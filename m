Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7153A9B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355020AbiFAPPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354987AbiFAPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:15:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46F91552
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:15:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q21so2817283wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlAz9A27qP0uAwYahd1NHsUql8CrfwMJT64PfEqDJMI=;
        b=kNFa3FVHpmOpee0ov9lHYqpmsQPsVFKvOFXdMws1goL+fcdBmdkpayFsqyu5WJdDui
         lIs/kYmB2pV7cFtha1kWmdYntxkTvN6N9ZAGFN+/F6PXrTqWMdFcGx6uAFalBZvKuanB
         rU1sSd2ihYJHHPdvxbwhuHKk7BbS8cVi7/rPzh/3w6fWnIRm7FUYdnOSPrRRkMyLJmwJ
         GtlCbcB45EZLTmAuia7dbJ4gZAr34Zf7X7rQzQBOaDsxz2VIq0zZnbA152Vk+xg2dDC8
         yM0/6qFWIjYWxNAGteUgeRA4JeOWdUWvDtGdEkobXK/XpGTgjR/r1P0LvovD07fdI2fb
         MzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlAz9A27qP0uAwYahd1NHsUql8CrfwMJT64PfEqDJMI=;
        b=cBlI7RQQuoYNMJA8vaIEpUV39Un5c+aQ7wmS82ItQtHnpo0Za5j/lini4k5mr2z4h5
         BV5dGhzDL9WNV+r/nhqF+Q2F8QVPPZehxkRXjSW2LaIIsneJUWpeJKjnWgbNyjU6CV0V
         l+I0x0f8dcPwVfHFdX+ly9p2mIdL7BMmNw3B3N3GsA2XPH+Q6M8WN6FOd7bT2qJy6Kj8
         gTqWXtuW+OcQzmpcgbqlpnIQBuWXg2x0zV5eejukMDxASD3OAuLtq8rt99/AjsjDluN0
         xAu1lMfXdG/upu+db4KHNhlEQNR0tTAntATcM3hLWziHzMde1wHQo7krSOYXnLCLQWZD
         jKLw==
X-Gm-Message-State: AOAM53174HAUHR9hXg7NA80R/97AyvKXbPZrtZ5LCtEIaBDJOTkQDstn
        U73bWb8nm8bdtgEq/KvSxY6tIA==
X-Google-Smtp-Source: ABdhPJxtJvO+YkKSAiJWREsk+b+J81DXBGYIb6OjJ1+rwq/de2T760Q5FYiqP6eMRM7bewQTvWeGng==
X-Received: by 2002:a05:6000:2a9:b0:210:2530:be32 with SMTP id l9-20020a05600002a900b002102530be32mr231684wry.153.1654096499280;
        Wed, 01 Jun 2022 08:14:59 -0700 (PDT)
Received: from localhost.localdomain (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm1882077wrp.114.2022.06.01.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:14:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/3] thermal/debugfs: Add debugfs information
Date:   Wed,  1 Jun 2022 17:14:40 +0200
Message-Id: <20220601151441.9128-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601151441.9128-1-daniel.lezcano@linaro.org>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
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

The thermal framework does not have any debug information except a
sysfs stat which is a bit controversial. This one allocates big chunks
of memory for every cooling devices with a high number of states and
could represent on some systems in production several megabytes of
memory for just a portion of it. As the syfs is limited to a page
size, the output is not exploitable with large data array and gets
truncated.

The patch provides the same information than sysfs except the
transitions are dynamically allocated, thus they won't represent more
events than the ones which actually occured. There is no longer a size
limitation and it opens the field for more debugging information where
the debugfs is designed for, not sysfs.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   3 +
 drivers/thermal/thermal_core.c    |  10 +
 drivers/thermal/thermal_core.h    |   1 +
 drivers/thermal/thermal_debugfs.c | 362 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |  17 ++
 drivers/thermal/thermal_helpers.c |   1 +
 include/linux/thermal.h           |   7 +
 8 files changed, 408 insertions(+)
 create mode 100644 drivers/thermal/thermal_debugfs.c
 create mode 100644 drivers/thermal/thermal_debugfs.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e5cc948373c..42400c6aed61 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -33,6 +33,13 @@ config THERMAL_STATISTICS
 
 	  If in doubt, say N.
 
