Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7B527422
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiENVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiENVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:15:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE52528F
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so10650279pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbacUb/8Hop+8HY0uMaEXIzDZG6uvUIx7QD/1JQmDMU=;
        b=J2ioqshjtQY9YBMOrvonYP6wBvdQurdYMfPn1MZJRoE7lIXtA03vhTpqJPuXal/mBX
         Tqssy10gw1amxOByv/iTxGxRpAO/M2ian4G2zMBJA0Q1lUhOGabXPx7gkU0wE1rX96Cy
         6QDHD8rFYeh7Zkf+ZHc2B/BegF/PpZ82zyjevBgguCGjBTKoqotT12HepKQP01Xu5/GL
         7i28/7XMgnIgJbJXnJh4o2ayAgJuQYxrgg/8K6U47YexVfVsObh7OQF1K9i0+/P3QXff
         CpuzLcirm/GXD+mCREqnVWLM1Giz4TnZMh6cS7uej7dD91TNWiFwhA1Kq0q21YJOIbXB
         FiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbacUb/8Hop+8HY0uMaEXIzDZG6uvUIx7QD/1JQmDMU=;
        b=aZP09/OByGNgTMlyoIuqfPtB+gDHQbBRk9y1oWpMl3dEa8N9D5dva+WkEGJAI7kHEX
         mr2YqUZVujxmtOLY+cx7XkBl3U0HRHWLnLH5/MB3KysBHG8EKQZjaKPwa84WhoEuY7yt
         KU232spdxu3YoZvFgJUSug7LAOAKFy2z+jM2bVpHh5ae6KAltWzFvwxFsCKjQkPDErun
         OlG9T27K3xkmcfkBwp7b3oajmyGtpeRLKjJHFnnDiiWqazTwyMbjzFfUOKacASPWAQ80
         87DOYgh6pNERpX89hHR6yLTwP4qDY6niBJ6LO1JQw+fSYDXXNwEk8zqjBREzoki70Xxh
         MLNA==
X-Gm-Message-State: AOAM531nbk5tVSPb6Xogh0nFT4XdubEylg4F+2Kokikc2CjCxUn3d7Y5
        TL8347oO4My/dfGR1IyWcjk=
X-Google-Smtp-Source: ABdhPJyVf3OqGCUG4MomsOXVMoCaTpkZQQ4RUCW5DOme54k2QcpO1RqiNzZj9bAA2IY1YH+ImHqt7A==
X-Received: by 2002:a05:6a00:1806:b0:510:9f7a:61ff with SMTP id y6-20020a056a00180600b005109f7a61ffmr10807404pfa.15.1652562930670;
        Sat, 14 May 2022 14:15:30 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id e35-20020a635023000000b003db141a5f26sm3826825pgb.1.2022.05.14.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:15:30 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, paul@paul-moore.com,
        eparis@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        yesshedi@gmail.com, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 5/5] audit: fix most of the checkspec.pl warnnings & errors
Date:   Sun, 15 May 2022 02:44:55 +0530
Message-Id: <20220514211455.284782-5-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514211455.284782-1-sshedi@vmware.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 kernel/audit.c | 205 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 127 insertions(+), 78 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 0749211d5552..b3a5f65ee357 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -26,7 +26,7 @@
  *	     information that must be passed to user-space.
  *
  * Audit userspace, documentation, tests, and bug/issue trackers:
- * 	https://github.com/linux-audit
+ *	https://github.com/linux-audit
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -62,16 +62,19 @@
 
 #include "audit.h"
 
-/* No auditing will take place until audit_initialized == AUDIT_INITIALIZED.
- * (Initialization happens after skb_init is called.) */
+/*
+ * No auditing will take place until audit_initialized == AUDIT_INITIALIZED.
+ * (Initialization happens after skb_init is called.)
+ */
 #define AUDIT_DISABLED		-1
 #define AUDIT_UNINITIALIZED	0
 #define AUDIT_INITIALIZED	1
+
 static int	audit_initialized = AUDIT_UNINITIALIZED;
 
-u32		audit_enabled = AUDIT_OFF;
 bool		audit_ever_enabled = !!AUDIT_OFF;
 
+u32		audit_enabled = AUDIT_OFF;
 EXPORT_SYMBOL_GPL(audit_enabled);
 
 /* Default state when kernel boots without any parameters. */
