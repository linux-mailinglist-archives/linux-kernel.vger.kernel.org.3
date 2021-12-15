Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7936E47643B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhLOVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhLOVGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:06:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C1C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:06:45 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c32so45650128lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZMSpU7IbTeXJY/jQr9oSyOV6yh+md9eA0+Y7Tlp3q0=;
        b=rKDQ14w/RkIY1yRGhe48b2xT3UzLnOIhTsZb/Wuy8xHd4xI1e8GWlgOtY0JGQVaBab
         zOpYmXBE/2ly+QshgJ0hQzY3WyE4p1EnDQnNo9FrBI6cvZoD+jj9nvz9jNK+yydjc2yK
         9LX+N62pBtQjQC4BhYriFwq7H29DouklddQT18jjeh0q8kaWoZznFw8jjFSHX3JdYPCr
         GKprnYukWQ3WbTScjaeJ0RvQXZ1BVYr44FFTz7yKhyUE+ZOseyPshp8k01B3H44MNwK+
         tMBnPSpZa14AFn/2K9eD4k5iXK6pJ+vcBpoNGMZaV00QqEhdiaRZDXsLkYNb5BcKNDSk
         oJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZMSpU7IbTeXJY/jQr9oSyOV6yh+md9eA0+Y7Tlp3q0=;
        b=nnth86t/tgr3wL0v5DKKyzHsKbZbzSfWsnEHVJl9gYyGfIDeVQIIKRTz5K46oBZm3x
         NG7y4u1isY714WUv2HvZ4+X3p/DHMQPx9+sFPQWA6dvqOEts8NJEjUnLg7stENbD189Z
         9YWhHlhAbPeAT240Mc/9v0wTQlWYx4p/J+7VFTtX4fGMXI+MT57OovUCCQ64C3IkzkuS
         LepG3xqmNoPWFKytzYz9JxrgluqBdDzOS5QZ0yAC0wCTJErdvlgkM59ML04s63PCBM4o
         5EuYtINLdXZbpgo2negLv45pOmPYoL/kc+LBi5yyy762k1kpPSsPICV9djgzZNHitM2B
         FfuA==
X-Gm-Message-State: AOAM533HZASsOsSBFyBn2+SQcgRD8cylGC9hNPlasLbCRzEdA2jwxs+N
        1JvxIp4ExAbpGM/9F5f4vmWCGJdwioojFv43vEjFVQ==
X-Google-Smtp-Source: ABdhPJymI2AXDwmQ1n2btFeF7jMKeLuX9xrXSUthwnAtSOBcFspSfQ3Qh4uvF9acBGoXl+KW+HoodRvSRwW45nluMs0=
X-Received: by 2002:ac2:490b:: with SMTP id n11mr11785740lfi.36.1639602403417;
 Wed, 15 Dec 2021 13:06:43 -0800 (PST)
MIME-Version: 1.0
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx> <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
In-Reply-To: <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Dec 2021 13:06:30 -0800
Message-ID: <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
To:     Joel Daniels <jdaniels@sent.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 9:43 AM Joel Daniels <jdaniels@sent.com> wrote:
> On Tue, Dec 14, 2021, at 6:57 AM, Thomas Gleixner wrote:
> > thanks for making sure that this is really a RTC issue on that machine.
>
> And thank you for taking an interest. I've measured the RTC drift over
> a number of days and it is stable at around 3.8 seconds per day (or 44
> ppm).
>
> >> The "if" branch does not apply as I have no clock sources flagged as
> >> CLOCK_SOURCE_SUSPEND_NONSTOP but the "else if" branch does apply.
> >
> > Which CPU is in that box?
>
> Intel Celeron N4120. This is a Gemini Lake Refresh (Atom) chip.
>
> The relevant bit from the early_init_intel function
> (linux/arch/x86/kernel/cpu/intel.c) is:
>
>     /* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
>     if (c->x86 == 6) {
>             switch (c->x86_model) {
>             case INTEL_FAM6_ATOM_SALTWELL_MID:
>             case INTEL_FAM6_ATOM_SALTWELL_TABLET:
>             case INTEL_FAM6_ATOM_SILVERMONT_MID:
>             case INTEL_FAM6_ATOM_AIRMONT_NP:
>                     set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
>                     break;
>             default:
>                     break;
>             }
>     }
>
> > The kernel does not believe. It relies on the accuracy of the CMOS clock
> > which is usually pretty good.
>
> The references I have found on CMOS clock accuracy [1, 2, 3, 4]
> indicate that a drift of 1 or 2 seconds per day (10 to 20 ppm) is
> typical. Hopefully people on linux-rtc can confirm?
>
> If that is correct then my clock, at +44ppm, is an outlier but I
> suspect that people with a consistent drift of only 1 second per day
> would still benefit from being able to correct for it. Indeed, people
> have been using hwclock and /etc/adjtime to correct for CMOS RTC
> drift for decades.
>
> > > I would like to provide a way for user space to inform the kernel
> > > that the persistent clock drifts so it can make a corresponding
> > > adjustment when resuming from a long suspend period.
> > >
> > > ...
> >
> > That needs some thought. The RTC people (cc'ed now) might have opinions
> > on that.
>
> I agree that this needs thought. Three issues that I am particularly
> worried about:

I'm not really active in this space much anymore, but a few of my
(possibly wrongheaded) thoughts:

>    [A] On machines with a persistent clock how is userspace supposed
>        to be sure what drift to measure? Can it assume that the drift
>        of the persistent clock used for sleep time injection is the
>        same as the drift of /dev/rtc? This seems dangerous.

Yea, there can be multiple RTCs as well.

>    [B] Sleep time injection can come from the "persistent clock" or,
>        if there is no persistent clock, from an RTC driver. I'd like
>        to correct for drift from the perisistant clock but not touch
>        the RTC driver sleep time injection mechanism. Is this
>        acceptable or do people feel that any drift correction should
>        work with both mechanisms in order to ensure a polished
>        interface?

This dual interface comes from the desire to support both the more
atomic/earlier correction we can do w/ the persistent_clock interface
while holding the timekeeping lock, while also supporting RTC devices
that may sleep when being read, or may have dependencies that aren't
ready that early in resume.

Admittedly having two separate abstractions here is a bit of a pain,
and fixing just one side doesn't make it better.

>    [C] Some users may want to correct for drift during suspend-to-RAM
>        but during suspend-to-disk they might boot into some other
>        operating system which itself sets the CMOS RTC. Hopefully,
>        this could be solved from userspace by changing the drift
>        correction parameter to 0 just before a suspend-to-disk
>        operation.

Oof. This feels particularly complex and fragile to try to address.

> I suspect that there are other things about which I should also be
> worried if only I were less ignorant. That is why I am asking here.

Personally, I'm not sure this warrants adding new userland interfaces
for. I'd probably lean towards having the RTC framework internally
measure and correct for drift, rather than adding an extra knob in
userland.

Alternatively I'd go very simple and just put the correction factor in
a boot argument.

thanks
-john
