Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7149FE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbiA1Q3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiA1Q3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:29:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C21C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8948561EE0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33BAC340E6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:29:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CIBNIxAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643387339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HO9B6AQD9lhtTNqYreWDbICBEhJE9ur8i2dfTih+tHU=;
        b=CIBNIxAPQM2eCdTK8k/3cBsl/z2fbSw/8xR9uT8598k4f5xaNBQvqyNXpVE8DqdgVZKXZ3
        qy8PKeMwm+CMz5MM6NLBCqv8Baf20Y9INe13tDTs9IDv4lzJj1ig06iU3h0dEhAq+n9E5j
        3q5P8nQMZSfUPYiXTZ1FJnZeeN21u4I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 835cb781 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 28 Jan 2022 16:28:59 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id k31so20097110ybj.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:28:59 -0800 (PST)
X-Gm-Message-State: AOAM532/Si7RxDsEie4urdmDi5aVCEnmrjvdjZlG6RAu8SctOVoIb4dT
        Z4vhRJMXThSjbJAflhmk2zeqOwm8kbb+K65GaHg=
X-Google-Smtp-Source: ABdhPJwHJSqim1eChQeFVNv7DjxALppZZR6DCq8GZ2fMKkhrHRwkzyC9HESBcw6m481Y6mE99h1tgc11wobLFb6O84Q=
X-Received: by 2002:a25:2284:: with SMTP id i126mr12674192ybi.245.1643387338043;
 Fri, 28 Jan 2022 08:28:58 -0800 (PST)
MIME-Version: 1.0
References: <YfMa0QgsjCVdRAvJ@latitude> <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
 <YfOqsOiNfURyvFRX@linutronix.de> <CAHmME9qBj2gL=spp3AUEo-Ri4r0KQq-KrR-f6dG++xXQvzcA7A@mail.gmail.com>
 <YfQXgaAyBBEYSspV@linutronix.de>
In-Reply-To: <YfQXgaAyBBEYSspV@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Jan 2022 17:28:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9qhdRbFT26beStH3JYLiE0mpAZz-jp1jJsJdJNZKFpbvA@mail.gmail.com>
Message-ID: <CAHmME9qhdRbFT26beStH3JYLiE0mpAZz-jp1jJsJdJNZKFpbvA@mail.gmail.com>
Subject: Re: "BUG: Invalid wait context" in invalidate_batched_entropy
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jan 28, 2022 at 5:19 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Correct. You must not acquire a spinlock_t while holding a
> raw_spinlock_t. This is because on PREEMPT_RT the spinlock_t is a
> sleeping lock while raw_spinlock_t disables preemption/ interrupts and
> sleeping is not possible.
>         Documentation/locking/locktypes.rst
>
> On non-PREEMPT both lock types (spinlock_t & raw_spinlock_t) behave in
> the same way but lockdep can tell them apart with
> CONFIG_PROVE_RAW_LOCK_NESTING=y and show code that is problematic on RT.

Gotcha. Surely, then, Andy's patch at least goes some of the way
toward fixing this, since it outright _removes_ a spinlock_t. There is
still the other spinlock_t that you want removed, I realize, though
this doesn't appear to be the one from Jonathan's bug report. It
sounds like Andy's patch might be one side of the fix, and your patch
the other?

Jason
