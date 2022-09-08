Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86A5B273F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIHT5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIHT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C5FDBB5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QC2tmXzT7QIRjzdKgE4/pERRUFQxFSVesMKVk8CU1SU=;
        b=VaPEZ+XotEWJtrJF7PPmW+naR71NCxha82FFLaw+BspULhkzYuiV+7eEtSgKPT7IYxBeGr
        tYFl6QdomCugEf7djDjJ0gefFb9ekrlDBk/Ss/crGXy8YrjKf9mEDIBOLTyJ1h/s7Vbshf
        VBpdShiT+L4X9P4zg5MaRkqMf6u8MUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-tmdfuIpbMDqxT-iOHC72Rg-1; Thu, 08 Sep 2022 15:57:19 -0400
X-MC-Unique: tmdfuIpbMDqxT-iOHC72Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2094101AA46;
        Thu,  8 Sep 2022 19:57:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E74D2026D64;
        Thu,  8 Sep 2022 19:57:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 26424415BE32; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.863334407@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:04 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Prasad Pandit <ppandit@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH 5/7] timekeeping_notify: use stop_machine_fail when appropriate
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change timekeeping_notify to use stop_machine_fail when appropriate,
which will fail in case the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/clocksource.h
===================================================================
--- linux-2.6.orig/include/linux/clocksource.h
+++ linux-2.6/include/linux/clocksource.h
@@ -267,7 +267,7 @@ extern void clocksource_arch_init(struct
 static inline void clocksource_arch_init(struct clocksource *cs) { }
 #endif
 
-extern int timekeeping_notify(struct clocksource *clock);
+extern int timekeeping_notify(struct clocksource *clock, bool fail);
 
 extern u64 clocksource_mmio_readl_up(struct clocksource *);
 extern u64 clocksource_mmio_readl_down(struct clocksource *);
Index: linux-2.6/kernel/time/clocksource.c
===================================================================
--- linux-2.6.orig/kernel/time/clocksource.c
+++ linux-2.6/kernel/time/clocksource.c
@@ -117,7 +117,7 @@ static u64 suspend_start;
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
-static void clocksource_select(void);
+static int clocksource_select(bool fail);
 
 static LIST_HEAD(watchdog_list);
 static struct clocksource *watchdog;
@@ -649,7 +649,7 @@ static int clocksource_watchdog_kthread(
 {
 	mutex_lock(&clocksource_mutex);
 	if (__clocksource_watchdog_kthread())
-		clocksource_select();
+		clocksource_select(false);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -946,7 +946,7 @@ static struct clocksource *clocksource_f
 	return NULL;
 }
 
-static void __clocksource_select(bool skipcur)
+static int __clocksource_select(bool skipcur, bool fail)
 {
 	bool oneshot = tick_oneshot_mode_active();
 	struct clocksource *best, *cs;
@@ -954,7 +954,7 @@ static void __clocksource_select(bool sk
 	/* Find the best suitable clocksource */
 	best = clocksource_find_best(oneshot, skipcur);
 	if (!best)
-		return;
+		return 0;
 
 	if (!strlen(override_name))
 		goto found;
@@ -991,10 +991,16 @@ static void __clocksource_select(bool sk
 	}
 
 found:
-	if (curr_clocksource != best && !timekeeping_notify(best)) {
+	if (curr_clocksource != best) {
+		int ret;
+
+		ret = timekeeping_notify(best, fail);
+		if (ret)
+			return ret;
 		pr_info("Switched to clocksource %s\n", best->name);
 		curr_clocksource = best;
 	}
+	return 0;
 }
 
 /**
@@ -1005,14 +1011,14 @@ found:
  * Select the clocksource with the best rating, or the clocksource,
  * which is selected by userspace override.
  */
-static void clocksource_select(void)
+static int clocksource_select(bool fail)
 {
-	__clocksource_select(false);
+	return __clocksource_select(false, fail);
 }
 
-static void clocksource_select_fallback(void)
+static int clocksource_select_fallback(void)
 {
-	__clocksource_select(true);
+	return __clocksource_select(true, true);
 }
 
 /*
@@ -1031,7 +1037,7 @@ static int __init clocksource_done_booti
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
 	__clocksource_watchdog_kthread();
-	clocksource_select();
+	clocksource_select(false);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -1179,7 +1185,7 @@ int __clocksource_register_scale(struct
 	clocksource_enqueue_watchdog(cs);
 	clocksource_watchdog_unlock(&flags);
 
-	clocksource_select();
+	clocksource_select(false);
 	clocksource_select_watchdog(false);
 	__clocksource_suspend_select(cs);
 	mutex_unlock(&clocksource_mutex);
@@ -1208,7 +1214,7 @@ void clocksource_change_rating(struct cl
 	__clocksource_change_rating(cs, rating);
 	clocksource_watchdog_unlock(&flags);
 
-	clocksource_select();
+	clocksource_select(false);
 	clocksource_select_watchdog(false);
 	clocksource_suspend_select(false);
 	mutex_unlock(&clocksource_mutex);
@@ -1230,8 +1236,12 @@ static int clocksource_unbind(struct clo
 	}
 
 	if (cs == curr_clocksource) {
+		int ret;
+
 		/* Select and try to install a replacement clock source */
-		clocksource_select_fallback();
+		ret = clocksource_select_fallback();
+		if (ret)
+			return ret;
 		if (curr_clocksource == cs)
 			return -EBUSY;
 	}
@@ -1322,17 +1332,17 @@ static ssize_t current_clocksource_store
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	ssize_t ret;
+	ssize_t ret, err;
 
 	mutex_lock(&clocksource_mutex);
 
 	ret = sysfs_get_uname(buf, override_name, count);
 	if (ret >= 0)
-		clocksource_select();
+		err = clocksource_select(true);
 
 	mutex_unlock(&clocksource_mutex);
 
-	return ret;
+	return err ? err : ret;
 }
 static DEVICE_ATTR_RW(current_clocksource);
 
Index: linux-2.6/kernel/time/timekeeping.c
===================================================================
--- linux-2.6.orig/kernel/time/timekeeping.c
+++ linux-2.6/kernel/time/timekeeping.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/isolation.h>
 #include <linux/syscore_ops.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
@@ -1497,13 +1498,24 @@ static int change_clocksource(void *data
  * This function is called from clocksource.c after a new, better clock
  * source has been registered. The caller holds the clocksource_mutex.
  */
-int timekeeping_notify(struct clocksource *clock)
+int timekeeping_notify(struct clocksource *clock, bool fail)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
 	if (tk->tkr_mono.clock == clock)
 		return 0;
-	stop_machine(change_clocksource, clock, NULL);
+
+	if (!fail)
+		stop_machine(change_clocksource, clock, NULL);
+	else {
+		int ret;
+
+		block_interf_read_lock();
+		ret = stop_machine_fail(change_clocksource, clock, NULL);
+		block_interf_read_unlock();
+		if (ret)
+			return ret;
+	}
 	tick_clock_notify();
 	return tk->tkr_mono.clock == clock ? 0 : -1;
 }


