Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054134C8BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiCAMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCAMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:39:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B63372983B;
        Tue,  1 Mar 2022 04:38:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F42DED1;
        Tue,  1 Mar 2022 04:38:22 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BD743F70D;
        Tue,  1 Mar 2022 04:38:20 -0800 (PST)
Message-ID: <54b24f3d-3762-abbd-5ac4-dc5728f2fe4e@arm.com>
Date:   Tue, 1 Mar 2022 12:38:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: avoid logspam when cd-broken
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220228223642.1136229-1-pgwipeout@gmail.com>
 <c12e74b7-0bef-ac7a-20c1-2a17ddd050dd@arm.com>
 <CAMdYzYq0A4FitRGe49fxvjbwLUCi_KGwCtfz7pmayt_dK=r32w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMdYzYq0A4FitRGe49fxvjbwLUCi_KGwCtfz7pmayt_dK=r32w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-01 11:49, Peter Geis wrote:
> On Tue, Mar 1, 2022 at 6:23 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-02-28 22:36, Peter Geis wrote:
>>> The dw_mmc-rockchip driver drops a large amound of logspam constantly
>>> when the cd-broken flag is enabled.
>>> Set the warning to be debug ratelimited in this case.
>>
>> Isn't this just papering over some fundamental problem with the clock?
>> If it's failing to set the expected rate for communicating with a card,
>> then presumably that's an issue for correct operation in general? The
>> fact that polling for a card makes a lot more of that communication
>> happen seems unrelated :/
> 
> Good Morning,
> 
> This only happens when a card is not inserted, so communication cannot happen.

Well, I suppose there's a philosophical question in there about whether 
shouting into the void counts as "communication", but AFAIR what the 
polling function does is power up the controller, send a command, and 
see if it gets a response.

If the clock can't be set to the proper rate for low-speed discovery, 
some or all cards may not be detected properly. Conversely if it is 
already at a slow enough rate for discovery but can't be set higher once 
a proper communication mode has been established, data transfer 
performance will be terrible. Either way, it is not OK in general for 
clk_set_rate() to fail, hence the warning. You have a clock driver problem.

Cheers,
Robin.

> I found it while lighting off the SoQuartz module.
> As it is pin compatible with the RPi CM4, and the CM4 does not have a
> card detect line, sdmmc is non functional without cd-broken.
> This led to the fun spew when there wasn't a card inserted as this
> function is called every poll tick.
> 
> Thanks,
> Peter
> 
>>
>> Robin.
>>
>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>> ---
>>>    drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>>> index 95d0ec0f5f3a..d0ebf0afa42a 100644
>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>> @@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>                cclkin = ios->clock * RK3288_CLKGEN_DIV;
>>>
>>>        ret = clk_set_rate(host->ciu_clk, cclkin);
>>> -     if (ret)
>>> -             dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
>>> +     if (ret) {
>>> +             /* this screams when card detection is broken */
>>> +             if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
>>> +                     dev_dbg_ratelimited(host->dev, "failed to set rate %uHz\n", ios->clock);
>>> +             else
>>> +                     dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
>>> +     }
>>>
>>>        bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>>>        if (bus_hz != host->bus_hz) {
