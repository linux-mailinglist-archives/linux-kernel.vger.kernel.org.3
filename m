Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FF547476
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiFKMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiFKMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:22:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0713DF3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1654950139;
        bh=r6CLFsvfzdtAfXTaMUczoT+Va3+qUZByjX5fPqGANvg=;
        h=Message-ID:Subject:From:To:Date:From;
        b=XX+rY5yGNtaQBVUv5xOgs27s4geOk0pUiSookzWRZjY928ddYmZLO9v2FYy0ymg3r
         lL/yAVrz7HAJDmRyippENwAtygrHqv+kqikNqLjTLc/oF7OYuSL7/F7PmbRMnLWY7f
         siOUHb13AbCCp7MOu6/nrtTuSgIfkT+QlvWPoUDA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2592D1281EC2;
        Sat, 11 Jun 2022 08:22:19 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ti3uSHAtplsI; Sat, 11 Jun 2022 08:22:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1654950138;
        bh=r6CLFsvfzdtAfXTaMUczoT+Va3+qUZByjX5fPqGANvg=;
        h=Message-ID:Subject:From:To:Date:From;
        b=kr+Ytn4cOPt72v48kXKvWnPWeC9oQxsvAWtkZ8XPxH9vQzexB8gO+K8sz7m12t/DZ
         kzEdFo23Z3V57/t2Joww6XlNfh5xfNFuLag5pv/DteD9g+G4GTu9oSHpl86cA8reLD
         Zeg6m5zwWj4U719cZULgTGUDcGyvxam0z7c1sWPY=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 74D151281E0F;
        Sat, 11 Jun 2022 08:22:18 -0400 (EDT)
Message-ID: <7373802fc26a9a41b2dd4f5c05f993f574365029.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.19-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 11 Jun 2022 08:22:17 -0400
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

13 driver and 1 core patch.  Nine of the driver patches are minor fixes
and reworks to lpfc and the rest are trivial and minor fixes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Chengguang Xu (2):
      scsi: pmcraid: Fix missing resource cleanup in error case
      scsi: ipr: Fix missing/incorrect resource cleanup in error case

Helge Deller (1):
      scsi: mpt3sas: Fix out-of-bounds compiler warning

James Smart (9):
      scsi: lpfc: Update lpfc version to 14.2.0.4
      scsi: lpfc: Allow reduced polling rate for nvme_admin_async_event cmd completion
      scsi: lpfc: Add more logging of cmd and cqe information for aborted NVMe cmds
      scsi: lpfc: Fix port stuck in bypassed state after LIP in PT2PT topology
      scsi: lpfc: Resolve NULL ptr dereference after an ELS LOGO is aborted
      scsi: lpfc: Address NULL pointer dereference after starget_to_rport()
      scsi: lpfc: Resolve some cleanup issues following SLI path refactoring
      scsi: lpfc: Resolve some cleanup issues following abort path refactoring
      scsi: lpfc: Correct BDE type for XMIT_SEQ64_WQE in lpfc_ct_reject_event()

Tyler Erickson (1):
      scsi: sd: Fix interpretation of VPD B9h length

Wentao Wang (1):
      scsi: vmw_pvscsi: Expand vcpuHint to 16 bits

