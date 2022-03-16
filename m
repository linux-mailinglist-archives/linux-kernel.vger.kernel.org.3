Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0A4DB7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357703AbiCPSDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPSDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:03:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA649C97;
        Wed, 16 Mar 2022 11:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgeXKINkokg3go9NIk3X927boP3+LDcHqQhTb3rJfmSwPGrw7dtVXwp9162HXYTN33lRmFYQO442y84aPU2dNoejoaUVnLnCUUkHOW1ttPAPHFbWRvLMjv3rMkJQO/iZEXunEmDt1heKW7vHo6P7D0JvO0jVrwOcxCWBn4Cx9C+AmpMUzmbQzl+ciSoFUNfuJ/pSrxI7Q/dw7G6EjnqdvaCr4HRZgHCBneVicCim5rvcwsbnML61Xs76yCe367h9WGIe539VGt+PdnyqLhgW+Gbqc4fCMxnkC90b/GgPUppvECSvPWR5YjqKwv9NqhkyZyIVdFpV2Ets+Sj09eSTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z915+tjM/bn2Zv/Bz4fWCSchwxz6kiNxQzOzWMxo+WI=;
 b=Fd1dx1PmR4bb4RNlSg9HIfzewAv162TzR8h5+iqCwsZGF9+bjhiHeGjpPRECjXKHcve0lmxTuhCVrIZHknfo6duBhADIs7XSYPESoezTj8aPTxIAimjhQv2oDM4g3HfwU5dxwGqf9Isqq8JxpwhI8DQGHgCyjx1/seYQ6BFZ5D1m7pfTiTApJkPH5rhodL9mhrGEkUdN9/RvF1chIOYDMohNMHR+C500Q2CDMj2WG2GBhBISsYScd5klDFXa027yhrI5h4NkhChy9DNXC35sXXFmkBxlZ5Itx8+UvsAIz3AHRbfZLhYuqkw0F3AC7BXpSu64zoPH/MLzcztypVLlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z915+tjM/bn2Zv/Bz4fWCSchwxz6kiNxQzOzWMxo+WI=;
 b=rjWbo32wNSfV8hAFXwxvVDkQQSNZ28I5DToxs0LahLr9o+h9izEBwtdwxUIxk27CXYETAiBND8BZsB+VKOIz/RRNqmiyYiRgD/0nTbx/GqhmK8lzdLCBz8IXyQvqjlroEsa9MDZY1WgNoQLG1yVad7L4C8tT3cNYFpzQlCTCEzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (2603:10a6:208:5f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Wed, 16 Mar 2022 18:02:12 +0000
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::a813:c3ed:d1d3:5b03]) by HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::a813:c3ed:d1d3:5b03%7]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 18:02:12 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] crypto: caam/rng: Add support for PRNG
Date:   Wed, 16 Mar 2022 19:01:49 +0100
Message-Id: <20220316180149.4070622-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316180149.4070622-1-meenakshi.aggarwal@nxp.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
 <20220316180149.4070622-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:205::35)
 To HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04bc0174-f2dd-4227-930e-08da0777183c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4114:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB41145E65BDA52E0E1A60E6B88E119@AM0PR04MB4114.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fslMSOJJdDc7peNNyuzYHjFz/SY795eewU36lQmNUVkBcRPYVjUOit9TxF7pLNpAPLIQlLPsYBVB/kiFjLMgkeqoHZi8unx1IiSEAhOEjIUxWFEPFocNBoy8y8PzsY8M9qUAgsxhfSwji4aF70KS85pwC3UWQYnI4yHrp2RhGob7Kekda0SKe6/XAZUg1lCRqtXV+HazLnRfLvS/5R7GvuCJUwac4q1M02bnwKWIZ1p/vmFM8GN4Y+NfWHcZvDnIHl7cwVioJUVCBsgTsLk/ALWBpyE1oKTmZsKPhlmBicrXloXwuevPTZfhJ0t8ytWGl4i2Hvo22E78fxlWhu7SWg+ab5UqfjEJvojmdfjCtZ+4r/tK8isXD1qNj4C7zOwUeVwu0BwJzFpyA+x4shrLZwc+Rs5E7boJspvv6vodx5f6TzOPoHTL9pR/FyQel4ab3c2qtuZ5n4LhdSSGCZAENFsBoFCAGT0657OBZjc32fGwyn5mIg1Wxhu4WV0qmpkPqkA58GRZMCEbwSc7hQQT5YMArGVj8czvdFk9nWMic/5eXSPjtCeWfFUvdYfifjc57AmHAf4kcsOFbWJwFzTQjOEUvJfviL5HXQsW2j/SDIbRXSa8pVUAShxoFC14n7+vZXIFc4ePohqAm1QBhL4FgBkR3DrrJSY7S3BYw7eIfc1Otnzv4JeYwJtlc233Y/3h/vwrjdtMgVDIhmd1VrL7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2971.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(66556008)(66476007)(66946007)(38100700002)(6486002)(508600001)(1076003)(6506007)(38350700002)(52116002)(2616005)(9686003)(6512007)(8676002)(4326008)(6666004)(26005)(186003)(8936002)(110136005)(54906003)(2906002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n1RPlaRVSRsJGnB1bAhtynUZXFDR9gGcF3udmfTuKlo1PaYDHCQVNvsfQkSC?=
 =?us-ascii?Q?YXdQwD+/5mMbFSGFggFMIHAcNz/6FjR7Qduo/tIuUkT8XLwYNoU0se9GcK0L?=
 =?us-ascii?Q?sJtCzf1HChexDOfDfPBaDEFWvkjwB46b5lZX+05NCRZZG5oSU0GyQdEAHB1K?=
 =?us-ascii?Q?ZLDJnNS9mmAeL6zsuUb3XNKjEyscCABTYSBOH3NN36up17arITQ0WtAJxBm7?=
 =?us-ascii?Q?NT24b7Qmpha15Tvb1xsKKk3NhB9C6LEHQGy4e+8refjgcwS2ARkTbi4TuFW9?=
 =?us-ascii?Q?bK2YIc5Fp714LWEp5dpQUaoOjhlORT4+wJe3NdyZt8NfJ7LIvx3rEGQztDMV?=
 =?us-ascii?Q?Ar9xV2ie/0USP9BVCgX6Bxhwk2NdphF3ztrgDWKjr0ciRuui/UzCitoOmQMm?=
 =?us-ascii?Q?VXI4QOicUyDkneUtL2IqBhaq4V3fLcKcTKJ3JVTiXETIHUhp9RDbQ9w4B6Z9?=
 =?us-ascii?Q?SKgdEmksNESrw88Lvnof1fnEfXB1sqyypE0eLbCRR84FLBsg4jYFGrFop0TT?=
 =?us-ascii?Q?3bPtrzrzMKBnI614ToDP0Dauo69o+QjvGNJeWVlEiz4pI0DRFVrEJAuQCFbS?=
 =?us-ascii?Q?K7JcDe2s0dpPJNBQIcRLacZn6ux1JrrhG3om4JPc0LfwOlJVBasaWSelBDpA?=
 =?us-ascii?Q?wGq/vzP+Z7g4Qw+4gO9ia05nYpvigS9wuIVU4fgRyiuA2we2G7tszGwf4dLg?=
 =?us-ascii?Q?wzPVlaak581m8nYZaVC2ST3YfBMog8iMY+HZwds+fFYN3ZNjJVclwQLVa2o+?=
 =?us-ascii?Q?cqLFDp/rf9b8tfN/BCBey03y9EUp59seEArJnwc0/VhfQa4RNps4N02Ln4k4?=
 =?us-ascii?Q?6878aFTIZdX8bkINAyMCGFnGg738a7BzKkceCvCJ4IikMLH1agNm1QzXHd5Z?=
 =?us-ascii?Q?FpSKb7MtH7jc/TrpolplgJee6xGfOR+55VhDWVeySXa+vNdMZU3rEXP7S/HV?=
 =?us-ascii?Q?pcWyLV07opUumYzYKuMpgsmZawmiTU8+T7/5m6E/y2+IJdPxjdRAnTcRcnA7?=
 =?us-ascii?Q?V921VSmVcMfYgAbnDK2gLa3pCdpoFZHPy0IUr4cJ3wO5pZRmLjPtgFcxUr7m?=
 =?us-ascii?Q?QBY+81QWPym17Nv4tH84wo1wTsb0LPQPMrXYipIiUZSbkp+jyb9RlzFdlcsJ?=
 =?us-ascii?Q?hzyMsYWbJnzplEmcG8IdMLSVEROCLZ4z/ctRq6mSlW6dOQNnpLx9tlIxzZ18?=
 =?us-ascii?Q?a2clLtST4uug5IjzwI17IhsyqRr1F4G7kKgr1LcN39IHBhwIrMAKRtvn6Yy6?=
 =?us-ascii?Q?oJZIse/GtpPHwfqAHGXpqRRT3bzaSfeItcCziLWmx8V1mZDChUqujK5R1plM?=
 =?us-ascii?Q?8a2agx46rPoaGQQNTtpYC5/DXwL5dI5aK9DqwTwyHXfyDvKshwfGhD6PKB7h?=
 =?us-ascii?Q?O/03d+OYo7Jy5qX9lY6jKhRs3DMlNrTTWhGUuW6rGBdfgy8iCM7xvG+8Xd//?=
 =?us-ascii?Q?GxI4X9VhpqAsjfq1mnIlOMrl+b8c9VOer0+4wZ08yFlKLvgs/jwA5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bc0174-f2dd-4227-930e-08da0777183c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2971.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 18:02:11.7346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWroFejPkP+uozATKVgnoZve0uz3+y25z2BONslsOHFX/xcKNrXVjwx2xUcyv4jsorZ3uetXaL19KYztF7/tQGVs3LuiqsEmbu0HfCIzVFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Add support for random number generation using PRNG
mode of CAAM and expose the interface through crypto API.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/Kconfig    |   9 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 256 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/desc.h     |   1 +
 drivers/crypto/caam/intern.h   |  15 ++
 drivers/crypto/caam/jr.c       |   2 +
 6 files changed, 284 insertions(+)
 create mode 100644 drivers/crypto/caam/caamprng.c

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index 84ea7cba5ee5..d94250348b32 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -151,6 +151,15 @@ config CRYPTO_DEV_FSL_CAAM_RNG_API
 	  Selecting this will register the SEC4 hardware rng to
 	  the hw_random API for supplying the kernel entropy pool.
 
+
+config CRYPTO_DEV_FSL_CAAM_PRNG_API
+	bool "Register Pseudo random number generation implementation with Crypto API"
+	default y
+	select CRYPTO_RNG
+	help
+	  Selecting this will register the SEC hardware prng to
+	  the Crypto API.
+
 endif # CRYPTO_DEV_FSL_CAAM_JR
 
 endif # CRYPTO_DEV_FSL_CAAM
diff --git a/drivers/crypto/caam/Makefile b/drivers/crypto/caam/Makefile
index 3570286eb9ce..59961a0bbfe4 100644
--- a/drivers/crypto/caam/Makefile
+++ b/drivers/crypto/caam/Makefile
@@ -21,6 +21,7 @@ caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += caamalg_qi.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) += caamhash.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) += caamrng.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) += caampkc.o pkc_desc.o
+caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PRNG_API) += caamprng.o
 
 caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += qi.o
 ifneq ($(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI),)
