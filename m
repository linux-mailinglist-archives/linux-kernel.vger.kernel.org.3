Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F64544936
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbiFIKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242960AbiFIKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0126214812;
        Thu,  9 Jun 2022 03:36:21 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgTL0SD0z67LRs;
        Thu,  9 Jun 2022 18:35:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:19 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:16 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 07/18] libata-scsi: Add ata_internal_queuecommand()
Date:   Thu, 9 Jun 2022 18:29:08 +0800
Message-ID: <1654770559-101375-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add callback to queue reserved commands - call it "internal" as this is
what libata uses.

Also add it to the base ATA SHT, and set nr_reserved_cmds = 1, which
matches tag ATA_TAG_INTERNAL.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-scsi.c | 14 ++++++++++++++
 include/linux/libata.h    |  6 +++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index baac35dd17ca..b2702ab0183b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1114,6 +1114,20 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	return 0;
 }
 
+int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
+{
+	struct ata_port *ap;
+	int res;
+
+	ap = ata_shost_to_port(shost);
+	spin_lock_irq(ap->lock);
+	res = ata_sas_queuecmd(scmd, ap);
+	spin_unlock_irq(ap->lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(ata_internal_queuecommand);
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 43f4bcfe9a5f..5fa6f56bba81 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
 			      sector_t capacity, int geom[]);
 extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern int ata_internal_queuecommand(struct Scsi_Host *shost,
+				struct scsi_cmnd *scmd);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
@@ -1390,7 +1392,9 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.proc_name		= drv_name,			\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
-	.unlock_native_capacity	= ata_scsi_unlock_native_capacity
+	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
+	.nr_reserved_cmds = 1,\
+	.reserved_queuecommand = ata_internal_queuecommand
 
 #define ATA_SUBBASE_SHT(drv_name)				\
 	__ATA_BASE_SHT(drv_name),				\
-- 
2.26.2

