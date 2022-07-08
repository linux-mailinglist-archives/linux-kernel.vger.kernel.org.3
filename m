Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878E56B184
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiGHEZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGHEZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:25:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691421E3F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:25:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g14so25762413qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YiRIQ6EPldvCAHBc1vkFltTFtFZvbbQuV3XjMnACSEk=;
        b=NYg2Enet/cCdMjqU2+zIl2w2yOoLVLg20hXZUY/snkVK9j+WCy1MK4DUh4vggQ2W11
         LHqX9Hw53quV+9/HR9Btw+5zueHn9KtKFXRkFynXa615UoQcdaMr+/4UQwqsq3v5UhMg
         C/IzFHyyJkMnnzmjArg1yY5KLMu3xD1V9zeVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiRIQ6EPldvCAHBc1vkFltTFtFZvbbQuV3XjMnACSEk=;
        b=UM3/PbQjctu/fU6NoktupGVYfR93lejAs+SLxEx8I2OXQA5XAuUrfb8y5DLNqPcwnp
         PFwIJk3iAtDBBhw9dP80gruWOP36kP6cmKMx210GLNhiWfgCS3aQYmblYYTIoI4/gScx
         JqxHrO6OOz4JYWZEtQcbFsjvHd+RV5oNNNbmy+LLreGaGcQx/74L+qBY696ozEMJ/ww7
         v3v5qNkADvk8oPHHymjOocgwoo1mkHHPzknQ70FnJEnK2vyribFENrVm20gekEF+qNTi
         EDD6nPR79w9Y4MQGXabKRVphyzL3JKWDiUpCQ5FtbjWdip8uA9x1ZonVFxZZVuKIurag
         2Y+A==
X-Gm-Message-State: AJIora8smOsRlqoIw4r2ueJcV5JJkAXv/o0YSGt77gyF8hOh+H4cRS5H
        1BsJFQEol/nLg80aAFLH/GYCOQ==
X-Google-Smtp-Source: AGRyM1ssQj2JdzzT4Tsaqj33dtrnhGQjDMwLgzAtQgLZpFL2OO+fD9YINggJS2PRhhleidHfdUeeMA==
X-Received: by 2002:a05:6214:d66:b0:470:4528:bbd5 with SMTP id 6-20020a0562140d6600b004704528bbd5mr1186921qvs.73.1657254310548;
        Thu, 07 Jul 2022 21:25:10 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ay4-20020a05622a228400b002f39b99f69csm26560294qtb.54.2022.07.07.21.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:25:09 -0700 (PDT)
Date:   Fri, 8 Jul 2022 04:25:09 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <YsexpcG2iaplKPIs@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-8-joel@joelfernandes.org>
 <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 09:13:27PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 22, 2022 at 10:51:00PM +0000, Joel Fernandes (Google) wrote:
> > Reuse the kfree_rcu() test in order to be able to compare the memory reclaiming
> > properties of call_rcu_lazy() with kfree_rcu().
> > 
> > With this test, we find similar memory footprint and time call_rcu_lazy()
> > free'ing takes compared to kfree_rcu(). Also we confirm that call_rcu_lazy()
> > can survive OOM during extremely frequent calls.
> > 
> > If we really push it, i.e. boot system with low memory and compare
> > kfree_rcu() with call_rcu_lazy(), I find that call_rcu_lazy() is more
> > resilient and is much harder to produce OOM as compared to kfree_rcu().
> 
> Another approach would be to make rcutorture's forward-progress testing
> able to use call_rcu_lazy().  This would test lazy callback flooding.
> 
> Yet another approach would be to keep one CPU idle other than a
> kthread doing call_rcu_lazy().  Of course "idle" includes redirecting
> those pesky interrupts.
> 
> It is almost certainly necessary for rcutorture to exercise the
> call_rcu_lazy() path regularly.

Currently I added a test like the following which adds a new torture type, my
thought was to stress the new code to make sure nothing crashed or hung the
kernel. That is working well except I don't exactly understand the total-gps
print showing 0, which the other print shows 1188 GPs. I'll go dig into that
tomorrow.. thanks!

The print shows
TREE11 ------- 1474 GPs (12.2833/s) [rcu_lazy: g0 f0x0 total-gps=0]
TREE11 no success message, 7 successful version messages

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7120165a9342..cc6b7392d801 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -872,6 +872,64 @@ static struct rcu_torture_ops tasks_rude_ops = {
 
 #endif // #else #ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_RCU_LAZY
+
+/*
+ * Definitions for lazy RCU torture testing.
+ */
+unsigned long orig_jiffies_till_flush;
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
2.37.0.rc0.161.g10f37bed90-goog

