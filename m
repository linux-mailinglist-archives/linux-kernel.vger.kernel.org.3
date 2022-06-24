Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED49559416
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiFXHVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:21:46 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 00:21:45 PDT
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABCB699A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:21:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="78291326"
X-IronPort-AV: E=Sophos;i="5.92,218,1650898800"; 
   d="scan'208";a="78291326"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Jun 2022 16:20:39 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D014D624C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:20:38 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B23573C681
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:20:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 9506C2020B09;
        Fri, 24 Jun 2022 16:20:37 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        yamamoto.rei@jp.fujitsu.com
Subject: [PATCH] hrtimer: CPU and entry_time is added to a warning message in hrtimer_interrupt()
Date:   Fri, 24 Jun 2022 16:00:11 +0900
Message-Id: <20220624070011.128234-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <87h77lhkzh.ffs@tglx>
References: <87h77lhkzh.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning message in hrtimer_interrupt() is output up to 5 times
by default, and CPU and entry_time are also shown.
These changes are helpful that the function spending a lot of time is clear
by using ftrace:
-----
dmesg
:
[ 1462.836971] start repro_hrtimer_interrupt
[ 1462.836976] test_handler = test_handler [repro] 0xffff9788f7bb3048
:
[ 1462.879117] hrtimer: CPU 7, entry_time = 1462807264840, interrupt took
60048886 ns             ^^^^^               ^^^^^^^^^^^^^

cat /sys/kernel/debug/tracing/trace
:
          <idle>-0       [007] d.h1.  1462.838075: hrtimer_expire_entry:
                         ^^^^^
hrtimer=0000000041fcee42 function=test_handler [repro] now=1462807264840
                                                           ^^^^^^^^^^^^^
-----

Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
---
 include/linux/hrtimer.h |  1 +
 kernel/sysctl.c         | 10 ++++++++++
 kernel/time/hrtimer.c   | 16 +++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..1a6e03b3015b 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -317,6 +317,7 @@ static inline int hrtimer_is_hres_active(struct hrtimer *timer)
 struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
+extern int sysctl_hrtimer_interrupt_warnings;
 
 extern unsigned int hrtimer_resolution;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e52b6e372c60..b0420d60cec9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -64,6 +64,7 @@
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/pid.h>
+#include <linux/hrtimer.h>
 
 #include "../lib/kstrtox.h"
 
@@ -2038,6 +2039,15 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_INT_MAX,
 	},
+#endif
+#ifdef CONFIG_HIGH_RES_TIMERS
+	{
+		.procname       = "hrtimer_interrupt_warnings",
+		.data           = &sysctl_hrtimer_interrupt_warnings,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 #endif
 	{ }
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..19adcbcf92e4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1773,6 +1773,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
+int sysctl_hrtimer_interrupt_warnings = 5;
 
 /*
  * High resolution timer interrupt
@@ -1866,7 +1867,20 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
+
+	/*
+	 * If a message is output many times, the delayed funciton
+	 * may be identified by resetting sysctl_hrtimer_interrupt_warnings
+	 * and enabling ftrace.
+	 */
+	if (sysctl_hrtimer_interrupt_warnings) {
+		if (sysctl_hrtimer_interrupt_warnings > 0)
+			sysctl_hrtimer_interrupt_warnings--;
+		pr_warn("hrtimer: CPU %d, entry_time = %llu, "
+				"interrupt took %llu ns\n",
+				cpu_base->cpu, entry_time,
+				ktime_to_ns(delta));
+	}
 }
 
 /* called with interrupts disabled */
-- 
2.27.0

