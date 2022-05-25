Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED82534222
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbiEYRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiEYRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:23:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C595A34;
        Wed, 25 May 2022 10:23:51 -0700 (PDT)
Date:   Wed, 25 May 2022 19:23:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653499429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2BSL5Rwo89rLqEXxiG2O6kXQNZHwOECZU8ttnooY7V0=;
        b=wHfyXvPi10cm/lxKPBaH5sQTLlyZyGhRWSuOypCbFdu+DKkpXBtenCfXbBaIlV4a8buy42
        J1QaxjhTDKD3PdOWHzm5PGGfEX+oWwV6oQ70/aEeTfUHv1wtCoibEEEuAZ5+NQT8/dLUX5
        gFoz4UYc1nJl/bTAtvEU6xmaUvC03xvJZTRHfP4IUYJ7sZ2zrLh2w8KZBfbMwFXf+pU21g
        cYK0h55SalD7a0e2X1nmgHzBbQ84BC2uVQ+GOWSlN07wq+b5kfCFOXSk8tuH8uAczegl4+
        Y8IVWXDct0MPqkiM8oOF5FMJ2xZ9bu65QYGixH0kQ8Q1o6XY3aQZIXt1BpTN1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653499429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2BSL5Rwo89rLqEXxiG2O6kXQNZHwOECZU8ttnooY7V0=;
        b=06W1Wu1i2QuRF6XW19bHvRtRWEM0L6umZqMvPg8GSDb/TOtiWGQAb7WTG+RCTTMbe79mBO
        m/f9t+TZwaXWmbDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.18-rt11
Message-ID: <Yo5mI5C2YefYEkh8@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.18-rt11 patch set. 

Changes since v5.18-rt10:

  - Dropping preempt_check_resched_rt() checks. The checks were added to
    ensure a possible wake up which could be missed if the wakeup
    happens on the same CPU with disabled interrupts. This has been
    reduced to a ksoftirqd wake and is no longer needed because a
    softirq-raise won't wake ksoftirqd if the caller has BH disabled.
    The remaining two caller (based on audit, htb_work_func() and
    dev_cpu_dead()) acquire/release a lock "soon" which provides the
    needed scheduling point.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.18-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/incr/patch-5.18-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.18-rt11

The RT patch against v5.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patch-5.18-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patches-5.18-rt11.tar.xz

Sebastian

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c3cb3fcbee8c3..873a5dac54e0e 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -232,12 +232,6 @@ do { \
 
 #define preempt_enable_no_resched() sched_preempt_enable_no_resched()
 
-#ifndef CONFIG_PREEMPT_RT
-# define preempt_check_resched_rt() barrier();
-#else
-# define preempt_check_resched_rt() preempt_check_resched()
-#endif
-
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
 #ifdef CONFIG_PREEMPTION
@@ -324,7 +318,6 @@ do { \
 #define preempt_disable_notrace()		barrier()
 #define preempt_enable_no_resched_notrace()	barrier()
 #define preempt_enable_notrace()		barrier()
-#define preempt_check_resched_rt()		barrier()
 #define preemptible()				0
 
 #define preempt_lazy_disable()			barrier()
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/net/core/dev.c b/net/core/dev.c
index 0b81439394b07..2771fd22dc6ae 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3024,7 +3024,6 @@ static void __netif_reschedule(struct Qdisc *q)
 	sd->output_queue_tailp = &q->next_sched;
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_restore(flags);
-	preempt_check_resched_rt();
 }
 
 void __netif_schedule(struct Qdisc *q)
@@ -3087,7 +3086,6 @@ void __dev_kfree_skb_irq(struct sk_buff *skb, enum skb_free_reason reason)
 	__this_cpu_write(softnet_data.completion_queue, skb);
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_restore(flags);
-	preempt_check_resched_rt();
 }
 EXPORT_SYMBOL(__dev_kfree_skb_irq);
 
@@ -5809,14 +5807,12 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 		sd->rps_ipi_list = NULL;
 
 		local_irq_enable();
-		preempt_check_resched_rt();
 
 		/* Send pending IPI's to kick RPS processing on remote cpus. */
 		net_rps_send_ipi(remsd);
 	} else
 #endif
 		local_irq_enable();
-	preempt_check_resched_rt();
 }
 
 static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
@@ -5892,7 +5888,6 @@ void __napi_schedule(struct napi_struct *n)
 	local_irq_save(flags);
 	____napi_schedule(this_cpu_ptr(&softnet_data), n);
 	local_irq_restore(flags);
-	preempt_check_resched_rt();
 }
 EXPORT_SYMBOL(__napi_schedule);
 
@@ -11001,7 +10996,6 @@ static int dev_cpu_dead(unsigned int oldcpu)
 
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
-	preempt_check_resched_rt();
 
 #ifdef CONFIG_RPS
 	remsd = oldsd->rps_ipi_list;
