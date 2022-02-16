Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F574B7DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbiBPCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:22:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiBPCWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:22:10 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D15D2051;
        Tue, 15 Feb 2022 18:21:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4akk5y_1644978109;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0V4akk5y_1644978109)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 10:21:53 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: [PATCH V4] scsi: target: tcmu: Make cmd_ring_size changeable via configfs
Date:   Wed, 16 Feb 2022 10:21:49 +0800
Message-Id: <1644978109-14885-1-git-send-email-kanie@linux.alibaba.com>
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

Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/target/target_core_user.c | 73 +++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 7b2a89a..95d4ca5 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -61,10 +61,10 @@
 #define TCMU_TIME_OUT (30 * MSEC_PER_SEC)
 
 /* For mailbox plus cmd ring, the size is fixed 8MB */
-#define MB_CMDR_SIZE (8 * 1024 * 1024)
+#define MB_CMDR_SIZE_DEF (8 * 1024 * 1024)
 /* Offset of cmd ring is size of mailbox */
-#define CMDR_OFF sizeof(struct tcmu_mailbox)
-#define CMDR_SIZE (MB_CMDR_SIZE - CMDR_OFF)
+#define CMDR_OFF ((__u32)sizeof(struct tcmu_mailbox))
+#define CMDR_SIZE_DEF (MB_CMDR_SIZE_DEF - CMDR_OFF)
 
 /*
  * For data area, the default block size is PAGE_SIZE and
@@ -1617,6 +1617,7 @@ static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
 
 	udev->data_pages_per_blk = DATA_PAGES_PER_BLK_DEF;
 	udev->max_blocks = DATA_AREA_PAGES_DEF / udev->data_pages_per_blk;
+	udev->cmdr_size = CMDR_SIZE_DEF;
 	udev->data_area_mb = TCMU_PAGES_TO_MBS(DATA_AREA_PAGES_DEF);
 
 	mutex_init(&udev->cmdr_lock);
@@ -2189,7 +2190,7 @@ static int tcmu_configure_device(struct se_device *dev)
 		goto err_bitmap_alloc;
 	}
 
-	mb = vzalloc(MB_CMDR_SIZE);
+	mb = vzalloc(udev->cmdr_size + CMDR_OFF);
 	if (!mb) {
 		ret = -ENOMEM;
 		goto err_vzalloc;
@@ -2198,10 +2199,9 @@ static int tcmu_configure_device(struct se_device *dev)
 	/* mailbox fits in first part of CMDR space */
 	udev->mb_addr = mb;
 	udev->cmdr = (void *)mb + CMDR_OFF;
-	udev->cmdr_size = CMDR_SIZE;
-	udev->data_off = MB_CMDR_SIZE;
+	udev->data_off = udev->cmdr_size + CMDR_OFF;
 	data_size = TCMU_MBS_TO_PAGES(udev->data_area_mb) << PAGE_SHIFT;
-	udev->mmap_pages = (data_size + MB_CMDR_SIZE) >> PAGE_SHIFT;
+	udev->mmap_pages = (data_size + udev->cmdr_size + CMDR_OFF) >> PAGE_SHIFT;
 	udev->data_blk_size = udev->data_pages_per_blk * PAGE_SIZE;
 	udev->dbi_thresh = 0; /* Default in Idle state */
 
@@ -2221,7 +2221,7 @@ static int tcmu_configure_device(struct se_device *dev)
 
 	info->mem[0].name = "tcm-user command & data buffer";
 	info->mem[0].addr = (phys_addr_t)(uintptr_t)udev->mb_addr;
-	info->mem[0].size = data_size + MB_CMDR_SIZE;
+	info->mem[0].size = data_size + udev->cmdr_size + CMDR_OFF;
 	info->mem[0].memtype = UIO_MEM_NONE;
 
 	info->irqcontrol = tcmu_irqcontrol;
