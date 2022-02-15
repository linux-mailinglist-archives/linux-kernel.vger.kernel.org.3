Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B84B7794
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbiBOStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiBOStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:49:45 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A03673EC;
        Tue, 15 Feb 2022 10:49:30 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 00FEB207D564
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] ata: add/use ata_taskfile::{error|status} fields
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <8ecca7a5-1930-b2c5-d850-17caa4b95644@omp.ru>
Date:   Tue, 15 Feb 2022 21:49:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the explicit error and status register fields to 'struct ata_taskfile'
using the anonymous *union*s ('struct ide_taskfile' had that for ages!) and
update the libata taskfile code accordingly. There should be no object code
changes resulting from that...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo plus the recently posted patches:

https://lore.kernel.org/all/20220213151032.4694-1-s.shtylyov@omp.ru/
https://lore.kernel.org/all/7440bd27-b841-c3f0-2b47-4ab3f0ac0c83@omp.ru/

Changes in version 2:
- fixed the compilation error in 'sata_vsc.c'.

 drivers/ata/acard-ahci.c      |    2 +-
 drivers/ata/ahci.c            |    4 ++--
 drivers/ata/ahci_qoriq.c      |    2 +-
 drivers/ata/ahci_xgene.c      |    2 +-
 drivers/ata/libahci.c         |    4 ++--
 drivers/ata/libata-acpi.c     |    8 ++++----
 drivers/ata/libata-core.c     |   12 ++++++------
 drivers/ata/libata-eh.c       |   42 +++++++++++++++++++++---------------------
 drivers/ata/libata-sata.c     |   10 +++++-----
 drivers/ata/libata-scsi.c     |   22 +++++++++++-----------
 drivers/ata/libata-sff.c      |    6 +++---
 drivers/ata/pata_ep93xx.c     |    4 ++--
 drivers/ata/pata_ns87415.c    |    4 ++--
 drivers/ata/pata_octeon_cf.c  |    4 ++--
 drivers/ata/pata_samsung_cf.c |    2 +-
 drivers/ata/sata_highbank.c   |    2 +-
 drivers/ata/sata_inic162x.c   |   10 +++++-----
 drivers/ata/sata_rcar.c       |    4 ++--
 drivers/ata/sata_svw.c        |   10 +++++-----
 drivers/ata/sata_vsc.c        |   10 +++++-----
 include/linux/libata.h        |   10 ++++++++--
 21 files changed, 90 insertions(+), 84 deletions(-)

