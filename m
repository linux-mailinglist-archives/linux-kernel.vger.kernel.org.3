Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F74B65E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiBOIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:20:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiBOIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:19:57 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED69D4C7;
        Tue, 15 Feb 2022 00:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE7tp/KPXbqQO7vXQsxBtbiqnUSL1Xnb9Q0FmKfg2VfYn3kdPro6ObAymxtxwxUjIcWb65/EhF3wMchsxTGKp2eT6FMssnY2MiUPMfE6p7FjzMjS014Dir/PTEi0P08n6zY5aIcfyJ4IQNWDJk6NiaMA05l7+ZPeLh8qLLOSubuCct0InxjEVHonW7ep+DHOejjJqEJ1L7rQGkoDK2XkrZEGjlgvNXKCj9O8Me/b2hIx2gqLKC4MqYFsOMlOPfJM+ze/PDZx5U/3IPhTEJUXucbimhOFZJB6sSeI59x3dzOMZrQkyOopGDPfb6kbHw/uk/hslp5PiMrewnAjsOsbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az6rHMKsLE/50LMBNctvHUf5P3emdiIKEQvq2zfcbnk=;
 b=fLsIOimSl3OFTBuZGtlWkfkIsuwmehf3CgUmidxGoO4romCEkBLehwGll6rG/Duy1rjZfhgibQhY6AWfIiU+lZYXOW8SOftmt+hF7YFUFaK+jBcSaXG7A4HwjkG5/c9cA9gDclqxUkM4MnAwQdyhbvyySplZYX2aCHa0ZgdEU+jk4nHrzVY3IU5vEo44+gNVh2b/zwPRFUiMQtAlKilI24uR2zRsAIFvN3JW4G1ENvus5zl20i0frJ0V12yWI2BSKytwY4s1C0PqgufD6gqnAm/znPZNL128ipFQww+IuKMHCe0TcKAxMgmze81TODKDkH+SY2WhqCNPwYQ1oElNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az6rHMKsLE/50LMBNctvHUf5P3emdiIKEQvq2zfcbnk=;
 b=iGTfZgm+rWUIza0jduwr/FPkbc44dZGqzBYj4LmRm1sRmMbK0aUVS/tzDqZDnJJ5lYo7OZwTKYXkVlzVYDcIg6+TDLB4HP4dT2GyKsE0dbllzpOzOiJz2g/ql72xBZK0v+b6BeWIspRI7uS1LBcQZ/v0GUKvCa8ZbgMX56PEu14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:19:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:19:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] clk: imx: support fracn gppll
