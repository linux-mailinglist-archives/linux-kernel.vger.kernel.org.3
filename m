Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8F48F175
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbiANUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbiANUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:33:04 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40461C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:32:57 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id l15so18921056uai.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFJ1wELIQslX+urYQwrPC6vCU6aXMYEbuF/tZImQjkE=;
        b=TRU8i+NzmsVahW7FJBWbVPsWGiEi2iqY54/JCikOzwdzGLYT38YJW96Jso5y8Db+E3
         b6iBXA7kJkt6a7h79Fj/AwklqADjhxpBXx3WR4UwzaxjhV3V4MFKlT3gx3UC2uJNXzy4
         1Z/6oSAwcxR98M6n6M/xQfGXJa91x8j434bl2SqdVlcqpG827E/61bM6HXeWROWWIOWK
         fv9NM1O9BxiSg9WB8GL9sN/jhyx1UsR3+vFJDYBXB7/Ng6eLKVY2nHVt5w6w9h0Lt79m
         Lpgj1zcRRNgJpyoWNutYB2cnPvHm5dqOVItRs3TTN0O513RD1RRPaGB9kVc5s0IK042+
         005w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFJ1wELIQslX+urYQwrPC6vCU6aXMYEbuF/tZImQjkE=;
        b=zs+j1jVLmnOCInKJIbnT6ejNjjV/AkVpBfl/Fp6VJ3Wf10BD0rG0fKFYVlkoEn5Arv
         CrxncDOLh/Dg8OOi9xPkuAmJmSE+7ZUsA3FTCYWoem1HtBEZe7/6JnwhaEtnox7XFS09
         n68riletUow4RCWwigM8bNDNX2DGctTq3rJLbiLwvbs9PWAR35A0b8LePPDPa/JckMQN
         9PMw0JQij2v08EeffAzzy6Tl6j/Q0D4+jYbdr+P9jmJNVRJsFDsR22N1S+LhQKSLg7fb
         aLjp726weS7CW9pKlLfk3tTly76h2cNEZomPcHjj7xlf1uwDODLezvvcFyY5RUuaG9Y+
         k8YA==
X-Gm-Message-State: AOAM5320kkiHsfxSAYJSO2TWdZlkDnX+/isLwNUxVPg1JLtZ4YPsXRXI
        eCA94ljqrM+E8ZmlHsYlnRYdapRdz/gpYqUxNWldew==
X-Google-Smtp-Source: ABdhPJwl1MLKvyI4uD1q7T1BcjeRrXEYqaJbm7bBPdJK93dZyvmIu8QEcVZ1YKVMyizrW6nBRVw0A8xgyLv7mxaN20c=
X-Received: by 2002:a05:6102:108c:: with SMTP id s12mr4848770vsr.20.1642192376294;
 Fri, 14 Jan 2022 12:32:56 -0800 (PST)
MIME-Version: 1.0
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
 <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com> <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com>
