Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42A5793BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiGSHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiGSHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:02:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F1201B9;
        Tue, 19 Jul 2022 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658214163; x=1689750163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+exPw8yX9BjYdLqv/iy3Vw3i8VmcHOKhYDp3qRfcPC4=;
  b=lzYwsQzW1/pFc6BuC1dIc+p+OZNKp1KpEVb48zQdmpLSYhii+hLF80bk
   XZhg9+ZS+kGWlKDji+Vgc7vKeT1Rj0xALi+sJZIM1cteZ7oz/DZywVefW
   T6KddQNsxSRnYkNb9A2qETibW6gY2sv5cX+sAKsBXYlvv4ZBiHxYgqOCf
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jul 2022 00:02:42 -0700
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg01-sd.qualcomm.com with ESMTP; 19 Jul 2022 00:02:42 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 2A99B22784; Tue, 19 Jul 2022 00:02:42 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     bvanassche@acm.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        quic_cang@quicinc.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Date:   Tue, 19 Jul 2022 00:01:58 -0700
Message-Id: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asutosh Das <quic_asutoshd@quicinc.com>

Adds MCQ support to UFS driver.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/core/Makefile  |   2 +-
 drivers/ufs/core/ufs-mcq.c | 555 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c  | 362 ++++++++++++++++++++---------
 include/ufs/ufs.h          |   1 +
 include/ufs/ufshcd.h       | 231 ++++++++++++++++++-
 include/ufs/ufshci.h       |  89 ++++++++
 6 files changed, 1133 insertions(+), 107 deletions(-)
 create mode 100644 drivers/ufs/core/ufs-mcq.c

diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
index 62f38c5..4d02e0f 100644
--- a/drivers/ufs/core/Makefile
+++ b/drivers/ufs/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SCSI_UFSHCD)		+= ufshcd-core.o
-ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
+ufshcd-core-y				+= ufshcd.o ufs-sysfs.o ufs-mcq.o
 ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
 ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
