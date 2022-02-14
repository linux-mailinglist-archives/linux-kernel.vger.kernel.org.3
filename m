Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85164B4E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiBNLYN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:24:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350935AbiBNLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:23:51 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43AA170048
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:59:11 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-FLtZyrvGNYCv9PgvGY4JhA-1; Mon, 14 Feb 2022 05:47:59 -0500
X-MC-Unique: FLtZyrvGNYCv9PgvGY4JhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9769801B0E;
        Mon, 14 Feb 2022 10:47:56 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5948926E7E;
        Mon, 14 Feb 2022 10:47:51 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC V2 17/21] watchdog/dev: Add tracepoints
Date:   Mon, 14 Feb 2022 11:45:08 +0100
Message-Id: <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a set of tracepoints, enabling the observability of the watchdog
device interactions with user-space.

The events are:
	watchdog:watchdog_open
	watchdog:watchdog_close
	watchdog:watchdog_start
	watchdog:watchdog_stop
	watchdog:watchdog_set_timeout
	watchdog:watchdog_ping
	watchdog:watchdog_nowayout
	watchdog:watchdog_set_keep_alive
	watchdog:watchdog_keep_alive

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
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
 drivers/watchdog/watchdog_dev.c |  41 ++++++++++++-
 include/linux/watchdog.h        |   7 +--
 include/trace/events/watchdog.h | 103 ++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 9 deletions(-)
 create mode 100644 include/trace/events/watchdog.h

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3a3d8b5c7ad5..0beeac5d4541 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -44,6 +44,9 @@
 #include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/watchdog.h>
+
 #include "watchdog_core.h"
 #include "watchdog_pretimeout.h"
 
@@ -130,9 +133,11 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
 	if (watchdog_need_worker(wdd)) {
 		ktime_t t = watchdog_next_keepalive(wdd);
 
-		if (t > 0)
+		if (t > 0) {
 			hrtimer_start(&wd_data->timer, t,
 				      HRTIMER_MODE_REL_HARD);
+			trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
+		}
 	} else {
 		hrtimer_cancel(&wd_data->timer);
 	}
@@ -149,14 +154,16 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 	now = ktime_get();
 
 	if (ktime_after(earliest_keepalive, now)) {
-		hrtimer_start(&wd_data->timer,
-			      ktime_sub(earliest_keepalive, now),
+		ktime_t t = ktime_sub(earliest_keepalive, now);
+		hrtimer_start(&wd_data->timer, t,
 			      HRTIMER_MODE_REL_HARD);
+		trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
 		return 0;
 	}
 
 	wd_data->last_hw_keepalive = now;
 
+	trace_watchdog_ping(wdd);
 	if (wdd->ops->ping)
 		err = wdd->ops->ping(wdd);  /* ping the watchdog */
 	else
@@ -215,6 +222,7 @@ static void watchdog_ping_work(struct kthread_work *work)
 	wd_data = container_of(work, struct watchdog_core_data, work);
 
 	mutex_lock(&wd_data->lock);
+	trace_watchdog_keep_alive(wd_data->wdd);
 	if (watchdog_worker_should_ping(wd_data))
 		__watchdog_ping(wd_data->wdd);
 	mutex_unlock(&wd_data->lock);
@@ -252,6 +260,8 @@ static int watchdog_start(struct watchdog_device *wdd)
 
 	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
 
+	trace_watchdog_start(wdd);
+
 	started_at = ktime_get();
 	if (watchdog_hw_running(wdd) && wdd->ops->ping) {
 		err = __watchdog_ping(wdd);
@@ -298,6 +308,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return -EBUSY;
 	}
 
+	trace_watchdog_stop(wdd);
 	if (wdd->ops->stop) {
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
@@ -370,6 +381,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
+	trace_watchdog_set_timeout(wdd, timeout);
 	if (wdd->ops->set_timeout) {
 		err = wdd->ops->set_timeout(wdd, timeout);
 	} else {
@@ -432,6 +444,23 @@ static int watchdog_get_timeleft(struct watchdog_device *wdd,
 	return 0;
 }
 
+/*
+ * watchdog_set_nowayout - set nowaout bit
+ * @wdd:	The watchdog device to set nowayoutbit
+ * @nowayout	A boolean on/off switcher
+ *
+ * If nowayout boolean is true, the nowayout option is set. No action is
+ * taken if nowayout is false.
+ */
+void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
+{
+	if (nowayout) {
+		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
+		trace_watchdog_nowayout(wdd);
+	}
+}
+EXPORT_SYMBOL(watchdog_set_nowayout);
+
 #ifdef CONFIG_WATCHDOG_SYSFS
 static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
@@ -457,6 +486,7 @@ static ssize_t nowayout_store(struct device *dev, struct device_attribute *attr,
 	/* nowayout cannot be disabled once set */
 	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status) && !value)
 		return -EPERM;
+
 	watchdog_set_nowayout(wdd, value);
 	return len;
 }
@@ -858,6 +888,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 		goto out_clear;
 	}
 
