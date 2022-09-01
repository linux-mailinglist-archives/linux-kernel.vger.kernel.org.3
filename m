Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0A5AA2BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiIAWSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiIAWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E665809E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cb8so280900qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sbbotK/X6hyBCxf4X8eHnMZLe8+ikwZ/eJHvPr5PB5Y=;
        b=kPA5Qz5YkoMPW7SkgX+l0Ko5jkDfQyr3bsOZBOyAN8nMIw0Iw9j1I6H4sdDZvxhdxW
         7wsvjTl8ccTmCT2hpTRxUIQlxHTAEhDAge3obd9j18OBY9X0NXJOi3EOnRakNGRSgOXu
         1ZyJ9+IgAB/0g4Y3K5cwMXnAb9TFR59cfhq4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sbbotK/X6hyBCxf4X8eHnMZLe8+ikwZ/eJHvPr5PB5Y=;
        b=fVUbaOyGT1Dzoc1g+U7qYNs35r1V6+kEtkfIEzqAh8m/kEYrkndGBX0VFFKSE0OjRW
         CzV6FbV1ZMZFHRihIe0m+tRJ/RKXtq07182E6VwSCsCbIvkjw2CsxXBf6crOBXT2Cdmv
         bUpkB+TqLTKfFhItMrqOc57KJ7a22usJVTVoE09G7AiGz/nFCUZDw0d5IeKCKBURd6XT
         d3Pbqe8yCjMY52pUVya7Bguq3kv2LErgH++HitXXYIt9PPxM+aTge8L/ZFSiXg67r6II
         4zv9rCL+Ab1ka09S3VEfz9tWwRI6Q3fELU25ckjSVRCniyiEcC6dkiRTtOcQ/vCJvBAG
         3HLA==
X-Gm-Message-State: ACgBeo3eia4Sr05qb6SXJQHuxUeKP4iGE3xneBfWV8PE2BIg4pUvl5Ut
        Jp2J+xKsrzYJUaKZpLOKrnjtSQ==
X-Google-Smtp-Source: AA6agR6KszQ19UJa+Vd0R4VFnWWwwBVRqP48H2wjT6CRlwWeihtQuS7Q4n4Mfo+Tvf1h2BWMZDzvKA==
X-Received: by 2002:a05:622a:143:b0:344:95bf:8f02 with SMTP id v3-20020a05622a014300b0034495bf8f02mr24705082qtw.202.1662070683012;
        Thu, 01 Sep 2022 15:18:03 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and invocation.
Date:   Thu,  1 Sep 2022 22:17:10 +0000
Message-Id: <20220901221720.1105021-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very useful to debug whether call_rcu_lazy() is working
correctly. In the future, any BPF tools could also be modified to read
the new information.

The additional tracing is enabled by a new CONFIG_RCU_TRACE_CB and is
kept disabled by default.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/types.h      | 44 ++++++++++++++++++++++++
 include/trace/events/rcu.h | 69 +++++++++++++++++++++++++++++++++++---
 kernel/rcu/Kconfig         | 11 ++++++
 kernel/rcu/rcu_segcblist.c | 21 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  8 +++++
 kernel/rcu/tree.c          | 46 +++++++++++++++++++++++--
 kernel/rcu/tree_nocb.h     | 26 +++++++++++++-
 7 files changed, 217 insertions(+), 8 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a8a79..47501fdfd3c1 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -198,10 +198,51 @@ struct ustat {
 	char			f_fpack[6];
 };
 
