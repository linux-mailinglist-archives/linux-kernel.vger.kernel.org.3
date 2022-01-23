Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECD4970CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiAWJsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:48:37 -0500
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:7776
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235947AbiAWJsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:48:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eknxuKYcwQKUDx/QIirmThhEPlj1RpZsqCsuSg56bzmXIJa/V1/75dYvuMYfakvpKozphwoY6Bt2WE64yYYAsfE5X5p8xOWLXFVH9BT2NYWjTxx3AOJpPrNtEWq/AfvmEfReJiECg5J3XHZPY60y3fXyq7Y64cvBdgJ/Cw4AihlUT5yH6t9GPvPGXoTm5x3j036TN3WEGbAfS2aU1/scepn8ceQ228L/Via+QqG/BfXu6YT20H817UA15Y0qJmFB1Ay0RlffPEsLqc6vLBeA8lxw7Z4f1vYwjZ+p7+U89ww0sVawEIJDe6cjySaiB9ddxFnACkVrb9tFt9v61CYWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9BDdGuWJXrrhAbP3GtAxvdWo+Oing5b7HXBiIgGVJk=;
 b=guhdqTj+d4eiOenr6gVosg1tuk1O+YeJ8fhoe552OEk7A2Ci6xOn6ocpffu0Ef6G0HPd2tZeKAyVUEJdbIwZk8u+7rBv/bqwWewfJIvMV7Cp2mfNWfUftinaB69WKXGg05N0qDGPK5s2LLYRspcAikrsU3d2h9X1SJcd/DhkvxYqArFh+Zd7648eza/HX3coOygvsC3e3+BUvDxXXyF8FPFpPq/i64k3+hr3zFCPBpF4lVkdEaSU/aWeSJQkYRUuHUWez83FfjgNCWVsR5rOpL1KWWEJ/jxo60i9LQxCd3V8YADDytZtTlq8mEcmVDN8B2U/BHeGRiMdSu+DxAhOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9BDdGuWJXrrhAbP3GtAxvdWo+Oing5b7HXBiIgGVJk=;
 b=MrJB5ZPjFyXeSnh3MXXNE1OhxFmuYEczxTYgxGSZintTNb7mH/D+XtO1xuWsNAHiAUobnxnpXoK07fCvnVPBviqMroB4OxlutO/GH2p4+eWJ/ynTZjQltRtxahiSScSR5zN/aykb0HD4zuw6F5KfbDtrTI+WCdjQgdWj6RPzu3U=
Received: from BN6PR17CA0057.namprd17.prod.outlook.com (2603:10b6:405:75::46)
 by DM6PR02MB6138.namprd02.prod.outlook.com (2603:10b6:5:1fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sun, 23 Jan
 2022 09:48:17 +0000
Received: from BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d) by BN6PR17CA0057.outlook.office365.com
 (2603:10b6:405:75::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Sun, 23 Jan 2022 09:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT049.mail.protection.outlook.com (10.13.2.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Sun, 23 Jan 2022 09:48:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 23 Jan 2022 01:47:54 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 23 Jan 2022 01:47:54 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.15] (port=60078 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nBZTV-0001bj-SN; Sun, 23 Jan 2022 01:47:54 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH 3/4] crypto: xilinx: Add Xilinx SHA3 driver
Date:   Sun, 23 Jan 2022 15:17:06 +0530
Message-ID: <1642931227-20706-4-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
References: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dba61bc-878b-493a-5db1-08d9de557aa0
X-MS-TrafficTypeDiagnostic: DM6PR02MB6138:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB6138403F5B8B6C3A3598EB0BDE5D9@DM6PR02MB6138.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7z2ZW7gMRra1jXAkb22C480rymCG+jBBvZYUTCPGFeWWRzcuawTbyaO9kAS8h7QaNn2YyiedJG+Uf7LJFFbjvLcwOsKK9B1yo9EnHxSvyNtbHSaikDnlirs8v/sRH1KgUglzm/f1dWopNuWy4mg9C4RIeKXkx9Xzpn5fAAdUUXY/OhMIeDBTH+OqWxVVkgFygSrwwxBNe1Gw+3N+SrU5crleBTaPGsXg5Smt9RpK+itgEtr6WUpdC+WQDxY2R7JG8zQGE23lrV91hbq7nU4hCtdVLBNnE4CoRzC02N6US9qQb3pbDZEVf+XNC3WKItRXbuloJtuu8Tvg1y+05A2b7Ge0Scct+sWwFb/Py1xcHh6C2VRdJRQyyLpqCPSDAZKc83jaCnnh/1mlfDn6p5FIW7FIZuZ1TZCDk2tPFbkXVTVZ+8mcx7KLMYk6daZmGBipdo3Rmn3h3tEPvDIh7pw9m+sDxt3vHIvUKAh81sFWYZmNHnArkj34CkMjQSPdCHR2cQxDkiEfUPM2t+tcu/94yMbcpxA8MrSTcKASjhPR5yEgKwN0ncqQKpzpiGoi3NrxxDwZcnUXbj9n0xaHh0mQIvxo1WuJ8iQALqZKtjzSeXQIIaYvYQoiXtPJ/EVj8v71pp6chkNBqfX+CN6q+9JdS6LmYhD/kyvC3bPfYRS00kbBFdpXLVS36dkZf5UMwCxyb9QpCzaFs74N5JtZyA9xj8KdiPRU7qXlR2TjhejO2I0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(356005)(83380400001)(4326008)(6666004)(186003)(508600001)(26005)(7636003)(7696005)(82310400004)(36756003)(2906002)(70586007)(70206006)(47076005)(9786002)(36860700001)(107886003)(336012)(5660300002)(2616005)(316002)(110136005)(54906003)(8936002)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 09:48:15.9146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dba61bc-878b-493a-5db1-08d9de557aa0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SHA3 driver support for the Xilinx ZynqMP SoC.
Xilinx ZynqMP SoC has SHA3 engine used for secure hash calculation.
The flow is
SHA3 request from Userspace -> SHA3 driver-> ZynqMp driver-> Firmware ->
SHA3 HW Engine

SHA3 HW engine in Xilinx ZynqMP SoC, does not support parallel processing
of 2 hash requests.
Therefore, software fallback is being used for init, update, final,
export and import in the ZynqMP SHA driver
For digest, the calculation of SHA3 hash is done by the hardened
SHA3 accelerator in Xilinx ZynqMP SoC.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 drivers/crypto/Kconfig             |  10 ++
 drivers/crypto/xilinx/Makefile     |   1 +
 drivers/crypto/xilinx/zynqmp-sha.c | 285 +++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 51690e7..2e43f11 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -796,6 +796,16 @@ config CRYPTO_DEV_ZYNQMP_AES
 	  accelerator. Select this if you want to use the ZynqMP module
 	  for AES algorithms.
 
+config CRYPTO_DEV_ZYNQMP_SHA3
+	bool "Support for Xilinx ZynqMP SHA3 hardware accelerator"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select CRYPTO_SHA3
+	help
+	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
+	  This driver interfaces with SHA3 hardware engine.
+	  Select this if you want to use the ZynqMP module
+	  for SHA3 hash computation.
+
 source "drivers/crypto/chelsio/Kconfig"
 
 source "drivers/crypto/virtio/Kconfig"
diff --git a/drivers/crypto/xilinx/Makefile b/drivers/crypto/xilinx/Makefile
index 534e32d..730feff 100644
--- a/drivers/crypto/xilinx/Makefile
+++ b/drivers/crypto/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += zynqmp-aes-gcm.o
+obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_SHA3) += zynqmp-sha.o
diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx/zynqmp-sha.c
new file mode 100644
index 0000000..11f103c
--- /dev/null
+++ b/drivers/crypto/xilinx/zynqmp-sha.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZynqMP SHA Driver.
+ * Copyright (c) 2022 Xilinx Inc.
+ */
+#include <asm/cacheflush.h>
+#include <crypto/hash.h>
+#include <crypto/internal/hash.h>
+#include <crypto/sha3.h>
+#include <linux/crypto.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define ZYNQMP_DMA_BIT_MASK		32U
+#define ZYNQMP_DMA_ALLOC_FIXED_SIZE	0x1000U
+
+enum zynqmp_sha_op {
+	ZYNQMP_SHA3_INIT = 1,
+	ZYNQMP_SHA3_UPDATE = 2,
+	ZYNQMP_SHA3_FINAL = 4,
+};
+
+struct zynqmp_sha_drv_ctx {
+	struct shash_alg sha3_384;
+	struct device *dev;
+};
+
+struct zynqmp_sha_tfm_ctx {
+	struct device *dev;
+	struct crypto_shash *fbk_tfm;
+};
+
+struct zynqmp_sha_desc_ctx {
+	struct shash_desc fbk_req;
+};
+
+static dma_addr_t update_dma_addr, final_dma_addr;
+static char *ubuf, *fbuf;
+
+static int zynqmp_sha_init_tfm(struct crypto_shash *hash)
+{
+	const char *fallback_driver_name = crypto_shash_alg_name(hash);
+	struct zynqmp_sha_tfm_ctx *tfm_ctx = crypto_shash_ctx(hash);
+	struct shash_alg *alg = crypto_shash_alg(hash);
+	struct crypto_shash *fallback_tfm;
+	struct zynqmp_sha_drv_ctx *drv_ctx;
+
+	drv_ctx = container_of(alg, struct zynqmp_sha_drv_ctx, sha3_384);
+	tfm_ctx->dev = drv_ctx->dev;
+
+	/* Allocate a fallback and abort if it failed. */
+	fallback_tfm = crypto_alloc_shash(fallback_driver_name, 0,
+					  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(fallback_tfm))
+		return PTR_ERR(fallback_tfm);
+
+	tfm_ctx->fbk_tfm = fallback_tfm;
+	hash->descsize += crypto_shash_descsize(tfm_ctx->fbk_tfm);
+
+	return 0;
+}
+
+static void zynqmp_sha_exit_tfm(struct crypto_shash *hash)
+{
+	struct zynqmp_sha_tfm_ctx *tfm_ctx = crypto_shash_ctx(hash);
+
+	if (tfm_ctx->fbk_tfm) {
+		crypto_free_shash(tfm_ctx->fbk_tfm);
+		tfm_ctx->fbk_tfm = NULL;
+	}
+
+	memzero_explicit(tfm_ctx, sizeof(struct zynqmp_sha_tfm_ctx));
+}
+
+static int zynqmp_sha_init(struct shash_desc *desc)
+{
+	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
+	struct zynqmp_sha_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+
+	dctx->fbk_req.tfm = tctx->fbk_tfm;
+	return crypto_shash_init(&dctx->fbk_req);
+}
+
+static int zynqmp_sha_update(struct shash_desc *desc, const u8 *data, unsigned int length)
+{
+	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	return crypto_shash_update(&dctx->fbk_req, data, length);
+}
+
+static int zynqmp_sha_final(struct shash_desc *desc, u8 *out)
+{
+	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	return crypto_shash_final(&dctx->fbk_req, out);
+}
+
+static int zynqmp_sha_finup(struct shash_desc *desc, const u8 *data, unsigned int length, u8 *out)
+{
+	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	return crypto_shash_finup(&dctx->fbk_req, data, length, out);
+}
+
+static int zynqmp_sha_import(struct shash_desc *desc, const void *in)
+{
+	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
+	struct zynqmp_sha_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+
+	dctx->fbk_req.tfm = tctx->fbk_tfm;
+	return crypto_shash_import(&dctx->fbk_req, in);
+}
+
+static int zynqmp_sha_export(struct shash_desc *desc, void *out)
+{
+	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	return crypto_shash_export(&dctx->fbk_req, out);
+}
+
+static int zynqmp_sha_digest(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
+{
+	unsigned int remaining_len = len;
+	int update_size;
+	int ret;
+
+	ret = zynqmp_pm_sha_hash(0, 0, ZYNQMP_SHA3_INIT);
+	if (ret)
+		return ret;
+
+	while (remaining_len != 0) {
+		memset(ubuf, 0, ZYNQMP_DMA_ALLOC_FIXED_SIZE);
+		if (remaining_len >= ZYNQMP_DMA_ALLOC_FIXED_SIZE) {
+			update_size = ZYNQMP_DMA_ALLOC_FIXED_SIZE;
+			remaining_len -= ZYNQMP_DMA_ALLOC_FIXED_SIZE;
+		} else {
+			update_size = remaining_len;
+			remaining_len = 0;
+		}
+		memcpy(ubuf, data, update_size);
+		flush_icache_range((unsigned long)ubuf, (unsigned long)ubuf + update_size);
+		ret = zynqmp_pm_sha_hash(update_dma_addr, update_size, ZYNQMP_SHA3_UPDATE);
+		if (ret)
+			return ret;
+
+		data += update_size;
+	}
+
+	ret = zynqmp_pm_sha_hash(final_dma_addr, SHA3_384_DIGEST_SIZE, ZYNQMP_SHA3_FINAL);
+	memcpy(out, fbuf, SHA3_384_DIGEST_SIZE);
+	memset(fbuf, 0, SHA3_384_DIGEST_SIZE);
+
+	return ret;
+}
+
+static struct zynqmp_sha_drv_ctx sha3_drv_ctx = {
+	.sha3_384 = {
+		.init = zynqmp_sha_init,
+		.update = zynqmp_sha_update,
+		.final = zynqmp_sha_final,
+		.finup = zynqmp_sha_finup,
+		.digest = zynqmp_sha_digest,
+		.export = zynqmp_sha_export,
+		.import = zynqmp_sha_import,
+		.init_tfm = zynqmp_sha_init_tfm,
+		.exit_tfm = zynqmp_sha_exit_tfm,
+		.descsize = sizeof(struct zynqmp_sha_desc_ctx),
+		.statesize = sizeof(struct sha3_state),
+		.digestsize = SHA3_384_DIGEST_SIZE,
+		.base = {
+			.cra_name = "sha3-384",
+			.cra_driver_name = "zynqmp-sha3-384",
+			.cra_priority = 300,
+			.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY |
+				     CRYPTO_ALG_ALLOCATES_MEMORY |
+				     CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize = SHA3_384_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct zynqmp_sha_tfm_ctx),
+			.cra_alignmask = 3,
+			.cra_module = THIS_MODULE,
+		}
+	}
+};
+
+static int zynqmp_sha_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int err;
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(ZYNQMP_DMA_BIT_MASK));
+	if (err < 0) {
+		dev_err(dev, "No usable DMA configuration\n");
+		return err;
+	}
+
+	err = crypto_register_shash(&sha3_drv_ctx.sha3_384);
+	if (err < 0) {
+		dev_err(dev, "Failed to register shash alg.\n");
+		return err;
+	}
+
+	sha3_drv_ctx.dev = dev;
+	platform_set_drvdata(pdev, &sha3_drv_ctx);
+
+	ubuf = dma_alloc_coherent(dev, ZYNQMP_DMA_ALLOC_FIXED_SIZE, &update_dma_addr, GFP_KERNEL);
+	if (!ubuf) {
+		err = -ENOMEM;
+		goto err_shash;
+	}
+
+	fbuf = dma_alloc_coherent(dev, SHA3_384_DIGEST_SIZE, &final_dma_addr, GFP_KERNEL);
+	if (!fbuf) {
+		err = -ENOMEM;
+		goto err_mem;
+	}
+
+	return 0;
+
+err_mem:
+	dma_free_coherent(sha3_drv_ctx.dev, ZYNQMP_DMA_ALLOC_FIXED_SIZE, ubuf, update_dma_addr);
+
+err_shash:
+	crypto_unregister_shash(&sha3_drv_ctx.sha3_384);
+
+	return err;
+}
+
+static int zynqmp_sha_remove(struct platform_device *pdev)
+{
+	sha3_drv_ctx.dev = platform_get_drvdata(pdev);
+
+	dma_free_coherent(sha3_drv_ctx.dev, ZYNQMP_DMA_ALLOC_FIXED_SIZE, ubuf, update_dma_addr);
+	dma_free_coherent(sha3_drv_ctx.dev, SHA3_384_DIGEST_SIZE, fbuf, final_dma_addr);
+	crypto_unregister_shash(&sha3_drv_ctx.sha3_384);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_sha_driver = {
+	.probe = zynqmp_sha_probe,
+	.remove = zynqmp_sha_remove,
+	.driver = {
+		.name = "zynqmp-sha3-384",
+	},
+};
+
+static int __init sha_driver_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	ret = platform_driver_register(&zynqmp_sha_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(zynqmp_sha_driver.driver.name,
+					       0, NULL, 0);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		platform_driver_unregister(&zynqmp_sha_driver);
+		pr_info("Failed to register ZynqMP SHA3 dvixe %d\n", ret);
+	}
+
+	return ret;
+}
+
+device_initcall(sha_driver_init);
+
+static void __exit sha_driver_exit(void)
+{
+	platform_driver_unregister(&zynqmp_sha_driver);
+}
+
+module_platform_driver(zynqmp_sha_driver);
+
+MODULE_DESCRIPTION("ZynqMP SHA3 hardware acceleration support.");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Harsha <harsha.harsha@xilinx.com>");
-- 
1.8.2.1