diff --git a/drivers/crypto/caam/caamprng.c b/drivers/crypto/caam/caamprng.c
new file mode 100644
index 000000000000..0524017a5e73
--- /dev/null
+++ b/drivers/crypto/caam/caamprng.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver to expose SEC4 PRNG via crypto RNG API
+ *
+ * Copyright 2022 NXP
+ *
+ */
+
+#include <linux/completion.h>
+#include <crypto/internal/rng.h>
+#include "compat.h"
+#include "regs.h"
+#include "intern.h"
+#include "desc_constr.h"
+#include "jr.h"
+#include "error.h"
+
+/*
+ * Length of used descriptors, see caam_init_desc()
+ */
+#define CAAM_PRNG_DESC_LEN (CAAM_CMD_SZ +				\
+			    CAAM_CMD_SZ +				\
+			    CAAM_CMD_SZ + CAAM_PTR_SZ_MAX)
+
+/* prng per-device context */
+struct caam_prng_ctx {
+	struct device *jrdev;
+	struct completion done;
+};
+
+struct caam_prng_alg {
+	struct rng_alg rng;
+	bool registered;
+};
+
+static void caam_prng_done(struct device *jrdev, u32 *desc, u32 err,
+			  void *context)
+{
+	struct caam_prng_ctx *jctx = context;
+
+	if (err)
+		caam_jr_strstatus(jrdev, err);
+
+	complete(&jctx->done);
+}
+
+static u32 *caam_init_reseed_desc(u32 *desc, dma_addr_t seed_dma, u32 len)
+{
+	init_job_desc(desc, 0);	/* + 1 cmd_sz */
+	/* Generate random bytes: + 1 cmd_sz */
+	append_operation(desc, OP_TYPE_CLASS1_ALG | OP_ALG_ALGSEL_RNG |
+			OP_ALG_AS_FINALIZE | OP_ALG_AI_ON);
+	/* Store bytes: + 1 cmd_sz + caam_ptr_sz  */
+	append_load(desc, seed_dma, len, CLASS_1 | LDST_SRCDST_BYTE_CONTEXT);
+
+	print_hex_dump_debug("prng reseed desc@: ", DUMP_PREFIX_ADDRESS,
+			     16, 4, desc, desc_bytes(desc), 1);
+
+	return desc;
+}
+
+static u32 *caam_init_prng_desc(u32 *desc, dma_addr_t dst_dma, u32 len)
+{
+	init_job_desc(desc, 0);	/* + 1 cmd_sz */
+	/* Generate random bytes: + 1 cmd_sz */
+	append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG);
+	/* Store bytes: + 1 cmd_sz + caam_ptr_sz  */
+	append_fifo_store(desc, dst_dma,
+			  len, FIFOST_TYPE_RNGSTORE);
+
+	print_hex_dump_debug("prng job desc@: ", DUMP_PREFIX_ADDRESS,
+			     16, 4, desc, desc_bytes(desc), 1);
+
+	return desc;
+}
+
+static int caam_prng_generate(struct crypto_rng *tfm,
+			     const u8 *src, unsigned int slen,
+			     u8 *dst, unsigned int dlen)
+{
+	struct caam_prng_ctx ctx;
+	dma_addr_t dst_dma;
+	u32 *desc;
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(dlen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ctx.jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(ctx.jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		kfree(buf);
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		caam_jr_free(ctx.jrdev);
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	dst_dma = dma_map_single(ctx.jrdev, buf, dlen, DMA_FROM_DEVICE);
+	if (dma_mapping_error(ctx.jrdev, dst_dma)) {
+		dev_err(ctx.jrdev, "Failed to map destination buffer memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	init_completion(&ctx.done);
+	ret = caam_jr_enqueue(ctx.jrdev,
+			      caam_init_prng_desc(desc, dst_dma, dlen),
+			      caam_prng_done, &ctx);
+
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&ctx.done);
+		ret = 0;
+	}
+
+	dma_unmap_single(ctx.jrdev, dst_dma, dlen, DMA_FROM_DEVICE);
+
+	memcpy(dst, buf, dlen);
+out:
+	caam_jr_free(ctx.jrdev);
+	kfree(desc);
+	kfree(buf);
+	return ret;
+}
+
+static void caam_prng_exit(struct crypto_tfm *tfm) {}
+
+static int caam_prng_init(struct crypto_tfm *tfm)
+{
+	return 0;
+}
+
+static int caam_prng_seed(struct crypto_rng *tfm,
+			 const u8 *seed, unsigned int slen)
+{
+	struct caam_prng_ctx ctx;
+	dma_addr_t seed_dma;
+	u32 *desc;
+	u8 *buf;
+	int ret = 0;
+
+	if (seed == NULL) {
+		pr_err("Seed not provided\n");
+		return ret;
+	}
+
+	buf = kzalloc(slen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ctx.jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(ctx.jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		kfree(buf);
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		caam_jr_free(ctx.jrdev);
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	memcpy(buf, seed, slen);
+
+	seed_dma = dma_map_single(ctx.jrdev, buf, slen, DMA_FROM_DEVICE);
+	if (dma_mapping_error(ctx.jrdev, seed_dma)) {
+		dev_err(ctx.jrdev, "Failed to map seed buffer memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	init_completion(&ctx.done);
+	ret = caam_jr_enqueue(ctx.jrdev,
+			      caam_init_reseed_desc(desc, seed_dma, slen),
+			      caam_prng_done, &ctx);
+
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&ctx.done);
+		ret = 0;
+	}
+
+	dma_unmap_single(ctx.jrdev, seed_dma, slen, DMA_FROM_DEVICE);
+
+out:
+	caam_jr_free(ctx.jrdev);
+	kfree(desc);
+	kfree(buf);
+	return ret;
+}
+
+static struct caam_prng_alg caam_prng_alg = {
+	.rng = {
+		.generate = caam_prng_generate,
+		.seed = caam_prng_seed,
+		.seedsize = 32,
+		.base = {
+			.cra_name = "stdrng",
+			.cra_driver_name = "prng-caam",
+			.cra_priority = 500,
+			.cra_ctxsize = sizeof(struct caam_prng_ctx),
+			.cra_module = THIS_MODULE,
+			.cra_init = caam_prng_init,
+			.cra_exit = caam_prng_exit,
+		},
+	}
+};
+
+void caam_prng_unregister(void *data)
+{
+	if (caam_prng_alg.registered)
+		crypto_unregister_rng(&caam_prng_alg.rng);
+}
+
+int caam_prng_register(struct device *ctrldev)
+{
+	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
+	u32 rng_inst;
+	int ret = 0;
+
+	/* Check for available RNG blocks before registration */
+	if (priv->era < 10)
+		rng_inst = (rd_reg32(&priv->jr[0]->perfmon.cha_num_ls) &
+			    CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
+	else
+		rng_inst = rd_reg32(&priv->jr[0]->vreg.rng) & CHA_VER_NUM_MASK;
+
+	if (!rng_inst) {
+		dev_dbg(ctrldev, "RNG block is not available... skipping registering algorithm\n");
+		return ret;
+	}
+
+	ret = crypto_register_rng(&caam_prng_alg.rng);
+	if (ret) {
+		dev_err(ctrldev,
+			"couldn't register rng crypto alg: %d\n",
+			ret);
+		return ret;
+	}
+
+	caam_prng_alg.registered = true;
+
+	dev_info(ctrldev,
+		 "rng crypto API alg registered %s\n", caam_prng_alg.rng.base.cra_name);
+
+	return 0;
+}
diff --git a/drivers/crypto/caam/desc.h b/drivers/crypto/caam/desc.h
index e13470901586..33db8ed2b49e 100644
--- a/drivers/crypto/caam/desc.h
+++ b/drivers/crypto/caam/desc.h
@@ -1255,6 +1255,7 @@
 #define OP_ALG_ICV_ON		(1 << OP_ALG_ICV_SHIFT)
 
 #define OP_ALG_PR_ON		BIT(1)
+#define OP_ALG_AI_ON		BIT(11)
 
 #define OP_ALG_DIR_SHIFT	0
 #define OP_ALG_DIR_MASK		1
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 7d45b21bd55a..c2f51365df1b 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -185,6 +185,21 @@ static inline void caam_rng_exit(struct device *dev) {}
 
 #endif /* CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API */
 
+#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_PRNG_API
+
+int caam_prng_register(struct device *dev);
+void caam_prng_unregister(void *data);
+
+#else
+
+static inline int caam_prng_register(struct device *dev)
+{
+	return 0;
+}
+
+static inline void caam_prng_unregister(void *data) {}
+#endif /* CONFIG_CRYPTO_DEV_FSL_CAAM_PRNG_API */
+
 #ifdef CONFIG_CAAM_QI
 
 int caam_qi_algapi_init(struct device *dev);
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 7f2b1101f567..11849362f912 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -39,6 +39,7 @@ static void register_algs(struct caam_drv_private_jr *jrpriv,
 	caam_algapi_hash_init(dev);
 	caam_pkc_init(dev);
 	jrpriv->hwrng = !caam_rng_init(dev);
+	caam_prng_register(dev);
 	caam_qi_algapi_init(dev);
 
 algs_unlock:
@@ -56,6 +57,7 @@ static void unregister_algs(void)
 
 	caam_pkc_exit();
 	caam_algapi_hash_exit();
+	caam_prng_unregister(NULL);
 	caam_algapi_exit();
 
 algs_unlock:
-- 
2.25.1