+#ifdef CONFIG_RCU_TRACE_CB
+/*
+ * Debug information that a caller can store within a callback_head.
+ * Its expected to provide at least 12 bytes before BUILD_BUG starts
+ * complaining.
+ */
+enum cb_debug_flags {
+	CB_DEBUG_KFREE,
+	CB_DEBUG_LAZY,
+	CB_DEBUG_BYPASS,
+
+	// A new non-lazy CB showed up and we decided to not use
+	// the bypass list for it. So we flushed the old ones.
+	CB_DEBUG_NON_LAZY_FLUSHED,
+
+	// We decided to use the bypass list but had to flush
+	// the old bypass CBs because they got too old or too big.
+	CB_DEBUG_BYPASS_FLUSHED,
+	CB_DEBUG_BYPASS_LAZY_FLUSHED,
+
+	// The GP thread flushed the bypass CBs if they got old or big.
+	CB_DEBUG_GPTHREAD_FLUSHED,
+
+	// De-offload from NOCB mode.
+	CB_DEBUG_DEOFFLOAD_FLUSHED,
+
+	// rcu_barrier() flushes lazy/bypass CBs for CB exec ordering.
+	CB_DEBUG_BARRIER_FLUSHED
+};
+
+struct cb_debug_info {
+	// 16-bit jiffie deltas can provide about 60 seconds of resolution
+	// at HZ=1000 before wrapping. That's enough for debug.
+	u16 cb_queue_jiff;
+	u16 first_bp_jiff;
+	u16 cb_flush_jiff;
+	enum cb_debug_flags flags:16;
+};
+#endif
+
 /**
  * struct callback_head - callback structure for use with RCU and task_work
  * @next: next update requests in a list
  * @func: actual update function to call after the grace period.
+ * @di: debug information that can be stored.
  *
  * The struct is aligned to size of pointer. On most architectures it happens
  * naturally due ABI requirements, but some architectures (like CRIS) have
@@ -220,6 +261,9 @@ struct ustat {
 struct callback_head {
 	struct callback_head *next;
 	void (*func)(struct callback_head *head);
+#ifdef CONFIG_RCU_TRACE_CB
+	struct cb_debug_info di;
+#endif
 } __attribute__((aligned(sizeof(void *))));
 #define rcu_head callback_head
 
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 90b2fb0292cb..dd6baec6745c 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -630,24 +630,85 @@ TRACE_EVENT_RCU(rcu_batch_start,
  */
 TRACE_EVENT_RCU(rcu_invoke_callback,
 
-	TP_PROTO(const char *rcuname, struct rcu_head *rhp),
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp
+#ifdef CONFIG_RCU_TRACE_CB
+		, unsigned long jiffies_first
+#endif
+	),
 
-	TP_ARGS(rcuname, rhp),
+	TP_ARGS(rcuname, rhp
+#ifdef CONFIG_RCU_TRACE_CB
+		, jiffies_first
+#endif
+		),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(void *, rhp)
 		__field(void *, func)
+#ifdef CONFIG_RCU_TRACE_CB
+		__field(u16, cb_debug_flags)
+		__field(int, cb_queue_exec_latency)
+		__array(char, bypass_flush_reason, 32)
+		__field(int, cb_bypass_slack)
+		__field(int, cb_queue_flush_latency)
+#endif
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
 		__entry->rhp = rhp;
 		__entry->func = rhp->func;
+#ifdef CONFIG_RCU_TRACE_CB
+		__entry->cb_debug_flags = rhp->di.flags;
+		__entry->cb_queue_exec_latency =
+			(jiffies - jiffies_first) - rhp->di.cb_queue_jiff,
+
+		/* The following 3 fields are valid only for bypass/lazy CBs. */
+		__entry->cb_bypass_slack =
+			(rhp->di.flags & BIT(CB_DEBUG_BYPASS)) ?
+				rhp->di.cb_queue_jiff - rhp->di.first_bp_jiff : 0,
+		__entry->cb_queue_flush_latency =
+			(rhp->di.flags & BIT(CB_DEBUG_BYPASS)) ?
+				rhp->di.cb_flush_jiff - rhp->di.cb_queue_jiff : 0;
+
+
+		if (__entry->cb_debug_flags & BIT(CB_DEBUG_NON_LAZY_FLUSHED))
+			strcpy(__entry->bypass_flush_reason, "non-lazy");
+		else if (__entry->cb_debug_flags & BIT(CB_DEBUG_BYPASS_FLUSHED))
+			strcpy(__entry->bypass_flush_reason, "bypass");
+		else if (__entry->cb_debug_flags & BIT(CB_DEBUG_BYPASS_LAZY_FLUSHED))
+			strcpy(__entry->bypass_flush_reason, "bypass-lazy");
+		else if (__entry->cb_debug_flags & BIT(CB_DEBUG_GPTHREAD_FLUSHED))
+			strcpy(__entry->bypass_flush_reason, "gpthread");
+		else if (__entry->cb_debug_flags & BIT(CB_DEBUG_BARRIER_FLUSHED))
+			strcpy(__entry->bypass_flush_reason, "rcu_barrier");
+		else if (__entry->cb_debug_flags & BIT(CB_DEBUG_DEOFFLOAD_FLUSHED))
+			strcpy(__entry->bypass_flush_reason, "deoffload");
+#endif
 	),
 
