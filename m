Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08451EE92
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiEHP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiEHP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:28:54 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 451BCBF77;
        Sun,  8 May 2022 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Zdk4/
        W1gLEfSq23ElvcOwM3KoNgAxe5BDUhIjFTlIXg=; b=ahmEGSWmyu0T7i5Ap1cYq
        KsanRO+G2dcLoDPZ7WWssMjMsaa1gOZgegQb6qqrjtMgNp2fOhOrQ3XD7KR7HofK
        7sKRT2S/2fSwe1ZdGnwJDxSFXYnmNrqFS3ah2hTxgewlraKtylaqGO5eFbhDLwYt
        I6d2ZkqmLArnLKlUQ3Dbp4=
Received: from localhost (unknown [14.154.30.57])
        by smtp10 (Coremail) with SMTP id DsCowAC32gPS3Hdih__rBQ--.37673S2;
        Sun, 08 May 2022 23:08:03 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Junwen Wu <wudaemon@163.com>, rafael@kernel.org,
        amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org
Subject: Re: [PATCH v1] thermal/core: change mm alloc method to avoid kernel warning
Date:   Sun,  8 May 2022 15:07:50 +0000
Message-Id: <ddbbc1db-2dd3-0c4d-26c0-0992867d35be@linaro.org> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <df7e04d86dd64dc85125d536434d93bab3d6314d.camel@intel.com>
References: <ddbbc1db-2dd3-0c4d-26c0-0992867d35be@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAC32gPS3Hdih__rBQ--.37673S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtry5Cw1DWw17WryfZF1kXwb_yoW3AFyxpF
        nxJa45Zr4UX3WkGay3Gw4DX3sY9F1Sqa47JaykK3s5KF45J3sxWa4DJry2yryrGrW09Fyr
        K3Wqvr98C3yjyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWrX_UUUUU=
X-Originating-IP: [14.154.30.57]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBxxP6bWB0HLuOKwAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

On 19/04/2022 15:54, Zhang Rui wrote:
> CC Viresh.
> 
> On Tue, 2022-04-19 at 11:14 +0200, Daniel Lezcano wrote:
>> On 19/04/2022 10:48, Zhang Rui wrote:
>>> large
>>>
>>> IMO, unless we can fix both places, I'd suggest we skip allocating
>>> and
>>> creating the broken trans_table attr. Like a prototype patch below
>>
>> Why not create a thermal debugfs with real useful information and
>> get
>> rid of this broken code ?
> 
> The idea looks good to me.

>What about doing a percentile approach of the state indexes changes 
>instead of a raw matrix full of zeros ? So we show the most significant 
>transitions, perhaps something like:
>
>99%:	7->6	6->7
>98%:	6->5	5->6
>95%:	5->4	4->5
>90%:	7->5	5->7
>80%:	6->4	4->6
>70%:	7->1	7->2
>50%:	...	...

>total:	123456	124573


>And another statistics file containing some timings information like the 
>total duration in mitigation, and the duration in the most significant 
>states above?

Viresh, Zhang Rui,  Daniel,sorry for the delay indeed ,the trans_table is always full of zero,
I introduce 'show_state' node(tunnable by user,default set as max_states/2) ,thus only show show_state'th  trans count
to the max trans count change stats. in this way trans_table_show's buffer always less than PAGE_SIZE
I create a patch v2
like this:
/sys/class/thermal/cooling_device0/stats # cat trans_table
 From  :    Index_change
state 0:      ->1( 1)      ->2( 2)      ->7( 1)
state 1:      ->0( 1)      ->2( 1)
state 2:      ->0( 2)      ->1( 1)

here is the patch:
From 64a7fefd008cb890a4a9ea4efd0dd388ac536ad5 Mon Sep 17 00:00:00 2001
From: Junwen Wu <wudaemon@163.com>
Date: Sun, 8 May 2022 14:50:14 +0000
Subject: [PATCH v2] thermal/core: Make trans_table tunnable to avoid some
 needless zero output

