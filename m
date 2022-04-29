Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252C5144B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356044AbiD2ItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356144AbiD2ItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:49:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AAF2AC46;
        Fri, 29 Apr 2022 01:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVqdThG2m8euJApsej+NGq9vPAFpNPweO1r/Humq+GwcZN1gaP0CJVxOeT9XVRmWwryYpY4VZYvUTw0o+NxtujHYE2eX4VI01ygdLOpsUTWtUDr/46eurYx4YpxywVfIFsNbRY1ozTX1RzZubgS5uDrIDNhiuf+o0jOE/fFxfAzjwmqzkLeNgptt+k4K/5ROqx+C0RrbxgJEbW3Ins2D/L+B6boBmteJdWyYz1oKNhMZ35z5/FdtGdQ76oRkPt6kh1Rg3f9PZPIP89xsipOqzHauG0TkEYlbdVoGk6LfWcymP8jE1IHY3/rESrTqmxmuz8Ms489gregEYZbaE9CgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa2VF2lzyegSbWHqjI7Ff18d65D1JI0EqsvqDUGbwWo=;
 b=OdFp8a1m2nnaJYmxqcPuHTjGrtDLyxIv5V9q+eBxPuHDrnjoZLsTqBC6ASZzoMXBlyNCxMUj1VuC/OUpmSZQMQFKMpr/NwLSbeVy4dZ9su6uOeZr+Lgxnv+bvCMGbwwiQo2t0sToAWC792ssYrcE3G99ylGrGAQSlquOKDL8fUOlukEOv07e5+xoGnIGD59CLqdlbp2PZMI7bWCJ6LF8lhBbNqNLWtMwDfnISq1U7U3vQ880VP0Hsl8MCQga2OCzz1gnhlT/qNhXJ0HkMQYH1W5iI3C8N+4BcY7Gg5UQi67irD0j/I2V1320LIJJeduBXGqb4pEFPkOnuDEmbABS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa2VF2lzyegSbWHqjI7Ff18d65D1JI0EqsvqDUGbwWo=;
 b=Dw7HBtS1FN7F7EzRmz9MxpLgE7wrR7xdvTiXkN0SZmbCsNP27GKKTZ5w8TogeIuOVXD3BU15pHwWKwEM5Yw0dL8mPKkTvCqDO4tHayb1sJLxYX4t3zGzgbo2f+8S2IwoSTt/7sXxXi2gDp3slQgVtlMm1yE8wS/BDq5LA2FdCFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 08:45:44 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d%8]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 08:45:44 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v4 1/1] crypto: caam/rng: Add support for PRNG
Date:   Fri, 29 Apr 2022 10:45:27 +0200
Message-Id: <20220429084527.2069402-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
References: <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
 <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0144.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ada1ff0-aab2-42a0-5f7f-08da29bca5f9
