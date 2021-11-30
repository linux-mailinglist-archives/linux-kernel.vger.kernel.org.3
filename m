Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B747E4639EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbhK3PZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbhK3PX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:23:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485ECC061758;
        Tue, 30 Nov 2021 07:19:52 -0800 (PST)
Date:   Tue, 30 Nov 2021 16:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638285590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=huhqqQ6aPlu7OI6jwnrY6vD7d4TkAxnl2p24+pNEuUU=;
        b=ZC8rgq2G5370za6U5RlfBo2ey0JN5Hty9JhrX4KG8vKvcR44VVPJI7BnIXI999L/EazjDw
        dIRNTCHFEUeOo0T5jxRUMU5onyW73dRVCsbYWkR6BOfmDTW9iTtfTYHb6mb+FTdJOdmNFf
        3w7kF3EW457ahUjwIah+V9Eb9gUUsIEa5nVdsNg6K13RG0QodsIFkrRHkCrWxK7RPqFeK7
        cc/81CUU/2IHuq2yAj+bKANRyw6CsySf+EAVAq5VRECnMnmr4X9T9e7FraUHqaoP+TL7wM
        DaqEf4TSEBqOHW+L0UgrnUCFY7zAUmDZrRJgRTBMbgx6HU4LXmZ29c1hbAFWFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638285590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=huhqqQ6aPlu7OI6jwnrY6vD7d4TkAxnl2p24+pNEuUU=;
        b=hrM9KEi5mdPG2k0Nopzi6ObZXOA2J59gbUYsaDneDHJb8i1OeVPsgZKohUVnMMmRRZ7rSL
        rXdIJzaMlx+B9xBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rc3-rt6
Message-ID: <20211130151948.fr3ibct5nmxdigkf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rc3-rt6 patch set. 

Changes since v5.16-rc3-rt5:

  - ARM64 implemented HAVE_POSIX_CPU_TIMERS_TASK_WORK and it is now
    possible to enable KVM and PREEMPT_RT. Patch by Nicolas Saenz
    Julienne

  - Backport two patches from upstream to avoid scheduling ksoftirqd
    from a workqueue while completing mmc requests.

  - Replace a patch from lockdep series with a suggestion from Peter
    Zijlstra.

  - Don't acquire dev_base_lock with disabled bottom halves to avoid
    lockdep complaint on PREEMPT_RT. Reported by Pei Zhang and Luis
    Claudio R. Goncalves.

  - Dress a networking patch regarding inet_listen_hashbucket::lock
    differently so it looks better.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16-rc3-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16-rc3-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rc3-rt6

The RT patch against v5.16-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rc3-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rc3-rt6.tar.xz

Sebastian

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6bd4acc2be02f..260866cf53c95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,7 +89,7 @@ config ARM64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
-	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select ARCH_SUPPORTS_RT
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
@@ -216,7 +216,6 @@ config ARM64
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_SYSCALL if PCI
-	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
 	select POWER_RESET
 	select POWER_SUPPLY
 	select SPARSE_IRQ
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 90e1bcd03b46c..52309b84be888 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2051,7 +2051,8 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 		mmc_put_card(mq->card, &mq->ctx);
 }
 
-static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
+				bool can_sleep)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
@@ -2063,10 +2064,14 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
 	 */
-	if (mq->in_recovery)
+	if (mq->in_recovery) {
 		mmc_blk_mq_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
-		blk_mq_complete_request(req);
+	} else if (likely(!blk_should_fake_timeout(req->q))) {
+		if (can_sleep)
+			blk_mq_complete_request_direct(req, mmc_blk_mq_complete);
+		else
+			blk_mq_complete_request(req);
+	}
 
 	mmc_blk_mq_dec_in_flight(mq, req);
 }
@@ -2087,7 +2092,7 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq)
 
 	mmc_blk_urgent_bkops(mq, mqrq);
 
-	mmc_blk_mq_post_req(mq, req);
+	mmc_blk_mq_post_req(mq, req, true);
 }
 
 static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
@@ -2106,7 +2111,7 @@ static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
 	if (prev_req)
 		*prev_req = mq->complete_req;
 	else
-		mmc_blk_mq_post_req(mq, mq->complete_req);
+		mmc_blk_mq_post_req(mq, mq->complete_req, true);
 
 	mq->complete_req = NULL;
 
@@ -2178,7 +2183,8 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 	mq->rw_wait = false;
 	wake_up(&mq->wait);
 
-	mmc_blk_mq_post_req(mq, req);
+	/* context unknown */
+	mmc_blk_mq_post_req(mq, req, false);
 }
 
 static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
@@ -2238,7 +2244,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
 	err = mmc_start_request(host, &mqrq->brq.mrq);
 
 	if (prev_req)
-		mmc_blk_mq_post_req(mq, prev_req);
+		mmc_blk_mq_post_req(mq, prev_req, true);
 
 	if (err)
 		mq->rw_wait = false;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2949d9ac74849..131b45dfec674 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -752,6 +752,17 @@ static inline void blk_mq_set_request_complete(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 }
 
+/*
+ * Complete the request directly instead of deferring it to softirq or
+ * completing it another CPU. Useful in preemptible instead of an interrupt.
+ */
+static inline void blk_mq_complete_request_direct(struct request *rq,
+		   void (*complete)(struct request *rq))
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	complete(rq);
+}
+
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5e19fe7dda4c5..f89620852774d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1103,27 +1103,12 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 * the other will detect the deadlock and return -EDEADLOCK,
 	 * which is wrong, as the other waiter is not in a deadlock
 	 * situation.
