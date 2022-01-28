Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACBD49F2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiA1Ez6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbiA1Ezp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:55:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C06CC061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:55:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so6537835pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EST4yPRhpYd4j6/4I3VVjJykcTXmME6pCSAXeD9O2oI=;
        b=a4omuQ8xjejCbxr6+rlGqzBUPSW52h2bcZrDlUg61UqWinEPJJUWkn0Hiof028jMzv
         XuoAWcKWy7F62VF8D33FMSQS6vEfLfr3BplzE1WnhJdFf7qiV1ve78laLaVU3UQVK6m6
         iVdE9RhGeEOF8ZOCz6+UuuZ1r0evIcT8EmfwkJOHOQpYWJgDAApDf47zB5TurYlKccD8
         NInEQRSW3BgNes7Ckk4OEwinat1VgC7R51rqF6cp1fihMEWXMZ/QiHvdguAfeBJOJbRD
         zxy2T0uzfk4mtqv+sdHM9wtOgqiIICsJmum56TEs7I0tbVXiAR+wT56ApDAxegCYMlPO
         yC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EST4yPRhpYd4j6/4I3VVjJykcTXmME6pCSAXeD9O2oI=;
        b=4+KByqsw1aQCI+1VYjNzjVH/Kx9P//SYn5m6RIGoAIDz65DPeiWxmz4ID79PZws9LJ
         rY5De7tvEd2Fr4+5bITmocTLJQYs5MfRR7J6ic1SLXJgh6Xk8cWqUNdPrsi/A+iVoklc
         U4orPqBdTAae5sjkKyInHGTN8J+NYGwoJuppQiB74xgia42FtwhwNlYRb9OZ9eLYtx9k
         c2lVyXXTYm2Uu1YgPIg/2INeAoNBsLM6YjNn80bovm2E9hXFuwpI5EjISLQsmiL9DuGS
         0IQTLJk/fP8xnVyb9hrZY7rvOcZDEmOvNdjvXHPXwy+HeHwKNVKfGtFQbv7O+IjaybEq
         C+Hw==
X-Gm-Message-State: AOAM530ZrYRb0a88OP0G9UeWV4/yUtV+ion+qYte4DiJ9+h0iOOigtET
        +iu6ZtXcyJhDKne3U2FlFcov7Q==
X-Google-Smtp-Source: ABdhPJws5e/bf1O5+jHM7h0S19SpwnFB7zNd9TDJSuO1sCdmqRfAA1qjZvfqoIilXgJRZk/fJFBXyg==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr17817198pjb.106.1643345744949;
        Thu, 27 Jan 2022 20:55:44 -0800 (PST)
Received: from localhost.localdomain ([103.117.248.198])
        by smtp.gmail.com with ESMTPSA id e4sm20316238pge.74.2022.01.27.20.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:55:44 -0800 (PST)
From:   Zichar Zhang <zichar.zhang@linaro.org>
To:     zichar.zhang@linaro.org
Cc:     gregkh@linuxfoundation.org, john.stultz@linaro.org,
        krossmo@google.com, lee.jones@linaro.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        nayakvij@google.com, pavel@ucw.cz, rafael@kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        kernel-team@android.com
Subject: [PATCH 1/1] [RFC] wakeup_reason: Add infrastructure to log and report why the system resumed from suspend.
Date:   Fri, 28 Jan 2022 12:55:22 +0800
Message-Id: <20220128045522.3505336-1-zichar.zhang@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
References: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When optimizing for power usage, it's useful to be able to track and
log each time why the system woke up from suspend. This is useful as
it helps us understand why we might be seeing more wakeups then we
expect. For a while now, Android has carried the "wakeup_reasons"
patch which provides this to allow developers to optimize battery life
on devices.

This patch tries to provide a simplified version of the
Android wakeup_reasons functionality. It tracks both software
wakeup_sources as well as IRQS that brought the device out of suspend,
and exposes these values as a string via /sys/power/last_wakeup_reason.

This differs slightly from the Android patch, in that it doesn't track
the suspend-abort reason logging, the misconfigured or unmapped IRQS,
the threaded IRQS, and time spent in suspend/resume. But it provides
an initial simple step to add a useful portion of the logic.

