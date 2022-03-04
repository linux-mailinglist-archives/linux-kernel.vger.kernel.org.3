Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4234CD6C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCDOwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiCDOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:52:12 -0500
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D221B84E8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:51:24 -0800 (PST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 0DA4819B7D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:51:24 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Q9H9nV99Cdx86Q9HAniccq; Fri, 04 Mar 2022 08:51:24 -0600
X-Authority-Reason: nr=8
Received: from host-82-63-1-3.business.telecomitalia.it ([82.63.1.3]:40136 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nQ9H9-0009kg-7d; Fri, 04 Mar 2022 08:51:23 -0600
Message-ID: <abb789c3-0d1a-28e9-3b8d-e4a68e3f57f5@kernel.org>
Date:   Fri, 4 Mar 2022 15:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
        Juri Lelli <juri.lelli@redhat.com>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
 <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 82.63.1.3
X-Source-L: No
X-Exim-ID: 1nQ9H9-0009kg-7d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-82-63-1-3.business.telecomitalia.it ([10.0.0.45]) [82.63.1.3]:40136
X-Source-Auth: kernel@bristot.me
X-Email-Count: 17
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hey Nicolas,
>>
>> While testing this patch with rtla osnoise on the 5.17.0-rc6-rt10+, when I hit
>> ^c on osnoise top, the system freezes :-/.
>>
>> Could you try that on your system?
> Yes of course, I'll get a build going.


also, could you try this? 

it is an RFC I was thinking to send, as I mentioned before (and on IRC).

It works fine, I see nohz_full and rcu behaving like if osnoise was a
user-space tool. It is more invasive on osnoise, but the behavior does not
change - like, run cyclictest on top of osnoise and you will see that
the system is still preemptive with low latency even with osnoise with
"preempt_disabled."

do you mind having a look to see if it behaves as expected in your scenario?

[ note, there are things to cleanup in this patch, like adding a static key ]
[ in is_osnoise_cur(), it was a real RFC. 				    ]

-- Daniel

tracing/osnoise: Pretend to be in user-space for RCU

To simulate an user-space workload, osnoise informs RCU that it
is going to user-space by calling rcu_user_enter(). However,
osnoise never actually goes to user-space. It keeps running
in an intermediate stage.

This stage runs with preemption disabled, like the idle thread
does. Likewise idle, osnoise will continuously check for need
resched, allowing its preemption, simulating a fully preemptive
mode.

Anytime a kernel function needs to be called, the rcu_user_enter()
needs to be called.

Any change on rcu_user_enter/exit needs to be tested with
CONFIG_RCU_EQS_DEBUG=y.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 include/linux/trace.h        |   9 +++
 kernel/rcu/tree.c            |   7 +-
 kernel/trace/trace_osnoise.c | 129 +++++++++++++++++++++++++++++++++--
 3 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index bf169612ffe1..970d66f79cee 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -48,6 +48,15 @@ void osnoise_arch_unregister(void);
 void osnoise_trace_irq_entry(int id);
 void osnoise_trace_irq_exit(int id, const char *desc);
 
+#ifdef CONFIG_OSNOISE_TRACER
+extern bool is_osnoise_curr(void);
+#else
+static __always_inline bool is_osnoise_curr(void)
+{
+	return false;
+}
+#endif /* CONFIG_OSNOISE_TRACER */
+
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6283b0..ede0c468e75f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -62,6 +62,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/kasan.h>
+#include <linux/trace.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
@@ -442,9 +443,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 		return false;
 
 	/*
-	 * If we're not in an interrupt, we must be in the idle task!
+	 * If we're not in an interrupt, we must be in the idle task or osnoise.
+	 * The osnoise thread is an special case. It is a kernel thread that
+	 * pretends to be in user-space. See kernel/trace/trace_osnoise.c.
 	 */
-	WARN_ON_ONCE(!nesting && !is_idle_task(current));
+	WARN_ON_ONCE(!nesting && !(is_idle_task(current) || is_osnoise_curr()));
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index cfddb30e65ab..d52ef290c884 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -448,6 +448,31 @@ static void print_osnoise_headers(struct seq_file *s)
 }
 #endif /* CONFIG_PREEMPT_RT */
 
+static inline void osnoise_user_enter(void)
+{
+	local_irq_disable();
+	rcu_user_enter();
+	local_irq_enable();
+}
+
+static inline void osnoise_user_exit(void)
+{
+	local_irq_disable();
+	rcu_user_exit();
+	local_irq_enable();
+}
+
+static inline void osnoise_cond_resched(void)
+{
+	if (need_resched()) {
+		osnoise_user_exit();
+		preempt_enable();
+		cond_resched();
+		preempt_disable();
+		osnoise_user_enter();
+	}
+}
+
 /*
  * osnoise_taint - report an osnoise error.
  */
@@ -464,6 +489,14 @@ static void print_osnoise_headers(struct seq_file *s)
 	osnoise_data.tainted = true;						\
 })
 