+	 *
+	 * Except for ww_mutex, in that case the chain walk must already deal
+	 * with spurious cycles, see the comments at [3] and [6].
 	 */
-	if (owner == task) {
-#if defined(DEBUG_WW_MUTEXES) && defined(CONFIG_DEBUG_LOCKING_API_SELFTESTS)
-		/*
-		 * The lockdep selftest for ww-mutex assumes in a few cases
-		 * the ww_ctx->contending_lock assignment via
-		 * __ww_mutex_check_kill() which does not happen if the rtmutex
-		 * detects the deadlock early.
-		 */
-		if (build_ww_mutex() && ww_ctx) {
-			struct rt_mutex *rtm;
-
-			/* Check whether the waiter should backout immediately */
-			rtm = container_of(lock, struct rt_mutex, rtmutex);
-
-			__ww_mutex_add_waiter(waiter, rtm, ww_ctx);
-			__ww_mutex_check_kill(rtm, waiter, ww_ctx);
-		}
-#endif
+	if (owner == task && !(build_ww_mutex() && ww_ctx))
 		return -EDEADLK;
-	}
 
 	raw_spin_lock(&task->pi_lock);
 	waiter->task = task;
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
diff --git a/net/core/dev.c b/net/core/dev.c
index 8b5cf8ad859b5..ad3cccbfa573b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -371,12 +371,12 @@ static void list_netdevice(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
 	netdev_name_node_add(net, dev->name_node);
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(net);
 }
@@ -389,11 +389,11 @@ static void unlist_netdevice(struct net_device *dev)
 	ASSERT_RTNL();
 
 	/* Unlink dev from the device chain */
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	list_del_rcu(&dev->dev_list);
 	netdev_name_node_del(dev->name_node);
 	hlist_del_rcu(&dev->index_hlist);
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(dev_net(dev));
 }
@@ -1272,15 +1272,15 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	netdev_adjacent_rename_links(dev, oldname);
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	netdev_name_node_del(dev->name_node);
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	synchronize_rcu();
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	netdev_name_node_add(net, dev->name_node);
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
 	ret = notifier_to_errno(ret);
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 1a455847da54f..9599afd0862da 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -55,7 +55,7 @@ static void rfc2863_policy(struct net_device *dev)
 	if (operstate == dev->operstate)
 		return;
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 
 	switch(dev->link_mode) {
 	case IF_LINK_MODE_TESTING:
@@ -74,7 +74,7 @@ static void rfc2863_policy(struct net_device *dev)
 
 	dev->operstate = operstate;
 
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 }
 
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2af8aeeadadf0..716be2f88cd75 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -842,9 +842,9 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 	}
 
 	if (dev->operstate != operstate) {
-		write_lock_bh(&dev_base_lock);
+		write_lock(&dev_base_lock);
 		dev->operstate = operstate;
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	}
 }
@@ -2779,11 +2779,11 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_LINKMODE]) {
 		unsigned char value = nla_get_u8(tb[IFLA_LINKMODE]);
 
-		write_lock_bh(&dev_base_lock);
+		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
 		dev->link_mode = value;
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 	}
 
 	if (tb[IFLA_VFINFO_LIST]) {
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 737e4f17e1c6d..e57fdad9ef942 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -30,13 +30,13 @@ static bool is_slave_up(struct net_device *dev)
 
 static void __hsr_set_operstate(struct net_device *dev, int transition)
 {
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	if (dev->operstate != transition) {
 		dev->operstate = transition;
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	} else {
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 	}
 }
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e460c84b1f8e4..7bd1e10086f0a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -678,41 +678,47 @@ int inet_hash(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_hash);
 
-void inet_unhash(struct sock *sk)
+static void __inet_unhash(struct sock *sk, struct inet_listen_hashbucket *ilb)
 {
-	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-	struct inet_listen_hashbucket *ilb = NULL;
-	spinlock_t *lock;
-	bool state_listen;
-
 	if (sk_unhashed(sk))
 		return;
 
-	if (sk->sk_state == TCP_LISTEN) {
-		state_listen = true;
-		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
-		spin_lock(&ilb->lock);
-	} else {
-		state_listen = false;
-		lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
-		spin_lock_bh(lock);
-	}
-	if (sk_unhashed(sk))
-		goto unlock;
-
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_stop_listen_sock(sk);
 	if (ilb) {
+		struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
+
 		inet_unhash2(hashinfo, sk);
 		ilb->count--;
 	}
 	__sk_nulls_del_node_init_rcu(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-unlock:
-	if (state_listen)
+}
+
+void inet_unhash(struct sock *sk)
+{
+	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
+
+	if (sk_unhashed(sk))
+		return;
+
+	if (sk->sk_state == TCP_LISTEN) {
+		struct inet_listen_hashbucket *ilb;
+
+		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
+		/* Don't disable bottom halves while acquiring the lock to
+		 * avoid circular locking dependency on PREEMPT_RT.
+		 */
+		spin_lock(&ilb->lock);
+		__inet_unhash(sk, ilb);
 		spin_unlock(&ilb->lock);
-	else
+	} else {
+		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
+
+		spin_lock_bh(lock);
+		__inet_unhash(sk, NULL);
 		spin_unlock_bh(lock);
+	}
 }
 EXPORT_SYMBOL_GPL(inet_unhash);
 