And the diffstat:

 drivers/scsi/ipr.c                  |  4 +--
 drivers/scsi/lpfc/lpfc_crtn.h       |  4 +--
 drivers/scsi/lpfc/lpfc_ct.c         |  2 +-
 drivers/scsi/lpfc/lpfc_els.c        | 21 +++++++--------
 drivers/scsi/lpfc/lpfc_hw4.h        |  3 +++
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c  |  3 ++-
 drivers/scsi/lpfc/lpfc_nvme.c       | 52 ++++++++++++++++++++++++++++---------
 drivers/scsi/lpfc/lpfc_scsi.c       |  6 +++++
 drivers/scsi/lpfc/lpfc_sli.c        | 25 +++++++++---------
 drivers/scsi/lpfc/lpfc_version.h    |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c | 23 ++++++++--------
 drivers/scsi/pmcraid.c              |  2 +-
 drivers/scsi/sd.c                   |  2 +-
 drivers/scsi/vmw_pvscsi.h           |  4 +--
 15 files changed, 94 insertions(+), 61 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 256ec6d08c16..9d01a3e3c26a 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9795,7 +9795,7 @@ static int ipr_alloc_mem(struct ipr_ioa_cfg *ioa_cfg)
 					GFP_KERNEL);
 
 		if (!ioa_cfg->hrrq[i].host_rrq)  {
-			while (--i > 0)
+			while (--i >= 0)
 				dma_free_coherent(&pdev->dev,
 					sizeof(u32) * ioa_cfg->hrrq[i].size,
 					ioa_cfg->hrrq[i].host_rrq,
@@ -10068,7 +10068,7 @@ static int ipr_request_other_msi_irqs(struct ipr_ioa_cfg *ioa_cfg,
 			ioa_cfg->vectors_info[i].desc,
 			&ioa_cfg->hrrq[i]);
 		if (rc) {
-			while (--i >= 0)
+			while (--i > 0)
 				free_irq(pci_irq_vector(pdev, i),
 					&ioa_cfg->hrrq[i]);
 			return rc;
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index b1be0dd0337a..f5d74958b664 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -420,8 +420,6 @@ int lpfc_sli_issue_iocb_wait(struct lpfc_hba *, uint32_t,
 			     uint32_t);
 void lpfc_sli_abort_fcp_cmpl(struct lpfc_hba *, struct lpfc_iocbq *,
 			     struct lpfc_iocbq *);
-void lpfc_sli4_abort_fcp_cmpl(struct lpfc_hba *h, struct lpfc_iocbq *i,
-			      struct lpfc_wcqe_complete *w);
 
 void lpfc_sli_free_hbq(struct lpfc_hba *, struct hbq_dmabuf *);
 
@@ -630,7 +628,7 @@ void lpfc_nvmet_invalidate_host(struct lpfc_hba *phba,
 			struct lpfc_nodelist *ndlp);
 void lpfc_nvme_abort_fcreq_cmpl(struct lpfc_hba *phba,
 				struct lpfc_iocbq *cmdiocb,
-				struct lpfc_wcqe_complete *abts_cmpl);
+				struct lpfc_iocbq *rspiocb);
 void lpfc_create_multixri_pools(struct lpfc_hba *phba);
 void lpfc_create_destroy_pools(struct lpfc_hba *phba);
 void lpfc_move_xri_pvt_to_pbl(struct lpfc_hba *phba, u32 hwqid);
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 9d36b20fb878..13dfe285493d 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -197,7 +197,7 @@ lpfc_ct_reject_event(struct lpfc_nodelist *ndlp,
 	memset(bpl, 0, sizeof(struct ulp_bde64));
 	bpl->addrHigh = le32_to_cpu(putPaddrHigh(mp->phys));
 	bpl->addrLow = le32_to_cpu(putPaddrLow(mp->phys));
-	bpl->tus.f.bdeFlags = BUFF_TYPE_BLP_64;
+	bpl->tus.f.bdeFlags = BUFF_TYPE_BDE_64;
 	bpl->tus.f.bdeSize = (LPFC_CT_PREAMBLE - 4);
 	bpl->tus.w = le32_to_cpu(bpl->tus.w);
 
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 07f9a6e61e10..3fababb7c181 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -2998,10 +2998,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				 ndlp->nlp_DID, ulp_status,
 				 ulp_word4);
 
-		/* Call NLP_EVT_DEVICE_RM if link is down or LOGO is aborted */
 		if (lpfc_error_lost_link(ulp_status, ulp_word4)) {
-			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
-						NLP_EVT_DEVICE_RM);
 			skip_recovery = 1;
 			goto out;
 		}
@@ -3021,18 +3018,10 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		spin_unlock_irq(&ndlp->lock);
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					NLP_EVT_DEVICE_RM);
-		lpfc_els_free_iocb(phba, cmdiocb);
-		lpfc_nlp_put(ndlp);
-
-		/* Presume the node was released. */
-		return;
+		goto out_rsrc_free;
 	}
 
 out:
-	/* Driver is done with the IO.  */
-	lpfc_els_free_iocb(phba, cmdiocb);
-	lpfc_nlp_put(ndlp);
-
 	/* At this point, the LOGO processing is complete. NOTE: For a
 	 * pt2pt topology, we are assuming the NPortID will only change
 	 * on link up processing. For a LOGO / PLOGI initiated by the
@@ -3059,6 +3048,10 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				 ndlp->nlp_DID, ulp_status,
 				 ulp_word4, tmo,
 				 vport->num_disc_nodes);
+
+		lpfc_els_free_iocb(phba, cmdiocb);
+		lpfc_nlp_put(ndlp);
+
 		lpfc_disc_start(vport);
 		return;
 	}
@@ -3075,6 +3068,10 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					NLP_EVT_DEVICE_RM);
 	}
+out_rsrc_free:
+	/* Driver is done with the I/O. */
+	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 8511369d2cf8..f024415731ac 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -4487,6 +4487,9 @@ struct wqe_common {
 #define wqe_sup_SHIFT         6
 #define wqe_sup_MASK          0x00000001
 #define wqe_sup_WORD          word11
+#define wqe_ffrq_SHIFT         6
+#define wqe_ffrq_MASK          0x00000001
+#define wqe_ffrq_WORD          word11
 #define wqe_wqec_SHIFT        7
 #define wqe_wqec_MASK         0x00000001
 #define wqe_wqec_WORD         word11
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 93b94c64518d..750dd1e9f2cc 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12188,7 +12188,7 @@ lpfc_sli_enable_msi(struct lpfc_hba *phba)
 	rc = pci_enable_msi(phba->pcidev);
 	if (!rc)
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-				"0462 PCI enable MSI mode success.\n");
+				"0012 PCI enable MSI mode success.\n");
 	else {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0471 PCI enable MSI mode failed (%d)\n", rc);
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 639f86635127..b86ff9fcdf0c 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -834,7 +834,8 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		lpfc_nvmet_invalidate_host(phba, ndlp);
 
 	if (ndlp->nlp_DID == Fabric_DID) {
-		if (vport->port_state <= LPFC_FDISC)
+		if (vport->port_state <= LPFC_FDISC ||
+		    vport->fc_flag & FC_PT2PT)
 			goto out;
 		lpfc_linkdown_port(vport);
 		spin_lock_irq(shost->host_lock);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 335e90633933..cd10ee6482fc 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1065,25 +1065,37 @@ lpfc_nvme_io_cmd_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 			nCmd->rcv_rsplen = wcqe->parameter;
 			nCmd->status = 0;
 
+			/* Get the NVME cmd details for this unique error. */
+			cp = (struct nvme_fc_cmd_iu *)nCmd->cmdaddr;
+			ep = (struct nvme_fc_ersp_iu *)nCmd->rspaddr;
+
 			/* Check if this is really an ERSP */
 			if (nCmd->rcv_rsplen == LPFC_NVME_ERSP_LEN) {
 				lpfc_ncmd->status = IOSTAT_SUCCESS;
 				lpfc_ncmd->result = 0;
 
 				lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-					 "6084 NVME Completion ERSP: "
-					 "xri %x placed x%x\n",
-					 lpfc_ncmd->cur_iocbq.sli4_xritag,
-					 wcqe->total_data_placed);
+					"6084 NVME FCP_ERR ERSP: "
+					"xri %x placed x%x opcode x%x cmd_id "
+					"x%x cqe_status x%x\n",
+					lpfc_ncmd->cur_iocbq.sli4_xritag,
+					wcqe->total_data_placed,
+					cp->sqe.common.opcode,
+					cp->sqe.common.command_id,
+					ep->cqe.status);
 				break;
 			}
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "6081 NVME Completion Protocol Error: "
 					 "xri %x status x%x result x%x "
