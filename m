Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C464462F14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhK3I6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:43 -0500
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:28896
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239893AbhK3I6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlPZcRJmfo7bYu+BiKgbqrhYIli/RazrUuJL+Nnk0XPcJ8wHmvvXgtOu6qoele/H3ldqbM/M9EtgD7X5EwFOvvSGNLcH9sMQJuGKvMAwPsdwvbDsHkxvBH0Pmy7TSh18FS5y+jMijLJfaO7hpEbSOzVQPHQKZAe1Tt6CD4F4YwzPkvp7U1D6maLCnLuwTinXAq6ltiQEm/w/VqjbH+qx6/CBynoe1ct1t8VubT8mjw1KhgOOZA3jB3izwQGqLFbEpnFxTXmUJKKlZfGAw/5wkurvTDOG9+khLzqYDBUsP+CBBvATPQ//3doCdRt9H4c7h10yWkaC0O+xFEv94syuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyGmwTr7UZIrxPwylXddOHr+vzjMI8ySftfu1NFGbwY=;
 b=ejoQhES+BSVgyHui8HSih5Fkhk+ru/n6MIbDNy98OxB5oKNbmlt7GzTWjelT69N6K4fADy0073KuKO3oVhqnA9OnUPte1/iAbOhzEtNPjypK31ubpF6LSievpdLpA0vFlJSGNVZSzcEaWOQgtaVvGh4JCCMcd6Phm+4Fhqc7hSYNSc5epzKu8azzJDn6UCXV5L3/YxLe/5AipSjH0j2S6fMIxs9UO5Q+V5I3Zl8pn+1vNWoaqFZ7Gp8UCqQX7r6CO6Z7GZ7RxII7bALa10G88PdMzgWmoKkLaJ9YY37RfrrM6Lr+TXl+8FaJ/YGQ7l7NN2DbVdDgJFdplEFH8AKjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyGmwTr7UZIrxPwylXddOHr+vzjMI8ySftfu1NFGbwY=;
 b=fiuqjyJzW1RYHT0EcbtX1DxXaCskpwXM9v2Z776yEDy6WXBOXq91vxpu7rRuCTOuWvhBd/0CJ2LUGlVORVX3kd3bk026RrPxcPXVNY8IzMxXVqBAE8eTlTjqixoK2SAFtaMNmsc8W4jbqzJFavdOQLprrnzuWIzwEuJgRLBhua8=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 CO6PR02MB8772.namprd02.prod.outlook.com (2603:10b6:303:143::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 08:54:49 +0000
Received: from DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::50) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT014.mail.protection.outlook.com (10.13.5.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:47 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:47 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.6] (port=56576 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1mryuV-000GNC-CC; Tue, 30 Nov 2021 00:54:47 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 5/6] crypto: xilinx: Add Xilinx SHA3 driver
Date:   Tue, 30 Nov 2021 14:24:24 +0530
Message-ID: <1638262465-10790-6-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21bf53f7-2746-493c-9560-08d9b3df10d5
X-MS-TrafficTypeDiagnostic: CO6PR02MB8772:
X-Microsoft-Antispam-PRVS: <CO6PR02MB8772E15BEF875644646196FCDE679@CO6PR02MB8772.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlubfANbvPdncnx27vgTd1wwq9C7EN1sYUe2EXQpXN+PDrVw+dY4bzH/JDa0rovyfwA43w9vOs0QlWILOovhS7xCoG2OfBF3lwFooqMz6X2IegYBHpK/8Ery/JV3ETexSL6lKGIGp5Ez/qeVmsRot80hqh3WeDZ3CITYz37ntmPFwWeWLOgE6z6kxg8pZZEYJzYM/kx3Mu5NnmSdU983XI7rkJuAF+6auBAwA+tLa8/fRRN39mKof/uahd0IwLhDKjxCwQWDFrcjYxlio7Uot5tCKzwK1KMrGc+duZQIm+DURSjMK0QDSdg9gME7tulgWn67mxcdglsoqjkATPMg8L99UTHnU65IZVFFIdgrK+8tR7dd4xSQic+RKwEjB5t/QOqMCxdxtK2eBv0ZZzGw9NpaeQb+E3OdQ909lQx8ZsTMyACEayjhGtQAD7Auvei9cHmW6yZQT4576JFfHFGNzZCtLGFYaLtrJGJbBbMXApd0S28U9XCBRuTNv2rvWka7NPYLt/KDmiCDj141uOyrhxrs+cu8tJdnfrbNSRFg9f8LPYCHIpNsXcS5aXJ6cCmQ8R8H2/qBMaCwcy4U33hTwUugmcjR9KzTe0DzAjSPHxDDn002U4d4l8K2XBbW2qpeOhJ7PsZf1ckXGwkPiw+U3AVM3nar8OZtXOgqR/SsipXNlRQjdvd3CaeV+h0rOn/19PPMfkJbiJo+Y6Fj1NrbZXGOY6dTQX5T/Khu4E2ULME=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(8676002)(7636003)(8936002)(6666004)(82310400004)(316002)(26005)(356005)(4326008)(7696005)(36756003)(47076005)(110136005)(2616005)(508600001)(70206006)(70586007)(107886003)(36860700001)(2906002)(9786002)(426003)(186003)(83380400001)(5660300002)(54906003)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:49.0238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bf53f7-2746-493c-9560-08d9b3df10d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8772
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
 drivers/crypto/xilinx/zynqmp-sha.c | 265 +++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 51690e7..5df252e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -796,6 +796,16 @@ config CRYPTO_DEV_ZYNQMP_AES
 	  accelerator. Select this if you want to use the ZynqMP module
 	  for AES algorithms.
 
+config CRYPTO_DEV_ZYNQMP_SHA3
+	bool "Support for Xilinx ZynqMP SHA3 hw accelerator"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select CRYPTO_SHA3
+	help
+	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
+	  This driver interfaces with SHA3 hw engine.
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
index 0000000..c7166ef
--- /dev/null
+++ b/drivers/crypto/xilinx/zynqmp-sha.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZynqMP SHA Driver.
+ * Copyright (c) 2021 Xilinx Inc.
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
+	int remaining_len = len;
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
+		flush_icache_user_range((unsigned long)ubuf, (unsigned long)ubuf + update_size);
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
+static const struct of_device_id zynqmp_sha_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-sha3-384" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, zynqmp_sha_dt_ids);
+
+static struct platform_driver zynqmp_sha_driver = {
+	.probe = zynqmp_sha_probe,
+	.remove = zynqmp_sha_remove,
+	.driver = {
+		.name = "zynqmp-sha3-384",
+		.of_match_table = of_match_ptr(zynqmp_sha_dt_ids),
+	},
+};
+
+module_platform_driver(zynqmp_sha_driver);
+
+MODULE_DESCRIPTION("ZynqMP SHA3 hw acceleration support.");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Harsha <harsha.harsha@xilinx.com>");
-- 
1.8.2.1

