Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4134B0112
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiBIXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:16:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiBIXPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:15:22 -0500
X-Greylist: delayed 1946 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 15:14:58 PST
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BFCE0536EC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:14:58 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219KEmBO013146;
        Wed, 9 Feb 2022 14:42:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=pjqjXnoWw716hxwQyfAnuGxeaNUWvsbakPWMCUb7fnQ=;
 b=eIp20DHVr2VO7MK8aDPPd6oC6jI4v96IipwfkPhb7eRnuSAjLfdjIGHspl5g0s+DiR+d
 x9tquuTQttBhA+iSPJrGRjg8GnTArgGkTPpobEdVb7lvFAGYYVCCPN/iBKyMV1mGXHwC
 bcln38Zl9dyUn7hO/avFvOpNGwsdCKTQspZ8mWUCV2npv3wtu3C20iqo0iYgSU7Afkkm
 OY1hnuIMEEmU9iqPoAyyqqh7py9CLR5fQjeevFAwoo2sXzBpT7IhGKobXyb8jCm11P0r
 d+YYAIsmhDa+EKGHCJkktFYKLgDTi9RNeTCe01GZhTzHvsJaeClsSqGyM8w+LkuCO5Sc RA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3e4cpj2tkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:42:20 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 14:42:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 14:42:18 -0800
Received: from rchin-dellt430.marvell.com (rchin-dellt430.marvell.com [10.85.176.141])
        by maili.marvell.com (Postfix) with ESMTP id C860E3F709C;
        Wed,  9 Feb 2022 14:42:18 -0800 (PST)
From:   Radha Mohan Chintakuntla <radhac@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        "Radha Mohan Chintakuntla" <radhac@marvell.com>
Subject: [PATCH 2/4] soc: octeontx2-sdp: Add mailbox support
Date:   Wed, 9 Feb 2022 14:42:08 -0800
Message-ID: <20220209224210.153907-3-radhac@marvell.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20220209224210.153907-1-radhac@marvell.com>
References: <20220209224210.153907-1-radhac@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: udlJOXs9gcNXcWPP8lGOjdhgb6XtnCuN
X-Proofpoint-ORIG-GUID: udlJOXs9gcNXcWPP8lGOjdhgb6XtnCuN
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

Added mailbox support to communicate between VFs to PF and between PF to
AF (Administrative Function).

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
 drivers/soc/marvell/octeontx2-sdp/sdp.c | 799 ++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2-sdp/sdp.h |  22 +-
 2 files changed, 820 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/marvell/octeontx2-sdp/sdp.c b/drivers/soc/marvell/octeontx2-sdp/sdp.c
index dda85b5c0264..fef063b6ce1f 100644
--- a/drivers/soc/marvell/octeontx2-sdp/sdp.c
+++ b/drivers/soc/marvell/octeontx2-sdp/sdp.c
@@ -33,6 +33,9 @@
 
 #define SDP_PPAIR_THOLD 0x400
 
+static spinlock_t sdp_lst_lock;
+LIST_HEAD(sdp_dev_lst_head);
+
 static void
 sdp_write64(struct sdp_dev *rvu, u64 b, u64 s, u64 o, u64 v)
 {
@@ -44,6 +47,555 @@ static u64 sdp_read64(struct sdp_dev *rvu, u64 b, u64 s, u64 o)
 	return readq(rvu->bar2 + ((b << 20) | (s << 12) | o));
 }
 
