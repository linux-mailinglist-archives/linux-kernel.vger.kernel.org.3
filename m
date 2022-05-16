Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F452870D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbiEPObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiEPOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:30:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F9F0B;
        Mon, 16 May 2022 07:30:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k30so8097675wrd.5;
        Mon, 16 May 2022 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=SkI9j+PV+1mmvxHb7GKlSLP3Y+qTblf8gX9dnYFmiFM=;
        b=APIp0gdbezfYXpzOnG3h2kFGrduy6yci+HMh3Q2Y1I46Bj2dPmiihp0n1JKneFnPTP
         yacOwcuxlO6u/kS0o+Ek48MJz+iALhTfSyUeuNZMTkYEBxtcSAJ7ocxy000Xwr1Sb6Cf
         uZOW7yh3chlhbbGPLX59DzHzC0YLVH3gSyHrhcpGXWzuDd44pQaA8+96GZ2HyUBCn/ou
         eoLTsl02PuZwGxjjs++Jyy2g3Vj6FpBewWEB1BOnpzOLc0tTCALmRLgcH6x/QFBkGfAX
         /eYV5U48mLoH41rqys27cZKnRCUExHqkn/AcZ8e4tqLL0YHdxR5VdTNEesL51Xh54fj7
         oRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=SkI9j+PV+1mmvxHb7GKlSLP3Y+qTblf8gX9dnYFmiFM=;
        b=WoHa2C42O2CbEn9o5piRpiJCSfU97CSN9JTR4SXmxyUSgCUgE87SkkhZSjK/SKrcWW
         u2/Ku/7eijOS5F/PJpeXf3OSajN9aikoqovlrnxCNesA5TM1r+2mWJnSo5htq6VfNmUo
         5uslmom+Qay+4wrEw6n+sEEcW1qDDZIyI3P/4BwGzKNE0JcyCN0OfLHlL9FsGq7V4ZGY
         v/enxMt1tt7cXWyjwBrAIrx2VDHFGXLpgxbX7SoVEGO6DW/0Gz3s8Ql8Hy8pqUAKTWX3
         85ZKlXs6obYhmpWLFdP6CaxZlQjsJLfoRCH9qhTCa9F/tdk0IysGV0W/G/EGJz4LQ7TN
         HxeA==
X-Gm-Message-State: AOAM532C51szdlO9XNZkZVAlc6P6iidx4Vpbl2rbqU7s/QftIceP1+nn
        Oo2eBjmtdX3UI77a5vWpqnI=
X-Google-Smtp-Source: ABdhPJxgO5KhCZCHlnN5ffu2hoLwZBCjWnLCX08taD9hP3OlxbZq2lHIPrqpxxC1BD8HOp8ozvF6RA==
X-Received: by 2002:adf:e80b:0:b0:20d:7e1:5c81 with SMTP id o11-20020adfe80b000000b0020d07e15c81mr5053529wrm.147.1652711449169;
        Mon, 16 May 2022 07:30:49 -0700 (PDT)
Received: from [192.168.82.247] ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d5984000000b0020c77f36b13sm9985206wri.100.2022.05.16.07.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 07:30:48 -0700 (PDT)
Date:   Mon, 16 May 2022 18:30:33 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
Message-Id: <XACZBR.6DH6TON0H9IO@gmail.com>
In-Reply-To: <7d4caab4-bb70-8e32-dc06-5edd51dbeea5@collabora.com>
References: <20220513201442.13569-1-y.oudjana@protonmail.com>
        <7d4caab4-bb70-8e32-dc06-5edd51dbeea5@collabora.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, May 16 2022 at 10:31:12 +0200, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 13/05/22 22:14, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <yassine.oudjana@gmail.com>
>> 
>> On Mon,  9 May 2022 23:07:40 +0200, AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com> wrote:
>>> Some MediaTek platforms with a buggy TrustZone ATF firmware will not
>>> initialize the AArch64 System Timer correctly: in these cases, the
>>> System Timer address is correctly programmed, as well as the 
>>> CNTFRQ_EL0
>>> register (reading 13MHz, as it should be), but the assigned hardware
>>> timers are never started before (or after) booting Linux.
>>> 
>>> In this condition, any call to function get_cycles() will be 
>>> returning
>>> zero, as CNTVCT_EL0 will always read zero.
>> 
>> I spent a lot of time trying to figure out why the arch timer didn't
>> work on MT6737T and never got any results. Turns out this is why...
>> 
>> I ended up using the GPT (@ 0x10004000) as a system timer and it
>> worked fine.
>> 
>> With this patch the arch timer started to work finally. Thanks for
>> the fix! See below for one comment on this patch.
>> 
> 
> Hello Yassine,
> 
> yes this is a common quirk that's present on all (or almost all?) 
> older
> MediaTek platforms - as I explained, due to TZ doing only partial init
> for these timers.
> 
> I'm happy to read that this is working out as expected: I saw you 
> pushing
> some patches for older MTK SoCs, so I started researching about what 
> the
> community was blocked on with the upstreaming of these, and learnt 
> about
> such major blocker.
> 
> There's more, though: you also need to initialize the CPU MTCMOS at 
> early
> boot in order for SMP to work on (some?) old platforms, or at least 
> this
> is true for MT6795.

Oh I'm actually having trouble with SMP. I tried to do a bunch of
things downstream does but the CPUs just kept refusing to come up.
This might be the reason.

> Since it looks like you're interested in giving love to old SoCs, I 
> will
> anticipate to you that I *do* have a local implementation for a 
> correct
> initialization of the MTCMOS for the non-boot cores... that needs to 
> be
> cleaned up a bit before I push that upstream though.

Any chance I can give it an early test? Having only one working
CPU kind of sucks...

> 
>>> One common critical symptom of that is trying to use the udelay()
>>> function (calling __delay()), which executes the following loop:
>>> 
>>>              start = get_cycles();
>>>              while ((get_cycles() - start) < cycles)
>>>                      cpu_relax();
>>> 
>>> which, when CNTVCT_EL0 always reads zero, translates to:
>>> 
>>>              while((0 - 0) < 0)  ==> while(0 < 0)
>>> 
>>> ... generating an infinite loop, even though zero is never less
>>> than zero, but always equal to it (this has to be researched,
>>> but it's out of the scope of this commit).
>>> 
>>> To fix this issue on the affected MediaTek platforms, the solution
>>> is to simply start the timers that are designed to be System 
>>> Timer(s).
>>> These timers, downstream, are called "CPUXGPT" and there is one
>>> timer per CPU core; luckily, it is not necessary to set a start bit
>>> on each CPUX General Purpose Timer, but it's conveniently enough to:
>>>   - Set the clock divider (input = 26MHz, divider = 2, output = 
>>> 13MHz);
>>>   - Set the ENABLE bit on a global register (starts all CPUX 
>>> timers).
>>> 
>>> The only small hurdle with this setup is that it's all done through
>>> the MCUSYS wrapper, where it is needed, for each read or write, to
>>> select a register address (by writing it to an index register) and
>>> then to perform any R/W on a "CON" register.
>>> 
>>> For example, writing "0x1" to the CPUXGPT register offset 0x4:
>>> - Write 0x4 to mcusys INDEX register
>>> - Write 0x1 to mcusys CON register
>>> 
>>> Reading from CPUXGPT register offset 0x4:
>>> - Write 0x4 to mcusys INDEX register
>>> - Read mcusys CON register.
>>> 
>>> Finally, starting this timer makes platforms affected by this issue
>>> to work correctly.
>>> 
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/clocksource/timer-mediatek.c | 119 
>>> +++++++++++++++++++++++++++
>>>   1 file changed, 119 insertions(+)
>>> 
>>> diff --git a/drivers/clocksource/timer-mediatek.c 
>>> b/drivers/clocksource/timer-mediatek.c
>>> index 7bcb4a3f26fb..a3e90047f9ac 100644
>>> --- a/drivers/clocksource/timer-mediatek.c
>>> +++ b/drivers/clocksource/timer-mediatek.c
> 
> ..snip..
> 
>>> +
>>> +	/*
>>> +	 * Check if we're given a clock with the right frequency for this
>>> +	 * timer, otherwise warn but keep going with the setup anyway, as
>>> +	 * that makes it possible to still boot the kernel, even though
>>> +	 * it may not work correctly (random lockups, etc).
>>> +	 * The reason behind this is that having an early UART may not be
>>> +	 * possible for everyone and this gives a chance to retrieve kmsg
>>> +	 * for eventual debugging even on consumer devices.
>>> +	 */
>>> +	freq = timer_of_rate(&to_cpux);
>>> +	if (freq > 13000000)
>> 
>> Input clock is 26MHz and is then divided by 2 in CPUXGPT, so 
>> shouldn't
>> this be 26000000 instead? I get a warning here with 26MHz system 
>> clock
>> supplied:
>> 
> 
> This may seem to be counter intuitive... I had two ways to implement 
> this:
> 1. Design this driver to take "clk26m" as a clock input and make it so
>    that it reads the expected frequency from CNTFRQ_EL0, then setup 
> the
>    dividers based on that reading; or
> 2. Take "clk13m" as input and refuse to take anything else.
> 
> Keeping in mind that:
> 1. There's no way (that I know, at least) to set a different clock 
> source for
>    the CPUXGPT timers, and
> 2. There's no platform (I've been researching on that) that uses a 
> different
>    frequency for these timers...
> 
> ...there will never be any platform that outputs a clock that's not 
> 13MHz,
> hence I chose to follow path 2 and take the 13MHz "System Clock", 
> which is
> something that is present downstream as well.
> 
> In any case, now that you make me think about that, it may indeed be 
> more
> logical to assign the 26MHz clock to this node... my intention was to 
> force
> knowledge on this outputting 13MHz instead but, I realize, this may 
> be the
> wrong way of doing that.

Maybe it is a better idea to use clock-frequency = <13000000> to
show the timer frequency?

> 
>> clocks {
>> 	...
>> 	clk26m: clk26m {
>> 		compatible = "fixed-clock";
>> 		clock-frequency = <26000000>;
>> 		#clock-cells = <0>;
>> 	};
>> 	...
>> };
>> ...
>> soc {
>> 	...
>> 	cpuxgpt: timer@10200670 {
>> 		compatible = "mediatek,mt6795-systimer";
>> 		reg = <0 0x10200670 0 0x8>;
> 
> My congratulations on this timer node: you're a smart person!
> I was expecting people complaining about "this doesn't work" and 
> having
> to explain that 0x10200000 is not the right iostart for this node, but
> I didn't have to.
> 
> Hats off.

Thanks :)

I actually figured that out because I had topckgen incorrectly
placed at 0x10200000 in my device tree, which made me check
the datasheet, downstream dts and the timer driver to realize
that the correct address for tockgen is 0x10210000, 0x10200000
is mcusys and the timer driver has the XGPT registers defined
starting from 0, meaning I had to add their offset in dts.

Regards,
Yassine


