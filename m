Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21853A9BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355035AbiFAPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354999AbiFAPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:15:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5291568
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:15:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k16so2805458wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKt+Gy1AIZNq3CIoAAgp8yHidfZBIJZjm3pmQFW5Yak=;
        b=pqPRkw4WH/1zwAUlXvYQlyC0yZyH7aHVCPnV8R4B9VLg7gLkq42g1SR5SSCFm9b4vg
         uwKbNLfPBZTJ4EINve6v/h9F7LRWi0XHd663blHCNXc2iaXvIMaykVGBEmoCYD1iFhQV
         wO/K+PEWvv/JZ8+VVF7sHaGhRAzKaa0ZnctHdHBfJJ1dFeZTFexbF5RxlLhF+MVANMJK
         icI0N0yFi80vTP4XXdwPo6ZPyQpm7qDGEYdkJcFRJcEbdVH/MfCDhbqcWhkObc5Jw++S
         1LRHW8z//FLue6Ttg7M3eZhqw73i/lmkKaiwqBXCSLBLXgNK0NxuF2gLGTiYkT31KBGp
         TFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKt+Gy1AIZNq3CIoAAgp8yHidfZBIJZjm3pmQFW5Yak=;
        b=Ifkzx4DKzmXjAwCS1hvFsENgilRrrCE7qwCXhbeXXby8uey0SoIf3Kr67I8XknbmaO
         JQsis9ZHB1PJ8X5a0PiCACAI/OYugasRHjrpjwfAnFzCXMvBhKBIBdmCHnLNokC2YX9a
         qhTzPK6FIrN4zT6paUibHyc8W1L5//orE9CrC21GmAtsvAWPWf8+Yr6m4sbEDI9aoP96
         WkgdMYNiT4JFg2ZcJQkFjTkjEwhH4QFwV0enyVlYQfib3eO/XaT6YHcmYExQF6ApIve6
         uv19iGnYvSaKY4svBQi4amg6mF3qbQsPt6xHwotrZEhHhRsQVHbMWak+hqClH3ItDN1q
         aFlw==
X-Gm-Message-State: AOAM533wcDXZZqVAkV8qHtR4LWWowSsrtgrzdFezeE9fs3SlPdTra21u
        dxxg1dIE/vMfY1hUL8tZ7Miq9w==
X-Google-Smtp-Source: ABdhPJywqsSRJKSj+F/s/zNoQDw6IUfJXbgPq8Fv1IzqWesTdxk+6QKaYMefJ1jFSFyEthPDOEqpSg==
X-Received: by 2002:a05:6000:156f:b0:20f:d444:dcd with SMTP id 15-20020a056000156f00b0020fd4440dcdmr221934wrz.223.1654096500742;
        Wed, 01 Jun 2022 08:15:00 -0700 (PDT)
Received: from localhost.localdomain (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm1882077wrp.114.2022.06.01.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:15:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Date:   Wed,  1 Jun 2022 17:14:41 +0200
Message-Id: <20220601151441.9128-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601151441.9128-1-daniel.lezcano@linaro.org>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The statistics are for debugging purpose and belong to debugfs rather
than sysfs. As the previous changes introduced the same statistics in
debugfs, those in sysfs are no longer needed and can be removed.

That solves a couple of problems reported by different SoC vendors:

 - Extra memory used in low profile boards where the memory is limited
   resource

- Truncated information and memory allocation failure with cooling
   devices having a large number of states

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig           |   7 -
 drivers/thermal/thermal_core.c    |   2 -
 drivers/thermal/thermal_core.h    |  10 --
 drivers/thermal/thermal_helpers.c |   1 -
 drivers/thermal/thermal_sysfs.c   | 217 ------------------------------
 include/linux/thermal.h           |   1 -
 6 files changed, 238 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 42400c6aed61..0c7b776462a9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -26,13 +26,6 @@ config THERMAL_NETLINK
 	  trip point crossed, cooling device update or governor
 	  change. It is recommended to enable the feature.
 
-config THERMAL_STATISTICS
-	bool "Thermal state transition statistics"
-	help
-	  Export thermal state transition statistics information through sysfs.
-
-	  If in doubt, say N.
-
 config THERMAL_DEBUGFS
 	bool "Thermal debugging file system"
 	depends on DEBUG_FS
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a2d6eb0d0895..4851f2c7910f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -949,7 +949,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	return cdev;
 
 out_kfree_type:
-	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
 	put_device(&cdev->device);
 	cdev = NULL;
@@ -1117,7 +1116,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_del(&cdev->device);
-	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
 	put_device(&cdev->device);
 }
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 49331b8a5404..dcae52f20258 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -134,22 +134,12 @@ void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
-void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
 /* used only at binding time */
 ssize_t trip_point_show(struct device *, struct device_attribute *, char *);
 ssize_t weight_show(struct device *, struct device_attribute *, char *);
 ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 		     size_t);
 
