Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4314F91EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiDHJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDHJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:13:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56B2B04C7;
        Fri,  8 Apr 2022 02:09:52 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZXTD349Hz684Y0;
        Fri,  8 Apr 2022 17:07:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 8 Apr 2022 11:09:49 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 10:09:47 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <hch@lst.de>
CC:     <linux-doc@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v4] libata: Improve ATA queued command allocation
Date:   Fri, 8 Apr 2022 17:04:12 +0800
Message-ID: <1649408652-217372-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Improve ATA queued command allocation as follows:

- For attaining a qc tag for a SAS host we need to allocate a bit in
  ata_port.sas_tag_allocated bitmap.

  However we already have a unique tag per device in range
  [0, ATA_MAX_QUEUE -1] in the scsi cmnd budget token, so just use that
  instead.

- It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
  pokes scsi internals, so inline it in ata_scsi_qc_new() (in
  libata-scsi.c). Also update Doc accordingly.

- Use standard SCSI helpers set_host_byte() and set_status_byte() in
  ata_scsi_qc_new().

Christoph Hellwig originally contributed the change to inline
ata_qc_new_init().

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Do not apply on a kernel without "scsi: core: Fix sbitmap depth in
scsi_realloc_sdev_budget_map()" - hopefully v5.18-rc2 will include it.

Changes since v3:
- Add RB tag (thanks)
- remove double set of qc->scsicmd (Advised by Christoph)

Changes since v2 series:
- combine into a single patch
- use scsi helpers (Damien)
- use inclusive brackets for commit message description

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
index cceedde51126..5e7d6ccad5da 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4563,42 +4563,6 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 #endif /* __BIG_ENDIAN */
 }
 
-/**
- *	ata_qc_new_init - Request an available ATA command, and initialize it
- *	@dev: Device from whom we request an available command structure
- *	@tag: tag
- *
- *	LOCKING:
- *	None.
- */
-
-struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
-{
-	struct ata_port *ap = dev->link->ap;
-	struct ata_queued_cmd *qc;
-
-	/* no command while frozen */
-	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
-		return NULL;
-
-	/* libsas case */
-	if (ap->flags & ATA_FLAG_SAS_HOST) {
-		tag = ata_sas_allocate_tag(ap);
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
@@ -4611,19 +4575,9 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap;
-	unsigned int tag;
-
-	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
-	ap = qc->ap;
-
 	qc->flags = 0;
-	tag = qc->tag;
-	if (ata_tag_valid(tag)) {
+	if (ata_tag_valid(qc->tag))
 		qc->tag = ATA_TAG_POISON;
-		if (ap->flags & ATA_FLAG_SAS_HOST)
-			ata_sas_free_tag(tag, ap);
-	}
 }
 
 void __ata_qc_complete(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 044a16daa2d4..7a5fe41aa5ae 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1268,31 +1268,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
 
-int ata_sas_allocate_tag(struct ata_port *ap)
-{
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
-
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
-}
-
 /**
  *	sata_async_notification - SATA async notification handler
  *	@ap: ATA port where async notification is received
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 06c9d90238d9..42cecf95a4e5 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -638,24 +638,48 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 					      struct scsi_cmnd *cmd)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
+	int tag;
 
-	qc = ata_qc_new_init(dev, scsi_cmd_to_rq(cmd)->tag);
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
+
 	return qc;
+
+fail:
+	set_host_byte(cmd, DID_OK);
+	set_status_byte(cmd, SAM_STAT_TASK_SET_FULL);
+	scsi_done(cmd);
+	return NULL;
 }
 
 static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c9c2496d91ea..926a7f41303d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,7 +44,6 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
 #endif
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag, int class);
@@ -91,18 +90,6 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
-/* libata-sata.c */
-#ifdef CONFIG_SATA_HOST
-int ata_sas_allocate_tag(struct ata_port *ap);
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
-#else
-static inline int ata_sas_allocate_tag(struct ata_port *ap)
-{
-	return -EOPNOTSUPP;
-}
-static inline void ata_sas_free_tag(unsigned int tag, struct ata_port *ap) { }
-#endif
-
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
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