+static void enable_af_mbox_int(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+
+	sdp = pci_get_drvdata(pdev);
+	/* Clear interrupt if any */
+	sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_INT, 0x1ULL);
+
+	/* Now Enable AF-PF interrupt */
+	sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_INT_ENA_W1S, 0x1ULL);
+}
+
+static void disable_af_mbox_int(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+
+	sdp = pci_get_drvdata(pdev);
+	/* Clear interrupt if any */
+	sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_INT, 0x1ULL);
+
+	/* Now Disable AF-PF interrupt */
+	sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_INT_ENA_W1C, 0x1ULL);
+}
+
+static int
+forward_to_mbox(struct sdp_dev *sdp, struct otx2_mbox *mbox, int devid,
+		struct mbox_msghdr *req, int size, const char *mstr)
+{
+	struct mbox_msghdr *msg;
+	int res = 0;
+
+	msg = otx2_mbox_alloc_msg(mbox, devid, size);
+	if (msg == NULL)
+		return -ENOMEM;
+
+	memcpy((uint8_t *)msg + sizeof(struct mbox_msghdr),
+	       (uint8_t *)req + sizeof(struct mbox_msghdr), size);
+	msg->id = req->id;
+	msg->pcifunc = req->pcifunc;
+	msg->sig = req->sig;
+	msg->ver = req->ver;
+
+	otx2_mbox_msg_send(mbox, devid);
+	res = otx2_mbox_wait_for_rsp(mbox, devid);
+	if (res == -EIO) {
+		dev_err(&sdp->pdev->dev, "RVU %s MBOX timeout.\n", mstr);
+		goto err;
+	} else if (res) {
+		dev_err(&sdp->pdev->dev,
+			"RVU %s MBOX error: %d.\n", mstr, res);
+		res = -EFAULT;
+		goto err;
+	}
+
+	return 0;
+err:
+	return res;
+}
+
+static int
+handle_af_req(struct sdp_dev *sdp, struct rvu_vf *vf, struct mbox_msghdr *req,
+	      int size)
+{
+	/* We expect a request here */
+	if (req->sig != OTX2_MBOX_REQ_SIG) {
+		dev_err(&sdp->pdev->dev,
+			"UP MBOX msg with wrong signature %x, ID 0x%x\n",
+			req->sig, req->id);
+		return -EINVAL;
+	}
+
+	/* If handling notifs in PF is required,add a switch-case here. */
+	return forward_to_mbox(sdp, &sdp->pfvf_mbox_up, vf->vf_id, req, size,
+			       "VF");
+}
+
+
+static void sdp_afpf_mbox_handler_up(struct work_struct *work)
+{
+	struct sdp_dev *sdp = container_of(work, struct sdp_dev, mbox_wrk_up);
+	struct otx2_mbox *mbox = &sdp->afpf_mbox_up;
+	struct otx2_mbox_dev *mdev = mbox->dev;
+	struct mbox_hdr *req_hdr;
+	struct mbox_msghdr *msg;
+	int offset, id, err;
+	struct rvu_vf *vf;
+
+	/* sync with mbox memory region */
+	smp_rmb();
+
+	/* Process received mbox messages */
+	req_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	offset = ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
+	for (id = 0; id < req_hdr->num_msgs; id++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start +
+					     offset);
+
+		if ((msg->pcifunc >> RVU_PFVF_PF_SHIFT) != sdp->pf ||
+		    (msg->pcifunc & RVU_PFVF_FUNC_MASK) <= sdp->num_vfs)
+			err = -EINVAL;
+		else {
+			vf = &sdp->vf_info[msg->pcifunc & RVU_PFVF_FUNC_MASK];
+			err = handle_af_req(sdp, vf, msg,
+					    msg->next_msgoff - offset);
+		}
+		if (err)
+			otx2_reply_invalid_msg(mbox, 0, msg->pcifunc, msg->id);
+		offset = msg->next_msgoff;
+	}
+
+	otx2_mbox_msg_send(mbox, 0);
+}
+
+static void sdp_afpf_mbox_handler(struct work_struct *work)
+{
+	struct nix_lf_alloc_rsp *alloc_rsp;
+	struct otx2_mbox *af_mbx, *vf_mbx;
+	struct mbox_msghdr *msg, *fwd;
+	struct free_rsrcs_rsp *rsp;
+	int offset, i, vf_id, size;
+	struct mbox_hdr *rsp_hdr;
+	struct sdp_dev *sdp;
+	struct rvu_vf *vf;
+
+	/* Read latest mbox data */
+	smp_rmb();
+
+	sdp = container_of(work, struct sdp_dev, mbox_wrk);
+	af_mbx = &sdp->afpf_mbox;
+	vf_mbx = &sdp->pfvf_mbox;
+	rsp_hdr = (struct mbox_hdr *)(af_mbx->dev->mbase + af_mbx->rx_start);
+	if (rsp_hdr->num_msgs == 0)
+		return;
+	offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+
+	for (i = 0; i < rsp_hdr->num_msgs; i++) {
+		msg = (struct mbox_msghdr *)(af_mbx->dev->mbase +
+					     af_mbx->rx_start + offset);
+		size = msg->next_msgoff - offset;
+
+		if (msg->id >= MBOX_MSG_MAX) {
+			dev_err(&sdp->pdev->dev,
+				"MBOX msg with unknown ID 0x%x\n", msg->id);
+			goto end;
+		}
+
+		if (msg->sig != OTX2_MBOX_RSP_SIG) {
+			dev_err(&sdp->pdev->dev,
+				"MBOX msg with wrong signature %x, ID 0x%x\n",
+				msg->sig, msg->id);
+			goto end;
+		}
+
+		vf_id = (msg->pcifunc & RVU_PFVF_FUNC_MASK);
+
+		if (msg->id == MBOX_MSG_NIX_LF_ALLOC) {
+			alloc_rsp = (struct nix_lf_alloc_rsp *)msg;
+			if (vf_id == 1)
+				alloc_rsp->rx_chan_cnt = sdp->info.vf_rings[0];
+			else
+				alloc_rsp->rx_chan_cnt = sdp->info.vf_rings[1];
+			alloc_rsp->tx_chan_cnt = alloc_rsp->rx_chan_cnt;
+		}
+
+		if (vf_id > 0) {
+			if (vf_id > sdp->num_vfs) {
+				dev_err(&sdp->pdev->dev,
+					"MBOX msg to unknown VF: %d >= %d\n",
+					vf_id, sdp->num_vfs);
+				goto end;
+			}
+			vf = &sdp->vf_info[vf_id - 1];
+			/* Ignore stale responses and VFs in FLR. */
+			if (!vf->in_use || vf->got_flr)
+				goto end;
+			fwd = otx2_mbox_alloc_msg(vf_mbx, vf_id - 1, size);
+			if (!fwd) {
+				dev_err(&sdp->pdev->dev,
+					"Forwarding to VF%d failed.\n", vf_id);
+				goto end;
+			}
+			memcpy((uint8_t *)fwd + sizeof(struct mbox_msghdr),
+			       (uint8_t *)msg + sizeof(struct mbox_msghdr),
+			       size);
+			fwd->id = msg->id;
+			fwd->pcifunc = msg->pcifunc;
+			fwd->sig = msg->sig;
+			fwd->ver = msg->ver;
+			fwd->rc = msg->rc;
+		} else {
+			if (msg->ver < OTX2_MBOX_VERSION) {
+				dev_err(&sdp->pdev->dev,
+					"MBOX msg with version %04x != %04x\n",
+					msg->ver, OTX2_MBOX_VERSION);
+				goto end;
+			}
+
+			switch (msg->id) {
+			case MBOX_MSG_READY:
+				sdp->pf = (msg->pcifunc >> RVU_PFVF_PF_SHIFT) &
+					 RVU_PFVF_PF_MASK;
+				break;
+			case MBOX_MSG_FREE_RSRC_CNT:
+				rsp = (struct free_rsrcs_rsp *)msg;
+				memcpy(&sdp->limits, msg, sizeof(*rsp));
+				break;
+			case MBOX_MSG_SET_SDP_CHAN_INFO:
+				/* Nothing to do */
+				break;
+			case MBOX_MSG_GET_SDP_CHAN_INFO:
+				/* Nothing to do */
+				break;
+			default:
+				dev_err(&sdp->pdev->dev,
+					"Unsupported msg %d received.\n",
+					msg->id);
+				break;
+			}
+		}
+end:
+		offset = msg->next_msgoff;
+		af_mbx->dev->msgs_acked++;
+	}
+	otx2_mbox_reset(af_mbx, 0);
+}
+
+static int
+reply_free_rsrc_cnt(struct sdp_dev *sdp, struct rvu_vf *vf,
+		    struct mbox_msghdr *req, int size)
+{
+	struct free_rsrcs_rsp *rsp;
+
+	rsp = (struct free_rsrcs_rsp *)otx2_mbox_alloc_msg(&sdp->pfvf_mbox,
+							   vf->vf_id,
+							   sizeof(*rsp));
+	if (rsp == NULL)
+		return -ENOMEM;
+
+	rsp->hdr.id = MBOX_MSG_FREE_RSRC_CNT;
+	rsp->hdr.pcifunc = req->pcifunc;
+	rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
+	return 0;
+}
+
+static int
+handle_vf_req(struct sdp_dev *sdp, struct rvu_vf *vf, struct mbox_msghdr *req,
+	      int size)
+{
+	int err = 0, chan_idx, chan_diff, reg_off = 0, vf_id;
+	uint64_t en_bp;
+	u16 chan_base;
+	u8 chan_cnt;
+
+	/* Check if valid, if not reply with a invalid msg */
+	if (req->sig != OTX2_MBOX_REQ_SIG) {
+		dev_err(&sdp->pdev->dev,
+			"VF MBOX msg with wrong signature %x, ID 0x%x\n",
+			req->sig, req->id);
+		return -EINVAL;
+	}
+
+	switch (req->id) {
+	case MBOX_MSG_READY:
+		if (req->ver < OTX2_MBOX_VERSION) {
+			dev_err(&sdp->pdev->dev,
+				"VF MBOX msg with version %04x != %04x\n",
+				req->ver, OTX2_MBOX_VERSION);
+			return -EINVAL;
+		}
+		vf->in_use = true;
+		err = forward_to_mbox(sdp, &sdp->afpf_mbox, 0, req, size, "AF");
+		break;
+	case MBOX_MSG_FREE_RSRC_CNT:
+		if (req->ver < OTX2_MBOX_VERSION) {
+			dev_err(&sdp->pdev->dev,
+				"VF MBOX msg with version %04x != %04x\n",
+				req->ver, OTX2_MBOX_VERSION);
+			return -EINVAL;
+		}
+		err = reply_free_rsrc_cnt(sdp, vf, req, size);
+		break;
+	case MBOX_MSG_ATTACH_RESOURCES:
+		if (req->ver < OTX2_MBOX_VERSION) {
+			dev_err(&sdp->pdev->dev,
+				"VF MBOX msg with version %04x != %04x\n",
+				req->ver, OTX2_MBOX_VERSION);
+			return -EINVAL;
+		}
+		err = forward_to_mbox(sdp, &sdp->afpf_mbox, 0, req, size, "AF");
+		break;
+	case MBOX_MSG_NIX_LF_ALLOC:
+		chan_base = sdp->chan_base + sdp->info.num_pf_rings;
+		for (vf_id = 0; vf_id < vf->vf_id; vf_id++)
+			chan_base += sdp->info.vf_rings[vf_id];
+		chan_cnt = sdp->info.vf_rings[vf->vf_id];
+		for (chan_idx = 0; chan_idx < chan_cnt; chan_idx++) {
+			chan_diff = chan_base + chan_idx - sdp->chan_base;
+			reg_off = 0;
+			while (chan_diff > 63) {
+				reg_off += 1;
+				chan_diff -= 64;
+			}
+
+			en_bp = readq(sdp->sdp_base +
+				      SDPX_OUT_BP_ENX_W1S(reg_off));
+			en_bp |= (1ULL << chan_diff);
+			writeq(en_bp, sdp->sdp_base +
+			       SDPX_OUT_BP_ENX_W1S(reg_off));
+		}
+		fallthrough;
+	default:
+		err = forward_to_mbox(sdp, &sdp->afpf_mbox, 0, req, size, "AF");
+		break;
+	}
+
+	return err;
+}
+
+static irqreturn_t sdp_af_pf_mbox_intr(int irq, void *arg)
+{
+	struct sdp_dev *sdp = (struct sdp_dev *)arg;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+
+	/* Read latest mbox data */
+	smp_rmb();
+
+	mbox = &sdp->afpf_mbox;
+	mdev = &mbox->dev[0];
+	hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	/* Handle PF => AF channel response */
+	if (hdr->num_msgs)
+		queue_work(sdp->afpf_mbox_wq, &sdp->mbox_wrk);
+
+	mbox = &sdp->afpf_mbox_up;
+	mdev = &mbox->dev[0];
+	hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	/* Handle AF => PF request */
+	if (hdr->num_msgs)
+		queue_work(sdp->afpf_mbox_wq, &sdp->mbox_wrk_up);
+
+	/* Clear and ack the interrupt */
+	sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_INT, 0x1ULL);
+
+	return IRQ_HANDLED;
+}
+
+static void sdp_pfvf_mbox_handler_up(struct work_struct *work)
+{
+	struct otx2_mbox *af_mbx, *vf_mbx;
+	struct mbox_msghdr *msg, *fwd;
+	struct mbox_hdr *rsp_hdr;
+	struct sdp_dev *sdp;
+	int offset, i, size;
+	struct rvu_vf *vf;
+
+	/* Read latest mbox data */
+	smp_rmb();
+
+	vf = container_of(work, struct rvu_vf, mbox_wrk_up);
+	sdp = vf->sdp;
+	af_mbx = &sdp->afpf_mbox;
+	vf_mbx = &sdp->pfvf_mbox;
+	rsp_hdr = (struct mbox_hdr *)(vf_mbx->dev[vf->vf_id].mbase +
+				      vf_mbx->rx_start);
+	if (rsp_hdr->num_msgs == 0)
+		return;
+	offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+
+	for (i = 0; i < rsp_hdr->num_msgs; i++) {
+		msg = (struct mbox_msghdr *)(vf_mbx->dev->mbase +
+					     vf_mbx->rx_start + offset);
+		size = msg->next_msgoff - offset;
+
+		if (msg->sig != OTX2_MBOX_RSP_SIG) {
+			dev_err(&sdp->pdev->dev,
+				"UP MBOX msg with wrong signature %x, ID 0x%x\n",
+				msg->sig, msg->id);
+			goto end;
+		}
+
+		/* override message value with actual values */
+		msg->pcifunc = (sdp->pf << RVU_PFVF_PF_SHIFT) | vf->vf_id;
+
+		fwd = otx2_mbox_alloc_msg(af_mbx, 0, size);
+		if (!fwd) {
+			dev_err(&sdp->pdev->dev,
+				"UP Forwarding from VF%d to AF failed.\n",
+				vf->vf_id);
+			goto end;
+		}
+		memcpy((uint8_t *)fwd + sizeof(struct mbox_msghdr),
+			(uint8_t *)msg + sizeof(struct mbox_msghdr),
+			size);
+		fwd->id = msg->id;
+		fwd->pcifunc = msg->pcifunc;
+		fwd->sig = msg->sig;
+		fwd->ver = msg->ver;
+		fwd->rc = msg->rc;
+end:
+		offset = msg->next_msgoff;
+		vf_mbx->dev->msgs_acked++;
+	}
+	otx2_mbox_reset(vf_mbx, vf->vf_id);
+}
+
+static void sdp_pfvf_mbox_handler(struct work_struct *work)
+{
+	struct rvu_vf *vf = container_of(work, struct rvu_vf, mbox_wrk);
+	struct sdp_dev *sdp = vf->sdp;
+	struct otx2_mbox_dev *mdev;
+	struct mbox_hdr *req_hdr;
+	struct mbox_msghdr *msg;
+	struct otx2_mbox *mbox;
+	int offset, id, err;
+
+	mbox = &sdp->pfvf_mbox;
+	mdev = &mbox->dev[vf->vf_id];
+
+	/* sync with mbox memory region */
+	smp_rmb();
+
+	/* Process received mbox messages */
+	req_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	offset = ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
+	for (id = 0; id < req_hdr->num_msgs; id++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start +
+					     offset);
+
+		/* Set which VF sent this message based on mbox IRQ */
+		msg->pcifunc = ((u16)sdp->pf << RVU_PFVF_PF_SHIFT) |
+				((vf->vf_id + 1) & RVU_PFVF_FUNC_MASK);
+		err = handle_vf_req(sdp, vf, msg, msg->next_msgoff - offset);
+		if (err)
+			otx2_reply_invalid_msg(mbox, vf->vf_id, msg->pcifunc,
+					       msg->id);
+		offset = msg->next_msgoff;
+	}
+	/* Send mbox responses to VF */
+	if (mdev->num_msgs)
+		otx2_mbox_msg_send(mbox, vf->vf_id);
+}
+
+static irqreturn_t sdp_pf_vf_mbox_intr(int irq, void *arg)
+{
+	struct sdp_dev *sdp = (struct sdp_dev *)arg;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	struct rvu_vf *vf;
+	int i, vfi;
+	u64 intr;
+
+	/* Check which VF has raised an interrupt and schedule corresponding
+	 * workq to process the MBOX
+	 */
+	for (i = 0; i < 2; i++) {
+		/* Read the interrupt bits */
+		intr = sdp_read64(sdp, BLKADDR_RVUM, 0,
+				  RVU_PF_VFPF_MBOX_INTX(i));
+
+		for (vfi = i * 64; vfi < sdp->num_vfs; vfi++) {
+			vf = &sdp->vf_info[vfi];
+			if ((intr & (1ULL << vf->intr_idx)) == 0)
+				continue;
+			mbox = &sdp->pfvf_mbox;
+			mdev = &mbox->dev[vf->vf_id];
+			hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+			/* Handle VF => PF channel request */
+			if (hdr->num_msgs)
+				queue_work(sdp->pfvf_mbox_wq, &vf->mbox_wrk);
+
+			mbox = &sdp->pfvf_mbox_up;
+			mdev = &mbox->dev[vf->vf_id];
+			hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+			/* Handle PF => VF channel response */
+			if (hdr->num_msgs)
+				queue_work(sdp->pfvf_mbox_wq, &vf->mbox_wrk_up);
+			/* Clear the interrupt */
+			sdp_write64(sdp, BLKADDR_RVUM, 0,
+				   RVU_PF_VFPF_MBOX_INTX(i),
+				   BIT_ULL(vf->intr_idx));
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void enable_vf_mbox_int(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int ena_bits, idx;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Clear any pending interrupts */
+	for (idx = 0; idx < 2; idx++) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFPF_MBOX_INTX(idx),
+			    ~0x0ULL);
+	}
+
+	/* Enable VF MBOX interrupts */
+	if (sdp->num_vfs > 64) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			    RVU_PF_VFPF_MBOX_INT_ENA_W1SX(0),
+			    GENMASK_ULL(63, 0));
+		ena_bits = (sdp->num_vfs - 64) - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			   RVU_PF_VFPF_MBOX_INT_ENA_W1SX(1),
+			   GENMASK_ULL(ena_bits, 0));
+	} else {
+		ena_bits = sdp->num_vfs - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			    RVU_PF_VFPF_MBOX_INT_ENA_W1SX(0),
+			    GENMASK_ULL(ena_bits, 0));
+	}
+}
+
+static void disable_vf_mbox_int(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int ena_bits, idx;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Clear any pending interrupts */
+	for (idx = 0; idx < 2; idx++) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0, RVU_PF_VFPF_MBOX_INTX(idx),
+			    ~0x0ULL);
+	}
+
+	/* Disable the MBOX interrupts for VFs */
+	if (sdp->num_vfs > 64) {
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			    RVU_PF_VFPF_MBOX_INT_ENA_W1CX(0),
+			    GENMASK_ULL(63, 0));
+		ena_bits = (sdp->num_vfs - 64) - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			   RVU_PF_VFPF_MBOX_INT_ENA_W1CX(1),
+			   GENMASK_ULL(ena_bits, 0));
+	} else {
+		ena_bits = sdp->num_vfs - 1;
+		sdp_write64(sdp, BLKADDR_RVUM, 0,
+			   RVU_PF_VFPF_MBOX_INT_ENA_W1CX(0),
+			   GENMASK_ULL(ena_bits, 0));
+	}
+}
+
 static int sdp_check_pf_usable(struct sdp_dev *sdp)
 {
 	u64 rev;
@@ -122,6 +674,138 @@ static void sdp_free_irqs(struct pci_dev *pdev)
 	kfree(sdp->irq_allocated);
 }
 
