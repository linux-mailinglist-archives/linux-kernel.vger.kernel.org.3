Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FE49870E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiAXRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiAXRiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:38:10 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1EFC06173D;
        Mon, 24 Jan 2022 09:38:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y84so4062739iof.0;
        Mon, 24 Jan 2022 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PC3NeMELC1XD6IFEvl0tImz7mUzi6DrIvhNgtCXheg=;
        b=r3W2o3FbK8Po9p5t9DKi/hM9uqDYDGKCZAI1sHFgfyGCY4wwhyY98OXAuMF6IdpkZb
         c/rGYTdAPqbfzZMwr0XyNrlMnlGcWLc4gz44291eU8oERgzhJg5YyFWQ2MsBRSQV9NqI
         YvgTo69DQeTu17hTODXR9xxiuw9j2iE1Rqq3AI3xm3b/lGWCXIrrMmkF6pVkIM8DnOoA
         /xOJeIVot2b74mIishr1uty9wkFBQ8MNphJrpakA14QRl6MCgygV6kKmvSr1AaD8mVPm
         ILUVGnzEomtWsL6yreWjWfZOAuFFTyBZUXIwEOeVAMlj+h0KorsJijDssRichvSERbtn
         Drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PC3NeMELC1XD6IFEvl0tImz7mUzi6DrIvhNgtCXheg=;
        b=JjGA8i5ZocSBkzMAB08G1KaFWAF6jHHleGbeBq3KtPYDAd3adZV3l46eJYpt5ErID6
         /S8Hqh/TwxF7OyMHPgaKuV5jzvEskSH0qERaDTsb1/AETVf1WGySaCURQoKNnUxIw2zL
         odjcS/omXq6npk1V93bDJv6dMAG+0U1VpoLtLtmgw0ht+CrFbdwvwmL5/kRE8AWD2LaG
         +Y3ghEEOrsIn2KTsH60Pp6tnq41qlmxrChcBMEvpOHZ3gsL6aXV4ZPU5EBTTfo2xOply
         1GOviSNvv8slp1WGWAm34ENeIFN18DimYKG5DQ8hLhC9RlcbdNzmtXPBnpIbdWQgXm6k
         kX8w==
X-Gm-Message-State: AOAM531eI5IKadKjMLMP5GgYgRZL5e3GB/RBIxRcTwbsjbf1mHcaW+52
        9OO8tS7L5wESdXEYOgTcL1dueLYShJroGpEqv0lGRLkCjMo=
X-Google-Smtp-Source: ABdhPJxqyiT0PPFpA0fk5ZVw2UJp+Mt7/NILaDDSxDYChAcP9uwMjItN1NgZ6EKo9iCRfF7hQBQ1H8jJ8B4YIwuKyNo=
X-Received: by 2002:a05:6638:32a5:: with SMTP id f37mr7394048jav.208.1643045890072;
 Mon, 24 Jan 2022 09:38:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
In-Reply-To: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 24 Jan 2022 09:37:59 -0800
Message-ID: <CANcMJZA16b5gT++73a8hjA=6OeLsPLQM-X+ps3kEsYHVyariGg@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     Kelly Rossmoyer <krossmo@google.com>,
        Zichar Zhang <zichar.zhang@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Tue, Jan 11, 2022 at 5:06 AM Kelly Rossmoyer <krossmo@google.com> wrote:
>
> # Introduction
>
> To aid optimization, troubleshooting, and attribution of battery life, the
> Android kernel currently includes a set of patches which provide enhanced
> visibility into kernel suspend/resume/abort behaviors.  The capabilities
> and implementation of this feature have evolved significantly since an
> unsuccessful attempt to upstream the original code
> (https://lkml.org/lkml/2014/3/10/716), and we would like to (re)start a
> conversation about upstreaming, starting with the central question: is
> there support for upstreaming this set of features?
>
> # Motivation
>
> Of the many factors influencing battery life on Linux-powered mobile
> devices, kernel suspend tends to be amongst the most impactful.  Maximizing
> time spent in suspend and minimizing the frequency of net-negative suspend
> cycles are both important contributors to battery life optimization.  But
> enabling that optimization - and troubleshooting when things go wrong -
> requires more observability of suspend/resume/abort behavior than Linux
> currently provides.  While mechanisms like `/sys/power/pm_wakeup_irq` and
> wakeup_source stats are useful, they are incomplete and scattered.  The
> Android kernel wakeup reason patches implement significant improvements in
> that area.
>
> # Features
>
> As of today, the active set of patches surface the following
> suspend-related data:
>
> * wakeup IRQs, including:
>    * multiple IRQs if more than one is pending during resume flow
>    * unmapped HW IRQs (wakeup-capable in HW) that should not be
>      occurring
>    * misconfigured IRQs (e.g. both enable_irq_wake() and
>      IRQF_NO_SUSPEND)
>    * threaded IRQs (not just the parent chip's IRQ)
>
> * non-IRQ wakeups, including:
>    * wakeups caused by an IRQ that was consumed by lower-level SW
>    * wakeups from SOC architecture that don't manifest as IRQs
>
> * abort reasons, including:
>    * wakeup_source activity
>    * failure to freeze userspace
>    * failure to suspend devices
>    * failed syscore_suspend callback
>
> * durations from the most recent cycle, including:
>    * time spent doing suspend/resume work
>    * time spent in suspend
>
> In addition to battery life optimization and troubleshooting, some of these
> capabilities also lay the groundwork for efforts around improving
> attribution of wakeups/aborts (e.g. to specific processes, device features,
> external devices, etc).
>
> # Shortcomings
>
> While the core implementation (see below) is relatively straightforward and
> localized, calls into that core are somewhat widely spread in order to
> capture the breadth of events of interest.  The pervasiveness of those
> hooks is clearly an area where improvement would be beneficial, especially
> if a cleaner solution preserved equivalent capabilities.
>
> # Existing Code
>
> As a reference for how Android currently implements the core code for these
> features (which would need a bit of work before submission even if all
> features were included), see the following link:
>
> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/kernel/power/wakeup_reason.c
>

Hey Kelly!
  So Zichar (added to the thread here) has been working for a little
while on his own approach to upstream a simplified version of the
wakeup_reason functionality. He's just gotten it to a place where it
can be shared, so I wanted to pull him in so he could reply with his
proposal.

thanks
-john
