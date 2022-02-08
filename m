Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083E4ACFD9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiBHDq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiBHDqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:46:23 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1704C0401DC;
        Mon,  7 Feb 2022 19:46:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V3uh.5F_1644291974;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0V3uh.5F_1644291974)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Feb 2022 11:46:19 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: target: tcmu: Make cmd_ring_size changeable via configfs.
Date:   Tue,  8 Feb 2022 11:46:14 +0800
Message-Id: <1644291974-73531-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make cmd_ring_size changeable similar to the way it is done for
max_data_area_mb, the reason is that our tcmu client will create
thousands of tcmu instances, and this will consume lots of mem with
default 8Mb cmd ring size for every backstore.

One can change the value by typing:
    echo "cmd_ring_size_mb=N" > control
The "N" is a integer between 1 to 8, if set 1, the cmd ring can hold
about 6k cmds(tcmu_cmd_entry about 176 byte) at least.

The value is printed when doing:
    cat info
In addition, a new readonly attribute 'cmd_ring_size_mb' returns the
value in read.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/target/target_core_user.c | 64 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 7b2a89a..826c1c0 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -64,7 +64,6 @@
 #define MB_CMDR_SIZE (8 * 1024 * 1024)
 /* Offset of cmd ring is size of mailbox */
 #define CMDR_OFF sizeof(struct tcmu_mailbox)
-#define CMDR_SIZE (MB_CMDR_SIZE - CMDR_OFF)
 
 /*
  * For data area, the default block size is PAGE_SIZE and
@@ -133,6 +132,7 @@ struct tcmu_dev {
 	struct tcmu_mailbox *mb_addr;
 	void *cmdr;
 	u32 cmdr_size;
+	u32 total_cmdr_size_byte;
 	u32 cmdr_last_cleaned;
 	/* Offset of data area from start of mb */
 	/* Must add data_off and mb_addr to get the address */
@@ -1617,6 +1617,7 @@ static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
 
 	udev->data_pages_per_blk = DATA_PAGES_PER_BLK_DEF;
 	udev->max_blocks = DATA_AREA_PAGES_DEF / udev->data_pages_per_blk;
+	udev->total_cmdr_size_byte = MB_CMDR_SIZE;
 	udev->data_area_mb = TCMU_PAGES_TO_MBS(DATA_AREA_PAGES_DEF);
 
 	mutex_init(&udev->cmdr_lock);
@@ -2189,7 +2190,7 @@ static int tcmu_configure_device(struct se_device *dev)
 		goto err_bitmap_alloc;
 	}
 