new file mode 100644
index 0000000..5bdee7d
--- /dev/null
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linux Foundation. All rights reserved.
+ *
+ * Authors:
+ *	Asutosh Das <quic_asutoshd@quicinc.com>
+ *	Can Guo <quic_cang@quicinc.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <ufs/ufshcd.h>
+#include <asm/unaligned.h>
+
+/* resources */
+static const struct ufshcd_res_info_t ufshcd_res_info[RES_MAX] = {
+	{"ufs_mem", NULL, NULL},
+	{"mcq", NULL, NULL},
+	{"mcq_sqd", NULL, NULL},
+	{"mcq_sqis", NULL, NULL},
+	{"mcq_cqd", NULL, NULL},
+	{"mcq_cqis", NULL, NULL},
+	{"mcq_vs", NULL, NULL},
+};
+
+void ufshcd_mcq_config_mac(struct ufs_hba *hba)
+{
+	u32 val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
+
+	val &= ~MCQ_CFG_MAC_MASK;
+	val |= hba->dev_info.bqueuedepth << MCQ_CFG_MAC_OFFSET;
+	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
+
+static void ufshcd_mcq_init_lrb(struct ufs_hba *hba, struct ufs_hw_queue *hwq,
+				struct ufshcd_lrb *lrb, int i)
+{
+	struct utp_transfer_cmd_desc *cmd_descp = (void *)hwq->ucdl_base_addr;
+	struct utp_transfer_req_desc *utrdlp = hwq->sqe_shadow_addr;
+	dma_addr_t cmd_desc_dma_addr = hwq->ucdl_dma_addr +
+		i * sizeof(struct utp_transfer_cmd_desc);
+	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
+				       response_upiu);
+	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
+
+	lrb->utr_descriptor_ptr = utrdlp + i;
+	lrb->utrd_dma_addr = hwq->sqe_dma_addr +
+		i * sizeof(struct utp_transfer_req_desc);
+	lrb->ucd_req_ptr = (struct utp_upiu_req *)(cmd_descp + i);
+	lrb->ucd_req_dma_addr = cmd_desc_dma_addr;
+	lrb->ucd_rsp_ptr = (struct utp_upiu_rsp *)cmd_descp[i].response_upiu;
+	lrb->ucd_rsp_dma_addr = cmd_desc_dma_addr + response_offset;
+	lrb->ucd_prdt_ptr = cmd_descp[i].prd_table;
+	lrb->ucd_prdt_dma_addr = cmd_desc_dma_addr + prdt_offset;
+}
+
+struct ufshcd_lrb *ufshcd_mcq_find_lrb(struct ufs_hba *hba,
+					struct request *req,
+					struct 	ufs_hw_queue **hq)
+{
+	struct ufs_hw_queue *h;
+	struct ufshcd_lrb *lrbp;
+	u32 utag, hwq;
+	u8 tag = req->tag;
+
+	utag = blk_mq_unique_tag(req);
+	hwq = blk_mq_unique_tag_to_hwq(utag);
+	h = &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+	*hq = h;
+	lrbp = &h->lrb[tag];
+	lrbp->hw_queue_id = h->id;
+
+	return &h->lrb[tag];
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_find_lrb);
+
+int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	size_t ucdl_size, utrdl_size, cqe_size;
+	int i;
+
+	for_each_hw_queue(hba, i) {
+		hwq = &hba->uhq[i];
+		ucdl_size = (sizeof(struct utp_transfer_cmd_desc) *
+			     hwq->max_entries);
+		hwq->ucdl_base_addr = dmam_alloc_coherent(hba->dev, ucdl_size,
+							  &hwq->ucdl_dma_addr,
+							  GFP_KERNEL);
+		if (!hwq->ucdl_base_addr ||
+		    WARN_ON(hwq->ucdl_dma_addr & (PAGE_SIZE - 1))) {
+			dev_err(hba->dev, "MCQ Command Descriptor Memory allocation failed\n");
+			return -ENOMEM;
+		}
+
+		utrdl_size = sizeof(struct utp_transfer_req_desc) *
+			     hwq->max_entries;
+		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
+							 &hwq->sqe_dma_addr,
+							 GFP_KERNEL);
+		if (!hwq->sqe_dma_addr || WARN_ON(hwq->sqe_dma_addr &
+						  (PAGE_SIZE - 1))) {
+			dev_err(hba->dev, "Alloc SQE failed\n");
+			return -ENOMEM;
+		}
+
+		hwq->sqe_shadow_addr = devm_kzalloc(hba->dev, utrdl_size,
+						    GFP_KERNEL);
+		if (!hwq->sqe_shadow_addr) {
+			dev_err(hba->dev, "Alloc SQE shadow failed\n");
+			return -ENOMEM;
+		}
+
+		cqe_size = sizeof(struct cq_entry) * hwq->max_entries,
+		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
+							 &hwq->cqe_dma_addr,
+							 GFP_KERNEL);
+		if (!hwq->cqe_dma_addr || WARN_ON(hwq->cqe_dma_addr &
+						  (PAGE_SIZE - 1))) {
+			dev_err(hba->dev, "Alloc CQE failed\n");
+			return -ENOMEM;
+		}
+
+		hwq->lrb = devm_kcalloc(hba->dev, hwq->max_entries,
+					sizeof(struct ufshcd_lrb), GFP_KERNEL);
+		if (!hwq->lrb) {
+			dev_err(hba->dev, "LRB Memory allocation failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_memory_alloc);
+
+int ufshcd_mcq_memory_configure(struct ufs_hba *hba)
+{
+	struct utp_transfer_req_desc *utrdlp;
+	dma_addr_t cmd_desc_dma_base_addr;
+	dma_addr_t cmd_desc_dma_addr;
+	u16 response_offset;
+	u16 prdt_offset;
+	int cmd_desc_size;
+	struct ufs_hw_queue *hwq;
+	int i, j;
+
+	response_offset = offsetof(struct utp_transfer_cmd_desc, response_upiu);
+	prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
+
+	cmd_desc_size = sizeof(struct utp_transfer_cmd_desc);
+
+	for_each_hw_queue(hba, i) {
+		hwq = &hba->uhq[i];
+		utrdlp = hwq->sqe_shadow_addr;
+		cmd_desc_dma_base_addr = hwq->ucdl_dma_addr;
+
+		for (j = 0; j < hwq->max_entries; j++) {
+			/*
+			 * Configure UTRD with command descriptor base address
+			 */
+			cmd_desc_dma_addr =
+				(cmd_desc_dma_base_addr + (cmd_desc_size * j));
+			utrdlp[j].command_desc_base_addr_lo =
+				cpu_to_le32(lower_32_bits(cmd_desc_dma_addr));
+			utrdlp[j].command_desc_base_addr_hi =
+				cpu_to_le32(upper_32_bits(cmd_desc_dma_addr));
+
+			/*
+			 * Response upiu and prdt offset should be in DWs
+			 */
+			if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN) {
+				utrdlp[j].response_upiu_offset =
+					cpu_to_le16(response_offset);
+				utrdlp[j].prd_table_offset =
+					cpu_to_le16(prdt_offset);
+				utrdlp[j].response_upiu_length =
+					cpu_to_le16(ALIGNED_UPIU_SIZE);
+			} else {
+				utrdlp[j].response_upiu_offset =
+					cpu_to_le16(response_offset >> 2);
+				utrdlp[j].prd_table_offset =
+					cpu_to_le16(prdt_offset >> 2);
+				utrdlp[j].response_upiu_length =
+					cpu_to_le16(ALIGNED_UPIU_SIZE >> 2);
+			}
+
+			ufshcd_mcq_init_lrb(hba, hwq, &hwq->lrb[j], j);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_memory_configure);
+
+#define MCQ_CFG_n(r, i) \
+	(r) + MCQ_QCFG_SIZE * (i)
+#define MCQ_ROP_OFFSET_n(p, i) \
+	hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i)
+
+static inline void __iomem *mcq_rop_base(struct ufs_hba *hba,
+					 enum ufshcd_mcq_rop n, int i)
+{
+	struct ufshcd_mcq_rop_info_t *rop = &hba->mcq_rop[n];
+
+	return rop->base + rop->stride * i;
+}
+
+void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	u16 qsize;
+	int i;
+
+	for_each_hw_queue(hba, i) {
+		hwq = &hba->uhq[i];
+		hwq->id = i;
+		qsize = hwq->max_entries * MCQ_ENTRY_SIZE_IN_DWORD - 1;
+
+		/* SQLBA */
+		ufsmcq_writel(hba, lower_32_bits(hwq->sqe_dma_addr),
+			      MCQ_CFG_n(REG_SQLBA, i));
+		/* SQUBA */
+		ufsmcq_writel(hba, upper_32_bits(hwq->sqe_dma_addr),
+			      MCQ_CFG_n(REG_SQUBA, i));
+		/* SQDAO */
+		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQD, i),
+			      MCQ_CFG_n(REG_SQDAO, i));
+		/* SQISAO */
+		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQIS, i),
+			      MCQ_CFG_n(REG_SQISAO, i));
+
+		/* CQLBA */
+		ufsmcq_writel(hba, lower_32_bits(hwq->cqe_dma_addr),
+			      MCQ_CFG_n(REG_CQLBA, i));
+		/* CQUBA */
+		ufsmcq_writel(hba, upper_32_bits(hwq->cqe_dma_addr),
+			      MCQ_CFG_n(REG_CQUBA, i));
+		/* CQDAO */
+		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_CQD, i),
+			      MCQ_CFG_n(REG_CQDAO, i));
+		/* CQISAO */
+		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_CQIS, i),
+			      MCQ_CFG_n(REG_CQISAO, i));
+
+		/* Save the base addresses for quicker access */
+		hwq->mcq_sq_hp = mcq_rop_base(hba, ROP_SQD, i) + REG_SQHP;
+		hwq->mcq_sq_tp = mcq_rop_base(hba, ROP_SQD, i) + REG_SQTP;
+		hwq->mcq_cq_hp = mcq_rop_base(hba, ROP_CQD, i) + REG_CQHP;
+		hwq->mcq_cq_tp = mcq_rop_base(hba, ROP_CQD, i) + REG_CQTP;
+
+		/* enable CQIE.TEPS interrupt only for non-poll queues */
+		if (i < hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
+			writel(1, mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIE);
+
+		/* cqen|size */
+		ufsmcq_writel(hba, (1 << 31) | qsize, MCQ_CFG_n(REG_CQATTR, i));
+
+		/* sqen|size|cqid */
+		ufsmcq_writel(hba, (1 << 31) | qsize | (i << 16),
+			      MCQ_CFG_n(REG_SQATTR, i));
+	}
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_make_queues_operational);
+
+static void ufshcd_mcq_release_resource(struct ufs_hba *hba)
+{
+	struct ufshcd_res_info_t *res;
+	int i;
+
+	for (i = RES_MCQ; i < RES_MAX; i++) {
+		res = &hba->res[i];
+
+		if(res->base) {
+			devm_iounmap(hba->dev, res->base);
+			res->base = NULL;
+		}
+
+		if (res->is_alloc)
+			devm_kfree(hba->dev, res->resource);
+	}
+}
+
+static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
+{
+	struct platform_device *pdev = to_platform_device(hba->dev);
+	struct ufshcd_res_info_t *res;
+	struct resource *res_mem, *res_mcq;
+	int i, ret = 0;
+
+	memcpy(hba->res, ufshcd_res_info, sizeof(ufshcd_res_info));
+
+	for (i = 0; i < RES_MAX; i++) {
+		res = &hba->res[i];
+
+		res->resource = platform_get_resource_byname(pdev,
+							     IORESOURCE_MEM,
+							     res->name);
+		if (!res->resource) {
+			dev_info(hba->dev, "Resource %s not provided\n", res->name);
+			if (i == RES_MEM)
+				return -ENOMEM;
+			continue;
+		} else if (i == RES_MEM) {
+			res_mem = res->resource;
+			res->base = hba->mmio_base;
+			continue;
+		}
+
+		res->base = devm_ioremap_resource(hba->dev, res->resource);
+		if (IS_ERR(res->base)) {
+			dev_err(hba->dev, "Failed to map res %s, err = %d\n",
+					 res->name, (int)PTR_ERR(res->base));
+			res->base = NULL;
+			ret = PTR_ERR(res->base);
+			goto out_err;
+		}
+	}
+
+	res = &hba->res[RES_MCQ];
+	/* MCQ resource provided */
+	if (res->base)
+		goto out;
+
+	/* Manually allocate MCQ resource */
+	res_mcq = res->resource;
+	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
+	if (!res_mcq) {
+		dev_err(hba->dev, "Failed to alloate MCQ resource\n");
+		goto out_err;
+	}
+	res->is_alloc = true;
+
+	res_mcq->start = res_mem->start +
+			 mcq_sqattr_offset(hba->mcq_capabilities);
+	res_mcq->end = res_mcq->start + 32 * MCQ_QCFG_SIZE - 1;
+	res_mcq->flags = res_mem->flags;
+	res_mcq->name = "mcq";
+
+	ret = insert_resource(&iomem_resource, res_mcq);
+	if (ret) {
+		dev_err(hba->dev, "Failed to insert MCQ resource %d\n", ret);
+		goto out_err;
+	}
+
+	res->base = devm_ioremap_resource(hba->dev, res_mcq);
+	if (IS_ERR(res->base)) {
+		dev_err(hba->dev, "Map MCQ registers failed, err = %d\n",
+			(int)PTR_ERR(res->base));
+		ret = PTR_ERR(res->base);
+		res->base = NULL;
+		goto out_err;
+	}
+
+out:
+	hba->mcq_base = res->base;
+	return 0;
+
+out_err:
+	ufshcd_mcq_release_resource(hba);
+	return ret;
+}
+
+int ufshcd_mcq_init(struct ufs_hba *hba)
+{
+	struct Scsi_Host *host = hba->host;
+	struct ufs_hw_queue *hwq;
+	int i, ret = 0;
+
+	if (!is_mcq_supported(hba))
+		return 0;
+
+	ret = ufshcd_mcq_config_resource(hba);
+	if (ret) {
+		dev_err(hba->dev, "Failed to config MCQ resource\n");
+		return ret;
+	}
+
+	ret = ufshcd_vops_config_mcq_rop(hba);
+	if (ret) {
+		dev_err(hba->dev, "MCQ Runtime Operation Pointers not configured\n");
+		goto out_err;
+	}
+
+	hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
+	hba->nr_queues[HCTX_TYPE_READ] = 0;
+	hba->nr_queues[HCTX_TYPE_POLL] = 1;
+
+	for (i = 0; i < HCTX_MAX_TYPES; i++)
+		host->nr_hw_queues += hba->nr_queues[i];
+
+	host->can_queue = hba->nutrs;
+	host->cmd_per_lun = hba->nutrs;
+
+	/* One more reserved for dev_cmd_queue */
+	hba->nr_hw_queues = host->nr_hw_queues + 1;
+
+	hba->uhq = devm_kmalloc(hba->dev,
+				hba->nr_hw_queues * sizeof(struct ufs_hw_queue),
+				GFP_KERNEL);
+	if (!hba->uhq) {
+		dev_err(hba->dev, "Alloc ufs hw queue failed\n");
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	for_each_hw_queue(hba, i) {
+		hwq = &hba->uhq[i];
+		hwq->max_entries = hba->nutrs;
+		spin_lock_init(&hwq->sq_lock);
+		spin_lock_init(&hwq->cq_lock);
+	}
+	/* The very first HW queue is to serve dev_cmd */
+	hba->dev_cmd_queue = &hba->uhq[0];
+	/* Give dev_cmd_queue the minimal num of entries */
+	hba->dev_cmd_queue->max_entries = 2;
+
+	/* Selct MCQ mode */
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
+		      REG_UFS_MEM_CFG);
+	hba->use_mcq = true;
+
+	return 0;
+
+out_err:
+	ufshcd_mcq_release_resource(hba);
+	devm_kfree(hba->dev, hba->uhq);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_init);
+
+u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
+{
+	return readl(mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIS);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_read_cqis);
+
+void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
+{
+	writel(val, mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIS);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_write_cqis);
+
+/**
+ * ufshcd_mcq_enable_cq_intr - Enable MCQ completion queue interrupts
+ * @hba: per adapter instance
+ * @intrs: interrupt bits
+ */
+void ufshcd_mcq_enable_cq_intr(struct ufs_hba *hba, u32 intrs)
+{
+	int i;
+	u32 set;
+
+	for_each_hw_queue(hba, i) {
+		/* enable CQIS.TEPS interrupt only for non-poll queues */
+		if (i >= hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
+			continue;
+
+		set = readl(mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIE);
+		set |= intrs;
+		writel(set, mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIE);
+	}
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_cq_intr);
+
+/**
+ * ufshcd_mcq_disable_cq_intr - Disable MCQ completion queue interrupts
+ * @hba: per adapter instance
+ * @intrs: interrupt bits
+ */
+void ufshcd_mcq_disable_cq_intr(struct ufs_hba *hba, u32 intrs)
+{
+	int i;
+	u32 set;
+
+	for_each_hw_queue(hba, i) {
+		set = readl(mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIE);
+		set &= ~intrs;
+		writel(set, mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIE);
+	}
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_disable_cq_intr);
+
+void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
+{
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x2,
+		      REG_UFS_MEM_CFG);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
+
+void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
+{
+	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
+	ufshcd_writel(hba, msg->address_hi, REG_UFS_ESIUBA);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_config_esi);
+
+static inline u32 ufshcd_mcq_get_tag(struct ufs_hba *hba,
+				     struct ufs_hw_queue *hwq,
+				     struct cq_entry *cqe)
+{
+	dma_addr_t dma_addr;
+
+	dma_addr = ((u64)le32_to_cpu(cqe->command_desc_base_addr_hi) << 32) |
+		   (le32_to_cpu(cqe->command_desc_base_addr_lo) & 0xffffff80);
+
+	return (dma_addr - hwq->ucdl_dma_addr) /
+		sizeof(struct utp_transfer_cmd_desc);
+}
+
+static inline void ufshcd_mcq_process_event(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq)
+{
+	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+	struct ufshcd_lrb *lrbp;
+	u32 tag;
+
+	tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
+
+	lrbp = &hwq->lrb[tag];
+
+	ufshcd_compl_one_lrb(hba, lrbp, cqe);
+}
+
+unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq)
+{
+	unsigned long completed_reqs = 0;
+
+	ufshcd_mcq_update_cq_tp_slot(hwq);
+	while (!ufshcd_mcq_is_cq_empty(hwq)) {
+		ufshcd_mcq_process_event(hba, hwq);
+		ufshcd_mcq_inc_cq_hp_slot(hwq);
+		completed_reqs++;
+	}
+
+	if (completed_reqs)
+		ufshcd_mcq_update_cq_hp(hwq);
+
+	return completed_reqs;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
+
+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+				       struct ufs_hw_queue *hwq)
+{
+	unsigned long completed_reqs, flags;
+
+	spin_lock_irqsave(&hwq->cq_lock, flags);
+	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+	spin_unlock_irqrestore(&hwq->cq_lock, flags);
+
+	return completed_reqs;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_lock);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2cdc146..429b3e2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -42,6 +42,11 @@
 #define UFSHCD_ENABLE_INTRS	(UTP_TRANSFER_REQ_COMPL |\
 				 UTP_TASK_REQ_COMPL |\
 				 UFSHCD_ERROR_MASK)