+#define osnoise_taint_user(msg) ({						\
+	local_irq_disable();							\
+	rcu_user_exit();							\
+	osnoise_taint(msg);							\
+	rcu_user_enter();							\
+	local_irq_enable();							\
+})
+
 /*
  * Record an osnoise_sample into the tracer buffer.
  */
@@ -819,6 +852,43 @@ set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
 	return int_counter;
 }
 
+/*
+ * set_int_safe_time_thread - Save the current time on *time, aware of interference
+ *
+ * Get the time, taking into consideration a possible interference from
+ * higher priority interrupts and threads.
+ *
+ * See get_int_safe_duration() for an explanation.
+ */
+static u64
+set_int_safe_time_thread(struct osnoise_variables *osn_var, u64 *time)
+{
+	u64 int_counter;
+
+	do {
+		int_counter = local_read(&osn_var->int_counter);
+
+		/* let any thread awakened by an interrupt to run */
+		osnoise_cond_resched();
+
+		/* synchronize with interrupts */
+		barrier();
+
+		*time = time_get();
+
+		/* synchronize with interrupts */
+		barrier();
+
+	} while (int_counter != local_read(&osn_var->int_counter));
+
+	/*
+	 * At this point, the time accounts all the interference from to
+	 * consecutive get time that did not get interfered.
+	 */
+	return int_counter;
+}
+
+
 #ifdef CONFIG_TIMERLAT_TRACER
 /*
  * copy_int_safe_time - Copy *src into *desc aware of interference
@@ -1337,11 +1407,31 @@ static int run_osnoise(void)
 	 */
 	last_int_count = set_int_safe_time(osn_var, &last_sample);
 
+	/*
+	 * to simulate an user-space workload, osnoise informs RCU that it
+	 * is going to user-space by calling rcu_user_enter(). However,
+	 * osnoise never actually goes to user-space. It keeps running
+	 * in an intermediate stage.
+	 *
+	 * This stage runs with preemption disabled, like the idle thread
+	 * does. Likewise idle, osnoise will continuously check for need
+	 * resched, allowing its preemption, simulating a fully preemptive
+	 * mode.
+	 *
+	 * Anytime a kernel function needs to be called, the rcu_user_enter()
+	 * needs to be called.
+	 *
+	 * Any change on rcu_user_enter/exit needs to be tested with
+	 * CONFIG_RCU_EQS_DEBUG=y.
+	 */
+	preempt_disable();
+	osnoise_user_enter();
+
 	do {
 		/*
 		 * Get sample!
 		 */
-		int_count = set_int_safe_time(osn_var, &sample);
+		int_count = set_int_safe_time_thread(osn_var, &sample);
 
 		noise = time_sub(sample, last_sample);
 
@@ -1349,7 +1439,7 @@ static int run_osnoise(void)
 		 * This shouldn't happen.
 		 */
 		if (noise < 0) {
-			osnoise_taint("negative noise!");
+			osnoise_taint_user("negative noise!");
 			goto out;
 		}
 
@@ -1362,7 +1452,7 @@ static int run_osnoise(void)
 		 * Check for possible overflows.
 		 */
 		if (total < last_total) {
-			osnoise_taint("total overflow!");
+			osnoise_taint_user("total overflow!");
 			break;
 		}
 
@@ -1379,24 +1469,41 @@ static int run_osnoise(void)
 
 			sum_noise += noise;
 
+			/*
+			 * osnoise is in fake user-space. Leave this mode to call
+			 * the tracepoint. Interrupts are kept disabled to avoid
+			 * having the overhead of enabling/disabling around
+			 * rcu_user_exit/enter again. This does not change the
+			 * behavior of osnoise.
+			 */
+			local_irq_disable();
+			rcu_user_exit();
 			trace_sample_threshold(last_sample, noise, interference);
+			rcu_user_enter();
+			local_irq_enable();
 
 			if (osnoise_data.stop_tracing)
-				if (noise > stop_in)
+				if (noise > stop_in) {
+					osnoise_user_exit();
 					osnoise_stop_tracing();
+					osnoise_user_enter();
+				}
 		}
 
+
 		/*
-		 * For the non-preemptive kernel config: let threads runs, if
-		 * they so wish.
+		 * Let threads to interfere with osnoise.
 		 */
-		cond_resched();
+		osnoise_cond_resched();
 
 		last_sample = sample;
 		last_int_count = int_count;
 
 	} while (total < runtime && !kthread_should_stop());
 
+	osnoise_user_exit();
+	preempt_enable();
+
 	/*
 	 * Finish the above in the view for interrupts.
 	 */
@@ -2387,3 +2494,11 @@ __init static int init_osnoise_tracer(void)
 	return 0;
 }
 late_initcall(init_osnoise_tracer);
+
+bool is_osnoise_curr(void)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	if (osn_var->kthread == current)
+		return 1;
+	return 0;
+}
-- 
2.34.1
