Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E55269C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383498AbiEMS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383566AbiEMS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:58:27 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4B6CAB6;
        Fri, 13 May 2022 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652468302;
        bh=Gm4rcTcYc28VXYvmDWwLQXWJgZTozo/KYQQ4R8gbqIU=;
        h=Message-ID:Subject:From:To:Date:From;
        b=iXuZYSJL7e/7J3suwK4wtD1hV5KnEQzgPRK13DbTi9aXiRyn8jBKXxslhil0Mr8um
         C0POie0O4o3ZobxvQXDuz5vg7/6lqhwurFTGBYFmv7obsgv78iNoixClw1VmljcJzs
         eB1SXd5xTgt3PRuDNsmc61oaXOL2I2fUpekegkRY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AF8C7128796B;
        Fri, 13 May 2022 14:58:22 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hNgfgQ_5ON96; Fri, 13 May 2022 14:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652468302;
        bh=Gm4rcTcYc28VXYvmDWwLQXWJgZTozo/KYQQ4R8gbqIU=;
        h=Message-ID:Subject:From:To:Date:From;
        b=iXuZYSJL7e/7J3suwK4wtD1hV5KnEQzgPRK13DbTi9aXiRyn8jBKXxslhil0Mr8um
         C0POie0O4o3ZobxvQXDuz5vg7/6lqhwurFTGBYFmv7obsgv78iNoixClw1VmljcJzs
         eB1SXd5xTgt3PRuDNsmc61oaXOL2I2fUpekegkRY=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 10A8D12878F7;
        Fri, 13 May 2022 14:58:21 -0400 (EDT)
Message-ID: <892647cabbe1e3b2134f4667c3edadd853d51602.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.18-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 13 May 2022 14:58:20 -0400
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

Four fixes, all in drivers.  These patches mosly fix error legs and
exceptional conditions (scsi_dh_alua, qla2xxx).  The lpfc fixes are for
coding issues with lpfc features.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Brian Bunker (1):
      scsi: scsi_dh_alua: Properly handle the ALUA transitioning state

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix missed DMA unmap for aborted commands

James Smart (2):
      scsi: lpfc: Correct BDE DMA address assignment for GEN_REQ_WQE
      scsi: lpfc: Fix split code for FLOGI on FCoE

And the diffstat:

 drivers/scsi/device_handler/scsi_dh_alua.c | 3 +--
 drivers/scsi/lpfc/lpfc_els.c               | 2 +-
 drivers/scsi/lpfc/lpfc_sli.c               | 6 +++---
 drivers/scsi/qla2xxx/qla_target.c          | 3 +++
 4 files changed, 8 insertions(+), 6 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 37d06f993b76..1d9be771f3ee 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1172,9 +1172,8 @@ static blk_status_t alua_prep_fn(struct scsi_device *sdev, struct request *req)
 	case SCSI_ACCESS_STATE_OPTIMAL:
 	case SCSI_ACCESS_STATE_ACTIVE:
 	case SCSI_ACCESS_STATE_LBA:
-		return BLK_STS_OK;
 	case SCSI_ACCESS_STATE_TRANSITIONING:
-		return BLK_STS_AGAIN;
+		return BLK_STS_OK;
 	default:
 		req->rq_flags |= RQF_QUIET;
 		return BLK_STS_IOERR;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index ef6e8cd8c26a..872a26376ccb 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1330,7 +1330,7 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) ==
 		    LPFC_SLI_INTF_IF_TYPE_0) {
 			/* FLOGI needs to be 3 for WQE FCFI */
-			ct = ((SLI4_CT_FCFI >> 1) & 1) | (SLI4_CT_FCFI & 1);
+			ct = SLI4_CT_FCFI;
 			bf_set(wqe_ct, &wqe->els_req.wqe_com, ct);
 
 			/* Set the fcfi to the fcfi we registered with */
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index bda2a7ba4e77..6adaf79e67cc 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -10720,10 +10720,10 @@ __lpfc_sli_prep_gen_req_s4(struct lpfc_iocbq *cmdiocbq, struct lpfc_dmabuf *bmp,
 
 	/* Words 0 - 2 */
 	bde = (struct ulp_bde64_le *)&cmdwqe->generic.bde;
-	bde->addr_low = cpu_to_le32(putPaddrLow(bmp->phys));
-	bde->addr_high = cpu_to_le32(putPaddrHigh(bmp->phys));
+	bde->addr_low = bpl->addr_low;
+	bde->addr_high = bpl->addr_high;
 	bde->type_size = cpu_to_le32(xmit_len);
-	bde->type_size |= cpu_to_le32(ULP_BDE64_TYPE_BLP_64);
+	bde->type_size |= cpu_to_le32(ULP_BDE64_TYPE_BDE_64);
 
 	/* Word 3 */
 	cmdwqe->gen_req.request_payload_len = xmit_len;
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 85dbf81f3204..6dfcfd8e7337 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3826,6 +3826,9 @@ int qlt_abort_cmd(struct qla_tgt_cmd *cmd)
 
 	spin_lock_irqsave(&cmd->cmd_lock, flags);
 	if (cmd->aborted) {
+		if (cmd->sg_mapped)
+			qlt_unmap_sg(vha, cmd);
+
 		spin_unlock_irqrestore(&cmd->cmd_lock, flags);
 		/*
 		 * It's normal to see 2 calls in this path:

