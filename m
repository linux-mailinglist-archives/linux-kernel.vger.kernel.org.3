Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4458FAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiHKKfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiHKKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:35:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6B2981A;
        Thu, 11 Aug 2022 03:35:32 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B4ZgP9007593;
        Thu, 11 Aug 2022 10:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=jesBZXF3g0BA7FcsBtNvC3ULk/kTOPGsaoQncuQccDI=;
 b=OmFvQXQ6PmScp0XvOckMQP2mE7oN0tWJWWa1jfCyYqOOakETO7A4i0W5qH2egOsag2LW
 0uYQgpBeqD7GHN/nVt3PUELrJ072CdVyFX/GAwT63qlhIgGbDhcojsMJsRnqHR1CPFr3
 G+jBRBm3JHeCviCIOJlQBSyGZTveh6wFKr6+NL5i+3EckjspC1WJPqF+jRW0023q5Hy8
 6WQMAlQRfZqtr97+8We37DM2iN4Jg5SpEibO3GoacdtvlyuO37phHjDG9EBXSnAgKK/w
 xbqwIc1TCFlKg68fzdPXo96t/shn0/QbPtlhAx0+STI+s5NfcHDskvD4xz6D/JJrI9Hq 8Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvt429046-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:35:14 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27BAZCi6004493;
        Thu, 11 Aug 2022 10:35:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3hvwps1h10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2022 10:35:12 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27BAZClw004480;
        Thu, 11 Aug 2022 10:35:12 GMT
Received: from stor-presley.qualcomm.com (stor-presley.qualcomm.com [192.168.140.85])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 27BAZC9j004478;
        Thu, 11 Aug 2022 10:35:12 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id D891022752; Thu, 11 Aug 2022 03:35:11 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, beanhuo@micron.com,
        avri.altman@wdc.com, mani@kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, quic_cang@quicinc.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
Date:   Thu, 11 Aug 2022 03:33:03 -0700
Message-Id: <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: teuvMUWa5KSFQCQRqZ6564JoImZdc2PQ
X-Proofpoint-ORIG-GUID: teuvMUWa5KSFQCQRqZ6564JoImZdc2PQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110030
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asutosh Das <quic_asutoshd@quicinc.com>

Adds MCQ support to UFS.

The design uses shared tags across all the hw queues.
The queue-depth is chosen within range supported by controller &
device. It also takes EXT_IID into account while choosing the queue
depth.

It supports default, read, poll and a dev cmd queue.
It enables MCQ after determining the queue-depth that the ufs
device supports.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/core/Makefile  |   2 +-
 drivers/ufs/core/ufs-mcq.c | 524 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c  | 394 ++++++++++++++++++++++++++--------
 include/ufs/ufs.h          |   5 +
 include/ufs/ufshcd.h       | 223 ++++++++++++++++++-
 include/ufs/ufshci.h       |  77 +++++++
 6 files changed, 1135 insertions(+), 90 deletions(-)
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
index 0000000..9d87153
--- /dev/null
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -0,0 +1,524 @@
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
+#include <linux/module.h>
+#include <asm/unaligned.h>
+
+#include <ufs/ufshcd.h>
+
+#define MCQ_CFG_MAC_OFFSET	8
+#define MCQ_CFG_MAC_MASK	UFS_MASK(0x1FF, MCQ_CFG_MAC_OFFSET)
+
+#define MCQ_QCFGPTR_MASK	0xff
+#define MCQ_QCFGPTR_UNIT	0x200
+#define mcq_sqattr_offset(c) \
+	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
+
+#define MCQ_ENTRY_SIZE_IN_DWORD	8
+#define MCQ_QCFG_SIZE	0x40
+
+static unsigned int dev_cmd_queue = 1;
+static unsigned int read_queues;
+static unsigned int poll_queues = 1;
+
+static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int n;
+	int ret;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret)
+		return ret;
+	if (n > num_possible_cpus())
+		return -EINVAL;
+	return param_set_uint(val, kp);
+}
+
+static const struct kernel_param_ops rw_queue_count_ops = {
+	.set = rw_queue_count_set,
+	.get = param_get_uint,
+};
+
+static unsigned int rw_queues = 8;
+module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
+MODULE_PARM_DESC(rw_queues, "Number of queues used for rw. Default value is 8");
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
+u32 ufshcd_mcq_find_queue_depth(struct ufs_hba *hba)
+{
+	u32 qd, val, mac;
+
+	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
+	mac = ufshcd_mcq_vops_get_hba_mac(hba);
+	if (mac < 0)
+		mac = (val & MCQ_CFG_MAC_MASK) >> MCQ_CFG_MAC_OFFSET;
+
+	/*  MAC is a 0 based value. */
+	mac += 1;
+	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
+	if (!qd)
+		qd = mac;
+
+	/* Adjust queue depth based on ext_iid support. */
+	if (qd > 256 && (!hba->ext_iid_sup || !hba->dev_info.b_ext_iid_en))
+		qd = 256;
+	if (qd > 4096 && hba->ext_iid_sup && hba->dev_info.b_ext_iid_en)
+		qd = 4096;
+
+	return qd;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_find_queue_depth);
+
+void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 set)
+{
+	u32 val;
+
+	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
+	val &= ~MCQ_CFG_MAC_MASK;
+	val |= set << MCQ_CFG_MAC_OFFSET;
+	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
+
+struct ufs_hw_queue *ufshcd_mcq_find_hwq(struct ufs_hba *hba,
+					 struct request *req)
+{
+	u32 utag, hwq;
+
+	utag = blk_mq_unique_tag(req);
+	hwq = blk_mq_unique_tag_to_hwq(utag);
+
+	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_find_hwq);
+
+int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	size_t utrdl_size, cqe_size;
+	int i;
+
+	for_each_hw_queue(hba, i) {
+		hwq = &hba->uhq[i];
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
+		cqe_size = sizeof(struct cq_entry) * hwq->max_entries;
+		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
+							 &hwq->cqe_dma_addr,
+							 GFP_KERNEL);
+		if (!hwq->cqe_dma_addr || WARN_ON(hwq->cqe_dma_addr &
+						  (PAGE_SIZE - 1))) {
+			dev_err(hba->dev, "Alloc CQE failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_memory_alloc);
+
+#define MCQ_CFG_n(r, i) \
+	((r) + MCQ_QCFG_SIZE * (i))
+#define MCQ_ROP_OFFSET_n(p, i) \
+	(hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i))
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
+		if (res->base) {
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
+			dev_err(hba->dev, "Resource %s not provided\n");
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
+			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
+					 res->name, PTR_ERR(res->base));
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
+	res_mcq->end = res_mcq->start + hba->nr_hw_queues * MCQ_QCFG_SIZE - 1;
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
+		dev_err(hba->dev, "Map MCQ registers failed, err=%d\n",
+			PTR_ERR(res->base));
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
+static void ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
+{
+	int i;
+	u32 hbaq_cap, def_nr_queues, max_nr_queues;
+	struct Scsi_Host *host = hba->host;
+
+	/* default queues will be less than or equal to max_nr_queues */
+	def_nr_queues = rw_queues + poll_queues + read_queues + dev_cmd_queue;
+	max_nr_queues = num_possible_cpus() + poll_queues + read_queues +
+		dev_cmd_queue;
+	hbaq_cap = hba->mcq_capabilities & 0xff;
+
+	if (hbaq_cap >= max_nr_queues)
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
+	else if (hbaq_cap >= def_nr_queues)
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = rw_queues;
+	else
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = hbaq_cap - read_queues -
+						    poll_queues - dev_cmd_queue;
+
+	hba->nr_queues[HCTX_TYPE_READ] = read_queues;
+	hba->nr_queues[HCTX_TYPE_POLL] = poll_queues;
+
+	for (i = 0; i < HCTX_MAX_TYPES; i++)
+		host->nr_hw_queues += hba->nr_queues[i];
+
+	/* One more reserved for dev_cmd_queue */
+	hba->nr_hw_queues = host->nr_hw_queues + 1;
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
+	ufshcd_mcq_config_nr_queues(hba);
+
+	ret = ufshcd_mcq_config_resource(hba);
+	if (ret) {
+		dev_err(hba->dev, "Failed to config MCQ resource\n");
+		return ret;
+	}
+
+	ret = ufshcd_mcq_vops_config_rop(hba);
+	if (ret) {
+		dev_err(hba->dev, "MCQ Runtime Operation Pointers not configured\n");
+		goto out_err;
+	}
+
+	host->host_tagset = 1;
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
+static inline int ufshcd_mcq_get_tag(struct ufs_hba *hba,
+				     struct ufs_hw_queue *hwq,
+				     struct cq_entry *cqe)
+{
+	dma_addr_t dma_addr;
+
+	dma_addr = ((u64)le32_to_cpu(cqe->command_desc_base_addr_hi) << 32) |
+		   (le32_to_cpu(cqe->command_desc_base_addr_lo) & 0xffffff80);
+
+	return (dma_addr - hba->ucdl_dma_addr) /
+		sizeof_utp_transfer_cmd_desc(hba);
+}
+
+static inline void ufshcd_mcq_process_event(struct ufs_hba *hba,
+					    struct ufs_hw_queue *hwq)
+{
+	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+	int tag;
+
+	tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
+	ufshcd_compl_one_task(hba, tag, cqe);
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
index f4f8ded..f4c1752 100644
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
 
@@ -249,7 +254,7 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba);
 static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd);
 static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag);
 static void ufshcd_hba_exit(struct ufs_hba *hba);
-static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params);
+static int ufshcd_probe_hba(struct ufs_hba *hba, bool initial_boot);
 static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
 static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
@@ -310,10 +315,11 @@ static void ufshcd_scsi_block_requests(struct ufs_hba *hba)
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
@@ -322,7 +328,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 	if (str_t == UFS_CMD_SEND)
 		header = &rq->header;
 	else
-		header = &hba->lrb[tag].ucd_rsp_ptr->header;
+		header = &lrbp->ucd_rsp_ptr->header;
 
 	trace_ufshcd_upiu(dev_name(hba->dev), str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
@@ -379,13 +385,13 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
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
@@ -394,7 +400,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	/* trace UPIU also */
-	ufshcd_add_cmd_upiu_trace(hba, tag, str_t);
+	ufshcd_add_cmd_upiu_trace(hba, lrbp, str_t);
 	if (!trace_ufshcd_command_enabled())
 		return;
 
@@ -419,7 +425,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
+	trace_ufshcd_command(dev_name(hba->dev), str_t, lrbp->task_tag,
 			doorbell, transfer_len, intr, lba, opcode, group_id);
 }
 
@@ -739,8 +745,11 @@ static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
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
 
@@ -2131,27 +2140,43 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
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
+		if (hba->vops && hba->vops->setup_xfer_req)
+			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						  !!lrbp->cmd);
+		memcpy(hwq->sqe_base_addr + (hwq->sq_tp_slot * utrd_size),
+		       lrbp->utr_descriptor_ptr, utrd_size);
+		ufshcd_inc_tp(hwq);
+		spin_unlock(&hwq->sq_lock);
+	} else {
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		if (hba->vops && hba->vops->setup_xfer_req)
+			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						  !!lrbp->cmd);
+		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
+		ufshcd_writel(hba, 1 << lrbp->task_tag,
+			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	}
 }
 
 /**
@@ -2239,6 +2264,13 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	if (err)
 		dev_err(hba->dev, "crypto setup failed\n");
 
+	hba->mcq_sup = (hba->capabilities & MASK_MCQ_SUPPORT) >> 30;
+	if (!hba->mcq_sup)
+		return err;
+
+	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
+	hba->ext_iid_sup = (hba->mcq_capabilities & MASK_EXT_IID_SUPPORT) >> 10;
+
 	return err;
 }
 
@@ -2553,9 +2585,10 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_flags)
 	/* command descriptor fields */
 	ucd_req_ptr->header.dword_0 = UPIU_HEADER_DWORD(
 				UPIU_TRANSACTION_COMMAND, upiu_flags,
-				lrbp->lun, lrbp->task_tag);
+				lrbp->lun, lrbp->task_tag & 0xff);
 	ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
-				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
+				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0,
+				(lrbp->task_tag & 0xF00) << 4);
 
 	/* Total EHS length and Data segment length will be zero */
 	ucd_req_ptr->header.dword_2 = 0;
@@ -2703,25 +2736,26 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
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
+		if (i == HCTX_TYPE_POLL && !is_mcq_supported(hba))
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
@@ -2761,6 +2795,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
+	struct ufs_hw_queue *hwq = NULL;
 
 	WARN_ONCE(tag < 0 || tag >= hba->nutrs, "Invalid tag %d\n", tag);
 
@@ -2845,8 +2880,10 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	ufshcd_send_command(hba, tag);
+	if (is_mcq_enabled(hba))
+		hwq = ufshcd_mcq_find_hwq(hba, scsi_cmd_to_rq(cmd));
 
+	ufshcd_send_command(hba, lrbp, hwq);
 out:
 	rcu_read_unlock();
 
@@ -2963,7 +3000,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->dev_cmd.complete = NULL;
 	if (likely(time_left)) {
-		err = ufshcd_get_tr_ocs(lrbp);
+		err = ufshcd_get_tr_ocs(lrbp, hba->dev_cmd.cqe);
 		if (!err)
 			err = ufshcd_dev_cmd_completion(hba, lrbp);
 	}
@@ -2971,7 +3008,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
 	if (!time_left) {
 		err = -ETIMEDOUT;
-		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
+		dev_err(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
 		if (!ufshcd_clear_cmds(hba, 1U << lrbp->task_tag))
 			/* successfully cleared the command, retry if needed */
@@ -3002,7 +3039,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		enum dev_cmd_type cmd_type, int timeout)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	const u32 tag = hba->reserved_slot;
+	u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err;
 
@@ -3018,10 +3055,10 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
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
@@ -3617,11 +3654,11 @@ static int ufshcd_get_ref_clk_gating_wait(struct ufs_hba *hba)
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
@@ -3666,6 +3703,8 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto out;
 	}
 
+	if (hba->utmrdl_base_addr)
+		goto skip_utmrdl;
 	/*
 	 * Allocate memory for UTP Task Management descriptors
 	 * UFSHCI requires 1024 byte alignment of UTMRD
@@ -3682,6 +3721,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto out;
 	}
 
+skip_utmrdl:
 	/* Allocate memory for local reference block */
 	hba->lrb = devm_kcalloc(hba->dev,
 				hba->nutrs, sizeof(struct ufshcd_lrb),
@@ -3695,6 +3735,21 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	return -ENOMEM;
 }
 
+static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
+{
+	size_t ucdl_size, utrdl_size;
+
+	ucdl_size = (sizeof(struct utp_transfer_cmd_desc) * nutrs);
+	dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
+			   hba->ucdl_dma_addr);
+
+	utrdl_size = (sizeof(struct utp_transfer_req_desc) * nutrs);
+	dmam_free_coherent(hba->dev, utrdl_size, hba->utrdl_base_addr,
+			   hba->utrdl_dma_addr);
+
+	devm_kfree(hba->dev, hba->lrb);
+}
+
 /**
  * ufshcd_host_memory_configure - configure local reference block with
  *				memory offsets
@@ -3708,7 +3763,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
  * 3. Save the corresponding addresses of UTRD, UCD.CMD, UCD.RSP and UCD.PRDT
  * into local reference block.
  */
-static void ufshcd_host_memory_configure(struct ufs_hba *hba)
+static int ufshcd_host_memory_configure(struct ufs_hba *hba)
 {
 	struct utp_transfer_req_desc *utrdlp;
 	dma_addr_t cmd_desc_dma_addr;
@@ -3756,6 +3811,8 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 
 		ufshcd_init_lrb(hba, &hba->lrb[i], i);
 	}
+
+	return 0;
 }
 
 /**
@@ -4508,11 +4565,13 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
 	else
 		ufshcd_disable_intr_aggr(hba);
 
-	/* Configure UTRL and UTMRL base address registers */
+	/* Configure UTRL base address registers */
 	ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
 			REG_UTP_TRANSFER_REQ_LIST_BASE_L);
 	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
 			REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+
+	/* Configure UTMRL base address registers */
 	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
 			REG_UTP_TASK_REQ_LIST_BASE_L);
 	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
@@ -5149,14 +5208,15 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
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
@@ -5320,6 +5380,34 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 	ufshcd_clk_scaling_update_busy(hba);
 }
 
+void ufshcd_compl_one_task(struct ufs_hba *hba, int task_tag,
+			  struct cq_entry *cqe)
+{
+	struct ufshcd_lrb *lrbp;
+	struct scsi_cmnd *cmd;
+
+	lrbp = &hba->lrb[task_tag];
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
+	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
+		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
+		if (hba->dev_cmd.complete) {
+			hba->dev_cmd.cqe = cqe;
+			ufshcd_add_command_trace(hba, lrbp, UFS_DEV_COMP);
+			complete(hba->dev_cmd.complete);
+			ufshcd_clk_scaling_update_busy(hba);
+		}
+	}
+}
+
 /**
  * __ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
@@ -5328,32 +5416,10 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 					unsigned long completed_reqs)
 {
-	struct ufshcd_lrb *lrbp;
-	struct scsi_cmnd *cmd;
-	int index;
-
-	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
-		lrbp = &hba->lrb[index];
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
-	}
+	int tag;
+
+	for_each_set_bit(tag, &completed_reqs, hba->nutrs)
+		ufshcd_compl_one_task(hba, tag, NULL);
 }
 
 /*
@@ -5363,9 +5429,15 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
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
@@ -5389,7 +5461,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
-static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
+irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 {
 	/* Resetting interrupt aggregation counters first and reading the
 	 * DOOR_BELL afterward allows us to handle all the completed requests.
@@ -5413,6 +5485,43 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 
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
@@ -5944,10 +6053,23 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
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
 
@@ -6210,7 +6332,6 @@ static void ufshcd_err_handler(struct work_struct *work)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_err_handling_prepare(hba);
-	/* Complete requests that have door-bell cleared by h/w */
 	ufshcd_complete_requests(hba);
 	spin_lock_irqsave(hba->host->host_lock, flags);
 again:
@@ -6602,6 +6723,9 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
 	if (intr_status & UTP_TRANSFER_REQ_COMPL)
 		retval |= ufshcd_transfer_req_compl(hba);
 
+	if (intr_status & MCQ_CQ_EVENT_STATUS)
+		retval |= ufshcd_handle_mcq_cq_events(hba);
+
 	return retval;
 }
 
@@ -6823,7 +6947,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum query_opcode desc_op)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	const u32 tag = hba->reserved_slot;
+	u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
 	u8 upiu_flags;
@@ -6866,10 +6990,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
 	hba->dev_cmd.complete = &wait;
