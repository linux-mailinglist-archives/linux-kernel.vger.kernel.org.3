Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BB4D9990
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiCOKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347653AbiCOKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:48:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331D39BA1;
        Tue, 15 Mar 2022 03:45:08 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KHqlj106pz67Y1y;
        Tue, 15 Mar 2022 18:44:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 11:45:01 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 10:44:58 +0000
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <bvanassche@acm.org>,
        <ming.lei@redhat.com>, <hch@lst.de>, <hare@suse.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <martin.wilck@suse.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag for SAS host
Date:   Tue, 15 Mar 2022 18:39:06 +0800
Message-ID: <1647340746-17600-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For attaining a qc tag for a SAS host we need to allocate a bit in
ata_port.sas_tag_allocated bitmap.

However we already have a unique tag per device in range
[0, ATA_MAX_QUEUE) in the scsi cmnd budget token, so just use that
instead.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-core.c |  5 +++--
 drivers/ata/libata-sata.c | 21 ++++-----------------
 drivers/ata/libata-scsi.c |  2 +-
 drivers/ata/libata.h      |  4 ++--
 include/linux/libata.h    |  1 -
 5 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c854aebfe0b..2c0a550d3ecd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4572,8 +4572,9 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
  *	None.
  */
 
-struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
+struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd)
 {
+	int tag = scsi_cmd_to_rq(scmd)->tag;
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
@@ -4583,7 +4584,7 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
 
 	/* libsas case */
 	if (ap->flags & ATA_FLAG_SAS_HOST) {
-		tag = ata_sas_allocate_tag(ap);
+		tag = ata_sas_allocate_tag(ap, scmd);
 		if (tag < 0)
 			return NULL;
 	}
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 071158c0c44c..a4374fdffc43 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1268,29 +1268,16 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
 
-int ata_sas_allocate_tag(struct ata_port *ap)
+int ata_sas_allocate_tag(struct ata_port *ap, struct scsi_cmnd *scmd)
 {
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
+	if (scmd->budget_token >= ATA_MAX_QUEUE)
+		return -1;
 
-	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
-		tag = tag < max_queue ? tag : 0;
-
-		/* the last tag is reserved for internal command. */
-		if (ata_tag_internal(tag))
-			continue;
-
-		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
-			ap->sas_last_tag = tag;
-			return tag;
-		}
-	}
-	return -1;
+	return scmd->budget_token;
 }
 
 void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
 {
-	clear_bit(tag, &ap->sas_tag_allocated);
 }
 
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ed8be585a98f..45d63a2ba3ee 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -640,7 +640,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 {
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new_init(dev, scsi_cmd_to_rq(cmd)->tag);
+	qc = ata_qc_new_init(dev, cmd);
 	if (qc) {
 		qc->scsicmd = cmd;
 		qc->scsidone = scsi_done;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 51e01acdd241..65302d7829fe 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,7 +44,7 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
 #endif
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
+extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag, int class);
@@ -93,7 +93,7 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 /* libata-sata.c */
 #ifdef CONFIG_SATA_HOST
-int ata_sas_allocate_tag(struct ata_port *ap);
+int ata_sas_allocate_tag(struct ata_port *ap, struct scsi_cmnd *scmd);
 void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
 #else
 static inline int ata_sas_allocate_tag(struct ata_port *ap)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7f99b4d78822..3b9399f67b39 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -814,7 +814,6 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
-	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 	unsigned int		sas_last_tag;	/* track next tag hw expects */
-- 
2.26.2

