Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7249D272
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiAZTWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244432AbiAZTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:22:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3760DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:22:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so1139889ybp.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=04sdxbg1x/YeFMRyv9AOCI2xeg6o05KS69MbBAG7QGY=;
        b=a4RvJo6ASrqusnJN7uPmas81uMdKnvsb1brITuUnXSODDcNV3AJBQtzf49Ni8vB1Gb
         POZcO79CReKAlS5QN0S/v0TekC1iOXzDBWdzbBJBT1P6H95SfmVlgj/AXOU5tT+9ZLc3
         fxfFIIgugssUXq36s3MK+XMDg0OsRpaHGZO6yza7jOhq3CNRvF3zCVkaKOGiLuNKwFvc
         z4idBE4x045MPYsNU5mryLLad01l+9vXPo1EcU0QfiyQPJKDDztpxzLCe+gSjhvt4KsG
         02Pwdzr8a8ZBFS9DvMk2v3G/XMM3qb8B3vQ6V+9VoiqVIFWtlCSo1neWIIsb4SSltaFe
         yhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=04sdxbg1x/YeFMRyv9AOCI2xeg6o05KS69MbBAG7QGY=;
        b=eSOPnGZMHbHV+Wt09pcoDOVp0KARo6jMqnNa5oBd5Mw69UnVnfLMrUcUpbFVeDG/Ct
         nohPeGw00s5wU1H6OHAPlQknnX148uT8XQku9piJV1m7WdoHCfgRf5qnIGI2bMi9yGxa
         asSh95sIqflmM+2bMws01sFl46KgaEyDc400whLH9dOTsnFWFmuCQFq4Gy4I+bXfD7K4
         SxhEMibkpplpBzvGlAkZu8259f9DV10gxSyYm6EyDjo9Ua+6kUi0kMq9WSDpH10VBAuh
         dDN1cLICYfrGGyqu/Va5VuvSl2gTYAAwTfQFw4HuVlZHGKLwDUy1AqEcXhwBf2Cnc9cb
         9aYQ==
X-Gm-Message-State: AOAM5300HIeR1SJeuSHqWIV9cauRu8QAgDUfKmmx/NoLZLHCNak8REc4
        yDFNxXDB8iRPrDHPx9JubcY8PkAB91Us
X-Google-Smtp-Source: ABdhPJxnjNIaE09+bgW4aCFWhJbPq7xplPCN0QUq8CKCWlEHAusq4H3cU/VZpfyMHbNlaFIqdSTz5B6bn1Yu
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:4711:719d:26c1:9f8f])
 (user=bgeffon job=sendgmr) by 2002:a25:6fc4:: with SMTP id
 k187mr480151ybc.709.1643224961441; Wed, 26 Jan 2022 11:22:41 -0800 (PST)
Date:   Wed, 26 Jan 2022 11:22:34 -0800
In-Reply-To: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Message-Id: <20220126192234.572058-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] dm: introduce a DM_ENFORCE_OPEN_COUNT flag.
From:   Brian Geffon <bgeffon@google.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduces a new flag which can be used with
DM_DEV_CREATE to establish the maximum open count allowed
for a device. When this flag is set on DM_DEV_CREATE the
open_count on dm_ioctl will be intrpreted as an input
parameter. This value must be >= 1 or DM_DEV_CREATE will
return -ERANGE.

