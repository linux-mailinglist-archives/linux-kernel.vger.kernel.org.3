Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6124BCA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbiBSUET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 15:04:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbiBSUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 15:04:17 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357852F6;
        Sat, 19 Feb 2022 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1645301037;
        bh=vdEUtLDy0jay3RwrfnexOijRWOPdiQT2s7r1SOGKtGI=;
        h=Message-ID:Subject:From:To:Date:From;
        b=qvv9UJLujWhrHeLnd0WUnHyQED+tWln9aUTrV5SQJQkboU9fgQAqqBzQxwDV3i0xj
         GSbv+oxuRSDNCLHW4i50PyHYVu15y4OWq36F1clKe3esXzKxo8UShgPH0/NRsHA8zj
         TUIWP+VlX3FXs+hZfIt8rgsVqUmzrbY0BxsVc34E=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 924F31281204;
        Sat, 19 Feb 2022 15:03:57 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2jD3pt-RAHVW; Sat, 19 Feb 2022 15:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1645301037;
        bh=vdEUtLDy0jay3RwrfnexOijRWOPdiQT2s7r1SOGKtGI=;
        h=Message-ID:Subject:From:To:Date:From;
        b=qvv9UJLujWhrHeLnd0WUnHyQED+tWln9aUTrV5SQJQkboU9fgQAqqBzQxwDV3i0xj
         GSbv+oxuRSDNCLHW4i50PyHYVu15y4OWq36F1clKe3esXzKxo8UShgPH0/NRsHA8zj
         TUIWP+VlX3FXs+hZfIt8rgsVqUmzrbY0BxsVc34E=
Received: from jarvis.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 09FA212811BC;
        Sat, 19 Feb 2022 15:03:56 -0500 (EST)
Message-ID: <f6af0e7becb42dcf5f52f797c81550bda81c73fb.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.17-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Feb 2022 15:03:55 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fixes, all in drivers.  The ufs and qedi fixes are minor; the
lpfc one is a bit bigger because it involves adding a heuristic to
detect and deal with common but not standards compliant behaviour.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

James Smart (1):
      scsi: lpfc: Fix pt2pt NVMe PRLI reject LOGO loop

Jinyoung Choi (1):
      scsi: ufs: core: Fix divide by zero in ufshcd_map_queues()

Mike Christie (1):
      scsi: qedi: Fix ABBA deadlock in qedi_process_tmf_resp() and qedi_process_cmd_cleanup_resp()

And the diffstat:

 drivers/scsi/lpfc/lpfc.h           |  1 +
 drivers/scsi/lpfc/lpfc_attr.c      |  3 +++
 drivers/scsi/lpfc/lpfc_els.c       | 20 +++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_nportdisc.c |  5 +++--
 drivers/scsi/qedi/qedi_fw.c        |  6 ++----
 drivers/scsi/ufs/ufshcd.c          |  2 +-
 6 files changed, 29 insertions(+), 8 deletions(-)

With full diffs below.

James

---

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index a1e0a106c132..98cabe09c040 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -592,6 +592,7 @@ struct lpfc_vport {
 #define FC_VPORT_LOGO_RCVD      0x200    /* LOGO received on vport */
 #define FC_RSCN_DISCOVERY       0x400	 /* Auth all devices after RSCN */
 #define FC_LOGO_RCVD_DID_CHNG   0x800    /* FDISC on phys port detect DID chng*/
+#define FC_PT2PT_NO_NVME        0x1000   /* Don't send NVME PRLI */
 #define FC_SCSI_SCAN_TMO        0x4000	 /* scsi scan timer running */
 #define FC_ABORT_DISCOVERY      0x8000	 /* we want to abort discovery */
 #define FC_NDISC_ACTIVE         0x10000	 /* NPort discovery active */
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index bac78fbce8d6..fa8415259cb8 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1315,6 +1315,9 @@ lpfc_issue_lip(struct Scsi_Host *shost)
 	pmboxq->u.mb.mbxCommand = MBX_DOWN_LINK;
 	pmboxq->u.mb.mbxOwner = OWN_HOST;
 
+	if ((vport->fc_flag & FC_PT2PT) && (vport->fc_flag & FC_PT2PT_NO_NVME))
+		vport->fc_flag &= ~FC_PT2PT_NO_NVME;
+
 	mbxstatus = lpfc_sli_issue_mbox_wait(phba, pmboxq, LPFC_MBOX_TMO * 2);
 
 	if ((mbxstatus == MBX_SUCCESS) &&
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index db5ccae1b63d..f936833c9909 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1072,7 +1072,8 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		/* FLOGI failed, so there is no fabric */
 		spin_lock_irq(shost->host_lock);
-		vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
+		vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP |
+				    FC_PT2PT_NO_NVME);
 		spin_unlock_irq(shost->host_lock);
 
 		/* If private loop, then allow max outstanding els to be
@@ -4607,6 +4608,23 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Added for Vendor specifc support
 		 * Just keep retrying for these Rsn / Exp codes
 		 */
+		if ((vport->fc_flag & FC_PT2PT) &&
+		    cmd == ELS_CMD_NVMEPRLI) {
+			switch (stat.un.b.lsRjtRsnCode) {
+			case LSRJT_UNABLE_TPC:
+			case LSRJT_INVALID_CMD:
+			case LSRJT_LOGICAL_ERR:
+			case LSRJT_CMD_UNSUPPORTED:
+				lpfc_printf_vlog(vport, KERN_WARNING, LOG_ELS,
+						 "0168 NVME PRLI LS_RJT "
+						 "reason %x port doesn't "
+						 "support NVME, disabling NVME\n",
+						 stat.un.b.lsRjtRsnCode);
+				retry = 0;
+				vport->fc_flag |= FC_PT2PT_NO_NVME;
+				goto out_retry;
+			}
+		}
 		switch (stat.un.b.lsRjtRsnCode) {
 		case LSRJT_UNABLE_TPC:
 			/* The driver has a VALID PLOGI but the rport has
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 7d717a4ac14d..fdf5e777bf11 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -1961,8 +1961,9 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 			 * is configured try it.
 			 */
 			ndlp->nlp_fc4_type |= NLP_FC4_FCP;
-			if ((vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH) ||
-			    (vport->cfg_enable_fc4_type == LPFC_ENABLE_NVME)) {
+			if ((!(vport->fc_flag & FC_PT2PT_NO_NVME)) &&
+			    (vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH ||
+			    vport->cfg_enable_fc4_type == LPFC_ENABLE_NVME)) {
 				ndlp->nlp_fc4_type |= NLP_FC4_NVME;
 				/* We need to update the localport also */
 				lpfc_nvme_update_localport(vport);
diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 5916ed7662d5..4eb89aa4a39d 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -771,11 +771,10 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 			qedi_cmd->list_tmf_work = NULL;
 		}
 	}
+	spin_unlock_bh(&qedi_conn->tmf_work_lock);
 
-	if (!found) {
-		spin_unlock_bh(&qedi_conn->tmf_work_lock);
+	if (!found)
 		goto check_cleanup_reqs;
-	}
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 		  "TMF work, cqe->tid=0x%x, tmf flags=0x%x, cid=0x%x\n",
@@ -806,7 +805,6 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 	qedi_cmd->state = CLEANUP_RECV;
 unlock:
 	spin_unlock_bh(&conn->session->back_lock);
-	spin_unlock_bh(&qedi_conn->tmf_work_lock);
 	wake_up_interruptible(&qedi_conn->wait_queue);
 	return;
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 50b12d60dc1b..9349557b8a01 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2681,7 +2681,7 @@ static int ufshcd_map_queues(struct Scsi_Host *shost)
 			break;
 		case HCTX_TYPE_READ:
 			map->nr_queues = 0;
-			break;
+			continue;
 		default:
 			WARN_ON_ONCE(true);
 		}