+	trace_watchdog_open(wdd);
+
 	err = watchdog_start(wdd);
 	if (err < 0)
 		goto out_mod;
@@ -880,6 +912,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
 out_mod:
+	trace_watchdog_close(wdd);
 	module_put(wd_data->wdd->ops->owner);
 out_clear:
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
@@ -940,6 +973,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 
+	trace_watchdog_close(wdd);
 done:
 	running = wdd && watchdog_hw_running(wdd);
 	mutex_unlock(&wd_data->lock);
@@ -952,6 +986,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		module_put(wd_data->cdev.owner);
 		put_device(&wd_data->dev);
 	}
+
 	return 0;
 }
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 99660197a36c..11d93407e492 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -139,12 +139,7 @@ static inline bool watchdog_hw_running(struct watchdog_device *wdd)
 	return test_bit(WDOG_HW_RUNNING, &wdd->status);
 }
 
-/* Use the following function to set the nowayout feature */
-static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
-{
-	if (nowayout)
-		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
-}
+void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout);
 
 /* Use the following function to stop the watchdog on reboot */
 static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
diff --git a/include/trace/events/watchdog.h b/include/trace/events/watchdog.h
new file mode 100644
index 000000000000..5d5617ab611a
--- /dev/null
+++ b/include/trace/events/watchdog.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM watchdog
+
+#if !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_WATCHDOG_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(dev_operations_template,
+
+	TP_PROTO(struct watchdog_device *wdd),
+
+	TP_ARGS(wdd),
+
+	TP_STRUCT__entry(
+		__field(__u32, id)
+	),
+
+	TP_fast_assign(
+		__entry->id = wdd->id;
+	),
+
+	TP_printk("id=%d",
+		  __entry->id)
+);
+
+/*
+ * Add a comment
+ */
+DEFINE_EVENT(dev_operations_template, watchdog_open,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+DEFINE_EVENT(dev_operations_template, watchdog_close,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+DEFINE_EVENT(dev_operations_template, watchdog_start,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+DEFINE_EVENT(dev_operations_template, watchdog_stop,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+DEFINE_EVENT(dev_operations_template, watchdog_ping,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+DEFINE_EVENT(dev_operations_template, watchdog_keep_alive,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+DEFINE_EVENT(dev_operations_template, watchdog_nowayout,
+	     TP_PROTO(struct watchdog_device *wdd),
+	     TP_ARGS(wdd));
+
+
+TRACE_EVENT(watchdog_set_timeout,
+
+	TP_PROTO(struct watchdog_device *wdd, u64 timeout),
+
+	TP_ARGS(wdd, timeout),
+
+	TP_STRUCT__entry(
+		__field(__u32, id)
+		__field(__u64, timeout)
+	),
+
+	TP_fast_assign(
+		__entry->id		= wdd->id;
+		__entry->timeout	= timeout;
+	),
+
+	TP_printk("id=%d timeout=%llus",
+		  __entry->id, __entry->timeout)
+);
+
+TRACE_EVENT(watchdog_set_keep_alive,
+
+	TP_PROTO(struct watchdog_device *wdd, u64 timeout),
+
+	TP_ARGS(wdd, timeout),
+
+	TP_STRUCT__entry(
+		__field(__u32, id)
+		__field(__u64, timeout)
+	),
+
+	TP_fast_assign(
+		__entry->id		= wdd->id;
+		__entry->timeout	= timeout;
+	),
+
+	TP_printk("id=%d keep_alive=%llums",
+		  __entry->id, __entry->timeout)
+);
+
+#endif /* _TRACE_WATCHDOG_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.33.1

