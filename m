Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E04CC107
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiCCPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiCCPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:20:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59ACD191420;
        Thu,  3 Mar 2022 07:19:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBE01424;
        Thu,  3 Mar 2022 07:19:24 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7674D3F66F;
        Thu,  3 Mar 2022 07:19:22 -0800 (PST)
Message-ID: <05ffc792-17cf-64f8-d3fd-4f7658aa6722@arm.com>
Date:   Thu, 3 Mar 2022 15:19:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock
 rates
Content-Language: en-GB
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220303015151.1711860-1-pgwipeout@gmail.com>
 <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
 <CAMdYzYrndAwWJELRRL4kP-BCdWuF6bLVwS2PUMVx_UcJZE=nsQ@mail.gmail.com>
 <CAPDyKFp8tZ-Ty0Wo2jkTjr6Jun83QczQfQRQ1zvFBBCOCWjtng@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAPDyKFp8tZ-Ty0Wo2jkTjr6Jun83QczQfQRQ1zvFBBCOCWjtng@mail.gmail.com>
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

On 2022-03-03 10:21, Ulf Hansson wrote:
> On Thu, 3 Mar 2022 at 10:49, Peter Geis <pgwipeout@gmail.com> wrote:
>>
>> On Thu, Mar 3, 2022 at 2:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> On Thu, 3 Mar 2022 at 02:52, Peter Geis <pgwipeout@gmail.com> wrote:
>>>>
>>>> The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
>>>> supports. This leads to a situation during card initialization where the
>>>> ciu clock is set lower than the clock driver can support. The
>>>> dw-mmc-rockchip driver spews errors when this happens.
>>>> For normal operation this only happens a few times during boot, but when
>>>> cd-broken is enabled (in cases such as the SoQuartz module) this fires
>>>> multiple times each poll cycle.
>>>>
>>>> Fix this by testing the minimum frequency the clock driver can support
>>>> that is within the mmc specification, then divide that by the internal
>>>> clock divider. Set the f_min frequency to this value, or if it fails,
>>>> set f_min to the downstream driver's default.
>>>>
>>>> Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
>>>>
>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>> ---
>>>>   drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
>>>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>>>> index 95d0ec0f5f3a..c198590cd74a 100644
>>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>>> @@ -15,7 +15,9 @@
>>>>   #include "dw_mmc.h"
>>>>   #include "dw_mmc-pltfm.h"
>>>>
>>>> -#define RK3288_CLKGEN_DIV       2
>>>> +#define RK3288_CLKGEN_DIV      2
>>>> +#define RK3288_MIN_INIT_FREQ   375000
>>>> +#define MMC_MAX_INIT_FREQ      400000
>>>>
>>>>   struct dw_mci_rockchip_priv_data {
>>>>          struct clk              *drv_clk;
>>>> @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
>>>>   static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>>   {
>>>>          struct dw_mci_rockchip_priv_data *priv = host->priv;
>>>> +       struct mmc_host *mmc = mmc_from_priv(host);
>>>>          int ret;
>>>>          unsigned int cclkin;
>>>>          u32 bus_hz;
>>>> @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>>          if (ios->clock == 0)
>>>>                  return;
>>>>
>>>> +       /* the clock will fail if below the f_min rate */
>>>> +       if (ios->clock < mmc->f_min)
>>>> +               ios->clock = mmc->f_min;
>>>> +
>>>
>>> You shouldn't need this. The mmc core should manage this already.
>>
>> I thought so too, but while setting f_min did reduce the number of
>> errors, it didn't stop them completely.
>> Each tick I was getting three failures, it turns out mmc core tries
>> anyways with 300000, 200000, and 100000.
>> Clamping it here was necessary to stop these.
> 
> Ohh, that was certainly a surprise to me. Unless the dw_mmc driver
> invokes this path on it's own in some odd way, that means the mmc core
> has a bug that we need to fix.
> 
> Would you mind taking a stack trace or debug this so we understand in
> what case the mmc core doesn't respect f_min? It really should.

I'm only armed with grep and a hunch, but is dw_mci_init_slot_caps() 
stomping on the same f_min that we've set in the platform init hook?

Robin.
