Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13E48A049
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbiAJTlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbiAJTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:41:35 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB2BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:41:35 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e8so12314623ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhs7IL4TuG8oCYTZuQ1+Jl2xnZ/ELPkPUon97c59VHo=;
        b=n3MYFNks8/IOT2YjufrlS6VEYPjy+x1daJ7/2YzdsLN9cvg+2nz1u71iTNIMhbnFe7
         wquK+2gOG4YskjWfRH51WQLgm20kTM9GtpF5hWSkW+izvrK4NqgJaa/bK0wYENtAUkN7
         1pxE4MOYIThkesUn4tpRCvuuQUkAcnkB5cNu7NbcYw7o006A3FuZVTs+Yii8denc1Loi
         2x8dBg15cZrOp36xIfc3Me3YJfCui7TuoNS20XElI1OqfCrAW9wpEfgSrr72wyojueDT
         9fxMMb4g24j4dY/64E2J9VTuK0emyLAtJeJG31/AZAQMKlWhP0CCsDiWgaQBeIBCE650
         HQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhs7IL4TuG8oCYTZuQ1+Jl2xnZ/ELPkPUon97c59VHo=;
        b=gAAQasJ2pNM4jeZHIA1OQQii7GqhqrE8ZQnYup1gBzwzB3GwcWk/CF3nepEm8MJHOS
         G8iAMKpqsM+MY7yslCwMlmTdaxjJYjarHYMddpCXDf0Hc37IsSLnV13yO6lkWYsXYfff
         +2YdH0053smRy8FgzztSEy85djmgcCCF/iMBMWzsj+3VKh7tR2bm0PFcn4JgLC2u3DcE
         cnRjJJyBDRsHuRthPYrJ9G5UfQ03isxczFQK7tBYO3nfaGNASRm4FUIj0I1Je3Xii1EQ
         xr7ywlnnd06fjzAjFjoCAXIkjU6K+PPXbjvDs2VeG9asDsbOkU216nRh4bqR/2b7gtUm
         j8cg==
X-Gm-Message-State: AOAM5322Hu0ZiCbPWxZfTOs7d+JXvZn85Ey+CpreybmzFn2dLLVhgLsa
        of0Oc9/QBNtgvNLqfcq3w1EqgaXrWwlSaZKwza1cvw==
X-Google-Smtp-Source: ABdhPJxhjNm6icsqOGOpoFOONXUNbXjRqEF5soc9izmdW9/IxaC/kPfcJo0PCuHyrH747FDUTCl0MmpF8k0bksOJZYk=
X-Received: by 2002:a92:ca90:: with SMTP id t16mr735783ilo.173.1641843694664;
 Mon, 10 Jan 2022 11:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20220108164617.3130175-1-jaegeuk@kernel.org> <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
In-Reply-To: <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
From:   Tim Murray <timmurray@google.com>
Date:   Mon, 10 Jan 2022 11:41:23 -0800
Message-ID: <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 7:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Can we start by describing the actual problem?

Of course. Sorry, I didn't realize Jaegeuk was going to move so
quickly with this patch :)

We have a few thousand traces from internal Android devices where
large numbers of threads throughout the system end up blocked on
f2fs_issue_checkpoint(), which userspace code usually reaches via
fsync(). In the same traces, the f2fs-ckpt kthread is often blocked
around f2fs_write_checkpoint(), which does the actual fsync()
operation on behalf of some number of callers (coalescing multiple
fsync calls into a single checkpoint op). I think the problem is
something like:

1. f2fs-ckpt thread is running f2fs_write_checkpoint(), holding the
cp_rwsem write lock while doing so via f2fs_lock_all() in
block_operations().
2. Random very-low-priority thread A makes some other f2fs call that
tries to get the cp_rwsem read lock by atomically adding on the rwsem,
fails and deschedules in uninterruptible sleep. cp_rwsem now has a
non-zero reader count but is write-locked.
3. f2fs-ckpt thread releases the cp_rwsem write lock. cp_rwsem now has
a non-zero reader count and is not write-locked, so is reader-locked.
4. Other threads call fsync(), which requests checkpoints from
f2fs-ckpt, and block on a completion event that f2fs-ckpt dispatches.
cp_rwsem still has a non-zero reader count because the low-prio thread
A from (2) has not been scheduled again yet.
5. f2fs-ckpt wakes up to perform checkpoints, but it stalls on the
write lock via cmpxchg in block_operations() until the low-prio thread
A has run and released the cp_rwsem read lock. Because f2fs-ckpt can't
run, all fsync() callers are also effectively blocked by the
low-priority thread holding the read lock.

I think this is the rough shape of the problem (vs readers holding the
lock for too long or something like that) because the low-priority
thread is never run between when it is initially made runnable by
f2fs-ckpt and when it runs tens/hundreds of milliseconds later then
immediately unblocks f2fs-ckpt.

When there's a lot of oversubscription, threads running IO, etc, we
see f2fs-ckpt stalls of tens to hundreds of milliseconds per f2fs-ckpt
iteration. In one recent experiment of the immediate aftermath of
booting and unlocking a phone for the first time, over a 10s period,
we saw f2fs-ckpt blocked on the rwsem for 9.7s, running for <50ms over
110 separate slices (so probably ~110 fsyncs), and blocked on IO
operations for <100ms. The worst 10s period I can find in a similar
experiment with the unfair reader approach has f2fs-ckpt blocked on
the rwsem for 130ms, running for 20ms over 95 slices, blocked on IO
for 40ms, and sleeping the rest of the time.

Unfair rwsems are rarely appropriate, but I think the lack of fairness
makes sense here because of the relative importance of f2fs-ckpt vs
any particular reader of that rwsem. The one concern I have about
down_read_unfair() is whether the fairness should be a property of the
down_read operation or the rw_semaphore itself. In the f2fs case, it
seems like all read locks of the rw_semaphores should be unfair and
that adding a single fair down_read() could introduce a similar
regression, but duplicating rw_semaphore also seems bad. If it does
make sense to make the fairness a property of the semaphore, could
that property be flagged in an init_unfair_rwsem() macro and then
checked in lockdep?
