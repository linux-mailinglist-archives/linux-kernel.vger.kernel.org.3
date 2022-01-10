Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84055489F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiAJStz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbiAJSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:49:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CAC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:49:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j11so47719741lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jaXzWb8RIYggtumZsRquSImyXJVvqgGVeqysl2CjfNs=;
        b=IwCpV9hqvo50xIXYGoYiOow1RTXRzZo7PKZJjfCTn13mW8l9wl9EInMYf83Pb1KtHW
         q6rPtrMCBguxNQp3+UIOrQNBOEaNW4z1jwOHmFqeHxloxBdSljnRwDnXJ61BFjJtOspl
         mzqfZnx8aoXoI7XsciYTiGZDlgigps74TTbqySregXY0YMT3tPBBXCpnr9YrTc5L+oaw
         wVENgAQd7zOxIM1/atqXqxF5tivHgQdvYRqGp1okLa68fUduUXgezhkKAWxcu6TFfJoF
         7Wk7ZfdSJiTxnEbdOw1JU04j1NXecY2ufE3JCOMOYGYHuhvFCAr0WuZZhI+M5HU/T9OI
         7Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jaXzWb8RIYggtumZsRquSImyXJVvqgGVeqysl2CjfNs=;
        b=QGapHaZlA0UxE6rbFwR6nt6SKErSS5P7MZQyQDCWzOUffU/9TaEjO0EXm6z8fSkFmW
         fbmgNz3zTIopB35kqhQ+UhMvCkQKU0wm+tKeX88fOWDyx5eWZIOFavVKUU5JeyElx/cX
         ciXRhOPvU+PalT/Uyi6c7kx+IqOgrcdp9kGn8F9eu+UtgRUarJ1bAFXwrrzUUrRr4HHK
         Qf3j8mo+T/2EB/bHE0iVWI2AeFOwtf2Rbt4cwyBv2ySolryRxhKh3CM703AtSt09vvg+
         3zXy4aV+n4CMDdXoh6KDaFkQHVvFPpgh1VwF1/gOL8YXTQmdbGXsbXhzok4iqJwYjBiJ
         YpDg==
X-Gm-Message-State: AOAM531a05H3dHSsFBpZZOoT9Si+AT59YI3jnXXfoOVST/KsgzW8zYp/
        Lzwg8eFXvg8oKZNQmhl0ioCRVjKkgIZ6G3loh97KQBisrJLdaSyw
X-Google-Smtp-Source: ABdhPJwjegyxg0bdZ8Zl85KkHVjwm9LjDPonIAZnkNAkwCS/RJdKgnpG5w9l+AAc6SdkIJXrkrRu1/12whOyHhCbSgU=
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr735334lfg.253.1641840592002;
 Mon, 10 Jan 2022 10:49:52 -0800 (PST)
MIME-Version: 1.0
From:   Kelly Rossmoyer <krossmo@google.com>
Date:   Mon, 10 Jan 2022 10:49:15 -0800
Message-ID: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
Subject: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Introduction

To aid optimization, troubleshooting, and attribution of battery life, the
Android kernel currently includes a set of patches which provide enhanced
visibility into kernel suspend/resume/abort behaviors.  The capabilities
and implementation of this feature have evolved significantly since an
unsuccessful attempt to upstream the original code
(https://lkml.org/lkml/2014/3/10/716), and we would like to (re)start a
conversation about upstreaming, starting with the central question: is
there support for upstreaming this set of features?

# Motivation

Of the many factors influencing battery life on Linux-powered mobile
devices, kernel suspend tends to be amongst the most impactful.  Maximizing
time spent in suspend and minimizing the frequency of net-negative suspend
cycles are both important contributors to battery life optimization.  But
enabling that optimization - and troubleshooting when things go wrong -
requires more observability of suspend/resume/abort behavior than Linux
currently provides.  While mechanisms like `/sys/power/pm_wakeup_irq` and
wakeup_source stats are useful, they are incomplete and scattered.  The
Android kernel wakeup reason patches implement significant improvements in
that area.

# Features

As of today, the active set of patches surface the following
suspend-related data:

* wakeup IRQs, including:
   * multiple IRQs if more than one is pending during resume flow
   * unmapped HW IRQs (wakeup-capable in HW) that should not be
     occurring
   * misconfigured IRQs (e.g. both enable_irq_wake() and
     IRQF_NO_SUSPEND)
   * threaded IRQs (not just the parent chip's IRQ)

* non-IRQ wakeups, including:
   * wakeups caused by an IRQ that was consumed by lower-level SW
   * wakeups from SOC architecture that don't manifest as IRQs

* abort reasons, including:
   * wakeup_source activity
   * failure to freeze userspace
   * failure to suspend devices
   * failed syscore_suspend callback

* durations from the most recent cycle, including:
   * time spent doing suspend/resume work
   * time spent in suspend

In addition to battery life optimization and troubleshooting, some of these
capabilities also lay the groundwork for efforts around improving
attribution of wakeups/aborts (e.g. to specific processes, device features,
external devices, etc).

# Shortcomings

While the core implementation (see below) is relatively straightforward and
localized, calls into that core are somewhat widely spread in order to
capture the breadth of events of interest.  The pervasiveness of those
hooks is clearly an area where improvement would be beneficial, especially
if a cleaner solution preserved equivalent capabilities.

# Existing Code

As a reference for how Android currently implements the core code for these
features (which would need a bit of work before submission even if all
features were included), see the following link:

https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/kernel/power/wakeup_reason.c


--

Kelly Rossmoyer | Software Engineer | krossmo@google.com