Here is the requirements from https://lkml.org/lkml/2022/1/10/1134 for
"wakeup_reason" with line head "[Y]" and "[N]" to notify if this commit
meet the requirements or not. And if it is not, the detail reason is
right behind it after "--".

* wakeup IRQs, including:
    [Y]* multiple IRQs if more than one is pending during resume flow
    [N]* unmapped HW IRQs
    [N]* misconfigured IRQs
    [N]* threaded IRQs (not just the parent chip's IRQ)
    -- If we do these things, the additional codes should be added in
    interrupt subsystem or some interrupt controller drivers. These
    codes are no relationship with the interrupt subsystem or the
    interrupt controllers. And we can't distinguish these IRQs from
    "non-suspend" environment, even the "Android patch" can't do that.
    So it will make the things complicated.
    -- If these IRQs do hanpen, the code in this commit will catch
    them as "unknown wakeup reason" and suggest user to check the
    kernel log for more information.
    -- I think We should cooperate with interrupt subsystem to log
    these "abnormal" IRQs. And it could be several additional
    commits to accomplish this work together then.

* non-IRQ wakeups, including:
    [Y]* wakeups caused by an IRQ that was consumed by lower-level SW
    [Y]* wakeups from SOC architecture that don't manifest as IRQs

* abort reasons, including:
    [N]* wakeup_source activity
    [N]* failure to freeze userspace
    [N]* failure to suspend devices
    [N]* failed syscore_suspend callback
    -- These codes are "intrusive" to kernel (suspend/resume).
    -- These "errors" are already printed in kernel log, if we add
    these log to "wakeup_reason" either, it will cause double
    "log string" in section ".data", which just waste of the memory.
    -- As mentioned before, if these "abort action" happened, you
    can catch string "unknown wakeup reason", and check the kernel
    log then.

* durations from the most recent cycle, including:
    [N]* time spent doing suspend/resume work
    [N]* time spent in suspend
    -- Just separate these from "wakeup reason". It should be done
    in another commit.

This patch can be tested in Android using the following change to AOSP:
  https://android-review.googlesource.com/c/platform/system/hardware/interfaces/+/1958666

And there is a stress test code for the interfaces in kernel:
  https://android-review.googlesource.com/c/kernel/common/+/1958189

Any feedback or thoughts would be welcome!

Signed-off-by: Zichar Zhang <zichar.zhang@linaro.org>
Change-Id: Id70f3cbec15f24ea999d7f643e9589be9c047f2b
---
 Documentation/ABI/testing/sysfs-power |   9 ++
 drivers/base/power/wakeup.c           |   6 +
 include/linux/wakeup_reason.h         |  35 +++++
 kernel/power/Makefile                 |   1 +
 kernel/power/main.c                   |  11 ++
 kernel/power/wakeup_reason.c          | 183 ++++++++++++++++++++++++++
 6 files changed, 245 insertions(+)
 create mode 100644 include/linux/wakeup_reason.h
 create mode 100644 kernel/power/wakeup_reason.c

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 90ec4987074b..e79d7a49a24e 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -182,6 +182,15 @@ Description:
 		to a sleep state if any wakeup events are reported after the
 		write has returned.
 
+What:		/sys/power/last_wakeup_reason
+Date:		Jan 2022
+Contact:	Zichar Zhang <zichar.zhang@linaro.org>
+Description:
+		The /sys/power/last_wakeup_reason file shows the last reason
+		causing system "wake up" from suspend state. It could be an
+		interrupt signal, a kernel "wakeup_source" or just some other
+		reason logged into this file, and shows as a string.
+
 What:		/sys/power/reserved_size
 Date:		May 2011
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 99bda0da23a8..a91ee1b8c0df 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/pm_wakeirq.h>
+#include <linux/wakeup_reason.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -924,6 +925,7 @@ bool pm_wakeup_pending(void)
 
 	if (ret) {
 		pm_pr_dbg("Wakeup pending, aborting suspend\n");
+		log_ws_wakeup_reason();
 		pm_print_active_wakeup_sources();
 	}
 
@@ -947,11 +949,15 @@ void pm_wakeup_clear(bool reset)
 	pm_wakeup_irq = 0;
 	if (reset)
 		atomic_set(&pm_abort_suspend, 0);
+
+	clear_wakeup_reason();
 }
 
 void pm_system_irq_wakeup(unsigned int irq_number)
 {
 	if (pm_wakeup_irq == 0) {
+		log_irq_wakeup_reason(irq_number);
+
 		pm_wakeup_irq = irq_number;
 		pm_system_wakeup();
 	}
diff --git a/include/linux/wakeup_reason.h b/include/linux/wakeup_reason.h
new file mode 100644
index 000000000000..8d6e7a0e0bad
--- /dev/null
+++ b/include/linux/wakeup_reason.h
@@ -0,0 +1,35 @@
+/*
+ * include/linux/wakeup_reason.h
+ *
+ * Logs the reason which caused the kernel to resume
+ * from the suspend mode.
+ *
+ * Copyright (C) 2021 Linaro, Inc.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_WAKEUP_REASON_H
+#define _LINUX_WAKEUP_REASON_H
+
+#define MAX_WAKEUP_REASON_STR_LEN 256
+
+#ifdef CONFIG_SUSPEND
+ssize_t log_ws_wakeup_reason(void);
+ssize_t log_irq_wakeup_reason(unsigned int irq_number);
+void clear_wakeup_reason(void);
+ssize_t last_wakeup_reason_get(char *buf, ssize_t max);
+#else
+ssize_t log_ws_wakeup_reason(void) { }
+ssize_t log_irq_wakeup_reason(unsigned int irq_number) { }
+void clear_wakeup_reason(void) { }
+ssize_t last_wakeup_reason_get(char *buf, ssize_t max) { }
+#endif
+
+#endif /* _LINUX_WAKEUP_REASON_H */
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 5899260a8bef..73d77edc6a08 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o
 obj-$(CONFIG_HIBERNATION_SNAPSHOT_DEV) += user.o
 obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
 obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
+obj-$(CONFIG_PM_SLEEP)		+= wakeup_reason.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 44169f3081fd..859af097813c 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -16,6 +16,7 @@
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/pm_runtime.h>
+#include <linux/wakeup_reason.h>
 
 #include "power.h"
 
@@ -739,6 +740,15 @@ static ssize_t wakeup_count_store(struct kobject *kobj,
 
 power_attr(wakeup_count);
 
+static ssize_t last_wakeup_reason_show(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				char *buf)
+{
+	return last_wakeup_reason_get(buf, PAGE_SIZE);
+}
+
+power_attr_ro(last_wakeup_reason);
+
 #ifdef CONFIG_PM_AUTOSLEEP
 static ssize_t autosleep_show(struct kobject *kobj,
 			      struct kobj_attribute *attr,
@@ -892,6 +902,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_SLEEP
 	&pm_async_attr.attr,
 	&wakeup_count_attr.attr,
+	&last_wakeup_reason_attr.attr,
 #ifdef CONFIG_SUSPEND
 	&mem_sleep_attr.attr,
 	&sync_on_suspend_attr.attr,
diff --git a/kernel/power/wakeup_reason.c b/kernel/power/wakeup_reason.c
new file mode 100644
index 000000000000..38d5f5e4d373
--- /dev/null
+++ b/kernel/power/wakeup_reason.c
@@ -0,0 +1,183 @@
+/*
+ * driver/base/power/wakeup_reason.c
+ *
+ * Logs the reasons which caused the kernel to resume from
+ * the suspend mode.
+ *
+ * Copyright (C) 2021 Linaro, Inc.
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/notifier.h>
+#include <linux/suspend.h>
+#include <linux/wakeup_reason.h>
+
+static DEFINE_SPINLOCK(wakeup_reason_lock);
+
+static bool capture_reasons;
+static char wakeup_reason_str[MAX_WAKEUP_REASON_STR_LEN];
+
+ssize_t log_ws_wakeup_reason(void)
+{
+	struct wakeup_source *ws, *last_active_ws = NULL;
+	int idx, max, len = 0;
+	bool active = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wakeup_reason_lock, flags);
+
+	if (!capture_reasons) {
+		goto out;
+	}
+
+	idx = wakeup_sources_read_lock();
+	max = MAX_WAKEUP_REASON_STR_LEN;
+	for_each_wakeup_source(ws) {
+		if (ws->active && len < max) {
+			if (!active)
+				len += scnprintf(wakeup_reason_str, max,
+						"Pending Wakeup Sources: ");
+			len += scnprintf(wakeup_reason_str + len, max - len,
+				"%s ", ws->name);
+			active = true;
+		} else if (!active &&
+			   (!last_active_ws ||
+			    ktime_to_ns(ws->last_time) >
+			    ktime_to_ns(last_active_ws->last_time))) {
+			last_active_ws = ws;
+		}
+	}
+	if (!active && last_active_ws) {
+		len = scnprintf(wakeup_reason_str, max,
+				"Last active Wakeup Source: %s",
+				last_active_ws->name);
+	}
+	len += scnprintf(wakeup_reason_str + len, max - len, "\n");
+	wakeup_sources_read_unlock(idx);
+
+out:
+	spin_unlock_irqrestore(&wakeup_reason_lock, flags);
+
+	return len;
+}
+EXPORT_SYMBOL(log_ws_wakeup_reason);
+
+ssize_t log_irq_wakeup_reason(unsigned int irq_number)
+{
+	int len = 0;
+	struct irq_desc *desc;
+	const char *name = "null";
+	unsigned long flags;
+
+	desc = irq_to_desc(irq_number);
+	if (desc == NULL)
+		name = "stray irq";
+	else if (desc->action && desc->action->name)
+		name = desc->action->name;
+
+	spin_lock_irqsave(&wakeup_reason_lock, flags);
+
+	len = strnlen(wakeup_reason_str, MAX_WAKEUP_REASON_STR_LEN);
+	len += scnprintf(wakeup_reason_str + len,
+			MAX_WAKEUP_REASON_STR_LEN - len,
+			"%d %s\n", irq_number, name);
+
+	spin_unlock_irqrestore(&wakeup_reason_lock, flags);
+
+	return len;
+}
+EXPORT_SYMBOL(log_irq_wakeup_reason);
+
+void clear_wakeup_reason(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wakeup_reason_lock, flags);
+
+	memset(wakeup_reason_str, 0, sizeof(wakeup_reason_str));
+
+	spin_unlock_irqrestore(&wakeup_reason_lock, flags);
+}
+EXPORT_SYMBOL(clear_wakeup_reason);
+
+ssize_t last_wakeup_reason_get(char *buf, ssize_t max)
+{
+	ssize_t len, size = 0;
+	unsigned long flags;
+
+	if (!buf) {
+		return 0;
+	}
+
+	spin_lock_irqsave(&wakeup_reason_lock, flags);
+
+	len = strnlen(wakeup_reason_str, MAX_WAKEUP_REASON_STR_LEN);
+	if (len > 0) {
+		size = scnprintf(buf, max, "%s", wakeup_reason_str);
+	} else {
+		size = -ENODATA;
+	}
+
+	spin_unlock_irqrestore(&wakeup_reason_lock, flags);
+
+	return size;
+}
+EXPORT_SYMBOL(last_wakeup_reason_get);
+
+static int wakeup_reason_pm_event(struct notifier_block *notifier,
+		unsigned long pm_event, void *unused)
+{
+	unsigned long flags;
+
+	switch (pm_event) {
+	case PM_SUSPEND_PREPARE:
+		spin_lock_irqsave(&wakeup_reason_lock, flags);
+		capture_reasons = true;
+		spin_unlock_irqrestore(&wakeup_reason_lock, flags);
+
+		clear_wakeup_reason();
+		break;
+	case PM_POST_SUSPEND:
+		spin_lock_irqsave(&wakeup_reason_lock, flags);
+		capture_reasons = false;
+		if (!strnlen(wakeup_reason_str, MAX_WAKEUP_REASON_STR_LEN)) {
+			scnprintf(wakeup_reason_str, MAX_WAKEUP_REASON_STR_LEN,
+				"unknown wakeup reason, please check the kernel log\n");
+		}
+		spin_unlock_irqrestore(&wakeup_reason_lock, flags);
+
+		pr_debug("Resume caused by %s\n", wakeup_reason_str);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block wakeup_reason_pm_notifier_block = {
+	.notifier_call = wakeup_reason_pm_event,
+};
+
+static int __init wakeup_reason_init(void)
+{
+	if (register_pm_notifier(&wakeup_reason_pm_notifier_block)) {
+		pr_warn("[%s] failed to register PM notifier\n", __func__);
+		return -EPERM;
+	}
+
+	return 0;
+}
+late_initcall(wakeup_reason_init);
-- 
2.25.1

