Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7BE49F539
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbiA1IfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:35:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiA1Ie7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:34:59 -0500
Date:   Fri, 28 Jan 2022 09:34:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643358898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mznfj1fiPKTxFf7vYfwMEGCtvJ9wyttqXLSgdsx8nRA=;
        b=BCrujvZBSCpf2xna9fz8CLrwsuLZ5hpooBVbum1LBX25zjvELu0ZsoZ253ceQPEXMN8Kvi
        sqzdZUnLxnGYNZAO/CgBXiCdqfc3i60YX3JSMjjGryGSX7EQZycBzQf9sSSf4zSXySule+
        +S/lIBltqiPfMaeR2tpllMyMUYUcf5fTdeb6CL1dSJgrv3MZPjTrzmSZPRdimWhVa/1UzM
        AQC8pCFEu+7DGdY4ys9aV4jXCDdrZ0sNUiO+TKe9hCmyBOPsof2gtDlltesRmbCWa+e3mS
        q0CGhNcaX7EzhyI0m1eccf4luHkeN1Kn0eYPSD+3dNF0PSq9GeC05T38KpBkaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643358898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mznfj1fiPKTxFf7vYfwMEGCtvJ9wyttqXLSgdsx8nRA=;
        b=QSzHDGAI/DVypc2Th4gX1TX2xv1rmt64a7FnUgtSVLPgZOqLDhH4pawMVIJvqvQyn+h8O5
        GrCmraSp5DSp8JBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: "BUG: Invalid wait context" in invalidate_batched_entropy
Message-ID: <YfOqsOiNfURyvFRX@linutronix.de>
References: <YfMa0QgsjCVdRAvJ@latitude>
 <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 23:26:32 [+0100], Jason A. Donenfeld wrote:
> Hi Jonathan,
Hi Jason,

> Thanks for the report. I'll try to reproduce this and see what's going on.
> 
> I'm emailing back right away, though, so that I can CC in Andy
> Lutomirski, who I know has been sitting on a stack of patches that fix
> up (actually, remove) the locking, so this might be one path to fixing
> this.

This report is due to CONFIG_PROVE_LOCKING=y _and_
CONFIG_PROVE_RAW_LOCK_NESTING=y. It reports a nesting problem
(raw_spinlock_t -> spinlock_t lock ordering) which becomes a real
problem on PREEMPT_RT.

I've been testing my old series on top of 5.17-rc1. With blake2 the
numbers lowered a little. I'm gettin 3-6us on average and 16-26us
worstcase and with NUMA it still goes up to 40-50us.
If you still object the previous approach and neither tglx/peterz
disagree we could try making the lock raw_spinlock_t and add a mutex_t
around the userspace interface to lower the lock contention. But even
then we need to find a way to move the crng init part (crng_fast_load())
out of the hard-IRQ.

> Thanks,
> Jason

Sebastian
