Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80644B0080
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiBIWm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:42:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiBIWmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:42:31 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639CE02E45D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:42:29 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219IO5Ej014382;
        Wed, 9 Feb 2022 14:42:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=u+eAZNiCKCIeT8xnn50IgpVJYz9Cz9Yacj4xxNzogLU=;
 b=IVGUx48H29DfpvQBLy+vBtxGkFGtnnpFtwjlgMhnFHFmm1nciby6KrujPHRyBuM6Ci19
 dhUWnb8EalT2vQZH6PBtA3EsK6qi4k8ZfT4+EwNshfr74/902vXtqainWafXeuyScAwB
 yeMyIJvLGX7Sc0in8jEcm6BEd5rqrwGj1hSaqs9yfYabV4JdZcgUtvkK60Le563OtbeJ
 d43h+8VfQy3iL0c/zMy+0WzAmxf4PmoL1t6c2wT16pmZcLcrsPO5OEIhFJirrtoeeLZW
 1y29P8U+2pc4MB8Y5dAZ+CKaT6eVyfdYkEHhN8Kj2qHm8GX1XF096Fi8XafNBHP2SEG7 7Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e4am93bx1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:42:23 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 14:42:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 9 Feb 2022 14:42:19 -0800
Received: from rchin-dellt430.marvell.com (rchin-dellt430.marvell.com [10.85.176.141])
        by maili.marvell.com (Postfix) with ESMTP id 0F2093F70A4;
        Wed,  9 Feb 2022 14:42:19 -0800 (PST)
From:   Radha Mohan Chintakuntla <radhac@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        "Radha Mohan Chintakuntla" <radhac@marvell.com>
Subject: [PATCH 3/4] soc: octeontx2-sdp: Add FLR handling support
Date:   Wed, 9 Feb 2022 14:42:09 -0800
Message-ID: <20220209224210.153907-4-radhac@marvell.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20220209224210.153907-1-radhac@marvell.com>
References: <20220209224210.153907-1-radhac@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6vw5brJFqggaoPcn1DwsGfxGvgfB3xH6
X-Proofpoint-ORIG-GUID: 6vw5brJFqggaoPcn1DwsGfxGvgfB3xH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to enable VF FLR interrupts and handling them.

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
 drivers/soc/marvell/octeontx2-sdp/sdp.c | 208 ++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/soc/marvell/octeontx2-sdp/sdp.c b/drivers/soc/marvell/octeontx2-sdp/sdp.c
index fef063b6ce1f..ce1e8c424bff 100644
--- a/drivers/soc/marvell/octeontx2-sdp/sdp.c
+++ b/drivers/soc/marvell/octeontx2-sdp/sdp.c
@@ -615,6 +615,202 @@ static int sdp_check_pf_usable(struct sdp_dev *sdp)
 	return 0;
 }
 
