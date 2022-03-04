Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1627A4CD3B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiCDLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCDLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:42:33 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC416203C;
        Fri,  4 Mar 2022 03:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijRWQWtrfRvmfQO5p859wK4uniGCkNLyXfnfSu3GIzVJUkcFEAdF16/8dNkz3c8RLE07g/RLCplYiRAwyVCC8LkXAXDL9JN1eQSVP+3mJ4rK3IB7xDIZBN29aNW1BoHxxs61OONPyg496azHMjPxbs+2SktYgcNniCH/P8sMVaE0xIT+sXKUl+P9XNwxGC8V7NUC9gk8TmjLsOUn20KNrwgurNktFA75t19vWft6oxhSKByEwOaKuFkb7MoGqsvzB1VRx6X6cxRNwfJeuW9HnA9kdQnl4PG3rxKvqvOcBjtjlbQZSKECmISCbWlj8p5H5R+F5wxJ8F8EfgdmJ+10lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrWsu9cJQx6DxpOOXR0trsCdFv5+qVebF0wrFVCn7iY=;
 b=fwKP1ZaZ8fKKjcvo4WkJsAWLvKVEtq0UZEYv72CZDGOXCP4uVhNJVViVI38jnKAr4OCbOVmPvCeS08g3mqtOENNuRyTCr9/WmXmmDrzrk9Vga8BPRiM8EtP1qXAZRdnX4zYhwGW52+NXDSoHGZU+6Uccg9MBfkCLOwr0VADH/m1lOzwLzxYHgfjf+P+nXxtXto7kBpVCFWbgCq5FhhFh9nnKKU/OprK2G3RpoazTcy3ztt+NI2Icz3ZYE5kpxk94blcNzGw8nUvC25o0WelrhEnT1EqCVGbpXZIxHuToqGbyhKNsl2xhqjM7rkf63mPNFoWCim70KdKLv6slsfs8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrWsu9cJQx6DxpOOXR0trsCdFv5+qVebF0wrFVCn7iY=;
 b=VxzCCij+ivuADkDtiSXtcHgDflohGRtSptNJyOpFmMMZDCn24W08CY5CPkpQupY7FTfrZk98G7X5C73sjK6HA1wFf6JQHpPWEeb58t6Q537JmpylGWTq6CtjVf+EX65Cq2JRrnwgP8nse5zHeAikWI7ZAM2vIQBAzC1/CcD21ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13) by
 VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 11:41:41 +0000
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::bd8c:f89a:866:d92e]) by HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::bd8c:f89a:866:d92e%3]) with mapi id 15.20.5017.030; Fri, 4 Mar 2022
 11:41:41 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: caam/rng: Add support for PRNG
