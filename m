Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8584FA90D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbiDIOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiDIOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:36:38 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC45AECE;
        Sat,  9 Apr 2022 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1649514867;
        bh=JONHDRMOIlPli24qyI3ojfllbhWxT5+Ddzq9xlVhIRo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=sYmeelAzHwtH++90bLIqsx5dvHShdQf4ELkNCYMCy26s8HLskjCDkR1Zr0xIlk7Zx
         q/5s94fzxvmNc+cnzxZvBnfqpQO5UFEgo+XxSqSObtErZ99zqD/TvoKAqahisyJiVZ
         czzfZR4doppqgPi18M2dWgrROvgXYUToYcKJyAYc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6F78A12810D1;
        Sat,  9 Apr 2022 10:34:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id czX8NTtihJ6b; Sat,  9 Apr 2022 10:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1649514867;
        bh=JONHDRMOIlPli24qyI3ojfllbhWxT5+Ddzq9xlVhIRo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=sYmeelAzHwtH++90bLIqsx5dvHShdQf4ELkNCYMCy26s8HLskjCDkR1Zr0xIlk7Zx
         q/5s94fzxvmNc+cnzxZvBnfqpQO5UFEgo+XxSqSObtErZ99zqD/TvoKAqahisyJiVZ
         czzfZR4doppqgPi18M2dWgrROvgXYUToYcKJyAYc=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 724A912810CE;
        Sat,  9 Apr 2022 10:34:26 -0400 (EDT)
Message-ID: <7677b962e5416dc69b6c960dcfdba8ff454a8781.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.18-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 09 Apr 2022 10:34:25 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

38 Patches, two adding support for new devices (ufs, mvsas), a major
set of six fixes in lpfc plus a huge chunk removal in pmcraid to get
rid of a driver specific ioctl and a major rework of aha152x to get rid
of the scsi_pointer.  The rest are minor fixes and obvious changes
including several spelling updates.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel MTL

Alexey Galakhov (1):
      scsi: mvsas: Add PCI ID of RocketRaid 2640

Chandrakanth patil (1):
      scsi: megaraid_sas: Target with invalid LUN ID is deleted during scan

Christophe JAILLET (2):
      scsi: zorro7xx: Fix a resource leak in zorro7xx_remove_one()
      scsi: pmcraid: Remove the PMCRAID_PASSTHROUGH_IOCTL ioctl implementation

Colin Ian King (4):
      scsi: message: fusion: Remove redundant variable dmp
      scsi: bnx2i: Fix spelling mistake "mis-match" -> "mismatch"
      scsi: bnx2fc: Fix spelling mistake "mis-match" -> "mismatch"
      scsi: isci: Fix spelling mistake "doesnt" -> "doesn't"

Damien Le Moal (3):
      scsi: mpt3sas: Fix mpt3sas_check_same_4gb_region() kdoc comment
      scsi: scsi_debug: Fix sdebug_blk_mq_poll() in_use_bm bitmap use
      scsi: mpt3sas: Fix use after free in _scsih_expander_node_remove()

Dan Carpenter (1):
      scsi: hisi_sas: Remove stray fallthrough annotation

Finn Thain (2):
      scsi: sym53c500_cs: Stop using struct scsi_pointer
      scsi: aha152x: Stop using struct scsi_pointer

Jackie Liu (1):
      scsi: core: sysfs: Remove comments that conflict with the actual logic

James Smart (6):
      scsi: lpfc: Fix locking for lpfc_sli_iocbq_lookup()
      scsi: lpfc: Fix broken SLI4 abort path
      scsi: lpfc: Update lpfc version to 14.2.0.1
      scsi: lpfc: Fix queue failures when recovering from PCI parity error
      scsi: lpfc: Fix unload hang after back to back PCI EEH faults
      scsi: lpfc: Improve PCI EEH Error and Recovery Handling

John Garry (1):
      scsi: core: Fix sbitmap depth in scsi_realloc_sdev_budget_map()

Keoseong Park (1):
      scsi: ufs: core: Remove unused field in struct ufs_hba

Kevin Groeneveld (1):
      scsi: sr: Fix typo in CDROM(CLOSETRAY|EJECT) handling

Krzysztof Kozlowski (1):
      scsi: ufs: qcom: Drop custom Android boot parameters

Martin K. Petersen (1):
      scsi: sd: sd_read_cpr() requires VPD pages

Randy Dunlap (1):
      scsi: virtio-scsi: Eliminate anonymous module_init & module_exit

Sreekanth Reddy (1):
      scsi: mpt3sas: Fail reset operation if config request timed out

Tom Rix (1):
      scsi: aic7xxx: Use standard PCI subsystem, subdevice defines

Tomas Henzl (1):
      scsi: core: scsi_logging: Fix a BUG

Tyrel Datwyler (1):
      scsi: ibmvscsis: Increase INITIAL_SRP_LIMIT to 1024

Wenchao Hao (2):
      scsi: sd: Clean up gendisk if device_add_disk() failed
      scsi: libiscsi: Remove unnecessary memset() in iscsi_conn_setup()

Xiaoguang Wang (1):
      scsi: target: tcmu: Fix possible page UAF

Xiaomeng Tong (1):
      scsi: ufs: ufshpb: Fix a NULL check on list iterator

And the diffstat:

 drivers/message/fusion/mptbase.c          |   4 +-
 drivers/scsi/aha152x.c                    | 235 +++++++-------
 drivers/scsi/aic7xxx/aic79xx_osm.h        |   2 -
 drivers/scsi/aic7xxx/aic79xx_pci.c        |   6 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.h        |   2 -
 drivers/scsi/aic7xxx/aic7xxx_pci.c        |   4 +-
 drivers/scsi/bnx2fc/bnx2fc_hwi.c          |   6 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c            |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c     |   1 -
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c  |   2 +-
 drivers/scsi/isci/host.c                  |   6 +-
 drivers/scsi/libiscsi.c                   |   1 -
 drivers/scsi/lpfc/lpfc.h                  |   7 +-
 drivers/scsi/lpfc/lpfc_crtn.h             |   3 +
 drivers/scsi/lpfc/lpfc_hbadisc.c          | 120 ++++++--
 drivers/scsi/lpfc/lpfc_init.c             |  88 ++++--
 drivers/scsi/lpfc/lpfc_nvme.c             |  27 +-
 drivers/scsi/lpfc/lpfc_scsi.c             |  12 +-
 drivers/scsi/lpfc/lpfc_sli.c              |  75 +++--
 drivers/scsi/lpfc/lpfc_version.h          |   2 +-
 drivers/scsi/megaraid/megaraid_sas.h      |   3 +
 drivers/scsi/megaraid/megaraid_sas_base.c |   7 +
 drivers/scsi/mpt3sas/mpt3sas_base.c       |   3 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c     |   9 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |   5 +-
 drivers/scsi/mvsas/mv_init.c              |   1 +
 drivers/scsi/pcmcia/sym53c500_cs.c        |  52 ++--
 drivers/scsi/pmcraid.c                    | 491 ------------------------------
 drivers/scsi/pmcraid.h                    |  33 --
 drivers/scsi/scsi_debug.c                 |   8 +-
 drivers/scsi/scsi_logging.c               |   2 +-
 drivers/scsi/scsi_scan.c                  |   5 +
 drivers/scsi/scsi_sysfs.c                 |   4 -
 drivers/scsi/sd.c                         |   3 +-
 drivers/scsi/sr.c                         |   2 +-
 drivers/scsi/ufs/ufs-qcom.c               |  15 -
 drivers/scsi/ufs/ufshcd-pci.c             |  17 ++
 drivers/scsi/ufs/ufshcd.h                 |   2 -
 drivers/scsi/ufs/ufshpb.c                 |  11 +-
 drivers/scsi/virtio_scsi.c                |   8 +-
 drivers/scsi/zorro7xx.c                   |   2 +
 drivers/target/target_core_user.c         |   3 +-
 42 files changed, 467 insertions(+), 826 deletions(-)

With full diff below.

James