+
+#define UFSHCD_ENABLE_MCQ_INTRS	(UTP_TASK_REQ_COMPL |\
+				 UFSHCD_ERROR_MASK |\
+				 MCQ_CQ_EVENT_STATUS)
+
 /* UIC command timeout, unit: ms */
 #define UIC_CMD_TIMEOUT	500
 
@@ -101,11 +106,13 @@
 		_ret;                                                   \
 	})
 
-#define ufshcd_hex_dump(prefix_str, buf, len) do {                       \
-	size_t __len = (len);                                            \
-	print_hex_dump(KERN_ERR, prefix_str,                             \
-		       __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,\
-		       16, 4, buf, __len, false);                        \
+#define ufshcd_hex_dump(prefix_str, buf, len) do {			\
+	size_t __len = (len);						\
+									\
+	print_hex_dump(KERN_ERR, prefix_str,				\
+		       __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE, \
+		       16, 4, buf, __len, false);			\
+									\
 } while (0)
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
@@ -313,10 +320,11 @@ static void ufshcd_scsi_block_requests(struct ufs_hba *hba)
 		scsi_block_requests(hba->host);
 }
 
-static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
+static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
+				      struct ufshcd_lrb *lrbp,
 				      enum ufs_trace_str_t str_t)
 {
-	struct utp_upiu_req *rq = hba->lrb[tag].ucd_req_ptr;
+	struct utp_upiu_req *rq = lrbp->ucd_req_ptr;
 	struct utp_upiu_header *header;
 
 	if (!trace_ufshcd_upiu_enabled())
@@ -325,7 +333,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 	if (str_t == UFS_CMD_SEND)
 		header = &rq->header;
 	else
-		header = &hba->lrb[tag].ucd_rsp_ptr->header;
+		header = &lrbp->ucd_rsp_ptr->header;
 
 	trace_ufshcd_upiu(dev_name(hba->dev), str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
@@ -382,13 +390,13 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
 }
 
-static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
+static void ufshcd_add_command_trace(struct ufs_hba *hba,
+				     struct ufshcd_lrb *lrbp,
 				     enum ufs_trace_str_t str_t)
 {
 	u64 lba = 0;
 	u8 opcode = 0, group_id = 0;
 	u32 intr, doorbell;
-	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	int transfer_len = -1;
@@ -397,7 +405,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	/* trace UPIU also */
-	ufshcd_add_cmd_upiu_trace(hba, tag, str_t);
+	ufshcd_add_cmd_upiu_trace(hba, lrbp, str_t);
 	if (!trace_ufshcd_command_enabled())
 		return;
 
@@ -422,7 +430,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
+	trace_ufshcd_command(dev_name(hba->dev), str_t, lrbp->task_tag,
 			doorbell, transfer_len, intr, lba, opcode, group_id);
 }
 
@@ -742,8 +750,11 @@ static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
  * This function is used to get the OCS field from UTRD
  * Returns the OCS field in the UTRD
  */
-static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp)
+static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp,
+				      struct cq_entry *cqe)
 {
+	if (cqe)
+		return le32_to_cpu(cqe->status) & MASK_OCS;
 	return le32_to_cpu(lrbp->utr_descriptor_ptr->header.dword_2) & MASK_OCS;
 }
 