+static int sdp_register_mbox_irq(struct pci_dev *pdev)
+{
+	int err, vec = RVU_PF_INT_VEC_VFPF_MBOX0, i;
+	struct sdp_dev *sdp;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Register PF-AF interrupt handler */
+	sprintf(&sdp->irq_names[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE],
+		"PF%02d_AF_MBOX_IRQ", pdev->devfn);
+	err = request_irq(pci_irq_vector(pdev, RVU_PF_INT_VEC_AFPF_MBOX),
+			  sdp_af_pf_mbox_intr, 0,
+			  &sdp->irq_names[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE],
+			  sdp);
+	if (err) {
+		dev_err(&pdev->dev,
+			"request_irq() failed for AF_PF MSIX vector\n");
+		return err;
+	}
+	sdp->irq_allocated[RVU_PF_INT_VEC_AFPF_MBOX] = true;
+
+	err = otx2_mbox_init(&sdp->afpf_mbox, sdp->af_mbx_base, pdev, sdp->bar2,
+			     MBOX_DIR_PFAF, 1);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to initialize PF/AF MBOX\n");
+		goto error;
+	}
+	err = otx2_mbox_init(&sdp->afpf_mbox_up, sdp->af_mbx_base, pdev,
+			     sdp->bar2, MBOX_DIR_PFAF_UP, 1);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to initialize PF/AF UP MBOX\n");
+		goto error;
+	}
+
+	/* Register for PF-VF mailbox interrupts
+	 * There are 2 vectors starting at index 0x4
+	 */
+	for (vec = RVU_PF_INT_VEC_VFPF_MBOX0, i = 0;
+	     vec + i <= RVU_PF_INT_VEC_VFPF_MBOX1; i++) {
+		sprintf(&sdp->irq_names[(vec + i) * NAME_SIZE],
+			"PF%02d_VF_MBOX_IRQ%d", pdev->devfn, i);
+		err = request_irq(pci_irq_vector(pdev, vec + i),
+				  sdp_pf_vf_mbox_intr, 0,
+				  &sdp->irq_names[(vec + i) * NAME_SIZE], sdp);
+		if (err) {
+			dev_err(&pdev->dev,
+				"request_irq() failed for PFVF Mbox intr %d\n",
+				vec + i);
+			goto error;
+		}
+		sdp->irq_allocated[vec + i] = true;
+	}
+
+	sdp->afpf_mbox_wq = alloc_workqueue(
+	    "sdp_pfaf_mailbox", WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
+	if (!sdp->afpf_mbox_wq)
+		goto error;
+
+	INIT_WORK(&sdp->mbox_wrk, sdp_afpf_mbox_handler);
+	INIT_WORK(&sdp->mbox_wrk_up, sdp_afpf_mbox_handler_up);
+
+	return err;
+
+error:
+	if (sdp->afpf_mbox_up.dev != NULL)
+		otx2_mbox_destroy(&sdp->afpf_mbox_up);
+	if (sdp->afpf_mbox.dev != NULL)
+		otx2_mbox_destroy(&sdp->afpf_mbox);
+
+	return err;
+}
+
+static int sdp_get_pcifunc(struct sdp_dev *sdp)
+{
+	struct msg_req *ready_req;
+	int res = 0;
+
+	ready_req = (struct msg_req *)
+		otx2_mbox_alloc_msg_rsp(&sdp->afpf_mbox, 0, sizeof(ready_req),
+					sizeof(struct ready_msg_rsp));
+	if (ready_req == NULL) {
+		dev_err(&sdp->pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+
+	ready_req->hdr.id = MBOX_MSG_READY;
+	ready_req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	otx2_mbox_msg_send(&sdp->afpf_mbox, 0);
+	res = otx2_mbox_wait_for_rsp(&sdp->afpf_mbox, 0);
+	if (res == -EIO) {
+		dev_err(&sdp->pdev->dev, "RVU AF MBOX timeout.\n");
+	} else if (res) {
+		dev_err(&sdp->pdev->dev, "RVU MBOX error: %d.\n", res);
+		res = -EFAULT;
+	}
+	return res;
+}
+
+static int sdp_get_available_rsrcs(struct sdp_dev *sdp)
+{
+	struct mbox_msghdr *rsrc_req;
+	int res = 0;
+
+	rsrc_req = otx2_mbox_alloc_msg(&sdp->afpf_mbox, 0, sizeof(*rsrc_req));
+	if (rsrc_req == NULL) {
+		dev_err(&sdp->pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+	rsrc_req->id = MBOX_MSG_FREE_RSRC_CNT;
+	rsrc_req->sig = OTX2_MBOX_REQ_SIG;
+	rsrc_req->pcifunc = RVU_PFFUNC(sdp->pf, 0);
+	otx2_mbox_msg_send(&sdp->afpf_mbox, 0);
+	res = otx2_mbox_wait_for_rsp(&sdp->afpf_mbox, 0);
+	if (res == -EIO) {
+		dev_err(&sdp->pdev->dev, "RVU AF MBOX timeout.\n");
+	} else if (res) {
+		dev_err(&sdp->pdev->dev,
+			"RVU MBOX error: %d.\n", res);
+		res = -EFAULT;
+	}
+	return res;
+}
+
+static void sdp_afpf_mbox_term(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp = pci_get_drvdata(pdev);
+
+	destroy_workqueue(sdp->afpf_mbox_wq);
+	otx2_mbox_destroy(&sdp->afpf_mbox);
+	otx2_mbox_destroy(&sdp->afpf_mbox_up);
+}
+
 static int __sriov_disable(struct pci_dev *pdev)
 {
 	struct sdp_dev *sdp;
@@ -133,6 +817,20 @@ static int __sriov_disable(struct pci_dev *pdev)
 		return -EPERM;
 	}
 
+	disable_vf_mbox_int(pdev);
+
+	if (sdp->pfvf_mbox_wq) {
+		destroy_workqueue(sdp->pfvf_mbox_wq);
+		sdp->pfvf_mbox_wq = NULL;
+	}
+	if (sdp->pfvf_mbx_base) {
+		iounmap(sdp->pfvf_mbx_base);
+		sdp->pfvf_mbx_base = NULL;
+	}
+
+	otx2_mbox_destroy(&sdp->pfvf_mbox);
+	otx2_mbox_destroy(&sdp->pfvf_mbox_up);
+
 	pci_disable_sriov(pdev);
 
 	kfree(sdp->vf_info);
@@ -146,6 +844,7 @@ static int __sriov_enable(struct pci_dev *pdev, int num_vfs)
 	struct rvu_vf *vf_ptr;
 	int curr_vfs, vf = 0;
 	struct sdp_dev *sdp;
+	u64 pf_vf_mbox_base;
 	int err;
 
 	curr_vfs = pci_num_vf(pdev);
@@ -174,6 +873,66 @@ static int __sriov_enable(struct pci_dev *pdev, int num_vfs)
 
 	sdp->num_vfs = num_vfs;
 
+	/*
+	 * Map PF-VF mailbox memory.
+	 */
+	pf_vf_mbox_base = readq((void __iomem *)((u64)sdp->bar2 +
+						 RVU_PF_VF_BAR4_ADDR));
+
+	if (!pf_vf_mbox_base) {
+		dev_err(&pdev->dev, "PF-VF Mailbox address not configured\n");
+		err = -ENOMEM;
+		goto err_mbox_mem_map;
+	}
+	sdp->pfvf_mbx_base = ioremap_wc(pf_vf_mbox_base, MBOX_SIZE * num_vfs);
+	if (!sdp->pfvf_mbx_base) {
+		dev_err(&pdev->dev,
+			"Mapping of PF-VF mailbox address failed\n");
+		err = -ENOMEM;
+		goto err_mbox_mem_map;
+	}
+	err = otx2_mbox_init(&sdp->pfvf_mbox, sdp->pfvf_mbx_base, pdev,
+			     sdp->bar2, MBOX_DIR_PFVF, num_vfs);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to initialize PF/VF MBOX for %d VFs\n",
+			num_vfs);
+		goto err_mbox_init;
+	}
+
+	err = otx2_mbox_init(&sdp->pfvf_mbox_up, sdp->pfvf_mbx_base, pdev,
+			     sdp->bar2, MBOX_DIR_PFVF_UP, num_vfs);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to initialize PF/VF MBOX UP for %d VFs\n",
+			num_vfs);
+		goto err_mbox_up_init;
+	}
+
+	/* Allocate a single workqueue for VF/PF mailbox because access to
+	 * AF/PF mailbox has to be synchronized.
+	 */
+	sdp->pfvf_mbox_wq =
+		alloc_workqueue("sdp_pfvf_mailbox",
+				WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
+	if (sdp->pfvf_mbox_wq == NULL) {
+		dev_err(&pdev->dev,
+			"Workqueue allocation failed for PF-VF MBOX\n");
+		err = -ENOMEM;
+		goto err_workqueue_alloc;
+	}
+
+	for (vf = 0; vf < num_vfs; vf++) {
+		vf_ptr = &sdp->vf_info[vf];
+		vf_ptr->vf_id = vf;
+		vf_ptr->sdp = (void *)sdp;
+		vf_ptr->intr_idx = vf % 64;
+		INIT_WORK(&vf_ptr->mbox_wrk, sdp_pfvf_mbox_handler);
+		INIT_WORK(&vf_ptr->mbox_wrk_up, sdp_pfvf_mbox_handler_up);
+	}
+
+	enable_vf_mbox_int(pdev);
+
 	err = pci_enable_sriov(pdev, num_vfs);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable to SRIOV VFs: %d\n", err);
@@ -181,6 +940,23 @@ static int __sriov_enable(struct pci_dev *pdev, int num_vfs)
 	}
 
 	return num_vfs;
