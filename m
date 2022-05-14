Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA165271E4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiENOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiENOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:20:37 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 173329FD2;
        Sat, 14 May 2022 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fs7xO
        mXbGEknwJrqsFpipHU+pL7BLI3UV/BiTzqh4uk=; b=mPfx/jPWdKRyT+J4Y+tMp
        eYKLGBWgQXgAQZ9qr0oLjpWI6FlZy88RHqzbHR9tIWsfQYoUbrOJ/Jj6sYPjfQLm
        j5QPX3NxZosKFvmnkk+Irw1hzN+dm4+QPEiX7x3g24mSyvx8VbB3/aqCMIdL+ytx
        af3TrdMBx4RQbB0I4T6XaI=
Received: from localhost (unknown [223.74.106.63])
        by smtp9 (Coremail) with SMTP id DcCowAA3Py98un9iKCZdCw--.42048S2;
        Sat, 14 May 2022 22:19:41 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Junwen Wu <wudaemon@163.com>
Subject: [PATCH v2] thermal/core: Make trans_table tunnable to avoid some needless zero output
Date:   Sat, 14 May 2022 14:19:32 +0000
Message-Id: <20220514141932.53938-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAA3Py98un9iKCZdCw--.42048S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1fZF4fWF1kKFykWr1xZrb_yoW7uF4rpF
        nxJa4Y9r4UX3WkGay3Jr4DX3sY9F1Sqa47JFZ7K3s5KF4UJ3sxXFyDJry2yrW5GrWkuFy3
        K3Wqvr98C3yUtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioUDdUUUUU=
X-Originating-IP: [223.74.106.63]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisQEBbVXlqDM-GAABsR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very high cooling device max state value make trans_table node
prompt File too large. We introduce show_state node, tunnable
by user,thus trans_table only show show_state'th trans count to
the max trans count, in this way trans_table_show's buffer is
always less than PAGE_SIZE and shows the important changes.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 drivers/thermal/thermal_sysfs.c | 111 +++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..bb8627aa49b7 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -656,6 +656,7 @@ struct cooling_dev_stats {
 	spinlock_t lock;
 	unsigned int total_trans;
 	unsigned long state;
+	unsigned long show_state;
 	unsigned long max_states;
 	ktime_t last_time;
 	ktime_t *time_in_state;
@@ -752,38 +753,93 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	return count;
 }
 
-static ssize_t trans_table_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t
+show_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
+		size_t count)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats = cdev->stats;
-	ssize_t len = 0;
-	int i, j;
+	unsigned long state;
+	ssize_t ret;
 
-	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
-	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
-	for (i = 0; i < stats->max_states; i++) {
-		if (len >= PAGE_SIZE)
-			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
-	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+	spin_lock(&stats->lock);
+
+	ret = kstrtoul(buf, 10, &state);
+	if (ret || (state > stats->max_states))
+		goto unlock;
 
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	stats->show_state = state;
+unlock:
+	spin_unlock(&stats->lock);
 
-	for (i = 0; i < stats->max_states; i++) {
-		if (len >= PAGE_SIZE)
-			break;
+	return count;
+}
+
+static ssize_t
+show_state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+
+	return sprintf(buf, "%lu\n", stats->show_state);
+}
 
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
+/* find the kth largest in nums array*/
+static int find_show_state(int *nums, int numsSize, int k, unsigned int *max_value)
+{
+	int i, l, r, mid, cnt = 0, min = INT_MAX, max = 0;
 
-		for (j = 0; j < stats->max_states; j++) {
-			if (len >= PAGE_SIZE)
-				break;
-			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
-				stats->trans_table[i * stats->max_states + j]);
+	for (i = 0; i < numsSize; i++) {
+		min = nums[i] < min ? nums[i] : min;
+		max = nums[i] > max ? nums[i] : max;
+	}
+	l = min;
+	r = max;
+	while (l < r) {
+		mid = r - (r - l) / 2;
+		for (i = 0; i < numsSize; i++) {
+			if (nums[i] >= mid)
+				cnt++;
+		}
+		if (cnt < k) {
+			r = mid - 1;
+			cnt = 0;
+		} else {
+			l = mid;
+			cnt = 0;
 		}
+	}
+
+	*max_value = max;
+
+	return l;
+}
+
+
+
+static ssize_t trans_table_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	unsigned int show_state_value = 0;
+	unsigned int max_state_value = 0;
+	ssize_t len = 0;
+	int i, j;
+
+	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    Index_change\n");
+	for (i = 0; i < stats->max_states; i++) {
+		show_state_value = find_show_state(&stats->trans_table[i * stats->max_states],
+				stats->max_states, stats->show_state, &max_state_value);
+		if (max_state_value)
+			len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
+		else
+			continue;
+		for (j = 0; j < stats->max_states; j++)
+			if (stats->trans_table[i * stats->max_states + j] && (show_state_value <=
+						stats->trans_table[i * stats->max_states + j]))
+				len += snprintf(buf + len, PAGE_SIZE - len, "     ->%u(%u)", j,
+						stats->trans_table[i * stats->max_states + j]);
 		if (len >= PAGE_SIZE)
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
@@ -793,6 +849,7 @@ static ssize_t trans_table_show(struct device *dev,
 		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
 	}
+
 	return len;
 }
 
@@ -800,12 +857,14 @@ static DEVICE_ATTR_RO(total_trans);
 static DEVICE_ATTR_RO(time_in_state_ms);
 static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_RO(trans_table);
+static DEVICE_ATTR_RW(show_state);
 
 static struct attribute *cooling_device_stats_attrs[] = {
 	&dev_attr_total_trans.attr,
 	&dev_attr_time_in_state_ms.attr,
 	&dev_attr_reset.attr,
 	&dev_attr_trans_table.attr,
+	&dev_attr_show_state.attr,
 	NULL
 };
 
@@ -829,7 +888,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
 
-	stats = kzalloc(var, GFP_KERNEL);
+	stats = kvzalloc(var, GFP_KERNEL);
 	if (!stats)
 		return;
 
@@ -838,6 +897,8 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	cdev->stats = stats;
 	stats->last_time = ktime_get();
 	stats->max_states = states;
+	/* default set show_state = max_states/2 */
+	stats->show_state = states / 2;
 
 	spin_lock_init(&stats->lock);
 
@@ -848,7 +909,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
-	kfree(cdev->stats);
+	kvfree(cdev->stats);
 	cdev->stats = NULL;
 }
 
-- 
2.25.1