+	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, lrbp, hba->dev_cmd_queue);
 	/*
 	 * ignore the returning value here - ufshcd_check_query_response is
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
@@ -7664,6 +7789,30 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	}
 }
 
+static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u32 ext_ufs_feature;
+	u32 ext_iid_en = 0;
+	int err;
+
+	if (dev_info->wspecversion < 0x400)
+		goto out;
+
+	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+
+	if (!(ext_ufs_feature & UFS_DEV_EXT_IID_SUP))
+		goto out;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				      QUERY_ATTR_IDN_EXT_IID_EN, 0, 0, &ext_iid_en);
+	if (err)
+		dev_err(hba->dev, "failed reading bEXTIIDEn. err = %d\n", err);
+
+out:
+	dev_info->b_ext_iid_en = !!ext_iid_en;
+}
+
 void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
 			     const struct ufs_dev_quirk *fixups)
 {
@@ -7725,6 +7874,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	/* getting Specification Version in big endian format */
 	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+
+	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
+
 	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
@@ -7762,6 +7914,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	ufshcd_ext_iid_probe(hba, desc_buf);
+
 	/*
 	 * ufshcd_read_string_desc returns size of the string
 	 * reset the error value
@@ -8135,14 +8289,61 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	return ret;
 }
 
+static int ufshcd_config_mcq(struct ufs_hba *hba)
+{
+	int old_nutrs = hba->nutrs;
+	int ret;
+	struct Scsi_Host *host = hba->host;
+
+	hba->nutrs = ufshcd_mcq_find_queue_depth(hba);
+	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
+	hba->reserved_slot = hba->nutrs - 1;
+
+	ret = ufshcd_mcq_init(hba);
+	if (ret) {
+		dev_err(hba->dev, "MCQ init failed %d\n", ret);
+		return ret;
+	}
+
+	if (hba->nutrs != old_nutrs) {
+		ufshcd_release_sdb_queue(hba, old_nutrs);
+		ret = ufshcd_memory_alloc(hba);
+		if (ret)
+			return ret;
+		ufshcd_host_memory_configure(hba);
+	}
+
+	ret = ufshcd_mcq_memory_alloc(hba);
+	if (ret)
+		return ret;
+
+	ret = ufshcd_mcq_vops_config_esi(hba);
+	if (ret) {
+		dev_info(hba->dev, "MCQ ESI not available %d\n", ret);
+		ret = 0;
+	}
+
+	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
+	ufshcd_mcq_make_queues_operational(hba);
+	ufshcd_mcq_config_mac(hba, hba->nutrs);
+
+	ret = scsi_add_host(host, hba->dev);
+	if (ret)
+		dev_err(hba->dev, "scsi_add_host failed\n");
+	else
+		dev_info(hba->dev, "MCQ configured, nr_queues=%d, queue_depth=%d\n",
+			 hba->nr_hw_queues, hba->nutrs);
+	return ret;
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize it
  * @hba: per-adapter instance
- * @init_dev_params: whether or not to call ufshcd_device_params_init().
+ * @initial_boot: Whether or not from initial bootup
  *
  * Execute link-startup and verify device initialization
  */