Very high cooling device max state value make trans_table node prompt File too large.
we introduce show_state node, tunnable by user,thus trans_table only show show_state'th
trans count to the max trans count, in this way trans_table_show's buffer is
always less than PAGE_SIZE and shows the important changes.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
V1 -> V2: avoid some needless zero output
 drivers/thermal/thermal_sysfs.c | 136 +++++++++++++++++++++++---------
 1 file changed, 99 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..1496088a1638 100644
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
@@ -752,60 +753,119 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	return count;
 }
 
-static ssize_t trans_table_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t
+show_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
+            size_t count)
 {
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
-	ssize_t len = 0;
-	int i, j;
+        struct thermal_cooling_device *cdev = to_cooling_device(dev);
+        struct cooling_dev_stats *stats = cdev->stats;
+        unsigned long state;
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
+        spin_lock(&stats->lock);
 
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	ret = kstrtoul(buf, 10, &state);
+        if (ret || (state > stats->max_states))
+		goto unlock;
 
-	for (i = 0; i < stats->max_states; i++) {
-		if (len >= PAGE_SIZE)
-			break;
+	stats->show_state = state;
+unlock:
+	spin_unlock(&stats->lock);
+        return count;
+}
 
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
+static ssize_t
+show_state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+        struct thermal_cooling_device *cdev = to_cooling_device(dev);
+        struct cooling_dev_stats *stats = cdev->stats;
+
+	return sprintf(buf, "%lu\n", stats->show_state);
+}
+
+static int find_show_state( int *nums, int numsSize, int k, unsigned int *max_value)
+{
+    int i, min = INT_MAX, max = 0;
+    for( i = 0; i < numsSize; ++i )
+    {
+        min = nums[i] < min ? nums[i] : min;
+        max = nums[i] > max ? nums[i] : max;
+    }
+    int l = min, r = max, mid, cnt = 0;
+    while( l < r )
+    {
+        mid = r - (r - l) / 2;
+        for( i = 0; i < numsSize; ++i )
+        {
+            if( nums[i] >= mid )
+                ++cnt;
+        }
+        if( cnt < k )
+        {
+            r = mid - 1;
+            cnt = 0;
+        }
+        else
+        {
+            l = mid;
+            cnt = 0;
+        }
+    }
+     *max_value = max;
+    return l;
+}
 
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
 
-	if (len >= PAGE_SIZE) {
-		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
-		return -EFBIG;
-	}
-	return len;
+
+static ssize_t trans_table_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+        struct cooling_dev_stats *stats = cdev->stats;
+        ssize_t len = 0;
+        int i, j;
+        unsigned int show_state_value = 0;
+	unsigned int max_state_value = 0;
+
+        len += snprintf(buf + len, PAGE_SIZE - len, " From  :    Index_change\n");
+        for (i = 0; i < stats->max_states; i++) {
+                show_state_value = find_show_state(&stats->trans_table[i * stats->max_states], stats->max_states, stats->show_state, &max_state_value);
+                if (max_state_value) {
+                        len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
+                }
+                else {
+                        continue;
+                }
+
+                for (j = 0; j < stats->max_states; j++) {
+                        if (stats->trans_table[i * stats->max_states + j] && (show_state_value <= stats->trans_table[i * stats->max_states + j])) {
+                                len += snprintf(buf + len, PAGE_SIZE - len, "     ->%u(%u)",j, stats->trans_table[i * stats->max_states + j]);
+                        }
+                }
+                if (len >= PAGE_SIZE)
+                        break;
+                len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+        }
+
+        if (len >= PAGE_SIZE) {
+                pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
+                return -EFBIG;
+        }
+        return len;
 }
 
 static DEVICE_ATTR_RO(total_trans);
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
 
@@ -829,7 +889,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
 
-	stats = kzalloc(var, GFP_KERNEL);
+	stats = kvzalloc(var, GFP_KERNEL);
 	if (!stats)
 		return;
 
@@ -838,6 +898,8 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	cdev->stats = stats;
 	stats->last_time = ktime_get();
 	stats->max_states = states;
+	/* default set show_state = max_states/2 */
+	stats->show_state = states / 2;
 
 	spin_lock_init(&stats->lock);
 
@@ -848,7 +910,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
-	kfree(cdev->stats);
+	kvfree(cdev->stats);
 	cdev->stats = NULL;
 }
 
-- 
2.25.1


