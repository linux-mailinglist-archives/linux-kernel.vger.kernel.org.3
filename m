Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C694C8F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiCAQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiCAQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:03:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A27F349917;
        Tue,  1 Mar 2022 08:03:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66BB31042;
        Tue,  1 Mar 2022 08:03:06 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E0B3F70D;
        Tue,  1 Mar 2022 08:03:05 -0800 (PST)
Message-ID: <f9768ddd-26c4-9b23-8c48-9de4123a75e6@arm.com>
Date:   Tue, 1 Mar 2022 16:03:00 +0000
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
 <54b24f3d-3762-abbd-5ac4-dc5728f2fe4e@arm.com>
 <CAMdYzYp=Po08pap9w5s8PV0mKfFZSPSOhM1U1AUdrRkYV-FRZQ@mail.gmail.com>
 <CAMdYzYoF6eO3mBZD=PtOPL3atdA3kH4UzV++6wB0pirW-7h_9A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMdYzYoF6eO3mBZD=PtOPL3atdA3kH4UzV++6wB0pirW-7h_9A@mail.gmail.com>
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

On 2022-03-01 14:49, Peter Geis wrote:
> On Tue, Mar 1, 2022 at 7:46 AM Peter Geis <pgwipeout@gmail.com> wrote:
>>
>> On Tue, Mar 1, 2022 at 7:38 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2022-03-01 11:49, Peter Geis wrote:
>>>> On Tue, Mar 1, 2022 at 6:23 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>>
>>>>> On 2022-02-28 22:36, Peter Geis wrote:
>>>>>> The dw_mmc-rockchip driver drops a large amound of logspam constantly
>>>>>> when the cd-broken flag is enabled.
>>>>>> Set the warning to be debug ratelimited in this case.
>>>>>
>>>>> Isn't this just papering over some fundamental problem with the clock?
>>>>> If it's failing to set the expected rate for communicating with a card,
>>>>> then presumably that's an issue for correct operation in general? The
>>>>> fact that polling for a card makes a lot more of that communication
>>>>> happen seems unrelated :/
>>>>
>>>> Good Morning,
>>>>
>>>> This only happens when a card is not inserted, so communication cannot happen.
>>>
>>> Well, I suppose there's a philosophical question in there about whether
>>> shouting into the void counts as "communication", but AFAIR what the
>>> polling function does is power up the controller, send a command, and
>>> see if it gets a response.
>>>
>>> If the clock can't be set to the proper rate for low-speed discovery,
>>> some or all cards may not be detected properly. Conversely if it is
>>> already at a slow enough rate for discovery but can't be set higher once
>>> a proper communication mode has been established, data transfer
>>> performance will be terrible. Either way, it is not OK in general for
>>> clk_set_rate() to fail, hence the warning. You have a clock driver problem.
>>
>> Alright, I'll look into this.
>> It seems only extremely low clock speeds fail and I know rockchip
>> chips have a hard time with extremely low clock rates.
>> I'll trace out where the failure is happening.
> 
> Okay, I hope you can provide me a direction to go from here, because
> it looks like it's doing exactly what it should do in this situation.
> mmc core is requesting a rate (200k/100k).
> clk core tries to find a parent to provide a clock that low and fails,
> because the lowest possible parent is 750k.
> clk_sdmmc(x) is listed as no-div, so it can't go any lower.
> 
> It seems to me that this error is sane, because other results of
> einval you want to catch.
> But einval in this case is fine, because
> The thing that strikes me weird is currently clk_core thinks the
> lowest possible freq here is 0, when in actuality it should be 750k,
> am I correct here?
> The mmc controller has an internal divider, so if my line of thinking
> is correct here we should be more flexible here and request a rate
> that's acceptable rather than just failing if it doesn't work.
> But that's based on my limited understanding of how mmc core is
> requesting this and what it expects in return.

The downstream solution appears to be just to clamp the rate for 
detection[1][2]. Not sure whether it's feasible to try to be cleverer 
with the local divider to settle on a more in-spec rate for the final 
output :/

Robin.

[1] 
https://github.com/JeffyCN/mirrors/commit/d80d5062b22f9c4a559401bdb7b2727c4ced36c0
[2] 
https://github.com/JeffyCN/mirrors/commit/3f26edfb2392df25efc361ad0a9f41d0917e40ee
