Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB58349EB63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbiA0Ty2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:54:28 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:38483 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiA0Ty1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:54:27 -0500
Received: by mail-yb1-f180.google.com with SMTP id i62so11973809ybg.5;
        Thu, 27 Jan 2022 11:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0CsRFxzzBrJ4BfSM8ysWhGxkA3JbyEVNNCMA4Y9qEw=;
        b=I33hFJDHA95r/uVpYePieeqQ1Sqv15KQIjQDGrMc9f5TRperDgnKWnXqmyWhY56bhC
         AhSXtbJxE38RNVUeR0Nfx4V6a+JTw/M47SiPF9zwsFzLn5mtERS1ZQTWah7aCFPGTTsJ
         ZU8igMhmMiYkVyTiZCSQllNZc7F9I+V6ysnUnCXAC46FmoVgCWbdMuEgysUjUO5rQV3g
         36MEcSI6JFF0pA3rkdMSihBKL2F1jjD9KC6pQK3dbKnK8pYnenEvqnwYOu15efOcZ7hS
         M+zfPjzFwRJrlUF+eRCn0FYvFp7JBBXaZOOO1nW6nANiv2+P7GFBC1zkdqlVtNFOP6lM
         BqWQ==
X-Gm-Message-State: AOAM531/3gimaQy92VzTjPETEyfY0x9oYzK4mRKvfv5jU12LLfvsp+RE
        7/c+CP6DT43P2f60ve0re97Y3ifL2+qlqtdWMKQ=
X-Google-Smtp-Source: ABdhPJwBuKlrfLY9aMI2upRQvV67nFTgmKSKkR466gSRMNJ4X/x/aQ2ceT2In4Gy7XM25GdTYjSK2lcibeELDjac2VE=
X-Received: by 2002:a05:6902:1507:: with SMTP id q7mr8057510ybu.343.1643313266829;
 Thu, 27 Jan 2022 11:54:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
In-Reply-To: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 20:54:16 +0100
Message-ID: <CAJZ5v0jrU4Xw2wzdUL9Vd2C6u8NVx5J79DeiRY6KU1xT6ZSuqw@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     Kelly Rossmoyer <krossmo@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 7:49 PM Kelly Rossmoyer <krossmo@google.com> wrote:
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

So as Zichar said, this is quite heavy-weight.

I'm not fundamentally against adding more infrastructure to help
identify issues related to system suspend, but there needs to be a
clear benefit associated with any change in this direction.  Also
adding significant overhead just for this purpose alone is rather out
of the question.

I would advise you to follow the suggestion to split the work into
smaller pieces and submit them one at a time, possibly starting with
the ones bringing the most significant benefits to the table.