+
+err_enable_sriov:
+	disable_vf_mbox_int(pdev);
+err_workqueue_alloc:
+	destroy_workqueue(sdp->pfvf_mbox_wq);
+	if (sdp->pfvf_mbox_up.dev != NULL)
+		otx2_mbox_destroy(&sdp->pfvf_mbox_up);
+err_mbox_up_init:
+	if (sdp->pfvf_mbox.dev != NULL)
+		otx2_mbox_destroy(&sdp->pfvf_mbox);
+err_mbox_init:
+	iounmap(sdp->pfvf_mbx_base);
+err_mbox_mem_map:
+	kfree(sdp->vf_info);
+
+	return err;
+
 }
 
 static int sdp_sriov_configure(struct pci_dev *pdev, int num_vfs)
@@ -278,6 +1054,22 @@ static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto alloc_irqs_failed;
 	}
 
+	if (sdp_register_mbox_irq(pdev) != 0) {
+		dev_err(&pdev->dev,
+			"Unable to allocate MBOX Interrupt vectors\n");
+		err = -ENODEV;
+		goto reg_mbox_irq_failed;
+	}
+
+	enable_af_mbox_int(pdev);
+
+	if (sdp_get_pcifunc(sdp)) {
+		dev_err(&pdev->dev,
+			"Failed to retrieve pcifunc from AF\n");
+		err = -ENODEV;
+		goto get_pcifunc_failed;
+	}
+
 	regval = readq(sdp->sdp_base + SDPX_GBL_CONTROL);
 	regval |= (1 << 2); /* BPFLR_D disable clearing BP in FLR */
 	writeq(regval, sdp->sdp_base + SDPX_GBL_CONTROL);