+config THERMAL_DEBUGFS
+	bool "Thermal debugging file system"
+	depends on DEBUG_FS
+	help
+	  This option provides a debugfs entry giving useful
+	  information about the thermal framework internals.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..1d498fa1beba 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -10,6 +10,9 @@ thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 
+# debugfs interface to investigate the behavior and statistics
+thermal_sys-$(CONFIG_THERMAL_DEBUGFS)	+= thermal_debugfs.o
+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..a2d6eb0d0895 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -944,6 +944,8 @@ __thermal_cooling_device_register(struct device_node *np,
 						   THERMAL_EVENT_UNSPECIFIED);
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_debugfs_cdev_register(cdev);
+	
 	return cdev;
 
 out_kfree_type:
@@ -1079,6 +1081,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	if (!cdev)
 		return;
 
+	thermal_debugfs_cdev_unregister(cdev);
+
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_cdev_list, node)
 		if (pos == cdev)
@@ -1311,6 +1315,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	thermal_notify_tz_create(tz->id, tz->type);
 
+	thermal_debugfs_tz_register(tz);
+
 	return tz;
 
 unregister:
@@ -1340,6 +1346,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
+	thermal_debugfs_tz_unregister(tz);
+	
 	tzp = tz->tzp;
 	tz_id = tz->id;
 
@@ -1485,6 +1493,8 @@ static int __init thermal_init(void)
 		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
 			result);
 
