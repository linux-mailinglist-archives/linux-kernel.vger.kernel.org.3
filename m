Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD14BA986
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbiBQTQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:16:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbiBQTP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:15:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B79025A;
        Thu, 17 Feb 2022 11:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT9Y2X+L90VsLu6Gi32fBwwXDjAUJCl7Ms1AJQ/OoWUJwZkSQVNCxECBKEjYpm4gBMtysuFYf8J2pU+uSN0YiSzlwZ9/qk2WKg+/52Se1Iy2LvuyV6g7AS1qDlm3qOTsDbg0QEPBuymMKUc+8hYFywYJXRzuBmKcdmeFucsJoWjHU2RGx/xLjjqahp+qczRfSQKFxJdXO16MbqynRHkuWVgaF3QTa90UxIs5MnuvvcU76XOMxoWWfVJwiTBQeHx5+cXWhETFoV+26a1p6JUO0ze/iof6Xazf56z4gkhomJ6MLifw4bWbe3zexc6xvwFFGHYs75V3cktr//xH1zeXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QenrutwF65zI6N3zg8PZkoW1LJ0PEPv3CktOBABn7VY=;
 b=hIT6em2oVxpDNT8C51Hw0NRYwJqjIQTP2r80FCfbj8oSnEYWhdyUJd72skHLO23Q2mFzl0KaLjvvIVDSGP4NMryU9sehLyqb1DXDu5yWYv0taKgWnphrd538EemzBCTX2eT8HGbaaxxE7sXvzhmnzUdKoVshi8DThktxV33BgiPxgJ9flgOC4sC5iomJn25KId8J+mQHUsLcakLp08qFBHvNW5vHTBMvvwxDCcFOgbNq1fyiRMdgd2HOFoCGg0HgARwSUe3wTAy7jKEZ0ffNenLCE/FqcdSrto9lcDxD16Yl6LHRG7+HbgNJsYJJaVmd3+AYkpDYeYRTDWRrhzUn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QenrutwF65zI6N3zg8PZkoW1LJ0PEPv3CktOBABn7VY=;
 b=Fj35JSmsAX1luBNzfdCGykxFYsWxm1ZoXuQuQ0g9pmMLxH6CiZ1BJ6UDI6H6CoRAsiWONqLGLQEPpSwPF+DGFeV+vTIg+ME/CzuZtZ00SXI2WKk6LG6vEw1ztUfXO8+JKcdVZlI5EnxJIV4T9U8gGNS+741PVNZ547gyHGQXtrY=
Received: from SA0PR12CA0021.namprd12.prod.outlook.com (2603:10b6:806:6f::26)
 by CH0PR02MB8193.namprd02.prod.outlook.com (2603:10b6:610:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 19:15:40 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::5d) by SA0PR12CA0021.outlook.office365.com
 (2603:10b6:806:6f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 19:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 19:15:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 17 Feb 2022 11:14:37 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 17 Feb 2022 11:14:37 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=57270 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nKmEf-0002nF-EM; Thu, 17 Feb 2022 11:14:37 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V2 3/4] crypto: xilinx: Add Xilinx SHA3 driver
Date:   Fri, 18 Feb 2022 00:44:23 +0530
Message-ID: <1645125264-11033-4-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 378e35be-45d8-49da-ee0e-08d9f249e286
X-MS-TrafficTypeDiagnostic: CH0PR02MB8193:EE_
X-Microsoft-Antispam-PRVS: <CH0PR02MB81931892E45E23F58B41DDCDDE369@CH0PR02MB8193.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtxW7r5Pxsv8CHl94qgJ2o3oEidHjtLkwtB7zfUE46bSnWkqtA/x1MLKfVB5fCudNXIorgqo6hMnQv+YRurKQCK36SxMEEGjNnpsigJFl905d5n5wQ1AL0rr4PFtyj0Tf0Ckp8xPM/eDNXm2GGnqcPFN0++e6qNjVRvtr3XResZdyBN2oS5fjk8LrLOc1wjco82leiI2tlDJpyaIxIpZmXZMA2XPYO4ZcWUddTkeR+dkCM2SVao22Jl5q8WCW1LweV9vczwXk1JznZs2kw5ne1Z0lJZrT+9PmGJcmjEjbRegmSXf0eRtHyzx4/qfgcHoZSriWsDdVTdAloULWOCiX037yyMNgEWbsz7PkiCiMKD93AQqLP4N2w1NzxNEvAyFYTYncsrMbPYCU0FkYS/pl/jFe+pecuOnwBgH/cbjbuXxhJadgSwmpRvjlAGj2tPZOvLWNR8qrB8SXEdxhySZ1rLdXt7qKLrh/wnmEnrC7YS1iqyovt19zm3m/Ugr2OXeJvhg54+2gw7Ex5J3ssUqeQzR2u/M9SGDWKByLe/snwPN7SaXxz3pGAwYgVh1oY408lRCUUIIJMUbQfdY34hqqrfjoxGzKlzb4XgA4797xq2LODSd8kwA0iVuRyDkcHU5/fvA8Q/nsPuL2mg1jc2UAM01eh7yiAakB+3WLPOzrSFvzhwU2pKiQz+sW68+YyM4MCILTKQgS/9yrVKm84hAHoI1CPLTLUVfxU81ks6LJZY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(7696005)(70586007)(47076005)(508600001)(40460700003)(6636002)(2906002)(316002)(110136005)(54906003)(36860700001)(7636003)(356005)(36756003)(4326008)(8676002)(5660300002)(83380400001)(9786002)(8936002)(2616005)(6666004)(82310400004)(107886003)(26005)(336012)(186003)(426003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 19:15:39.5882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378e35be-45d8-49da-ee0e-08d9f249e286
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8193
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4f70567..bf4e55e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -808,6 +808,16 @@ config CRYPTO_DEV_ZYNQMP_AES
 	  accelerator. Select this if you want to use the ZynqMP module
 	  for AES algorithms.
 
+config CRYPTO_DEV_ZYNQMP_SHA3
+	bool "Support for Xilinx ZynqMP SHA3 hardware accelerator"
+	depends on ARCH_ZYNQMP
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
index 0000000..1eaca97
--- /dev/null
+++ b/drivers/crypto/xilinx/zynqmp-sha.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZynqMP SHA Driver.
+ * Copyright (c) 2022 Xilinx Inc.
+ */
+#include <linux/cacheflush.h>
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