@@ -290,6 +1082,11 @@ static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+get_pcifunc_failed:
+	disable_af_mbox_int(pdev);
+	sdp_afpf_mbox_term(pdev);
+reg_mbox_irq_failed:
+	sdp_free_irqs(pdev);
 alloc_irqs_failed:
 	iounmap(sdp->af_mbx_base);
 pf_unusable:
@@ -316,6 +1113,8 @@ static void sdp_remove(struct pci_dev *pdev)
 	if (sdp->num_vfs)
 		__sriov_disable(pdev);
 
+	disable_af_mbox_int(pdev);
+	sdp_afpf_mbox_term(pdev);
 	sdp_free_irqs(pdev);
 
 	if (sdp->af_mbx_base)
diff --git a/drivers/soc/marvell/octeontx2-sdp/sdp.h b/drivers/soc/marvell/octeontx2-sdp/sdp.h
index c8ef7a2ade45..6ee61aeb9750 100644
--- a/drivers/soc/marvell/octeontx2-sdp/sdp.h
+++ b/drivers/soc/marvell/octeontx2-sdp/sdp.h
@@ -15,9 +15,19 @@
 #include <linux/pci.h>
 #include "mbox.h"
 
+#define RVU_PFVF_PF_SHIFT	10
+#define RVU_PFVF_PF_MASK	0x3F
+#define RVU_PFVF_FUNC_SHIFT	0
+#define RVU_PFVF_FUNC_MASK	0x3FF
+
+#define RVU_PFFUNC(pf, func)	\
+	((((pf) & RVU_PFVF_PF_MASK) << RVU_PFVF_PF_SHIFT) | \
+	(((func) & RVU_PFVF_FUNC_MASK) << RVU_PFVF_FUNC_SHIFT))
+
 #define SDP_BASE(a)		(0x86E080000000ull | a << 36)
 #define SDP_REG_SIZE		0x42000000
 
