Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD46A5325A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiEXIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiEXIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:50:28 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52F287CB35;
        Tue, 24 May 2022 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9KFfo
        46Pv2roKfZgjfQwCtxLH+v1kf+Ql85XaC4j/Xo=; b=WjRJKwA5aw4BvijVtqP4M
        5lGH3T5bmU+KXaC09PS613OxwxJxTlVmGxFZF/G+gVv6+qE9cHxXF10O+cKY5B5F
        XHhZJAvuNN11WU4ONytiM6LXnEBU/h4ZCdMf6PazQjCWYMgYzo3xNlgdelrMmPlR
        m6jDN68MH8CUT4G5WHLkck=
Received: from carlis (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowABX+eQ9nIxihWfrDw--.40768S2;
        Tue, 24 May 2022 16:50:06 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llyz108@163.com, Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: core: sysfs: convert sysfs snprintf to sysfs_emit
Date:   Tue, 24 May 2022 08:49:59 +0000
Message-Id: <20220524084959.126188-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABX+eQ9nIxihWfrDw--.40768S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrW8KFy8uF4ktw4kZF4rGrg_yoW3WFWxpF
        yfGa45A3y8Gr1Duws0gFs3uFyY9rWUA343JayrGw1j93ZFyrWkta4kAFWjq3yrGrZ5C3W7
        ZF4DKFW5CF4rurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jviihUUUUU=
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiMhcEhVWBzZ8v4gABsu
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/scsi/scsi_sysfs.c:705:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:696:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:1119:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:738:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:986:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:1209:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:717:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:385:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:961:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:402:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:881:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:277:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:327:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:231:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_sysfs.c:866:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/scsi_sysfs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 546a9e3cfbec..256d45ca5fa5 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -163,7 +163,7 @@ show_##name (struct device *dev, struct device_attribute *attr, 	\
 	     char *buf)							\
 {									\
 	struct Scsi_Host *shost = class_to_shost(dev);			\
-	return snprintf (buf, 20, format_string, shost->field);		\
+	return sysfs_emit(buf, format_string, shost->field);		\
 }
 
 /*
@@ -228,7 +228,7 @@ show_shost_state(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 /* DEVICE_ATTR(state) clashes with dev_attr_state for sdev */
@@ -274,7 +274,7 @@ show_shost_active_mode(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	if (shost->active_mode == MODE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	else
 		return show_shost_mode(shost->active_mode, buf);
 }
@@ -382,7 +382,7 @@ static ssize_t
 show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
-	return snprintf(buf, 20, "%d\n", scsi_host_busy(shost));
+	return sysfs_emit(buf, "%d\n", scsi_host_busy(shost));
 }
 static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
 
@@ -399,7 +399,7 @@ show_nr_hw_queues(struct device *dev, struct device_attribute *attr, char *buf)
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct blk_mq_tag_set *tag_set = &shost->tag_set;
 
-	return snprintf(buf, 20, "%d\n", tag_set->nr_hw_queues);
+	return sysfs_emit(buf, "%d\n", tag_set->nr_hw_queues);
 }
 static DEVICE_ATTR(nr_hw_queues, S_IRUGO, show_nr_hw_queues, NULL);
 
@@ -606,7 +606,7 @@ sdev_show_##field (struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct scsi_device *sdev;					\
 	sdev = to_scsi_device(dev);					\
-	return snprintf (buf, 20, format_string, sdev->field);		\
+	return sysfs_emit(buf, format_string, sdev->field);		\
 }									\
 
 /*
@@ -693,7 +693,7 @@ sdev_show_device_busy(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", scsi_device_busy(sdev));
+	return sysfs_emit(buf, "%d\n", scsi_device_busy(sdev));
 }
 static DEVICE_ATTR(device_busy, S_IRUGO, sdev_show_device_busy, NULL);
 
@@ -702,7 +702,7 @@ sdev_show_device_blocked(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", atomic_read(&sdev->device_blocked));
+	return sysfs_emit(buf, "%d\n", atomic_read(&sdev->device_blocked));
 }
 static DEVICE_ATTR(device_blocked, S_IRUGO, sdev_show_device_blocked, NULL);
 
@@ -714,7 +714,7 @@ sdev_show_timeout (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", sdev->request_queue->rq_timeout / HZ);
+	return sysfs_emit(buf, "%d\n", sdev->request_queue->rq_timeout / HZ);
 }
 
 static ssize_t
@@ -735,7 +735,7 @@ sdev_show_eh_timeout(struct device *dev, struct device_attribute *attr, char *bu
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n", sdev->eh_timeout / HZ);
+	return sysfs_emit(buf, "%u\n", sdev->eh_timeout / HZ);
 }
 
 static ssize_t
@@ -863,7 +863,7 @@ show_state_field(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
@@ -878,7 +878,7 @@ show_queue_type_field(struct device *dev, struct device_attribute *attr,
 	if (sdev->simple_tags)
 		name = "simple";
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t
@@ -958,7 +958,7 @@ static ssize_t
 show_iostat_counterbits(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
+	return sysfs_emit(buf, "%d\n", (int)sizeof(atomic_t) * 8);
 }
 
 static DEVICE_ATTR(iocounterbits, S_IRUGO, show_iostat_counterbits, NULL);
@@ -970,7 +970,7 @@ show_iostat_##field(struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	unsigned long long count = atomic_read(&sdev->field);		\
-	return snprintf(buf, 20, "0x%llx\n", count);			\
+	return sysfs_emit(buf, "0x%llx\n", count);			\
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_iostat_##field, NULL)
 
@@ -983,7 +983,7 @@ sdev_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf (buf, 20, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
+	return sysfs_emit(buf, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
 }
 static DEVICE_ATTR(modalias, S_IRUGO, sdev_show_modalias, NULL);
 
@@ -994,7 +994,7 @@ sdev_show_evt_##name(struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	int val = test_bit(SDEV_EVT_##Cap_name, sdev->supported_events);\
-	return snprintf(buf, 20, "%d\n", val);				\
+	return sysfs_emit(buf, "%d\n", val);				\
 }
 
 #define DECLARE_EVT_STORE(name, Cap_name)				\
@@ -1116,9 +1116,9 @@ sdev_show_dh_state(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 
 	if (!sdev->handler)
-		return snprintf(buf, 20, "detached\n");
+		return sysfs_emit(buf, "detached\n");
 
-	return snprintf(buf, 20, "%s\n", sdev->handler->name);
+	return sysfs_emit(buf, "%s\n", sdev->handler->name);
 }
 
 static ssize_t
@@ -1206,7 +1206,7 @@ sdev_show_queue_ramp_up_period(struct device *dev,
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			jiffies_to_msecs(sdev->queue_ramp_up_period));
 }
 
-- 
2.25.1