When this flag is set when the open count is equal to
the max open count any future opens will result in an
-EBUSY.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/md/dm-core.h          |  2 ++
 drivers/md/dm-ioctl.c         | 13 ++++++++++++
 drivers/md/dm.c               | 39 ++++++++++++++++++++++++++++++++---
 drivers/md/dm.h               |  7 +++++++
 include/uapi/linux/dm-ioctl.h |  9 +++++++-
 5 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 55dccdfbcb22..57922a80026e 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -57,6 +57,7 @@ struct mapped_device {
 
 	atomic_t holders;
 	atomic_t open_count;
+	int max_open_count;
 
 	struct dm_target *immutable_target;
 	struct target_type *immutable_target_type;
@@ -139,6 +140,7 @@ struct mapped_device {
 #define DMF_SUSPENDED_INTERNALLY 7
 #define DMF_POST_SUSPENDING 8
 #define DMF_EMULATE_ZONE_APPEND 9
+#define DMF_ENFORCE_OPEN_COUNT 10
 
 void disable_discard(struct mapped_device *md);
 void disable_write_same(struct mapped_device *md);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 21fe8652b095..8ddf3ab99ef6 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -814,6 +814,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 	if (dm_test_deferred_remove_flag(md))
 		param->flags |= DM_DEFERRED_REMOVE;
 
+	if (dm_test_enforce_open_count_flag(md))
+		param->flags |= DM_ENFORCE_OPEN_COUNT_FLAG;
+
 	param->dev = huge_encode_dev(disk_devt(disk));
 
 	/*
@@ -866,6 +869,16 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (r)
 		return r;
 
+	if (param->flags & DM_ENFORCE_OPEN_COUNT_FLAG) {
+		if (param->open_count < 1) {
+			dm_put(md);
+			dm_destroy(md);
+			return -ERANGE;
+		}
+
+		dm_set_max_open_count(md, param->open_count);
+	}
+
 	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
 	if (r) {
 		dm_put(md);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 76d9da49fda7..718bc9fce7c1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -307,6 +307,7 @@ int dm_deleting_md(struct mapped_device *md)
 static int dm_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mapped_device *md;
+	int ret = -ENXIO;
 
 	spin_lock(&_minor_lock);
 
@@ -316,16 +317,28 @@ static int dm_blk_open(struct block_device *bdev, fmode_t mode)
 
 	if (test_bit(DMF_FREEING, &md->flags) ||
 	    dm_deleting_md(md)) {
-		md = NULL;
 		goto out;
 	}
 
 	dm_get(md);
+
+	if (test_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags)) {
+		/*
+		 * No opens or closes can happen in parallel as both
+		 * paths hold the _minor_lock.
+		 */
+		if (atomic_read(&md->open_count) + 1 > md->max_open_count) {
+			dm_put(md);
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
 	atomic_inc(&md->open_count);
+	ret = 0;
 out:
 	spin_unlock(&_minor_lock);
-
-	return md ? 0 : -ENXIO;
+	return ret;
 }
 
 static void dm_blk_close(struct gendisk *disk, fmode_t mode)
@@ -2219,6 +2232,21 @@ void dm_put(struct mapped_device *md)
 }
 EXPORT_SYMBOL_GPL(dm_put);
 
+/*
+ * dm_set_max_open count can only be called when the device is created,
+ * it cannot be changed once set.
+ */
+void dm_set_max_open_count(struct mapped_device *md, int count)
+{
+	/*
+	 * The max open count cannot be changed
+	 */
+	BUG_ON(test_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags));
+
+	set_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags);
+	md->max_open_count = count;
+}
+
 static bool md_in_flight_bios(struct mapped_device *md)
 {
 	int cpu;
@@ -2795,6 +2823,11 @@ int dm_test_deferred_remove_flag(struct mapped_device *md)
 	return test_bit(DMF_DEFERRED_REMOVE, &md->flags);
 }
 
+int dm_test_enforce_open_count_flag(struct mapped_device *md)
+{
+	return test_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags);
+}
+
 int dm_suspended(struct dm_target *ti)
 {
 	return dm_suspended_md(ti->table->md);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 742d9c80efe1..82f56a066b83 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -84,6 +84,8 @@ void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type);
 enum dm_queue_mode dm_get_md_type(struct mapped_device *md);
 struct target_type *dm_get_immutable_target_type(struct mapped_device *md);
 
+void dm_set_max_open_count(struct mapped_device *md, int count);
+
 int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
 
 /*
@@ -162,6 +164,11 @@ void dm_internal_resume(struct mapped_device *md);
  */
 int dm_test_deferred_remove_flag(struct mapped_device *md);
 
+/*
+ * Test if the device is enforcing an open count.
+ */
+int dm_test_enforce_open_count_flag(struct mapped_device *md);
+
 /*
  * Try to remove devices marked for deferred removal.
  */
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index c12ce30b52df..9da3700c0442 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -123,7 +123,7 @@ struct dm_ioctl {
 				 * relative to start of this struct */
 
 	__u32 target_count;	/* in/out */
-	__s32 open_count;	/* out */
+	__s32 open_count;	/* in/out, in on DM_DEV_CREATE only */
 	__u32 flags;		/* in/out */
 
 	/*
@@ -382,4 +382,11 @@ enum {
  */
 #define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
 
+/*
+ * If set with DM_DEV_CREATE then the open_count on device creation
+ * will be set as the maximum concurrent opens allowed on the device.
+ * Once the open_count has been hit any new opens will result in
+ * -EBUSY until other users close the device.
+ */
+#define DM_ENFORCE_OPEN_COUNT_FLAG	 (1 << 20) /* In/Out */
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
2.35.0.rc0.227.g00780c9af4-goog

