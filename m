Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD20489688
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbiAJKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:38:51 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244063AbiAJKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:38:04 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20A9V4IQ030680;
        Mon, 10 Jan 2022 11:37:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=ltuKY3JbZ9a8gnDMbB/xLmLbXhMhu4XfcFmrhNwLzSU=;
 b=puEdB7FwTo5ZqfbW9w6h8VvccFHdyT7TqxDMeKo8OWELlPslVpd/OcpdjmcDrHTi9/yt
 X3nKp4jkAK8ZgZj79voIn9XBnsumcaJ/a0kOQOZFxy5xluMeV/LSpP1HmHndwlHIJhq+
 Kb9ha/tS7d33SGyHIh8gAze9WjZEiUoTtjymq5JCjwHO07tDvr9qESvqmAvSvDDZB8ow
 dwxPzdcWpEErcqH/k71R4FU9bU0bz60UHUakVhUwlCKDYicKXMDd0WahiMLnzro8zNB+
 0B7AjqAgGJXNVkpSdCDymvgV10JFf/vxnlDWYqaEyljYOsS0FYnlIZGiW7cPqQasLMG7 TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dgj85rakv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 11:37:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3896D10002A;
        Mon, 10 Jan 2022 11:37:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2AFE9235F0F;
        Mon, 10 Jan 2022 11:37:40 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 10 Jan 2022 11:37:39
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <hugues.fruchet@foss.st.com>, <mchehab@kernel.org>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alain.volmat@foss.st.com>
Subject: [PATCH] media: stm32: dcmi: create a dma scatterlist based on DMA max_sg_burst value
Date:   Mon, 10 Jan 2022 11:37:39 +0100
Message-ID: <20220110103739.118426-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_04,2022-01-10_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to submitting a transfer to the DMA, the client should first check
the capabilities of the DMA channel in term of maximum of each segment.
This is given by the max_sg_burst value reported by dma_get_slave_caps API.
Based on that, if the transfer is larger than what can be handled by the
DMA channel, we split the transfer into several scatterlist elements.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 47 ++++++++++++++++++-----
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index e1b17c05229c..ee170e999a88 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -113,7 +113,7 @@ struct dcmi_framesize {
 struct dcmi_buf {
 	struct vb2_v4l2_buffer	vb;
 	bool			prepared;
-	dma_addr_t		paddr;
+	struct sg_table		sgt;
 	size_t			size;
 	struct list_head	list;
 };
@@ -157,6 +157,7 @@ struct stm32_dcmi {
 	enum state			state;
 	struct dma_chan			*dma_chan;
 	dma_cookie_t			dma_cookie;
+	u32				dma_max_burst;
 	u32				misr;
 	int				errors_count;
 	int				overrun_count;
@@ -326,13 +327,11 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 	mutex_lock(&dcmi->dma_lock);
 
 	/* Prepare a DMA transaction */
-	desc = dmaengine_prep_slave_single(dcmi->dma_chan, buf->paddr,
-					   buf->size,
+	desc = dmaengine_prep_slave_sg(dcmi->dma_chan, buf->sgt.sgl, buf->sgt.nents,
 					   DMA_DEV_TO_MEM,
 					   DMA_PREP_INTERRUPT);
 	if (!desc) {
-		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_single failed for buffer phy=%pad size=%zu\n",
-			__func__, &buf->paddr, buf->size);
+		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_sg failed\n", __func__);
 		mutex_unlock(&dcmi->dma_lock);
 		return -EINVAL;
 	}
@@ -524,6 +523,10 @@ static int dcmi_buf_prepare(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct dcmi_buf *buf = container_of(vbuf, struct dcmi_buf, vb);
 	unsigned long size;
+	unsigned int num_sgs = 1;
+	dma_addr_t dma_buf;
+	struct scatterlist *sg;
+	int i, ret;
 
 	size = dcmi->fmt.fmt.pix.sizeimage;
 
@@ -537,15 +540,33 @@ static int dcmi_buf_prepare(struct vb2_buffer *vb)
 
 	if (!buf->prepared) {
 		/* Get memory addresses */
-		buf->paddr =
-			vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
 		buf->size = vb2_plane_size(&buf->vb.vb2_buf, 0);
-		buf->prepared = true;
+		if (buf->size > dcmi->dma_max_burst)
+			num_sgs = DIV_ROUND_UP(buf->size, dcmi->dma_max_burst);
 
-		vb2_set_plane_payload(&buf->vb.vb2_buf, 0, buf->size);
+		ret = sg_alloc_table(&buf->sgt, num_sgs, GFP_ATOMIC);
+		if (ret) {
+			dev_err(dcmi->dev, "sg table alloc failed\n");
+			return ret;
+		}
+
+		dma_buf = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
 
 		dev_dbg(dcmi->dev, "buffer[%d] phy=%pad size=%zu\n",
-			vb->index, &buf->paddr, buf->size);
+			vb->index, &dma_buf, buf->size);
+
+		for_each_sg(buf->sgt.sgl, sg, num_sgs, i) {
+			size_t bytes = min_t(size_t, size, dcmi->dma_max_burst);
+
+			sg_dma_address(sg) = dma_buf;
+			sg_dma_len(sg) = bytes;
+			dma_buf += bytes;
+			size -= bytes;
+		}
+
+		buf->prepared = true;
+
+		vb2_set_plane_payload(&buf->vb.vb2_buf, 0, buf->size);
 	}
 
 	return 0;
@@ -1866,6 +1887,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	struct stm32_dcmi *dcmi;
 	struct vb2_queue *q;
 	struct dma_chan *chan;
+	struct dma_slave_caps caps;
 	struct clk *mclk;
 	int irq;
 	int ret = 0;
@@ -1953,6 +1975,11 @@ static int dcmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dcmi->dma_max_burst = UINT_MAX;
+	ret = dma_get_slave_caps(chan, &caps);
+	if (!ret && caps.max_sg_burst)
+		dcmi->dma_max_burst = caps.max_sg_burst	* DMA_SLAVE_BUSWIDTH_4_BYTES;
+
 	spin_lock_init(&dcmi->irqlock);
 	mutex_init(&dcmi->lock);
 	mutex_init(&dcmi->dma_lock);
-- 
2.25.1

