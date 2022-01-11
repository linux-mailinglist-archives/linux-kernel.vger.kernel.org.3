Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9748A7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiAKGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiAKGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:53:29 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A357C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 22:53:29 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y11so21024377iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 22:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSDl3QNPw4cusWftYB9ASogJT1ZlpHBuHV1JbJnIkcs=;
        b=EglXCHArEpYpL7rh/UinFzlp1BBkEt46ijZrwE1U+E3jdCWiq8UShov6puMiGCPQ/3
         QMpPM0B8CJT2t9jCtocSbc0iLnhqkJGtA5JF388ATZQg+zBgbV6FDexxN7mY91kjfD9M
         UnRzDfmEHUyH8EgVFBKoNRyBKLgTSzuP8i2mpqrkjPbqaMzUAy85rkBptZ+ErT4cqfH/
         VM5bpFN8lBQy4Vs0l81nGqCkb6PSyiSd0iXOaJHdp5XSqS70ONVZGnWZPVJCev47VWlT
         3UWPPkkJMJ2CLC+WMDixnyaAdaHQHxWs4GK/+7dXiWKPDWv/ZMMoucUErvvR4HnzBpeL
         ND1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSDl3QNPw4cusWftYB9ASogJT1ZlpHBuHV1JbJnIkcs=;
        b=oDwNWVIe8KI2bRB3P/KNxkRdgpmdppj8k6stlK9LA9wUw8lm3F+Fpd02H2qEV/e0eG
         lQBJl0tfyXFPRZHyGpUWdyN4DagSTOC9ppKehGU448Z++3ud1SlkyvQQldvWnb19FqMy
         dM503fRiHhLCaKXog52tLP1gdHf3JDU2NoNKpmwdhsmekq2GMHBKMskeKiMMYto/ty6S
         9169d0EMCD1UX3xR1lzV0oG5u38zux1NtNDDvoH6gu//lK6awbCSmQGzx86PHtHzCDbC
         9bpm4y6IjV2iocKzzECmhHbgveVCmhmLWJum0yMJVzQ7G8Yuo54kavRan2oLoooUpDgn
         MDzA==
X-Gm-Message-State: AOAM533XAtilpIsElzL5SE1nn5PoWYriCRSb2TPJYKLrV5enBW7aCtLa
        8d2Fsuddkf9RPz7hqjZ7JCCRkDLJkt7cVnolDvAyQQ==
X-Google-Smtp-Source: ABdhPJztacg8YHUE48ljmhu2/De8xlmIklTvWPbHOcEJi/2sSA+6bP6x2m9vsxqPaSpG0al/1KqmwoCfK5rUlFEBzDw=
X-Received: by 2002:a05:6602:2b03:: with SMTP id p3mr1590314iov.74.1641884008720;
 Mon, 10 Jan 2022 22:53:28 -0800 (PST)
MIME-Version: 1.0
References: <20220108164617.3130175-1-jaegeuk@kernel.org> <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com> <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <9efbbcb7-29cd-a8ab-0632-01986edc862f@redhat.com>
In-Reply-To: <9efbbcb7-29cd-a8ab-0632-01986edc862f@redhat.com>
From:   Tim Murray <timmurray@google.com>
Date:   Mon, 10 Jan 2022 22:53:16 -0800
Message-ID: <CAEe=Sx=C8e7=A6ziy8dYC+FvkWvVYZ+o=XMCP_4vX0efsUPT4Q@mail.gmail.com>
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

On Mon, Jan 10, 2022 at 8:15 PM Waiman Long <longman@redhat.com> wrote:
> That is not how rwsem works. A reader which fails to get the lock
> because it is write-locked will remove its reader count before going to
> sleep. So the reader count will be zero eventually. Of course, there is
> a short period of time where the reader count will be non-zero until the
> reader removes its own reader count. So if a new writer comes in at that
> time, it will fail its initial trylock and probably go to optimistic
> spinning mode. If the writer that owns the lock release it at the right
> moment, the reader may acquire the read lock.

Thanks for the correction, that makes sense. I haven't spent too much
time on rwsem internals and I'm not confident about when flags are set
and cleared in sem->count; is there a case where sem->count after
up_write() could be nonzero?

An example from one trace:

1. Low-priority userspace thread 4764 is blocked in f2fs_unlink,
probably at f2fs_lock_op, which is a wrapper around
down_read(cp_rwsem).
2. f2fs-ckpt runs at t=0ms and wakes thread 4764, making it runnable.
3. At t=1ms, f2fs-ckpt enters uninterruptible sleep and blocks at
rwsem_down_write_slowpath per sched_blocked_reason.
4. At t=26ms, thread 4764 runs for the first time since being made
runnable. Within 40us, thread 4764 unblocks f2fs-ckpt and makes it
runnable.

Since thread 4764 is awakened by f2fs-ckpt but never runs before it
unblocks f2fs-ckpt in down_write_slowpath(), the only idea I had is
that cp_rwsem->count is nonzero after f2fs-ckpt's up_write() in step 2
(maybe because of rwsem_mark_wake()?).

> I do have a question about the number of readers in such a case compared
> with the number of writers. Are there a large number of low priority
> hanging around? What is an average read lock hold time?
>
> Blocking for 9.7s for a write lock is quite excessive and we need to
> figure out how this happen.,

Just to be 100% clear, it's not a single 9.7s stall, it's many smaller
stalls of 10-500+ms in f2fs-ckpt that add up to 9.7s over that range.

f2fs is not my area of expertise, but my understanding is that
cp_rwsem in f2fs has many (potentially unbounded) readers and a single
writer. Arbitrary userspace work (fsync, creating/deleting/truncating
files, atomic writes) may grab the read lock, but assuming the
merge_checkpoint option is enabled, only f2fs-ckpt will ever grab the
write lock during normal operation. However, in this particular
example, it looks like there may have been 5-10 threads blocked on
f2fs-ckpt that were awakened alongside thread 4764 in step 2.

I'll defer to the f2fs experts on the average duration that the read
lock is held.
