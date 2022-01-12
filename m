Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3683348BBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbiALAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiALAZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:25:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A50C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:25:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0F260E14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC650C36AEB;
        Wed, 12 Jan 2022 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641947109;
        bh=Fh70Uv5lSLqUCk9OhHMl3vXX6SeDhQ5MGCVUXCBarbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGHU9oxCbPwlEzApQbeiOP5a42rhokYS86d3e2ImJt1Lni7e7kEo7Stmm54QRknNP
         qC5/KVfhZjSJWdRwkMWuN3/HuCPrzBDw5+11kG5zfoUhq0aup0sCqlWLyvl8IIOrlJ
         +lpH86aAbw04j3+m0zl6zvTSXe9bV9Rv2d6adPb6XF9KWLDJ55zl9A9RL3hU5kxBWX
         YagZvIm3RiNgdAV+PT74iSe1Z8EjzPQHCFgSk47j1k0KL2OlZzfv38TMY3NAGDjEvC
         XvkmAqgaIygbXKLUhS5/CIZXs4OcwOHRnjz8rSGHxLTyAZPA+2l7LEnLHFd9kZD9Jn
         3PmKL8FVRtsRA==
Date:   Tue, 11 Jan 2022 16:25:07 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tim Murray <timmurray@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Message-ID: <Yd4f49lhnC7+vvAm@google.com>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <9efbbcb7-29cd-a8ab-0632-01986edc862f@redhat.com>
 <CAEe=Sx=C8e7=A6ziy8dYC+FvkWvVYZ+o=XMCP_4vX0efsUPT4Q@mail.gmail.com>
 <86891228-9c91-09f1-0e2d-0a3392649d52@redhat.com>
 <Yd25SWaqEDSpR1vO@google.com>
 <4a2352a9-42b4-56cd-423a-825faffcd801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2352a9-42b4-56cd-423a-825faffcd801@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11, Waiman Long wrote:
> On 1/11/22 12:07, Jaegeuk Kim wrote:
> > On 01/11, Waiman Long wrote:
> > > On 1/11/22 01:53, Tim Murray wrote:
> > > > On Mon, Jan 10, 2022 at 8:15 PM Waiman Long <longman@redhat.com> wrote:
> > > > > That is not how rwsem works. A reader which fails to get the lock
> > > > > because it is write-locked will remove its reader count before going to
> > > > > sleep. So the reader count will be zero eventually. Of course, there is
> > > > > a short period of time where the reader count will be non-zero until the
> > > > > reader removes its own reader count. So if a new writer comes in at that
> > > > > time, it will fail its initial trylock and probably go to optimistic
> > > > > spinning mode. If the writer that owns the lock release it at the right
> > > > > moment, the reader may acquire the read lock.
> > > > Thanks for the correction, that makes sense. I haven't spent too much
> > > > time on rwsem internals and I'm not confident about when flags are set
> > > > and cleared in sem->count; is there a case where sem->count after
> > > > up_write() could be nonzero?
> > > > 
> > > > An example from one trace:
> > > > 
> > > > 1. Low-priority userspace thread 4764 is blocked in f2fs_unlink,
> > > > probably at f2fs_lock_op, which is a wrapper around
> > > > down_read(cp_rwsem).
> > > > 2. f2fs-ckpt runs at t=0ms and wakes thread 4764, making it runnable.
> > > > 3. At t=1ms, f2fs-ckpt enters uninterruptible sleep and blocks at
> > > > rwsem_down_write_slowpath per sched_blocked_reason.
> > > > 4. At t=26ms, thread 4764 runs for the first time since being made
> > > > runnable. Within 40us, thread 4764 unblocks f2fs-ckpt and makes it
> > > > runnable.
> > > > 
> > > > Since thread 4764 is awakened by f2fs-ckpt but never runs before it
> > > > unblocks f2fs-ckpt in down_write_slowpath(), the only idea I had is
> > > > that cp_rwsem->count is nonzero after f2fs-ckpt's up_write() in step 2
> > > > (maybe because of rwsem_mark_wake()?).
> > > > 
> > > > > I do have a question about the number of readers in such a case compared
> > > > > with the number of writers. Are there a large number of low priority
> > > > > hanging around? What is an average read lock hold time?
> > > > > 
> > > > > Blocking for 9.7s for a write lock is quite excessive and we need to
> > > > > figure out how this happen.,
> > > > Just to be 100% clear, it's not a single 9.7s stall, it's many smaller
> > > > stalls of 10-500+ms in f2fs-ckpt that add up to 9.7s over that range.
> > > > 
> > > > f2fs is not my area of expertise, but my understanding is that
> > > > cp_rwsem in f2fs has many (potentially unbounded) readers and a single
> > > > writer. Arbitrary userspace work (fsync, creating/deleting/truncating
> > > > files, atomic writes) may grab the read lock, but assuming the
> > > > merge_checkpoint option is enabled, only f2fs-ckpt will ever grab the
> > > > write lock during normal operation. However, in this particular
> > > > example, it looks like there may have been 5-10 threads blocked on
> > > > f2fs-ckpt that were awakened alongside thread 4764 in step 2.
> > > > 
> > > > I'll defer to the f2fs experts on the average duration that the read
> > > > lock is held.
> > > Thanks for the explanation.
> > > 
> > > Another question that I have is whether the test result is based on the
> > > latest upstream kernel or earlier kernel version. We used to allow reader
> > > optimistic spinning which was then removed in later kernel. Reader
> > > optimistic spinning may further increase writer wait time.
> > It's on 5.10 kernel having all the upstream f2fs patches, and yes, we wanted
> > to get higher priority on writer over many readers since the writer, checkpoint,
> > is the  most latency-critical operation that can block all the other filesystem
> > operations.
> 
> v5.10 kernel still have reader optimistic spinning enabled in rwsem which
> may have worsen the writer wait time. Could you try with a more up-to-date
> kernel or backport the relevant rwsem patches into your test kernel to see
> how much it can help?

We're using https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10.
By any chance, may I ask which upstream patches we need to backport?

> 
> 
> > > Anyway, AFAICS, this patch keeps readers out of the rwsem wait queue and so
> > > only writers can go into it. We can make an unfair rwsem to give preference
> > > to writers in the wait queue and wake up readers only if there is no more
> > > writers in the wait queue or even in the optimistic spinning queue. That
> > > should achieve the same effect as this patch.
> > Can we get a patch for the variant to test a bit? Meanwhile, I think we can
> > merge this patch to add a wraper first and switches to it later?
> 
> Give me a week or so and I can make a RFC patch to support unfair rwsem for
> you to try out. You do need to try it on the latest kernel, though.

Thank you so much. My thought flow is applying this in f2fs for all the old
kernels shipped in Android devices. Then, we can try to backport upstream
rwsem patches and yours to switch finally. Let me know if you have any concern.

> 
> Cheers,
> longman