+static void __handle_vf_flr(struct sdp_dev *sdp, struct rvu_vf *vf_ptr)
+{
+	if (vf_ptr->in_use) {
+		/* Using the same MBOX workqueue here, so that we can
+		 * synchronize with other VF->PF messages being forwarded to
+		 * AF
+		 */
+		vf_ptr->got_flr = true;
+		queue_work(sdp->pfvf_mbox_wq, &vf_ptr->pfvf_flr_work);
+	} else
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			   RVU_PF_VFTRPENDX(vf_ptr->vf_id / 64),
+			   BIT_ULL(vf_ptr->intr_idx));
+}
+
+static irqreturn_t sdp_pf_vf_flr_intr(int irq, void *arg)
+{
+	struct sdp_dev *sdp = (struct sdp_dev *)arg;
+	struct rvu_vf *vf_ptr;
+	int vf, i;
+	u64 intr;
+
+	/* Check which VF FLR has been raised and process accordingly */
+	for (i = 0; i < 2; i++) {
+		/* Read the interrupt bits */
+		intr = sdp_read64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INTX(i));
+
+		for (vf = i * 64; vf < sdp->num_vfs; vf++) {
+			vf_ptr = &sdp->vf_info[vf];
+			if (intr & (1ULL << vf_ptr->intr_idx)) {
+				/* Clear the interrupts */
+				sdp_write64(sdp, BLKADDR_RVUM, 0,
+					   RVU_PF_VFFLR_INTX(i),
+					   BIT_ULL(vf_ptr->intr_idx));
+				__handle_vf_flr(sdp, vf_ptr);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sdp_register_flr_irq(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int err, vec, i;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Register for VF FLR interrupts
+	 * There are 2 vectors starting at index 0x0
+	 */
+	for (vec = RVU_PF_INT_VEC_VFFLR0, i = 0;
+	     vec + i <= RVU_PF_INT_VEC_VFFLR1; i++) {
+		sprintf(&sdp->irq_names[(vec + i) * NAME_SIZE],
+			"SDP_PF%02d_VF_FLR%d", pdev->bus->number, i);
+		err = request_irq(pci_irq_vector(pdev, vec + i),
+				  sdp_pf_vf_flr_intr, 0,
+				  &sdp->irq_names[(vec + i) * NAME_SIZE], sdp);
+		if (err) {
+			dev_err(&pdev->dev,
+				"request_irq() failed for PFVF FLR intr %d\n",
+				vec);
+			goto reg_fail;
+		}
+		sdp->irq_allocated[vec + i] = true;
+	}
+
+	return 0;
+
+reg_fail:
+
+	return err;
+}
+
+static void enable_vf_flr_int(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int ena_bits, idx;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Clear any pending interrupts */
+	for (idx = 0; idx  < 2; idx++) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFTRPENDX(idx),
+			    ~0x0ULL);
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INTX(idx),
+			    ~0x0ULL);
+	}
+
+	/* Enable for FLR interrupts for VFs */
+	if (sdp->num_vfs > 64) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INT_ENA_W1SX(0),
+			    GENMASK_ULL(63, 0));
+		ena_bits = (sdp->num_vfs - 64) - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INT_ENA_W1SX(1),
+			   GENMASK_ULL(ena_bits, 0));
+	} else {
+		ena_bits = sdp->num_vfs - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INT_ENA_W1SX(0),
+			    GENMASK_ULL(ena_bits, 0));
+	}
+}
+
+static int send_flr_msg(struct otx2_mbox *mbox, int dev_id, int pcifunc)
+{
+	struct msg_req *req;
+
+	req = (struct msg_req *)
+		otx2_mbox_alloc_msg(mbox, dev_id, sizeof(*req));
+	if (req == NULL)
+		return -ENOMEM;
+
+	req->hdr.pcifunc = pcifunc;
+	req->hdr.id = MBOX_MSG_VF_FLR;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+
+	otx2_mbox_msg_send(mbox, 0);
+
+	return 0;
+}
+
+static void sdp_send_flr_msg(struct sdp_dev *sdp, struct rvu_vf *vf)
+{
+	int res, pcifunc;
+
+	pcifunc = (vf->sdp->pf << RVU_PFVF_PF_SHIFT) |
+		((vf->vf_id + 1) & RVU_PFVF_FUNC_MASK);
+
+	if (send_flr_msg(&sdp->afpf_mbox, 0, pcifunc) != 0) {
+		dev_err(&sdp->pdev->dev, "Sending FLR to AF failed\n");
+		return;
+	}
+
+	res = otx2_mbox_wait_for_rsp(&sdp->afpf_mbox, 0);
+	if (res == -EIO) {
+		dev_err(&sdp->pdev->dev, "RVU AF MBOX timeout.\n");
+	} else if (res) {
+		dev_err(&sdp->pdev->dev,
+			"RVU MBOX error: %d.\n", res);
+	}
+}
+
+static void sdp_pfvf_flr_handler(struct work_struct *work)
+{
+	struct rvu_vf *vf = container_of(work, struct rvu_vf, pfvf_flr_work);
+	struct sdp_dev *sdp = vf->sdp;
+	struct otx2_mbox *mbox;
+
+	mbox = &sdp->pfvf_mbox;
+
+	sdp_send_flr_msg(sdp, vf);
+
+	/* Disable interrupts from AF and wait for any pending
+	 * responses to be handled for this VF and then reset the
+	 * mailbox
+	 */
+	disable_af_mbox_int(sdp->pdev);
+	flush_workqueue(sdp->afpf_mbox_wq);
+	otx2_mbox_reset(mbox, vf->vf_id);
+	vf->in_use = false;
+	vf->got_flr = false;
+	enable_af_mbox_int(sdp->pdev);
+	sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFTRPENDX(vf->vf_id / 64),
+		   BIT_ULL(vf->intr_idx));
+}
+
+static void disable_vf_flr_int(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int ena_bits, idx;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Clear any pending interrupts */
+	for (idx = 0; idx  < 2; idx++) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFTRPENDX(idx),
+			    ~0x0ULL);
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INTX(idx),
+			    ~0x0ULL);
+	}
+
+	/* Disable the FLR interrupts for VFs */
+	if (sdp->num_vfs > 64) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INT_ENA_W1CX(0),
+			    GENMASK_ULL(63, 0));
+		ena_bits = (sdp->num_vfs - 64) - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INT_ENA_W1CX(1),
+			   GENMASK_ULL(ena_bits, 0));
+	} else {
+		ena_bits = sdp->num_vfs - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFFLR_INT_ENA_W1CX(0),
+			    GENMASK_ULL(ena_bits, 0));
+	}
+}
+
 static int sdp_alloc_irqs(struct pci_dev *pdev)
 {
 	struct sdp_dev *sdp;
@@ -817,6 +1013,7 @@ static int __sriov_disable(struct pci_dev *pdev)
 		return -EPERM;
 	}
 