-#ifdef CONFIG_THERMAL_STATISTICS
-void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
-					 unsigned long new_state);
-#else
-static inline void
-thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
-				    unsigned long new_state) {}
-#endif /* CONFIG_THERMAL_STATISTICS */
-
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
 int of_parse_thermal_zones(void);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 040d9e9b55e1..81185bb0d526 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -204,7 +204,6 @@ int thermal_cdev_set_state(struct thermal_cooling_device *cdev, int state)
 	ret = cdev->ops->set_cur_state(cdev, state);
 	if (!ret) {
 		thermal_notify_cdev_state_update(cdev->id, state);
-		thermal_cooling_device_stats_update(cdev, state);
 		thermal_debugfs_cdev_transition(cdev, state);
 	}
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 935e79909121..e48c5ad26611 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -641,231 +641,14 @@ static const struct attribute_group cooling_device_attr_group = {
 
 static const struct attribute_group *cooling_device_attr_groups[] = {
 	&cooling_device_attr_group,
-	NULL, /* Space allocated for cooling_device_stats_attr_group */
 	NULL,
 };
 
-#ifdef CONFIG_THERMAL_STATISTICS
-struct cooling_dev_stats {
-	spinlock_t lock;
-	unsigned int total_trans;
-	unsigned long state;
-	unsigned long max_states;
-	ktime_t last_time;
-	ktime_t *time_in_state;
-	unsigned int *trans_table;
-};
-
-static void update_time_in_state(struct cooling_dev_stats *stats)
-{
-	ktime_t now = ktime_get(), delta;
-
-	delta = ktime_sub(now, stats->last_time);
-	stats->time_in_state[stats->state] =
-		ktime_add(stats->time_in_state[stats->state], delta);
-	stats->last_time = now;
-}
-
-void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
-					 unsigned long new_state)
-{
-	struct cooling_dev_stats *stats = cdev->stats;
-
-	if (!stats)
-		return;
-
-	spin_lock(&stats->lock);
-
-	if (stats->state == new_state)
-		goto unlock;
-
-	update_time_in_state(stats);
-	stats->trans_table[stats->state * stats->max_states + new_state]++;
-	stats->state = new_state;
-	stats->total_trans++;
-
-unlock:
-	spin_unlock(&stats->lock);
-}
-
-static ssize_t total_trans_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
-	int ret;
-
-	spin_lock(&stats->lock);
-	ret = sprintf(buf, "%u\n", stats->total_trans);
-	spin_unlock(&stats->lock);
-
-	return ret;
-}
-
-static ssize_t
-time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
-		      char *buf)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
-	ssize_t len = 0;
-	int i;
-
-	spin_lock(&stats->lock);
-	update_time_in_state(stats);
-
-	for (i = 0; i < stats->max_states; i++) {
-		len += sprintf(buf + len, "state%u\t%llu\n", i,
-			       ktime_to_ms(stats->time_in_state[i]));
-	}
-	spin_unlock(&stats->lock);
-
-	return len;
-}
-
-static ssize_t
-reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
-	    size_t count)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
-	int i, states = stats->max_states;
-
-	spin_lock(&stats->lock);
-
-	stats->total_trans = 0;
-	stats->last_time = ktime_get();
-	memset(stats->trans_table, 0,
-	       states * states * sizeof(*stats->trans_table));
-
-	for (i = 0; i < stats->max_states; i++)
-		stats->time_in_state[i] = ktime_set(0, 0);
-
-	spin_unlock(&stats->lock);
-
-	return count;
-}
-
-static ssize_t trans_table_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
-	ssize_t len = 0;
-	int i, j;
-
-	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
-	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
-	for (i = 0; i < stats->max_states; i++) {
-		if (len >= PAGE_SIZE)
-			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
-	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
-
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
-
-	for (i = 0; i < stats->max_states; i++) {
-		if (len >= PAGE_SIZE)
-			break;
-
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
-
-		for (j = 0; j < stats->max_states; j++) {
-			if (len >= PAGE_SIZE)
-				break;
-			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
-				stats->trans_table[i * stats->max_states + j]);
-		}
-		if (len >= PAGE_SIZE)
-			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
-	}
-
-	if (len >= PAGE_SIZE) {
-		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
-		return -EFBIG;
-	}
-	return len;
-}
-
-static DEVICE_ATTR_RO(total_trans);
-static DEVICE_ATTR_RO(time_in_state_ms);
-static DEVICE_ATTR_WO(reset);
-static DEVICE_ATTR_RO(trans_table);
-
-static struct attribute *cooling_device_stats_attrs[] = {
-	&dev_attr_total_trans.attr,
-	&dev_attr_time_in_state_ms.attr,
-	&dev_attr_reset.attr,
-	&dev_attr_trans_table.attr,
-	NULL
-};
-
-static const struct attribute_group cooling_device_stats_attr_group = {
-	.attrs = cooling_device_stats_attrs,
-	.name = "stats"
-};
-
-static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
-{
-	struct cooling_dev_stats *stats;
-	unsigned long states;
-	int var;
-
-	if (cdev->ops->get_max_state(cdev, &states))
-		return;
-
-	states++; /* Total number of states is highest state + 1 */
-
-	var = sizeof(*stats);
-	var += sizeof(*stats->time_in_state) * states;
-	var += sizeof(*stats->trans_table) * states * states;
-
-	stats = kzalloc(var, GFP_KERNEL);
-	if (!stats)
-		return;
-
-	stats->time_in_state = (ktime_t *)(stats + 1);
-	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
-	cdev->stats = stats;
-	stats->last_time = ktime_get();
-	stats->max_states = states;
-
-	spin_lock_init(&stats->lock);
-
-	/* Fill the empty slot left in cooling_device_attr_groups */
-	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
-	cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
-}
-
-static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
-{
-	kfree(cdev->stats);
-	cdev->stats = NULL;
-}
-
-#else
-
-static inline void
-cooling_device_stats_setup(struct thermal_cooling_device *cdev) {}
-static inline void
-cooling_device_stats_destroy(struct thermal_cooling_device *cdev) {}
-
-#endif /* CONFIG_THERMAL_STATISTICS */
-
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *cdev)
 {
-	cooling_device_stats_setup(cdev);
 	cdev->device.groups = cooling_device_attr_groups;
 }
 
-void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev)
-{
-	cooling_device_stats_destroy(cdev);
-}
-
 /* these helper will be used only at the time of bindig */
 ssize_t
 trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4a69e8a6868e..522c9180a08d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -96,7 +96,6 @@ struct thermal_cooling_device {
 	struct device device;
 	struct device_node *np;
 	void *devdata;
-	void *stats;
 	const struct thermal_cooling_device_ops *ops;
 	bool updated; /* true if the cooling device does not need update */
 	struct mutex lock; /* protect thermal_instances list */
-- 
2.25.1

