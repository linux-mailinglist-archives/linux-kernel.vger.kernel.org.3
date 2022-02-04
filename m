Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BCF4A9A26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358936AbiBDNmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBDNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:42:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF5C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7135E61C3F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9560BC340F0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U4+TCpwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643982136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TFgUiB6M8AXvidT0bBlWlp2lQ7isr6WC/zsd6RXvDI=;
        b=U4+TCpwSXk1SidxmWGL+o422cBdYALlobcX/4UwR7r4xQK3WOoeSREY8UOFQZDmcPMFg1W
        kNNUOrKCW4r8344lhx3UtQnV132w+Et0i00YxoaRXkoTc34FgRclM4uSnYb61PpWh1mCTY
        YL5tUclo8dPI8co8DZFuQp+82HYmPW0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bbe4586d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 13:42:16 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id v190so2599556ybv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:42:15 -0800 (PST)
X-Gm-Message-State: AOAM530b/D96iWcoK6oCTdUgCwP6wtf/a/DvNJM56QPdT9urd2wQWCvG
        j2Wsu4dCQzuok1EIk5G3d03FBKbv8emRumWeEyU=
X-Google-Smtp-Source: ABdhPJxXsnr2IeXKL0Z7XMPRDxIzrZJVx3MjKHR6Sx4XYAyV5au6HyaJEFa18rSOZUjfJFOrSbYcRRDEzOQtVtWYkO8=
X-Received: by 2002:a81:9902:: with SMTP id q2mr2982258ywg.499.1643982134561;
 Fri, 04 Feb 2022 05:42:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com> <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
 <Yf0JlXf3ARsBpL9K@linutronix.de>
In-Reply-To: <Yf0JlXf3ARsBpL9K@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 14:42:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
Message-ID: <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
Subject: Re: [PATCH v2] random: remove batched entropy locking
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Please calm down a bit: this patch doesn't minimize the importance of
working out a real solution for PREEMPT_RT, and I'm not under the
illusion that this one here is the silver bullet. It does, however,
have other merits, which may or may not have anything to do with
PREEMPT_RT. To reiterate: I am taking your PREEMPT_RT concerns
seriously, and I want to come up with a solution to that, which we're
working toward more broadly in that other thread.

Per your feedback on v1, this is no longer marked for stable and no
longer purports to fix the PREEMPT_RT issues entirely. Actually, a
large motivation for this includes the reason why Andy's original
patch was laying around in the first place: we're trying to make this
code faster.

I can improve the commit message a bit though.

On Fri, Feb 4, 2022 at 12:10 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> - This splat only occurs with CONFIG_PROVE_RAW_LOCK_NESTING enabled.

Right, the commit message for v2 mentions that.

> - The problem identified by the splat affects only PREEMPT_RT. Non-RT is
>   not affected by this.

Right.

>
> - This patch disables interrupts and invokes extract_crng() which leads
>   to other problems.

The existing code, which uses a spinlock, also disables interrupts,
right? So this isn't actually regressing in that regard. It just
doesn't fix your PREEMPT_RT issue, right?

Or is the issue you see that spinlock_t is a mutex on PREEMPT_RT, so
we're disabling interrupts here in a way that we _weren't_ originally,
in a PREEMPT_RT context? If that's the case, then I think I see your
objection.

I wonder if it'd be enough here to disable preemption instead? But
then we run into trouble if this is called from an interrupt.

Maybe it'd be best to retain the spinlock_t, which will amount to
disabling interrupts on !PREEMPT_RT, since it'll never be contended,
but will turn into a mutex on PREEMPT_RT, where it'll do the right
thing from an exclusivity perspective. Would this be reasonable?

Andy? Any suggestions?

Jason