@@ -2134,27 +2145,39 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
 /**
  * ufshcd_send_command - Send SCSI or device management commands
  * @hba: per adapter instance
- * @task_tag: Task tag of the command
+ * @lrbp: pointer to lrb
+ * @hwq: hardware queue
  */
 static inline
-void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
+void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			 struct ufs_hw_queue *hwq)
 {
-	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
 	unsigned long flags;
 
 	lrbp->issue_time_stamp = ktime_get();
 	lrbp->compl_time_stamp = ktime_set(0, 0);
-	ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
+	ufshcd_add_command_trace(hba, lrbp, UFS_CMD_SEND);
 	ufshcd_clk_scaling_start_busy(hba);
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
 		ufshcd_start_monitor(hba, lrbp);
 
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	if (hba->vops && hba->vops->setup_xfer_req)
-		hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
-	__set_bit(task_tag, &hba->outstanding_reqs);
-	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	if (is_mcq_enabled(hba)) {
+		int utrd_size = sizeof(struct utp_transfer_req_desc);
+
+		spin_lock(&hwq->sq_lock);
+		memcpy(hwq->sqe_base_addr + (hwq->sq_tp_slot * utrd_size),
+		       lrbp->utr_descriptor_ptr, utrd_size);
+		ufshcd_inc_tp(hwq);
+		spin_unlock(&hwq->sq_lock);
+	} else {
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		if (hba->vops && hba->vops->setup_xfer_req)
+			hba->vops->setup_xfer_req(hba, lrbp->task_tag, !!lrbp->cmd);
+		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
+		ufshcd_writel(hba, 1 << lrbp->task_tag,
+			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	}
 }
 
 /**
@@ -2242,6 +2265,12 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	if (err)
 		dev_err(hba->dev, "crypto setup failed\n");
 
+	hba->mcq_sup = (hba->capabilities & MASK_MCQ_SUPPORT) >> 30;
+	if (hba->mcq_sup) {
+		hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
+		hba->ext_iid_sup = (hba->mcq_capabilities & MASK_EXT_IID_SUPPORT)
+			>> 10;
+	}
 	return err;
 }
 
@@ -2558,7 +2587,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_flags)
 				UPIU_TRANSACTION_COMMAND, upiu_flags,
 				lrbp->lun, lrbp->task_tag);
 	ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
-				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
+				UPIU_COMMAND_SET_TYPE_SCSI |
+				(lrbp->hw_queue_id << 4), 0, 0, 0);
 
 	/* Total EHS length and Data segment length will be zero */
 	ucd_req_ptr->header.dword_2 = 0;
@@ -2706,25 +2736,26 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  */
 static int ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i, ret;
+	int i, queue_offset = 0, ret;
+	struct ufs_hba *hba = shost_priv(shost);
 
 	for (i = 0; i < shost->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
 
-		switch (i) {
-		case HCTX_TYPE_DEFAULT:
-		case HCTX_TYPE_POLL:
-			map->nr_queues = 1;
-			break;
-		case HCTX_TYPE_READ:
-			map->nr_queues = 0;
+		map->nr_queues = hba->nr_queues[i];
+		if (!map->nr_queues)
 			continue;
-		default:
-			WARN_ON_ONCE(true);
-		}
-		map->queue_offset = 0;
+
+		map->queue_offset = queue_offset;
+		if (i == HCTX_TYPE_POLL && !is_mcq_enabled(hba))
+			map->queue_offset = 0;
+
 		ret = blk_mq_map_queues(map);
-		WARN_ON_ONCE(ret);
+
+		if (ret)
+			return ret;
+
+		queue_offset += map->nr_queues;
 	}
 
 	return 0;
@@ -2764,6 +2795,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
+	struct ufs_hw_queue *hwq;
 
 	WARN_ONCE(tag < 0 || tag >= hba->nutrs, "Invalid tag %d\n", tag);
 
@@ -2826,7 +2858,11 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
 		(hba->clk_gating.state != CLKS_ON));
 
-	lrbp = &hba->lrb[tag];
+	if (is_mcq_enabled(hba))
+		lrbp = ufshcd_mcq_find_lrb(hba, scsi_cmd_to_rq(cmd), &hwq);
+	else
+		lrbp = &hba->lrb[tag];
+
 	WARN_ON(lrbp->cmd);
 	lrbp->cmd = cmd;
 	lrbp->task_tag = tag;
@@ -2848,8 +2884,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	ufshcd_send_command(hba, tag);
-
+	ufshcd_send_command(hba, lrbp, hwq);
 out:
 	rcu_read_unlock();
 
@@ -2966,7 +3001,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->dev_cmd.complete = NULL;
 	if (likely(time_left)) {
-		err = ufshcd_get_tr_ocs(lrbp);
+		err = ufshcd_get_tr_ocs(lrbp, hba->dev_cmd.cqe);
 		if (!err)
 			err = ufshcd_dev_cmd_completion(hba, lrbp);
 	}