-					 "placed x%x\n",
+					 "placed x%x opcode x%x cmd_id x%x, "
+					 "cqe_status x%x\n",
 					 lpfc_ncmd->cur_iocbq.sli4_xritag,
 					 lpfc_ncmd->status, lpfc_ncmd->result,
-					 wcqe->total_data_placed);
+					 wcqe->total_data_placed,
+					 cp->sqe.common.opcode,
+					 cp->sqe.common.command_id,
+					 ep->cqe.status);
 			break;
 		case IOSTAT_LOCAL_REJECT:
 			/* Let fall through to set command final state. */
@@ -1195,7 +1207,8 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 {
 	struct lpfc_hba *phba = vport->phba;
 	struct nvmefc_fcp_req *nCmd = lpfc_ncmd->nvmeCmd;
-	struct lpfc_iocbq *pwqeq = &(lpfc_ncmd->cur_iocbq);
+	struct nvme_common_command *sqe;
+	struct lpfc_iocbq *pwqeq = &lpfc_ncmd->cur_iocbq;
 	union lpfc_wqe128 *wqe = &pwqeq->wqe;
 	uint32_t req_len;
 
@@ -1252,8 +1265,14 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 		cstat->control_requests++;
 	}
 
-	if (pnode->nlp_nvme_info & NLP_NVME_NSLER)
+	if (pnode->nlp_nvme_info & NLP_NVME_NSLER) {
 		bf_set(wqe_erp, &wqe->generic.wqe_com, 1);
+		sqe = &((struct nvme_fc_cmd_iu *)
+			nCmd->cmdaddr)->sqe.common;
+		if (sqe->opcode == nvme_admin_async_event)
+			bf_set(wqe_ffrq, &wqe->generic.wqe_com, 1);
+	}
+
 	/*
 	 * Finish initializing those WQE fields that are independent
 	 * of the nvme_cmnd request_buffer
@@ -1787,7 +1806,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
  * lpfc_nvme_abort_fcreq_cmpl - Complete an NVME FCP abort request.
  * @phba: Pointer to HBA context object
  * @cmdiocb: Pointer to command iocb object.
- * @abts_cmpl: Pointer to wcqe complete object.
+ * @rspiocb: Pointer to response iocb object.
  *
  * This is the callback function for any NVME FCP IO that was aborted.
  *
@@ -1796,8 +1815,10 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
  **/
 void
 lpfc_nvme_abort_fcreq_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
-			   struct lpfc_wcqe_complete *abts_cmpl)
+			   struct lpfc_iocbq *rspiocb)
 {
+	struct lpfc_wcqe_complete *abts_cmpl = &rspiocb->wcqe_cmpl;
+
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME,
 			"6145 ABORT_XRI_CN completing on rpi x%x "
 			"original iotag x%x, abort cmd iotag x%x "
@@ -1840,6 +1861,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	struct lpfc_nvme_fcpreq_priv *freqpriv;
 	unsigned long flags;
 	int ret_val;
+	struct nvme_fc_cmd_iu *cp;
 
 	/* Validate pointers. LLDD fault handling with transport does
 	 * have timing races.
@@ -1963,10 +1985,16 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 		return;
 	}
 
+	/*
+	 * Get Command Id from cmd to plug into response. This
+	 * code is not needed in the next NVME Transport drop.
+	 */
+	cp = (struct nvme_fc_cmd_iu *)lpfc_nbuf->nvmeCmd->cmdaddr;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_ABTS,
 			 "6138 Transport Abort NVME Request Issued for "
-			 "ox_id x%x\n",
-			 nvmereq_wqe->sli4_xritag);
+			 "ox_id x%x nvme opcode x%x nvme cmd_id x%x\n",
+			 nvmereq_wqe->sli4_xritag, cp->sqe.common.opcode,
+			 cp->sqe.common.command_id);
 	return;
 
 out_unlock:
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d43968203248..ba5e4016262e 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -6062,6 +6062,9 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 	int status;
 	u32 logit = LOG_FCP;
 