---

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index e90adfa57950..9b3ba2df71c7 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6658,13 +6658,13 @@ static int mpt_summary_proc_show(struct seq_file *m, void *v)
 static int mpt_version_proc_show(struct seq_file *m, void *v)
 {
 	u8	 cb_idx;
-	int	 scsi, fc, sas, lan, ctl, targ, dmp;
+	int	 scsi, fc, sas, lan, ctl, targ;
 	char	*drvname;
 
 	seq_printf(m, "%s-%s\n", "mptlinux", MPT_LINUX_VERSION_COMMON);
 	seq_printf(m, "  Fusion MPT base driver\n");
 
-	scsi = fc = sas = lan = ctl = targ = dmp = 0;
+	scsi = fc = sas = lan = ctl = targ = 0;
 	for (cb_idx = MPT_MAX_PROTOCOL_DRIVERS-1; cb_idx; cb_idx--) {
 		drvname = NULL;
 		if (MptCallbacks[cb_idx]) {
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 5f554a3a0f62..caeebfb67149 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -317,14 +317,18 @@ enum {
 };
 
 struct aha152x_cmd_priv {
-	struct scsi_pointer scsi_pointer;
+	char *ptr;
+	int this_residual;
+	struct scatterlist *buffer;
+	int status;
+	int message;
+	int sent_command;
+	int phase;
 };
 
-static struct scsi_pointer *aha152x_scsi_pointer(struct scsi_cmnd *cmd)
+static struct aha152x_cmd_priv *aha152x_priv(struct scsi_cmnd *cmd)
 {
-	struct aha152x_cmd_priv *acmd = scsi_cmd_priv(cmd);
-
-	return &acmd->scsi_pointer;
+	return scsi_cmd_priv(cmd);
 }
 
 MODULE_AUTHOR("Jürgen Fischer");
@@ -890,17 +894,16 @@ void aha152x_release(struct Scsi_Host *shpnt)
 static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 {
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
-		scsi_pointer->phase |= 1 << 16;
+		acp->phase |= 1 << 16;
 
-		if (scsi_pointer->phase & selecting) {
+		if (acp->phase & selecting) {
 			SETPORT(SSTAT1, SELTO);
 			SETPORT(SIMODE0, ENSELDO | (DISCONNECTED_SC ? ENSELDI : 0));
 			SETPORT(SIMODE1, ENSELTIMO);
 		} else {
-			SETPORT(SIMODE0, (scsi_pointer->phase & spiordy) ? ENSPIORDY : 0);
+			SETPORT(SIMODE0, (acp->phase & spiordy) ? ENSPIORDY : 0);
 			SETPORT(SIMODE1, ENPHASEMIS | ENSCSIRST | ENSCSIPERR | ENBUSFREE);
 		}
 	} else if(STATE==seldi) {
@@ -924,17 +927,16 @@ static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 				  struct completion *complete, int phase)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(SCpnt);
+	struct aha152x_cmd_priv *acp = aha152x_priv(SCpnt);
 	struct Scsi_Host *shpnt = SCpnt->device->host;
 	unsigned long flags;
 
-	scsi_pointer->phase	   = not_issued | phase;
-	scsi_pointer->Status	   = 0x1; /* Ilegal status by SCSI standard */
-	scsi_pointer->Message	   = 0;
-	scsi_pointer->have_data_in = 0;
-	scsi_pointer->sent_command = 0;
+	acp->phase        = not_issued | phase;
+	acp->status       = 0x1; /* Illegal status by SCSI standard */
+	acp->message      = 0;
+	acp->sent_command = 0;
 
-	if (scsi_pointer->phase & (resetting | check_condition)) {
+	if (acp->phase & (resetting | check_condition)) {
 		if (!SCpnt->host_scribble || SCSEM(SCpnt) || SCNEXT(SCpnt)) {
 			scmd_printk(KERN_ERR, SCpnt, "cannot reuse command\n");
 			return FAILED;
@@ -957,15 +959,15 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 	   SCp.phase            : current state of the command */
 
 	if ((phase & resetting) || !scsi_sglist(SCpnt)) {
-		scsi_pointer->ptr           = NULL;
-		scsi_pointer->this_residual = 0;
+		acp->ptr           = NULL;
+		acp->this_residual = 0;
 		scsi_set_resid(SCpnt, 0);
-		scsi_pointer->buffer        = NULL;
+		acp->buffer        = NULL;
 	} else {
 		scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
-		scsi_pointer->buffer        = scsi_sglist(SCpnt);
-		scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
-		scsi_pointer->this_residual = scsi_pointer->buffer->length;
+		acp->buffer        = scsi_sglist(SCpnt);
+		acp->ptr           = SG_ADDRESS(acp->buffer);
+		acp->this_residual = acp->buffer->length;
 	}
 
 	DO_LOCK(flags);
@@ -1015,7 +1017,7 @@ static void reset_done(struct scsi_cmnd *SCpnt)
 
 static void aha152x_scsi_done(struct scsi_cmnd *SCpnt)
 {
-	if (aha152x_scsi_pointer(SCpnt)->phase & resetting)
+	if (aha152x_priv(SCpnt)->phase & resetting)
 		reset_done(SCpnt);
 	else
 		scsi_done(SCpnt);
@@ -1101,7 +1103,7 @@ static int aha152x_device_reset(struct scsi_cmnd * SCpnt)
 
 	DO_LOCK(flags);
 
-	if (aha152x_scsi_pointer(SCpnt)->phase & resetted) {
+	if (aha152x_priv(SCpnt)->phase & resetted) {
 		HOSTDATA(shpnt)->commands--;
 		if (!HOSTDATA(shpnt)->commands)
 			SETPORT(PORTA, 0);
@@ -1395,31 +1397,30 @@ static void busfree_run(struct Scsi_Host *shpnt)
 	SETPORT(SSTAT1, CLRBUSFREE);
 
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 #if defined(AHA152X_STAT)
 		action++;
 #endif
-		scsi_pointer->phase &= ~syncneg;
+		acp->phase &= ~syncneg;
 
-		if (scsi_pointer->phase & completed) {
+		if (acp->phase & completed) {
 			/* target sent COMMAND COMPLETE */
-			done(shpnt, scsi_pointer->Status, DID_OK);
+			done(shpnt, acp->status, DID_OK);
 
-		} else if (scsi_pointer->phase & aborted) {
-			done(shpnt, scsi_pointer->Status, DID_ABORT);
+		} else if (acp->phase & aborted) {
+			done(shpnt, acp->status, DID_ABORT);
 
-		} else if (scsi_pointer->phase & resetted) {
-			done(shpnt, scsi_pointer->Status, DID_RESET);
+		} else if (acp->phase & resetted) {
+			done(shpnt, acp->status, DID_RESET);
 
-		} else if (scsi_pointer->phase & disconnected) {
+		} else if (acp->phase & disconnected) {
 			/* target sent DISCONNECT */
 #if defined(AHA152X_STAT)
 			HOSTDATA(shpnt)->disconnections++;
 #endif
 			append_SC(&DISCONNECTED_SC, CURRENT_SC);
-			scsi_pointer->phase |= 1 << 16;
+			acp->phase |= 1 << 16;
 			CURRENT_SC = NULL;
 
 		} else {
@@ -1438,24 +1439,23 @@ static void busfree_run(struct Scsi_Host *shpnt)
 		action++;
 #endif
 
-		if (aha152x_scsi_pointer(DONE_SC)->phase & check_condition) {
+		if (aha152x_priv(DONE_SC)->phase & check_condition) {
 			struct scsi_cmnd *cmd = HOSTDATA(shpnt)->done_SC;
 			struct aha152x_scdata *sc = SCDATA(cmd);
 
 			scsi_eh_restore_cmnd(cmd, &sc->ses);
 
-			aha152x_scsi_pointer(cmd)->Status = SAM_STAT_CHECK_CONDITION;
+			aha152x_priv(cmd)->status = SAM_STAT_CHECK_CONDITION;
 
 			HOSTDATA(shpnt)->commands--;
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
-		} else if (aha152x_scsi_pointer(DONE_SC)->Status ==
-			   SAM_STAT_CHECK_CONDITION) {
+		} else if (aha152x_priv(DONE_SC)->status == SAM_STAT_CHECK_CONDITION) {
 #if defined(AHA152X_STAT)
 			HOSTDATA(shpnt)->busfree_with_check_condition++;
 #endif
 
-			if(!(aha152x_scsi_pointer(DONE_SC)->phase & not_issued)) {
+			if (!(aha152x_priv(DONE_SC)->phase & not_issued)) {
 				struct aha152x_scdata *sc;
 				struct scsi_cmnd *ptr = DONE_SC;
 				DONE_SC=NULL;
@@ -1480,7 +1480,7 @@ static void busfree_run(struct Scsi_Host *shpnt)
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
 
-			if (!(aha152x_scsi_pointer(ptr)->phase & resetting)) {
+			if (!(aha152x_priv(ptr)->phase & resetting)) {
 				kfree(ptr->host_scribble);
 				ptr->host_scribble=NULL;
 			}
@@ -1503,13 +1503,12 @@ static void busfree_run(struct Scsi_Host *shpnt)
 	DO_UNLOCK(flags);
 
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 #if defined(AHA152X_STAT)
 		action++;
 #endif
-		scsi_pointer->phase |= selecting;
+		acp->phase |= selecting;
 
 		/* clear selection timeout */
 		SETPORT(SSTAT1, SELTO);
@@ -1537,13 +1536,13 @@ static void busfree_run(struct Scsi_Host *shpnt)
  */
 static void seldo_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 	SETPORT(SCSISIG, 0);
 	SETPORT(SSTAT1, CLRBUSFREE);
 	SETPORT(SSTAT1, CLRPHASECHG);
 
-	scsi_pointer->phase &= ~(selecting | not_issued);
+	acp->phase &= ~(selecting | not_issued);
 
 	SETPORT(SCSISEQ, 0);
 
@@ -1558,12 +1557,12 @@ static void seldo_run(struct Scsi_Host *shpnt)
 
 	ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 
-	if (scsi_pointer->phase & aborting) {
+	if (acp->phase & aborting) {
 		ADDMSGO(ABORT);
-	} else if (scsi_pointer->phase & resetting) {
+	} else if (acp->phase & resetting) {
 		ADDMSGO(BUS_DEVICE_RESET);
 	} else if (SYNCNEG==0 && SYNCHRONOUS) {
-		scsi_pointer->phase |= syncneg;
+		acp->phase |= syncneg;
 		MSGOLEN += spi_populate_sync_msg(&MSGO(MSGOLEN), 50, 8);
 		SYNCNEG=1;		/* negotiation in progress */
 	}
@@ -1578,7 +1577,7 @@ static void seldo_run(struct Scsi_Host *shpnt)
  */
 static void selto_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp;
 
 	SETPORT(SCSISEQ, 0);
 	SETPORT(SSTAT1, CLRSELTIMO);
@@ -1586,9 +1585,10 @@ static void selto_run(struct Scsi_Host *shpnt)
 	if (!CURRENT_SC)
 		return;
 
-	scsi_pointer->phase &= ~selecting;
+	acp = aha152x_priv(CURRENT_SC);
+	acp->phase &= ~selecting;
 
-	if (scsi_pointer->phase & aborted)
+	if (acp->phase & aborted)
 		done(shpnt, SAM_STAT_GOOD, DID_ABORT);
 	else if (TESTLO(SSTAT0, SELINGO))
 		done(shpnt, SAM_STAT_GOOD, DID_BUS_BUSY);
@@ -1616,10 +1616,9 @@ static void seldi_run(struct Scsi_Host *shpnt)
 	SETPORT(SSTAT1, CLRPHASECHG);
 
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
-		if (!(scsi_pointer->phase & not_issued))
+		if (!(acp->phase & not_issued))
 			scmd_printk(KERN_ERR, CURRENT_SC,
 				    "command should not have been issued yet\n");
 
@@ -1676,7 +1675,7 @@ static void seldi_run(struct Scsi_Host *shpnt)
 static void msgi_run(struct Scsi_Host *shpnt)
 {
 	for(;;) {
-		struct scsi_pointer *scsi_pointer;
+		struct aha152x_cmd_priv *acp;
 		int sstat1 = GETPORT(SSTAT1);
 
 		if(sstat1 & (PHASECHG|PHASEMIS|BUSFREE) || !(sstat1 & REQINIT))
@@ -1714,9 +1713,9 @@ static void msgi_run(struct Scsi_Host *shpnt)
 				continue;
 			}
 
-			scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-			scsi_pointer->Message = MSGI(0);
-			scsi_pointer->phase &= ~disconnected;
+			acp = aha152x_priv(CURRENT_SC);
+			acp->message = MSGI(0);
+			acp->phase &= ~disconnected;
 
 			MSGILEN=0;
 
@@ -1724,8 +1723,8 @@ static void msgi_run(struct Scsi_Host *shpnt)
 			continue;
 		}
 
-		scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-		scsi_pointer->Message = MSGI(0);
+		acp = aha152x_priv(CURRENT_SC);
+		acp->message = MSGI(0);
 
 		switch (MSGI(0)) {
 		case DISCONNECT:
@@ -1733,11 +1732,11 @@ static void msgi_run(struct Scsi_Host *shpnt)
 				scmd_printk(KERN_WARNING, CURRENT_SC,
 					    "target was not allowed to disconnect\n");
 
-			scsi_pointer->phase |= disconnected;
+			acp->phase |= disconnected;
 			break;
 
 		case COMMAND_COMPLETE:
-			scsi_pointer->phase |= completed;
+			acp->phase |= completed;
 			break;
 
 		case MESSAGE_REJECT:
@@ -1867,11 +1866,9 @@ static void msgi_end(struct Scsi_Host *shpnt)
  */
 static void msgo_init(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-
 	if(MSGOLEN==0) {
-		if ((scsi_pointer->phase & syncneg) && SYNCNEG==2 &&
-		    SYNCRATE==0) {
+		if ((aha152x_priv(CURRENT_SC)->phase & syncneg) &&
+		    SYNCNEG == 2 && SYNCRATE == 0) {
 			ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 		} else {
 			scmd_printk(KERN_INFO, CURRENT_SC,
@@ -1888,7 +1885,7 @@ static void msgo_init(struct Scsi_Host *shpnt)
  */
 static void msgo_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 	while(MSGO_I<MSGOLEN) {
 		if (TESTLO(SSTAT0, SPIORDY))
@@ -1901,13 +1898,13 @@ static void msgo_run(struct Scsi_Host *shpnt)
 
 
 		if (MSGO(MSGO_I) & IDENTIFY_BASE)
-			scsi_pointer->phase |= identified;
+			acp->phase |= identified;
 
 		if (MSGO(MSGO_I)==ABORT)
-			scsi_pointer->phase |= aborted;
+			acp->phase |= aborted;
 
 		if (MSGO(MSGO_I)==BUS_DEVICE_RESET)
-			scsi_pointer->phase |= resetted;
+			acp->phase |= resetted;
 
 		SETPORT(SCSIDAT, MSGO(MSGO_I++));
 	}
@@ -1936,7 +1933,7 @@ static void msgo_end(struct Scsi_Host *shpnt)
  */
 static void cmd_init(struct Scsi_Host *shpnt)
 {
-	if (aha152x_scsi_pointer(CURRENT_SC)->sent_command) {
+	if (aha152x_priv(CURRENT_SC)->sent_command) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "command already sent\n");
 		done(shpnt, SAM_STAT_GOOD, DID_ERROR);
@@ -1967,7 +1964,7 @@ static void cmd_end(struct Scsi_Host *shpnt)
 			    "command sent incompletely (%d/%d)\n",
 			    CMD_I, CURRENT_SC->cmd_len);
 	else
-		aha152x_scsi_pointer(CURRENT_SC)->sent_command++;
+		aha152x_priv(CURRENT_SC)->sent_command++;
 }
 
 /*
@@ -1979,7 +1976,7 @@ static void status_run(struct Scsi_Host *shpnt)
 	if (TESTLO(SSTAT0, SPIORDY))
 		return;
 
-	aha152x_scsi_pointer(CURRENT_SC)->Status = GETPORT(SCSIDAT);
+	aha152x_priv(CURRENT_SC)->status = GETPORT(SCSIDAT);
 
 }
 
@@ -2003,7 +2000,7 @@ static void datai_init(struct Scsi_Host *shpnt)
 
 static void datai_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer;
+	struct aha152x_cmd_priv *acp;
 	unsigned long the_time;
 	int fifodata, data_count;
 
@@ -2041,36 +2038,35 @@ static void datai_run(struct Scsi_Host *shpnt)
 			fifodata = GETPORT(FIFOSTAT);
 		}
 
-		scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-		if (scsi_pointer->this_residual > 0) {
-			while (fifodata > 0 && scsi_pointer->this_residual > 0) {
-				data_count = fifodata > scsi_pointer->this_residual ?
-						scsi_pointer->this_residual :
-						fifodata;
+		acp = aha152x_priv(CURRENT_SC);
+		if (acp->this_residual > 0) {
+			while (fifodata > 0 && acp->this_residual > 0) {
+				data_count = fifodata > acp->this_residual ?
+						acp->this_residual : fifodata;
 				fifodata -= data_count;
 
 				if (data_count & 1) {
 					SETPORT(DMACNTRL0, ENDMA|_8BIT);
-					*scsi_pointer->ptr++ = GETPORT(DATAPORT);
-					scsi_pointer->this_residual--;
+					*acp->ptr++ = GETPORT(DATAPORT);
+					acp->this_residual--;
 					DATA_LEN++;
 					SETPORT(DMACNTRL0, ENDMA);
 				}
 
 				if (data_count > 1) {
 					data_count >>= 1;
-					insw(DATAPORT, scsi_pointer->ptr, data_count);
-					scsi_pointer->ptr += 2 * data_count;
-					scsi_pointer->this_residual -= 2 * data_count;
+					insw(DATAPORT, acp->ptr, data_count);
+					acp->ptr += 2 * data_count;
+					acp->this_residual -= 2 * data_count;
 					DATA_LEN += 2 * data_count;
 				}
 
-				if (scsi_pointer->this_residual == 0 &&
-				    !sg_is_last(scsi_pointer->buffer)) {
+				if (acp->this_residual == 0 &&
+				    !sg_is_last(acp->buffer)) {
 					/* advance to next buffer */
-					scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
-					scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
-					scsi_pointer->this_residual = scsi_pointer->buffer->length;
+					acp->buffer = sg_next(acp->buffer);
+					acp->ptr = SG_ADDRESS(acp->buffer);
+					acp->this_residual = acp->buffer->length;
 				}
 			}
 		} else if (fifodata > 0) {
@@ -2138,15 +2134,15 @@ static void datao_init(struct Scsi_Host *shpnt)
 
 static void datao_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 	unsigned long the_time;
 	int data_count;
 
 	/* until phase changes or all data sent */
-	while (TESTLO(DMASTAT, INTSTAT) && scsi_pointer->this_residual > 0) {
+	while (TESTLO(DMASTAT, INTSTAT) && acp->this_residual > 0) {
 		data_count = 128;
-		if (data_count > scsi_pointer->this_residual)
-			data_count = scsi_pointer->this_residual;
+		if (data_count > acp->this_residual)
+			data_count = acp->this_residual;
 
 		if(TESTLO(DMASTAT, DFIFOEMP)) {
 			scmd_printk(KERN_ERR, CURRENT_SC,
@@ -2157,26 +2153,25 @@ static void datao_run(struct Scsi_Host *shpnt)
 
 		if(data_count & 1) {
 			SETPORT(DMACNTRL0,WRITE_READ|ENDMA|_8BIT);
-			SETPORT(DATAPORT, *scsi_pointer->ptr++);
-			scsi_pointer->this_residual--;
+			SETPORT(DATAPORT, *acp->ptr++);
+			acp->this_residual--;
 			CMD_INC_RESID(CURRENT_SC, -1);
 			SETPORT(DMACNTRL0,WRITE_READ|ENDMA);
 		}
 
 		if(data_count > 1) {
 			data_count >>= 1;
-			outsw(DATAPORT, scsi_pointer->ptr, data_count);
-			scsi_pointer->ptr           += 2 * data_count;
-			scsi_pointer->this_residual -= 2 * data_count;
+			outsw(DATAPORT, acp->ptr, data_count);
+			acp->ptr += 2 * data_count;
+			acp->this_residual -= 2 * data_count;
 			CMD_INC_RESID(CURRENT_SC, -2 * data_count);
 		}
 
-		if (scsi_pointer->this_residual == 0 &&
-		    !sg_is_last(scsi_pointer->buffer)) {
+		if (acp->this_residual == 0 && !sg_is_last(acp->buffer)) {
 			/* advance to next buffer */
-			scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
-			scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
-			scsi_pointer->this_residual = scsi_pointer->buffer->length;
+			acp->buffer = sg_next(acp->buffer);
+			acp->ptr = SG_ADDRESS(acp->buffer);
+			acp->this_residual = acp->buffer->length;
 		}
 
 		the_time=jiffies + 100*HZ;
@@ -2192,7 +2187,7 @@ static void datao_run(struct Scsi_Host *shpnt)
 
 static void datao_end(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 	if(TESTLO(DMASTAT, DFIFOEMP)) {
 		u32 datao_cnt = GETSTCNT();
@@ -2211,10 +2206,9 @@ static void datao_end(struct Scsi_Host *shpnt)
 			sg = sg_next(sg);
 		}
 
-		scsi_pointer->buffer = sg;
-		scsi_pointer->ptr = SG_ADDRESS(scsi_pointer->buffer) + done;
-		scsi_pointer->this_residual = scsi_pointer->buffer->length -
-			done;
+		acp->buffer = sg;
+		acp->ptr = SG_ADDRESS(acp->buffer) + done;
+		acp->this_residual = acp->buffer->length - done;
 	}
 
 	SETPORT(SXFRCTL0, CH1|CLRCH1|CLRSTCNT);
@@ -2229,7 +2223,6 @@ static void datao_end(struct Scsi_Host *shpnt)
  */
 static int update_state(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
 	int dataphase=0;
 	unsigned int stat0 = GETPORT(SSTAT0);
 	unsigned int stat1 = GETPORT(SSTAT1);
@@ -2244,7 +2237,7 @@ static int update_state(struct Scsi_Host *shpnt)
 	} else if (stat0 & SELDI && PREVSTATE == busfree) {
 		STATE=seldi;
 	} else if (stat0 & SELDO && CURRENT_SC &&
-		   (scsi_pointer->phase & selecting)) {
+		   (aha152x_priv(CURRENT_SC)->phase & selecting)) {
 		STATE=seldo;
 	} else if(stat1 & SELTO) {
 		STATE=selto;
@@ -2376,8 +2369,7 @@ static void is_complete(struct Scsi_Host *shpnt)
 			SETPORT(SXFRCTL0, CH1);
 			SETPORT(DMACNTRL0, 0);
 			if(CURRENT_SC)
-				aha152x_scsi_pointer(CURRENT_SC)->phase &=
-					~spiordy;
+				aha152x_priv(CURRENT_SC)->phase &= ~spiordy;
 		}
 
 		/*
@@ -2399,8 +2391,7 @@ static void is_complete(struct Scsi_Host *shpnt)
 			SETPORT(DMACNTRL0, 0);
 			SETPORT(SXFRCTL0, CH1|SPIOEN);
 			if(CURRENT_SC)
-				aha152x_scsi_pointer(CURRENT_SC)->phase |=
-					spiordy;
+				aha152x_priv(CURRENT_SC)->phase |= spiordy;
 		}
 
 		/*
@@ -2490,7 +2481,7 @@ static void disp_enintr(struct Scsi_Host *shpnt)
  */
 static void show_command(struct scsi_cmnd *ptr)
 {
-	const int phase = aha152x_scsi_pointer(ptr)->phase;
+	const int phase = aha152x_priv(ptr)->phase;
 
 	scsi_print_command(ptr);
 	scmd_printk(KERN_DEBUG, ptr,
@@ -2538,8 +2529,8 @@ static void show_queues(struct Scsi_Host *shpnt)
 
 static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(ptr);
-	const int phase = scsi_pointer->phase;
+	struct aha152x_cmd_priv *acp = aha152x_priv(ptr);
+	const int phase = acp->phase;
 	int i;
 
 	seq_printf(m, "%p: target=%d; lun=%d; cmnd=( ",
@@ -2549,8 +2540,8 @@ static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 		seq_printf(m, "0x%02x ", ptr->cmnd[i]);
 
 	seq_printf(m, "); resid=%d; residual=%d; buffers=%d; phase |",
-		scsi_get_resid(ptr), scsi_pointer->this_residual,
-		sg_nents(scsi_pointer->buffer) - 1);
+		scsi_get_resid(ptr), acp->this_residual,
+		sg_nents(acp->buffer) - 1);
 
 	if (phase & not_issued)
 		seq_puts(m, "not issued|");
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
index 679a4fd13874..793fe19993a9 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -420,8 +420,6 @@ ahd_unlock(struct ahd_softc *ahd, unsigned long *flags)
 
 /* config registers for header type 0 devices */
 #define PCIR_MAPS	0x10
-#define PCIR_SUBVEND_0	0x2c
-#define PCIR_SUBDEV_0	0x2e
 
 /****************************** PCI-X definitions *****************************/
 #define PCIXR_COMMAND	0x96
diff --git a/drivers/scsi/aic7xxx/aic79xx_pci.c b/drivers/scsi/aic7xxx/aic79xx_pci.c
index 2f0bdb9225a4..5fad41b1ab58 100644
--- a/drivers/scsi/aic7xxx/aic79xx_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_pci.c
@@ -260,8 +260,8 @@ ahd_find_pci_device(ahd_dev_softc_t pci)
 
 	vendor = ahd_pci_read_config(pci, PCIR_DEVVENDOR, /*bytes*/2);
 	device = ahd_pci_read_config(pci, PCIR_DEVICE, /*bytes*/2);
-	subvendor = ahd_pci_read_config(pci, PCIR_SUBVEND_0, /*bytes*/2);
-	subdevice = ahd_pci_read_config(pci, PCIR_SUBDEV_0, /*bytes*/2);
+	subvendor = ahd_pci_read_config(pci, PCI_SUBSYSTEM_VENDOR_ID, /*bytes*/2);
+	subdevice = ahd_pci_read_config(pci, PCI_SUBSYSTEM_ID, /*bytes*/2);
 	full_id = ahd_compose_id(device,
 				 vendor,
 				 subdevice,
@@ -298,7 +298,7 @@ ahd_pci_config(struct ahd_softc *ahd, const struct ahd_pci_identity *entry)
 	 * Record if this is an HP board.
 	 */
 	subvendor = ahd_pci_read_config(ahd->dev_softc,
-					PCIR_SUBVEND_0, /*bytes*/2);
+					PCI_SUBSYSTEM_VENDOR_ID, /*bytes*/2);
 	if (subvendor == SUBID_HP)
 		ahd->flags |= AHD_HP_BOARD;
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index 4782a304e93c..51d9f4de0734 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -433,8 +433,6 @@ ahc_unlock(struct ahc_softc *ahc, unsigned long *flags)
 
 /* config registers for header type 0 devices */
 #define PCIR_MAPS	0x10
-#define PCIR_SUBVEND_0	0x2c
-#define PCIR_SUBDEV_0	0x2e
 
 typedef enum
 {
diff --git a/drivers/scsi/aic7xxx/aic7xxx_pci.c b/drivers/scsi/aic7xxx/aic7xxx_pci.c
index dab3a6d12c4d..2d4c85426dc3 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_pci.c
@@ -673,8 +673,8 @@ ahc_find_pci_device(ahc_dev_softc_t pci)
 
 	vendor = ahc_pci_read_config(pci, PCIR_DEVVENDOR, /*bytes*/2);
 	device = ahc_pci_read_config(pci, PCIR_DEVICE, /*bytes*/2);
-	subvendor = ahc_pci_read_config(pci, PCIR_SUBVEND_0, /*bytes*/2);
-	subdevice = ahc_pci_read_config(pci, PCIR_SUBDEV_0, /*bytes*/2);
+	subvendor = ahc_pci_read_config(pci, PCI_SUBSYSTEM_VENDOR_ID, /*bytes*/2);
+	subdevice = ahc_pci_read_config(pci, PCI_SUBSYSTEM_ID, /*bytes*/2);
 	full_id = ahc_compose_id(device, vendor, subdevice, subvendor);
 
 	/*
diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 0103f811cc25..776544385598 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -1169,7 +1169,7 @@ static void bnx2fc_process_ofld_cmpl(struct bnx2fc_hba *hba,
 		ofld_kcqe->fcoe_conn_context_id);
 	interface = tgt->port->priv;
 	if (hba != interface->hba) {
-		printk(KERN_ERR PFX "ERROR:ofld_cmpl: HBA mis-match\n");
+		printk(KERN_ERR PFX "ERROR:ofld_cmpl: HBA mismatch\n");
 		goto ofld_cmpl_err;
 	}
 	/*
@@ -1226,12 +1226,12 @@ static void bnx2fc_process_enable_conn_cmpl(struct bnx2fc_hba *hba,
 	 * and enable
 	 */
 	if (tgt->context_id != context_id) {
-		printk(KERN_ERR PFX "context id mis-match\n");
+		printk(KERN_ERR PFX "context id mismatch\n");
 		return;
 	}
 	interface = tgt->port->priv;
 	if (hba != interface->hba) {
-		printk(KERN_ERR PFX "bnx2fc-enbl_cmpl: HBA mis-match\n");
+		printk(KERN_ERR PFX "bnx2fc-enbl_cmpl: HBA mismatch\n");
 		goto enbl_cmpl_err;
 	}
 	if (!ofld_kcqe->completion_status)
diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index 5521469ce678..7fe7f53a41c0 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -2398,7 +2398,7 @@ static void bnx2i_process_conn_destroy_cmpl(struct bnx2i_hba *hba,
 	}
 
 	if (hba != ep->hba) {
-		printk(KERN_ALERT "conn destroy- error hba mis-match\n");
+		printk(KERN_ALERT "conn destroy- error hba mismatch\n");
 		return;
 	}
 
@@ -2432,7 +2432,7 @@ static void bnx2i_process_ofld_cmpl(struct bnx2i_hba *hba,
 	}
 
 	if (hba != ep->hba) {
-		printk(KERN_ALERT "ofld_cmpl: error hba mis-match\n");
+		printk(KERN_ALERT "ofld_cmpl: error hba mismatch\n");
 		return;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 461ef8a76c4c..4bda2f6cb352 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -442,7 +442,6 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_INTERNAL_ABORT:
 		hisi_sas_task_prep_abort(hisi_hba, slot);
 		break;
-	fallthrough;
 	default:
 		return;
 	}
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 80238e6a3c98..eee1a24f7e15 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -36,7 +36,7 @@
 
 #define IBMVSCSIS_VERSION	"v0.2"
 
-#define	INITIAL_SRP_LIMIT	800
+#define	INITIAL_SRP_LIMIT	1024
 #define	DEFAULT_MAX_SECTORS	256
 #define MAX_TXU			1024 * 1024
 
diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index d690d9cf7eb1..35589b6af90d 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -413,7 +413,7 @@ static void sci_controller_event_completion(struct isci_host *ihost, u32 ent)
 				dev_warn(&ihost->pdev->dev,
 					 "%s: SCIC Controller 0x%p received "
 					 "event 0x%x for io request object "
-					 "that doesnt exist.\n",
+					 "that doesn't exist.\n",
 					 __func__,
 					 ihost,
 					 ent);
@@ -428,7 +428,7 @@ static void sci_controller_event_completion(struct isci_host *ihost, u32 ent)
 				dev_warn(&ihost->pdev->dev,
 					 "%s: SCIC Controller 0x%p received "
 					 "event 0x%x for remote device object "
-					 "that doesnt exist.\n",
+					 "that doesn't exist.\n",
 					 __func__,
 					 ihost,
 					 ent);
@@ -462,7 +462,7 @@ static void sci_controller_event_completion(struct isci_host *ihost, u32 ent)
 		} else
 			dev_err(&ihost->pdev->dev,
 				"%s: SCIC Controller 0x%p received event 0x%x "
-				"for remote device object 0x%0x that doesnt "
+				"for remote device object 0x%0x that doesn't "
 				"exist.\n",
 				__func__,
 				ihost,
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index d09926e6c8a8..cf4211c6500d 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3045,7 +3045,6 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 	if (!cls_conn)
 		return NULL;
 	conn = cls_conn->dd_data;
-	memset(conn, 0, sizeof(*conn) + dd_size);
 
 	conn->dd_data = cls_conn->dd_data + sizeof(*conn);
 	conn->session = session;
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index f0cf8ffdc5f3..0025760230e5 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -897,6 +897,11 @@ enum lpfc_irq_chann_mode {
 	NHT_MODE,
 };
 
+enum lpfc_hba_bit_flags {
+	FABRIC_COMANDS_BLOCKED,
+	HBA_PCI_ERR,
+};
+
 struct lpfc_hba {
 	/* SCSI interface function jump table entries */
 	struct lpfc_io_buf * (*lpfc_get_scsi_buf)
@@ -1043,7 +1048,6 @@ struct lpfc_hba {
 					 * Firmware supports Forced Link Speed
 					 * capability
 					 */
-#define HBA_PCI_ERR		0x80000 /* The PCI slot is offline */
 #define HBA_FLOGI_ISSUED	0x100000 /* FLOGI was issued */
 #define HBA_SHORT_CMF		0x200000 /* shorter CMF timer routine */
 #define HBA_CGN_DAY_WRAP	0x400000 /* HBA Congestion info day wraps */
@@ -1350,7 +1354,6 @@ struct lpfc_hba {
 	atomic_t fabric_iocb_count;
 	struct timer_list fabric_block_timer;
 	unsigned long bit_flags;
-#define	FABRIC_COMANDS_BLOCKED	0
 	atomic_t num_rsrc_err;
 	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 96408cd6c4c8..9897a1aa387b 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -670,3 +670,6 @@ struct lpfc_vmid *lpfc_get_vmid_from_hashtable(struct lpfc_vport *vport,
 					      uint32_t hash, uint8_t *buf);
 void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
 int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
+
+void lpfc_sli_rpi_release(struct lpfc_vport *vport,
+			  struct lpfc_nodelist *ndlp);
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 0144da30e3db..2b877dff5ed4 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -109,8 +109,8 @@ lpfc_rport_invalid(struct fc_rport *rport)
 
 	ndlp = rdata->pnode;
 	if (!rdata->pnode) {
-		pr_err("**** %s: NULL ndlp on rport x%px SID x%x\n",
-		       __func__, rport, rport->scsi_target_id);
+		pr_info("**** %s: NULL ndlp on rport x%px SID x%x\n",
+			__func__, rport, rport->scsi_target_id);
 		return -EINVAL;
 	}
 
@@ -169,9 +169,10 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
 			 "3181 dev_loss_callbk x%06x, rport x%px flg x%x "
-			 "load_flag x%x refcnt %d\n",
+			 "load_flag x%x refcnt %d state %d xpt x%x\n",
 			 ndlp->nlp_DID, ndlp->rport, ndlp->nlp_flag,
-			 vport->load_flag, kref_read(&ndlp->kref));
+			 vport->load_flag, kref_read(&ndlp->kref),
+			 ndlp->nlp_state, ndlp->fc4_xpt_flags);
 
 	/* Don't schedule a worker thread event if the vport is going down.
 	 * The teardown process cleans up the node via lpfc_drop_node.
@@ -181,6 +182,11 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		ndlp->rport = NULL;
 
 		ndlp->fc4_xpt_flags &= ~SCSI_XPT_REGD;
+		/* clear the NLP_XPT_REGD if the node is not registered
+		 * with nvme-fc
+		 */
+		if (ndlp->fc4_xpt_flags == NLP_XPT_REGD)
+			ndlp->fc4_xpt_flags &= ~NLP_XPT_REGD;
 
 		/* Remove the node reference from remote_port_add now.
 		 * The driver will not call remote_port_delete.
@@ -225,18 +231,36 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	ndlp->rport = NULL;
 	spin_unlock_irqrestore(&ndlp->lock, iflags);
 
-	/* We need to hold the node by incrementing the reference
-	 * count until this queued work is done
-	 */
-	evtp->evt_arg1 = lpfc_nlp_get(ndlp);
+	if (phba->worker_thread) {
+		/* We need to hold the node by incrementing the reference
+		 * count until this queued work is done
+		 */
+		evtp->evt_arg1 = lpfc_nlp_get(ndlp);
+
+		spin_lock_irqsave(&phba->hbalock, iflags);
+		if (evtp->evt_arg1) {
+			evtp->evt = LPFC_EVT_DEV_LOSS;
+			list_add_tail(&evtp->evt_listp, &phba->work_list);
+			lpfc_worker_wake_up(phba);
+		}
+		spin_unlock_irqrestore(&phba->hbalock, iflags);
+	} else {
+		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
+				 "3188 worker thread is stopped %s x%06x, "
+				 " rport x%px flg x%x load_flag x%x refcnt "
+				 "%d\n", __func__, ndlp->nlp_DID,
+				 ndlp->rport, ndlp->nlp_flag,
+				 vport->load_flag, kref_read(&ndlp->kref));
+		if (!(ndlp->fc4_xpt_flags & NVME_XPT_REGD)) {
+			spin_lock_irqsave(&ndlp->lock, iflags);
+			/* Node is in dev loss.  No further transaction. */
+			ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
+			spin_unlock_irqrestore(&ndlp->lock, iflags);
+			lpfc_disc_state_machine(vport, ndlp, NULL,
+						NLP_EVT_DEVICE_RM);
+		}
 
-	spin_lock_irqsave(&phba->hbalock, iflags);
-	if (evtp->evt_arg1) {
-		evtp->evt = LPFC_EVT_DEV_LOSS;
-		list_add_tail(&evtp->evt_listp, &phba->work_list);
-		lpfc_worker_wake_up(phba);
 	}
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
 
 	return;
 }
@@ -503,11 +527,12 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0203 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
-				 "NPort x%06x Data: x%x x%x x%x\n",
+				 "NPort x%06x Data: x%x x%x x%x refcnt %d\n",
 				 *name, *(name+1), *(name+2), *(name+3),
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID, ndlp->nlp_flag,
-				 ndlp->nlp_state, ndlp->nlp_rpi);
+				 ndlp->nlp_state, ndlp->nlp_rpi,
+				 kref_read(&ndlp->kref));
 	} else {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_TRACE_EVENT,
 				 "0204 Devloss timeout on "
@@ -755,18 +780,22 @@ lpfc_work_list_done(struct lpfc_hba *phba)
 	int free_evt;
 	int fcf_inuse;
 	uint32_t nlp_did;
+	bool hba_pci_err;
 
 	spin_lock_irq(&phba->hbalock);
 	while (!list_empty(&phba->work_list)) {
 		list_remove_head((&phba->work_list), evtp, typeof(*evtp),
 				 evt_listp);
 		spin_unlock_irq(&phba->hbalock);
+		hba_pci_err = test_bit(HBA_PCI_ERR, &phba->bit_flags);
 		free_evt = 1;
 		switch (evtp->evt) {
 		case LPFC_EVT_ELS_RETRY:
 			ndlp = (struct lpfc_nodelist *) (evtp->evt_arg1);
-			lpfc_els_retry_delay_handler(ndlp);
-			free_evt = 0; /* evt is part of ndlp */
+			if (!hba_pci_err) {
+				lpfc_els_retry_delay_handler(ndlp);
+				free_evt = 0; /* evt is part of ndlp */
+			}
 			/* decrement the node reference count held
 			 * for this queued work
 			 */
@@ -788,8 +817,10 @@ lpfc_work_list_done(struct lpfc_hba *phba)
 			break;
 		case LPFC_EVT_RECOVER_PORT:
 			ndlp = (struct lpfc_nodelist *)(evtp->evt_arg1);
-			lpfc_sli_abts_recover_port(ndlp->vport, ndlp);
-			free_evt = 0;
+			if (!hba_pci_err) {
+				lpfc_sli_abts_recover_port(ndlp->vport, ndlp);
+				free_evt = 0;
+			}
 			/* decrement the node reference count held for
 			 * this queued work
 			 */
@@ -859,14 +890,18 @@ lpfc_work_done(struct lpfc_hba *phba)
 	struct lpfc_vport **vports;
 	struct lpfc_vport *vport;
 	int i;
+	bool hba_pci_err;
 
+	hba_pci_err = test_bit(HBA_PCI_ERR, &phba->bit_flags);
 	spin_lock_irq(&phba->hbalock);
 	ha_copy = phba->work_ha;
 	phba->work_ha = 0;
 	spin_unlock_irq(&phba->hbalock);
+	if (hba_pci_err)
+		ha_copy = 0;
 
 	/* First, try to post the next mailbox command to SLI4 device */
-	if (phba->pci_dev_grp == LPFC_PCI_DEV_OC)
+	if (phba->pci_dev_grp == LPFC_PCI_DEV_OC && !hba_pci_err)
 		lpfc_sli4_post_async_mbox(phba);
 
 	if (ha_copy & HA_ERATT) {
@@ -886,7 +921,7 @@ lpfc_work_done(struct lpfc_hba *phba)
 		lpfc_handle_latt(phba);
 
 	/* Handle VMID Events */
-	if (lpfc_is_vmid_enabled(phba)) {
+	if (lpfc_is_vmid_enabled(phba) && !hba_pci_err) {
 		if (phba->pport->work_port_events &
 		    WORKER_CHECK_VMID_ISSUE_QFPA) {
 			lpfc_check_vmid_qfpa_issue(phba);
@@ -936,6 +971,8 @@ lpfc_work_done(struct lpfc_hba *phba)
 			work_port_events = vport->work_port_events;
 			vport->work_port_events &= ~work_port_events;
 			spin_unlock_irq(&vport->work_port_lock);
+			if (hba_pci_err)
+				continue;
 			if (work_port_events & WORKER_DISC_TMO)
 				lpfc_disc_timeout_handler(vport);
 			if (work_port_events & WORKER_ELS_TMO)
@@ -1173,12 +1210,14 @@ lpfc_linkdown(struct lpfc_hba *phba)
 	struct lpfc_vport **vports;
 	LPFC_MBOXQ_t          *mb;
 	int i;
+	int offline;
 
 	if (phba->link_state == LPFC_LINK_DOWN)
 		return 0;
 
 	/* Block all SCSI stack I/Os */
 	lpfc_scsi_dev_block(phba);
+	offline = pci_channel_offline(phba->pcidev);
 
 	phba->defer_flogi_acc_flag = false;
 
@@ -1219,7 +1258,7 @@ lpfc_linkdown(struct lpfc_hba *phba)
 	lpfc_destroy_vport_work_array(phba, vports);
 
 	/* Clean up any SLI3 firmware default rpi's */
-	if (phba->sli_rev > LPFC_SLI_REV3)
+	if (phba->sli_rev > LPFC_SLI_REV3 || offline)
 		goto skip_unreg_did;
 
 	mb = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
@@ -4712,6 +4751,11 @@ lpfc_nlp_unreg_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	spin_lock_irqsave(&ndlp->lock, iflags);
 	if (!(ndlp->fc4_xpt_flags & NLP_XPT_REGD)) {
 		spin_unlock_irqrestore(&ndlp->lock, iflags);
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
+				 "0999 %s Not regd: ndlp x%px rport x%px DID "
+				 "x%x FLG x%x XPT x%x\n",
+				  __func__, ndlp, ndlp->rport, ndlp->nlp_DID,
+				  ndlp->nlp_flag, ndlp->fc4_xpt_flags);
 		return;
 	}
 
@@ -4722,6 +4766,13 @@ lpfc_nlp_unreg_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	    ndlp->fc4_xpt_flags & SCSI_XPT_REGD) {
 		vport->phba->nport_event_cnt++;
 		lpfc_unregister_remote_port(ndlp);
+	} else if (!ndlp->rport) {
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
+				 "1999 %s NDLP in devloss x%px DID x%x FLG x%x"
+				 " XPT x%x refcnt %d\n",
+				 __func__, ndlp, ndlp->nlp_DID, ndlp->nlp_flag,
+				 ndlp->fc4_xpt_flags,
+				 kref_read(&ndlp->kref));
 	}
 
 	if (ndlp->fc4_xpt_flags & NVME_XPT_REGD) {
@@ -5371,6 +5422,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				ndlp->nlp_flag &= ~NLP_UNREG_INP;
 				mempool_free(mbox, phba->mbox_mem_pool);
 				acc_plogi = 1;
+				lpfc_nlp_put(ndlp);
 			}
 		} else {
 			lpfc_printf_vlog(vport, KERN_INFO,
@@ -6097,12 +6149,34 @@ lpfc_disc_flush_list(struct lpfc_vport *vport)
 	}
 }
 
+/*
+ * lpfc_notify_xport_npr - notifies xport of node disappearance
+ * @vport: Pointer to Virtual Port object.
+ *
+ * Transitions all ndlps to NPR state.  When lpfc_nlp_set_state
+ * calls lpfc_nlp_state_cleanup, the ndlp->rport is unregistered
+ * and transport notified that the node is gone.
+ * Return Code:
+ *	none
+ */
+static void
+lpfc_notify_xport_npr(struct lpfc_vport *vport)
+{
+	struct lpfc_nodelist *ndlp, *next_ndlp;
+
+	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes,
+				 nlp_listp) {
+		lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
+	}
+}
 void
 lpfc_cleanup_discovery_resources(struct lpfc_vport *vport)
 {
 	lpfc_els_flush_rscn(vport);
 	lpfc_els_flush_cmd(vport);
 	lpfc_disc_flush_list(vport);
+	if (pci_channel_offline(vport->phba->pcidev))
+		lpfc_notify_xport_npr(vport);
 }
 
 /*****************************************************************************/
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index eed6464bd880..461d333b1b3a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -95,6 +95,7 @@ static void lpfc_sli4_oas_verify(struct lpfc_hba *phba);
 static uint16_t lpfc_find_cpu_handle(struct lpfc_hba *, uint16_t, int);
 static void lpfc_setup_bg(struct lpfc_hba *, struct Scsi_Host *);
 static int lpfc_sli4_cgn_parm_chg_evt(struct lpfc_hba *);
+static void lpfc_sli4_prep_dev_for_reset(struct lpfc_hba *phba);
 
 static struct scsi_transport_template *lpfc_transport_template = NULL;
 static struct scsi_transport_template *lpfc_vport_transport_template = NULL;
@@ -1642,7 +1643,7 @@ lpfc_sli4_offline_eratt(struct lpfc_hba *phba)
 {
 	spin_lock_irq(&phba->hbalock);
 	if (phba->link_state == LPFC_HBA_ERROR &&
-	    phba->hba_flag & HBA_PCI_ERR) {
+		test_bit(HBA_PCI_ERR, &phba->bit_flags)) {
 		spin_unlock_irq(&phba->hbalock);
 		return;
 	}
@@ -1985,6 +1986,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 	if (pci_channel_offline(phba->pcidev)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3166 pci channel is offline\n");
+		lpfc_sli_flush_io_rings(phba);
 		return;
 	}
 
@@ -2973,6 +2975,22 @@ lpfc_cleanup(struct lpfc_vport *vport)
 					NLP_EVT_DEVICE_RM);
 	}
 
+	/* This is a special case flush to return all
+	 * IOs before entering this loop. There are
+	 * two points in the code where a flush is
+	 * avoided if the FC_UNLOADING flag is set.
+	 * one is in the multipool destroy,
+	 * (this prevents a crash) and the other is
+	 * in the nvme abort handler, ( also prevents
+	 * a crash). Both of these exceptions are
+	 * cases where the slot is still accessible.
+	 * The flush here is only when the pci slot
+	 * is offline.
+	 */
+	if (vport->load_flag & FC_UNLOADING &&
+	    pci_channel_offline(phba->pcidev))
+		lpfc_sli_flush_io_rings(vport->phba);
+
 	/* At this point, ALL ndlp's should be gone
 	 * because of the previous NLP_EVT_DEVICE_RM.
 	 * Lets wait for this to happen, if needed.
@@ -2985,7 +3003,7 @@ lpfc_cleanup(struct lpfc_vport *vport)
 			list_for_each_entry_safe(ndlp, next_ndlp,
 						&vport->fc_nodes, nlp_listp) {
 				lpfc_printf_vlog(ndlp->vport, KERN_ERR,
-						 LOG_TRACE_EVENT,
+						 LOG_DISCOVERY,
 						 "0282 did:x%x ndlp:x%px "
 						 "refcnt:%d xflags x%x nflag x%x\n",
 						 ndlp->nlp_DID, (void *)ndlp,
@@ -3682,7 +3700,8 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
 	struct lpfc_vport **vports;
 	struct Scsi_Host *shost;
 	int i;
-	int offline = 0;
+	int offline;
+	bool hba_pci_err;
 
 	if (vport->fc_flag & FC_OFFLINE_MODE)
 		return;
@@ -3692,6 +3711,7 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
 	lpfc_linkdown(phba);
 
 	offline =  pci_channel_offline(phba->pcidev);
+	hba_pci_err = test_bit(HBA_PCI_ERR, &phba->bit_flags);
 
 	/* Issue an unreg_login to all nodes on all vports */
 	vports = lpfc_create_vport_work_array(phba);
@@ -3715,11 +3735,14 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
 				ndlp->nlp_flag &= ~NLP_NPR_ADISC;
 				spin_unlock_irq(&ndlp->lock);
 
-				if (offline) {
+				if (offline || hba_pci_err) {
 					spin_lock_irq(&ndlp->lock);
 					ndlp->nlp_flag &= ~(NLP_UNREG_INP |
 							    NLP_RPI_REGISTERED);
 					spin_unlock_irq(&ndlp->lock);
+					if (phba->sli_rev == LPFC_SLI_REV4)
+						lpfc_sli_rpi_release(vports[i],
+								     ndlp);
 				} else {
 					lpfc_unreg_rpi(vports[i], ndlp);
 				}
@@ -13354,8 +13377,9 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 	/* Abort all iocbs associated with the hba */
 	lpfc_sli_hba_iocb_abort(phba);
 
-	/* Wait for completion of device XRI exchange busy */
-	lpfc_sli4_xri_exchange_busy_wait(phba);
+	if (!pci_channel_offline(phba->pcidev))
+		/* Wait for completion of device XRI exchange busy */
+		lpfc_sli4_xri_exchange_busy_wait(phba);
 
 	/* per-phba callback de-registration for hotplug event */
 	if (phba->pport)
@@ -13374,15 +13398,12 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 	/* Disable FW logging to host memory */
 	lpfc_ras_stop_fwlog(phba);
 
-	/* Unset the queues shared with the hardware then release all
-	 * allocated resources.
-	 */
-	lpfc_sli4_queue_unset(phba);
-	lpfc_sli4_queue_destroy(phba);
-
 	/* Reset SLI4 HBA FCoE function */
 	lpfc_pci_function_reset(phba);
 
+	/* release all queue allocated resources. */
+	lpfc_sli4_queue_destroy(phba);
+
 	/* Free RAS DMA memory */
 	if (phba->ras_fwlog.ras_enabled)
 		lpfc_sli4_ras_dma_free(phba);
@@ -14262,6 +14283,7 @@ lpfc_sli_prep_dev_for_perm_failure(struct lpfc_hba *phba)
 			"2711 PCI channel permanent disable for failure\n");
 	/* Block all SCSI devices' I/Os on the host */
 	lpfc_scsi_dev_block(phba);
+	lpfc_sli4_prep_dev_for_reset(phba);
 
 	/* stop all timers */
 	lpfc_stop_hba_timers(phba);
@@ -15057,24 +15079,28 @@ lpfc_sli4_prep_dev_for_recover(struct lpfc_hba *phba)
 static void
 lpfc_sli4_prep_dev_for_reset(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-			"2826 PCI channel disable preparing for reset\n");
+	int offline =  pci_channel_offline(phba->pcidev);
+
+	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			"2826 PCI channel disable preparing for reset offline"
+			" %d\n", offline);
 
 	/* Block any management I/Os to the device */
 	lpfc_block_mgmt_io(phba, LPFC_MBX_NO_WAIT);
 
-	/* Block all SCSI devices' I/Os on the host */
-	lpfc_scsi_dev_block(phba);
 
+	/* HBA_PCI_ERR was set in io_error_detect */
+	lpfc_offline_prep(phba, LPFC_MBX_NO_WAIT);
 	/* Flush all driver's outstanding I/Os as we are to reset */
 	lpfc_sli_flush_io_rings(phba);
+	lpfc_offline(phba);
 
 	/* stop all timers */
 	lpfc_stop_hba_timers(phba);
 
+	lpfc_sli4_queue_destroy(phba);
 	/* Disable interrupt and pci device */
 	lpfc_sli4_disable_intr(phba);
-	lpfc_sli4_queue_destroy(phba);
 	pci_disable_device(phba->pcidev);
 }
 
@@ -15123,6 +15149,7 @@ lpfc_io_error_detected_s4(struct pci_dev *pdev, pci_channel_state_t state)
 {
 	struct Scsi_Host *shost = pci_get_drvdata(pdev);
 	struct lpfc_hba *phba = ((struct lpfc_vport *)shost->hostdata)->phba;
+	bool hba_pci_err;
 
 	switch (state) {
 	case pci_channel_io_normal:
@@ -15130,17 +15157,24 @@ lpfc_io_error_detected_s4(struct pci_dev *pdev, pci_channel_state_t state)
 		lpfc_sli4_prep_dev_for_recover(phba);
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
-		phba->hba_flag |= HBA_PCI_ERR;
+		hba_pci_err = test_and_set_bit(HBA_PCI_ERR, &phba->bit_flags);
 		/* Fatal error, prepare for slot reset */
-		lpfc_sli4_prep_dev_for_reset(phba);
+		if (!hba_pci_err)
+			lpfc_sli4_prep_dev_for_reset(phba);
+		else
+			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+					"2832  Already handling PCI error "
+					"state: x%x\n", state);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
-		phba->hba_flag |= HBA_PCI_ERR;
+		set_bit(HBA_PCI_ERR, &phba->bit_flags);
 		/* Permanent failure, prepare for device down */
 		lpfc_sli4_prep_dev_for_perm_failure(phba);
 		return PCI_ERS_RESULT_DISCONNECT;
 	default:
-		phba->hba_flag |= HBA_PCI_ERR;
+		hba_pci_err = test_and_set_bit(HBA_PCI_ERR, &phba->bit_flags);
+		if (!hba_pci_err)
+			lpfc_sli4_prep_dev_for_reset(phba);
 		/* Unknown state, prepare and request slot reset */
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2825 Unknown PCI error state: x%x\n", state);
@@ -15174,17 +15208,21 @@ lpfc_io_slot_reset_s4(struct pci_dev *pdev)
 	struct lpfc_hba *phba = ((struct lpfc_vport *)shost->hostdata)->phba;
 	struct lpfc_sli *psli = &phba->sli;
 	uint32_t intr_mode;
+	bool hba_pci_err;
 
 	dev_printk(KERN_INFO, &pdev->dev, "recovering from a slot reset.\n");
 	if (pci_enable_device_mem(pdev)) {
 		printk(KERN_ERR "lpfc: Cannot re-enable "
-			"PCI device after reset.\n");
+		       "PCI device after reset.\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
 	pci_restore_state(pdev);
 
-	phba->hba_flag &= ~HBA_PCI_ERR;
+	hba_pci_err = test_and_clear_bit(HBA_PCI_ERR, &phba->bit_flags);
+	if (!hba_pci_err)
+		dev_info(&pdev->dev,
+			 "hba_pci_err was not set, recovering slot reset.\n");
 	/*
 	 * As the new kernel behavior of pci_restore_state() API call clears
 	 * device saved_state flag, need to save the restored state again.
@@ -15198,6 +15236,8 @@ lpfc_io_slot_reset_s4(struct pci_dev *pdev)
 	psli->sli_flag &= ~LPFC_SLI_ACTIVE;
 	spin_unlock_irq(&phba->hbalock);
 
+	/* Init cpu_map array */
+	lpfc_cpu_map_array_init(phba);
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli4_enable_intr(phba, phba->intr_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
@@ -15239,8 +15279,6 @@ lpfc_io_resume_s4(struct pci_dev *pdev)
 	 */
 	if (!(phba->sli.sli_flag & LPFC_SLI_ACTIVE)) {
 		/* Perform device reset */
-		lpfc_offline_prep(phba, LPFC_MBX_WAIT);
-		lpfc_offline(phba);
 		lpfc_sli_brdrestart(phba);
 		/* Bring the device back online */
 		lpfc_online(phba);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 1213a299f9aa..8d26f207ebd2 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -93,6 +93,11 @@ lpfc_nvme_create_queue(struct nvme_fc_local_port *pnvme_lport,
 
 	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
 	vport = lport->vport;
+
+	if (!vport || vport->load_flag & FC_UNLOADING ||
+	    vport->phba->hba_flag & HBA_IOQ_FLUSH)
+		return -ENODEV;
+
 	qhandle = kzalloc(sizeof(struct lpfc_nvme_qhandle), GFP_KERNEL);
 	if (qhandle == NULL)
 		return -ENOMEM;
@@ -267,7 +272,8 @@ lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
 		return -EINVAL;
 
 	remoteport = lpfc_rport->remoteport;
-	if (!vport->localport)
+	if (!vport->localport ||
+	    vport->phba->hba_flag & HBA_IOQ_FLUSH)
 		return -EINVAL;
 
 	lport = vport->localport->private;
@@ -559,6 +565,8 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				 ndlp->nlp_DID, ntype, nstate);
 		return -ENODEV;
 	}
+	if (vport->phba->hba_flag & HBA_IOQ_FLUSH)
+		return -ENODEV;
 
 	if (!vport->phba->sli4_hba.nvmels_wq)
 		return -ENOMEM;
@@ -662,7 +670,8 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 		return -EINVAL;
 
 	vport = lport->vport;
-	if (vport->load_flag & FC_UNLOADING)
+	if (vport->load_flag & FC_UNLOADING ||
+	    vport->phba->hba_flag & HBA_IOQ_FLUSH)
 		return -ENODEV;
 
 	atomic_inc(&lport->fc4NvmeLsRequests);
@@ -1516,7 +1525,8 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 
 	phba = vport->phba;
 
-	if (unlikely(vport->load_flag & FC_UNLOADING)) {
+	if ((unlikely(vport->load_flag & FC_UNLOADING)) ||
+	    phba->hba_flag & HBA_IOQ_FLUSH) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_IOERR,
 				 "6124 Fail IO, Driver unload\n");
 		atomic_inc(&lport->xmt_fcp_err);
@@ -2169,8 +2179,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 			abts_nvme = 0;
 			for (i = 0; i < phba->cfg_hdw_queue; i++) {
 				qp = &phba->sli4_hba.hdwq[i];
-				if (!vport || !vport->localport ||
-				    !qp || !qp->io_wq)
+				if (!vport->localport || !qp || !qp->io_wq)
 					return;
 
 				pring = qp->io_wq->pring;
@@ -2180,8 +2189,9 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 				abts_scsi += qp->abts_scsi_io_bufs;
 				abts_nvme += qp->abts_nvme_io_bufs;
 			}
-			if (!vport || !vport->localport ||
-			    vport->phba->hba_flag & HBA_PCI_ERR)
+			if (!vport->localport ||
+			    test_bit(HBA_PCI_ERR, &vport->phba->bit_flags) ||
+			    vport->load_flag & FC_UNLOADING)
 				return;
 
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
@@ -2541,8 +2551,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		 * return values is ignored.  The upcall is a courtesy to the
 		 * transport.
 		 */
-		if (vport->load_flag & FC_UNLOADING ||
-		    unlikely(vport->phba->hba_flag & HBA_PCI_ERR))
+		if (vport->load_flag & FC_UNLOADING)
 			(void)nvme_fc_set_remoteport_devloss(remoteport, 0);
 
 		ret = nvme_fc_unregister_remoteport(remoteport);
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 3c132604fd91..ba9dbb51b75f 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5929,13 +5929,15 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 	}
 
 	lpfc_cmd->waitq = &waitq;
-	if (phba->sli_rev == LPFC_SLI_REV4)
+	if (phba->sli_rev == LPFC_SLI_REV4) {
 		spin_unlock(&pring_s4->ring_lock);
-	else
+		ret_val = lpfc_sli4_issue_abort_iotag(phba, iocb,
+						      lpfc_sli_abort_fcp_cmpl);
+	} else {
 		pring = &phba->sli.sli3_ring[LPFC_FCP_RING];
-
-	ret_val = lpfc_sli_issue_abort_iotag(phba, pring, iocb,
-					     lpfc_sli_abort_fcp_cmpl);
+		ret_val = lpfc_sli_issue_abort_iotag(phba, pring, iocb,
+						     lpfc_sli_abort_fcp_cmpl);
+	}
 
 	/* Make sure HBA is alive */
 	lpfc_issue_hb_tmo(phba);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 20d40957a385..bda2a7ba4e77 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2828,6 +2828,12 @@ __lpfc_sli_rpi_release(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	ndlp->nlp_flag &= ~NLP_UNREG_INP;
 }
 
+void
+lpfc_sli_rpi_release(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
+{
+	__lpfc_sli_rpi_release(vport, ndlp);
+}
+
 /**
  * lpfc_sli_def_mbox_cmpl - Default mailbox completion handler
  * @phba: Pointer to HBA context object.
@@ -3715,7 +3721,15 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	unsigned long iflag;
 	u32 ulp_command, ulp_status, ulp_word4, ulp_context, iotag;
 
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		spin_lock_irqsave(&pring->ring_lock, iflag);
+	else
+		spin_lock_irqsave(&phba->hbalock, iflag);
 	cmdiocbp = lpfc_sli_iocbq_lookup(phba, pring, saveq);
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		spin_unlock_irqrestore(&pring->ring_lock, iflag);
+	else
+		spin_unlock_irqrestore(&phba->hbalock, iflag);
 
 	ulp_command = get_job_cmnd(phba, saveq);
 	ulp_status = get_job_ulpstatus(phba, saveq);
@@ -4052,10 +4066,8 @@ lpfc_sli_handle_fast_ring_event(struct lpfc_hba *phba,
 				break;
 			}
 
-			spin_unlock_irqrestore(&phba->hbalock, iflag);
 			cmdiocbq = lpfc_sli_iocbq_lookup(phba, pring,
 							 &rspiocbq);
-			spin_lock_irqsave(&phba->hbalock, iflag);
 			if (unlikely(!cmdiocbq))
 				break;
 			if (cmdiocbq->cmd_flag & LPFC_DRIVER_ABORTED)
@@ -4536,42 +4548,62 @@ lpfc_sli_handle_slow_ring_event_s4(struct lpfc_hba *phba,
 void
 lpfc_sli_abort_iocb_ring(struct lpfc_hba *phba, struct lpfc_sli_ring *pring)
 {
-	LIST_HEAD(completions);
+	LIST_HEAD(tx_completions);
+	LIST_HEAD(txcmplq_completions);
 	struct lpfc_iocbq *iocb, *next_iocb;
+	int offline;
 
 	if (pring->ringno == LPFC_ELS_RING) {
 		lpfc_fabric_abort_hba(phba);
 	}
+	offline = pci_channel_offline(phba->pcidev);
 
 	/* Error everything on txq and txcmplq
 	 * First do the txq.
 	 */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
 		spin_lock_irq(&pring->ring_lock);
-		list_splice_init(&pring->txq, &completions);
+		list_splice_init(&pring->txq, &tx_completions);
 		pring->txq_cnt = 0;
-		spin_unlock_irq(&pring->ring_lock);
 
-		spin_lock_irq(&phba->hbalock);
-		/* Next issue ABTS for everything on the txcmplq */
-		list_for_each_entry_safe(iocb, next_iocb, &pring->txcmplq, list)
-			lpfc_sli_issue_abort_iotag(phba, pring, iocb, NULL);
-		spin_unlock_irq(&phba->hbalock);
+		if (offline) {
+			list_splice_init(&pring->txcmplq,
+					 &txcmplq_completions);
+		} else {
+			/* Next issue ABTS for everything on the txcmplq */
+			list_for_each_entry_safe(iocb, next_iocb,
+						 &pring->txcmplq, list)
+				lpfc_sli_issue_abort_iotag(phba, pring,
+							   iocb, NULL);
+		}
+		spin_unlock_irq(&pring->ring_lock);
 	} else {
 		spin_lock_irq(&phba->hbalock);
-		list_splice_init(&pring->txq, &completions);
+		list_splice_init(&pring->txq, &tx_completions);
 		pring->txq_cnt = 0;
 
-		/* Next issue ABTS for everything on the txcmplq */
-		list_for_each_entry_safe(iocb, next_iocb, &pring->txcmplq, list)
-			lpfc_sli_issue_abort_iotag(phba, pring, iocb, NULL);
+		if (offline) {
+			list_splice_init(&pring->txcmplq, &txcmplq_completions);
+		} else {
+			/* Next issue ABTS for everything on the txcmplq */
+			list_for_each_entry_safe(iocb, next_iocb,
+						 &pring->txcmplq, list)
+				lpfc_sli_issue_abort_iotag(phba, pring,
+							   iocb, NULL);
+		}
 		spin_unlock_irq(&phba->hbalock);
 	}
-	/* Make sure HBA is alive */
-	lpfc_issue_hb_tmo(phba);
 
+	if (offline) {
+		/* Cancel all the IOCBs from the completions list */
+		lpfc_sli_cancel_iocbs(phba, &txcmplq_completions,
+				      IOSTAT_LOCAL_REJECT, IOERR_SLI_ABORTED);
+	} else {
+		/* Make sure HBA is alive */
+		lpfc_issue_hb_tmo(phba);
+	}
 	/* Cancel all the IOCBs from the completions list */
-	lpfc_sli_cancel_iocbs(phba, &completions, IOSTAT_LOCAL_REJECT,
+	lpfc_sli_cancel_iocbs(phba, &tx_completions, IOSTAT_LOCAL_REJECT,
 			      IOERR_SLI_ABORTED);
 }
 
@@ -4624,11 +4656,6 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
 	struct lpfc_iocbq *piocb, *next_iocb;
 
 	spin_lock_irq(&phba->hbalock);
-	if (phba->hba_flag & HBA_IOQ_FLUSH ||
-	    !phba->sli4_hba.hdwq) {
-		spin_unlock_irq(&phba->hbalock);
-		return;
-	}
 	/* Indicate the I/O queues are flushed */
 	phba->hba_flag |= HBA_IOQ_FLUSH;
 	spin_unlock_irq(&phba->hbalock);
@@ -10997,6 +11024,10 @@ lpfc_sli_issue_iocb(struct lpfc_hba *phba, uint32_t ring_number,
 	unsigned long iflags;
 	int rc;
 
+	/* If the PCI channel is in offline state, do not post iocbs. */
+	if (unlikely(pci_channel_offline(phba->pcidev)))
+		return IOCB_ERROR;
+
 	if (phba->sli_rev == LPFC_SLI_REV4) {
 		lpfc_sli_prep_wqe(phba, piocb);
 
diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index e52f37e5d896..a4d3259b8c52 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "14.2.0.0"
+#define LPFC_DRIVER_VERSION "14.2.0.1"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 611871ef15b5..4919ea54b827 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2560,6 +2560,9 @@ struct megasas_instance_template {
 #define MEGASAS_IS_LOGICAL(sdev)					\
 	((sdev->channel < MEGASAS_MAX_PD_CHANNELS) ? 0 : 1)
 
+#define MEGASAS_IS_LUN_VALID(sdev)					\
+	(((sdev)->lun == 0) ? 1 : 0)
+
 #define MEGASAS_DEV_INDEX(scp)						\
 	(((scp->device->channel % 2) * MEGASAS_MAX_DEV_PER_CHANNEL) +	\
 	scp->device->id)
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 8bf72dbc33b7..db6793608447 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2126,6 +2126,9 @@ static int megasas_slave_alloc(struct scsi_device *sdev)
 			goto scan_target;
 		}
 		return -ENXIO;
+	} else if (!MEGASAS_IS_LUN_VALID(sdev)) {
+		sdev_printk(KERN_INFO, sdev, "%s: invalid LUN\n", __func__);
+		return -ENXIO;
 	}
 
 scan_target:
@@ -2156,6 +2159,10 @@ static void megasas_slave_destroy(struct scsi_device *sdev)
 	instance = megasas_lookup_instance(sdev->host->host_no);
 
 	if (MEGASAS_IS_LOGICAL(sdev)) {
+		if (!MEGASAS_IS_LUN_VALID(sdev)) {
+			sdev_printk(KERN_INFO, sdev, "%s: invalid LUN\n", __func__);
+			return;
+		}
 		ld_tgt_id = MEGASAS_TARGET_ID(sdev);
 		instance->ld_tgtid_status[ld_tgt_id] = LD_TARGET_ID_DELETED;
 		if (megasas_dbg_lvl & LD_PD_DEBUG)
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index b57f1803371e..538d2c0cd971 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5716,13 +5716,12 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 /**
  * mpt3sas_check_same_4gb_region - checks whether all reply queues in a set are
  *	having same upper 32bits in their base memory address.
- * @reply_pool_start_address: Base address of a reply queue set
+ * @start_address: Base address of a reply queue set
  * @pool_sz: Size of single Reply Descriptor Post Queues pool size
  *
  * Return: 1 if reply queues in a set have a same upper 32bits in their base
  * memory address, else 0.
  */
-
 static int
 mpt3sas_check_same_4gb_region(dma_addr_t start_address, u32 pool_sz)
 {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 0563078227de..a8dd14c91efd 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -394,10 +394,13 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 		retry_count++;
 		if (ioc->config_cmds.smid == smid)
 			mpt3sas_base_free_smid(ioc, smid);
-		if ((ioc->shost_recovery) || (ioc->config_cmds.status &
-		    MPT3_CMD_RESET) || ioc->pci_error_recovery)
+		if (ioc->config_cmds.status & MPT3_CMD_RESET)
 			goto retry_config;
-		issue_host_reset = 1;
+		if (ioc->shost_recovery || ioc->pci_error_recovery) {
+			issue_host_reset = 0;
+			r = -EFAULT;
+		} else
+			issue_host_reset = 1;
 		goto free_mem;
 	}
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 00792767c620..7e476f50935b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11035,6 +11035,7 @@ _scsih_expander_node_remove(struct MPT3SAS_ADAPTER *ioc,
 {
 	struct _sas_port *mpt3sas_port, *next;
 	unsigned long flags;
+	int port_id;
 
 	/* remove sibling ports attached to this expander */
 	list_for_each_entry_safe(mpt3sas_port, next,
@@ -11055,6 +11056,8 @@ _scsih_expander_node_remove(struct MPT3SAS_ADAPTER *ioc,
 			    mpt3sas_port->hba_port);
 	}
 
+	port_id = sas_expander->port->port_id;
+
 	mpt3sas_transport_port_remove(ioc, sas_expander->sas_address,
 	    sas_expander->sas_address_parent, sas_expander->port);
 
@@ -11062,7 +11065,7 @@ _scsih_expander_node_remove(struct MPT3SAS_ADAPTER *ioc,
 	    "expander_remove: handle(0x%04x), sas_addr(0x%016llx), port:%d\n",
 	    sas_expander->handle, (unsigned long long)
 	    sas_expander->sas_address,
-	    sas_expander->port->port_id);
+	    port_id);
 
 	spin_lock_irqsave(&ioc->sas_node_lock, flags);
 	list_del(&sas_expander->list);
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 7ac63eb5ccd3..2fde496fff5f 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -647,6 +647,7 @@ static struct pci_device_id mvs_pci_table[] = {
 	{ PCI_VDEVICE(ARECA, PCI_DEVICE_ID_ARECA_1300), chip_1300 },
 	{ PCI_VDEVICE(ARECA, PCI_DEVICE_ID_ARECA_1320), chip_1320 },
 	{ PCI_VDEVICE(ADAPTEC2, 0x0450), chip_6440 },
+	{ PCI_VDEVICE(TTI, 0x2640), chip_6440 },
 	{ PCI_VDEVICE(TTI, 0x2710), chip_9480 },
 	{ PCI_VDEVICE(TTI, 0x2720), chip_9480 },
 	{ PCI_VDEVICE(TTI, 0x2721), chip_9480 },
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index c4a838635893..5d7dfefd6f6c 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -192,10 +192,11 @@ struct sym53c500_data {
 	int fast_pio;
 };
 
-static struct scsi_pointer *sym53c500_scsi_pointer(struct scsi_cmnd *cmd)
-{
-	return scsi_cmd_priv(cmd);
-}
+struct sym53c500_cmd_priv {
+	int status;
+	int message;
+	int phase;
+};
 
 enum Phase {
     idle,
@@ -356,7 +357,7 @@ SYM53C500_intr(int irq, void *dev_id)
 	struct sym53c500_data *data =
 	    (struct sym53c500_data *)dev->hostdata;
 	struct scsi_cmnd *curSC = data->current_SC;
-	struct scsi_pointer *scsi_pointer = sym53c500_scsi_pointer(curSC);
+	struct sym53c500_cmd_priv *scp = scsi_cmd_priv(curSC);
 	int fast_pio = data->fast_pio;
 
 	spin_lock_irqsave(dev->host_lock, flags);
@@ -403,12 +404,11 @@ SYM53C500_intr(int irq, void *dev_id)
 
 	if (int_reg & 0x20) {		/* Disconnect */
 		DEB(printk("SYM53C500: disconnect intr received\n"));
-		if (scsi_pointer->phase != message_in) {	/* Unexpected disconnect */
+		if (scp->phase != message_in) {	/* Unexpected disconnect */
 			curSC->result = DID_NO_CONNECT << 16;
 		} else {	/* Command complete, return status and message */
-			curSC->result = (scsi_pointer->Status & 0xff) |
-				((scsi_pointer->Message & 0xff) << 8) |
-				(DID_OK << 16);
+			curSC->result = (scp->status & 0xff) |
+				((scp->message & 0xff) << 8) | (DID_OK << 16);
 		}
 		goto idle_out;
 	}
@@ -419,7 +419,7 @@ SYM53C500_intr(int irq, void *dev_id)
 			struct scatterlist *sg;
 			int i;
 
-			scsi_pointer->phase = data_out;
+			scp->phase = data_out;
 			VDEB(printk("SYM53C500: Data-Out phase\n"));
 			outb(FLUSH_FIFO, port_base + CMD_REG);
 			LOAD_DMA_COUNT(port_base, scsi_bufflen(curSC));	/* Max transfer size */
@@ -438,7 +438,7 @@ SYM53C500_intr(int irq, void *dev_id)
 			struct scatterlist *sg;
 			int i;
 
-			scsi_pointer->phase = data_in;
+			scp->phase = data_in;
 			VDEB(printk("SYM53C500: Data-In phase\n"));
 			outb(FLUSH_FIFO, port_base + CMD_REG);
 			LOAD_DMA_COUNT(port_base, scsi_bufflen(curSC));	/* Max transfer size */
@@ -453,12 +453,12 @@ SYM53C500_intr(int irq, void *dev_id)
 		break;
 
 	case 0x02:		/* COMMAND */
-		scsi_pointer->phase = command_ph;
+		scp->phase = command_ph;
 		printk("SYM53C500: Warning: Unknown interrupt occurred in command phase!\n");
 		break;
 
 	case 0x03:		/* STATUS */
-		scsi_pointer->phase = status_ph;
+		scp->phase = status_ph;
 		VDEB(printk("SYM53C500: Status phase\n"));
 		outb(FLUSH_FIFO, port_base + CMD_REG);
 		outb(INIT_CMD_COMPLETE, port_base + CMD_REG);
@@ -471,24 +471,22 @@ SYM53C500_intr(int irq, void *dev_id)
 
 	case 0x06:		/* MESSAGE-OUT */
 		DEB(printk("SYM53C500: Message-Out phase\n"));
-		scsi_pointer->phase = message_out;
+		scp->phase = message_out;
 		outb(SET_ATN, port_base + CMD_REG);	/* Reject the message */
 		outb(MSG_ACCEPT, port_base + CMD_REG);
 		break;
 
 	case 0x07:		/* MESSAGE-IN */
 		VDEB(printk("SYM53C500: Message-In phase\n"));
-		scsi_pointer->phase = message_in;
+		scp->phase = message_in;
 
-		scsi_pointer->Status = inb(port_base + SCSI_FIFO);
-		scsi_pointer->Message = inb(port_base + SCSI_FIFO);
+		scp->status = inb(port_base + SCSI_FIFO);
+		scp->message = inb(port_base + SCSI_FIFO);
 
 		VDEB(printk("SCSI FIFO size=%d\n", inb(port_base + FIFO_FLAGS) & 0x1f));
-		DEB(printk("Status = %02x  Message = %02x\n",
-			   scsi_pointer->Status, scsi_pointer->Message));
+		DEB(printk("Status = %02x  Message = %02x\n", scp->status, scp->message));
 
-		if (scsi_pointer->Message == SAVE_POINTERS ||
-		    scsi_pointer->Message == DISCONNECT) {
+		if (scp->message == SAVE_POINTERS || scp->message == DISCONNECT) {
 			outb(SET_ATN, port_base + CMD_REG);	/* Reject message */
 			DEB(printk("Discarding SAVE_POINTERS message\n"));
 		}
@@ -500,7 +498,7 @@ SYM53C500_intr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 
 idle_out:
-	scsi_pointer->phase = idle;
+	scp->phase = idle;
 	scsi_done(curSC);
 	goto out;
 }
@@ -548,7 +546,7 @@ SYM53C500_info(struct Scsi_Host *SChost)
 
 static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
 {
-	struct scsi_pointer *scsi_pointer = sym53c500_scsi_pointer(SCpnt);
+	struct sym53c500_cmd_priv *scp = scsi_cmd_priv(SCpnt);
 	int i;
 	int port_base = SCpnt->device->host->io_port;
 	struct sym53c500_data *data =
@@ -565,9 +563,9 @@ static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
 	VDEB(printk("\n"));
 
 	data->current_SC = SCpnt;
-	scsi_pointer->phase = command_ph;
-	scsi_pointer->Status = 0;
-	scsi_pointer->Message = 0;
+	scp->phase = command_ph;
+	scp->status = 0;
+	scp->message = 0;
 
 	/* We are locked here already by the mid layer */
 	REG0(port_base);
@@ -682,7 +680,7 @@ static struct scsi_host_template sym53c500_driver_template = {
      .this_id			= 7,
      .sg_tablesize		= 32,
      .shost_groups		= SYM53C500_shost_groups,
-     .cmd_size			= sizeof(struct scsi_pointer),
+     .cmd_size			= sizeof(struct sym53c500_cmd_priv),
 };
 
 static int SYM53C500_config_check(struct pcmcia_device *p_dev, void *priv_data)
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 928532180d32..fd674ed1febe 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3181,124 +3181,6 @@ static int pmcraid_build_ioadl(
 	return 0;
 }
 
-/**
- * pmcraid_free_sglist - Frees an allocated SG buffer list
- * @sglist: scatter/gather list pointer
- *
- * Free a DMA'able memory previously allocated with pmcraid_alloc_sglist
- *
- * Return value:
- *	none
- */
-static void pmcraid_free_sglist(struct pmcraid_sglist *sglist)
-{
-	sgl_free_order(sglist->scatterlist, sglist->order);
-	kfree(sglist);
-}
-
-/**
- * pmcraid_alloc_sglist - Allocates memory for a SG list
- * @buflen: buffer length
- *
- * Allocates a DMA'able buffer in chunks and assembles a scatter/gather
- * list.
- *
- * Return value
- *	pointer to sglist / NULL on failure
- */
-static struct pmcraid_sglist *pmcraid_alloc_sglist(int buflen)
-{
-	struct pmcraid_sglist *sglist;
-	int sg_size;
-	int order;
-
-	sg_size = buflen / (PMCRAID_MAX_IOADLS - 1);
-	order = (sg_size > 0) ? get_order(sg_size) : 0;
-
-	/* Allocate a scatter/gather list for the DMA */
-	sglist = kzalloc(sizeof(struct pmcraid_sglist), GFP_KERNEL);
-	if (sglist == NULL)
-		return NULL;
-
-	sglist->order = order;
-	sgl_alloc_order(buflen, order, false, GFP_KERNEL | __GFP_ZERO,
-			&sglist->num_sg);
-
-	return sglist;
-}
-
-/**
- * pmcraid_copy_sglist - Copy user buffer to kernel buffer's SG list
- * @sglist: scatter/gather list pointer
- * @buffer: buffer pointer
- * @len: buffer length
- * @direction: data transfer direction
- *
- * Copy a user buffer into a buffer allocated by pmcraid_alloc_sglist
- *
- * Return value:
- * 0 on success / other on failure
- */
-static int pmcraid_copy_sglist(
-	struct pmcraid_sglist *sglist,
-	void __user *buffer,
-	u32 len,
-	int direction
-)
-{
-	struct scatterlist *sg;
-	void *kaddr;
-	int bsize_elem;
-	int i;
-	int rc = 0;
-
-	/* Determine the actual number of bytes per element */
-	bsize_elem = PAGE_SIZE * (1 << sglist->order);
-
-	sg = sglist->scatterlist;
-
-	for (i = 0; i < (len / bsize_elem); i++, sg = sg_next(sg), buffer += bsize_elem) {
-		struct page *page = sg_page(sg);
-
-		kaddr = kmap(page);
-		if (direction == DMA_TO_DEVICE)
-			rc = copy_from_user(kaddr, buffer, bsize_elem);
-		else
-			rc = copy_to_user(buffer, kaddr, bsize_elem);
-
-		kunmap(page);
-
-		if (rc) {
-			pmcraid_err("failed to copy user data into sg list\n");
-			return -EFAULT;
-		}
-
-		sg->length = bsize_elem;
-	}
-
-	if (len % bsize_elem) {
-		struct page *page = sg_page(sg);
-
-		kaddr = kmap(page);
-
-		if (direction == DMA_TO_DEVICE)
-			rc = copy_from_user(kaddr, buffer, len % bsize_elem);
-		else
-			rc = copy_to_user(buffer, kaddr, len % bsize_elem);
-
-		kunmap(page);
-
-		sg->length = len % bsize_elem;
-	}
-
-	if (rc) {
-		pmcraid_err("failed to copy user data into sg list\n");
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
 /**
  * pmcraid_queuecommand_lck - Queue a mid-layer request
  * @scsi_cmd: scsi command struct
@@ -3454,365 +3336,6 @@ static int pmcraid_chr_fasync(int fd, struct file *filep, int mode)
 	return rc;
 }
 
-
-/**
- * pmcraid_build_passthrough_ioadls - builds SG elements for passthrough
- * commands sent over IOCTL interface
- *
- * @cmd       : pointer to struct pmcraid_cmd
- * @buflen    : length of the request buffer
- * @direction : data transfer direction
- *
- * Return value
- *  0 on success, non-zero error code on failure
- */
-static int pmcraid_build_passthrough_ioadls(
-	struct pmcraid_cmd *cmd,
-	int buflen,
-	int direction
-)
-{
-	struct pmcraid_sglist *sglist = NULL;
-	struct scatterlist *sg = NULL;
-	struct pmcraid_ioarcb *ioarcb = &cmd->ioa_cb->ioarcb;
-	struct pmcraid_ioadl_desc *ioadl;
-	int i;
-
-	sglist = pmcraid_alloc_sglist(buflen);
-
-	if (!sglist) {
-		pmcraid_err("can't allocate memory for passthrough SGls\n");
-		return -ENOMEM;
-	}
-
-	sglist->num_dma_sg = dma_map_sg(&cmd->drv_inst->pdev->dev,
-					sglist->scatterlist,
-					sglist->num_sg, direction);
-
-	if (!sglist->num_dma_sg || sglist->num_dma_sg > PMCRAID_MAX_IOADLS) {
-		dev_err(&cmd->drv_inst->pdev->dev,
-			"Failed to map passthrough buffer!\n");
-		pmcraid_free_sglist(sglist);
-		return -EIO;
-	}
-
-	cmd->sglist = sglist;
-	ioarcb->request_flags0 |= NO_LINK_DESCS;
-
-	ioadl = pmcraid_init_ioadls(cmd, sglist->num_dma_sg);
-
-	/* Initialize IOADL descriptor addresses */
-	for_each_sg(sglist->scatterlist, sg, sglist->num_dma_sg, i) {
-		ioadl[i].data_len = cpu_to_le32(sg_dma_len(sg));
-		ioadl[i].address = cpu_to_le64(sg_dma_address(sg));
-		ioadl[i].flags = 0;
-	}
-
-	/* setup the last descriptor */
-	ioadl[i - 1].flags = IOADL_FLAGS_LAST_DESC;
-
-	return 0;
-}
-
-
-/**
- * pmcraid_release_passthrough_ioadls - release passthrough ioadls
- *
- * @cmd: pointer to struct pmcraid_cmd for which ioadls were allocated
- * @buflen: size of the request buffer
- * @direction: data transfer direction
- *
- * Return value
- *  0 on success, non-zero error code on failure
- */
-static void pmcraid_release_passthrough_ioadls(
-	struct pmcraid_cmd *cmd,
-	int buflen,
-	int direction
-)
-{
-	struct pmcraid_sglist *sglist = cmd->sglist;
-
-	if (buflen > 0) {
-		dma_unmap_sg(&cmd->drv_inst->pdev->dev,
-			     sglist->scatterlist,
-			     sglist->num_sg,
-			     direction);
-		pmcraid_free_sglist(sglist);
-		cmd->sglist = NULL;
-	}
-}
-
-/**
- * pmcraid_ioctl_passthrough - handling passthrough IOCTL commands
- *
- * @pinstance: pointer to adapter instance structure
- * @ioctl_cmd: ioctl code
- * @buflen: unused
- * @arg: pointer to pmcraid_passthrough_buffer user buffer
- *
- * Return value
- *  0 on success, non-zero error code on failure
- */
-static long pmcraid_ioctl_passthrough(
-	struct pmcraid_instance *pinstance,
-	unsigned int ioctl_cmd,
-	unsigned int buflen,
-	void __user *arg
-)
-{
-	struct pmcraid_passthrough_ioctl_buffer *buffer;
-	struct pmcraid_ioarcb *ioarcb;
-	struct pmcraid_cmd *cmd;
-	struct pmcraid_cmd *cancel_cmd;
-	void __user *request_buffer;
-	unsigned long request_offset;
-	unsigned long lock_flags;
-	void __user *ioasa;
-	u32 ioasc;
-	int request_size;
-	int buffer_size;
-	u8 direction;
-	int rc = 0;
-
-	/* If IOA reset is in progress, wait 10 secs for reset to complete */
-	if (pinstance->ioa_reset_in_progress) {
-		rc = wait_event_interruptible_timeout(
-				pinstance->reset_wait_q,
-				!pinstance->ioa_reset_in_progress,
-				msecs_to_jiffies(10000));
-
-		if (!rc)
-			return -ETIMEDOUT;
-		else if (rc < 0)
-			return -ERESTARTSYS;
-	}
-
-	/* If adapter is not in operational state, return error */
-	if (pinstance->ioa_state != IOA_STATE_OPERATIONAL) {
-		pmcraid_err("IOA is not operational\n");
-		return -ENOTTY;
-	}
-
-	buffer_size = sizeof(struct pmcraid_passthrough_ioctl_buffer);
-	buffer = kmalloc(buffer_size, GFP_KERNEL);
-
-	if (!buffer) {
-		pmcraid_err("no memory for passthrough buffer\n");
-		return -ENOMEM;
-	}
-
-	request_offset =
-	    offsetof(struct pmcraid_passthrough_ioctl_buffer, request_buffer);
-
-	request_buffer = arg + request_offset;
-
-	rc = copy_from_user(buffer, arg,
-			     sizeof(struct pmcraid_passthrough_ioctl_buffer));
-
-	ioasa = arg + offsetof(struct pmcraid_passthrough_ioctl_buffer, ioasa);
-
-	if (rc) {
-		pmcraid_err("ioctl: can't copy passthrough buffer\n");
-		rc = -EFAULT;
-		goto out_free_buffer;
-	}
-
-	request_size = le32_to_cpu(buffer->ioarcb.data_transfer_length);
-
-	if (buffer->ioarcb.request_flags0 & TRANSFER_DIR_WRITE) {
-		direction = DMA_TO_DEVICE;
-	} else {
-		direction = DMA_FROM_DEVICE;
-	}
-
-	if (request_size < 0) {
-		rc = -EINVAL;
-		goto out_free_buffer;
-	}
-
-	/* check if we have any additional command parameters */
-	if (le16_to_cpu(buffer->ioarcb.add_cmd_param_length)
-	     > PMCRAID_ADD_CMD_PARAM_LEN) {
-		rc = -EINVAL;
-		goto out_free_buffer;
-	}
-
-	cmd = pmcraid_get_free_cmd(pinstance);
-
-	if (!cmd) {
-		pmcraid_err("free command block is not available\n");
-		rc = -ENOMEM;
-		goto out_free_buffer;
-	}
-
-	cmd->scsi_cmd = NULL;
-	ioarcb = &(cmd->ioa_cb->ioarcb);
-
-	/* Copy the user-provided IOARCB stuff field by field */
-	ioarcb->resource_handle = buffer->ioarcb.resource_handle;
-	ioarcb->data_transfer_length = buffer->ioarcb.data_transfer_length;
-	ioarcb->cmd_timeout = buffer->ioarcb.cmd_timeout;
-	ioarcb->request_type = buffer->ioarcb.request_type;
-	ioarcb->request_flags0 = buffer->ioarcb.request_flags0;
-	ioarcb->request_flags1 = buffer->ioarcb.request_flags1;
-	memcpy(ioarcb->cdb, buffer->ioarcb.cdb, PMCRAID_MAX_CDB_LEN);
-
-	if (buffer->ioarcb.add_cmd_param_length) {
-		ioarcb->add_cmd_param_length =
-			buffer->ioarcb.add_cmd_param_length;
-		ioarcb->add_cmd_param_offset =
-			buffer->ioarcb.add_cmd_param_offset;
-		memcpy(ioarcb->add_data.u.add_cmd_params,
-			buffer->ioarcb.add_data.u.add_cmd_params,
-			le16_to_cpu(buffer->ioarcb.add_cmd_param_length));
-	}
-
-	/* set hrrq number where the IOA should respond to. Note that all cmds
-	 * generated internally uses hrrq_id 0, exception to this is the cmd
-	 * block of scsi_cmd which is re-used (e.g. cancel/abort), which uses
-	 * hrrq_id assigned here in queuecommand
-	 */
-	ioarcb->hrrq_id = atomic_add_return(1, &(pinstance->last_message_id)) %
-			  pinstance->num_hrrq;
-
-	if (request_size) {
-		rc = pmcraid_build_passthrough_ioadls(cmd,
-						      request_size,
-						      direction);
-		if (rc) {
-			pmcraid_err("couldn't build passthrough ioadls\n");
-			goto out_free_cmd;
-		}
-	}
-
-	/* If data is being written into the device, copy the data from user
-	 * buffers
-	 */
-	if (direction == DMA_TO_DEVICE && request_size > 0) {
-		rc = pmcraid_copy_sglist(cmd->sglist,
-					 request_buffer,
-					 request_size,
-					 direction);
-		if (rc) {
-			pmcraid_err("failed to copy user buffer\n");
-			goto out_free_sglist;
-		}
-	}
-
-	/* passthrough ioctl is a blocking command so, put the user to sleep
-	 * until timeout. Note that a timeout value of 0 means, do timeout.
-	 */
-	cmd->cmd_done = pmcraid_internal_done;
-	init_completion(&cmd->wait_for_completion);
-	cmd->completion_req = 1;
-
-	pmcraid_info("command(%d) (CDB[0] = %x) for %x\n",
-		     le32_to_cpu(cmd->ioa_cb->ioarcb.response_handle) >> 2,
-		     cmd->ioa_cb->ioarcb.cdb[0],
-		     le32_to_cpu(cmd->ioa_cb->ioarcb.resource_handle));
-
-	spin_lock_irqsave(pinstance->host->host_lock, lock_flags);
-	_pmcraid_fire_command(cmd);
-	spin_unlock_irqrestore(pinstance->host->host_lock, lock_flags);
-
-	/* NOTE ! Remove the below line once abort_task is implemented
-	 * in firmware. This line disables ioctl command timeout handling logic
-	 * similar to IO command timeout handling, making ioctl commands to wait
-	 * until the command completion regardless of timeout value specified in
-	 * ioarcb
-	 */
-	buffer->ioarcb.cmd_timeout = 0;
-
-	/* If command timeout is specified put caller to wait till that time,
-	 * otherwise it would be blocking wait. If command gets timed out, it
-	 * will be aborted.
-	 */
-	if (buffer->ioarcb.cmd_timeout == 0) {
-		wait_for_completion(&cmd->wait_for_completion);
-	} else if (!wait_for_completion_timeout(
-			&cmd->wait_for_completion,
-			msecs_to_jiffies(le16_to_cpu(buffer->ioarcb.cmd_timeout) * 1000))) {
-
-		pmcraid_info("aborting cmd %d (CDB[0] = %x) due to timeout\n",
-			le32_to_cpu(cmd->ioa_cb->ioarcb.response_handle) >> 2,
-			cmd->ioa_cb->ioarcb.cdb[0]);
-
-		spin_lock_irqsave(pinstance->host->host_lock, lock_flags);
-		cancel_cmd = pmcraid_abort_cmd(cmd);
-		spin_unlock_irqrestore(pinstance->host->host_lock, lock_flags);
-
-		if (cancel_cmd) {
-			wait_for_completion(&cancel_cmd->wait_for_completion);
-			ioasc = le32_to_cpu(cancel_cmd->ioa_cb->ioasa.ioasc);
-			pmcraid_return_cmd(cancel_cmd);
-
-			/* if abort task couldn't find the command i.e it got
-			 * completed prior to aborting, return good completion.
-			 * if command got aborted successfully or there was IOA
-			 * reset due to abort task itself getting timedout then
-			 * return -ETIMEDOUT
-			 */
-			if (ioasc == PMCRAID_IOASC_IOA_WAS_RESET ||
-			    PMCRAID_IOASC_SENSE_KEY(ioasc) == 0x00) {
-				if (ioasc != PMCRAID_IOASC_GC_IOARCB_NOTFOUND)
-					rc = -ETIMEDOUT;
-				goto out_handle_response;
-			}
-		}
-
-		/* no command block for abort task or abort task failed to abort
-		 * the IOARCB, then wait for 150 more seconds and initiate reset
-		 * sequence after timeout
-		 */
-		if (!wait_for_completion_timeout(
-			&cmd->wait_for_completion,
-			msecs_to_jiffies(150 * 1000))) {
-			pmcraid_reset_bringup(cmd->drv_inst);
-			rc = -ETIMEDOUT;
-		}
-	}
-
-out_handle_response:
-	/* copy entire IOASA buffer and return IOCTL success.
-	 * If copying IOASA to user-buffer fails, return
-	 * EFAULT
-	 */
-	if (copy_to_user(ioasa, &cmd->ioa_cb->ioasa,
-		sizeof(struct pmcraid_ioasa))) {
-		pmcraid_err("failed to copy ioasa buffer to user\n");
-		rc = -EFAULT;
-	}
-
-	/* If the data transfer was from device, copy the data onto user
-	 * buffers
-	 */
-	else if (direction == DMA_FROM_DEVICE && request_size > 0) {
-		rc = pmcraid_copy_sglist(cmd->sglist,
-					 request_buffer,
-					 request_size,
-					 direction);
-		if (rc) {
-			pmcraid_err("failed to copy user buffer\n");
-			rc = -EFAULT;
-		}
-	}
-
-out_free_sglist:
-	pmcraid_release_passthrough_ioadls(cmd, request_size, direction);
-
-out_free_cmd:
-	pmcraid_return_cmd(cmd);
-
-out_free_buffer:
-	kfree(buffer);
-
-	return rc;
-}
-
-
-
-
 /**
  * pmcraid_ioctl_driver - ioctl handler for commands handled by driver itself
  *
@@ -3922,20 +3445,6 @@ static long pmcraid_chr_ioctl(
 
 	switch (_IOC_TYPE(cmd)) {
 
-	case PMCRAID_PASSTHROUGH_IOCTL:
-		/* If ioctl code is to download microcode, we need to block
-		 * mid-layer requests.
-		 */
-		if (cmd == PMCRAID_IOCTL_DOWNLOAD_MICROCODE)
-			scsi_block_requests(pinstance->host);
-
-		retval = pmcraid_ioctl_passthrough(pinstance, cmd,
-						   hdr->buffer_length, argp);
-
-		if (cmd == PMCRAID_IOCTL_DOWNLOAD_MICROCODE)
-			scsi_unblock_requests(pinstance->host);
-		break;
-
 	case PMCRAID_DRIVER_IOCTL:
 		arg += sizeof(struct pmcraid_ioctl_header);
 		retval = pmcraid_ioctl_driver(pinstance, cmd,
diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
index bbb75318f1e7..9f59930e8b4f 100644
--- a/drivers/scsi/pmcraid.h
+++ b/drivers/scsi/pmcraid.h
@@ -1022,41 +1022,16 @@ struct pmcraid_ioctl_header {
 
 #define PMCRAID_IOCTL_SIGNATURE      "PMCRAID"
 
-/*
- * pmcraid_passthrough_ioctl_buffer - structure given as argument to
- * passthrough(or firmware handled) IOCTL commands. Note that ioarcb requires
- * 32-byte alignment so, it is necessary to pack this structure to avoid any
- * holes between ioctl_header and passthrough buffer
- *
- * .ioactl_header : ioctl header
- * .ioarcb        : filled-up ioarcb buffer, driver always reads this buffer
- * .ioasa         : buffer for ioasa, driver fills this with IOASA from firmware
- * .request_buffer: The I/O buffer (flat), driver reads/writes to this based on
- *                  the transfer directions passed in ioarcb.flags0. Contents
- *                  of this buffer are valid only when ioarcb.data_transfer_len
- *                  is not zero.
- */
-struct pmcraid_passthrough_ioctl_buffer {
-	struct pmcraid_ioctl_header ioctl_header;
-	struct pmcraid_ioarcb ioarcb;
-	struct pmcraid_ioasa  ioasa;
-	u8  request_buffer[];
-} __attribute__ ((packed, aligned(PMCRAID_IOARCB_ALIGNMENT)));
-
 /*
  * keys to differentiate between driver handled IOCTLs and passthrough
  * IOCTLs passed to IOA. driver determines the ioctl type using macro
  * _IOC_TYPE
  */
 #define PMCRAID_DRIVER_IOCTL         'D'
-#define PMCRAID_PASSTHROUGH_IOCTL    'F'
 
 #define DRV_IOCTL(n, size) \
 	_IOC(_IOC_READ|_IOC_WRITE, PMCRAID_DRIVER_IOCTL, (n), (size))
 
-#define FMW_IOCTL(n, size) \
-	_IOC(_IOC_READ|_IOC_WRITE, PMCRAID_PASSTHROUGH_IOCTL,  (n), (size))
-
 /*
  * _ARGSIZE: macro that gives size of the argument type passed to an IOCTL cmd.
  * This is to facilitate applications avoiding un-necessary memory allocations.
@@ -1069,12 +1044,4 @@ struct pmcraid_passthrough_ioctl_buffer {
 #define PMCRAID_IOCTL_RESET_ADAPTER          \
 	DRV_IOCTL(5, sizeof(struct pmcraid_ioctl_header))
 
-/* passthrough/firmware handled commands */
-#define PMCRAID_IOCTL_PASSTHROUGH_COMMAND         \
-	FMW_IOCTL(1, sizeof(struct pmcraid_passthrough_ioctl_buffer))
-
-#define PMCRAID_IOCTL_DOWNLOAD_MICROCODE     \
-	FMW_IOCTL(2, sizeof(struct pmcraid_passthrough_ioctl_buffer))
-
-
 #endif /* _PMCRAID_H */
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index c607755cce00..ff78ef702f22 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7519,12 +7519,13 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct sdebug_defer *sd_dp;
 
 	sqp = sdebug_q_arr + queue_num;
-	qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
-	if (qc_idx >= sdebug_max_queue)
-		return 0;
 
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
+	qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
+	if (qc_idx >= sdebug_max_queue)
+		goto unlock;
+
 	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
 		if (first) {
 			first = false;
@@ -7589,6 +7590,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			break;
 	}
 
+unlock:
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 	if (num_entries > 0)
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index ff89de86545d..b02af340c2d3 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -30,7 +30,7 @@ static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
 	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
 
-	if (!rq->q->disk)
+	if (!rq->q || !rq->q->disk)
 		return NULL;
 	return rq->q->disk->disk_name;
 }
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f4e6c68ac99e..2ef78083f1ef 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -223,6 +223,8 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	int ret;
 	struct sbitmap sb_backup;
 
+	depth = min_t(unsigned int, depth, scsi_device_max_queue_depth(sdev));
+
 	/*
 	 * realloc if new shift is calculated, which is caused by setting
 	 * up one new default queue depth after calling ->slave_configure
@@ -245,6 +247,9 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 				scsi_device_max_queue_depth(sdev),
 				new_shift, GFP_KERNEL,
 				sdev->request_queue->node, false, true);
+	if (!ret)
+		sbitmap_resize(&sdev->budget_map, depth);
+
 	if (need_free) {
 		if (ret)
 			sdev->budget_map = sb_backup;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 226a50944c00..dc6872e352bd 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1384,10 +1384,6 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	if (IS_ENABLED(CONFIG_BLK_DEV_BSG)) {
 		sdev->bsg_dev = scsi_bsg_register_queue(sdev);
 		if (IS_ERR(sdev->bsg_dev)) {
-			/*
-			 * We're treating error on bsg register as non-fatal, so
-			 * pretend nothing went wrong.
-			 */
 			error = PTR_ERR(sdev->bsg_dev);
 			sdev_printk(KERN_INFO, sdev,
 				    "Failed to register bsg queue, errno=%d\n",
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..dc6e55761fd1 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3216,6 +3216,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 			sd_read_block_limits(sdkp);
 			sd_read_block_characteristics(sdkp);
 			sd_zbc_read_zones(sdkp, buffer);
+			sd_read_cpr(sdkp);
 		}
 
 		sd_print_capacity(sdkp, old_capacity);
@@ -3225,7 +3226,6 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
-		sd_read_cpr(sdkp);
 	}
 
 	/*
@@ -3475,6 +3475,7 @@ static int sd_probe(struct device *dev)
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		blk_cleanup_disk(gd);
 		goto out;
 	}
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 5ba9df334968..cbd92891a762 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -535,7 +535,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 
 	scsi_autopm_get_device(sdev);
 
-	if (ret != CDROMCLOSETRAY && ret != CDROMEJECT) {
+	if (cmd != CDROMCLOSETRAY && cmd != CDROMEJECT) {
 		ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
 		if (ret != -ENOSYS)
 			goto put;
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 0d2e950d0865..586c0e567ff9 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -957,18 +957,6 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
 	.deassert = ufs_qcom_reset_deassert,
 };
 
-#define	ANDROID_BOOT_DEV_MAX	30
-static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
-
-#ifndef MODULE
-static int __init get_android_boot_dev(char *str)
-{
-	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
-	return 1;
-}
-__setup("androidboot.bootdevice=", get_android_boot_dev);
-#endif
-
 /**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
@@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	struct resource *res;
 	struct ufs_clk_info *clki;
 
-	if (strlen(android_boot_dev) && strcmp(android_boot_dev, dev_name(dev)))
-		return -ENODEV;
-
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
 		err = -ENOMEM;
diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index f76692053ca1..e892b9feffb1 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -428,6 +428,12 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
 	return ufs_intel_common_init(hba);
 }
 
+static int ufs_intel_mtl_init(struct ufs_hba *hba)
+{
+	hba->caps |= UFSHCD_CAP_CRYPTO | UFSHCD_CAP_WB_EN;
+	return ufs_intel_common_init(hba);
+}
+
 static struct ufs_hba_variant_ops ufs_intel_cnl_hba_vops = {
 	.name                   = "intel-pci",
 	.init			= ufs_intel_common_init,
@@ -465,6 +471,16 @@ static struct ufs_hba_variant_ops ufs_intel_adl_hba_vops = {
 	.device_reset		= ufs_intel_device_reset,
 };
 
+static struct ufs_hba_variant_ops ufs_intel_mtl_hba_vops = {
+	.name                   = "intel-pci",
+	.init			= ufs_intel_mtl_init,
+	.exit			= ufs_intel_common_exit,
+	.hce_enable_notify	= ufs_intel_hce_enable_notify,
+	.link_startup_notify	= ufs_intel_link_startup_notify,
+	.resume			= ufs_intel_resume,
+	.device_reset		= ufs_intel_device_reset,
+};
+
 #ifdef CONFIG_PM_SLEEP
 static int ufshcd_pci_restore(struct device *dev)
 {
@@ -579,6 +595,7 @@ static const struct pci_device_id ufshcd_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x98FA), (kernel_ulong_t)&ufs_intel_lkf_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x51FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x54FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0x7E47), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 88c20f3608c2..94f545be183a 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -820,8 +820,6 @@ struct ufs_hba {
 	enum ufs_pm_level rpm_lvl;
 	/* Desired UFS power management level during system PM */
 	enum ufs_pm_level spm_lvl;
-	struct device_attribute rpm_lvl_attr;
-	struct device_attribute spm_lvl_attr;
 	int pm_op_in_progress;
 
 	/* Auto-Hibernate Idle Timer register value */
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index b2bec19022cd..81099b68bbfb 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -867,12 +867,6 @@ static struct ufshpb_region *ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
 	struct ufshpb_region *rgn, *victim_rgn = NULL;
 
 	list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn) {
-		if (!rgn) {
-			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-				"%s: no region allocated\n",
-				__func__);
-			return NULL;
-		}
 		if (ufshpb_check_srgns_issue_state(hpb, rgn))
 			continue;
 
@@ -888,6 +882,11 @@ static struct ufshpb_region *ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
 		break;
 	}
 
+	if (!victim_rgn)
+		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
+			"%s: no region allocated\n",
+			__func__);
+
 	return victim_rgn;
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0e6110da69e7..578c4b6d0f7d 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -988,7 +988,7 @@ static struct virtio_driver virtio_scsi_driver = {
 	.remove = virtscsi_remove,
 };
 
-static int __init init(void)
+static int __init virtio_scsi_init(void)
 {
 	int ret = -ENOMEM;
 
@@ -1020,14 +1020,14 @@ static int __init init(void)
 	return ret;
 }
 
-static void __exit fini(void)
+static void __exit virtio_scsi_fini(void)
 {
 	unregister_virtio_driver(&virtio_scsi_driver);
 	mempool_destroy(virtscsi_cmd_pool);
 	kmem_cache_destroy(virtscsi_cmd_cache);
 }
-module_init(init);
-module_exit(fini);
+module_init(virtio_scsi_init);
+module_exit(virtio_scsi_fini);
 
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio SCSI HBA driver");
diff --git a/drivers/scsi/zorro7xx.c b/drivers/scsi/zorro7xx.c
index 27b9e2baab1a..7acf9193a9e8 100644
--- a/drivers/scsi/zorro7xx.c
+++ b/drivers/scsi/zorro7xx.c
@@ -159,6 +159,8 @@ static void zorro7xx_remove_one(struct zorro_dev *z)
 	scsi_remove_host(host);
 
 	NCR_700_release(host);
+	if (host->base > 0x01000000)
+		iounmap(hostdata->base);
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	zorro_release_device(z);
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 95d4ca50a605..fd7267baa707 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1821,6 +1821,7 @@ static struct page *tcmu_try_get_data_page(struct tcmu_dev *udev, uint32_t dpi)
 	mutex_lock(&udev->cmdr_lock);
 	page = xa_load(&udev->data_pages, dpi);
 	if (likely(page)) {
+		get_page(page);
 		mutex_unlock(&udev->cmdr_lock);
 		return page;
 	}
@@ -1877,6 +1878,7 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 		/* For the vmalloc()ed cmd area pages */
 		addr = (void *)(unsigned long)info->mem[mi].addr + offset;
 		page = vmalloc_to_page(addr);
+		get_page(page);
 	} else {
 		uint32_t dpi;
 
@@ -1887,7 +1889,6 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 			return VM_FAULT_SIGBUS;
 	}
 
-	get_page(page);
 	vmf->page = page;
 	return 0;
 }