Date:   Fri,  4 Mar 2022 12:41:23 +0100
Message-Id: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To HE1PR04MB2971.eurprd04.prod.outlook.com
 (2603:10a6:7:24::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a74c5cb-5e54-497b-d4f2-08d9fdd3f351
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB65097F0B9ED432066D6E51468E059@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5HXDkiuYTwgKMiuyUPwkbQiP6tivtL3UTtg7fIHcVSvcN2NVv15ufFcJAMmcMxfR7YGYhQXlTac9x/dbGxG/q0UKmxLXlfiKNcs0HcjZCDZ0Tuah5CP5X3hRleqP/4YMdIVxnUXFTpo/L3cof4m9lUQiNKnDRLHdijiHMoPwnhfvplB69Fb7tmZXNgUVIwDFFywHin4OTWoZqq8wvCUZOHWmaTPjlEZqBSNhts/U5dGYEZ4OQ6HIjwzFRQ/UYAXZULK2prjfwusZ/Z8Dd/y7KMObZCCA5aqabDocDCprroZGSOtsGJN8Z6XGd/WR+ypY98qkAX3noBW7jNad3LBGmCNIHZULW1OOpdoXQHZhKlb/wf26TeqeezIFPtZ45+CEXC9WEbWDgVFlz2fzvIPH67KQgsuZjawnbbBXg/2AFLnidvZhCg0AznCpZV7p/OjcB6lo1R6ht/Rh+M1YqpF1rYMPWmvaTRvdfQvsD8OCihBkm39Qto1Z+DQIE55dtV2Tl/3XUm+e7Zgv4/SeOMKv/XE5ayyc3qv+ytvFIMhn8BBW+rZGzY2TuZ8U48xazU3a4icuKzjj0X8hHpJyDjW0gkRAxwysoVUpVl98AGU/Kg+lRI2KKtSq0Bbgr+QTes1057F0W6WEgZOYBhwsHKCvS3+i3DYZbeY6zR/2x4mbjNP3XF10V2VRppFZW1+/PLtI9sY7lVk3/GcqT9/o8hdYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2971.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(8936002)(6666004)(9686003)(52116002)(5660300002)(6506007)(2906002)(498600001)(6486002)(86362001)(38350700002)(38100700002)(36756003)(8676002)(83380400001)(66476007)(66946007)(186003)(66556008)(1076003)(4326008)(26005)(2616005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72bfdhd8KxmRH6mUouJhOl/jr3utGukcbb3riB9wYtpsNtLskESdoOTgYhf6?=
 =?us-ascii?Q?ndjPVUvmWOtJVcro+pZNTtTIf6DYsyoiTzlRGca2XhGMG+7tGBMAPE/eDs45?=
 =?us-ascii?Q?B5qUzi3fRwaOTm9gs53ap3tfxUq/YQC7QBfalk6oSy6t0dV6pqdjPYQg5d+8?=
 =?us-ascii?Q?g+U+qZ4PHik/SfH6ZtDpsSBXj9w/Fs1V2CITvp+RK/51wAzjyiyGBqbzfUzm?=
 =?us-ascii?Q?dfmGr0pqKT5WT0gxAoKu+A+9SPLDsDculKq3w1FPKfxnfytjGGQd0AkCgdEg?=
 =?us-ascii?Q?QwHv+Ny0OBghkBDJSUzm77tdFPdImAdWkMdE9u1JeWoqa9rZL+sg2AAWJ1UD?=
 =?us-ascii?Q?hISvcSMfORuBYGswXkZTecRt2idRPZfd9UnZPPkB+PzwkYWkcEE+c/LKvI41?=
 =?us-ascii?Q?kq42b0Q7lRrSLrNAnRnpTcWY2bXw8hfnT9nQ3TBlWH+Jl4J1HlNjKx8SawWD?=
 =?us-ascii?Q?2QBBdUKtHHmtzfxatTDHt+/wtEVYR26LhRQKZWs4GGOwIvTt3nhVPMrrw5iL?=
 =?us-ascii?Q?097ZAL5QyTzkJjYpB16byMroP/T9ewBNYC+iWIPJBWAVPhDd2+W/bd0Ij8zY?=
 =?us-ascii?Q?K5xejuZm9eZyWNG1Pt5s22iFFcGsILFGapEsg/hurDpj1ItOWHJ3PS5VToFH?=
 =?us-ascii?Q?onUrLmJzopdjFIeWKdnEyKmajsUkz6WakO/PaIvD4frJuNYAotY1bVaPKaBQ?=
 =?us-ascii?Q?8NHiEwzTXEC18OyAEOQlzorL+Q68tGzqwnG7IQQgZCMQRsN8ybMEEVdS8uz6?=
 =?us-ascii?Q?mwdrmiKtzwW2zOIz+kci1kmUXeqs5fw6xmo6B4SGidGnTbcV9nGva+FufQN+?=
 =?us-ascii?Q?nokA4wUW/bqnrj3lrjfuqqJw4WAXXgoJFMc9gimFTEqncDcSgIZyRqLZio41?=
 =?us-ascii?Q?oKwXJdcg442qYYB27M0bG9tA9AI7ts+yWMI1oR0wPYupWSiPzk9Aixdw0G8w?=
 =?us-ascii?Q?s6/dnrWRp9dK8SvQAFomx9ch8gxIKLeDHkI/4sqpHBQ0L6x8ehaKic1drscu?=
 =?us-ascii?Q?DnkVRInbtYncnBfXdRFuIomwlazhHjc3vYVR0kFpMvLxW06S4HYBxW7Z/VlL?=
 =?us-ascii?Q?qui0QXVNBDZIcJ5nyD8hNyvCH+VRt9p4PiZpSAiABCGrKGxWlQNrAtzuiCkj?=
 =?us-ascii?Q?M95AAzJa64zBwnArLvhZ/qHROqh5Z8jtbXaSaPJKH/ZIsQhNj3ySpwt/ZzDB?=
 =?us-ascii?Q?V5BOIRzm438Q7ISuoBXgxGlWuh5Fm5/+gNiNkZwvHiNe7NuyedjbCz38i6Xb?=
 =?us-ascii?Q?4sfYYNqP+WlkshheS+pdKfuFm69dPTRef9JU8owREFxXO7zhN8OCQantxfXx?=
 =?us-ascii?Q?umHlvJDTgbGYt71ubxZomecRuRr5SediLRWlogWgfPFs+uyvTdjrU1+avK9A?=
 =?us-ascii?Q?1sTGtc33sg2aD5V3bwnQxv9Ap1E9oTbk/eHw3yt6vvcw2Bgx8W2Tk1bin9w0?=
 =?us-ascii?Q?UO9Xf6xbgo8h8w10G8ww7ViK/UXPvVgRS8oPDLW1UFc1XzZUkxaJfmi9tqsq?=
 =?us-ascii?Q?Y2AKdKqJNLD5iVkhlmsyM6LXfc58QIXz+lVcyQj6b0QEAIT2A6QzSotunz8G?=
 =?us-ascii?Q?5fUHoShI0Ofce4LAzOOxC6k7JtrrnyI/Dp+nA3cr49xS9dIohMdUlynI8d3r?=
 =?us-ascii?Q?W/MSVPYuplfjFt4AccRpIyI5LM7BPE9Q0pJAcCDJFifR4Nx0p5WR10ZK5WiA?=
 =?us-ascii?Q?YDqXcg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74c5cb-5e54-497b-d4f2-08d9fdd3f351
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2971.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 11:41:41.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJaXDFYjcFoZm6k1bEfpBsTsojHRxSq00rGHb5sdqKSos/bqY8K+YaMRc0AJurpN01VYfM1B9GeH6uqRWYjyxM00a+Ff0nv4IveLM9eaQl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
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

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/Kconfig    |   9 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 238 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/desc.h     |   1 +
 drivers/crypto/caam/intern.h   |  15 +++
 drivers/crypto/caam/jr.c       |   2 +
 6 files changed, 266 insertions(+)
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
index 000000000000..be0cf0e214f0
--- /dev/null
+++ b/drivers/crypto/caam/caamprng.c
@@ -0,0 +1,238 @@
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
+	int ret;
+
+	ctx.jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(ctx.jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		caam_jr_free(ctx.jrdev);
+		return -ENOMEM;
+	}
+
+	dst_dma = dma_map_single(ctx.jrdev, dst, dlen, DMA_FROM_DEVICE);
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
+out:
+	kfree(desc);
+	caam_jr_free(ctx.jrdev);
+	return ret;
+}
+
+static void caam_prng_exit(struct crypto_tfm *tfm)
+{
+
+	return;
+}
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
+	int ret;
+
+	ctx.jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(ctx.jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		caam_jr_free(ctx.jrdev);
+		return -ENOMEM;
+	}
+
+	seed_dma = dma_map_single(ctx.jrdev, seed, slen, DMA_FROM_DEVICE);
+	if (dma_mapping_error(ctx.jrdev, seed_dma)) {
+		dev_err(ctx.jrdev, "Failed to map destination buffer memory\n");
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
+	kfree(desc);
+	caam_jr_free(ctx.jrdev);
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
+		dev_dbg(ctrldev, "RNG block is not available..."
+				"skipping registering rng algorithm\n");
+
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