X-MS-TrafficTypeDiagnostic: VE1PR04MB7423:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB74236361073CB384B0BEB0158EFC9@VE1PR04MB7423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGTYjf87bXEZKyChga/uEMRtEQrlrzsovKl/NARePI3GRDue5uCz0WL+p9DZq4cHNrrB+XFc0F1KkcOL0AOBYdTrxTksJd37z54PRL2RRa4yDCkZNSdNUNbjjh2k4HIUyHvRsP4IZ1dt7eRv5R/Pp8qgDqpCjaM2EaTJ8d5lIuYHSQxwiaZrH2LeDhA/M9azQb8TSE0Ew6mCcUpqmuwFt8h+2OkbG/GfCeGi9j/R+4GOP1JX0PWlMuQF4IH0cVFNmWizRuCfA/6xVIuYJHcYEhFkS0m45MD95jUiLxC4Se+Yy+zA0oB9FrVniR/qFUuXjJInatUPL7S0UtYal0/f1Av/tgCSFJeqHbqOVOCnT0gLI6lv3UllkwKQyf+uYfag4xLPynmU7TwD+Yh/OrwnR6aedKom52OWQW4UNnMiVFakV9ypVVrvp1KO+ELZdR473njr/8py8cDCK3C8IQCUEY772lfQENY/kk0pezQS08aZDJsMVwHPTDh3aMfMUjCqVZ/71WK8Mg4g6ls6awgtV6x1AXalq2Gjis01jUXZc3URiOTFjOENCr+zrQTbwAyOHgVEuOMIDW8ct5VxtCib0eU6AEDwWlxv4+OyCcyKTlLm7PoBz4d9Gf2GDa5hnhbr7gL4cy/fNkgF7THjrR6jumo3cME/AJW2J0refFzE/CA8PKTgWQuT7DKdFtiH8fsO0fjkONUeG5IjdOyyEYzi5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(83380400001)(8676002)(4326008)(2616005)(110136005)(186003)(316002)(1076003)(9686003)(6512007)(2906002)(26005)(6506007)(86362001)(6666004)(36756003)(52116002)(5660300002)(6486002)(8936002)(508600001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZW3WLzv83YAHS59RvPpsrA+2t2XEL/IuiPxmwXYLYs+zGNIzzihQiY6IzIxa?=
 =?us-ascii?Q?eQ+Bi4YYg0eu5mAMYs6ag5Cnsx1178EPIHMOdgIsy1yEeV1+Kh6rzkgQIM1+?=
 =?us-ascii?Q?vx/GoTApXm9zvBLSALqDm7byoNnL+KgsX92sWo9zZOcZ0yrjXxrsG26aMKDt?=
 =?us-ascii?Q?JG7RRMOFM0KHFIyWNeRCUmhwleJXDTZuukU3YGdrvwEtDSEPl5iecNzUmC6U?=
 =?us-ascii?Q?Wc2S6HHPaKtmm82f2RfJ0OBb3s7Hgc1SRYnUElYeTkNZXDiShR8Tp5BJNmXh?=
 =?us-ascii?Q?8zY1o8q9PX22JDl3nWVLY9OkgL4X/twyA1P70zHLeLyVdkb9UUx+tkNlMtL8?=
 =?us-ascii?Q?B/gzifej45nSxrp7YWruYdckuXGrwqmjPurVnIxvjdoFsihC9lATVjaEe1Z9?=
 =?us-ascii?Q?WkwHvsDs04i5+9KR90nrajC+Ce3CpkZ0FnKhS/nbj0t+xJbDaEJP/1J5zTxm?=
 =?us-ascii?Q?ZOyqONB8kgUazg5EvjryveSGGppfkQGH6PDj/mb8f4R+XqBY0VzxybmLYFqG?=
 =?us-ascii?Q?bpSbMnF1PJyTQvuWzWEOd6e44zgwrGtrA33OB1s+YVul87zL//e8KTOmNpXc?=
 =?us-ascii?Q?WA6QkXNhzIQMTRRq2GlgK6+CBpPDHhPyN+vgVo8ccE34F+9C/l3UVCCDrJHA?=
 =?us-ascii?Q?UbPgYRLoVIm081nzK3MqBBqoOLgcJpivmNoYlje2uLgFDOgN5L483vViAHmc?=
 =?us-ascii?Q?fhdXm4njGGnJ+8ky95tI8v1JDiaYj7edicy9gvRGYhOzk/Fva6XNk9D1Z4ll?=
 =?us-ascii?Q?uzhzP+Q93y1Ozir9Z5QnFdunSlSIsFxvgkyGdVxkqrGjaqT0RwUXVNfPa6HJ?=
 =?us-ascii?Q?Lyk1j9O2Y8YqHG/2lfei1xTRCAxHMN9ZCSuCPHztOwVrTuixNttGvE+ulfBl?=
 =?us-ascii?Q?8OcQM2BjNWZ2Fd4t+cOgIo/Uvg9rjcn+3QEJJuKXF3WQhE3ejbcugVI05Vak?=
 =?us-ascii?Q?aY8w39TWBsLcqLoiaf03yGaEU2c3wMSsE0QUcKxSBdgJd9rT7RNf22rhHpLQ?=
 =?us-ascii?Q?DH1cFae32j/HIjcencr3EPGzb0V0Y9I/CGLjpOzfJWQvbsIKirT+uqnRiyhd?=
 =?us-ascii?Q?SEanxCi/Cark/0WilBTWJr+XEyhxyNFOGAk2asGVKZ8zLGas1EnuvldEf4CU?=
 =?us-ascii?Q?/PNMQb1Ono3voj11L/BW8dTorulA0iLXeGGZRtYZDy3/K7+IOCEl/2xLDnKy?=
 =?us-ascii?Q?9YouSjvvoHPxK/7QqPwEXUY5DZYphZFZwSVvxuo1jkSz/uXjxlhPl9LB7cNW?=
 =?us-ascii?Q?nvbaaPli7z70FcCB0JCTD22NMivBdd0Sun4jtbiP94ntZxvLjFwFO1w594Bk?=
 =?us-ascii?Q?0b8QBdTcX4DDSJnfRJeodEN/yYm+Z3thr9MzUun5XCoh7wNPcgb+jXdu7/hE?=
 =?us-ascii?Q?G/uXPCd2gMXRXlVxEuE7WCI33KJ6kFgpd99CNHOOz3jOzTxhQdY95NFO6Q4E?=
 =?us-ascii?Q?JQEJm44xUkHUyQFsOOWaO85JhnUhhX4EtakQwvkfpxcGOH8pdkt48WToD4Sb?=
 =?us-ascii?Q?JKdWybvF5DBFcco1hkvvcVEMCgTt6b0P94V6xrjFJQVwx8Dx2Ya6NOmS7P68?=
 =?us-ascii?Q?BU8Y3960HVOTPEoyCeSspOFqGJ1aErUWE30uXz8PYcV8DAvHr06FZZaVJAHm?=
 =?us-ascii?Q?olDPbezMvV1z88F3oLmr4S1sDyZKO9zTzGm4SlyjzUfmaZd4CyXG+TAS3i/q?=
 =?us-ascii?Q?3Z/50uvip8tYkuzPPkFhfwuxfDd2+Cz0965G0xlAgfjTD7cC9WH6VaLEZ6sJ?=
 =?us-ascii?Q?oHJoCp2yK48+3PvZNSsAlKU+yTz8rTc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ada1ff0-aab2-42a0-5f7f-08da29bca5f9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:45:44.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KZq19YR/lfUcvFLHj0dw/vywmx8vZJKCJrFOcwB5C5DQAh2jTBnIM+vEciulshns6y+O2N/lSt2G/hdcNfoMKzzlp4NUv5rSSmplNgfzVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Add support for random number generation using PRNG
mode of CAAM and expose the interface through crypto API.

According to the RM, the HW implementation of the DRBG follows
NIST SP 800-90A specification for DRBG_Hash SHA-256 function

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/Kconfig    |   8 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 234 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/intern.h   |  15 +++
 drivers/crypto/caam/jr.c       |   3 +-
 5 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/caam/caamprng.c

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index 84ea7cba5ee5..0aa52b612a01 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -151,6 +151,14 @@ config CRYPTO_DEV_FSL_CAAM_RNG_API
 	  Selecting this will register the SEC4 hardware rng to
 	  the hw_random API for supplying the kernel entropy pool.
 
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
index 3570286eb9ce..4f9837a8a1ad 100644
--- a/drivers/crypto/caam/Makefile
+++ b/drivers/crypto/caam/Makefile
@@ -20,6 +20,7 @@ caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API) += caamalg.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += caamalg_qi.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) += caamhash.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) += caamrng.o
+caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PRNG_API) += caamprng.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) += caampkc.o pkc_desc.o
 
 caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += qi.o
