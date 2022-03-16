Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459354DAC87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354398AbiCPIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiCPIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:36:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5619E46175;
        Wed, 16 Mar 2022 01:34:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C578D68AFE; Wed, 16 Mar 2022 09:34:39 +0100 (CET)
Date:   Wed, 16 Mar 2022 09:34:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        ming.lei@redhat.com, hch@lst.de, hare@suse.de,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.wilck@suse.com
Subject: Re: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag
 for SAS host
Message-ID: <20220316083439.GA6701@lst.de>
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com> <1647340746-17600-3-git-send-email-john.garry@huawei.com> <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com> <650c667f-ca55-821d-4e0f-29fce69a68fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650c667f-ca55-821d-4e0f-29fce69a68fc@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the comments from Damien:  I think we should kill
ata_qc_new_init as well.  It is a bit pointless and having it in
libata-core.c when it pokes into scsi internals also doesn't make sense.

So maybe something like:

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index d477e296bda5f2..311af516a3fd9c 100644
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
index 0c854aebfe0bdc..811fceb4e647fa 100644
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
index 071158c0c44c1d..13e2c0d28b6937 100644
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
index ed8be585a98f7c..5e0bc7b05a107e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -638,24 +638,44 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
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
+		/* XXX: add a comment here why SAS is different */
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
index 51e01acdd24107..191f8bfe038656 100644
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
index 7f99b4d788223b..3b9399f67b3902 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -814,7 +814,6 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
-	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 	unsigned int		sas_last_tag;	/* track next tag hw expects */
