Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE64B0083
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiBIWmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:42:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiBIWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:42:30 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E45C0302D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:42:30 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219IO5Ek014382;
        Wed, 9 Feb 2022 14:42:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=IRHFx3h5FBrQu2UY7xrQzm1gPaslNEwFcYm95KOm78w=;
 b=C18tnaYoWRwaK/jc+TNzIVx+iOaRNZaxWuRo9EkONzV83jKb0SYaEOvQsrVOTwQiLtp6
 7H7cpS+WGjdRSkKIBKMuj1cZAjUscvgXuDLnATeidbEs0I1XfyXoquOxKPBnFt+0mTWC
 Ic+CCd011Kjs1eiky4bUl00hTi5s4m0T/hWeeCuOibswkxZNycLHBHVVQ/fTTD2Ly+vD
 FFhNANJdvS81etEPlKQmEMdK0W2tZe2PgolCVQrmayLbqgjV+dWD0HdHFrHqPSK4teI1
 TnWjj2GTTuxU3t+DR9Ah0KZZFWXaPBJ0giohJ+KcfNbh6PBqWx/AElJsKo1Vz38E+L/t dA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e4am93bx1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:42:24 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 14:42:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 14:42:19 -0800
Received: from rchin-dellt430.marvell.com (rchin-dellt430.marvell.com [10.85.176.141])
        by maili.marvell.com (Postfix) with ESMTP id 4A9A93F70A7;
        Wed,  9 Feb 2022 14:42:19 -0800 (PST)
From:   Radha Mohan Chintakuntla <radhac@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        "Radha Mohan Chintakuntla" <radhac@marvell.com>
Subject: [PATCH 4/4] soc: octeontx2-sdp: setup the SDP channel configuration
Date:   Wed, 9 Feb 2022 14:42:10 -0800
Message-ID: <20220209224210.153907-5-radhac@marvell.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20220209224210.153907-1-radhac@marvell.com>
References: <20220209224210.153907-1-radhac@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _UsGQAe4JH15u4wlqlluNdrLXTYCRlmP
X-Proofpoint-ORIG-GUID: _UsGQAe4JH15u4wlqlluNdrLXTYCRlmP
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

This patch sets up the SDP channels to NIX block for packet transmit and
receive.

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
 drivers/soc/marvell/octeontx2-sdp/sdp.c | 186 ++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/soc/marvell/octeontx2-sdp/sdp.c b/drivers/soc/marvell/octeontx2-sdp/sdp.c
index ce1e8c424bff..a5f707bf17cf 100644
--- a/drivers/soc/marvell/octeontx2-sdp/sdp.c
+++ b/drivers/soc/marvell/octeontx2-sdp/sdp.c
@@ -1167,6 +1167,152 @@ static int sdp_sriov_configure(struct pci_dev *pdev, int num_vfs)
 		return __sriov_enable(pdev, num_vfs);
 }
 