@@ -2974,7 +3009,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
 	if (!time_left) {
 		err = -ETIMEDOUT;
-		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
+		dev_err(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
 		if (!ufshcd_clear_cmds(hba, 1U << lrbp->task_tag))
 			/* successfully cleared the command, retry if needed */
@@ -3005,7 +3040,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		enum dev_cmd_type cmd_type, int timeout)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	const u32 tag = hba->reserved_slot;
+	u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err;
 
@@ -3014,17 +3049,22 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	down_read(&hba->clk_scaling_lock);
 
-	lrbp = &hba->lrb[tag];
+	if (is_mcq_enabled(hba)) {
+		tag = hba->dev_cmd_queue->sq_tp_slot;
+		lrbp = &hba->dev_cmd_queue->lrb[tag];
+	} else {
+		lrbp = &hba->lrb[tag];
+	}
 	WARN_ON(lrbp->cmd);
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
 	if (unlikely(err))
 		goto out;
 
 	hba->dev_cmd.complete = &wait;
+	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
-
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, lrbp, hba->dev_cmd_queue);
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
@@ -3620,11 +3660,11 @@ static int ufshcd_get_ref_clk_gating_wait(struct ufs_hba *hba)
  * ufshcd_memory_alloc - allocate memory for host memory space data structures
  * @hba: per adapter instance
  *
- * 1. Allocate DMA memory for Command Descriptor array
- *	Each command descriptor consist of Command UPIU, Response UPIU and PRDT
- * 2. Allocate DMA memory for UTP Transfer Request Descriptor List (UTRDL).
- * 3. Allocate DMA memory for UTP Task Management Request Descriptor List
+ * 1. Allocate DMA memory for UTP Task Management Request Descriptor List
  *	(UTMRDL)
+ * 2. Allocate DMA memory for Command Descriptor array
+ *	Each command descriptor consist of Command UPIU, Response UPIU and PRDT
+ * 3. Allocate DMA memory for UTP Transfer Request Descriptor List (UTRDL).
  * 4. Allocate memory for local reference block(lrb).
  *
  * Returns 0 for success, non-zero in case of failure
@@ -3633,6 +3673,25 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 {
 	size_t utmrdl_size, utrdl_size, ucdl_size;
 
+	/*
+	 * Allocate memory for UTP Task Management descriptors
+	 * UFSHCI requires 1024 byte alignment of UTMRD
+	 */
+	utmrdl_size = sizeof(struct utp_task_req_desc) * hba->nutmrs;
+	hba->utmrdl_base_addr = dmam_alloc_coherent(hba->dev,
+						    utmrdl_size,
+						    &hba->utmrdl_dma_addr,
+						    GFP_KERNEL);
+	if (!hba->utmrdl_base_addr ||
+	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
+		dev_err(hba->dev,
+		"Task Management Descriptor Memory allocation failed\n");
+		goto out;
+	}
+
+	if (is_mcq_enabled(hba))
+		return ufshcd_mcq_memory_alloc(hba);
+
 	/* Allocate memory for UTP command descriptors */
 	ucdl_size = (sizeof(struct utp_transfer_cmd_desc) * hba->nutrs);
 	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
@@ -3669,22 +3728,6 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto out;
 	}
 
-	/*
-	 * Allocate memory for UTP Task Management descriptors
-	 * UFSHCI requires 1024 byte alignment of UTMRD
-	 */
-	utmrdl_size = sizeof(struct utp_task_req_desc) * hba->nutmrs;
-	hba->utmrdl_base_addr = dmam_alloc_coherent(hba->dev,
-						    utmrdl_size,
-						    &hba->utmrdl_dma_addr,
-						    GFP_KERNEL);
-	if (!hba->utmrdl_base_addr ||
-	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
-		dev_err(hba->dev,
-		"Task Management Descriptor Memory allocation failed\n");
-		goto out;
-	}
-
 	/* Allocate memory for local reference block */
 	hba->lrb = devm_kcalloc(hba->dev,
 				hba->nutrs, sizeof(struct ufshcd_lrb),
@@ -3711,7 +3754,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
  * 3. Save the corresponding addresses of UTRD, UCD.CMD, UCD.RSP and UCD.PRDT
  * into local reference block.
  */
-static void ufshcd_host_memory_configure(struct ufs_hba *hba)
+static int ufshcd_host_memory_configure(struct ufs_hba *hba)
 {
 	struct utp_transfer_req_desc *utrdlp;
 	dma_addr_t cmd_desc_dma_addr;
@@ -3721,6 +3764,9 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 	int cmd_desc_size;
 	int i;
 
+	if (is_mcq_enabled(hba))
+		return ufshcd_mcq_memory_configure(hba);
+
 	utrdlp = hba->utrdl_base_addr;
 
 	response_offset =
@@ -3759,6 +3805,8 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 
 		ufshcd_init_lrb(hba, &hba->lrb[i], i);
 	}
+
+	return 0;
 }
 
 /**
@@ -4503,7 +4551,10 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
 	u32 reg;
 
 	/* Enable required interrupts */
-	ufshcd_enable_intr(hba, UFSHCD_ENABLE_INTRS);
+	if (is_mcq_enabled(hba))
+		ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
+	else
+		ufshcd_enable_intr(hba, UFSHCD_ENABLE_INTRS);
 
 	/* Configure interrupt aggregation */
 	if (ufshcd_is_intr_aggr_allowed(hba))
@@ -4511,11 +4562,17 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
 	else
 		ufshcd_disable_intr_aggr(hba);
 
-	/* Configure UTRL and UTMRL base address registers */
-	ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
-			REG_UTP_TRANSFER_REQ_LIST_BASE_L);
-	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
-			REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+	if (is_mcq_enabled(hba)) {
+		ufshcd_mcq_make_queues_operational(hba);
+	} else {
+		/* Configure UTRL base address registers */
+		ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
+				REG_UTP_TRANSFER_REQ_LIST_BASE_L);
+		ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
+				REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+	}
+
+	/* Configure UTMRL base address registers */
 	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
 			REG_UTP_TASK_REQ_LIST_BASE_L);
 	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
@@ -5152,14 +5209,15 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
  * Returns result of the command to notify SCSI midlayer
  */
 static inline int
-ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			   struct cq_entry *cqe)
 {
 	int result = 0;
 	int scsi_status;
 	enum utp_ocs ocs;
 
 	/* overall command status of utrd */
-	ocs = ufshcd_get_tr_ocs(lrbp);
+	ocs = ufshcd_get_tr_ocs(lrbp, cqe);
 
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR) {
 		if (be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_1) &
@@ -5323,6 +5381,31 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 	ufshcd_clk_scaling_update_busy(hba);
 }
 
+void ufshcd_compl_one_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			  struct cq_entry *cqe)
+{
+	struct scsi_cmnd *cmd;
+
+	lrbp->compl_time_stamp = ktime_get();
+	cmd = lrbp->cmd;
+	if (cmd) {
+		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
+			ufshcd_update_monitor(hba, lrbp);
+		ufshcd_add_command_trace(hba, lrbp, UFS_CMD_COMP);
+		cmd->result = ufshcd_transfer_rsp_status(hba, lrbp, cqe);
+		ufshcd_release_scsi_cmd(hba, lrbp);
+		/* Do not touch lrbp after scsi done */
+		scsi_done(cmd);
+	} else if ((lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
+		    lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) &&
+		   hba->dev_cmd.complete) {
+			hba->dev_cmd.cqe = cqe;
+			ufshcd_add_command_trace(hba, lrbp, UFS_DEV_COMP);
+			complete(hba->dev_cmd.complete);
+			ufshcd_clk_scaling_update_busy(hba);
+	}
+}
+
 /**
  * __ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
@@ -5332,30 +5415,11 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 					unsigned long completed_reqs)
 {
 	struct ufshcd_lrb *lrbp;
-	struct scsi_cmnd *cmd;
 	int index;
 
 	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
 		lrbp = &hba->lrb[index];
-		lrbp->compl_time_stamp = ktime_get();
-		cmd = lrbp->cmd;
-		if (cmd) {
-			if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
-				ufshcd_update_monitor(hba, lrbp);
-			ufshcd_add_command_trace(hba, index, UFS_CMD_COMP);
-			cmd->result = ufshcd_transfer_rsp_status(hba, lrbp);
-			ufshcd_release_scsi_cmd(hba, lrbp);
-			/* Do not touch lrbp after scsi done */
-			scsi_done(cmd);
-		} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
-			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
-			if (hba->dev_cmd.complete) {
-				ufshcd_add_command_trace(hba, index,
-							 UFS_DEV_COMP);
-				complete(hba->dev_cmd.complete);
-				ufshcd_clk_scaling_update_busy(hba);
-			}
-		}
+		ufshcd_compl_one_lrb(hba, lrbp, NULL);
 	}
 }
 