-static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
+static int ufshcd_probe_hba(struct ufs_hba *hba, bool initial_boot)
 {
 	int ret;
 	unsigned long flags;
@@ -8177,10 +8378,16 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	 * Initialize UFS device parameters used by driver, these
 	 * parameters are associated with UFS descriptors.
 	 */
-	if (init_dev_params) {
+	if (initial_boot) {
 		ret = ufshcd_device_params_init(hba);
 		if (ret)
 			goto out;
+
+		if (is_mcq_supported(hba)) {
+			ret = ufshcd_config_mcq(hba);
+			if (ret)
+				goto out;
+		}
 	}
 
 	ufshcd_tune_unipro_params(hba);
@@ -9654,6 +9861,14 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto out_disable;
 	}
 
+	if (!is_mcq_supported(hba)) {
+		/* Refer ufshcd_map_queues() */
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = 1;
+		hba->nr_queues[HCTX_TYPE_READ] = 0;
+		hba->nr_queues[HCTX_TYPE_POLL] = 1;
+		hba->nr_hw_queues = 1;
+	}
+
 	/* Allocate memory for host memory space */
 	err = ufshcd_memory_alloc(hba);
 	if (err) {
@@ -9727,10 +9942,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		hba->is_irq_enabled = true;
 	}
 
-	err = scsi_add_host(host, hba->dev);
-	if (err) {
-		dev_err(hba->dev, "scsi_add_host failed\n");
-		goto out_disable;
+	if (!is_mcq_supported(hba)) {
+		/* Refer ufshcd_config_mcq() */
+		err = scsi_add_host(host, hba->dev);
+		if (err) {
+			dev_err(hba->dev, "scsi_add_host failed\n");
+			goto out_disable;
+		}
 	}
 
 	hba->tmf_tag_set = (struct blk_mq_tag_set) {
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fe..f59cc27 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -165,6 +165,7 @@ enum attr_idn {
 	QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       = 0x1D,
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
+	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
 };
 
 /* Descriptor idn for Query requests */
@@ -352,6 +353,7 @@ enum {
 	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
+	UFS_DEV_EXT_IID_SUP		= BIT(16),
 };
 #define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
@@ -589,6 +591,7 @@ struct ufs_dev_info {
 	u8	*model;
 	u16	wspecversion;
 	u32	clk_gating_wait_us;
+	u8	bqueuedepth;
 
 	/* UFS HPB related flag */
 	bool	hpb_enabled;
@@ -601,6 +604,8 @@ struct ufs_dev_info {
 
 	bool	b_rpm_dev_flush_capable;
 	u8	b_presrv_uspc_en;
+
+	bool	b_ext_iid_en;
 };
 
 /*
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a92..a195663 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -22,6 +22,7 @@
 #include <ufs/ufs.h>
 #include <ufs/ufs_quirks.h>
 #include <ufs/ufshci.h>
+#include <linux/msi.h>
 
 #define UFSHCD "ufshcd"
 
@@ -218,6 +219,7 @@ struct ufs_dev_cmd {
 	struct mutex lock;
 	struct completion *complete;
 	struct ufs_query query;
+	struct cq_entry *cqe;
 };
 
 /**
@@ -293,6 +295,9 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @get_outstanding_cqs: called to get outstanding completion queues
+ * @config_mcq_rop: called to config Runtime Operation Pointers
+ * @config_mcq_esi: called to config MCQ ESI handlers
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -331,6 +336,11 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
+				       unsigned long *ocqs);
+	int	(*config_mcq_rop)(struct ufs_hba *hba);
+	int	(*config_mcq_esi)(struct ufs_hba *hba);
+	int	(*get_hba_mac)(struct ufs_hba *hba);
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
@@ -818,6 +862,13 @@ struct ufs_hba_monitor {
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
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -858,6 +909,7 @@ struct ufs_hba {
 	unsigned long outstanding_reqs;
 
 	u32 capabilities;
+	u32 mcq_capabilities;
 	int nutrs;
 	int nutmrs;
 	u32 reserved_slot;
@@ -965,8 +1017,119 @@ struct ufs_hba {
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
 };
 
+enum {
+	ESIVEC_CQ,
+	ESIVEC_SQ,
+	ESIVEC_MAX,
+};
+
+/**
+ * @sqe_base_addr: submission queue entry base address
+ * @sqe_dma_addr: submission queue dma address
+ * @cqe_base_addr: completion queue base address
+ * @cqe_dma_addr: completion queue dma address
+ * @max_entries: max number of slots in this hardware queue
+ * @id: hardware queue ID
+ * @mcq_sq_hp: base address of submission queue head pointer
+ * @mcq_sq_tp: base address of submission queue tail pointer
+ * @mcq_cq_hp: base address of completion queue head pointer
+ * @mcq_cq_tp: base address of completion queue tail pointer
+ * @sq_lock: lock to protect submission queue head/tail pointer and slot update
+ * @sq_tp_slot: current slot to which SQ tail pointer is pointing
+ * @cq_lock: lock to protect completion queue head/tail pointer and slot update
+ * @cq_tp_slot: current slot to which CQ tail pointer is pointing
+ * @cq_hp_slot: current slot to which CQ head pointer is pointing
+ */
+struct ufs_hw_queue {
+	void *sqe_base_addr;
+	dma_addr_t sqe_dma_addr;
+	struct cq_entry *cqe_base_addr;
+	dma_addr_t cqe_dma_addr;
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
+	spinlock_t cq_lock;
+	u32 cq_tp_slot;
+	u32 cq_hp_slot;
+};
+
+#define for_each_hw_queue(hba, i) \
+	for ((i) = 0; (i) < (hba)->nr_hw_queues; (i)++)
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
+	q->cq_hp_slot++;
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
+
+	q->cq_tp_slot = val / sizeof(struct cq_entry);
+}
+
 /* Returns true if clocks can be gated. Otherwise false */
 static inline bool ufshcd_is_clkgating_allowed(struct ufs_hba *hba)
 {
@@ -1017,11 +1180,16 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
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
@@ -1100,6 +1268,26 @@ extern int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 			struct ufs_pa_layer_attr *desired_pwr_mode);
 extern int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode);
+extern void ufshcd_compl_one_task(struct ufs_hba *hba, int task_tag,
+				  struct cq_entry *cqe);
+extern int ufshcd_mcq_init(struct ufs_hba *hba);
+extern void ufshcd_mcq_enable(struct ufs_hba *hba);
+extern int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
+extern void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 set);
+extern u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
+extern void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
+extern void ufshcd_mcq_enable_cq_intr(struct ufs_hba *hba, u32 intrs);
+extern void ufshcd_mcq_disable_cq_intr(struct ufs_hba *hba, u32 intrs);
+extern void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
+extern void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
+extern unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+						struct ufs_hw_queue *hwq);
+extern unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+					      struct ufs_hw_queue *hwq);
+extern void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
+extern struct ufs_hw_queue *ufshcd_mcq_find_hwq(struct ufs_hba *hba,
+						struct request *req);
+extern u32 ufshcd_mcq_find_queue_depth(struct ufs_hba *hba);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
@@ -1232,6 +1420,39 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
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
+static inline int ufshcd_mcq_vops_config_rop(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_mcq_rop)
+		return hba->vops->config_mcq_rop(hba);
+
+	return -EOPNOTSUPP;
+}
+
+static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_mcq_esi)
+		return hba->vops->config_mcq_esi(hba);
+
+	return -EOPNOTSUPP;
+}
+
+static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->get_hba_mac)
+		return hba->vops->get_hba_mac(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index f81aa95..6ca29ae 100644
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
@@ -56,6 +57,10 @@ enum {
 	REG_UFS_CCAP				= 0x100,
 	REG_UFS_CRYPTOCAP			= 0x104,
 
+	REG_UFS_MEM_CFG				= 0x300,
+	REG_UFS_MCQ_CFG				= 0x380,
+	REG_UFS_ESILBA				= 0x384,
+	REG_UFS_ESIUBA				= 0x388,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
 
@@ -68,6 +73,53 @@ enum {
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
@@ -126,6 +178,8 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
 #define CRYPTO_ENGINE_FATAL_ERROR		0x40000
+#define MCQ_SQ_EVENT_STATUS			0x80000
+#define MCQ_CQ_EVENT_STATUS			0x100000
 
 #define UFSHCD_UIC_HIBERN8_MASK	(UIC_HIBERNATE_ENTER |\
 				UIC_HIBERNATE_EXIT)
@@ -227,6 +281,9 @@ enum {
 /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
+/* CQISy - CQ y Interrupt Status Register  */
+#define UFSHCD_MCQ_CQIS_TEPS	0x1
+
 /* UICCMD - UIC Command */
 #define COMMAND_OPCODE_MASK		0xFF
 #define GEN_SELECTOR_INDEX_MASK		0xFFFF
@@ -482,6 +539,26 @@ struct utp_transfer_req_desc {
 	__le16  prd_table_offset;
 };
 
+struct cq_entry {
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