@@ -111,13 +114,17 @@ struct auditd_connection {
 static struct auditd_connection __rcu *auditd_conn;
 static DEFINE_SPINLOCK(auditd_conn_lock);
 
-/* If audit_rate_limit is non-zero, limit the rate of sending audit records
+/*
+ * If audit_rate_limit is non-zero, limit the rate of sending audit records
  * to that number per second.  This prevents DoS attacks, but results in
- * audit records being dropped. */
+ * audit records being dropped.
+ */
 static u32	audit_rate_limit;
 
-/* Number of outstanding audit_buffers allowed.
- * When set to zero, this means unlimited. */
+/*
+ * Number of outstanding audit_buffers allowed.
+ * When set to zero, this means unlimited.
+ */
 static u32	audit_backlog_limit = 64;
 #define AUDIT_BACKLOG_WAIT_TIME (60 * HZ)
 static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
@@ -127,13 +134,14 @@ static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
 static u32		audit_sig_sid;
 
-/* Records can be lost in several ways:
-   0) [suppressed in audit_alloc]
-   1) out of memory in audit_log_start [kmalloc of struct audit_buffer]
-   2) out of memory in audit_log_move [alloc_skb]
-   3) suppressed due to audit_rate_limit
-   4) suppressed due to audit_backlog_limit
-*/
+/*
+ * Records can be lost in several ways:
+ * 0) [suppressed in audit_alloc]
+ * 1) out of memory in audit_log_start [kmalloc of struct audit_buffer]
+ * 2) out of memory in audit_log_move [alloc_skb]
+ * 3) suppressed due to audit_rate_limit
+ * 4) suppressed due to audit_backlog_limit
+ */
 static atomic_t	audit_lost = ATOMIC_INIT(0);
 
 /* Monotonically increasing sum of time the kernel has spent
@@ -186,16 +194,20 @@ static struct audit_ctl_mutex {
 	void *owner;
 } audit_cmd_mutex;
 
-/* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
+/*
+ * AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
  * audit records.  Since printk uses a 1024 byte buffer, this buffer
- * should be at least that large. */
+ * should be at least that large.
+ */
 #define AUDIT_BUFSIZ 1024
 
-/* The audit_buffer is used when formatting an audit record.  The caller
+/*
+ * The audit_buffer is used when formatting an audit record.  The caller
  * locks briefly to get the record off the freelist or to allocate the
  * buffer, and locks briefly to send the buffer to the netlink layer or
  * to place it on a transmit queue.  Multiple audit_buffers can be in
- * use simultaneously. */
+ * use simultaneously.
+ */
 struct audit_buffer {
 	struct sk_buff       *skb;	/* formatted skb ready to send */
 	struct audit_context *ctx;	/* NULL or associated context */
@@ -305,8 +317,7 @@ void audit_panic(const char *message)
 	case AUDIT_FAIL_SILENT:
 		break;
 	case AUDIT_FAIL_PRINTK:
-		if (printk_ratelimit())
-			pr_err("%s\n", message);
+		pr_err_ratelimited("%s\n", message);
 		break;
 	case AUDIT_FAIL_PANIC:
 		panic("audit: %s\n", message);
@@ -316,15 +327,16 @@ void audit_panic(const char *message)
 
 static inline int audit_rate_check(void)
 {
-	static unsigned long	last_check = 0;
-	static int		messages   = 0;
+	static unsigned long	last_check;
+	static int		messages;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
 	unsigned long		elapsed;
-	int			retval	   = 0;
+	int			retval = 0;
 
-	if (!audit_rate_limit) return 1;
+	if (!audit_rate_limit)
+		return 1;
 
 	spin_lock_irqsave(&lock, flags);
 	if (++messages < audit_rate_limit) {
@@ -350,10 +362,10 @@ static inline int audit_rate_check(void)
  * Emit at least 1 message per second, even if audit_rate_check is
  * throttling.
  * Always increment the lost messages counter.
-*/
+ */
 void audit_log_lost(const char *message)
 {
-	static unsigned long	last_msg = 0;
+	static unsigned long	last_msg;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
@@ -374,11 +386,10 @@ void audit_log_lost(const char *message)
 	}
 
 	if (print) {
-		if (printk_ratelimit())
-			pr_warn("audit_lost=%u audit_rate_limit=%u audit_backlog_limit=%u\n",
-				atomic_read(&audit_lost),
-				audit_rate_limit,
-				audit_backlog_limit);
+		pr_warn_ratelimited("audit_lost=%u audit_rate_limit=%u audit_backlog_limit=%u\n",
+			atomic_read(&audit_lost),
+			audit_rate_limit,
+			audit_backlog_limit);
 		audit_panic(message);
 	}
 }
@@ -447,6 +458,7 @@ static int audit_set_backlog_wait_time(u32 timeout)
 static int audit_set_enabled(u32 state)
 {
 	int rc;
+
 	if (state > AUDIT_LOCKED)
 		return -EINVAL;
 
@@ -534,8 +546,8 @@ static void kauditd_printk_skb(struct sk_buff *skb)
 	struct nlmsghdr *nlh = nlmsg_hdr(skb);
 	char *data = nlmsg_data(nlh);
 
-	if (nlh->nlmsg_type != AUDIT_EOE && printk_ratelimit())
-		pr_notice("type=%d %s\n", nlh->nlmsg_type, data);
+	if (nlh->nlmsg_type != AUDIT_EOE)
+		pr_notice_ratelimited("type=%d %s\n", nlh->nlmsg_type, data);
 }
 
 /**
@@ -568,8 +580,10 @@ static void kauditd_rehold_skb(struct sk_buff *skb, __always_unused int error)
  */
 static void kauditd_hold_skb(struct sk_buff *skb, int error)
 {
-	/* at this point it is uncertain if we will ever send this to auditd so
-	 * try to send the message via printk before we go any further */
+	/*
+	 * at this point it is uncertain if we will ever send this to auditd so
+	 * try to send the message via printk before we go any further
+	 */
 	kauditd_printk_skb(skb);
 
 	/* can we just silently drop the message? */
@@ -659,8 +673,10 @@ static void auditd_reset(const struct auditd_connection *ac)
 	if (ac_old)
 		call_rcu(&ac_old->rcu, auditd_conn_free);
 
-	/* flush the retry queue to the hold queue, but don't touch the main
-	 * queue since we need to process that normally for multicast */
+	/*
+	 * flush the retry queue to the hold queue, but don't touch the main
+	 * queue since we need to process that normally for multicast
+	 */
 	while ((skb = skb_dequeue(&audit_retry_queue)))
 		kauditd_hold_skb(skb, -ECONNREFUSED);
 }
@@ -684,12 +700,14 @@ static int auditd_send_unicast_skb(struct sk_buff *skb)
 	struct sock *sk;
 	struct auditd_connection *ac;
 
-	/* NOTE: we can't call netlink_unicast while in the RCU section so
+	/*
+	 * NOTE: we can't call netlink_unicast while in the RCU section so
 	 *       take a reference to the network namespace and grab local
 	 *       copies of the namespace, the sock, and the portid; the
 	 *       namespace and sock aren't going to go away while we hold a
 	 *       reference and if the portid does become invalid after the RCU
-	 *       section netlink_unicast() should safely return an error */
+	 *       section netlink_unicast() should safely return an error
+	 */
 
 	rcu_read_lock();
 	ac = rcu_dereference(auditd_conn);
@@ -743,8 +761,10 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 	struct sk_buff *skb_tail;
 	unsigned int failed = 0;
 
-	/* NOTE: kauditd_thread takes care of all our locking, we just use
-	 *       the netlink info passed to us (e.g. sk and portid) */
+	/*
+	 * NOTE: kauditd_thread takes care of all our locking, we just use
+	 *       the netlink info passed to us (e.g. sk and portid)
+	 */
 
 	skb_tail = skb_peek_tail(queue);
 	while ((skb != skb_tail) && (skb = skb_dequeue(queue))) {
@@ -801,8 +821,10 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
 	struct sock *sock = audit_get_sk(&init_net);
 	struct nlmsghdr *nlh;
 
-	/* NOTE: we are not taking an additional reference for init_net since
-	 *       we don't have to worry about it going away */
+	/*
+	 * NOTE: we are not taking an additional reference for init_net since
+	 *       we don't have to worry about it going away
+	 */
 
 	if (!netlink_has_listeners(sock, AUDIT_NLGRP_READLOG))
 		return;
@@ -875,10 +897,12 @@ static int kauditd_thread(void *dummy)
 		}
 
 main_queue:
-		/* process the main queue - do the multicast send and attempt
+		/*
+		 * process the main queue - do the multicast send and attempt
 		 * unicast, dump failed record sends to the retry queue; if
 		 * sk == NULL due to previous failures we will just do the
-		 * multicast send and move the record to the hold queue */
+		 * multicast send and move the record to the hold queue
+		 */
 		rc = kauditd_send_queue(sk, portid, &audit_queue, 1,
 					kauditd_send_multicast_skb,
 					(sk ?
@@ -896,10 +920,12 @@ static int kauditd_thread(void *dummy)
 		/* we have processed all the queues so wake everyone */
 		wake_up(&audit_backlog_wait);
 
-		/* NOTE: we want to wake up if there is anything on the queue,
+		/*
+		 * NOTE: we want to wake up if there is anything on the queue,
 		 *       regardless of if an auditd is connected, as we need to
 		 *       do the multicast send and rotate records from the
-		 *       main queue to the retry/hold queues */
+		 *       main queue to the retry/hold queues
+		 */
 		wait_event_freezable(kauditd_wait,
 				     (skb_queue_len(&audit_queue) ? 1 : 0));
 	}
@@ -969,8 +995,10 @@ static int audit_send_reply_thread(void *arg)
 	audit_ctl_lock();
 	audit_ctl_unlock();
 
-	/* Ignore failure. It'll only happen if the sender goes away,
-	   because our timeout is set to infinite. */
+	/*
+	 * Ignore failure. It'll only happen if the sender goes away,
+	 * because our timeout is set to infinite.
+	 */
 	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, 0);
 	reply->skb = NULL;
 	audit_free_reply(reply);
@@ -1054,8 +1082,10 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	case AUDIT_TTY_SET:
 	case AUDIT_TRIM:
 	case AUDIT_MAKE_EQUIV:
-		/* Only support auditd and auditctl in initial pid namespace
-		 * for now. */
+		/*
+		 * Only support auditd and auditctl in initial pid namespace
+		 * for now.
+		 */
 		if (task_active_pid_ns(current) != &init_pid_ns)
 			return -EPERM;
 
@@ -1226,11 +1256,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	switch (msg_type) {
 	case AUDIT_GET: {
 		struct audit_status	s;
+
 		memset(&s, 0, sizeof(s));
 		s.enabled		   = audit_enabled;
 		s.failure		   = audit_failure;
-		/* NOTE: use pid_vnr() so the PID is relative to the current
-		 *       namespace */
+		/*
+		 * NOTE: use pid_vnr() so the PID is relative to the current
+		 *       namespace
+		 */
 		s.pid			   = auditd_pid_vnr();
 		s.rate_limit		   = audit_rate_limit;
 		s.backlog_limit		   = audit_backlog_limit;
@@ -1244,6 +1277,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SET: {
 		struct audit_status	s;
+
 		memset(&s, 0, sizeof(s));
 		/* guard against past and future API changes */
 		memcpy(&s, data, min_t(size_t, sizeof(s), data_len));
@@ -1258,18 +1292,22 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				return err;
 		}
 		if (s.mask & AUDIT_STATUS_PID) {
-			/* NOTE: we are using the vnr PID functions below
+			/*
+			 * NOTE: we are using the vnr PID functions below
 			 *       because the s.pid value is relative to the
 			 *       namespace of the caller; at present this
 			 *       doesn't matter much since you can really only
 			 *       run auditd from the initial pid namespace, but
-			 *       something to keep in mind if this changes */
+			 *       something to keep in mind if this changes
+			 */
 			pid_t new_pid = s.pid;
 			pid_t auditd_pid;
 			struct pid *req_pid = task_tgid(current);
 
-			/* Sanity check - PID values must match. Setting
-			 * pid to 0 is how auditd ends auditing. */
+			/*
+			 * Sanity check - PID values must match. Setting
+			 * pid to 0 is how auditd ends auditing.
+			 */
 			if (new_pid && (new_pid != pid_vnr(req_pid)))
 				return -EINVAL;
 
@@ -1655,11 +1693,13 @@ static void __net_exit audit_net_exit(struct net *net)
 {
 	struct audit_net *aunet = net_generic(net, audit_net_id);
 
-	/* NOTE: you would think that we would want to check the auditd
+	/*
+	 * NOTE: you would think that we would want to check the auditd
 	 * connection and potentially reset it here if it lives in this
 	 * namespace, but since the auditd connection tracking struct holds a
 	 * reference to this namespace (see auditd_set()) we are only ever
-	 * going to get here after that connection has been released */
+	 * going to get here after that connection has been released
+	 */
 
 	netlink_kernel_release(aunet->sk);
 }
@@ -1702,6 +1742,7 @@ static int __init audit_init(void)
 	kauditd_task = kthread_run(kauditd_thread, NULL, "kauditd");
 	if (IS_ERR(kauditd_task)) {
 		int err = PTR_ERR(kauditd_task);
+
 		panic("audit: failed to start the kauditd thread (%d)\n", err);
 	}
 
@@ -1741,21 +1782,23 @@ static int __init audit_enable(char *str)
 }
 __setup("audit=", audit_enable);
 
-/* Process kernel command-line parameter at boot time.
- * audit_backlog_limit=<n> */
+/*
+ * Process kernel command-line parameter at boot time.
+ * audit_backlog_limit=<n>
+ */
 static int __init audit_backlog_limit_set(char *str)
 {
 	u32 audit_backlog_limit_arg;
 
 	pr_info("audit_backlog_limit: ");
 	if (kstrtouint(str, 0, &audit_backlog_limit_arg)) {
-		pr_cont("using default of %u, unable to parse %s\n",
+		pr_info("using default of %u, unable to parse %s\n",
 			audit_backlog_limit, str);
 		return 1;
 	}
 
 	audit_backlog_limit = audit_backlog_limit_arg;
-	pr_cont("%d\n", audit_backlog_limit);
+	pr_info("%d\n", audit_backlog_limit);
 
 	return 1;
 }
@@ -1873,8 +1916,10 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 			/* wake kauditd to try and flush the queue */
 			wake_up_interruptible(&kauditd_wait);
 
-			/* sleep if we are allowed and we haven't exhausted our
-			 * backlog wait limit */
+			/*
+			 * sleep if we are allowed and we haven't exhausted our
+			 * backlog wait limit
+			 */
 			if (gfpflags_allow_blocking(gfp_mask) && (stime > 0)) {
 				long rtime = stime;
 
@@ -1887,8 +1932,8 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				atomic_add(rtime - stime, &audit_backlog_wait_time_actual);
 				remove_wait_queue(&audit_backlog_wait, &wait);
 			} else {
-				if (audit_rate_check() && printk_ratelimit())
-					pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
+				if (audit_rate_check())
+					pr_warn_ratelimited("audit_backlog=%d > audit_backlog_limit=%d\n",
 						skb_queue_len(&audit_queue),
 						audit_backlog_limit);
 				audit_log_lost("backlog limit exceeded");
@@ -1912,6 +1957,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 
 	return ab;
 }
+EXPORT_SYMBOL(audit_log_start);
 
 /**
  * audit_expand - expand skb in the audit buffer
@@ -1964,11 +2010,13 @@ static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
 	va_copy(args2, args);
 	len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
 	if (len >= avail) {
-		/* The printk buffer is 1024 bytes long, so if we get
+		/*
+		 * The printk buffer is 1024 bytes long, so if we get
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
-		 * log everything that printk could have logged. */
+		 * log everything that printk could have logged.
+		 */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
@@ -1999,6 +2047,7 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 	audit_log_vformat(ab, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL(audit_log_format);
 
 /**
  * audit_log_n_hex - convert a buffer to hex and append it to the audit skb
@@ -2080,6 +2129,7 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 bool audit_string_contains_control(const char *string, size_t len)
 {
 	const unsigned char *p;
+
 	for (p = string; p < (const unsigned char *)string + len; p++) {
 		if (*p == '"' || *p < 0x21 || *p > 0x7e)
 			return true;
@@ -2167,7 +2217,7 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	char *ctx = NULL;
-	unsigned len;
+	unsigned int len;
 	int error;
 	u32 sid;
 
@@ -2419,8 +2469,10 @@ void audit_log_end(struct audit_buffer *ab)
 		skb = ab->skb;
 		ab->skb = NULL;
 
-		/* setup the netlink header, see the comments in
-		 * kauditd_send_multicast_skb() for length quirks */
+		/*
+		 * setup the netlink header, see the comments in
+		 * kauditd_send_multicast_skb() for length quirks
+		 */
 		nlh = nlmsg_hdr(skb);
 		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
 
@@ -2432,6 +2484,7 @@ void audit_log_end(struct audit_buffer *ab)
 
 	audit_buffer_free(ab);
 }
+EXPORT_SYMBOL(audit_log_end);
 
 /**
  * audit_log - Log an audit record
@@ -2459,8 +2512,4 @@ void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 		audit_log_end(ab);
 	}
 }
-
-EXPORT_SYMBOL(audit_log_start);
-EXPORT_SYMBOL(audit_log_end);
-EXPORT_SYMBOL(audit_log_format);
 EXPORT_SYMBOL(audit_log);
-- 
2.36.1