+#define SDPX_OUT_BP_ENX_W1S(a)  (0x80280ull | a << 4)
 #define SDPX_GBL_CONTROL	(0x40080200ull)
 
 struct sdp_dev {
@@ -27,6 +37,7 @@ struct sdp_dev {
 	void __iomem		*sdp_base;
 	void __iomem		*bar2;
 	void __iomem		*af_mbx_base;
+	void __iomem		*pfvf_mbx_base;
 #define SDP_VF_ENABLED 0x1
 	u32			flags;
 	u32			num_vfs;
@@ -38,13 +49,22 @@ struct sdp_dev {
 	int			pf;
 	u8			valid_ep_pem_mask;
 	u8			mac_mask;
-
+	struct otx2_mbox	pfvf_mbox; /* MBOXes for VF => PF channel */
+	struct otx2_mbox	pfvf_mbox_up; /* MBOXes for PF => VF channel */
+	struct otx2_mbox	afpf_mbox; /* MBOX for PF => AF channel */
+	struct otx2_mbox	afpf_mbox_up; /* MBOX for AF => PF channel */
+	struct work_struct	mbox_wrk;
+	struct work_struct	mbox_wrk_up;
+	struct workqueue_struct	*afpf_mbox_wq; /* MBOX handler */
+	struct workqueue_struct	*pfvf_mbox_wq; /* VF MBOX handler */
 	struct sdp_node_info info;
 	struct rvu_vf		*vf_info;
 	struct free_rsrcs_rsp	limits; /* Maximum limits for all VFs */
 };
 
 struct rvu_vf {
+	struct work_struct	mbox_wrk;
+	struct work_struct	mbox_wrk_up;
 	struct work_struct	pfvf_flr_work;
 	struct device_attribute in_use_attr;
 	struct pci_dev		*pdev;
-- 
2.24.1