+static int sdp_parse_rinfo(struct pci_dev *pdev,
+			   struct sdp_node_info *info)
+{
+	u32 vf_ring_cnts, vf_rings;
+	struct device_node *dev;
+	struct device *sdev;
+	const void *ptr;
+	int len, vfid;
+
+	sdev = &pdev->dev;
+	dev = of_find_node_by_name(NULL, "rvu-sdp");
+	if (dev == NULL) {
+		dev_err(sdev, "can't find FDT dev %s\n", "rvu-sdp");
+		return -EINVAL;
+	}
+
+	ptr = of_get_property(dev, "num-rvu-vfs", &len);
+	if (ptr == NULL) {
+		dev_err(sdev, "SDP DTS: Failed to get num-rvu-vfs\n");
+		return -EINVAL;
+	}
+
+	if (len != sizeof(u32)) {
+		dev_err(sdev, "SDP DTS: Wrong field length: num-rvu-vfs\n");
+		return -EINVAL;
+	}
+	info->max_vfs =  be32_to_cpup((u32 *)ptr);
+
+	if (info->max_vfs > pci_sriov_get_totalvfs(pdev)) {
+		dev_err(sdev, "SDP DTS: Invalid field value: num-rvu-vfs\n");
+		return -EINVAL;
+	}
+
+	ptr = of_get_property(dev, "num-pf-rings", &len);
+	if (ptr == NULL) {
+		dev_err(sdev, "SDP DTS: Failed to get num-pf-rings\n");
+		return -EINVAL;
+	}
+	if (len != sizeof(u32)) {
+		dev_err(sdev, "SDP DTS: Wrong field length: num-pf-rings\n");
+		return -EINVAL;
+	}
+	info->num_pf_rings = be32_to_cpup((u32 *)ptr);
+
+	ptr = of_get_property(dev, "pf-srn", &len);
+	if (ptr == NULL) {
+		dev_err(sdev, "SDP DTS: Failed to get pf-srn\n");
+		return -EINVAL;
+	}
+	if (len != sizeof(u32)) {
+		dev_err(sdev, "SDP DTS: Wrong field length: pf-srn\n");
+		return -EINVAL;
+	}
+	info->pf_srn = be32_to_cpup((u32 *)ptr);
+
+	ptr = of_get_property(dev, "num-vf-rings", &len);
+	if (ptr == NULL) {
+		dev_err(sdev, "SDP DTS: Failed to get num-vf-rings\n");
+		return -EINVAL;
+	}
+
+	vf_ring_cnts = len / sizeof(u32);
+	if (vf_ring_cnts > info->max_vfs) {
+		dev_err(sdev, "SDP DTS: Wrong field length: num-vf-rings\n");
+		return -EINVAL;
+	}
+
+	for (vfid = 0; vfid < info->max_vfs; vfid++) {
+		if (vfid < vf_ring_cnts) {
+			if (of_property_read_u32_index(dev, "num-vf-rings",
+					vfid, &vf_rings)) {
+				dev_err(sdev, "SDP DTS: Failed to get vf ring count\n");
+				return -EINVAL;
+			}
+			info->vf_rings[vfid] = vf_rings;
+		} else {
+			/*
+			 * Rest of the VFs use the same last ring count
+			 * specified
+			 */
+			info->vf_rings[vfid] = info->vf_rings[vf_ring_cnts - 1];
+		}
+	}
+	dev_info(sdev, "pf start ring number:%d num_pf_rings:%d max_vfs:%d vf_ring_cnts:%d\n",
+		 info->pf_srn, info->num_pf_rings, info->max_vfs, vf_ring_cnts);
+
+	return 0;
+}
+
+static int get_chan_info(struct sdp_dev *sdp)
+{
+	struct sdp_get_chan_info_msg *rsp;
+	struct msg_req *req;
+	int res = 0;
+
+	req = (struct msg_req *) otx2_mbox_alloc_msg(&sdp->afpf_mbox, 0, sizeof(*req));
+	if (req == NULL) {
+		dev_err(&sdp->pdev->dev, "RVU Mbox failed to alloc\n");
+		return -EFAULT;
+	}
+	req->hdr.id = MBOX_MSG_GET_SDP_CHAN_INFO;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.pcifunc = RVU_PFFUNC(sdp->pf, 0);
+
+	otx2_mbox_msg_send(&sdp->afpf_mbox, 0);
+	res = otx2_mbox_wait_for_rsp(&sdp->afpf_mbox, 0);
+	if (res == -EIO)
+		dev_err(&sdp->pdev->dev, "RVU AF Mbox timeout\n");
+	else if (res) {
+		dev_err(&sdp->pdev->dev, "RVU Mbox error: %d\n", res);
+		res = -EFAULT;
+	}
+	rsp = (struct sdp_get_chan_info_msg *)otx2_mbox_get_rsp(&sdp->afpf_mbox, 0,
+								&req->hdr);
+	sdp->chan_base = rsp->chan_base;
+	sdp->num_chan = rsp->num_chan;
+
+	return res;
+}
+static int send_chan_info(struct sdp_dev *sdp, struct sdp_node_info *info)
+{
+	struct sdp_chan_info_msg *cinfo;
+	int res = 0;
+
+	cinfo = (struct sdp_chan_info_msg *)
+		otx2_mbox_alloc_msg(&sdp->afpf_mbox, 0, sizeof(*cinfo));
+	if (cinfo == NULL) {
+		dev_err(&sdp->pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+	cinfo->hdr.id = MBOX_MSG_SET_SDP_CHAN_INFO;
+	cinfo->hdr.sig = OTX2_MBOX_REQ_SIG;
+	cinfo->hdr.pcifunc = RVU_PFFUNC(sdp->pf, 0);
+
+	memcpy(&cinfo->info, info, sizeof(struct sdp_node_info));
+	otx2_mbox_msg_send(&sdp->afpf_mbox, 0);
+	res = otx2_mbox_wait_for_rsp(&sdp->afpf_mbox, 0);
+	if (res == -EIO) {
+		dev_err(&sdp->pdev->dev, "RVU AF MBOX timeout.\n");
+	} else if (res) {
+		dev_err(&sdp->pdev->dev, "RVU MBOX error: %d.\n", res);
+		res = -EFAULT;
+	}
+
+	return res;
+}
 
 static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -1277,6 +1423,44 @@ static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto get_pcifunc_failed;
 	}
 
+	err = get_chan_info(sdp);
+	if (err) {
+		dev_err(&pdev->dev, "SDP get channel info failed\n");
+		goto get_chan_info_failed;
+	}
+
+	dev_info(&sdp->pdev->dev, "SDP chan base: 0x%x, num chan: 0x%x\n",
+		 sdp->chan_base, sdp->num_chan);
+
+	err = sdp_parse_rinfo(pdev, &sdp->info);
+	if (err) {
+		err = -EINVAL;
+		goto get_rinfo_failed;
+	}
+
+	/* To differentiate a PF between SDP0 or SDP1 we make use of the
+	 * revision ID field in the config space. The revision is filled
+	 * by the firmware. The lower 4 bits field is used here.
+	 * 0 means SDP0
+	 * 1 means SDP1
+	 */
+	if (pdev->revision & 0x0F)
+		sdp->info.node_id = 1;
+	else
+		sdp->info.node_id = 0;
+
+	/*
+	 * For 98xx there are 2xSDPs so start the PF ring from 128 for SDP1
+	 * SDP0 has PCI revid 0 and SDP1 has PCI revid 1
+	 */
+	sdp->info.pf_srn = (pdev->revision & 0x0F) ? 128 : sdp->info.pf_srn;
+
+	err = send_chan_info(sdp, &sdp->info);
+	if (err) {
+		err = -EINVAL;
+		goto get_rinfo_failed;
+	}
+
 	regval = readq(sdp->sdp_base + SDPX_GBL_CONTROL);
 	regval |= (1 << 2); /* BPFLR_D disable clearing BP in FLR */
 	writeq(regval, sdp->sdp_base + SDPX_GBL_CONTROL);
@@ -1289,6 +1473,8 @@ static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+get_chan_info_failed:
+get_rinfo_failed:
 get_pcifunc_failed:
 	disable_af_mbox_int(pdev);
 reg_flr_irq_failed:
-- 
2.24.1

