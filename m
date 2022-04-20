Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225A50814C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352106AbiDTGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350962AbiDTGlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:41:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CFC3467E;
        Tue, 19 Apr 2022 23:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZkpgduulu4tfzYD9sRIekV69WQ018BJ4ZUEDB9AaUCOtUlx4/vETfHf4a91LKGTuC/N2w9GB0Je58NC2cSuRGUwDTpua0W8U1oeVFULOB/cVjsOLTA2nqm+uieRDcUxFwklssCvOA/7O/zte21b3sUvCeT7V89K/e2l5qhLhd4jVAgZKjza8qOalP1ynhW9lNfiQzYfKKJMJ9jMdNWSmHDonLB9tEppXLKQkMtYLYyJXHeAQCMMxACaDjZEmhc8aErwOXo20zjMPdnuQnKMkKDFmJSO71B9cr1t3HdRv+0w4tcGORbHt/odxUZQV0tTvR0qrxBAI+rn4c8dnUZpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3eBbaaBHn6wKvMAkaZcUJgmflhAiExVfUikNYM1Kc4=;
 b=SGRR7EYNGnfeDZZJ9Ed4OCF9YpATM28+4jxAgka2PLkMXO+cXC4XejkuXf+TeR84tbN4YSSbNZVGA5Gb7OW4Z4OxdpNG8lrGH65E/RCqHjsx5+MiYfln/iYkHvnSFsxFqutVJj6pTUidgHVB4pypwCgKcTHzm1NZkNrTZPc1+0mnsLWhjU7rtAcrkjwqF6LSG9ewYgNsjtEcHHYWx1jCTMs85g1MgFP7HtFHGj8bIhr6oRZ2QEHkhNLt20yLQTun/cQ0nzs18l3GqIp/vpqmajDqYR2cnvzOpkh2Ju35n6sj2i4hZmibK0xuRiL3dC4SN+Ztst7rBkcpSe39TWAk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3eBbaaBHn6wKvMAkaZcUJgmflhAiExVfUikNYM1Kc4=;
 b=SZ6DJ9PT/didd3/W30iG8hMb+tqgwUdwg0OgXKKe7c6WSpWYA5gJQWmeMV2C/WT9hgTh8jRmNuNAoqEw269J9qyL0nKwVhifJXW1zROIeOutS6bOhHAYyVYqtYDtRFkRYmIg2NffS+0iXpW2K2SdEVLD+L9vQUOsSqcC5PK91Xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13) by
 AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 20 Apr
 2022 06:38:25 +0000
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::5d82:9d6e:68a0:fd8]) by HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::5d82:9d6e:68a0:fd8%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 06:38:25 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3 1/1] crypto: caam/rng: Add support for PRNG
Date:   Wed, 20 Apr 2022 08:38:08 +0200
Message-Id: <20220420063808.1089283-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
 <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::38) To HE1PR04MB2971.eurprd04.prod.outlook.com
 (2603:10a6:7:24::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d163fab-5dd9-45eb-9707-08da22985edc
X-MS-TrafficTypeDiagnostic: AS8PR04MB7990:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB7990527CF6AA3DB07B9B79698EF59@AS8PR04MB7990.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmJAxc+PShvHE+3gGQltIm9pt+Aolhb8fOCk8NEZtlo0xv24oaoPqwGjOGJPvKr1r8BphVslEeD7wzBxed/jQqE8VXO1NjApmdBnaufqkLFOm6e8jMqYJMYXfXZDbxJUeClzpFfUldeK3GRVH4fNWFyKXDw1vwbEiIhdEydgKGEXULkE76DrfhOoSV8nQFtaTcixBobBV2kg3G/7SRVeDWTz8GWf6SU0DDVY1gYBK9r88jJWSU9NogzE691cRQpV1iuv/4rx71EEeKnVq/us0baJyPOFqmrJQn77ZIpuJuB4NjNV6i3Uq6N3hGQpq236v/8cNQSIyNCRstFuXubHBzvRg+CDf/KKjEwO/po37shy/2NcqIMZT6xp9bl5ZDywSCY1bpGocmZPuoDimleuv3ds5vTfOzjuamNCgpzFJIJDnaHIjgJKh2dvAkYqHQit3Z5g15uip/02kbqlfp9q68BGgGI3Z3NrkbgijmewmNe/wVwex83sh5L4aoBGpe76/NQ7haeAj/0FDFfzGcQm4wHWt//rdUosNaqORpeLTmyUcUyzrv7b05waErw1Uy82HZpXNDXNRbeAT5Z7BxskwWgFhI15Fz//Nn6dve5HyzltoBkuAkd6ijLWsQpIHKpEIt2/zP6/yQh1wVvc65QifWGPrnWBLORRYJHbP8y8A+/tkbOdAplhedcRBHNY1RNj3kvbCxqAAo72HZ6bkkM7JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2971.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(6486002)(6512007)(6666004)(508600001)(8936002)(2616005)(86362001)(8676002)(83380400001)(66476007)(26005)(186003)(1076003)(66556008)(9686003)(66946007)(5660300002)(6506007)(2906002)(52116002)(38100700002)(110136005)(36756003)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BjJWpE5mjCQk9kkcYYVZrEuG+dcV6dB4dD3xJ1jKHoGegOB4GuibHKxL7TEL?=
 =?us-ascii?Q?V3GqwElB65v4htG+5o16IVXcujU/IZVNMkbMs7Cx+mgImKtmy0VLsugRdu1a?=
 =?us-ascii?Q?BeJ3yLq+Si5ZmF4DwP3OoqHisR3EZX1NWCMX8ns8dZWTBRN64cbTumwZtgpo?=
 =?us-ascii?Q?E1Tl2OUTLeJhDzcV7bcO0INC+E09Z1CNx68JTxhsiGf3VMIGzsPRP73LfBnD?=
 =?us-ascii?Q?FqHpFE7XkCNONHyraptmKQ9Qkl9uZZfXL3liSmaOI2LsglcA+zEYwesYl1sq?=
 =?us-ascii?Q?DcESUNTh5F22166d0qAfWkpl0dnqnf2Oo2z3AjNdB+io5MySfh/FpZZHD35Z?=
 =?us-ascii?Q?+Gk1sc+wT5pMCLwRh2wVd8atkNrBVl4ppXGjqMeEKLTrf2l9F30zN2Llo1kl?=
 =?us-ascii?Q?IyRoVLvr1reFZCugBBGuKbviZ/i9ci0FQCNoC2AB+f1TTBFXvUO0dmpC8HHx?=
 =?us-ascii?Q?7L8v2+JAvdU4uhPuNZWmELp0maMEE940lQvV4nATJuE0FHMTWOXU63q32u8v?=
 =?us-ascii?Q?Oghhyhtzdh9/9Gz4jGxEsBGK+1su4vgvr+39GsLSJ0lWa2cPgZe66JzZr4LM?=
 =?us-ascii?Q?jR9iZlpO6hsxnAKE/B9aOic+EPPXma67wBC8RoN/gGKhs+8yyC91AoICSPy7?=
 =?us-ascii?Q?IyY6WeFcqwfjdzr0gjfNXawk3ZzZpM8BnI7hTPpncisbiRtwAL+7pm4DJKCi?=
 =?us-ascii?Q?jwtUT/5Qr3vKP1PUUVPnya4pkbt0tTi26KuSVahkWdS9gtfTY+vG46Iv0pMB?=
 =?us-ascii?Q?fsmfeuQpBQBtNGOllXq29mQLY3Z2eRwWL4hd32ugWapW+PAq1Omr12YrTkvH?=
 =?us-ascii?Q?8Aw7Hc1xtMDdMOugt/CeKYzAnL6uoVlHnRd/FM5iYdvdoCWbUfshBR4sDpvF?=
 =?us-ascii?Q?QDulkgIWtOTHxfRRCQutbmirJp2NAc6fNA2IDjJE6xTgQuNGRKEelVBDMxt3?=
 =?us-ascii?Q?IIY2+jpzEdTF+WDVVeoUw7aE/HNsyT18jzyJeRjSnnvGzJq3Knh1L9AvSiOh?=
 =?us-ascii?Q?4I99zFkinlj3AOXz4Nb7iex8dwB0GcGW/P2EooHJB3mZ6dbg5ztvvWGui2ux?=
 =?us-ascii?Q?QJlXe9gH9YsaYcYQDuYdnREn4Dl+oOJEZSES8Nh/fqpIxxWF+kLBD8O9pKlv?=
 =?us-ascii?Q?vOn1SnY2oegwnHHZZoSBgA18vUihF9T24orL413m0L/rVcXUmU/gV6W5g98O?=
 =?us-ascii?Q?cbNtAJQp7t7UHUWK7yG6jOf3rwU+3oPrto+Hh4qYz5nvRysCWrz+ildLJxEF?=
 =?us-ascii?Q?eeCqs65EYsCfrgWB//iMKH0dO8ceFraGqAJZNp12hYsRd92583yMO6woHJpG?=
 =?us-ascii?Q?VXs1lx4U4NfjpITYNJHOgbeY2Dt+/vhWibl64M/5M8xFK5CTedLDlYdFzqrt?=
 =?us-ascii?Q?a6JwLzVpicruYyhMPIR9PayVJ2EYpMkiNit+byxuN6mUD9mTeSaMmDGF3TFv?=
 =?us-ascii?Q?Vtn0HN4TTxbRmsB3FR2L24CSpdDGmzkbd+LD28cKSDzngRo3rjPKMWh5v5PJ?=
 =?us-ascii?Q?f9GikYfLylCZwetT9WB2L0PzeWT2F+yewskz6FLre2HVe7hIuRN8HTZM/zpO?=
 =?us-ascii?Q?6/N0HQfGKragE0wmvkEVQ0tgFD6/d9ebkWfJLcQa6mAPVp5a9ob9YhyCbWDp?=
 =?us-ascii?Q?hrZKFo3PoM1DQ+89d2wzL5cFVF7QfxYKpQ0k+v07Diy0nF+qBR/Z4UT4OEwf?=
 =?us-ascii?Q?8mOB3/5M3MMAYUeGaRhCkyDj9wHpVlzKY3nNtuP58g+mp1BL6x89HtoHLZ+5?=
 =?us-ascii?Q?gMz7DLaIfvEnrZR2P/yEyK1bT6AUYmU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d163fab-5dd9-45eb-9707-08da22985edc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2971.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 06:38:24.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khGXvmI+0fCXziilbMSLxNfYuuLT5FADrZqc7RbxAn2stXIQ8OFohF58W/e2V9cbiBX5HPPH20huns1wex3rvmSOphBMAmOC7y6yU1QOIBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990
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

According to the RM, the HW implementation of the DRBG/PRNG
follows NIST SP 800-90A specification for DRBG_Hash SHA-256 function

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/Kconfig    |   9 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 260 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/desc.h     |   1 +
 drivers/crypto/caam/intern.h   |  15 ++
 drivers/crypto/caam/jr.c       |   3 +-
 6 files changed, 288 insertions(+), 1 deletion(-)
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
index 000000000000..a40f8d5f761f
--- /dev/null
+++ b/drivers/crypto/caam/caamprng.c
@@ -0,0 +1,260 @@
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
+	int err;
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
+	if (err >> JRSTA_SSRC_SHIFT)
+		jctx->err = caam_jr_strstatus(jrdev, err);
+	else
+		jctx->err = 0;
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
+	struct device *jrdev;
+	dma_addr_t dst_dma;
+	u32 *desc;
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(dlen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		kfree(buf);
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	dst_dma = dma_map_single(jrdev, buf, dlen, DMA_FROM_DEVICE);
+	if (dma_mapping_error(jrdev, dst_dma)) {
+		dev_err(jrdev, "Failed to map destination buffer memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	init_completion(&ctx.done);
+	ret = caam_jr_enqueue(jrdev,
+			      caam_init_prng_desc(desc, dst_dma, dlen),
+			      caam_prng_done, &ctx);
+
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&ctx.done);
+		ret = ctx.err;
+	}
+
+	dma_unmap_single(jrdev, dst_dma, dlen, DMA_FROM_DEVICE);
+
+	memcpy(dst, buf, dlen);
+out:
+	kfree(desc);
+out1:
+	caam_jr_free(jrdev);
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
+	struct device *jrdev;
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
+	jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		kfree(buf);
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	memcpy(buf, seed, slen);
+
+	seed_dma = dma_map_single(jrdev, buf, slen, DMA_FROM_DEVICE);
+	if (dma_mapping_error(jrdev, seed_dma)) {
+		dev_err(jrdev, "Failed to map seed buffer memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	init_completion(&ctx.done);
+	ret = caam_jr_enqueue(jrdev,
+			      caam_init_reseed_desc(desc, seed_dma, slen),
+			      caam_prng_done, &ctx);
+
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&ctx.done);
+		ret = ctx.err;
+	}
+
+	dma_unmap_single(jrdev, seed_dma, slen, DMA_FROM_DEVICE);
+
+out:
+	kfree(desc);
+out1:
+	caam_jr_free(jrdev);
+	kfree(buf);
+	return ret;
+}
+
+static struct caam_prng_alg caam_prng_alg = {
+	.rng = {
+		.generate = caam_prng_generate,
+		.seed = caam_prng_seed,
+		.seedsize = 0,
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
+		 "rng crypto API alg registered %s\n", caam_prng_alg.rng.base.cra_driver_name);
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
index 7f2b1101f567..724fdec18bf9 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -39,6 +39,7 @@ static void register_algs(struct caam_drv_private_jr *jrpriv,
 	caam_algapi_hash_init(dev);
 	caam_pkc_init(dev);
 	jrpriv->hwrng = !caam_rng_init(dev);
+	caam_prng_register(dev);
 	caam_qi_algapi_init(dev);
 
 algs_unlock:
@@ -53,7 +54,7 @@ static void unregister_algs(void)
 		goto algs_unlock;
 
 	caam_qi_algapi_exit();
-
+	caam_prng_unregister(NULL);
 	caam_pkc_exit();
 	caam_algapi_hash_exit();
 	caam_algapi_exit();
-- 
2.25.1

