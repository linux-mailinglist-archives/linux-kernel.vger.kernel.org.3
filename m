Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2851C4DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381859AbiEEQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381710AbiEEQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902D5C369;
        Thu,  5 May 2022 09:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF54961DCE;
        Thu,  5 May 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF30C385A4;
        Thu,  5 May 2022 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766878;
        bh=ruDJZQqJ2vH4V43k2TzRTNns+L92PMm6EnkVRO/pIrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juNzGCtIG3chtCjGxiEOwhMxVKozcqT7kaApraq9IWQMVpEgL3gnSuONMxk4jFoq7
         4JuPrQqW/SDpkQQPTZkD3WCn30+g6785oS/fNz4TVXE8Hbr0n7MIAtfdxIvxElnuoh
         lAa8QRyur8A5loT+tMfiOn1kyUhlXiQv9ABTYgsP2eI0WPZ6kB5KqjFZtLpyYyl21M
         4D85BvPy7DCu4+4BEOiba5cpHyozi+7vnFOHWGPvubAR71cLE2y7LsQYYWNFYu1bfs
         czafCRCpwyL+yWnV8VR2QTMy0iLy7TQTfNf6doAgkFBHfhHqJDWuglQ83nad3/iRsT
         mN/u8+W8jwp9w==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 09/20] rv/monitor: wip instrumentation and Makefile/Kconfig entries
Date:   Thu,  5 May 2022 18:06:49 +0200
Message-Id: <b1fd05113434300a1bdac38e67215ee7fe677215.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651766361.git.bristot@kernel.org>
References: <cover.1651766361.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the instrumentation to the previously created wip monitor, as an
example of the developer work. It also adds a Makefile and Kconfig
entries.

This is a good example of the manual work that is left for the
developer to do.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/rv/Kconfig             |  7 ++++++
 kernel/trace/rv/Makefile            |  1 +
 kernel/trace/rv/monitor_wip/model.h |  2 +-
 kernel/trace/rv/monitor_wip/wip.c   | 33 +++++++++++++----------------
 kernel/trace/rv/monitor_wip/wip.h   |  2 +-
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 560408fec0c8..f2549cdd2de8 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -13,6 +13,13 @@ menuconfig RV
 
 if RV
 
+config RV_MON_WIP
+	depends on PREEMPTIRQ_TRACEPOINTS
+	bool "WIP monitor"
+	help
+	  Enable WIP sample monitor, this is a sample monitor that
+	  illustrates the usage of per-cpu monitors.
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y if RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 8944274d9b41..20f30741b933 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
+obj-$(CONFIG_RV_MON_WIP) += monitor_wip/wip.o
diff --git a/kernel/trace/rv/monitor_wip/model.h b/kernel/trace/rv/monitor_wip/model.h
index 5212ba5b1dfb..8f82388f9f55 100644
--- a/kernel/trace/rv/monitor_wip/model.h
+++ b/kernel/trace/rv/monitor_wip/model.h
@@ -35,4 +35,4 @@ struct automaton_wip automaton_wip = {
 	},
 	.initial_state = preemptive,
 	.final_states = { 1, 0 },
-};
\ No newline at end of file
+};
diff --git a/kernel/trace/rv/monitor_wip/wip.c b/kernel/trace/rv/monitor_wip/wip.c
index cd7795b282d6..8dcee668959f 100644
--- a/kernel/trace/rv/monitor_wip/wip.c
+++ b/kernel/trace/rv/monitor_wip/wip.c
@@ -8,12 +8,10 @@
 #include <rv/instrumentation.h>
 #include <rv/da_monitor.h>
 
-#define MODULE_NAME "wip"
+#include <trace/events/sched.h>
+#include <trace/events/preemptirq.h>
 
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
+#define MODULE_NAME "wip"
 
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
@@ -39,22 +37,21 @@ DECLARE_DA_MON_PER_CPU(wip, char);
  * are translated into model's event.
  *
  */
-static void handle_preempt_disable(void *data, /* XXX: fill header */)
+static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
 	da_handle_event_wip(preempt_disable);
 }
 
-static void handle_preempt_enable(void *data, /* XXX: fill header */)
+static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_wip(preempt_enable);
+	da_handle_init_event_wip(preempt_enable);
 }
 
-static void handle_sched_waking(void *data, /* XXX: fill header */)
+static void handle_sched_waking(void *data, struct task_struct *task)
 {
 	da_handle_event_wip(sched_waking);
 }
 
-
 static int start_wip(void)
 {
 	int retval;
@@ -63,9 +60,9 @@ static int start_wip(void)
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+	rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);
+	rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
+	rv_attach_trace_probe("wip", sched_waking, handle_sched_waking);
 
 	return 0;
 }
@@ -74,9 +71,9 @@ static void stop_wip(void)
 {
 	rv_wip.enabled = 0;
 
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+	rv_detach_trace_probe("wip", preempt_disable, handle_preempt_disable);
+	rv_detach_trace_probe("wip", preempt_enable, handle_preempt_enable);
+	rv_detach_trace_probe("wip", sched_waking, handle_sched_waking);
 
 	da_monitor_destroy_wip();
 }
@@ -111,5 +108,5 @@ module_init(register_wip);
 module_exit(unregister_wip);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("wip");
+MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
+MODULE_DESCRIPTION("wip: wakeup in preemptive - per-cpu sample monitor.");
diff --git a/kernel/trace/rv/monitor_wip/wip.h b/kernel/trace/rv/monitor_wip/wip.h
index 7a751a8896e9..1ba58a5781ff 100644
--- a/kernel/trace/rv/monitor_wip/wip.h
+++ b/kernel/trace/rv/monitor_wip/wip.h
@@ -59,6 +59,6 @@ TRACE_EVENT(error_wip,
 
 /* This part ust be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../kernel/trace/rv/monitor_wip/
 #define TRACE_INCLUDE_FILE wip
 #include <trace/define_trace.h>
-- 
2.35.1

