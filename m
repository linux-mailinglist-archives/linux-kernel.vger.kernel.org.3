Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBF4B0A74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbiBJKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:19:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbiBJKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:19:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4551DB88
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3xweEom7G+dDeu6xr1iKwUdMJ+gkhA5yXvU23l0enCI=; b=VKuta7L7BFHOPw/ExmtRyTNVL7
        XzLBMFKGOXyUgWRrxeukq1azQbMrKtlKGvEI9hSpjrWwVm7AzH0jY6nsqnB6poS+kWZyXP9AMR6UY
        hNLHf/ET8GVaRVT+VsBrLVtGaAdV5Oiok4G8JBI4+GiUPHe5K6TGk+7XN+KB7K+oVkIdGiOzPSAbB
        eZ50DjlR/+sp/H0fyMPeyAWqHAx/XVkJkLeW0Ki4Sb5fDI/EfFQvqnwsm7ZUja8NXA86+S+y5zarr
        UjrD6MJ50kI+7m7iTHiByvo5woq14tyI4wYo63an/z0S3vBzervhzfDBWPxyEhCiRZx30H66bgzu7
        TRN7jCtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI6Y1-008gCW-I3; Thu, 10 Feb 2022 10:19:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D973230023F;
        Thu, 10 Feb 2022 11:19:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CA872C4B1BE9; Thu, 10 Feb 2022 11:19:31 +0100 (CET)
Date:   Thu, 10 Feb 2022 11:19:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <YgTms3tGYeQ4HYFZ@hirez.programming.kicks-ass.net>
References: <20220118153254.358748-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118153254.358748-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:32:54AM -0500, Waiman Long wrote:
> The following lockdep splat was observed:
> 
> [ 9776.459819] ======================================================
> [ 9776.459820] WARNING: possible circular locking dependency detected
> [ 9776.459821] 5.14.0-0.rc4.35.el9.x86_64+debug #1 Not tainted
> [ 9776.459823] ------------------------------------------------------
> [ 9776.459824] stress-ng/117708 is trying to acquire lock:
> [ 9776.459825] ffffffff892d41d8 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x13/0x70
> 
> [ 9776.459831] but task is already holding lock:
> [ 9776.459832] ffff888e005f6d18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x27/0x130
> 
> [ 9776.459837] which lock already depends on the new lock.
>       :
> [ 9776.459857] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> [ 9776.459860]        __lock_acquire+0xb72/0x1870
> [ 9776.459861]        lock_acquire+0x1ca/0x570
> [ 9776.459862]        _raw_spin_lock_irqsave+0x40/0x90
> [ 9776.459863]        try_to_wake_up+0x9d/0x1210
> [ 9776.459864]        up+0x7a/0xb0
> [ 9776.459864]        __up_console_sem+0x33/0x70
> [ 9776.459865]        console_unlock+0x3a1/0x5f0
> [ 9776.459866]        vprintk_emit+0x23b/0x2b0
> [ 9776.459867]        devkmsg_emit.constprop.0+0xab/0xdc
> [ 9776.459868]        devkmsg_write.cold+0x4e/0x78
> [ 9776.459869]        do_iter_readv_writev+0x343/0x690
> [ 9776.459870]        do_iter_write+0x123/0x340
> [ 9776.459871]        vfs_writev+0x19d/0x520
> [ 9776.459871]        do_writev+0x110/0x290
> [ 9776.459872]        do_syscall_64+0x3b/0x90
> [ 9776.459873]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>       :
> [ 9776.459905] Chain exists of:
> [ 9776.459906]   (console_sem).lock --> &p->pi_lock --> &rq->__lock
> 
> [ 9776.459911]  Possible unsafe locking scenario:
> 
> [ 9776.459913]        CPU0                    CPU1
> [ 9776.459914]        ----                    ----
> [ 9776.459914]   lock(&rq->__lock);
> [ 9776.459917]                                lock(&p->pi_lock);
> [ 9776.459919]                                lock(&rq->__lock);
> [ 9776.459921]   lock((console_sem).lock);
> 
> [ 9776.459923]  *** DEADLOCK ***

Is this new due to the ongoing printk rewrite? Also the above doesn't
actually describe the whole invesion, the one where console sem is taken
inside pi_lock is missing.

More concerning, that ordering is invalid to begin with, so the above
seems like a very poor justification for this patch.

> The problematic locking sequence ((console_sem).lock --> &p->pi_lock)
> was caused by the fact the semaphore up() function is calling
> wake_up_process() while holding the semaphore raw spinlock.
> 
> By moving the wake_up_processs() call out of the raw spinlock critical
> section using wake_q, it will break the problematic locking sequence as
> well as reducing raw spinlock hold time which will be good for
> PREEMPT_RT.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

I have no problem with the patch, just the justification / Changelog.
