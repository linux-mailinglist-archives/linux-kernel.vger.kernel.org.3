Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88C48CE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiALWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiALWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:07:03 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD918C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:07:03 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d14so3811092ila.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1JyjUsSG/tC90anes6eSOJnWR9Q3etKeOSBPf+5wCQ=;
        b=Q3y6vBc/2NoSipdG9xyq0Hn/hNADh8AEXVhgOMQK06NhjCdW1rIcWXpcNkhXQKqyEt
         ZdYpL80INGC9DMb/IM/itKk+qU9l1w1s7Fd4Q6v0kcv3GHmgalpZs1sdFwo6a/E6BW1I
         /QySbH2GlxKD88Xoyzpn3FLPbrZqa2rBY+1D7UjSXuPAfKrhRDH0iJWTjGLQNauTO3Ny
         kOX0GuQ4qr2KxUFN56k9Vhqob66k39+P0581P06QniPREVAlZAqq/Q/NdEPrmzsUY1vN
         NFlHGqeL6yqwteFmhknMLi/XS9a5ewQQcl4PAuOGAWF1InMqSnDZIV4Quoee681tp8MJ
         SFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1JyjUsSG/tC90anes6eSOJnWR9Q3etKeOSBPf+5wCQ=;
        b=8P55BP4GPi8xHoQkEDtNAo9raGoz6HA14d7p/E4iaH7594lypF1oW5r7h8Z8g1EtQu
         cSCpCYrHvkbR6mDmIIWUrb5DcNq42nPHpNmmfq6Qn4dlz57dQiCMG7NxHZtdY+GqebXF
         xR0e7/Zknr2uU57twtv4QtQwhcgWp7Ru+sU0iE7DYUse0rkdmpbtO+ggG9FD9tSprhq4
         pjeqiK89SzO/0oa+aYWvm/IHfssG0y6jGuSaPST1VU6d228NdrFnZ8uslma6rvbmUp4a
         8nSjgcHY+R1YGaAF3h3bW033dQpQxEfL8E+dAz7kjy8gt/YuxZ6fkbnrz4HoTkxTKHii
         kZCQ==
X-Gm-Message-State: AOAM531mZzt5mtUhJ8ZLxeapQY44BMwuNCRd6h4lnNc1M2Uv6PBSW06e
        M7hJzE67CA0IYKRpauK4HhRCjc4LCcmIrtowfjp+sr7BGos=
X-Google-Smtp-Source: ABdhPJwtTKZa+3RSsHFzPVEwy1zhEcEH0RO3KzgBl2q6/1ObHwMzOZF5Yf/htiNz+TMmVc3xP/rjSBCQR/QIR4Eqp2c=
X-Received: by 2002:a05:6e02:d08:: with SMTP id g8mr858200ilj.115.1642025222909;
 Wed, 12 Jan 2022 14:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20220108164617.3130175-1-jaegeuk@kernel.org> <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com> <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <Yd7gVLdHW11TQUAi@hirez.programming.kicks-ass.net>
In-Reply-To: <Yd7gVLdHW11TQUAi@hirez.programming.kicks-ass.net>
From:   Tim Murray <timmurray@google.com>
Date:   Wed, 12 Jan 2022 14:06:50 -0800
Message-ID: <CAEe=Sx=6FCvrp_6x2Bqp3YTzep2s=aWdCmP29g7+sGCWkpNvkg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 6:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> *urgh*... so you're making the worst case less likely but fundamentally
> you don't change anything.
>
> If one of those low prio threads manages to block while holding
> cp_rwsem your checkpoint thread will still block for a very long time.
>
> So while you improve the average case, the worst case doesn't improve
> much I think.

You're right about the worst case latency, but I think a lock
optimization is still useful. If I understand the rwsem implementation
correctly, if there's one pending reader while a writer holds the
rwsem and the reader is sleeping when the writer releases the lock,
the writer will mark the rwsem as reader-owned by incrementing the
reader count then wake the reader in rwsem_mark_wake(). Assuming
that's correct, hitting this case guarantees the lowest possible
latency of a second write lock is the sum of reader's scheduling
delay, the reader's critical section duration, and the writer's
scheduling delay. What we see here is that the reader's scheduling
delay is orders of magnitude larger than the read lock duration when
the readers are low priority (tens of milliseconds of scheduling delay
when the device is heavily loaded vs tens of microseconds of holding
the read lock). The scheduling delay of f2fs-ckpt seems insignificant
compared to the scheduling delay of the reader (and is easily
addressed because it's a kthread vs arbitrary userspace code).

If the stalls were due to preemption of a low-priority reader that
holds the cp_rwsem read lock, I would expect to see some traces like:

1. low-prio userspace thread is running
2. low-prio userspace thread grabs cp_rwsem read lock, is preempted,
switches back to runnable
3. f2fs-ckpt wakes up, blocks on cp_rwsem write lock
4. low-prio userspace thread switches to running and unblocks f2fs-ckpt

Specifically, the low-prio userspace thread would need to wake up
f2fs-ckpt without the userspace thread ending up in uninterruptible
sleep around that period. To my knowledge, we've never seen that in a
trace. The bad behavior we see always comes after the low-prio thread
was blocked acquiring the read lock and switches back to runnable from
uninterruptible sleep. I think the patches that Waiman mentioned don't
address the case we're seeing; I think they fix different patterns of
new readers preventing a writer from becoming runnable vs a long
scheduling delay of a reader awakened by a writer that in turn makes a
writer runnable once the reader finally runs.

With the existing rwsem usage in f2fs, f2fs-ckpt is guaranteed to wait
for the reader's scheduling delay plus the read lock time every time
there's a pending reader, which is the common case with f2fs-ckpt
(because the write lock is held for milliseconds of IO ops vs
microseconds for readers) and why we often see hundreds of 10-100ms
checkpoints in a row. By moving to a reader-unfair rwsem, f2fs-ckpt
would only pay the latency of the reader's scheduling delay if the
reader is preempted while holding the lock. I'm sure that preemption
does happen and that the max latency is about the same as a result,
but given how short the read locks are held vs the write lock and the
relative likelihood of a preempted reader vs any reader arriving at
the lock while the writer is doing IO, the reader-unfair approach
should be a dramatic improvement in 99th percentile (and greater) f2fs
checkpoint latency.

> Also, given that this is a system wide rwsem, would percpu-rwsem not be
> 'better' ? Arguably with the same hack cgroups uses for it (see
> cgroup_init()) to lower the cost of percpu_down_write().

Funny you should mention this--the next thing on my todo list is to
root causing stalls around cgroup_threadgroup_rwsem (mostly in
cgroup_css_set_fork() hit from pthread_create in userspace).

If I'm reading percpu-rwsem.c correctly, it's not fair to readers in
the same way that this patch is. It's probably okay to switch to
percpu_rwsem in f2fs given the distribution of readers to writers, but
I am concerned about giving up spin-on-owner given how often these
locks will be hit from different processes at very different
priorities. Does that seem overly paranoid?

> Now, I'm not a filesystem developer and I'm not much familiar with the
> problem space, but this locking reads like a fairly big problem. I'm not
> sure optimizing the lock is the answer.

I'm not a filesystem developer either, but rewriting the locking was
my first suggestion too. It seems much harder than tweaking the lock.
Rewriting the locking might still be necessary if we see regular
preemption while the cp_rwsem read lock is held, but I don't have any
data showing that preemption is happening regularly right now.
