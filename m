Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE849C2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiAZFJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiAZFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:09:22 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C3CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 21:09:22 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id 2so41438377uax.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 21:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULKsotdNfK1GjpHBxFknCGil4tyRTc4FFZp3NSZMfY4=;
        b=gKSi9Hy9kAAL5wjEcluH7Yx+kNchSkZPMLuaeMy/4t2XH9N134RVVts06zGW931tcB
         soZ4fyM1aEw2sQBllwALdmxNmmKvAEYWaToNW0DMNewAnqIIVF+GEUzBad/ygXDIahau
         knjy9IVd/Naz6ObSqOqeYZ+FIf6MEBBsxhNIfvq+lD6CaFCb0lf1vcmnrWoH4lJQbPOT
         rIlrYAFn3l4v9tpKnUjl4WE1WVP796LrnMTNlQQvN2/rXpKJmJCy059X4XU8jS1zcvuF
         D3sb0bIdHmG3DhEsbZ+zZhNg2x3JvX97CcOVV/BJlcIE6i4Brq4Ky/TkOqHj4L/s54ZM
         lvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULKsotdNfK1GjpHBxFknCGil4tyRTc4FFZp3NSZMfY4=;
        b=ZsGNxB9R3Q4YtT3nhZswaQxeUp2KaUf18e8ebTB10I++3+X/TiRHPXKhMhSzhHOFqN
         h+Zzv6NTrU/ZrA/doE+Kzqql+90RFtwH5hZwS9/Jv1ciMVgyjrGeRxX+kIvGPfYA1Z0H
         mcz0jHoQZ24Bj3y9/V+nnz4hiF8CXN/ZO6gltmx1yiact3v2QAWii6cWDVC4AB2CtCSg
         qZmRDFZB+JcGT5sE2CWBSaNjhRJzoZp7GWp5chYBtUMXTYIp1qFf33yUdNjSWqiLDeJw
         gJE6YKdkX42/DIBXEbHKZJps78dJbSqcpWdlebOK6NvVNUAmA5zvFJ0jpRgL59R56pO8
         TaKA==
X-Gm-Message-State: AOAM533DtCIkiA3CMsX40f3If718GnR2uE0cbBVym9cRBdIFNTry00Si
        hEKT8j8cla6v9JHfZ4mGAW43Q/DsQFsPNvfpO7u+iQ==
X-Google-Smtp-Source: ABdhPJw1gobt5SN7rdO/s4DihA1/CYLLRCN3+2lp46elXkejaEYfynLRV2i1rbhWRRjnkS+z0Tu1X30lZMpECsapQf4=
X-Received: by 2002:ab0:6946:: with SMTP id c6mr8972476uas.44.1643173761576;
 Tue, 25 Jan 2022 21:09:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
 <CANcMJZA16b5gT++73a8hjA=6OeLsPLQM-X+ps3kEsYHVyariGg@mail.gmail.com>
In-Reply-To: <CANcMJZA16b5gT++73a8hjA=6OeLsPLQM-X+ps3kEsYHVyariGg@mail.gmail.com>
From:   Zichar Zhang <zichar.zhang@linaro.org>
Date:   Wed, 26 Jan 2022 13:09:21 +0800
Message-ID: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     John Stultz <john.stultz@linaro.org>
Cc:     Kelly Rossmoyer <krossmo@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello John,  Kelly!

I'm working on upstream "wakeup_reason" patch.
But I found It's a little bit hard to do that, cause it is too heavy.

The android patch put "wakeup_reason",  suspend/resume process and
interrupt subsystem together make it hard to upstream all these at once. I
think maybe we can cooperate with each other, and do it step by step.
And I make a simplified "wakeup_reason" patch as the start.

It just report the  normal IRQs which cause system wake up from suspend
and non-device "wakeups" which use kernel interface "wakeup source". It
can cover most of the situations.

Here I placed the patch, so that people can review it:
https://android-review.googlesource.com/c/kernel/common/+/1958188

Here is the differences from the requirement:

>> As of today, the active set of patches surface the following
>> suspend-related data:
>>
>> * wakeup IRQs, including:
>>    * multiple IRQs if more than one is pending during resume flow
>>    * unmapped HW IRQs (wakeup-capable in HW) that should not be
>>      occurring
>>    * misconfigured IRQs (e.g. both enable_irq_wake() and
>>      IRQF_NO_SUSPEND)
>>    * threaded IRQs (not just the parent chip's IRQ)

    -- If we do these things, the additional codes should be added in
    interrupt subsystem or some interrupt controller drivers. These
    codes are no relationship with the interrupt subsystem or the
    interrupt controllers. And we can't distinguish these IRQs from
    "non-suspend" environment, even the "Android patch" can't do that.
    So it will make the things complicated.
    -- If these IRQs do hanpen, the code in this commit will catch
    them as "unknown wakeup reason" and suggest user to check the
    kernel log for more information.
    -- I think We should cooperate with interrupt subsystem to log
    these "abnormal" IRQs. And it could be several additional
    commits to accomplish this work together then.

>> * abort reasons, including:
>>    * wakeup_source activity
>>    * failure to freeze userspace
>>    * failure to suspend devices
>>    * failed syscore_suspend callback

    -- These codes are "intrusive" to kernel (suspend/resume).
    -- These "errors" are already printed in kernel log, if we add
    these log to "wakeup_reason" either, it will cause double
    "log string" in section ".data", which just waste of the memory.
    -- As mentioned before, if these "abort action" happened, you
    can catch string "unknown wakeup reason", and check the kernel
    log then.

>> * durations from the most recent cycle, including:
>>    * time spent doing suspend/resume work
>>    * time spent in suspend

    -- Just separate these from "wakeup reason".
    It should be done in another commit.

The patch is not complete, these is the next steps:
1. add interface to show time spend in suspend/resume work.
(after this, I think it could be works and replace the android patch)
2. we need solve the "unmapped HW IRQs", "misconfigured IRQs" and
"threaded IRQs" problem.
(this is the hardest one)
3. add a string report interface for the "wakeup reason" not belongs to
any thing above.
(kernel actually didn't know the hardware wake up reason. The IRQs just
one of the reason for wake up. So it just report a "wakeup reason" from
interrupt subsystem. It just a coincidence that most hardware "wakeup
reason" is also the interupt signal.  Even the "interrupt" and "wake up"
signal are separated from each other in GIC700.
So give them a chance to report the their "wakeup reason".)

This patch can be tested in Android using the following change to AOSP:
 https://android-review.googlesource.com/c/platform/system/hardware/interfaces/+/1958666

And there is a stress test code for the interfaces in kernel:
 https://android-review.googlesource.com/c/kernel/common/+/1958189

Best
zichar


On Tue, 25 Jan 2022 at 01:38, John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Jan 11, 2022 at 5:06 AM Kelly Rossmoyer <krossmo@google.com> wrote:
> >
> > # Introduction
> >
> > To aid optimization, troubleshooting, and attribution of battery life, the
> > Android kernel currently includes a set of patches which provide enhanced
> > visibility into kernel suspend/resume/abort behaviors.  The capabilities
> > and implementation of this feature have evolved significantly since an
> > unsuccessful attempt to upstream the original code
> > (https://lkml.org/lkml/2014/3/10/716), and we would like to (re)start a
> > conversation about upstreaming, starting with the central question: is
> > there support for upstreaming this set of features?
> >
> > # Motivation
> >
> > Of the many factors influencing battery life on Linux-powered mobile
> > devices, kernel suspend tends to be amongst the most impactful.  Maximizing
> > time spent in suspend and minimizing the frequency of net-negative suspend
> > cycles are both important contributors to battery life optimization.  But
> > enabling that optimization - and troubleshooting when things go wrong -
> > requires more observability of suspend/resume/abort behavior than Linux
> > currently provides.  While mechanisms like `/sys/power/pm_wakeup_irq` and
> > wakeup_source stats are useful, they are incomplete and scattered.  The
> > Android kernel wakeup reason patches implement significant improvements in
> > that area.
> >
> > # Features
> >
> > As of today, the active set of patches surface the following
> > suspend-related data:
> >
> > * wakeup IRQs, including:
> >    * multiple IRQs if more than one is pending during resume flow
> >    * unmapped HW IRQs (wakeup-capable in HW) that should not be
> >      occurring
> >    * misconfigured IRQs (e.g. both enable_irq_wake() and
> >      IRQF_NO_SUSPEND)
> >    * threaded IRQs (not just the parent chip's IRQ)
> >
> > * non-IRQ wakeups, including:
> >    * wakeups caused by an IRQ that was consumed by lower-level SW
> >    * wakeups from SOC architecture that don't manifest as IRQs
> >
> > * abort reasons, including:
> >    * wakeup_source activity
> >    * failure to freeze userspace
> >    * failure to suspend devices
> >    * failed syscore_suspend callback
> >
> > * durations from the most recent cycle, including:
> >    * time spent doing suspend/resume work
> >    * time spent in suspend
> >
> > In addition to battery life optimization and troubleshooting, some of these
> > capabilities also lay the groundwork for efforts around improving
> > attribution of wakeups/aborts (e.g. to specific processes, device features,
> > external devices, etc).
> >
> > # Shortcomings
> >
> > While the core implementation (see below) is relatively straightforward and
> > localized, calls into that core are somewhat widely spread in order to
> > capture the breadth of events of interest.  The pervasiveness of those
> > hooks is clearly an area where improvement would be beneficial, especially
> > if a cleaner solution preserved equivalent capabilities.
> >
> > # Existing Code
> >
> > As a reference for how Android currently implements the core code for these
> > features (which would need a bit of work before submission even if all
> > features were included), see the following link:
> >
> > https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/kernel/power/wakeup_reason.c
> >
>
> Hey Kelly!
>   So Zichar (added to the thread here) has been working for a little
> while on his own approach to upstream a simplified version of the
> wakeup_reason functionality. He's just gotten it to a place where it
> can be shared, so I wanted to pull him in so he could reply with his
> proposal.
>
> thanks
> -john