-	TP_printk("%s rhp=%p func=%ps",
-		  __entry->rcuname, __entry->rhp, __entry->func)
+	TP_printk("%s rhp=%p func=%ps"
+#ifdef CONFIG_RCU_TRACE_CB
+			" lazy=%d "
+			"bypass=%d "
+			"flush_reason=%s "
+			"queue_exec_latency=%d "
+			"bypass_slack=%d "
+			"queue_flush_latency=%d"
+#endif
+			,
+		  __entry->rcuname, __entry->rhp, __entry->func
+#ifdef CONFIG_RCU_TRACE_CB
+		,
+		!!(__entry->cb_debug_flags & BIT(CB_DEBUG_LAZY)),
+		!!(__entry->cb_debug_flags & BIT(CB_DEBUG_BYPASS)),
+		__entry->bypass_flush_reason,
+		__entry->cb_queue_exec_latency,
+		__entry->cb_bypass_slack,
+		__entry->cb_queue_flush_latency
+#endif
+	 )
 );
 
 /*
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3128d01427cb..cd6ff63517f4 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -319,4 +319,15 @@ config RCU_LAZY
 	  To save power, batch RCU callbacks and flush after delay, memory
 	  pressure or callback list growing too big.
 
+config RCU_TRACE_CB
+	bool "Enable additional callback tracing"
+	depends on RCU_LAZY
+	default n
+	help
+	  Enable additional callback tracing for RCU. Currently only
+	  tracing for lazy/bypass callbacks is done. In the future, it could be
+	  extended to non-lazy callbacks as well. The trace point contains
+	  detailed information about callback flushing reason and execution
+	  time. This information can be retrieved by BPF tools via tracepoints.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 55b50e592986..8f0b024f7bc5 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -32,6 +32,27 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
 	WRITE_ONCE(rclp->len, rclp->len + 1);
 }
 
+/*
+ * Set a debug flag on all CBs in the unsegmented cblist @rclp.
+ *
+ * The callback causing the flush. Should be NULL if its a timer that does it.
+ */
+#ifdef CONFIG_RCU_TRACE_CB
+void rcu_cblist_set_flush(struct rcu_cblist *rcl,
+			 enum cb_debug_flags flags,
+			 unsigned long flush_jiff)
+{
+	if (!rcl || !rcl->head)
+		return;
+
+	for (struct rcu_head *head = rcl->head;
+			head && head != *(rcl->tail); head = head->next) {
+		head->di.flags |= flags;
+		head->di.cb_flush_jiff = flush_jiff;
+	}
+}
+#endif
+
 /*
  * Flush the second rcu_cblist structure onto the first one, obliterating
  * any contents of the first.  If rhp is non-NULL, enqueue it as the sole
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 431cee212467..ac1f34024b84 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -53,6 +53,14 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 #endif
 }
 
+#ifdef CONFIG_RCU_TRACE_CB
+void rcu_cblist_set_flush(struct rcu_cblist *rcl,
+			 enum cb_debug_flags flags,
+			 unsigned long flush_jiff);
+#else
+#define rcu_cblist_set_flush(...)
+#endif
+
 static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
 					   int flags)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aaced29a0a71..8111d9f37621 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2179,6 +2179,12 @@ int rcutree_dead_cpu(unsigned int cpu)
 	return 0;
 }
 
+static unsigned long cb_debug_jiffies_first;
+
+#if defined(CONFIG_RCU_TRACE_CB) && defined(CONFIG_RCU_LAZY)
+extern unsigned long jiffies_till_flush;
+#endif
+
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Throttle as specified by rdp->blimit.
@@ -2241,7 +2247,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_callback(rcu_state.name, rhp);
+
+		trace_rcu_invoke_callback(rcu_state.name, rhp
+#ifdef CONFIG_RCU_TRACE_CB
+			, READ_ONCE(cb_debug_jiffies_first)
+#endif
+		);
 
 		f = rhp->func;
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
@@ -2736,6 +2747,17 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	struct rcu_data *rdp;
 	bool was_alldone;
 
+	/*
+	 * For CB debugging, record the starting reference to jiffies while
+	 * making sure it does not wrap around. The starting reference is
+	 * used to calculate 16-bit jiffie deltas. To be safe, reset the
+	 * reference once the delta exceeds 15-bits worth.
+	 */
+	if (IS_ENABLED(CONFIG_RCU_TRACE_CB) &&
+		(!READ_ONCE(cb_debug_jiffies_first) ||
+		 (jiffies - READ_ONCE(cb_debug_jiffies_first) > (1 << 15))))
+		WRITE_ONCE(cb_debug_jiffies_first, jiffies);
+
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
 
