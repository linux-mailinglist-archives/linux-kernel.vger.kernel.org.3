Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7688514887
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358403AbiD2LwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiD2LwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:52:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E2B3C52;
        Fri, 29 Apr 2022 04:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdxaWRFxIjp+ELnrNieFC3FrzRyRtODej8Bat/bfePqnOg+gWOqi3EUWeau3qXEGx/YmatMvD5wkeDYy6TP7aooV1ex2VcxPeFVG/L6LkAerBbqWIUZAizbbXSIgO+08KcDmD4Q1eOH4X0HllRHmUdWM2gMspP5Ztoofodh2VcfTduEAqBTLDQe+hfqgFGkVa43bKr5Zmsr5g+ylZvlK0II7cuNriQDlXQXm/ZbQB4hGAHP+FrcPZRhoHwXjeNRKTv8IbpMLbZRWY1RlGmtQhCIxgNDcB2A77IAoVr+Q7QY+h7tCquJgTtcUKu5RwpdgB0RsQcAAY03ADzJQyWc7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbDwKtR9wywD9OT+HtLpIgwkvuEy4xX7q8wIKBcNMvE=;
 b=OquvLPh5Ux85XmtXYhSl3Sttyld0rtHUZ2+E9+1yPXsYqC0lC7Oq/aQYDDjHqJSFeFPYcVM+djBc6dJziNtTxMp0YRqY9wFSbLotbBEkGKMBU0dujOdwT4dHlO8QonFiTaYhIkcghttL/Hkk3YM75oMRNugh6vbSGqJwKs5pNqdX1e+12TAHx/pGASKvxCQ392gCWjlHNbPJqkOTU7dkfQWW2potnvRK4170/zfpnYNHdHwEqVEqQqTEAYk2yGoXIKSVKsl6l5GzHlZCyiLvnaopIpkkqMF9P5uiQ8eUkiESfMK6wNYHNu/b64zloZIiF0cY3v3VKCjIxKtc885S6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbDwKtR9wywD9OT+HtLpIgwkvuEy4xX7q8wIKBcNMvE=;
 b=LNroNUGRbN7XZSWbIwyiENYgwqmRcINIzDndYCxQX8YA4eo7K+NzAS3eEIDhaN2qYOpr/qp9CPdc3dGVNHFxLDmZqf7ze0/RXbS/G0SQ7sYND2DM3KudizV1euBPCHs9YS+rXXGAZIBdCoHHaS2ruhUq4JyQAAxYsE47DpuCpj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 11:48:40 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d%8]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 11:48:40 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v5 1/1] crypto: caam/rng: Add support for PRNG
Date:   Fri, 29 Apr 2022 13:48:08 +0200
Message-Id: <20220429114808.147108-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429114808.147108-1-meenakshi.aggarwal@nxp.com>
References: <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
 <20220429114808.147108-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::20) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee2593f3-d60e-4e67-d959-08da29d6343f