+	disable_vf_flr_int(pdev);
 	disable_vf_mbox_int(pdev);
 
 	if (sdp->pfvf_mbox_wq) {
@@ -929,9 +1126,11 @@ static int __sriov_enable(struct pci_dev *pdev, int num_vfs)
 		vf_ptr->intr_idx = vf % 64;
 		INIT_WORK(&vf_ptr->mbox_wrk, sdp_pfvf_mbox_handler);
 		INIT_WORK(&vf_ptr->mbox_wrk_up, sdp_pfvf_mbox_handler_up);
+		INIT_WORK(&vf_ptr->pfvf_flr_work, sdp_pfvf_flr_handler);
 	}
 
 	enable_vf_mbox_int(pdev);
+	enable_vf_flr_int(pdev);
 
 	err = pci_enable_sriov(pdev, num_vfs);
 	if (err) {
@@ -942,6 +1141,7 @@ static int __sriov_enable(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 
 err_enable_sriov:
+	disable_vf_flr_int(pdev);
 	disable_vf_mbox_int(pdev);
 err_workqueue_alloc:
 	destroy_workqueue(sdp->pfvf_mbox_wq);
@@ -1061,6 +1261,13 @@ static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto reg_mbox_irq_failed;
 	}
 
+	if (sdp_register_flr_irq(pdev) != 0) {
+		dev_err(&pdev->dev,
+			"Unable to allocate FLR Interrupt vectors\n");
+		err = -ENODEV;
+		goto reg_flr_irq_failed;
+	}
+
 	enable_af_mbox_int(pdev);
 
 	if (sdp_get_pcifunc(sdp)) {
@@ -1084,6 +1291,7 @@ static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 get_pcifunc_failed:
 	disable_af_mbox_int(pdev);
+reg_flr_irq_failed:
 	sdp_afpf_mbox_term(pdev);
 reg_mbox_irq_failed:
 	sdp_free_irqs(pdev);
-- 
2.24.1

