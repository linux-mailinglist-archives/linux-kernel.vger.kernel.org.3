Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D04D61CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiCKMxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348665AbiCKMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:52:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F561B65F7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:51:55 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 60B613F1E5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647003108;
        bh=sIH/nw87aweAmAQLqAzIP/TZcavVp/TlhUgamFHUSgY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=esdae9CkvtjpLJY/QugCFXzBCaDFKb227QrXDOss/IrqBGDtAR+cbQe36c3uVBULK
         HXxoMJOf+kq1AxcD3uH/pOClQwdfw/HnvN5Bg6/xbJ21E2EJJ8ojQfxTBaBxoGZzWR
         CRn7FnDpv3x3Pk2sILMyeEzsb3gorbjb6zI1zyWOz6Gc+ykUgf27PwveeQ3bMmWT5y
         YP4lMrWfyE+MTMBr4w19LLWUqmg8aZBeiCx3wobKf90r8R9foNU2IZ8mZla8wLvfaa
         F+43fMSAzvVjdAVtC4UUGjbMRBg8k8X/wZl8U78ZKkfeSifb1/F8Ac6FGttKkeaU54
         lE8E7Bm3mYogg==
Received: by mail-ed1-f69.google.com with SMTP id u28-20020a50d51c000000b004159ffb8f24so4819092edi.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sIH/nw87aweAmAQLqAzIP/TZcavVp/TlhUgamFHUSgY=;
        b=nsmzJ5HmuLwzUXkWS0fFNXDaZbCeLrGAJ4SG6emA3d6DLoveEHxZTGzjsQklQVaEyB
         kze2XmyQ0VcPyF/R7Irq8zdbFlOKqBEzfuxWJavTIIftjoQbaJxFDdHUV87ZtIZuv/do
         5M3/kLpwZGUlS7y2JouhXIlh3kefFOyUoNYqTjtf/KZi4YDFFesJ5swYuFr9Nbr3RgzN
         zT9G3c5dPzIZJPBB/6K77C1DOa46bfRQbO0vqxr1fLhL7y/cDhUEThHf5CMraiI726JK
         rshVIRQ3tq7OTh0yKZbViA8xVtJ6mp7kDmZxflB4kdcINlrNLNBMtT0TAetmJ8KROHDM
         0e7w==
X-Gm-Message-State: AOAM532q1zI3aOrlngPS2SquJ63I7ph5kcHPy1tevsEd3PvdXkrag6tZ
        s8SLxUI8lCjkAl8SEdvxComLrP6fK1pnhxmiSkC2EjeV7aduMWOLITGuz4OQcOtFbgfvU3RJmPc
        XIvMtFhm00SYXkEZZ3ZWzceKlxzxjkQa/evrArEhgrg==
X-Received: by 2002:a05:6402:5192:b0:415:c6e6:23b with SMTP id q18-20020a056402519200b00415c6e6023bmr8844081edd.336.1647003108023;
        Fri, 11 Mar 2022 04:51:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbU5SYJkuKpQTbRCfYqLBZibZifI+8r07PwQMlyxzomP76itjmbDnqogO/XmojoU85iAG/Fg==
X-Received: by 2002:a05:6402:5192:b0:415:c6e6:23b with SMTP id q18-20020a056402519200b00415c6e6023bmr8844055edd.336.1647003107774;
        Fri, 11 Mar 2022 04:51:47 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b006da824011eesm2924624ejb.166.2022.03.11.04.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 04:51:46 -0800 (PST)
Message-ID: <69be9f88-b69b-c149-4387-c5002219bf0a@canonical.com>
Date:   Fri, 11 Mar 2022 13:51:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support
 local-timer-index property
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-4-vincent.whitchurch@axis.com>
 <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
 <20220311113543.GA17877@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311113543.GA17877@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 12:35, Vincent Whitchurch wrote:
> On Tue, Mar 08, 2022 at 03:57:55PM +0100, Krzysztof Kozlowski wrote:
>> On 08/03/2022 15:24, Vincent Whitchurch wrote:
>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>> index f29c812b70c9..5f8b516614eb 100644
>>> --- a/drivers/clocksource/exynos_mct.c
>>> +++ b/drivers/clocksource/exynos_mct.c
>>> @@ -33,7 +33,7 @@
>>>  #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
>>>  #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
>>>  #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
>>> -#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
>>> +#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
>>>  #define EXYNOS4_MCT_L_MASK		(0xffffff00)
>>>  
>>>  #define MCT_L_TCNTB_OFFSET		(0x00)
>>> @@ -75,6 +75,7 @@ enum {
>>>  static void __iomem *reg_base;
>>>  static unsigned long clk_rate;
>>>  static unsigned int mct_int_type;
>>> +static unsigned int mct_local_idx;
>>
>> No more static variables. This was wrong design, happens, but let's not
>> grow the list.
>>
>> I propose to conditionally (depending on property samsung,frc-shared)
>> assign .resume callback to NULL or exynos4_frc_resume. The init can
>> receive an argument whether to call frc_start().
> 
> Could we just add the skip-write-register-if-already-started change in
> exynos4_mct_frc_start() uncondtionally?  Perhaps it could be in a
> separate patch too?  I was probably being over-cautious when I did it
> conditionally on mct_local_idx.  Doing it uncondtionally would make it
> easier to remove the global variable.
> 
> On my system the FRC is actually started long before Linux, and I assume
> it's similar on other chips.

+Cc Marek,

Maybe we could skip it, I don't know. It could be enabled by early boot
code or by trusted firmware. This would require more testing, on few
different platforms.

On my Exynos5422 HC1 board the MCT is not running upon boot. The
EXYNOS4_MCT_G_TCON starts with a reset value (0x0).

> 
>>
>>>  static int mct_irqs[MCT_NR_IRQS];
>>>  
>>>  struct mct_clock_event_device {
>>> @@ -157,6 +158,17 @@ static void exynos4_mct_frc_start(void)
>>>  	u32 reg;
>>>  
>>>  	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
>>> +
>>> +	/*
>>> +	 * If the FRC is already running, we don't need to start it again.  We
>>> +	 * could probably just do this on all systems, but, to avoid any risk
>>> +	 * for regressions, we only do it on systems where it's absolutely
>>> +	 * necessary (i.e., on systems where writes to the global registers
>>> +	 * need to be avoided).
>>> +	 */
>>> +	if (mct_local_idx && (reg & MCT_G_TCON_START))
>>
>> This contradicts your intentions in commit #2 msg, where you described
>> that A53 will be started first.
> 
> Yes, you're right.  The case of the FRC not being running when the A5
> starts up is only ever hit in our simulation environment where we are
> able to start Linux on the A5 directly, without having to go via the
> A53.
> 
>> 1. If A53 is always started first, is it possible to be here from A5?
>> 2. If above is possible, how do you handle locking? For example:
>> a. A53 started with some delay, entered exynos4_mct_frc_start() pass
>> this check;
>> b. A5 gets to exynos4_mct_frc_start(), check is still false, so A5
>> enables the FRC,
>> c. A53 also enables the FRC.
> 
> The A5 is normally started from Linux on the A53 (using the remoteproc
> framework).  This is long after exynos4_mct_frc_start() has been called
> on the A53.

If it is 100% like this, let's make it explicit - if it is A53 (lack of
dedicated property), let's start it. If it A5 (property present), skip it.

Let's wait for Marek thoughts, he was digging the MCT a lot.


Best regards,
Krzysztof