+	thermal_debugfs_init();
+	
 	return 0;
 
 unregister_class:
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 4689f6cf898f..49331b8a5404 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_netlink.h"
+#include "thermal_debugfs.h"
 
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
new file mode 100644
index 000000000000..d22558d06da0
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Debug filesystem for thermal framework
+ */
+#include <linux/debugfs.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/thermal.h>
+
+static struct dentry *rootd;
+static struct dentry *cdevd;
+static struct dentry *tzd;
+
+/*
+ * Length of the string containing the thermal zone id, including the
+ * ending null character. We can reasonably assume there won't be more
+ * than 256 thermal zones as the maximum observed today is around 32.
+ */
+#define IDSLENGTH 4
+
+/*
+ * The cooling device transition list is stored in a hash table where
+ * the size is CDEVSTATS_HASH_SIZE. The majority of cooling devices
+ * have dozen of states but some can have much more, so a hash table
+ * is more adequate in this case because browsing the entire list when
+ * storing the transitions could have a non neglictible cost
+ */
+#define CDEVSTATS_HASH_SIZE 16
+
+struct cdev_value {
+	struct list_head list;
+	int id;
+	u64 value;
+};
+
+struct cdev_debugfs {
+	u32 total;
+	int current_state;
+	ktime_t timestamp;
+	struct mutex lock;
+	struct list_head trans_list[CDEVSTATS_HASH_SIZE];
+	struct list_head duration_list[CDEVSTATS_HASH_SIZE];
+};
+
+struct thermal_debugfs {
+	struct dentry *d_top;
+	union {
+		struct cdev_debugfs cdev;
+	};
+};
+
+void thermal_debugfs_init(void)
+{
+	rootd = debugfs_create_dir("thermal", NULL);
+	if (!rootd)
+		return;
+
+	cdevd = debugfs_create_dir("cooling_devices", rootd);
+	if (!cdevd)
+		return;
+
+	tzd = debugfs_create_dir("thermal_zones", rootd);
+}
+
+static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
+{
+	struct thermal_debugfs *dfs;
+	char ids[IDSLENGTH];
+
+	dfs = kzalloc(sizeof(*dfs), GFP_KERNEL);
+	if (!dfs)
+		return NULL;
+
+	snprintf(ids, IDSLENGTH, "%d", id);
+
+	dfs->d_top = debugfs_create_dir(ids, d);
+	if (!dfs->d_top) {
+		kfree(dfs);
+		return NULL;
+	}
+
+	return dfs;
+}
+
+static void thermal_debugfs_remove_id(struct thermal_debugfs *dfs)
+{
+	if (!dfs)
+		return;
+
+	debugfs_remove(dfs->d_top);
+	kfree(dfs);
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_alloc(int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = kzalloc(sizeof(*cdev_value), GFP_KERNEL);
+	if (cdev_value) {
+		cdev_value->id = id;
+		INIT_LIST_HEAD(&cdev_value->list);
+	}
+
+	return cdev_value;
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_find(struct thermal_debugfs *dfs,
+							  struct list_head *list, int id)
+{
+	struct cdev_value *pos;
+
+	list_for_each_entry(pos, &list[id % CDEVSTATS_HASH_SIZE], list)
+		if (pos->id == id)
+			return pos;
+
+	return NULL;
+}
+
+static void thermal_debugfs_cdev_value_insert(struct thermal_debugfs *dfs,
+					      struct list_head *list,
+					      struct cdev_value *cdev_value)
+{
+	list_add_tail(&cdev_value->list, &list[cdev_value->id % CDEVSTATS_HASH_SIZE]);
+}
+
+struct cdev_value *thermal_debugfs_cdev_value_get(struct thermal_debugfs *dfs,
+						  struct list_head *list, int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_find(dfs, list, id);
+	if (cdev_value)
+		return cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_alloc(id);
+	if (cdev_value)
+		thermal_debugfs_cdev_value_insert(dfs, list, cdev_value);
+
+	return cdev_value;
+}
+
+static void thermal_debugfs_cdev_reset(struct cdev_debugfs *cfs)
+{
+	int i;
+	struct cdev_value *pos, *tmp;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+
+		list_for_each_entry_safe(pos, tmp, &cfs->trans_list[i], list) {
+			list_del(&pos->list);
+			kfree(pos);
+		}
+
+		list_for_each_entry_safe(pos, tmp, &cfs->duration_list[i], list) {
+			list_del(&pos->list);
+			kfree(pos);
+		}
+	}
+
+	cfs->total = 0;
+}
+
+void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int to)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+	struct cdev_debugfs *cfs;
+	struct cdev_value *cdev_value;
+	ktime_t now = ktime_get();
+	int transition, from;
+
+	if (!dfs || (dfs->cdev.current_state == to))
+		return;
+
+	cfs = &dfs->cdev;
+
+	mutex_lock(&cfs->lock);
+
+	from = cfs->current_state;
+	cfs->current_state = to;
+	transition = (from << 16) | to;
+
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->duration_list, from);
+	if (cdev_value) {
+		cdev_value->value += ktime_ms_delta(now, cfs->timestamp);
+		cfs->timestamp = now;
+	}
+
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->trans_list, transition);
+	if (cdev_value)
+		cdev_value->value++;
+
+	cfs->total++;
+
+	mutex_unlock(&cfs->lock);
+}
+
+static void *cdev_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct cdev_debugfs *cfs =  s->private;
+
+	mutex_lock(&cfs->lock);
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void *cdev_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void cdev_seq_stop(struct seq_file *s, void *v)
+{
+	struct cdev_debugfs *cfs =  s->private;
+
+	mutex_unlock(&cfs->lock);
+}
+
+static int cdev_tt_seq_show(struct seq_file *s, void *v)
+{
+	struct cdev_debugfs *cfs =  s->private;
+	struct list_head *trans_list = cfs->trans_list;
+	struct cdev_value *pos;
+	char buffer[11];
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "Transition\tHits\n");
+
+	list_for_each_entry(pos, &trans_list[i], list) {
+
+		snprintf(buffer, ARRAY_SIZE(buffer) - 1, "%d->%d",
+			 pos->id >> 16, pos->id & 0xFFFF);
+
+		seq_printf(s, "%-10s\t%-10llu\n", buffer, pos->value);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_tt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tt);
+
+static int cdev_dt_seq_show(struct seq_file *s, void *v)
+{
+	struct cdev_debugfs *cfs = s->private;
+	struct list_head *duration_list = cfs->duration_list;
+	struct cdev_value *pos;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "State\tTime\n");
+
+	list_for_each_entry(pos, &duration_list[i], list) {
+		s64 duration = pos->value;
+
+		if (pos->id == cfs->current_state)
+			duration += ktime_ms_delta(ktime_get(), cfs->timestamp);
+
+		seq_printf(s, "%-5d\t%-10llu\n", pos->id, duration);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations dt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_dt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(dt);
+
+static int cdev_reset_set(void *data, u64 val)
+{
+	struct cdev_debugfs *cfs = data;
+
+	if (!val)
+		return -EINVAL;
+
+	thermal_debugfs_cdev_reset(cfs);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdev_reset_fops, NULL, cdev_reset_set, "%llu\n");
+
+void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs;
+	struct cdev_debugfs *cfs;
+	int i;
+
+	if (!cdevd)
+		return;
+
+	dfs = thermal_debugfs_add_id(cdevd, cdev->id);
+	if (!dfs)
+		return;
+
+	cfs = &dfs->cdev;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&cfs->trans_list[i]);
+		INIT_LIST_HEAD(&cfs->duration_list[i]);
+	}
+
+	mutex_init(&cfs->lock);
+	cfs->current_state = 0;
+	cfs->timestamp = ktime_get();
+
+	debugfs_create_file("trans_table", 0400, dfs->d_top, cfs, &tt_fops);
+
+	debugfs_create_file("time_in_state_ms", 0400, dfs->d_top, cfs, &dt_fops);
+
+	debugfs_create_file("reset", 0200, dfs->d_top, cfs, &cdev_reset_fops);
+
+	debugfs_create_u32("total_trans", 0400, dfs->d_top, &cfs->total);
+
+	cdev->debugfs = dfs;
+}
+
+void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+
+	if (!dfs)
+		return;
+
+	debugfs_remove(dfs->d_top);
+	thermal_debugfs_cdev_reset(&dfs->cdev);
+	cdev->debugfs = NULL;
+	kfree(dfs);
+}
+
+void thermal_debugfs_tz_register(struct thermal_zone_device *tz)
+{
+	if (!tz)
+		return;
+
+	tz->debugfs = thermal_debugfs_add_id(tzd, tz->id);
+}
+
+void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz)
+{
+	thermal_debugfs_remove_id(tz->debugfs);
+
+	tz->debugfs = NULL;
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
new file mode 100644
index 000000000000..529f5bda931b
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_THERMAL_DEBUGFS
+void thermal_debugfs_init(void);
+void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev);
+void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev);
+void thermal_debugfs_tz_register(struct thermal_zone_device *tz);
+void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz);
+void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int state);
+#else
+static inline void thermal_debugfs_init(void);
+static inline void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debugfs_tz_register(struct thermal_zone_device *tz) {}
+static inline void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz) {}
+static inline void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int state) {}
+#endif /* CONFIG_THERMAL_DEBUGFS */
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index d5f162fad1ab..040d9e9b55e1 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -205,6 +205,7 @@ int thermal_cdev_set_state(struct thermal_cooling_device *cdev, int state)
 	if (!ret) {
 		thermal_notify_cdev_state_update(cdev->id, state);
 		thermal_cooling_device_stats_update(cdev, state);
+		thermal_debugfs_cdev_transition(cdev, state);
 	}
 
 	return ret;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 365733b428d8..4a69e8a6868e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -34,6 +34,7 @@
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
+struct thermal_debugfs;
 struct thermal_attr;
 
 enum thermal_trend {
@@ -101,6 +102,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
@@ -174,6 +178,9 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
-- 
2.25.1

