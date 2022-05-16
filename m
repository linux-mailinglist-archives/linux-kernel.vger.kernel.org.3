Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748E527FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbiEPIbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiEPIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:31:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FDDDE84;
        Mon, 16 May 2022 01:31:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6E5C21F427EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652689876;
        bh=ytW6OzemA443Fouu0UIECYThL8+4RWJXRFWc1m4MtCA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DrwGfIZryGFSE47jUYrBD9ViP0HynbmltEeFaTfaRjPvDy127ALe3/gLlx4a/wIBm
         cpYw0qGPUh+ofhh0mBWJ5H4ZzXZlc6BC5fYLTbjuGUDrbCCqRRmyf5DpkU2H7FTAt0
         3yTXp9b7+x2kaw0UwSpa4FazbLDEeAB4UGuRl0ZhTGJQqJZJ34D+mlB8Gcb54Dq2bO
         OD26aijV8SV43MYCA/nARuauX2z8LwzxNUkZA+iotU9mdoqhSHbVAtmatPJMuUBuV9
         e6tAROSSVU6Iesivz5qfYmqVSEWIWedgd9icIfmLbDDdirUd2TbOyZwkeotkq+RVUP
         MDIFscgK1UCHg==
Message-ID: <7d4caab4-bb70-8e32-dc06-5edd51dbeea5@collabora.com>
Date:   Mon, 16 May 2022 10:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220513201442.13569-1-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220513201442.13569-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/05/22 22:14, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <yassine.oudjana@gmail.com>
> 
> On Mon,  9 May 2022 23:07:40 +0200, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
>> Some MediaTek platforms with a buggy TrustZone ATF firmware will not
>> initialize the AArch64 System Timer correctly: in these cases, the
>> System Timer address is correctly programmed, as well as the CNTFRQ_EL0
>> register (reading 13MHz, as it should be), but the assigned hardware
>> timers are never started before (or after) booting Linux.
>>
>> In this condition, any call to function get_cycles() will be returning
>> zero, as CNTVCT_EL0 will always read zero.
> 
> I spent a lot of time trying to figure out why the arch timer didn't
> work on MT6737T and never got any results. Turns out this is why...
> 
> I ended up using the GPT (@ 0x10004000) as a system timer and it
> worked fine.
> 
> With this patch the arch timer started to work finally. Thanks for
> the fix! See below for one comment on this patch.
> 

Hello Yassine,

yes this is a common quirk that's present on all (or almost all?) older
MediaTek platforms - as I explained, due to TZ doing only partial init
for these timers.

I'm happy to read that this is working out as expected: I saw you pushing
some patches for older MTK SoCs, so I started researching about what the
community was blocked on with the upstreaming of these, and learnt about
such major blocker.

There's more, though: you also need to initialize the CPU MTCMOS at early
boot in order for SMP to work on (some?) old platforms, or at least this
is true for MT6795.

Since it looks like you're interested in giving love to old SoCs, I will
anticipate to you that I *do* have a local implementation for a correct
initialization of the MTCMOS for the non-boot cores... that needs to be
cleaned up a bit before I push that upstream though.

>> One common critical symptom of that is trying to use the udelay()
>> function (calling __delay()), which executes the following loop:
>>
>>              start = get_cycles();
>>              while ((get_cycles() - start) < cycles)
>>                      cpu_relax();
>>
>> which, when CNTVCT_EL0 always reads zero, translates to:
>>
>>              while((0 - 0) < 0)  ==> while(0 < 0)
>>
>> ... generating an infinite loop, even though zero is never less
>> than zero, but always equal to it (this has to be researched,
>> but it's out of the scope of this commit).
>>
>> To fix this issue on the affected MediaTek platforms, the solution
>> is to simply start the timers that are designed to be System Timer(s).
>> These timers, downstream, are called "CPUXGPT" and there is one
>> timer per CPU core; luckily, it is not necessary to set a start bit
>> on each CPUX General Purpose Timer, but it's conveniently enough to:
>>   - Set the clock divider (input = 26MHz, divider = 2, output = 13MHz);
>>   - Set the ENABLE bit on a global register (starts all CPUX timers).
>>
>> The only small hurdle with this setup is that it's all done through
>> the MCUSYS wrapper, where it is needed, for each read or write, to
>> select a register address (by writing it to an index register) and
>> then to perform any R/W on a "CON" register.
>>
>> For example, writing "0x1" to the CPUXGPT register offset 0x4:
>> - Write 0x4 to mcusys INDEX register
>> - Write 0x1 to mcusys CON register
>>
>> Reading from CPUXGPT register offset 0x4:
>> - Write 0x4 to mcusys INDEX register
>> - Read mcusys CON register.
>>
>> Finally, starting this timer makes platforms affected by this issue
>> to work correctly.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clocksource/timer-mediatek.c | 119 +++++++++++++++++++++++++++
>>   1 file changed, 119 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
>> index 7bcb4a3f26fb..a3e90047f9ac 100644
>> --- a/drivers/clocksource/timer-mediatek.c
>> +++ b/drivers/clocksource/timer-mediatek.c

..snip..

>> +
>> +	/*
>> +	 * Check if we're given a clock with the right frequency for this
>> +	 * timer, otherwise warn but keep going with the setup anyway, as
>> +	 * that makes it possible to still boot the kernel, even though
>> +	 * it may not work correctly (random lockups, etc).
>> +	 * The reason behind this is that having an early UART may not be
>> +	 * possible for everyone and this gives a chance to retrieve kmsg
>> +	 * for eventual debugging even on consumer devices.
>> +	 */
>> +	freq = timer_of_rate(&to_cpux);
>> +	if (freq > 13000000)
> 
> Input clock is 26MHz and is then divided by 2 in CPUXGPT, so shouldn't
> this be 26000000 instead? I get a warning here with 26MHz system clock
> supplied:
> 

This may seem to be counter intuitive... I had two ways to implement this:
1. Design this driver to take "clk26m" as a clock input and make it so
    that it reads the expected frequency from CNTFRQ_EL0, then setup the
    dividers based on that reading; or
2. Take "clk13m" as input and refuse to take anything else.

Keeping in mind that:
1. There's no way (that I know, at least) to set a different clock source for
    the CPUXGPT timers, and
2. There's no platform (I've been researching on that) that uses a different
    frequency for these timers...

...there will never be any platform that outputs a clock that's not 13MHz,
hence I chose to follow path 2 and take the 13MHz "System Clock", which is
something that is present downstream as well.

In any case, now that you make me think about that, it may indeed be more
logical to assign the 26MHz clock to this node... my intention was to force
knowledge on this outputting 13MHz instead but, I realize, this may be the
wrong way of doing that.

> clocks {
> 	...
> 	clk26m: clk26m {
> 		compatible = "fixed-clock";
> 		clock-frequency = <26000000>;
> 		#clock-cells = <0>;
> 	};
> 	...
> };
> ...
> soc {
> 	...
> 	cpuxgpt: timer@10200670 {
> 		compatible = "mediatek,mt6795-systimer";
> 		reg = <0 0x10200670 0 0x8>;

My congratulations on this timer node: you're a smart person!
I was expecting people complaining about "this doesn't work" and having
to explain that 0x10200000 is not the right iostart for this node, but
I didn't have to.

Hats off.

Cheers,
Angelo

