Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F764DB590
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244990AbiCPQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiCPQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:04:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBE4EA2D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:03:16 -0700 (PDT)
Date:   Wed, 16 Mar 2022 17:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647446594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQRxvCGWz5JjZ5mxKrBGw2/uRU2quWW8b9gTuwsLi08=;
        b=zUJ/PTUFN88JQUjr3/q4NVB3+mFVpG94J5I6ycNIA6tKPg9nBZU/6cmeURuXEBErmMWUn9
        7HI1j6HhpRySNlEWGVqTnnr4eOR/Ongjo7fp1As/aFz4BkNcskVNP3ZHzWnYPrkGZbkbpR
        83Rfywiflvfns7lZAwmuc1AYzG8MQ/s41W912TH5nniE7f7rTsXnYGCJ3xhqcGr0UCb4Qk
        6MD7SgedyJQ+0Qeq1LElF5SRTmfrEH2aI+EPEMrrGpIuDNVa0AU7PP7lwAPrFr9w8Z2js6
        jMq1jSsZLcoPy26nEG8r3nAym+4u6lF1VknXxn9SBxltjv63ZotBAMQN8qFD/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647446594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQRxvCGWz5JjZ5mxKrBGw2/uRU2quWW8b9gTuwsLi08=;
        b=NWoxNFiv9Oc5+egiMdKxzZhIjMZZhmDoCwajc6mvhC2fgIuvYmJEL3BjPaudKIF1tLO9m4
        mhTED40dYRHizDBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <YjIKQBIbJR/kRR+N@linutronix.de>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315174606.02959816@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-15 17:46:06 [-0400], Steven Rostedt wrote:
> On Tue, 8 Mar 2022 16:14:55 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Peter,
> 
> Have you had time to look into this?

yes, I can confirm that it is a problem ;) So I did this:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 33ce5cd113d8..56c286aaa01f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5950,7 +5950,6 @@ static bool try_steal_cookie(int this, int that)
 	unsigned long cookie;
 	bool success = false;
 
-	local_irq_disable();
 	double_rq_lock(dst, src);
 
 	cookie = dst->core->core_cookie;
@@ -5989,7 +5988,6 @@ static bool try_steal_cookie(int this, int that)
 
 unlock:
 	double_rq_unlock(dst, src);
-	local_irq_enable();
 
 	return success;
 }
@@ -6019,7 +6017,7 @@ static void sched_core_balance(struct rq *rq)
 
 	preempt_disable();
 	rcu_read_lock();
-	raw_spin_rq_unlock_irq(rq);
+	raw_spin_rq_unlock(rq);
 	for_each_domain(cpu, sd) {
 		if (need_resched())
 			break;
@@ -6027,7 +6025,7 @@ static void sched_core_balance(struct rq *rq)
 		if (steal_cookie_task(cpu, sd))
 			break;
 	}
-	raw_spin_rq_lock_irq(rq);
+	raw_spin_rq_lock(rq);
 	rcu_read_unlock();
 	preempt_enable();
 }


which looked right but RT still fall apart:

| =====================================
| WARNING: bad unlock balance detected!
| 5.17.0-rc8-rt14+ #10 Not tainted
| -------------------------------------
| gcc/2608 is trying to release lock ((lock)) at:
| [<ffffffff8135a150>] folio_add_lru+0x60/0x90
| but there are no more locks to release!
| 
| other info that might help us debug this:
| 4 locks held by gcc/2608:
|  #0: ffff88826ea6efe0 (&sb->s_type->i_mutex_key#12){++++}-{3:3}, at: xfs_ilock+0x90/0xd0
|  #1: ffff88826ea6f1a0 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0x8e/0x1f0
|  #2: ffff88852aba8d18 ((lock)#3){+.+.}-{2:2}, at: folio_add_lru+0x2a/0x90
|  #3: ffffffff829a5140 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xe0
| 
| stack backtrace:
| CPU: 18 PID: 2608 Comm: gcc Not tainted 5.17.0-rc8-rt14+ #10
| Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.03.0003.041920141333 04/19/2014
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x4a/0x62
|  lock_release.cold+0x32/0x37
|  rt_spin_unlock+0x17/0x80
|  folio_add_lru+0x60/0x90
|  filemap_add_folio+0x53/0xa0
|  page_cache_ra_unbounded+0x1c3/0x1f0
|  filemap_get_pages+0xe3/0x5b0
|  filemap_read+0xc5/0x2f0
|  xfs_file_buffered_read+0x6b/0x1a0
|  xfs_file_read_iter+0x6a/0xd0
|  new_sync_read+0x11b/0x1a0
|  vfs_read+0x134/0x1d0
|  ksys_read+0x68/0xf0
|  do_syscall_64+0x59/0x80
|  entry_SYSCALL_64_after_hwframe+0x44/0xae
| RIP: 0033:0x7f3feab7310e

It is always the local-lock that is breaks apart. Based on "locks held"
and the lock it tries to release it looks like the lock was acquired on
CPU-A and released on CPU-B.

> Thanks,
> 
> -- Steve

Sebastian
