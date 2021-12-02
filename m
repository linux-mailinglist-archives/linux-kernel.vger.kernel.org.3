Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064004662C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbhLBL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLBL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:56:51 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AE7C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:53:27 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id u74so54963493oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERyjVDLbvXPFw+1ZHIpwSYVMUQxNY4scWpUY/y6O0Jc=;
        b=blIsLDwR7DDDswyfTL9WVDwe+/nUiuVUR+UCadaBQSti541u6laTjJjf9ToEVYDU7H
         Htyds7/EMoO9+ZUqBB2zuhy/565m4apZoQ74cN3uebq1UVMwJBRKG6tCeACR535RSnaB
         OW1P3+KISAGYO9Y+t1uHBn4GY8z+wfDbQKHAd6iizancTxDx+UPu7MMKkwQLC5wrxy/z
         8QcauXaXXtV/Zp12rcW7n+PSzXf135qnypLKsYt+p8OMLteCPWHMIR85LI7WZjIguDlR
         owrgqn0o69VHdzI3I5JDvsArcU18NtixOEzB2wfq0SM1XYdSxNp6CJGxZoX8VmUmvDpn
         xSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERyjVDLbvXPFw+1ZHIpwSYVMUQxNY4scWpUY/y6O0Jc=;
        b=jnL3EL7BUIvfE1eV230dHuQpE8Sn73+zYaUk8X5QHAJzmzL89jpqkA71ptV/voB05c
         iAMVBg1o8CQsD0HpSjfqEa2+EAgkSOwpUFF0xzOi1JBbgZlrg+dB92k30OpRTO6m4TvE
         QR9ja9kGdmmHXyoWAG+yarM3JUD6ze56Pnen7+nhaRiCtAmwJ49ns7oTRBfNraSChdeZ
         qDIeI+zdK1HQFsRg8HjAtBYbI91kMp1hI8lpB7SRwGpU9FSq8ZL711pIUBsX3xRuffRo
         oybuZA85I/JgILtZN5WfN2tC2IQatwd529oYA5mycfhDNNr6EUoW+gfkKrNu4cdez4a0
         tPcw==
X-Gm-Message-State: AOAM533J2Kgl3rw1HckceN0P0GEliueZZuyjOghuYfV3iph7I6tgU9b6
        /YSO7OUV5jNNRh29sdVMKJgCSdtyob+PliqV7X3h/w==
X-Google-Smtp-Source: ABdhPJwKGdAzCefTTCIIvY8lR1kW2egRR6DJg4LtoNnwU0WiLrD5llqmW6j5znFPLau6to4un5sDRRiBsMEo91LZxTk=
X-Received: by 2002:aca:af50:: with SMTP id y77mr4149176oie.134.1638446006972;
 Thu, 02 Dec 2021 03:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20211202101238.33546-1-elver@google.com>
In-Reply-To: <20211202101238.33546-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Dec 2021 12:53:14 +0100
Message-ID: <CANpmjNMvPepakONMjTO=FzzeEtvq_CLjPN6=zF35j10rVrJ9Fg@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Mark racy reads of owner->on_cpu
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 11:13, Marco Elver <elver@google.com> wrote:
> One of the more frequent data races reported by KCSAN is the racy read
> in mutex_spin_on_owner(), which is usually reported as "race of unknown
> origin" without showing the writer. This is due to the racing write
> occurring in kernel/sched. Locally enabling KCSAN in kernel/sched shows:
>
>  | write (marked) to 0xffff97f205079934 of 4 bytes by task 316 on cpu 6:
>  |  finish_task                kernel/sched/core.c:4632 [inline]
>  |  finish_task_switch         kernel/sched/core.c:4848
>  |  context_switch             kernel/sched/core.c:4975 [inline]
>  |  __schedule                 kernel/sched/core.c:6253
>  |  schedule                   kernel/sched/core.c:6326
>  |  schedule_preempt_disabled  kernel/sched/core.c:6385
>  |  __mutex_lock_common        kernel/locking/mutex.c:680
>  |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
>  |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
>  |  mutex_lock                 kernel/locking/mutex.c:283
>  |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
>  |  ...
>  |
>  | read to 0xffff97f205079934 of 4 bytes by task 322 on cpu 3:
>  |  mutex_spin_on_owner        kernel/locking/mutex.c:370
>  |  mutex_optimistic_spin      kernel/locking/mutex.c:480
>  |  __mutex_lock_common        kernel/locking/mutex.c:610
>  |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
>  |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
>  |  mutex_lock                 kernel/locking/mutex.c:283
>  |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
>  |  ...
>  |
>  | value changed: 0x00000001 -> 0x00000000
>
> This race is clearly intentional, and the potential for miscompilation
> is slim due to surrounding barrier() and cpu_relax(), and the value
> being used as a boolean.
>
> Nevertheless, marking this reader would more clearly denote intent and
> make it obvious that concurrency is expected. Use READ_ONCE() to avoid
> having to reason about compiler optimizations now and in future.
>
> Similarly, mark the read to owner->on_cpu in mutex_can_spin_on_owner(),
> which immediately precedes the loop executing mutex_spin_on_owner().
>
> Signed-off-by: Marco Elver <elver@google.com>
[...]

Kefeng kindly pointed out that there is an alternative, which would
refactor owner_on_cpu() from rwsem that would address both mutex and
rwsem:
https://lore.kernel.org/all/b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com/

Preferences?

Thanks,
-- Marco