+	if (!rport)
+		return FAILED;
+
 	rdata = rport->dd_data;
 	if (!rdata || !rdata->pnode) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
@@ -6140,6 +6143,9 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 	unsigned long flags;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(waitq);
 
+	if (!rport)
+		return FAILED;
+
 	rdata = rport->dd_data;
 	if (!rdata || !rdata->pnode) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 6ed696c4602a..80ac3a051c19 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1930,7 +1930,7 @@ lpfc_issue_cmf_sync_wqe(struct lpfc_hba *phba, u32 ms, u64 total)
 	sync_buf = __lpfc_sli_get_iocbq(phba);
 	if (!sync_buf) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT,
-				"6213 No available WQEs for CMF_SYNC_WQE\n");
+				"6244 No available WQEs for CMF_SYNC_WQE\n");
 		ret_val = ENOMEM;
 		goto out_unlock;
 	}
@@ -3805,7 +3805,7 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 						set_job_ulpword4(cmdiocbp,
 								 IOERR_ABORT_REQUESTED);
 						/*
-						 * For SLI4, irsiocb contains
+						 * For SLI4, irspiocb contains
 						 * NO_XRI in sli_xritag, it
 						 * shall not affect releasing
 						 * sgl (xri) process.
@@ -3823,7 +3823,7 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 					}
 				}
 			}
-			(cmdiocbp->cmd_cmpl) (phba, cmdiocbp, saveq);
+			cmdiocbp->cmd_cmpl(phba, cmdiocbp, saveq);
 		} else
 			lpfc_sli_release_iocbq(phba, cmdiocbp);
 	} else {
@@ -4063,8 +4063,7 @@ lpfc_sli_handle_fast_ring_event(struct lpfc_hba *phba,
 				cmdiocbq->cmd_flag &= ~LPFC_DRIVER_ABORTED;
 			if (cmdiocbq->cmd_cmpl) {
 				spin_unlock_irqrestore(&phba->hbalock, iflag);
-				(cmdiocbq->cmd_cmpl)(phba, cmdiocbq,
-						      &rspiocbq);
+				cmdiocbq->cmd_cmpl(phba, cmdiocbq, &rspiocbq);
 				spin_lock_irqsave(&phba->hbalock, iflag);
 			}
 			break;
@@ -10288,7 +10287,7 @@ __lpfc_sli_issue_iocb_s3(struct lpfc_hba *phba, uint32_t ring_number,
  * @flag: Flag indicating if this command can be put into txq.
  *
  * __lpfc_sli_issue_fcp_io_s3 is wrapper function to invoke lockless func to
- * send  an iocb command to an HBA with SLI-4 interface spec.
+ * send  an iocb command to an HBA with SLI-3 interface spec.
  *
  * This function takes the hbalock before invoking the lockless version.
  * The function will return success after it successfully submit the wqe to
@@ -12740,7 +12739,7 @@ lpfc_sli_wake_iocb_wait(struct lpfc_hba *phba,
 		cmdiocbq->cmd_cmpl = cmdiocbq->wait_cmd_cmpl;
 		cmdiocbq->wait_cmd_cmpl = NULL;
 		if (cmdiocbq->cmd_cmpl)
-			(cmdiocbq->cmd_cmpl)(phba, cmdiocbq, NULL);
+			cmdiocbq->cmd_cmpl(phba, cmdiocbq, NULL);
 		else
 			lpfc_sli_release_iocbq(phba, cmdiocbq);
 		return;
@@ -12754,9 +12753,9 @@ lpfc_sli_wake_iocb_wait(struct lpfc_hba *phba,
 
 	/* Set the exchange busy flag for task management commands */
 	if ((cmdiocbq->cmd_flag & LPFC_IO_FCP) &&
-		!(cmdiocbq->cmd_flag & LPFC_IO_LIBDFC)) {
+	    !(cmdiocbq->cmd_flag & LPFC_IO_LIBDFC)) {
 		lpfc_cmd = container_of(cmdiocbq, struct lpfc_io_buf,
-			cur_iocbq);
+					cur_iocbq);
 		if (rspiocbq && (rspiocbq->cmd_flag & LPFC_EXCHANGE_BUSY))
 			lpfc_cmd->flags |= LPFC_SBUF_XBUSY;
 		else
