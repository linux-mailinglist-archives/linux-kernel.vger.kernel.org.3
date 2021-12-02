Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77932466923
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376350AbhLBReb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376274AbhLBRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F9C061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ep84lIAEm6xTBlFgZLnob8SiKfPdfbP+dMspC48ZnQM=; b=ZyNtuhbDMAlLeZ8wyu8BaBoyeK
        g2ov4pkggeCukqgmPR4Y4Aqs9RejMexmhi54R6P+P2oYhIlpyOUCW0COM7g+tHp7q79zmcrJo+0gs
        zGJXb/W+b0gXeKJWbFISmzmcWGf+kTeL31fqXFyN4JjkXFTGQ2rrh4/KdFe9+d1TfBroIZxU08n4s
        bk9unD6oSW5O3TvSTri9nwQWZ2rV9rGbwEg5yly0FhEtAPzKfxlFkEQ1EuPtrAzCI5gAYq579o8h8
        0FLbzEngoYYeBRCCF6NsChsxpiVfCDR/0PaKv9nFQaIZKz5VV+RKaSN5gqwWmiZ08ldRsUPAHbf/B
        ffo+0cLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mspuv-001qkS-Th; Thu, 02 Dec 2021 17:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D1E430047A;
        Thu,  2 Dec 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A9D4201A8A52; Thu,  2 Dec 2021 15:46:22 +0100 (CET)
Date:   Thu, 2 Dec 2021 15:46:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] locking/mutex: Mark racy reads of owner->on_cpu
Message-ID: <YajcPt04S3M0Z7oR@hirez.programming.kicks-ass.net>
References: <20211202101238.33546-1-elver@google.com>
 <CANpmjNMvPepakONMjTO=FzzeEtvq_CLjPN6=zF35j10rVrJ9Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMvPepakONMjTO=FzzeEtvq_CLjPN6=zF35j10rVrJ9Fg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 12:53:14PM +0100, Marco Elver wrote:
> On Thu, 2 Dec 2021 at 11:13, Marco Elver <elver@google.com> wrote:
> > One of the more frequent data races reported by KCSAN is the racy read
> > in mutex_spin_on_owner(), which is usually reported as "race of unknown
> > origin" without showing the writer. This is due to the racing write
> > occurring in kernel/sched. Locally enabling KCSAN in kernel/sched shows:
> >
> >  | write (marked) to 0xffff97f205079934 of 4 bytes by task 316 on cpu 6:
> >  |  finish_task                kernel/sched/core.c:4632 [inline]
> >  |  finish_task_switch         kernel/sched/core.c:4848
> >  |  context_switch             kernel/sched/core.c:4975 [inline]
> >  |  __schedule                 kernel/sched/core.c:6253
> >  |  schedule                   kernel/sched/core.c:6326
> >  |  schedule_preempt_disabled  kernel/sched/core.c:6385
> >  |  __mutex_lock_common        kernel/locking/mutex.c:680
> >  |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
> >  |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
> >  |  mutex_lock                 kernel/locking/mutex.c:283
> >  |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
> >  |  ...
> >  |
> >  | read to 0xffff97f205079934 of 4 bytes by task 322 on cpu 3:
> >  |  mutex_spin_on_owner        kernel/locking/mutex.c:370
> >  |  mutex_optimistic_spin      kernel/locking/mutex.c:480
> >  |  __mutex_lock_common        kernel/locking/mutex.c:610
> >  |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
> >  |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
> >  |  mutex_lock                 kernel/locking/mutex.c:283
> >  |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
> >  |  ...
> >  |
> >  | value changed: 0x00000001 -> 0x00000000
> >
> > This race is clearly intentional, and the potential for miscompilation
> > is slim due to surrounding barrier() and cpu_relax(), and the value
> > being used as a boolean.
> >
> > Nevertheless, marking this reader would more clearly denote intent and
> > make it obvious that concurrency is expected. Use READ_ONCE() to avoid
> > having to reason about compiler optimizations now and in future.
> >
> > Similarly, mark the read to owner->on_cpu in mutex_can_spin_on_owner(),
> > which immediately precedes the loop executing mutex_spin_on_owner().
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> [...]
> 
> Kefeng kindly pointed out that there is an alternative, which would
> refactor owner_on_cpu() from rwsem that would address both mutex and
> rwsem:
> https://lore.kernel.org/all/b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com/

That seems to make sense, except it should probably go under CONFIG_SMP,
since ->on_cpu doesn't otherwise exist.