X-MS-TrafficTypeDiagnostic: VE1PR04MB7358:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB735865C3724B013AED7C77098EFC9@VE1PR04MB7358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1YnO8yC1BBWMzJqFi+zLX9LKTRpXyzFXkXgjS4PYvlaC8Kf8mYHVPoz4JU86E9pLcdtGWMumG3a5BlMM7aHwYW2xW5ZAmAaX60P0LCspkRyTAE+px27fg+Z3MC8mfXluzbWDOEbRptgsB/cqjmW0Bb63wliPb42AFKoH/tRwXhJhEOI3CqgvkwodL2HXXMGDEpFWKfFwwCg9C9F52yZbAEn2GriL4OPunh4xp4bsqhfpqVjJr/l1ffWhWfi2qPMtWBc4HcfBe78uJFYMB3wP+RqVYMPc7tdeQTmKiQgCSOwnjFwDTY8fsfYcWdUjkb/7EyHr83kp+IApUdlQYfbV+8bFHLq7p6FLyinoJc3sotF5PEKOsX7rE/CEWcRsCKVSnHPM63a7FOqbvFysjf/VfAs26NZJ2XYHwJxDCZMzZRK/x1IJw4Vpb7sct0QfjEEHqymsWDNU2JaI1sCjFPHDC5b3ebOtb5N8qEbWNQB5cP2fP2TDA0X+4CDQkcP17/ydVgvzq0xn72r6J234kUW3nlOqBaTqL6Xpl0ayiQBgMz76g3+e3pnXk64moVzMLWaqMYT1BNHFeM7bz7Qz5Y7zrRWKyH/jhWXfn3XLdMTDa27pkPUlbuRfOT/c13HeAggCh/vBoLmoxTF1n0tf2rNgbMnRJEb08d88/V7I7STxpDwoRD/1ntjuhSMGFgdiHaYb+oTlBwMHYRswjY1tY6iWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(110136005)(2616005)(83380400001)(508600001)(186003)(1076003)(316002)(66946007)(8676002)(4326008)(6486002)(2906002)(66556008)(6666004)(66476007)(38350700002)(38100700002)(36756003)(52116002)(9686003)(26005)(6512007)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2y/VZyTiATnWy/HCH7slZzJrsHUA8UF4iFF0+lDTtyqIpAw48B7D1EJTW7VG?=
 =?us-ascii?Q?VNbJlySdUWj45gl9GoOl2ciG1C4h/XaEiB/YveL3dBrTNv7UElayD6II03u6?=
 =?us-ascii?Q?5oTVAfwT69upJ5DrPkbMJ0PUaimMBff8TTmeNzTjF958CqEmvZV4nEhzYPuC?=
 =?us-ascii?Q?EsigVXIK+KHQSSv0expgb2RUfcIIBHf1MjgpTuVxyRSDqra2be2qhpZmSngu?=
 =?us-ascii?Q?Nyv+1J1cKaTsA5kFtiAH+YQGr6It3+I8exayZearHgoIKL/uop+NWU3T+0Iy?=
 =?us-ascii?Q?4WvJ2z7vL+FHBHumo8hLfO+wEQYyFx+2Y8Rq6DDOGnWVw5vDrnLvJXUtIJqK?=
 =?us-ascii?Q?KW8bLulEPnVePrDsnUnku9MYWM9O9igPiVStfVvwIo8EfP2tzto1i+/KA8OT?=
 =?us-ascii?Q?+lrDLwqkf4M92nGmnt49KtEUAluKLbbAADvLLOwbmlpILaC7WmtOIQliX7uC?=
 =?us-ascii?Q?+3lMGUGWqon3etpJh/zm8uZwNVGKu7Oq93I236Is/sCc9+wLIaqEn8bnn6iL?=
 =?us-ascii?Q?oP6RyyMWUAfZ5YjaIuo3Ut/3UqPFp73NlwxTrrGpHq44wfaB8f7aoQ2kWle7?=
 =?us-ascii?Q?fIlwktbX6wMI8zwqHrG3TCda8njGPdWoaKjshlNjpHz+QF9hUadSbluAq5yo?=
 =?us-ascii?Q?IYXBjwW3Jix6wCvhrlZDJsuh33CeRR8LVqpMtGP4OymZa2n+n9lWxl/w3Y+1?=
 =?us-ascii?Q?AQghPNN+cWW1uDPOG37A9xvMW5VEZ2RN06EkivQxeQL6c3pwwxkDqn01p0q3?=
 =?us-ascii?Q?CyYZn/UbfIOXKHCy+OTU2V/3wJt+fA0pdK8aHY2JPrN8+FT2IkklbEFlW0hb?=
 =?us-ascii?Q?p6jWZQemMhqT89VkZg/gQ8sO4yjFmoHqRjUPGt/yKVcEWh/f8y9Z4ULHcWYy?=
 =?us-ascii?Q?u4JX+dKEDk0tn1MOi12K9FfkpV9PHwUAMIyPPesgL+jQ23o/Kj6jrTcsqeFD?=
 =?us-ascii?Q?SoxZ6O6fnNXBRq6droTmre4we6w/bkGlYIAeiVkd2iTzPIKUxtKOcD55g5Qg?=
 =?us-ascii?Q?a98Nb3JhxgR4idMCvVuxj/KTY1s4O60AJtI/d4Ph433b7c1pSJ69uF++zyiY?=
 =?us-ascii?Q?QZ0kdnwGkabPpX3aPnAhdLxNh5j9vWLln+ghl1/Qq/HPFwAggdI9sYEfvusK?=
 =?us-ascii?Q?0WMQ4PXoZEEThr2Fb2hT4Dc+p9sO2rbA5QfNgaIJlGPwY+138xSMHQjvWyTl?=
 =?us-ascii?Q?rkmZD5ZhXpETymuRKiBaioyhN5p8SL0pPoixrYVOgPNShrQVyutKytOIzove?=
 =?us-ascii?Q?JCZVXQACwipXaRNdlUbmskqOGg+GDKfW6Ykr8lbTe2vAoWzE3Uutmo2L82p4?=
 =?us-ascii?Q?lPRKhyw0G4nrf2qHVvythL4z9vFyJ2hdKqa6dWlxaII5YtKc3pnP6R+5RnMc?=
 =?us-ascii?Q?If1gUrVbfUYSPSIbXEJuaDI/vJ3/YI//bKRx5Fhi0W3oad9NwIgJ+X4acHQj?=
 =?us-ascii?Q?TrcS98UekwDTvfeCGtJkC83QTMoE1EvLQYUvw52oJsGgpSPRrXPrPKe36dt/?=
 =?us-ascii?Q?zT2+tGJ5RTexdPEdVPyuUWr+YS7eEh96Z+MnnHqW3bKGm0cumvvgTbHv92A6?=
 =?us-ascii?Q?HcuSIkUfj8d10vSU4vKfbIG57rpAcosdjmp7KtGcF/D41hR9nZy1tgllp5B+?=
 =?us-ascii?Q?kE0hA4Iru9ry/RRm4upBPQ9LWVQTDi9fZeCkXskcwGFX1G3mR4fsb99jdGwh?=
 =?us-ascii?Q?1WdDRXjPhPL2MwQj5j/h7j9aBalNUkAhMU5IDkYyCU56ky6MyzGCAPBKyiJj?=
 =?us-ascii?Q?4kUZhBI0rYZSkhikLaS2Ar4CyMarDE8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2593f3-d60e-4e67-d959-08da29d6343f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:48:40.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm2uz8DShwSlvMwp6MZWrlYgxNpLxpHNsvZOlp/EQIDmQalV9YwIZ4nuLp4h2f/h88XkPiNDmGw/lLGmVQFAHg3qqqldTuyxv4dbiFbZZS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358
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
Reviewed-by: Horia Geant <horia.geanta@nxp.com>
---
 drivers/crypto/caam/Kconfig    |   8 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 235 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/intern.h   |  15 +++
 drivers/crypto/caam/jr.c       |   3 +-
 5 files changed, 261 insertions(+), 1 deletion(-)
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
index 000000000000..4839e66300a2
--- /dev/null
+++ b/drivers/crypto/caam/caamprng.c
@@ -0,0 +1,235 @@
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
+#define CAAM_PRNG_MAX_DESC_LEN (CAAM_CMD_SZ +				\
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
+	desc = kzalloc(CAAM_PRNG_MAX_DESC_LEN, GFP_KERNEL | GFP_DMA);
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
+	if (!ret)
+		memcpy(dst, buf, dlen);
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
+	desc = kzalloc(CAAM_PRNG_MAX_DESC_LEN, GFP_KERNEL | GFP_DMA);
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

