Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FCA4F17C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378333AbiDDPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378296AbiDDPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:00:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35112BF6F;
        Mon,  4 Apr 2022 07:58:59 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDQM5WYWz67ms2;
        Mon,  4 Apr 2022 22:57:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:58:57 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 15:58:54 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in ata_scsi_qc_new()
Date:   Mon, 4 Apr 2022 22:53:10 +0800
Message-ID: <1649083990-207133-3-git-send-email-john.garry@huawei.com>
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

From: Christoph Hellwig <hch@lst.de>

It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
pokes scsi internals, so inline it in ata_scsi_qc_new() (in libata-scsi.c).

<Christoph, please provide signed-off-by>
[jpg, Take Christoph's change from list and form into a patch]
Signed-off-by: John Garry <john.garry@huawei.com>
---
 Documentation/driver-api/libata.rst | 11 -------
 drivers/ata/libata-core.c           | 44 +---------------------------
 drivers/ata/libata-sata.c           |  8 -----
 drivers/ata/libata-scsi.c           | 45 ++++++++++++++++++++++-------
 drivers/ata/libata.h                | 12 --------
 5 files changed, 35 insertions(+), 85 deletions(-)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index d477e296bda5..311af516a3fd 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -424,12 +424,6 @@ How commands are issued
 -----------------------
 
 Internal commands
-    First, qc is allocated and initialized using :c:func:`ata_qc_new_init`.
-    Although :c:func:`ata_qc_new_init` doesn't implement any wait or retry
-    mechanism when qc is not available, internal commands are currently
-    issued only during initialization and error recovery, so no other
-    command is active and allocation is guaranteed to succeed.
-
     Once allocated qc's taskfile is initialized for the command to be
     executed. qc currently has two mechanisms to notify completion. One
     is via ``qc->complete_fn()`` callback and the other is completion
@@ -447,11 +441,6 @@ SCSI commands
     translated. No qc is involved in processing a simulated scmd. The
     result is computed right away and the scmd is completed.
 
-    For a translated scmd, :c:func:`ata_qc_new_init` is invoked to allocate a
-    qc and the scmd is translated into the qc. SCSI midlayer's
-    completion notification function pointer is stored into
-    ``qc->scsidone``.
-
     ``qc->complete_fn()`` callback is used for completion notification. ATA
     commands use :c:func:`ata_scsi_qc_complete` while ATAPI commands use
     :c:func:`atapi_qc_complete`. Both functions end up calling ``qc->scsidone``
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1067b2e2be28..5e7d6ccad5da 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4563,43 +4563,6 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 #endif /* __BIG_ENDIAN */
 }
 
-/**
- *	ata_qc_new_init - Request an available ATA command, and initialize it
- *	@dev: Device from whom we request an available command structure
- *	@scmd: scmd for which to get qc
- *
- *	LOCKING:
- *	None.
- */
-
-struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd)
-{
-	int tag = scsi_cmd_to_rq(scmd)->tag;
-	struct ata_port *ap = dev->link->ap;
-	struct ata_queued_cmd *qc;
-
-	/* no command while frozen */
-	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
-		return NULL;
-
-	/* libsas case */
-	if (ap->flags & ATA_FLAG_SAS_HOST) {
-		tag = ata_sas_get_tag(scmd);
-		if (tag < 0)
-			return NULL;
-	}
-
-	qc = __ata_qc_from_tag(ap, tag);
-	qc->tag = qc->hw_tag = tag;
-	qc->scsicmd = NULL;
-	qc->ap = ap;
-	qc->dev = dev;
-
-	ata_qc_reinit(qc);
-
-	return qc;
-}
-
 /**
  *	ata_qc_free - free unused ata_queued_cmd
  *	@qc: Command to complete
@@ -4612,13 +4575,8 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
-	unsigned int tag;
-
-	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
-
 	qc->flags = 0;
-	tag = qc->tag;
-	if (ata_tag_valid(tag))
+	if (ata_tag_valid(qc->tag))
 		qc->tag = ATA_TAG_POISON;
 }
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c3e9fd7d920c..7a5fe41aa5ae 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1268,14 +1268,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
 
-int ata_sas_get_tag(struct scsi_cmnd *scmd)
-{
-	if (WARN_ON_ONCE(scmd->budget_token >= ATA_MAX_QUEUE))
-		return -1;
-
-	return scmd->budget_token;
-}
-
 /**
  *	sata_async_notification - SATA async notification handler
  *	@ap: ATA port where async notification is received
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 61dd7f7c7743..50ef132ec48c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -638,24 +638,47 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 					      struct scsi_cmnd *cmd)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
+	int tag;
 
-	qc = ata_qc_new_init(dev, cmd);
-	if (qc) {
-		qc->scsicmd = cmd;
-		qc->scsidone = scsi_done;
-
-		qc->sg = scsi_sglist(cmd);
-		qc->n_elem = scsi_sg_count(cmd);
+	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
+		goto fail;
 
-		if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
-			qc->flags |= ATA_QCFLAG_QUIET;
+	if (ap->flags & ATA_FLAG_SAS_HOST) {
+		/*
+		 * SAS hosts may queue > ATA_MAX_QUEUE commands so use
+		 * unique per-device budget token as a tag.
+		 */
+		if (WARN_ON_ONCE(cmd->budget_token >= ATA_MAX_QUEUE))
+			goto fail;
+		tag = cmd->budget_token;
 	} else {
-		cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
-		scsi_done(cmd);
+		tag = scsi_cmd_to_rq(cmd)->tag;
 	}
 
+	qc = __ata_qc_from_tag(ap, tag);
+	qc->tag = qc->hw_tag = tag;
+	qc->scsicmd = NULL;
+	qc->ap = ap;
+	qc->dev = dev;
+
+	ata_qc_reinit(qc);
+
+	qc->scsicmd = cmd;
+	qc->scsidone = scsi_done;
+
+	qc->sg = scsi_sglist(cmd);
+	qc->n_elem = scsi_sg_count(cmd);
+
+	if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
+		qc->flags |= ATA_QCFLAG_QUIET;
 	return qc;
+
+fail:
+	cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
+	scsi_done(cmd);
+	return NULL;
 }
 
 static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 92e52090165b..926a7f41303d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,7 +44,6 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
 #endif
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag, int class);
@@ -91,17 +90,6 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
-/* libata-sata.c */
-#ifdef CONFIG_SATA_HOST
-int ata_sas_get_tag(struct scsi_cmnd *scmd);
-#else
-static inline int ata_sas_get_tag(struct scsi_cmnd *scmd)
-{
-	return -EOPNOTSUPP;
-}
-static inline void ata_sas_free_tag(unsigned int tag, struct ata_port *ap) { }
-#endif
-
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
-- 
2.26.2

