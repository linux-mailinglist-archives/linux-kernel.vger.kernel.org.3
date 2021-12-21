Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB90947BDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhLUKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLUKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:09:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA463C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F2sWiLdVaTU2UfCA+OQuYx6IHrl1SC636xPUqV8dk7w=; b=SJdY76sAKdHt7nmGZGMHbqMz3u
        lx/lo4NauNhOSPFEvbR2R+6useWpYfyn1FEfbw/2LTbZdFmL06r6h9k8SMoYgZM2LkpWQhQz1FWef
        S0xFmqG1xhZhze8ic2r1nlIYxwWnYeZaiEW7xBmmtQzwA3gzltJlKBmjgTdwRaXmUdosYE++jMLRl
        KVSlut2YV7KVvLMJ8wzutHY/V7buOsvZZIty7hlJGfA2e4UMTVXdjhC/wDKOl3IwcuAghA7XtFy+2
        OO0tjGHXnqQZJZ/F5envHtHTonCOpmIw8KItGe5jw24QgJ+ZpWG6Ns9K37mN8ezeWiGgC4vB9nDUo
        r/Domgog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzc4s-002N0W-0I; Tue, 21 Dec 2021 10:09:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C474C3002BE;
        Tue, 21 Dec 2021 11:09:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A414E302328C3; Tue, 21 Dec 2021 11:09:00 +0100 (CET)
Date:   Tue, 21 Dec 2021 11:09:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     xuhaifeng <xuhaifeng@oppo.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] sched: optimize __cond_resched_lock()
Message-ID: <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
References: <20211221072316.42-1-xuhaifeng@oppo.com>
 <YcGVzClid/7q3DuB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGVzClid/7q3DuB@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:52:28AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 21, 2021 at 03:23:16PM +0800, xuhaifeng wrote:
> > if the kernel is preemptible(CONFIG_PREEMPTION=y), schedule()may be
> > called twice, once via spin_unlock, once via preempt_schedule_common.
> > 
> > we can add one conditional, check TIF_NEED_RESCHED flag again,
> > to avoid this.
> 
> You can also make it more similar to __cond_resched() instead of making
> it more different.

Bah, sorry, had to wake up first :/

cond_resched_lock still needs to exist for PREEMPT because locks won't
magically release themselves.

Still don't much like the patch though, how's this work for you?

That's arguably the right thing to do work PREEMPT_DYNAMIC too.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f95a1ea..79d3d5e15c4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8192,6 +8192,11 @@ int __sched __cond_resched(void)
 	return 0;
 }
 EXPORT_SYMBOL(__cond_resched);
+#else
+static inline int __cond_resched(void)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
@@ -8219,9 +8224,7 @@ int __cond_resched_lock(spinlock_t *lock)
 
 	if (spin_needbreak(lock) || resched) {
 		spin_unlock(lock);
-		if (resched)
-			preempt_schedule_common();
-		else
+		if (!__cond_resched())
 			cpu_relax();
 		ret = 1;
 		spin_lock(lock);
@@ -8239,9 +8242,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)
 
 	if (rwlock_needbreak(lock) || resched) {
 		read_unlock(lock);
-		if (resched)
-			preempt_schedule_common();
-		else
+		if (!__cond_resched())
 			cpu_relax();
 		ret = 1;
 		read_lock(lock);
@@ -8259,9 +8260,7 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 
 	if (rwlock_needbreak(lock) || resched) {
 		write_unlock(lock);
-		if (resched)
-			preempt_schedule_common();
-		else
+		if (!__cond_resched())
 			cpu_relax();
 		ret = 1;
 		write_lock(lock);