@@ -2401,7 +2401,7 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
 enum {
 	Opt_dev_config, Opt_dev_size, Opt_hw_block_size, Opt_hw_max_sectors,
 	Opt_nl_reply_supported, Opt_max_data_area_mb, Opt_data_pages_per_blk,
-	Opt_err,
+	Opt_cmd_ring_size_mb, Opt_err,
 };
 
 static match_table_t tokens = {
@@ -2412,6 +2412,7 @@ enum {
 	{Opt_nl_reply_supported, "nl_reply_supported=%d"},
 	{Opt_max_data_area_mb, "max_data_area_mb=%d"},
 	{Opt_data_pages_per_blk, "data_pages_per_blk=%d"},
+	{Opt_cmd_ring_size_mb, "cmd_ring_size_mb=%d"},
 	{Opt_err, NULL}
 };
 
@@ -2509,6 +2510,41 @@ static int tcmu_set_data_pages_per_blk(struct tcmu_dev *udev, substring_t *arg)
 	return ret;
 }
 
+static int tcmu_set_cmd_ring_size(struct tcmu_dev *udev, substring_t *arg)
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
+	udev->cmdr_size = (val << 20) - CMDR_OFF;
+	if (val > (MB_CMDR_SIZE_DEF >> 20)) {
+		pr_err("%d is too large. Adjusting cmd_ring_size_mb to global limit of %u\n",
+		       val, (MB_CMDR_SIZE_DEF >> 20));
+		udev->cmdr_size = CMDR_SIZE_DEF;
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
@@ -2563,6 +2599,9 @@ static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
 		case Opt_data_pages_per_blk:
 			ret = tcmu_set_data_pages_per_blk(udev, &args[0]);
 			break;
+		case Opt_cmd_ring_size_mb:
+			ret = tcmu_set_cmd_ring_size(udev, &args[0]);
+			break;
 		default:
 			break;
 		}
@@ -2584,7 +2623,9 @@ static ssize_t tcmu_show_configfs_dev_params(struct se_device *dev, char *b)
 		     udev->dev_config[0] ? udev->dev_config : "NULL");
 	bl += sprintf(b + bl, "Size: %llu ", udev->dev_size);
 	bl += sprintf(b + bl, "MaxDataAreaMB: %u ", udev->data_area_mb);
-	bl += sprintf(b + bl, "DataPagesPerBlk: %u\n", udev->data_pages_per_blk);
+	bl += sprintf(b + bl, "DataPagesPerBlk: %u ", udev->data_pages_per_blk);
+	bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
+		      (udev->cmdr_size + CMDR_OFF) >> 20);
 
 	return bl;
 }
@@ -2693,6 +2734,17 @@ static ssize_t tcmu_data_pages_per_blk_show(struct config_item *item,
 }
 CONFIGFS_ATTR_RO(tcmu_, data_pages_per_blk);
 
+static ssize_t tcmu_cmd_ring_size_mb_show(struct config_item *item, char *page)
+{
+	struct se_dev_attrib *da = container_of(to_config_group(item),
+						struct se_dev_attrib, da_group);
+	struct tcmu_dev *udev = TCMU_DEV(da->da_dev);
+
+	return snprintf(page, PAGE_SIZE, "%u\n",
+			(udev->cmdr_size + CMDR_OFF) >> 20);
+}
+CONFIGFS_ATTR_RO(tcmu_, cmd_ring_size_mb);
+
 static ssize_t tcmu_dev_config_show(struct config_item *item, char *page)
 {
 	struct se_dev_attrib *da = container_of(to_config_group(item),
@@ -3064,6 +3116,7 @@ static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *pa
 	&tcmu_attr_qfull_time_out,
 	&tcmu_attr_max_data_area_mb,
 	&tcmu_attr_data_pages_per_blk,
+	&tcmu_attr_cmd_ring_size_mb,
 	&tcmu_attr_dev_config,
 	&tcmu_attr_dev_size,
 	&tcmu_attr_emulate_write_cache,
-- 
1.8.3.1