In-Reply-To: <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 22:32:44 +0200
Message-ID: <CAPLW+4=xD5hM_tYDD+kwqkiVq5h0tjO+7q6Akbd6iO_Ou-g=0A@mail.gmail.com>
Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 at 10:16, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 03/01/2022 21:59, Sam Protsenko wrote:
> > On Thu, 30 Dec 2021 at 21:34, Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> Hi Chanho and Sam,
> >>
> >> I am slowly finishing dtschema for Samsung pinctrl drivers [1] and I
> >> noticed that Exynos850 and Auto v9 do not define interrupt in pinctrl
> >> node with: wakeup-interrupt-controller. This is an interrupt muxing
> >> several external wakeup interrupts, e.g. EINT16 - EINT31.
> >>
> >> For Exynos5433 this looks like:
> >> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/exynos/exynos5433.dtsi#L857
> >>
> >> Missing muxed interrupt for Exynos850 and Autov9 might be fine, although
> >> you should see in dmesg error log like:
> >>     "irq number for muxed EINTs not found"
> >>
> >> Can you check that your wakeup-interrupt-controller is properly defined
> >> in DTSI? If yes, I will need to include such differences in the dtschema.
> >>
> >
> > In case of Exynos850, no muxed interrupts exist for wakeup GPIO
> > domains. Basically, "pinctrl_alive" and "pinctrl_cmgp" domains are
> > wake-up capable, and they have dedicated interrupt for each particular
> > GPIO pin. All those interrupts are defined in exynos850-pinctrl.dtsi
> > file, in next nodes:
> >   - pinctrl_alive: gpa0..gpa4 (interrupt numbers 1..36)
> >   - pinctrl_cmgp: gpm0..gpm7 (interrupt numbers 39..46)
> >
> > All mentioned interrupts are wakeup interrupts, and there are no muxed
> > ones. So it seems like it's not possible to specify "interrupts"
> > property in pinctrl nodes with wakeup-interrupt-controller. The PM is
> > not enabled in Exynos850 platform yet, so I can't really test if
> > interrupts I mentioned are able to wake up the system.
>
> Thanks for confirming, I'll adjust the schema.
>
> >
> > After adding this patch ("arm64: dts: exynos: Add missing gpm6 and
> > gpm7 nodes to Exynos850"), I can't see this error message anymore:
> >
> >     samsung-pinctrl 11c30000.pinctrl: irq number for muxed EINTs not found
> >
> > That's because exynos_eint_wkup_init() function exits in this check:
> >
> >     if (!muxed_banks) {
> >         of_node_put(wkup_np);
> >         return 0;
> >     }
> >
> > But I actually can see another error message, printed in
> > exynos_eint_gpio_init() function (for wake-up capable pinctrl nodes,
> > because those nodes don't have "interrupts" property now -- you
> > removed those in your patch):
> >
> >     samsung-pinctrl 11850000.pinctrl: irq number not available
> >     samsung-pinctrl 11c30000.pinctrl: irq number not available
> >
> > which in turn leads to exynos_eint_gpio_init() function to exit with
> > -EINVAL code in the very beginning, and I'm not sure if it's ok? As I
> > said, those errors only appear after your patch ("arm64: dts: exynos:
> > drop incorrectly placed wakeup interrupts in Exynos850").
>
> Yeah, I replied to this next to my patch. I think my patch was not
> correct and you need one - exactly one - interrupt for regular GPIO
> interrupts.
>

I just need to remove ".eint_gpio_init" in exynos850_pin_ctrl[] for
pinctrl_alive and pinctrl_gpmc. Those already have ".eint_wkup_init",
which is enough to handle all interrupts (per-pin). GPIO_ALIVE and
GPIO_GPMC lack EINT capabilities: judging from TRM, there are no EINT
interrupts (like EINT_SVC, which is accessed in EINT ISR), and there
are no EINT interrupts wired to GIC (like INTREQ__GPIO_ALIVE or
INTREQ__GPIO_GPMC). With removed ".eint_gpio_init", I can see in
"/proc/interrupts" that corresponding interrupts are still handled
properly (because of .eint_wkup_init), and the error message is gone.
Will send the patch soon -- please add it to the beginning of your
series along with my other patch I already submitted.

> >
> > It raises next questions, which I'm trying to think over right now.
> > Krzysztof, please let me know if you already have answers to those:
> >
> > 1. Regarding "wakeup-interrupt-controller" node (and
> > exynos_eint_wkup_init() function): is it ok to not have "interrupts"
> > property in there? Would corresponding interrupts specified in child
> > nodes (gpa0..gpa4) function as wake-up interrupts in this case? Or
> > pinctrl driver should be reworked somehow?
>
> Yes, it should be fine. The message should be changed from error to info
> or even debug, maybe depending on SoC-type (so define in struct
> samsung_pin_ctrl whether exynos_eint_wkup_init expects muxed wake-ip
> interrupts).
>
> >
> > 2. Regarding missing interrupts in pinctrl nodes (and corresponding
> > error in exynos_eint_gpio_init() function): should it be reworked in
> > some way for Exynos850? Error message seems invalid in Exynos850 case,
> > and I'm not even sure if it's ok exynos_eint_gpio_init() fails. Should
> > it be modified to work that error around, in case of Exynos850?
> >
> > All other pinctrl nodes have a muxed interrupt (except pinctrl_aud,
> > but that's probably fine).
>
> The error message is valid - correctly points to wrong configuration.
> All pinctrl nodes should have one interrupt, if they have GPIOs capable
> of interrupt as a function (usually 0xf as GPIO CON register). Why
> pinctrl_aud does not have it? Maybe the function EXT_INT (0xf) is not
> available for its pins?
>
> Best regards,
> Krzysztof