diff --git a/drivers/crypto/caam/caamprng.c b/drivers/crypto/caam/caamprng.c
new file mode 100644
index 000000000000..728fd8e591d0
--- /dev/null
+++ b/drivers/crypto/caam/caamprng.c
@@ -0,0 +1,234 @@
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
+	jctx->err = err ? caam_jr_strstatus(jrdev, err) : 0;
+
+	complete(&jctx->done);
+}
+
+static u32 *caam_init_reseed_desc(u32 *desc)
+{
+	init_job_desc(desc, 0);	/* + 1 cmd_sz */
+	/* Generate random bytes: + 1 cmd_sz */
+	append_operation(desc, OP_TYPE_CLASS1_ALG | OP_ALG_ALGSEL_RNG |
+			OP_ALG_AS_FINALIZE);
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
+	u32 *desc;
+	int ret;
+
+	if (slen) {
+		pr_err("Seed length should be zero\n");
+		return -EINVAL;
+	}
+
+	jrdev = caam_jr_alloc();
+	ret = PTR_ERR_OR_ZERO(jrdev);
+	if (ret) {
+		pr_err("Job Ring Device allocation failed\n");
+		return ret;
+	}
+
+	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	if (!desc) {
+		caam_jr_free(jrdev);
+		return -ENOMEM;
+	}
+
+	init_completion(&ctx.done);
+	ret = caam_jr_enqueue(jrdev,
+			      caam_init_reseed_desc(desc),
+			      caam_prng_done, &ctx);
+
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&ctx.done);
+		ret = ctx.err;
+	}
+
+	kfree(desc);
+	caam_jr_free(jrdev);
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