@@ -5366,9 +5430,15 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 {
 	struct ufs_hba *hba = shost_priv(shost);
-	unsigned long completed_reqs, flags;
+	struct ufs_hw_queue *hwq;
+	unsigned long completed_reqs = 0, flags;
 	u32 tr_doorbell;
 
+	if (is_mcq_enabled(hba)) {
+		hwq = &hba->uhq[queue_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+		return ufshcd_mcq_poll_cqe_lock(hba, hwq);
+	}
+
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
@@ -5392,7 +5462,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
-static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
+irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 {
 	/* Resetting interrupt aggregation counters first and reading the
 	 * DOOR_BELL afterward allows us to handle all the completed requests.
@@ -5416,6 +5486,43 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(ufshcd_transfer_req_compl);
+
+/**
+ * ufshcd_handle_mcq_cq_events - handle MCQ completion queue events
+ * @hba: per adapter instance
+ *
+ * Returns
+ *  IRQ_HANDLED - If interrupt is valid
+ *  IRQ_NONE    - If invalid interrupt
+ */
+static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	unsigned long outstanding_cqs;
+	unsigned int nr_queues;
+	int i, ret;
+	u32 events;
+
+	ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
+	if (ret)
+		outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
+
+	/* Exclude the poll queues */
+	nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	for_each_set_bit(i, &outstanding_cqs, nr_queues) {
+		hwq = &hba->uhq[i];
+
+		events = ufshcd_mcq_read_cqis(hba, i);
+		if (events)
+			ufshcd_mcq_write_cqis(hba, events, i);
+
+		if (events & UFSHCD_MCQ_CQIS_TEPS)
+			ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+	}
+
+	return IRQ_HANDLED;
+}
 
 int __ufshcd_write_ee_control(struct ufs_hba *hba, u32 ee_ctrl_mask)
 {
@@ -5947,10 +6054,23 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 	ufshcd_scsi_unblock_requests(hba);
 }
 
-/* Complete requests that have door-bell cleared */
+/*
+ * Complete requests that have door-bell cleared and/or pending completion
+ * entries on completion queues if MCQ is enabled
+ */
 static void ufshcd_complete_requests(struct ufs_hba *hba)
 {
-	ufshcd_transfer_req_compl(hba);
+	struct ufs_hw_queue *hwq;
+	int i;
+
+	if (is_mcq_enabled(hba)) {
+		for_each_hw_queue(hba, i) {
+			hwq = &hba->uhq[i];
+			ufshcd_mcq_poll_cqe_lock(hba, hwq);
+		}
+	} else {
+		ufshcd_transfer_req_compl(hba);
+	}
 	ufshcd_tmc_handler(hba);
 }
 
@@ -6213,7 +6333,6 @@ static void ufshcd_err_handler(struct work_struct *work)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_err_handling_prepare(hba);
-	/* Complete requests that have door-bell cleared by h/w */
 	ufshcd_complete_requests(hba);
 	spin_lock_irqsave(hba->host->host_lock, flags);
 again:
@@ -6605,6 +6724,9 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
 	if (intr_status & UTP_TRANSFER_REQ_COMPL)
 		retval |= ufshcd_transfer_req_compl(hba);
 
+	if (intr_status & MCQ_CQ_EVENT_STATUS)
+		retval |= ufshcd_handle_mcq_cq_events(hba);
+
 	return retval;
 }
 
@@ -6826,7 +6948,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum query_opcode desc_op)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	const u32 tag = hba->reserved_slot;
+	u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
 	u8 upiu_flags;
@@ -6836,7 +6958,12 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	down_read(&hba->clk_scaling_lock);
 
-	lrbp = &hba->lrb[tag];
+	if (is_mcq_enabled(hba)) {
+		tag = hba->dev_cmd_queue->sq_tp_slot;
+		lrbp = &hba->dev_cmd_queue->lrb[tag];
+	} else {
+		lrbp = &hba->lrb[tag];
+	}
 	WARN_ON(lrbp->cmd);
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
@@ -6869,10 +6996,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
 	hba->dev_cmd.complete = &wait;
+	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, lrbp, hba->dev_cmd_queue);
 	/*
 	 * ignore the returning value here - ufshcd_check_query_response is
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
@@ -7728,6 +7856,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	/* getting Specification Version in big endian format */
 	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+
+	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
+
 	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
@@ -8184,6 +8315,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 		ret = ufshcd_device_params_init(hba);
 		if (ret)
 			goto out;
+
+		if (is_mcq_enabled(hba) && hba->dev_info.bqueuedepth)
+			ufshcd_mcq_config_mac(hba);
 	}
 
 	ufshcd_tune_unipro_params(hba);
@@ -9641,6 +9775,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto out_disable;
 	}
 
+	err = ufshcd_mcq_init(hba);
+	if (err)
+		dev_err(hba->dev, "MCQ init failed\n");
+
 	/* Allocate memory for host memory space */
 	err = ufshcd_memory_alloc(hba);
 	if (err) {
@@ -9651,8 +9789,14 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	/* Configure LRB */
 	ufshcd_host_memory_configure(hba);
 
-	host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
-	host->cmd_per_lun = hba->nutrs - UFSHCD_NUM_RESERVED;
+	if (!is_mcq_enabled(hba)) {
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = 1;
+		hba->nr_queues[HCTX_TYPE_POLL] = 1;
+		hba->nr_hw_queues = 1;
+
+		host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
+		host->cmd_per_lun = hba->nutrs - UFSHCD_NUM_RESERVED;
+	}
 	host->max_id = UFSHCD_MAX_ID;
 	host->max_lun = UFS_MAX_LUNS;
 	host->max_channel = UFSHCD_MAX_CHANNEL;
@@ -9714,6 +9858,14 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		hba->is_irq_enabled = true;
 	}
 