Date:   Tue, 15 Feb 2022 16:18:34 +0800
Message-Id: <20220215081835.790311-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215081835.790311-1-peng.fan@oss.nxp.com>
References: <20220215081835.790311-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd4b2e7-7d3d-484e-f919-08d9f05beb61
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5940DAB1A47622C585475E93C9349@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xh9sZ9kSjFUQgr40n57kaVwXF3STZruJ24QsjAjk6Al+EO5kSTwZUylTlDLDkfunmKEMWaql3rMcUKtHrf0CSVkwa0At/vFbJJdfeMWZjoyzIrnCWMGhMhZByUyjnliAI5vGqPj5qypEe94xO7Is2cpJMqJ1SqUMggeG3AHt0aAh0MEf1zOcZb6II18EPODLXU7hnljUWEXO69JxqJyN0S2xfNKn+EB3tTzSiGwS/cJwIWgEVj7WAYx/pdd74MWrqPthbvNpvnubMx0rLw0g0mCTrPC3xhdg4MH9loUwQH3FnEaWeR48BqvG15U2APB4IdQJtBK+9Iiw3hBppfBdTq9s0vYZSNG/GuPrm4m1WOCJ9U8lJzLqbX8/X7OFjnWN3E9465E7k/DqWI5RbIqf9lgy7jftnoGZqiFnOLUlGbASWKQgjOt7o1mrGFM9MPSHCynPiG9Mqr0L5GD7yDFinQh2coXdV7AgBXLUC8HV714H99Y1hFZmSi3BBx+VKvmUQzxRmbmWBj+4Yd9DjiRiXVje8ZEyVsBs8M+kEg8swKvj+WuFpHNrWbNfQLiOQtjHqs9Mh5Wii/uo4uiHyQV4RVtwSeI0n8NyLNE1/l1jd/kpzolfqwj9Jk0BD3x6J2WbzvLjidGXikgn1Y4JvSfeynHI/MiepSMvjVpTxCVWfHTByrJTe797zmlwldXJbabEcCyIjQzsEBgtLaq/hnbs4kcJrIZQKYd0P3igQtih+uF1F12FtW0bKHwgZHzv/BS5fItsxSuZjOIxR+kq+4NCyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(6486002)(26005)(83380400001)(5660300002)(1076003)(508600001)(86362001)(30864003)(2616005)(6666004)(2906002)(38100700002)(66946007)(66556008)(8936002)(66476007)(4326008)(7416002)(6512007)(52116002)(8676002)(6506007)(38350700002)(56820400005)(54580400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzU1ejlCR2lyd1doNDEyOVNEdThMSW5UQ0RqQndqZlRORUtjYUxUUG1pVkdn?=
 =?utf-8?B?TXpNOFRhN0dCTWNWZTd5Vnl4VzVQYjVHMytKb0dyY1BXQnljeGM1bmdVUTNu?=
 =?utf-8?B?eCtkaFl1SklsdHRKZlRieUtKZTFacVMwbjgwcTlIbFVMM0tRa0xpZ3VKZHZQ?=
 =?utf-8?B?dWFoeVVaeWhZS2lyM3V2eUZpQmUvbkxwVjRMK2lha1ZtMGFuV0dRRDUwdjlH?=
 =?utf-8?B?Z2lSczVXNU9ab3VLUy9pbzQ0dWt5cmEwY0paSFByeDJnMFE4WGRIUlJqTWdh?=
 =?utf-8?B?dldEYTIzaE5LQjFMUHc2bnFNdG1VaTNsZmZvbDlhUjFUc2hBK0Z6eE5JVDJC?=
 =?utf-8?B?UnpxdEVHSHFEM3h0dDJZUEJzTHdmVW9uTHcwOG52OFNDT0g2dVlYdEN1T2V6?=
 =?utf-8?B?TzNWbXJhemhaQktiNkFDbS9pV1ZQamFjbjBYWU9SRWlHKzRYUmFQRnlhaUVD?=
 =?utf-8?B?WmxadTllWmVaQk5iODgzSHFmREYwMG5raTRzUmxHRWFxQkMrSU9OU2c3SjZq?=
 =?utf-8?B?WnBFR1JHTXFLbDJuTWZJS21vdGdsUWFvZUdnc2xQNkI3eUZ0cjZZY1VHSS9O?=
 =?utf-8?B?ek9rOUE5WmQ4UytCeGJ5aGVSdnR5MXQyekIrbnVFUlF3NTBKNjBiOVQyYmZ6?=
 =?utf-8?B?WVh6SzdLcFcxRGlVRzY3M1BUZTJxMDJEZzhZVHhNWWwzOVFHRGQxbGdERVFq?=
 =?utf-8?B?bFNPbENGaHFQYnpLRTY4QnAvN0F3ZllWd2VBTnJuc1JvWjRDK0MrWUJjRVF0?=
 =?utf-8?B?ODBNSkoveHlZYWZLMmFFUDRURlJSR21id2VvQVVrSXRvRGh1azlWZXNnSXla?=
 =?utf-8?B?Vm1FV1Y1WEhJSzB4bFFzWTdjdkVaS3l3Yk1nQ092UUJJQWRqQVNXUGxCOEdK?=
 =?utf-8?B?MDZtZFlxbXNyK2ZJZ1J2bnkvSldNb2h3WlRHVllBM2xCTTc4R01BN2RtWXBR?=
 =?utf-8?B?M0RoOUJadUg2RG5LS1kvYy9sdTAzOUpidWNTN3JLOW0ybDBoNUxySStMeFc5?=
 =?utf-8?B?cGNROVBJNVJhanhNNjVaRzJkdTlUM01CcXRHdjhidEV4TTE1WEVkS3RrbE9R?=
 =?utf-8?B?WWNTdm51VEhncnQ2NVpDU05nZEl6REdFdXRlV2JxTCtRTUpFOWc2RjlkYW1J?=
 =?utf-8?B?QUZ3ZGxzTjB0R0NUaTNoSUlpWGYxcHMyYm5YaGdxd01zbURiZ3FUdWxJamZZ?=
 =?utf-8?B?aTFvTGd3ZzVtWmtIRk1KOFUwMk8xb3BBSjR4cE16R2lIRVVtbk4wR09kK3VO?=
 =?utf-8?B?eEtGVkoxd0g0U0hCWG5iQUtHNGdqS0t4MzB0Q3k1andLNEpQbGdsb3pEQjdo?=
 =?utf-8?B?NXZYYmRVR1VTQjBYbE5NanB3WlJjNWE2WFBFSXRmdnJuUGJIU0dxTWVJSmRx?=
 =?utf-8?B?dlZYdzJ3RFBUczkzTm5SL3dsMk1nYU1WU1I3eEYwOEptbkdNdHJ0c2NwcHJT?=
 =?utf-8?B?bFg2dWRlQ05PZ0o3alhqaElYMGlGWmJCV0h4cFdWS3lXNVdPWTRONHN0b1dh?=
 =?utf-8?B?aWVLQk4zcWJJVDRoU0J5VE9BN2ZKWCtBNU9qNUNlaU5XYTZUNzR0TjRiWUxy?=
 =?utf-8?B?am9kZU9Fa0FSSnFmMWVDWCt4OTlOVkJQL3NyTW95bFRRK2JUZ29DWVNnZlRs?=
 =?utf-8?B?Y0hUNjRpOHBGK2RJQnJwc3FidURGaS85dW1DSFdudWRPdnFOci9xTkFtM2JU?=
 =?utf-8?B?Zmg4cFlPQzdoL2VyaEFST3VQd0ZFZGNQc2FOZHpRVkJYYVlKd0hoK1UxY0o5?=
 =?utf-8?B?aVpTa2dyQ2JXcnNRQkxJZ1NTQTAxOUFtT3h5elFzMWJEc21mQ09SaEpzZlZU?=
 =?utf-8?B?emYvQnpya0lxVjlhT3BDUHFheW5DMGVUU2FQODRoZWlHVi9HNExvQS9HVGRE?=
 =?utf-8?B?Y0dyOVNjR2tzTmhsL3ZPbU1wMklZc1VnZnlKZDNxOHl6UFRGS3BtYnRrSkF1?=
 =?utf-8?B?cEhpR1B3TXU0MlVWaWx4aXY0MFVWOStPbjRrQmNGQWh3WWJpbDF1eC9yN3Rh?=
 =?utf-8?B?OTVCNGcxRkovbXlVMmhIeXlBbndOZElQaCtKMWFlc2RydGJmb2xxdVdzSFBn?=
 =?utf-8?B?U3NSRGJkUi9HOFZZYzNXSkpiMWJKL1pVN0tJNGt0REdaT1YycS9oaXV5TTVD?=
 =?utf-8?B?QW5ydnFWR0dNaUo0NnYreGlKdEdaUitpV3FSNlU2dFNiZDR6OWhybHlwTnMr?=
 =?utf-8?Q?Q2p7w9LxLBhaAmD+qI866pM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd4b2e7-7d3d-484e-f919-08d9f05beb61
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:19:43.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygO73wJguYMh7MDKA3hSCqkjYn1zZX4q1/VZ/qZ7Zrm8wBuTDWKqcOTHg8x2r8z8sJJGSdLuQCwriluGBhpMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        SUSP_UTF8_WORD_COMBO,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This PLL module is a Fractional-N synthesizer,
supporting 30-bit numerator and denominator. Numerator is a signed
number. It has feature to adjust fractional portion of feedback
divider dynamically. This fracn gppll is used in i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile          |   1 +
 drivers/clk/imx/clk-fracn-gppll.c | 327 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  21 ++
 3 files changed, 349 insertions(+)
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 15549a1c332f..717a33c7ed50 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -5,6 +5,7 @@ mxc-clk-objs += clk-busy.o
 mxc-clk-objs += clk-composite-7ulp.o
 mxc-clk-objs += clk-composite-8m.o
 mxc-clk-objs += clk-composite-93.o
+mxc-clk-objs += clk-fracn-gppll.o
 mxc-clk-objs += clk-cpu.o
 mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
new file mode 100644
index 000000000000..a4512b216ad5
--- /dev/null
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+
+#include "clk.h"
+
+#define PLL_CTRL		0x0
+#define CLKMUX_BYPASS		BIT(2)
+#define CLKMUX_EN		BIT(1)
+#define POWERUP_MASK		BIT(0)
+
+#define PLL_ANA_PRG		0x10
+#define PLL_SPREAD_SPECTRUM	0x30
+
+#define PLL_NUMERATOR		0x40
+#define PLL_MFN_MASK		GENMASK(31, 2)
+#define PLL_MFN_SHIFT		2
+
+#define PLL_DENOMINATOR		0x50
+#define PLL_MFD_MASK		GENMASK(29, 0)
+
+#define PLL_DIV			0x60
+#define PLL_MFI_MASK		GENMASK(24, 16)
+#define PLL_MFI_SHIFT		16
+#define PLL_RDIV_MASK		GENMASK(15, 13)
+#define PLL_RDIV_SHIFT		13
+#define PLL_ODIV_MASK		GENMASK(7, 0)
+
+#define PLL_DFS_CTRL(x)		(0x70 + (x) * 0x10)
+
+#define PLL_STATUS		0xF0
+#define LOCK_STATUS		BIT(0)
+
+#define DFS_STATUS		0xF4
+
+#define LOCK_TIMEOUT_US		200
+
+#define PLL_FRACN_GP(_rate, _mfi, _mfn, _mfd, _rdiv, _odiv)	\
+	{							\
+		.rate	=	(_rate),			\
+		.mfi	=	(_mfi),				\
+		.mfn	=	(_mfn),				\
+		.mfd	=	(_mfd),				\
+		.rdiv	=	(_rdiv),			\
+		.odiv	=	(_odiv),			\
+	}
+
+struct clk_fracn_gppll {
+	struct clk_hw			hw;
+	void __iomem			*base;
+	const struct imx_fracn_gppll_rate_table *rate_table;
+	int rate_count;
+};
+
+#define to_clk_fracn_gppll(_hw) container_of(_hw, struct clk_fracn_gppll, hw)
+
+/*
+ * Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷)
+ * Fout = Fvco / (rdiv * odiv)
+ */
+static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(650000000U, 81, 0, 0, 0, 3),
+	PLL_FRACN_GP(594000000U, 198, 0, 0, 0, 8),
+	PLL_FRACN_GP(560000000U, 70, 0, 0, 0, 3),
+	PLL_FRACN_GP(400000000U, 50, 0, 0, 0, 3),
+	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
+};
+
+struct imx_fracn_gppll_clk imx_fracn_gppll = {
+	.rate_table = fracn_tbl,
+	.rate_count = ARRAY_SIZE(fracn_tbl),
+};
+EXPORT_SYMBOL_GPL(imx_fracn_gppll);
+
+static const struct imx_fracn_gppll_rate_table *
+imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
+{
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+
+	return NULL;
+}
+
+static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assumming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate >= rate_table[i].rate)
+			return rate_table[i].rate;
+
+	if (i == pll->rate_count)
+		pr_err("Not able to round rate for %s: %lu\n", clk_hw_get_name(hw), rate);
+
+	/* return minimum supported value */
+	return rate_table[i - 1].rate;
+}
+
+static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	u32 pll_numerator, pll_denominator, pll_div;
+	u32 mfi, mfn, mfd, rdiv, odiv;
+	u64 fvco = parent_rate;
+	long rate = 0;
+	int i;
+
+	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
+	mfn = (pll_numerator & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
+
+	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
+	mfd = pll_denominator & PLL_MFD_MASK;
+
+	pll_div = readl_relaxed(pll->base + PLL_DIV);
+	mfi = (pll_div & PLL_MFI_MASK) >> PLL_MFI_SHIFT;
+
+	rdiv = (pll_div & PLL_RDIV_MASK) >> PLL_RDIV_SHIFT;
+	rdiv = rdiv + 1;
+	odiv = pll_div & PLL_ODIV_MASK;
+	switch (odiv) {
+	case 0:
+		odiv = 2;
+		break;
+	case 1:
+		odiv = 3;
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Sometimes, the recalculated rate has deviation due to
+	 * the frac part. So find the accurate pll rate from the table
+	 * first, if no match rate in the table, use the rate calculated
+	 * from the equation below.
+	 */
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate_table[i].mfn == mfn && rate_table[i].mfi == mfi &&
+		    rate_table[i].mfd == mfd && rate_table[i].rdiv == rdiv &&
+		    rate_table[i].odiv == odiv)
+			rate = rate_table[i].rate;
+	}
+
+	/* Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷) */
+	fvco = fvco * mfi + fvco * mfn / mfd;
+
+	do_div(fvco, rdiv * odiv);
+
+	return rate ? (unsigned long) rate : (unsigned long)fvco;
+}
+
+static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base + PLL_STATUS, val,
+				  val & LOCK_STATUS, 0, LOCK_TIMEOUT_US);
+}
+
+static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
+				    unsigned long prate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate;
+	u32 tmp, pll_div, ana_mfn;
+	int ret;
+
+	rate = imx_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	/* Disable output */
+	tmp = readl_relaxed(pll->base + PLL_CTRL);
+	tmp &= ~CLKMUX_EN;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Power Down */
+	tmp &= ~POWERUP_MASK;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Disable BYPASS */
+	tmp &= ~CLKMUX_BYPASS;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	pll_div = (rate->rdiv << PLL_RDIV_SHIFT) | rate->odiv | (rate->mfi << PLL_MFI_SHIFT);
+	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
+	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);
+
+	/* Wait for 5us according to fracn mode pll doc */
+	udelay(5);
+
+	/* Enable Powerup */
+	tmp |= POWERUP_MASK;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Wait Lock*/
+	ret = clk_fracn_gppll_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable output */
+	tmp |= CLKMUX_EN;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
+
+	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
+
+	return 0;
+}
+
+static int clk_fracn_gppll_prepare(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+	if (val & POWERUP_MASK)
+		return 0;
+
+	val |= CLKMUX_BYPASS;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	val |= POWERUP_MASK;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	val |= CLKMUX_EN;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	ret = clk_fracn_gppll_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	val &= ~CLKMUX_BYPASS;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	return 0;
+}
+
+static int clk_fracn_gppll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+
+	return (val & POWERUP_MASK) ? 1 : 0;
+}
+
+static void clk_fracn_gppll_unprepare(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+	val &= ~POWERUP_MASK;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+}
+
+static const struct clk_ops clk_fracn_gppll_ops = {
+	.prepare	= clk_fracn_gppll_prepare,
+	.unprepare	= clk_fracn_gppll_unprepare,
+	.is_prepared	= clk_fracn_gppll_is_prepared,
+	.recalc_rate	= clk_fracn_gppll_recalc_rate,
+	.round_rate	= clk_fracn_gppll_round_rate,
+	.set_rate	= clk_fracn_gppll_set_rate,
+};
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk)
+{
+	struct clk_fracn_gppll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = pll_clk->flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.ops = &clk_fracn_gppll_ops;
+
+	pll->base = base;
+	pll->hw.init = &init;
+	pll->rate_table = pll_clk->rate_table;
+	pll->rate_count = pll_clk->rate_count;
+
+	hw = &pll->hw;
+
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 63eb7c53b123..a7cbbcd1a3f4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -72,6 +72,27 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
 extern struct imx_pll14xx_clk imx_1443x_pll;
 extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 
+/* NOTE: Rate table should be kept sorted in descending order. */
+struct imx_fracn_gppll_rate_table {
+	unsigned int rate;
+	unsigned int mfi;
+	unsigned int mfn;
+	unsigned int mfd;
+	unsigned int rdiv;
+	unsigned int odiv;
+};
+
+struct imx_fracn_gppll_clk {
+	const struct imx_fracn_gppll_rate_table *rate_table;
+	int rate_count;
+	int flags;
+};
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk);
+
+extern struct imx_fracn_gppll_clk imx_fracn_gppll;
+
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
 
-- 
2.25.1