-	mb = vzalloc(MB_CMDR_SIZE);
+	mb = vzalloc(udev->total_cmdr_size_byte);
 	if (!mb) {
 		ret = -ENOMEM;
 		goto err_vzalloc;
@@ -2198,8 +2199,8 @@ static int tcmu_configure_device(struct se_device *dev)
 	/* mailbox fits in first part of CMDR space */
 	udev->mb_addr = mb;
 	udev->cmdr = (void *)mb + CMDR_OFF;
-	udev->cmdr_size = CMDR_SIZE;
-	udev->data_off = MB_CMDR_SIZE;
+	udev->cmdr_size = udev->total_cmdr_size_byte - CMDR_OFF;
+	udev->data_off = udev->total_cmdr_size_byte;
 	data_size = TCMU_MBS_TO_PAGES(udev->data_area_mb) << PAGE_SHIFT;
 	udev->mmap_pages = (data_size + MB_CMDR_SIZE) >> PAGE_SHIFT;
 	udev->data_blk_size = udev->data_pages_per_blk * PAGE_SIZE;
@@ -2401,7 +2402,7 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
 enum {
 	Opt_dev_config, Opt_dev_size, Opt_hw_block_size, Opt_hw_max_sectors,
 	Opt_nl_reply_supported, Opt_max_data_area_mb, Opt_data_pages_per_blk,
-	Opt_err,
+	Opt_cmd_ring_size_mb, Opt_err,
 };
 
 static match_table_t tokens = {
@@ -2412,6 +2413,7 @@ enum {
 	{Opt_nl_reply_supported, "nl_reply_supported=%d"},
 	{Opt_max_data_area_mb, "max_data_area_mb=%d"},
 	{Opt_data_pages_per_blk, "data_pages_per_blk=%d"},
+	{Opt_cmd_ring_size_mb, "cmd_ring_size_mb=%d"},
 	{Opt_err, NULL}
 };
 
@@ -2509,6 +2511,41 @@ static int tcmu_set_data_pages_per_blk(struct tcmu_dev *udev, substring_t *arg)
 	return ret;
 }
 
+static int tcmu_set_cmd_ring_size_param(struct tcmu_dev *udev, substring_t *arg)
+{
+	int val, ret;
+
+	ret = match_int(arg, &val);
+	if (ret < 0) {
+		pr_err("match_int() failed for cmd_ring_size_mb=. Error %d.\n",
+		       ret);
+		return ret;
+	}
+
+	if (val <= 0) {
+		pr_err("Invalid cmd_ring_size_mb %d.\n", val);
+		return -EINVAL;
+	}
+
+	mutex_lock(&udev->cmdr_lock);
+	if (udev->data_bitmap) {
+		pr_err("Cannot set cmd_ring_size_mb after it has been enabled.\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	udev->total_cmdr_size_byte = (val << 20);
+	if (udev->total_cmdr_size_byte > MB_CMDR_SIZE) {
+		pr_err("%d is too large. Adjusting cmd_ring_size_mb to global limit of %u\n",
+		       val, (MB_CMDR_SIZE >> 20));
+		udev->total_cmdr_size_byte = MB_CMDR_SIZE;
+	}
+
+unlock:
+	mutex_unlock(&udev->cmdr_lock);
+	return ret;
+}
+
 static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
 		const char *page, ssize_t count)
 {
@@ -2563,6 +2600,9 @@ static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
 		case Opt_data_pages_per_blk:
 			ret = tcmu_set_data_pages_per_blk(udev, &args[0]);
 			break;
+		case Opt_cmd_ring_size_mb:
+			ret = tcmu_set_cmd_ring_size_param(udev, &args[0]);
+			break;
 		default:
 			break;
 		}
@@ -2585,6 +2625,8 @@ static ssize_t tcmu_show_configfs_dev_params(struct se_device *dev, char *b)
 	bl += sprintf(b + bl, "Size: %llu ", udev->dev_size);
 	bl += sprintf(b + bl, "MaxDataAreaMB: %u ", udev->data_area_mb);
 	bl += sprintf(b + bl, "DataPagesPerBlk: %u\n", udev->data_pages_per_blk);
+	bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
+		      (udev->total_cmdr_size_byte >> 20));
 
 	return bl;
 }
@@ -3059,6 +3101,17 @@ static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *pa
 }
 CONFIGFS_ATTR_WO(tcmu_, free_kept_buf);
 
+static ssize_t tcmu_cmd_ring_size_mb_show(struct config_item *item, char *page)
+{
+	struct se_dev_attrib *da = container_of(to_config_group(item),
+						struct se_dev_attrib, da_group);
+	struct tcmu_dev *udev = TCMU_DEV(da->da_dev);
+
+	return snprintf(page, PAGE_SIZE, "%u\n",
+			(udev->total_cmdr_size_byte >> 20));
+}
+CONFIGFS_ATTR_RO(tcmu_, cmd_ring_size_mb);
+
 static struct configfs_attribute *tcmu_attrib_attrs[] = {
 	&tcmu_attr_cmd_time_out,
 	&tcmu_attr_qfull_time_out,
@@ -3069,6 +3122,7 @@ static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *pa
 	&tcmu_attr_emulate_write_cache,
 	&tcmu_attr_tmr_notification,
 	&tcmu_attr_nl_reply_supported,
+	&tcmu_attr_cmd_ring_size_mb,
 	NULL,
 };
 
-- 
1.8.3.1

