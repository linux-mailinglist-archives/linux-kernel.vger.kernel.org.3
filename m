Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4973A59A726
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiHSUtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351460AbiHSUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:13 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56649F0E4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d1so4226666qvs.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9DL/cHJo5H0hKH4rMWH0ykvZgellvC/KgQpRDuKPDSk=;
        b=l4RVSAofkBcfMT478Bx4AOsqIhKeWXLa0QDRhXlpMVVGXsHfsbVP7KPQvSUkHSxcqI
         PC2mXE8lPXsYIt7u9qUAT61snSdKEVMOsKDEq0ntvqKd+j+bQQke+9ggJTN6mud5E3SJ
         zVY+x3UT+mZyYeyb1RERlIxWzUYezNs6sZKyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9DL/cHJo5H0hKH4rMWH0ykvZgellvC/KgQpRDuKPDSk=;
        b=WjWATqjvGNnWpVjGoZagEXa+NNEm6IxxvczJ6AN25HswYfu1R+V6TJBXegX2X3bpsR
         0lSIU7eQemRTO2v/EC7D9N/QaHRqQWuCN3sVi3pAZYLUS1u1L95mvAo+aQUB7P/1gG8F
         5ESbes7KnK/qFZt7/WfG6lq4fFg3NJ2lrmABVAO3ofk5fU/R+RyhY1sdYxPm5W3swpJu
         JdKUjiFlnJh84Xx3b0X2fy+RABbmbdF+cEX6zgjLRSkZti01MhKCvBs2ssk+eEQuM1RX
         +wGK3kfQ/GrzejIqe9YxH+QB0d6J/05mTZ93kfq03X+y1rTprTKGtpLG400vOYLgclPp
         FXaA==
X-Gm-Message-State: ACgBeo1y5napv1fiFCcbr9qRSqoBx/jtyrACpP5H8VApTJVbZgzPcFxM
        brRzW06AlSmD1zxiGYPMIrzfvGzPSyFb5w==
X-Google-Smtp-Source: AA6agR58SuILA8j7MENBOHD4KAqwfTvSkpMvgUjabkpCDtGiAYTUvnrUZaW4E2T+C4VmDACOt/9F0Q==
X-Received: by 2002:a05:6214:3009:b0:482:5a89:c09b with SMTP id ke9-20020a056214300900b004825a89c09bmr8046360qvb.71.1660942147663;
        Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 05/14] rcutorture: Add test code for call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:48 +0000
Message-Id: <20220819204857.3066329-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a new RCU type to test call_rcu_lazy(). This allows us to just
override the '.call' callback. To compensate for the laziness, we force
the laziness to a small number of jiffies. The idea of this test is to
stress the new code paths for stability and ensure it at least is providing
behavior in parity with, or similar to, call_rcu(). The actual check for
amount of laziness is in another test (rcuscale).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/rcutorture.c                       | 60 ++++++++++++++++++-
 kernel/rcu/tree.c                             |  1 +
 .../selftests/rcutorture/configs/rcu/CFLIST   |  1 +
 .../selftests/rcutorture/configs/rcu/TREE11   | 18 ++++++
 .../rcutorture/configs/rcu/TREE11.boot        |  8 +++
 6 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 608f6ab76c7f..aa3243e49506 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -460,6 +460,7 @@ enum rcutorture_type {
 	RCU_TASKS_TRACING_FLAVOR,
 	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
+	RCU_LAZY_FLAVOR,
 	INVALID_RCU_FLAVOR
 };
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7120165a9342..c52cc4c064f9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -872,6 +872,64 @@ static struct rcu_torture_ops tasks_rude_ops = {
 
 #endif // #else #ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_RCU_LAZY
+
+/*
+ * Definitions for lazy RCU torture testing.
+ */
+static unsigned long orig_jiffies_till_flush;
+
+static void rcu_sync_torture_init_lazy(void)
+{
+	rcu_sync_torture_init();
+
+	orig_jiffies_till_flush = rcu_lazy_get_jiffies_till_flush();
+	rcu_lazy_set_jiffies_till_flush(50);
+}
+
+static void rcu_lazy_cleanup(void)
+{
+	rcu_lazy_set_jiffies_till_flush(orig_jiffies_till_flush);
+}
+
+static struct rcu_torture_ops rcu_lazy_ops = {
+	.ttype			= RCU_LAZY_FLAVOR,
+	.init			= rcu_sync_torture_init_lazy,
+	.cleanup		= rcu_lazy_cleanup,
+	.readlock		= rcu_torture_read_lock,
+	.read_delay		= rcu_read_delay,
+	.readunlock		= rcu_torture_read_unlock,
+	.readlock_held		= torture_readlock_not_held,
+	.get_gp_seq		= rcu_get_gp_seq,
+	.gp_diff		= rcu_seq_diff,
+	.deferred_free		= rcu_torture_deferred_free,
+	.sync			= synchronize_rcu,
+	.exp_sync		= synchronize_rcu_expedited,
+	.get_gp_state		= get_state_synchronize_rcu,
+	.start_gp_poll		= start_poll_synchronize_rcu,
+	.poll_gp_state		= poll_state_synchronize_rcu,
+	.cond_sync		= cond_synchronize_rcu,
+	.call			= call_rcu_lazy,
+	.cb_barrier		= rcu_barrier,
+	.fqs			= rcu_force_quiescent_state,
+	.stats			= NULL,
+	.gp_kthread_dbg		= show_rcu_gp_kthreads,
+	.check_boost_failed	= rcu_check_boost_fail,
+	.stall_dur		= rcu_jiffies_till_stall_check,
+	.irq_capable		= 1,
+	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
+	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.name			= "rcu_lazy"
+};
+
+#define LAZY_OPS &rcu_lazy_ops,
+
+#else // #ifdef CONFIG_RCU_LAZY
+
+#define LAZY_OPS
+
+#endif // #else #ifdef CONFIG_RCU_LAZY
+
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
@@ -3145,7 +3203,7 @@ rcu_torture_init(void)
 	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
-		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS LAZY_OPS
 		&trivial_ops,
 	};
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e76fef8031be..67026382dc21 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -600,6 +600,7 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 {
 	switch (test_type) {
 	case RCU_FLAVOR:
+	case RCU_LAZY_FLAVOR:
 		*flags = READ_ONCE(rcu_state.gp_flags);
 		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
 		break;
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index 98b6175e5aa0..609c3370616f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -5,6 +5,7 @@ TREE04
 TREE05
 TREE07
 TREE09
+TREE11
 SRCU-N
 SRCU-P
 SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
new file mode 100644
index 000000000000..436013f3e015
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_MAXSMP=y
+CONFIG_CPUMASK_OFFSTACK=y
+CONFIG_RCU_NOCB_CPU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_LAZY=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
new file mode 100644
index 000000000000..9b6f720d4ccd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
@@ -0,0 +1,8 @@
+maxcpus=8 nr_cpus=43
+rcutree.gp_preinit_delay=3
+rcutree.gp_init_delay=3
+rcutree.gp_cleanup_delay=3
+rcu_nocbs=0-7
+rcutorture.torture_type=rcu_lazy
+rcutorture.nocbs_nthreads=8
+rcutorture.fwd_progress=0
-- 
2.37.2.609.g9ff673ca1a-goog