Index: libata/drivers/ata/acard-ahci.c
===================================================================
--- libata.orig/drivers/ata/acard-ahci.c
+++ libata/drivers/ata/acard-ahci.c
@@ -265,7 +265,7 @@ static bool acard_ahci_qc_fill_rtf(struc
 	if (qc->tf.protocol == ATA_PROT_PIO && qc->dma_dir == DMA_FROM_DEVICE &&
 	    !(qc->flags & ATA_QCFLAG_FAILED)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
-		qc->result_tf.command = (rx_fis + RX_FIS_PIO_SETUP)[15];
+		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
 	} else
 		ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
 
Index: libata/drivers/ata/ahci.c
===================================================================
--- libata.orig/drivers/ata/ahci.c
+++ libata/drivers/ata/ahci.c
@@ -739,7 +739,7 @@ static int ahci_p5wdh_hardreset(struct a
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = ATA_BUSY;
+	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
@@ -808,7 +808,7 @@ static int ahci_avn_hardreset(struct ata
 
 		/* clear D2H reception area to properly wait for D2H FIS */
 		ata_tf_init(link->device, &tf);
-		tf.command = ATA_BUSY;
+		tf.status = ATA_BUSY;
 		ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 		rc = sata_link_hardreset(link, timing, deadline, &online,
Index: libata/drivers/ata/ahci_qoriq.c
===================================================================
--- libata.orig/drivers/ata/ahci_qoriq.c
+++ libata/drivers/ata/ahci_qoriq.c
@@ -123,7 +123,7 @@ static int ahci_qoriq_hardreset(struct a
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = ATA_BUSY;
+	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_link_hardreset(link, timing, deadline, &online,
Index: libata/drivers/ata/ahci_xgene.c
===================================================================
--- libata.orig/drivers/ata/ahci_xgene.c
+++ libata/drivers/ata/ahci_xgene.c
@@ -365,7 +365,7 @@ static int xgene_ahci_do_hardreset(struc
 	do {
 		/* clear D2H reception area to properly wait for D2H FIS */
 		ata_tf_init(link->device, &tf);
-		tf.command = ATA_BUSY;
+		tf.status = ATA_BUSY;
 		ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 		rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
Index: libata/drivers/ata/libahci.c
===================================================================
--- libata.orig/drivers/ata/libahci.c
+++ libata/drivers/ata/libahci.c
@@ -1561,7 +1561,7 @@ int ahci_do_hardreset(struct ata_link *l
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = ATA_BUSY;
+	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_link_hardreset(link, timing, deadline, online,
@@ -2033,7 +2033,7 @@ static bool ahci_qc_fill_rtf(struct ata_
 	if (qc->tf.protocol == ATA_PROT_PIO && qc->dma_dir == DMA_FROM_DEVICE &&
 	    !(qc->flags & ATA_QCFLAG_FAILED)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
-		qc->result_tf.command = (rx_fis + RX_FIS_PIO_SETUP)[15];
+		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
 	} else
 		ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
 
Index: libata/drivers/ata/libata-acpi.c
===================================================================
--- libata.orig/drivers/ata/libata-acpi.c
+++ libata/drivers/ata/libata-acpi.c
@@ -546,13 +546,13 @@ static void ata_acpi_gtf_to_tf(struct at
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
-	tf->feature = gtf->tf[0];	/* 0x1f1 */
+	tf->error   = gtf->tf[0];	/* 0x1f1 */
 	tf->nsect   = gtf->tf[1];	/* 0x1f2 */
 	tf->lbal    = gtf->tf[2];	/* 0x1f3 */
 	tf->lbam    = gtf->tf[3];	/* 0x1f4 */
 	tf->lbah    = gtf->tf[4];	/* 0x1f5 */
 	tf->device  = gtf->tf[5];	/* 0x1f6 */
-	tf->command = gtf->tf[6];	/* 0x1f7 */
+	tf->status  = gtf->tf[6];	/* 0x1f7 */
 }
 
 static int ata_acpi_filter_tf(struct ata_device *dev,
@@ -679,7 +679,7 @@ static int ata_acpi_run_tf(struct ata_de
 				"(%s) rejected by device (Stat=0x%02x Err=0x%02x)",
 				tf.command, tf.feature, tf.nsect, tf.lbal,
 				tf.lbam, tf.lbah, tf.device, descr,
-				rtf.command, rtf.feature);
+				rtf.status, rtf.error);
 			rc = 0;
 			break;
 
@@ -689,7 +689,7 @@ static int ata_acpi_run_tf(struct ata_de
 				"(%s) failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
 				tf.command, tf.feature, tf.nsect, tf.lbal,
 				tf.lbam, tf.lbah, tf.device, descr,
-				err_mask, rtf.command, rtf.feature);
+				err_mask, rtf.status, rtf.error);
 			rc = -EIO;
 			break;
 		}
Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -1171,7 +1171,7 @@ static int ata_read_native_max_address(s
 		ata_dev_warn(dev,
 			     "failed to read native max address (err_mask=0x%x)\n",
 			     err_mask);
-		if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
+		if (err_mask == AC_ERR_DEV && (tf.error & ATA_ABORTED))
 			return -EACCES;
 		return -EIO;
 	}
@@ -1235,7 +1235,7 @@ static int ata_set_max_sectors(struct at
 			     "failed to set max address (err_mask=0x%x)\n",
 			     err_mask);
 		if (err_mask == AC_ERR_DEV &&
-		    (tf.feature & (ATA_ABORTED | ATA_IDNF)))
+		    (tf.error & (ATA_ABORTED | ATA_IDNF)))
 			return -EACCES;
 		return -EIO;
 	}
@@ -1584,7 +1584,7 @@ unsigned ata_exec_internal_sg(struct ata
 
 	/* perform minimal error analysis */
 	if (qc->flags & ATA_QCFLAG_FAILED) {
-		if (qc->result_tf.command & (ATA_ERR | ATA_DF))
+		if (qc->result_tf.status & (ATA_ERR | ATA_DF))
 			qc->err_mask |= AC_ERR_DEV;
 
 		if (!qc->err_mask)
@@ -1593,7 +1593,7 @@ unsigned ata_exec_internal_sg(struct ata
 		if (qc->err_mask & ~AC_ERR_OTHER)
 			qc->err_mask &= ~AC_ERR_OTHER;
 	} else if (qc->tf.command == ATA_CMD_REQ_SENSE_DATA) {
-		qc->result_tf.command |= ATA_SENSE;
+		qc->result_tf.status |= ATA_SENSE;
 	}
 
 	/* finish up */
@@ -1813,7 +1813,7 @@ retry:
 			return 0;
 		}
 
-		if ((err_mask == AC_ERR_DEV) && (tf.feature & ATA_ABORTED)) {
+		if ((err_mask == AC_ERR_DEV) && (tf.error & ATA_ABORTED)) {
 			/* Device or controller might have reported
 			 * the wrong device class.  Give a shot at the
 			 * other IDENTIFY if the current one is
@@ -4375,7 +4375,7 @@ static unsigned int ata_dev_init_params(
 	/* A clean abort indicates an original or just out of spec drive
 	   and we should continue as we issue the setup based on the
 	   drive reported working geometry */
-	if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
+	if (err_mask == AC_ERR_DEV && (tf.error & ATA_ABORTED))
 		err_mask = 0;
 
 	return err_mask;
Index: libata/drivers/ata/libata-eh.c
===================================================================
--- libata.orig/drivers/ata/libata-eh.c
+++ libata/drivers/ata/libata-eh.c
@@ -1386,7 +1386,7 @@ unsigned int atapi_eh_tur(struct ata_dev
 
 	err_mask = ata_exec_internal(dev, &tf, cdb, DMA_NONE, NULL, 0, 0);
 	if (err_mask == AC_ERR_DEV)
-		*r_sense_key = tf.feature >> 4;
+		*r_sense_key = tf.error >> 4;
 	return err_mask;
 }
 
@@ -1429,12 +1429,12 @@ static void ata_eh_request_sense(struct
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	/* Ignore err_mask; ATA_ERR might be set */
-	if (tf.command & ATA_SENSE) {
+	if (tf.status & ATA_SENSE) {
 		ata_scsi_set_sense(dev, cmd, tf.lbah, tf.lbam, tf.lbal);
 		qc->flags |= ATA_QCFLAG_SENSE_VALID;
 	} else {
 		ata_dev_warn(dev, "request sense failed stat %02x emask %x\n",
-			     tf.command, err_mask);
+			     tf.status, err_mask);
 	}
 }
 
@@ -1557,7 +1557,7 @@ static unsigned int ata_eh_analyze_tf(st
 				      const struct ata_taskfile *tf)
 {
 	unsigned int tmp, action = 0;
-	u8 stat = tf->command, err = tf->feature;
+	u8 stat = tf->status, err = tf->error;
 
 	if ((stat & (ATA_BUSY | ATA_DRQ | ATA_DRDY)) != ATA_DRDY) {
 		qc->err_mask |= AC_ERR_HSM;
@@ -1594,7 +1594,7 @@ static unsigned int ata_eh_analyze_tf(st
 		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
 			tmp = atapi_eh_request_sense(qc->dev,
 						qc->scsicmd->sense_buffer,
-						qc->result_tf.feature >> 4);
+						qc->result_tf.error >> 4);
 			if (!tmp)
 				qc->flags |= ATA_QCFLAG_SENSE_VALID;
 			else
@@ -2360,7 +2360,7 @@ static void ata_eh_link_report(struct at
 			cmd->hob_feature, cmd->hob_nsect,
 			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
 			cmd->device, qc->tag, data_buf, cdb_buf,
-			res->command, res->feature, res->nsect,
+			res->status, res->error, res->nsect,
 			res->lbal, res->lbam, res->lbah,
 			res->hob_feature, res->hob_nsect,
 			res->hob_lbal, res->hob_lbam, res->hob_lbah,
@@ -2368,28 +2368,28 @@ static void ata_eh_link_report(struct at
 			qc->err_mask & AC_ERR_NCQ ? " <F>" : "");
 
 #ifdef CONFIG_ATA_VERBOSE_ERROR
-		if (res->command & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ |
-				    ATA_SENSE | ATA_ERR)) {
-			if (res->command & ATA_BUSY)
+		if (res->status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ |
+				   ATA_SENSE | ATA_ERR)) {
+			if (res->status & ATA_BUSY)
 				ata_dev_err(qc->dev, "status: { Busy }\n");
 			else
 				ata_dev_err(qc->dev, "status: { %s%s%s%s%s}\n",
-				  res->command & ATA_DRDY ? "DRDY " : "",
-				  res->command & ATA_DF ? "DF " : "",
-				  res->command & ATA_DRQ ? "DRQ " : "",
-				  res->command & ATA_SENSE ? "SENSE " : "",
-				  res->command & ATA_ERR ? "ERR " : "");
+				  res->status & ATA_DRDY ? "DRDY " : "",
+				  res->status & ATA_DF ? "DF " : "",
+				  res->status & ATA_DRQ ? "DRQ " : "",
+				  res->status & ATA_SENSE ? "SENSE " : "",
+				  res->status & ATA_ERR ? "ERR " : "");
 		}
 
 		if (cmd->command != ATA_CMD_PACKET &&
-		    (res->feature & (ATA_ICRC | ATA_UNC | ATA_AMNF |
-				     ATA_IDNF | ATA_ABORTED)))
+		    (res->error & (ATA_ICRC | ATA_UNC | ATA_AMNF | ATA_IDNF |
+				   ATA_ABORTED)))
 			ata_dev_err(qc->dev, "error: { %s%s%s%s%s}\n",
-			  res->feature & ATA_ICRC ? "ICRC " : "",
-			  res->feature & ATA_UNC ? "UNC " : "",
-			  res->feature & ATA_AMNF ? "AMNF " : "",
-			  res->feature & ATA_IDNF ? "IDNF " : "",
-			  res->feature & ATA_ABORTED ? "ABRT " : "");
+				    res->error & ATA_ICRC ? "ICRC " : "",
+				    res->error & ATA_UNC ? "UNC " : "",
+				    res->error & ATA_AMNF ? "AMNF " : "",
+				    res->error & ATA_IDNF ? "IDNF " : "",
+				    res->error & ATA_ABORTED ? "ABRT " : "");
 #endif
 	}
 }
Index: libata/drivers/ata/libata-sata.c
===================================================================
--- libata.orig/drivers/ata/libata-sata.c
+++ libata/drivers/ata/libata-sata.c
@@ -191,8 +191,8 @@ EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 
 void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
 {
-	tf->command	= fis[2];	/* status */
-	tf->feature	= fis[3];	/* error */
+	tf->status	= fis[2];
+	tf->error	= fis[3];
 
 	tf->lbal	= fis[4];
 	tf->lbam	= fis[5];
@@ -1406,8 +1406,8 @@ static int ata_eh_read_log_10h(struct at
 
 	*tag = buf[0] & 0x1f;
 
-	tf->command = buf[2];
-	tf->feature = buf[3];
+	tf->status = buf[2];
+	tf->error = buf[3];
 	tf->lbal = buf[4];
 	tf->lbam = buf[5];
 	tf->lbah = buf[6];
@@ -1482,7 +1482,7 @@ void ata_eh_analyze_ncq_error(struct ata
 	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
 	if (dev->class == ATA_DEV_ZAC &&
-	    ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary)) {
+	    ((qc->result_tf.status & ATA_SENSE) || qc->result_tf.auxiliary)) {
 		char sense_key, asc, ascq;
 
 		sense_key = (qc->result_tf.auxiliary >> 16) & 0xff;
Index: libata/drivers/ata/libata-scsi.c
===================================================================
--- libata.orig/drivers/ata/libata-scsi.c
+++ libata/drivers/ata/libata-scsi.c
@@ -680,7 +680,7 @@ static void ata_qc_set_pc_nbytes(struct
  */
 static void ata_dump_status(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	u8 stat = tf->command, err = tf->feature;
+	u8 stat = tf->status, err = tf->error;
 
 	if (stat & ATA_BUSY) {
 		ata_port_warn(ap, "status=0x%02x {Busy} ", stat);
@@ -871,8 +871,8 @@ static void ata_gen_passthru_sense(struc
 	 * onto sense key, asc & ascq.
 	 */
 	if (qc->err_mask ||
-	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->command, tf->feature,
+	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
 				   &sense_key, &asc, &ascq, verbose);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -901,13 +901,13 @@ static void ata_gen_passthru_sense(struc
 		 * Copy registers into sense buffer.
 		 */
 		desc[2] = 0x00;
-		desc[3] = tf->feature;	/* == error reg */
+		desc[3] = tf->error;
 		desc[5] = tf->nsect;
 		desc[7] = tf->lbal;
 		desc[9] = tf->lbam;
 		desc[11] = tf->lbah;
 		desc[12] = tf->device;
-		desc[13] = tf->command; /* == status reg */
+		desc[13] = tf->status;
 
 		/*
 		 * Fill in Extend bit, and the high order bytes
@@ -922,8 +922,8 @@ static void ata_gen_passthru_sense(struc
 		}
 	} else {
 		/* Fixed sense format */
-		desc[0] = tf->feature;
-		desc[1] = tf->command; /* status */
+		desc[0] = tf->error;
+		desc[1] = tf->status;
 		desc[2] = tf->device;
 		desc[3] = tf->nsect;
 		desc[7] = 0;
@@ -972,14 +972,14 @@ static void ata_gen_ata_sense(struct ata
 	 * onto sense key, asc & ascq.
 	 */
 	if (qc->err_mask ||
-	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->command, tf->feature,
+	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
 				   &sense_key, &asc, &ascq, verbose);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
 		/* Could not decode error */
 		ata_dev_warn(dev, "could not decode error status 0x%x err_mask 0x%x\n",
-			     tf->command, qc->err_mask);
+			     tf->status, qc->err_mask);
 		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
@@ -2473,7 +2473,7 @@ static void atapi_request_sense(struct a
 
 	/* fill these in, for the case where they are -not- overwritten */
 	cmd->sense_buffer[0] = 0x70;
-	cmd->sense_buffer[2] = qc->tf.feature >> 4;
+	cmd->sense_buffer[2] = qc->tf.error >> 4;
 
 	ata_qc_reinit(qc);
 
Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -449,8 +449,8 @@ void ata_sff_tf_read(struct ata_port *ap
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->command = ata_sff_check_status(ap);
-	tf->feature = ioread8(ioaddr->error_addr);
+	tf->status = ata_sff_check_status(ap);
+	tf->error = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
 	tf->lbal = ioread8(ioaddr->lbal_addr);
 	tf->lbam = ioread8(ioaddr->lbam_addr);
@@ -1824,7 +1824,7 @@ unsigned int ata_sff_dev_classify(struct
 	memset(&tf, 0, sizeof(tf));
 
 	ap->ops->sff_tf_read(ap, &tf);
-	err = tf.feature;
+	err = tf.error;
 	if (r_err)
 		*r_err = err;
 
Index: libata/drivers/ata/pata_ep93xx.c
===================================================================
--- libata.orig/drivers/ata/pata_ep93xx.c
+++ libata/drivers/ata/pata_ep93xx.c
@@ -416,8 +416,8 @@ static void ep93xx_pata_tf_read(struct a
 {
 	struct ep93xx_pata_data *drv_data = ap->host->private_data;
 
-	tf->command = ep93xx_pata_check_status(ap);
-	tf->feature = ep93xx_pata_read_reg(drv_data, IDECTRL_ADDR_FEATURE);
+	tf->status = ep93xx_pata_check_status(ap);
+	tf->error = ep93xx_pata_read_reg(drv_data, IDECTRL_ADDR_FEATURE);
 	tf->nsect = ep93xx_pata_read_reg(drv_data, IDECTRL_ADDR_NSECT);
 	tf->lbal = ep93xx_pata_read_reg(drv_data, IDECTRL_ADDR_LBAL);
 	tf->lbam = ep93xx_pata_read_reg(drv_data, IDECTRL_ADDR_LBAM);
Index: libata/drivers/ata/pata_ns87415.c
===================================================================
--- libata.orig/drivers/ata/pata_ns87415.c
+++ libata/drivers/ata/pata_ns87415.c
@@ -264,8 +264,8 @@ void ns87560_tf_read(struct ata_port *ap
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->command = ns87560_check_status(ap);
-	tf->feature = ioread8(ioaddr->error_addr);
+	tf->status = ns87560_check_status(ap);
+	tf->error = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
 	tf->lbal = ioread8(ioaddr->lbal_addr);
 	tf->lbam = ioread8(ioaddr->lbam_addr);
Index: libata/drivers/ata/pata_octeon_cf.c
===================================================================
--- libata.orig/drivers/ata/pata_octeon_cf.c
+++ libata/drivers/ata/pata_octeon_cf.c
@@ -382,7 +382,7 @@ static void octeon_cf_tf_read16(struct a
 	void __iomem *base = ap->ioaddr.data_addr;
 
 	blob = __raw_readw(base + 0xc);
-	tf->feature = blob >> 8;
+	tf->error = blob >> 8;
 
 	blob = __raw_readw(base + 2);
 	tf->nsect = blob & 0xff;
@@ -394,7 +394,7 @@ static void octeon_cf_tf_read16(struct a
 
 	blob = __raw_readw(base + 6);
 	tf->device = blob & 0xff;
-	tf->command = blob >> 8;
+	tf->status = blob >> 8;
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		if (likely(ap->ioaddr.ctl_addr)) {
Index: libata/drivers/ata/pata_samsung_cf.c
===================================================================
--- libata.orig/drivers/ata/pata_samsung_cf.c
+++ libata/drivers/ata/pata_samsung_cf.c
@@ -213,7 +213,7 @@ static void pata_s3c_tf_read(struct ata_
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->feature = ata_inb(ap->host, ioaddr->error_addr);
+	tf->error = ata_inb(ap->host, ioaddr->error_addr);
 	tf->nsect = ata_inb(ap->host, ioaddr->nsect_addr);
 	tf->lbal = ata_inb(ap->host, ioaddr->lbal_addr);
 	tf->lbam = ata_inb(ap->host, ioaddr->lbam_addr);
Index: libata/drivers/ata/sata_highbank.c
===================================================================
--- libata.orig/drivers/ata/sata_highbank.c
+++ libata/drivers/ata/sata_highbank.c
@@ -400,7 +400,7 @@ static int ahci_highbank_hardreset(struc
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = ATA_BUSY;
+	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	do {
Index: libata/drivers/ata/sata_inic162x.c
===================================================================
--- libata.orig/drivers/ata/sata_inic162x.c
+++ libata/drivers/ata/sata_inic162x.c
@@ -557,13 +557,13 @@ static void inic_tf_read(struct ata_port
 {
 	void __iomem *port_base = inic_port_base(ap);
 
-	tf->feature	= readb(port_base + PORT_TF_FEATURE);
+	tf->error	= readb(port_base + PORT_TF_FEATURE);
 	tf->nsect	= readb(port_base + PORT_TF_NSECT);
 	tf->lbal	= readb(port_base + PORT_TF_LBAL);
 	tf->lbam	= readb(port_base + PORT_TF_LBAM);
 	tf->lbah	= readb(port_base + PORT_TF_LBAH);
 	tf->device	= readb(port_base + PORT_TF_DEVICE);
-	tf->command	= readb(port_base + PORT_TF_COMMAND);
+	tf->status	= readb(port_base + PORT_TF_COMMAND);
 }
 
 static bool inic_qc_fill_rtf(struct ata_queued_cmd *qc)
@@ -580,11 +580,11 @@ static bool inic_qc_fill_rtf(struct ata_
 	 */
 	inic_tf_read(qc->ap, &tf);
 
-	if (!(tf.command & ATA_ERR))
+	if (!(tf.status & ATA_ERR))
 		return false;
 
-	rtf->command = tf.command;
-	rtf->feature = tf.feature;
+	rtf->status = tf.status;
+	rtf->error = tf.error;
 	return true;
 }
 
Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -394,8 +394,8 @@ static void sata_rcar_tf_read(struct ata
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->command = sata_rcar_check_status(ap);
-	tf->feature = ioread32(ioaddr->error_addr);
+	tf->status = sata_rcar_check_status(ap);
+	tf->error = ioread32(ioaddr->error_addr);
 	tf->nsect = ioread32(ioaddr->nsect_addr);
 	tf->lbal = ioread32(ioaddr->lbal_addr);
 	tf->lbam = ioread32(ioaddr->lbam_addr);
Index: libata/drivers/ata/sata_svw.c
===================================================================
--- libata.orig/drivers/ata/sata_svw.c
+++ libata/drivers/ata/sata_svw.c
@@ -194,24 +194,24 @@ static void k2_sata_tf_load(struct ata_p
 static void k2_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u16 nsect, lbal, lbam, lbah, feature;
+	u16 nsect, lbal, lbam, lbah, error;
 
-	tf->command = k2_stat_check_status(ap);
+	tf->status = k2_stat_check_status(ap);
 	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
+	error = readw(ioaddr->error_addr);
 	nsect = readw(ioaddr->nsect_addr);
 	lbal = readw(ioaddr->lbal_addr);
 	lbam = readw(ioaddr->lbam_addr);
 	lbah = readw(ioaddr->lbah_addr);
 
-	tf->feature = feature;
+	tf->error = error;
 	tf->nsect = nsect;
 	tf->lbal = lbal;
 	tf->lbam = lbam;
 	tf->lbah = lbah;
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = feature >> 8;
+		tf->hob_feature = error >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
Index: libata/drivers/ata/sata_vsc.c
===================================================================
--- libata.orig/drivers/ata/sata_vsc.c
+++ libata/drivers/ata/sata_vsc.c
@@ -183,24 +183,24 @@ static void vsc_sata_tf_load(struct ata_
 static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u16 nsect, lbal, lbam, lbah, feature;
+	u16 nsect, lbal, lbam, lbah, error;
 
-	tf->command = ata_sff_check_status(ap);
+	tf->status = ata_sff_check_status(ap);
 	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
+	error = readw(ioaddr->error_addr);
 	nsect = readw(ioaddr->nsect_addr);
 	lbal = readw(ioaddr->lbal_addr);
 	lbam = readw(ioaddr->lbam_addr);
 	lbah = readw(ioaddr->lbah_addr);
 
-	tf->feature = feature;
+	tf->error = error;
 	tf->nsect = nsect;
 	tf->lbal = lbal;
 	tf->lbam = lbam;
 	tf->lbah = lbah;
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = feature >> 8;
+		tf->hob_feature = error >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
Index: libata/include/linux/libata.h
===================================================================
--- libata.orig/include/linux/libata.h
+++ libata/include/linux/libata.h
@@ -518,7 +518,10 @@ struct ata_taskfile {
 	u8			hob_lbam;
 	u8			hob_lbah;
 
-	u8			feature;
+	union {
+		u8		error;
+		u8		feature;
+	};
 	u8			nsect;
 	u8			lbal;
 	u8			lbam;
@@ -526,7 +529,10 @@ struct ata_taskfile {
 
 	u8			device;
 
-	u8			command;	/* IO operation */
+	union {
+		u8		status;
+		u8		command;
+	};
 
 	u32			auxiliary;	/* auxiliary field */
 						/* from SATA 3.1 and */