+	if (is_mcq_enabled(hba)) {
+		err = ufshcd_vops_config_mcq_esi(hba);
+		if (err)
+			dev_err(hba->dev, "ESI is not available %d\n", err);
+		else
+			hba->use_mcq_esi = true;
+	}
+
 	err = scsi_add_host(host, hba->dev);
 	if (err) {
 		dev_err(hba->dev, "scsi_add_host failed\n");
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fe..b137aae 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -589,6 +589,7 @@ struct ufs_dev_info {
 	u8	*model;
 	u16	wspecversion;
 	u32	clk_gating_wait_us;
+	u8	bqueuedepth;
 
 	/* UFS HPB related flag */
 	bool	hpb_enabled;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a92..8e90835 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -17,6 +17,7 @@
 #include <linux/blk-mq.h>
 #include <linux/devfreq.h>
 #include <linux/pm_runtime.h>
+#include <linux/msi.h>
 #include <scsi/scsi_device.h>
 #include <ufs/unipro.h>
 #include <ufs/ufs.h>
@@ -192,6 +193,7 @@ struct ufshcd_lrb {
 #endif
 
 	bool req_abort_skip;
+	u32 hw_queue_id;
 };
 
 /**
@@ -218,6 +220,7 @@ struct ufs_dev_cmd {
 	struct mutex lock;
 	struct completion *complete;
 	struct ufs_query query;
+	struct cq_entry *cqe;
 };
 
 /**
@@ -293,6 +296,9 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @get_outstanding_cqs: called to get oustanding completion queues
+ * @config_mcq_rop: called to config Runtime Operation Pointers
+ * @config_mcq_esi: called to config MCQ ESI handlers
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -331,6 +337,10 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
+				       unsigned long *ocqs);
+	int	(*config_mcq_rop)(struct ufs_hba *hba);
+	int	(*config_mcq_esi)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
@@ -713,6 +723,39 @@ struct ufs_hba_monitor {
 	bool enabled;
 };
 
+struct ufshcd_res_info_t {
+	char *name;
+	struct resource *resource;
+	bool is_alloc;
+	void __iomem *base;
+};
+
+enum ufshcd_res {
+	RES_MEM,
+	RES_MCQ,
+	RES_MCQ_SQD,
+	RES_MCQ_SQIS,
+	RES_MCQ_CQD,
+	RES_MCQ_CQIS,
+	RES_MCQ_VS,
+	RES_MAX,
+};
+
+/* MCQ Runtime Operation Pointer info structure */
+struct ufshcd_mcq_rop_info_t {
+	unsigned long offset;
+	unsigned long stride;
+	void __iomem *base;
+};
+
+enum ufshcd_mcq_rop {
+	ROP_SQD,
+	ROP_SQIS,
+	ROP_CQD,
+	ROP_CQIS,
+	ROP_MAX,
+};
+
 /**
  * struct ufs_hba - per adapter private structure
  * @mmio_base: UFSHCI base register address
@@ -737,6 +780,7 @@ struct ufs_hba_monitor {
  * @outstanding_lock: Protects @outstanding_reqs.
  * @outstanding_reqs: Bits representing outstanding transfer requests
  * @capabilities: UFS Controller Capabilities
+ * @mcq_capabilities: UFS Multi Command Queue capabilities
  * @nutrs: Transfer Request Queue depth supported by controller
  * @nutmrs: Task Management Queue depth supported by controller
  * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
@@ -818,6 +862,14 @@ struct ufs_hba_monitor {
  *	device
  * @complete_put: whether or not to call ufshcd_rpm_put() from inside
  *	ufshcd_resume_complete()
+ * @uhq: array of supported hardware queues
+ * @mcq_base: Multi command queue registers base address
+ * @ucd_pool: dma pool of UCD descriptors
+ * @dao_offset: value used to calculate the SQ and CQ DAO
+ * @use_mcq: track if MCQ is enabled
+ * @mcq_sup: track if MCQ is supported by UFSHC
+ * @ext_iid_sup: EXT_IID support by UFS device
+ * @use_mcq_esi: track if MCQ ESI is used
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -858,6 +910,7 @@ struct ufs_hba {
 	unsigned long outstanding_reqs;
 
 	u32 capabilities;
+	u32 mcq_capabilities;
 	int nutrs;
 	int nutmrs;
 	u32 reserved_slot;
@@ -965,8 +1018,133 @@ struct ufs_hba {
 #endif
 	u32 luns_avail;
 	bool complete_put;
+	struct ufs_hw_queue *uhq;
+	struct ufs_hw_queue *dev_cmd_queue;
+	unsigned int nr_queues[HCTX_MAX_TYPES];
+	unsigned int nr_hw_queues;
+	void __iomem *mcq_base;
+	struct ufshcd_res_info_t res[RES_MAX];
+	struct ufshcd_mcq_rop_info_t mcq_rop[ROP_MAX];
+	struct dma_pool *ucd_pool;
+	u32 dao_offset;
+	bool use_mcq;
+	bool mcq_sup;
+	bool ext_iid_sup;
+	bool use_mcq_esi;
+};
+
+enum {
+	ESIVEC_CQ,
+	ESIVEC_SQ,
+	ESIVEC_MAX,
+};
+
+/**
+ * @ucdl_base_addr: UFS Command Descriptor base address
+ * @sqe_base_addr: submission queue entry base address
+ * @sqe_shadow_addr: submission queue entry shadow address
+ * @ucdl_dma_addr: UFS Command Descriptor DMA address
+ * @sqe_dma_addr: submission queue dma address
+ * @cqe_base_addr: completion queue base address
+ * @cqe_dma_addr: completion queue dma address
+ * @lrb: array of lrb for this hardware queue
+ * @max_entries: max number of slots in this hardware queue
+ * @sq_tp_slot: current slot to which SQ tail pointer is pointing
+ * @sq_hp_slot: current slot to which SQ head pointer is pointing
+ * @cq_tp_slot: current slot to which CQ tail pointer is pointing
+ * @cq_hp_slot: current slot to which CQ head pointer is pointing
+ */
+struct ufs_hw_queue {
+	struct utp_transfer_cmd_desc *ucdl_base_addr;
+	void *sqe_base_addr;
+	struct utp_transfer_req_desc *sqe_shadow_addr;
+	dma_addr_t ucdl_dma_addr;
+	dma_addr_t sqe_dma_addr;
+	struct cq_entry *cqe_base_addr;
+	dma_addr_t cqe_dma_addr;
+	struct ufshcd_lrb *lrb;
+	u32 max_entries;
+	u32 id;
+
+	void __iomem *mcq_sq_hp;
+	void __iomem *mcq_sq_tp;
+	void __iomem *mcq_cq_hp;
+	void __iomem *mcq_cq_tp;
+
+	spinlock_t sq_lock;
+	u32 sq_tp_slot;
+	u32 sq_hp_slot;
+	spinlock_t cq_lock;
+	u32 cq_tp_slot;
+	u32 cq_hp_slot;
 };
 
+#define for_each_hw_queue(hba, i) \
+	for ((i) = 0; (i) < (hba)->nr_hw_queues; (i) ++)
+
+#define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
+
+static inline bool is_mcq_enabled(struct ufs_hba *hba)
+{
+	return hba->use_mcq;
+}
+
+static inline bool is_mcq_supported(struct ufs_hba *hba)
+{
+	return hba->mcq_sup;
+}
+
+static inline bool ufshcd_is_hwq_full(struct ufs_hw_queue *q)
+{
+	return (q->sq_hp_slot == ((q->sq_tp_slot + 1) %
+				      q->max_entries));
+}
+
+static inline bool ufshcd_is_hwq_empty(struct ufs_hw_queue *q)
+{
+	return (q->sq_tp_slot == q->sq_hp_slot);
+}
+
+static inline void ufshcd_inc_tp(struct ufs_hw_queue *q)
+{
+	u32 next_slot = ((q->sq_tp_slot + 1) % q->max_entries);
+	u32 val = next_slot * sizeof(struct utp_transfer_req_desc);
+
+	q->sq_tp_slot = next_slot;
+
+	writel(val, q->mcq_sq_tp);
+}
+
+static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
+{
+	struct cq_entry *cqe = q->cqe_base_addr;
+
+	return cqe + q->cq_hp_slot;
+}
+
+static inline bool ufshcd_mcq_is_cq_empty(struct ufs_hw_queue *q)
+{
+	return q->cq_hp_slot == q->cq_tp_slot;
+}
+
+static inline void ufshcd_mcq_inc_cq_hp_slot(struct ufs_hw_queue *q)
+{
+	q->cq_hp_slot ++;
+	if (q->cq_hp_slot == q->max_entries)
+		q->cq_hp_slot = 0;
+}
+
+static inline void ufshcd_mcq_update_cq_hp(struct ufs_hw_queue *q)
+{
+	writel(q->cq_hp_slot * sizeof(struct cq_entry), q->mcq_cq_hp);
+}
+
+static inline void ufshcd_mcq_update_cq_tp_slot(struct ufs_hw_queue *q)
+{
+	u32 val = readl(q->mcq_cq_tp);
+	q->cq_tp_slot = val / sizeof(struct cq_entry);
+}
+
 /* Returns true if clocks can be gated. Otherwise false */
 static inline bool ufshcd_is_clkgating_allowed(struct ufs_hba *hba)
 {
@@ -1017,11 +1195,16 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
-#define ufshcd_writel(hba, val, reg)	\
+#define ufshcd_writel(hba, val, reg)		\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
 	readl((hba)->mmio_base + (reg))
 
+#define ufsmcq_writel(hba, val, reg)	\
+	writel((val), (hba)->mcq_base + (reg))
+#define ufsmcq_readl(hba, reg)	\
+	readl((hba)->mcq_base + (reg))
+
 /**
  * ufshcd_rmwl - perform read/modify/write for a controller register
  * @hba: per adapter instance
@@ -1100,6 +1283,27 @@ extern int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 			struct ufs_pa_layer_attr *desired_pwr_mode);
 extern int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode);
+extern void ufshcd_compl_one_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+				 struct cq_entry *cqe);
+extern int ufshcd_mcq_init(struct ufs_hba *hba);
+extern void ufshcd_mcq_enable(struct ufs_hba *hba);
+extern int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
+extern int ufshcd_mcq_memory_configure(struct ufs_hba *hba);
+extern void ufshcd_mcq_config_mac(struct ufs_hba *hba);
+extern u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
+extern void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
+extern void ufshcd_mcq_enable_cq_intr(struct ufs_hba *hba, u32 intrs);
+extern void ufshcd_mcq_disable_cq_intr(struct ufs_hba *hba, u32 intrs);
+extern void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
+extern void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
+extern unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq);
+extern unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+				       struct ufs_hw_queue *hwq);
+extern void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
+extern struct ufshcd_lrb * ufshcd_mcq_find_lrb(struct ufs_hba *hba,
+					       struct request *req,
+					       struct ufs_hw_queue **hq);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
@@ -1232,6 +1436,31 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline int ufshcd_vops_get_outstanding_cqs(struct ufs_hba *hba,
+						  unsigned long *ocqs)
+{
+	if (hba->vops && hba->vops->get_outstanding_cqs)
+		return hba->vops->get_outstanding_cqs(hba, ocqs);
+
+	return -EOPNOTSUPP;
+}
+
+static inline int ufshcd_vops_config_mcq_rop(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_mcq_rop)
+		return hba->vops->config_mcq_rop(hba);
+
+	return -EOPNOTSUPP;
+}
+
+static inline int ufshcd_vops_config_mcq_esi(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_mcq_esi)
+		return hba->vops->config_mcq_esi(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index f81aa95..2643efd 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -22,6 +22,7 @@ enum {
 /* UFSHCI Registers */
 enum {
 	REG_CONTROLLER_CAPABILITIES		= 0x00,
+	REG_MCQCAP				= 0x04,
 	REG_UFS_VERSION				= 0x08,
 	REG_CONTROLLER_DEV_ID			= 0x10,
 	REG_CONTROLLER_PROD_ID			= 0x14,
@@ -56,9 +57,24 @@ enum {
 	REG_UFS_CCAP				= 0x100,
 	REG_UFS_CRYPTOCAP			= 0x104,
 
+	REG_UFS_MEM_CFG				= 0x300,
+	REG_UFS_MCQ_CFG				= 0x380,
+	REG_UFS_ESILBA				= 0x384,
+	REG_UFS_ESIUBA				= 0x388,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
 
+#define MCQ_CFG_MAC_OFFSET	8
+#define MCQ_CFG_MAC_MASK	UFS_MASK(0x1FF, MCQ_CFG_MAC_OFFSET)
+
+#define MCQ_QCFGPTR_MASK	0xff
+#define MCQ_QCFGPTR_UNIT	0x200
+#define mcq_sqattr_offset(c) \
+	(((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT
+
+#define MCQ_ENTRY_SIZE_IN_DWORD	8
+#define MCQ_QCFG_SIZE	0x40
+
 /* Controller capability masks */
 enum {
 	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
@@ -68,6 +84,53 @@ enum {
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
 	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
 	MASK_CRYPTO_SUPPORT			= 0x10000000,
+	MASK_MCQ_SUPPORT			= 0x40000000,
+};
+
+/* MCQ capability mask */
+enum {
+	MASK_EXT_IID_SUPPORT = 0x00000400,
+	MASK_ROUND_ROBIN_PRI_SUPP = 0x00000200,
+};
+
+enum {
+	REG_SQATTR		= 0x0,
+	REG_SQLBA		= 0x4,
+	REG_SQUBA		= 0x8,
+	REG_SQDAO		= 0xC,
+	REG_SQISAO		= 0x10,
+	REG_SQCFG		= 0x14,
+
+	REG_CQATTR		= 0x20,
+	REG_CQLBA		= 0x24,
+	REG_CQUBA		= 0x28,
+	REG_CQDAO		= 0x2C,
+	REG_CQISAO		= 0x30,
+	REG_CQCFG		= 0x34,
+};
+
+enum {
+	REG_SQHP		= 0x0,
+	REG_SQTP		= 0x4,
+	REG_SQRTC		= 0x8,
+	REG_SQCTI		= 0xC,
+	REG_SQRTS		= 0x10,
+};
+
+enum {
+	REG_SQIS		= 0x0,
+	REG_SQIE		= 0x4,
+};
+
+enum {
+	REG_CQHP		= 0x0,
+	REG_CQTP		= 0x4,
+};
+
+enum {
+	REG_CQIS		= 0x0,
+	REG_CQIE		= 0x4,
+	REG_MCQIACR		= 0x8,
 };
 
 #define UFS_MASK(mask, offset)		((mask) << (offset))
@@ -126,6 +189,8 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
 #define CRYPTO_ENGINE_FATAL_ERROR		0x40000
+#define MCQ_SQ_EVENT_STATUS			0x80000
+#define MCQ_CQ_EVENT_STATUS			0x100000
 
 #define UFSHCD_UIC_HIBERN8_MASK	(UIC_HIBERNATE_ENTER |\
 				UIC_HIBERNATE_EXIT)
@@ -227,6 +292,9 @@ enum {
 /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
+/* CQISy - CQ y Interrupt Status Register  */
+#define UFSHCD_MCQ_CQIS_TEPS	0x1
+
 /* UICCMD - UIC Command */
 #define COMMAND_OPCODE_MASK		0xFF
 #define GEN_SELECTOR_INDEX_MASK		0xFFFF
@@ -482,6 +550,27 @@ struct utp_transfer_req_desc {
 	__le16  prd_table_offset;
 };
 
+struct cq_entry {
+
+	/* DW 0-1 */
+	__le32 command_desc_base_addr_lo;
+	__le32 command_desc_base_addr_hi;
+
+	/* DW 2 */
+	__le16  response_upiu_length;
+	__le16  response_upiu_offset;
+
+	/* DW 3 */
+	__le16  prd_table_length;
+	__le16  prd_table_offset;
+
+	/* DW 4 */
+	__le32 status;
+
+	/* DW 5-7 */
+	u32 reserved[3];
+};
+
 /*
  * UTMRD structure.
  */
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