@@ -2771,14 +2793,29 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 
 	check_cb_ovld(rdp);
 
-	if (__is_kvfree_rcu_offset((unsigned long)func))
+#ifdef CONFIG_RCU_TRACE_CB
+	head->di.flags = 0;
+	WARN_ON_ONCE(jiffies - READ_ONCE(cb_debug_jiffies_first) > 65535);
+	head->di.cb_queue_jiff = (u16)(jiffies - READ_ONCE(cb_debug_jiffies_first));
+#endif
+
+	if (__is_kvfree_rcu_offset((unsigned long)func)) {
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
-	else
+#ifdef CONFIG_RCU_TRACE_CB
+		head->di.flags |= BIT(CB_DEBUG_KFREE);
+#endif
+	} else {
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+#ifdef CONFIG_RCU_TRACE_CB
+		if (lazy)
+			head->di.flags |= BIT(CB_DEBUG_LAZY);
+#endif
+	}
+
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
@@ -3943,6 +3980,9 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+
+	rcu_cblist_set_flush(&rdp->nocb_bypass, BIT(CB_DEBUG_BARRIER_FLUSHED),
+			(jiffies - READ_ONCE(cb_debug_jiffies_first)));
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false,
 		     /* wake gp thread */ true));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 560ba87911c5..ee5924ba2f3b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -355,6 +355,11 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if (rhp)
 		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
 
+	/* The lazy CBs are being flushed, but a new one might be enqueued. */
+#ifdef CONFIG_RCU_TRACE_CB
+	WARN_ON_ONCE(rhp && lazy != !!(rhp->di.flags & BIT(CB_DEBUG_LAZY)));
+#endif
+
 	/*
 	 * If the new CB requested was a lazy one, queue it onto the main
 	 * ->cblist so we can take advantage of a sooner grade period.
@@ -407,6 +412,10 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
+
+	rcu_cblist_set_flush(&rdp->nocb_bypass, BIT(CB_DEBUG_GPTHREAD_FLUSHED),
+			     (j - READ_ONCE(cb_debug_jiffies_first)));
+
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
 }
 
@@ -489,8 +498,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
 
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false, false));
+		rcu_cblist_set_flush(&rdp->nocb_bypass, BIT(CB_DEBUG_NON_LAZY_FLUSHED),
+				     (j - READ_ONCE(cb_debug_jiffies_first)));
 
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false, false));
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		return false; // Caller must enqueue the callback.
 	}
@@ -503,6 +514,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
 
+		rcu_cblist_set_flush(&rdp->nocb_bypass,
+				lazy ? BIT(CB_DEBUG_BYPASS_LAZY_FLUSHED) : BIT(CB_DEBUG_BYPASS_FLUSHED),
+				(j - READ_ONCE(cb_debug_jiffies_first)));
+
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, false)) {
 			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
@@ -543,6 +558,11 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
 	}
 
+#ifdef CONFIG_RCU_TRACE_CB
+	rhp->di.flags |= BIT(CB_DEBUG_BYPASS);
+	rhp->di.first_bp_jiff = READ_ONCE(rdp->nocb_bypass_first) - READ_ONCE(cb_debug_jiffies_first);
+#endif
+
 	rcu_nocb_bypass_unlock(rdp);
 	smp_mb(); /* Order enqueue before wake. */
 
@@ -1156,6 +1176,10 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * return false, which means that future calls to rcu_nocb_try_bypass()
 	 * will refuse to put anything into the bypass.
 	 */
+
+	rcu_cblist_set_flush(&rdp->nocb_bypass, BIT(CB_DEBUG_DEOFFLOAD_FLUSHED),
+			(jiffies - READ_ONCE(cb_debug_jiffies_first)));
+
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
 	/*
 	 * Start with invoking rcu_core() early. This way if the current thread
-- 
2.37.2.789.g6183377224-goog