@@ -13896,7 +13895,7 @@ void lpfc_sli4_els_xri_abort_event_proc(struct lpfc_hba *phba)
  * @irspiocbq: Pointer to work-queue completion queue entry.
  *
  * This routine handles an ELS work-queue completion event and construct
- * a pseudo response ELS IODBQ from the SLI4 ELS WCQE for the common
+ * a pseudo response ELS IOCBQ from the SLI4 ELS WCQE for the common
  * discovery engine to handle.
  *
  * Return: Pointer to the receive IOCBQ, NULL otherwise.
@@ -13940,7 +13939,7 @@ lpfc_sli4_els_preprocess_rspiocbq(struct lpfc_hba *phba,
 
 	if (bf_get(lpfc_wcqe_c_xb, wcqe)) {
 		spin_lock_irqsave(&phba->hbalock, iflags);
-		cmdiocbq->cmd_flag |= LPFC_EXCHANGE_BUSY;
+		irspiocbq->cmd_flag |= LPFC_EXCHANGE_BUSY;
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
 
@@ -14799,7 +14798,7 @@ lpfc_sli4_fp_handle_fcp_wcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 		/* Pass the cmd_iocb and the wcqe to the upper layer */
 		memcpy(&cmdiocbq->wcqe_cmpl, wcqe,
 		       sizeof(struct lpfc_wcqe_complete));
-		(cmdiocbq->cmd_cmpl)(phba, cmdiocbq, cmdiocbq);
+		cmdiocbq->cmd_cmpl(phba, cmdiocbq, cmdiocbq);
 	} else {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"0375 FCP cmdiocb not callback function "
@@ -18956,7 +18955,7 @@ lpfc_sli4_send_seq_to_ulp(struct lpfc_vport *vport,
 
 	/* Free iocb created in lpfc_prep_seq */
 	list_for_each_entry_safe(curr_iocb, next_iocb,
-		&iocbq->list, list) {
+				 &iocbq->list, list) {
 		list_del_init(&curr_iocb->list);
 		lpfc_sli_release_iocbq(phba, curr_iocb);
 	}
diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index 4fab79ed58ed..2ab6f7db64d8 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "14.2.0.3"
+#define LPFC_DRIVER_VERSION "14.2.0.4"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 37d46ae5c61d..9a1ae52bb621 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5369,6 +5369,7 @@ static int _base_assign_fw_reported_qd(struct MPT3SAS_ADAPTER *ioc)
 	Mpi2ConfigReply_t mpi_reply;
 	Mpi2SasIOUnitPage1_t *sas_iounit_pg1 = NULL;
 	Mpi26PCIeIOUnitPage1_t pcie_iounit_pg1;
+	u16 depth;
 	int sz;
 	int rc = 0;
 
@@ -5380,7 +5381,7 @@ static int _base_assign_fw_reported_qd(struct MPT3SAS_ADAPTER *ioc)
 		goto out;
 	/* sas iounit page 1 */
 	sz = offsetof(Mpi2SasIOUnitPage1_t, PhyData);
-	sas_iounit_pg1 = kzalloc(sz, GFP_KERNEL);
+	sas_iounit_pg1 = kzalloc(sizeof(Mpi2SasIOUnitPage1_t), GFP_KERNEL);
 	if (!sas_iounit_pg1) {
 		pr_err("%s: failure at %s:%d/%s()!\n",
 		    ioc->name, __FILE__, __LINE__, __func__);
@@ -5393,16 +5394,16 @@ static int _base_assign_fw_reported_qd(struct MPT3SAS_ADAPTER *ioc)
 		    ioc->name, __FILE__, __LINE__, __func__);
 		goto out;
 	}
-	ioc->max_wideport_qd =
-	    (le16_to_cpu(sas_iounit_pg1->SASWideMaxQueueDepth)) ?
-	    le16_to_cpu(sas_iounit_pg1->SASWideMaxQueueDepth) :
-	    MPT3SAS_SAS_QUEUE_DEPTH;
-	ioc->max_narrowport_qd =
-	    (le16_to_cpu(sas_iounit_pg1->SASNarrowMaxQueueDepth)) ?
-	    le16_to_cpu(sas_iounit_pg1->SASNarrowMaxQueueDepth) :
-	    MPT3SAS_SAS_QUEUE_DEPTH;
-	ioc->max_sata_qd = (sas_iounit_pg1->SATAMaxQDepth) ?
-	    sas_iounit_pg1->SATAMaxQDepth : MPT3SAS_SATA_QUEUE_DEPTH;
+
+	depth = le16_to_cpu(sas_iounit_pg1->SASWideMaxQueueDepth);
+	ioc->max_wideport_qd = (depth ? depth : MPT3SAS_SAS_QUEUE_DEPTH);
+
+	depth = le16_to_cpu(sas_iounit_pg1->SASNarrowMaxQueueDepth);
+	ioc->max_narrowport_qd = (depth ? depth : MPT3SAS_SAS_QUEUE_DEPTH);
+
+	depth = sas_iounit_pg1->SATAMaxQDepth;
+	ioc->max_sata_qd = (depth ? depth : MPT3SAS_SATA_QUEUE_DEPTH);
+
 	/* pcie iounit page 1 */
 	rc = mpt3sas_config_get_pcie_iounit_pg1(ioc, &mpi_reply,
 	    &pcie_iounit_pg1, sizeof(Mpi26PCIeIOUnitPage1_t));
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index bfce60183a6e..836ddc476764 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4031,7 +4031,7 @@ pmcraid_register_interrupt_handler(struct pmcraid_instance *pinstance)
 	return 0;
 
 out_unwind:
-	while (--i > 0)
+	while (--i >= 0)
 		free_irq(pci_irq_vector(pdev, i), &pinstance->hrrq_vector[i]);
 	pci_free_irq_vectors(pdev);
 	return rc;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 895b56c8f25e..a1a2ac09066f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3072,7 +3072,7 @@ static void sd_read_cpr(struct scsi_disk *sdkp)
 		goto out;
 
 	/* We must have at least a 64B header and one 32B range descriptor */
-	vpd_len = get_unaligned_be16(&buffer[2]) + 3;
+	vpd_len = get_unaligned_be16(&buffer[2]) + 4;
 	if (vpd_len > buf_len || vpd_len < 64 + 32 || (vpd_len & 31)) {
 		sd_printk(KERN_ERR, sdkp,
 			  "Invalid Concurrent Positioning Ranges VPD page\n");
diff --git a/drivers/scsi/vmw_pvscsi.h b/drivers/scsi/vmw_pvscsi.h
index 51a82f7803d3..9d16cf925483 100644
--- a/drivers/scsi/vmw_pvscsi.h
+++ b/drivers/scsi/vmw_pvscsi.h
@@ -331,8 +331,8 @@ struct PVSCSIRingReqDesc {
 	u8	tag;
 	u8	bus;
 	u8	target;
-	u8	vcpuHint;
-	u8	unused[59];
+	u16	vcpuHint;
+	u8	unused[58];
 } __packed;
 
 /*


