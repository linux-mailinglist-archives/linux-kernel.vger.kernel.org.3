Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2028522BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiEKF5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiEKF5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:57:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9B4F9EE;
        Tue, 10 May 2022 22:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652248643; x=1683784643;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JS0wQtwj/aI1mz6dCd4z6y/dqiOprbNP2cwtAwaTJck=;
  b=zRDyEXMC5yr/kWra3Wz8CDLtnsCSEbVh75UyZIPXtzbq/gBk4wI52AA4
   rcTtSXAzNsMc9GA7IHXdHLdrUBtBjYYrXmQEVOxFFA8Y5ngOQAYU3bzIf
   q4umUDuo4A5p4+8SsQ+O2VndKaLujRZQFCrCNhwKNXDf+JSM9GGmNyDSM
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 May 2022 22:57:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 22:57:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 22:57:22 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 22:57:18 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <sboyd@kernel.org>, <agross@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <mka@chromium.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2] remoteproc: qcom_q6v5_mss: map/unmap metadata region before/after use
Date:   Wed, 11 May 2022 11:27:05 +0530
Message-ID: <1652248625-990-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The application processor accessing the dynamically assigned metadata
region after assigning it to the remote Q6 would lead to an XPU violation.
Fix this by un-mapping the metadata region post firmware header copy. The
metadata region is freed only after the modem Q6 is done with fw header
authentication.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V2:
 * Fix error when MSS is built as a module [Kernel Test Bot]
 * Fixup cleanup errors

 drivers/remoteproc/qcom_q6v5_mss.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index af217de75e4d..4b37e11fbb03 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devcoredump.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -932,27 +933,52 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
 static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 				const char *fw_name)
 {
-	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
+	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
+	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
+	struct page **pages;
+	struct page *page;
 	dma_addr_t phys;
 	void *metadata;
 	int mdata_perm;
 	int xferop_ret;
 	size_t size;
-	void *ptr;
+	void *vaddr;
+	int count;
 	int ret;
+	int i;
 
 	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
-	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
-	if (!ptr) {
+	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
+	if (!page) {
 		kfree(metadata);
 		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
 		return -ENOMEM;
 	}
 
-	memcpy(ptr, metadata, size);
+	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto free_dma_attrs;
+	}
+
+	for (i = 0; i < count; i++)
+		pages[i] = nth_page(page, i);
+
+	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
+	kfree(pages);
+	if (!vaddr) {
+		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
+		ret = -EBUSY;
+		goto free_dma_attrs;
+	}
+
+	memcpy(vaddr, metadata, size);
+
+	vunmap(vaddr);
 
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
@@ -982,7 +1008,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 			 "mdt buffer not reclaimed system may become unstable\n");
 
 free_dma_attrs:
-	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
+	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
 	kfree(metadata);
 
 	return ret < 0 ? ret : 0;
-- 
2.7.4

