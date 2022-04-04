Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CDA4F17C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378327AbiDDPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbiDDPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:00:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A2DEFB;
        Mon,  4 Apr 2022 07:58:56 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDQK2q0hz687B7;
        Mon,  4 Apr 2022 22:57:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:58:54 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 15:58:52 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/2] libata: Use scsi cmnd budget token for qc tag for SAS host
Date:   Mon, 4 Apr 2022 22:53:09 +0800
Message-ID: <1649083990-207133-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
 drivers/ata/libata-core.c | 14 +++++---------
 drivers/ata/libata-sata.c | 25 ++++---------------------
 drivers/ata/libata-scsi.c |  2 +-
 drivers/ata/libata.h      |  7 +++----
 include/linux/libata.h    |  1 -
 5 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cceedde51126..1067b2e2be28 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4566,14 +4566,15 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 /**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
- *	@tag: tag
+ *	@scmd: scmd for which to get qc
  *
  *	LOCKING:
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
+		tag = ata_sas_get_tag(scmd);
 		if (tag < 0)
 			return NULL;
 	}
@@ -4611,19 +4612,14 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap;
 	unsigned int tag;
 
 	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
-	ap = qc->ap;
 
 	qc->flags = 0;
 	tag = qc->tag;
-	if (ata_tag_valid(tag)) {
+	if (ata_tag_valid(tag))
 		qc->tag = ATA_TAG_POISON;
-		if (ap->flags & ATA_FLAG_SAS_HOST)
-			ata_sas_free_tag(tag, ap);
-	}
 }
 
 void __ata_qc_complete(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 044a16daa2d4..c3e9fd7d920c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1268,29 +1268,12 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
 
-int ata_sas_allocate_tag(struct ata_port *ap)
+int ata_sas_get_tag(struct scsi_cmnd *scmd)
 {
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
+	if (WARN_ON_ONCE(scmd->budget_token >= ATA_MAX_QUEUE))
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
-}
-
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
-{
-	clear_bit(tag, &ap->sas_tag_allocated);
+	return scmd->budget_token;
 }
 
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 06c9d90238d9..61dd7f7c7743 100644
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
index c9c2496d91ea..92e52090165b 100644
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
@@ -93,10 +93,9 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 /* libata-sata.c */
 #ifdef CONFIG_SATA_HOST
-int ata_sas_allocate_tag(struct ata_port *ap);
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
+int ata_sas_get_tag(struct scsi_cmnd *scmd);
 #else
-static inline int ata_sas_allocate_tag(struct ata_port *ap)
+static inline int ata_sas_get_tag(struct scsi_cmnd *scmd)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b1d3d8b1252..16107122e587 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -820,7 +820,6 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
-	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 	unsigned int		sas_last_tag;	/* track next tag hw expects */
-- 
2.26.2

