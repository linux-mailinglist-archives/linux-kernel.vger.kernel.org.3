Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3C4C06C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiBWBPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiBWBPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:15:06 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30046.outbound.protection.outlook.com [40.107.3.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1139B92;
        Tue, 22 Feb 2022 17:14:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjXAPTEL5oHYDEL/T8ptU7tE9BLg0eZLlmlRSk+7YbFvpPGg/O+kwsnZrbF9Gtrz5JWNShdTM2NlgtxFlfoUKFxqY0s1J9n7bPX6+o3fqVCop7hiKTQcfD25VC5AE+Wsna4tnXs553qHz/5LJn06ydsWGxlCIWPncd2K0bjv2AR54DA4aN4bYiSkxxwW3iKVcanBqI7OrsBQBwLV7MKPraw7EeooIWuAtLhLoQrkS5Gp3DfrRuFuasEr7Ommgg6BSlRJIWp0tiOyw9AX1JKHvcq3OOLFSFtSpwFXhqxiUZ/aYC63AlWOLOB58ARmk9isLwd/55zmZWBHEaUGX3H4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6y8KZvIgHATGmIYBESOoyPwOXzllnjzAU06kYu0hNk=;
 b=N5YaQUH0od4gXUR0S2o6Ou/ip+CaIMMLGL0J+pZ0mj4/FMybS57H/oZqvtSbS6AM8cJI/ghuYepPvKAR/JCBnl4dJ5SyuLuoPdD/rdKM+z7pd8FSgyZ7C+6RY97weCJiluaTZpff3h+L3wnCytKtSTC13Idn7kpsW47y7nJuYNssg13QwIKEWhMcNBBGlvmlJKGyqEl/o4HfbJrECOFQHwGkfBIgT6n6ZH12ozXRXE/WtbJjE677vqoH7rgRO0yzC6kTDlALWrakDoxCzWqYdxtCHNAyeShGGubqTW7gdf7UdBtaqumCthFnBrEpa2mi2LLPVKEpYUJ/awN3RDGidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6y8KZvIgHATGmIYBESOoyPwOXzllnjzAU06kYu0hNk=;
 b=MKYKBa9wQq5LFbELLVwoMOFkdsm5oRDs8wheha4mhvgx72J91OWCRcKrjr5v+88FWCFL3Q1A+3F5S2oPT7mm21sm8iEEwQrraQKMBitGEVSP8E++tnpjTcEqGhNhSLqeeY7n3MlDzT4Ycx2aCp9mv/VUNGQcOykAmbCm37a9YkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 01:14:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 01:14:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/5] clk: imx: support fracn gppll
Date:   Wed, 23 Feb 2022 09:16:05 +0800
Message-Id: <20220223011606.3282165-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
References: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1c5d1d-d657-475d-05c5-08d9f669da51
X-MS-TrafficTypeDiagnostic: DU2PR04MB8533:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8533702963A7165058C7B748C93C9@DU2PR04MB8533.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfp/Zr8ew7zXTQbzP9cRsskGL1cCiZkl0xFAFBWODs3nqRf9xjGA0n8gLdVPSBg5qCDpK6X3Pc5lr+AiQAIJ+vOPxQrc3oCvYauIeTEZiye3YDWqEgtLajDjII6cNQSHuWUVHtXf2qrSS8wV5ydV3+rmrPtCDejnSWEAZWWq+o1zTfVms0YThw75pWAjvI4d57hmncB3DrFDIAN0DCRcdYhdPaaWp/jWNSBXxLjpPD3atNgrviduxBXsbIiG/qCSWNoNHJ6guBAeW4mAftNsN5x6q7cysYGlTq25PLlL7xDWs10N2lta7MxmpY52V7VGwVjj61e4VHv7b8YVPnyoWjf+T/loe7EPcLQY4ApOAENsbaZJxryIGHThMsjHNiOB8VV8jfNUVFkeqTQWlyRMbylVn55O3QMVqayy0qSt2lbYhHpfWCdO0Iam1/PNNzwC+McZlPGx0WB56nz9+2QEqqnX48rpmXYVhUWHSTa/3xcnhE4wVxLTQmFw1kCD5dwuemcil/A3E4knxAgpAOgf6dY2HjFWb8YcOLD/K+CYjfu+lpjRZ/7uribWXIMgf3b3BQ+jdJ8yQL3E4ECNSVr9jyixWQ858Lksw054NoPK3nO33QjoXhkFjR4vcEh3WlweRNjPEpRxPm/oYh5kUi7bDek7vAQCnp1JCp/ZFvgWOHXtMx3BhCfIQpohO781JyMtGpdkluB8wonzrcYiApgUYytpwPoAJGIpSPDETgC3bvjuY5aPRgJ6YHwAoVvgCIxsodfG+M9tGSeeN+tBDAVd6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(2616005)(8936002)(2906002)(6506007)(52116002)(6666004)(7416002)(6512007)(5660300002)(86362001)(30864003)(38100700002)(38350700002)(83380400001)(66476007)(316002)(4326008)(508600001)(8676002)(6486002)(66946007)(66556008)(56820400005)(54580400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE04Q251UjJPSVBxMjhMcDhWQlBoajZxSnM3b0NZa0JLTmQ0YTlMOVpQa2xS?=
 =?utf-8?B?MXhzNWlCTmw0U0YrbjdGbkZXTVNJOThNanFSL3pkVkJWeVMxTUZ6UWY4cTE5?=
 =?utf-8?B?dDNhdFB1Q3Bub29PV1NqczZ2L3NUY2ZxWnlic1N0Vy9JdG1SN2h0OEZWZm44?=
 =?utf-8?B?Z21BYkYwdDJPdUN1MjdmZ2E1VVBCK1NubVJRVGJYTkh4MU9oa21qODRiZlJs?=
 =?utf-8?B?NW9lREUvYjZOWVV4Y2c5cFZ5OUFSamZ6MTVvd09QN0VEaG5nR3hqakEwdWRK?=
 =?utf-8?B?dmpqekluM2hWWUpRUGNiWW5kVlBhUitQT0VabVVMMTZWL0J0K2pRK2g1ak9s?=
 =?utf-8?B?TnRveERrMXRWejgwWVEwZkNOSFpZc1FBU01mNi80Q3d2dVlkeWJpTGh2T3Zy?=
 =?utf-8?B?Njd2QURoL095bk1zZnNWS1J1SGFRZW1JbE9sK1BFOGlORE9VMlRIWHZTK1J5?=
 =?utf-8?B?Ly9Wam1GNVpUUzkycnVNK2dxOE0zcXorNy9rNk53N2MxZnRxTUsxQysxWGZi?=
 =?utf-8?B?NDNxbnlzbU5JN05lUkJQMXRqT3hGUTZack8xZ2JmZWdJUXZZVjNnektQS1Bl?=
 =?utf-8?B?WDluWG8xWTIrQi8yellGaEp0WDlhU3FTRFNNdmxFSlMxalRJWlNFZTlpYmNl?=
 =?utf-8?B?T2g0b0NNa1dKbzFMUmlpKzNpdkU3am5BaFhLVjU1aFN6YmNSb1ljK3pDZmIv?=
 =?utf-8?B?dDNRN0h4SWs4YnpUM250VTc5bWg2MmIyTXhMUnIzZi9LZGhJMEFyS3d5ZlFY?=
 =?utf-8?B?UFpBSklsS3NTVXBwTlZjN2EyTlZaaDBEU2F5cUZWTUtXbDh2OTVaUlhEQlAx?=
 =?utf-8?B?c2w0R2kvK0NWSGpPbjYzY0U1MGI2dmowd3RUTjhZMU9DQmpCbkpyZ05kamww?=
 =?utf-8?B?ZFRiVUVHTUxOa0tLSEJVYktWTFFWY3ZPSktjT1RGSUpBdWNxc0J0dXVPcjdD?=
 =?utf-8?B?WjR6RUIxRncxNzQ5bmUwSE5EOWw4b2JIWkRkeG53VzBQVzl5dy9ZcXRSQWc4?=
 =?utf-8?B?b3p2TTNxcXpLdlk3R2luK09YY3JRRVdkdGxDVE9WRUlHWEtkWG8weStESjc3?=
 =?utf-8?B?QVBqQXFJVU9MS3ordHZ2Q0hnNHNQWFJmbXZKbzNwWGQzSDErRGRMNnBkd25t?=
 =?utf-8?B?aEk0aVNrK2d2VkpvSWY2TjkyNUd5a1k1b0FZbHpDemRSZ2Yyc0JLUTVXRzhC?=
 =?utf-8?B?QmhLVnAvYUY5UDBydHZuNEkzVXRheUJjeXhyYXRqWFlBMDdWY0NGbzV5MVVF?=
 =?utf-8?B?S01tYzRGL0FSYXIvVFZwVGVhbFRFQ1g3MkJES0VnOWZhWlhmL2p3R1ByRHRh?=
 =?utf-8?B?SVRNdTdsSWhqa1RhK1NETENTaC81dXRTY2c4RFdFWHpqSkZwNGFVZGJzc296?=
 =?utf-8?B?QU9DQnZBT0k0YWpaQzRScHhXcWw3bG9SK0d5d1lQVUNMQ3VqTHdKNTJXQUVa?=
 =?utf-8?B?ZkM3SDRtcnErQi9WM2dTQzB0clJEYlVTZmhUZkltbVJleFZVY1dCTlp2dDRO?=
 =?utf-8?B?WlczSUVsOUZ2OW1BNUtUVStXcUhqL1BOdXZkcnNTS0RUa3VCcU14Wm13RjUx?=
 =?utf-8?B?VjNNTE1vRktrNld5eDh6ais3bHIzUW9nV1NBREp3cDQweHM5S2dqMDdLdGxo?=
 =?utf-8?B?Mm1DNXlBQnRLcFVTNmx1blVqYTBQVEtpeGc4aVFvVGM4Vno3UlhKRnpLdlRv?=
 =?utf-8?B?R2dyNTR2ZHNWd1lQT3Z1Z2kyTnhoVlR1bmxnbVhiYVlYVnRRVFdIQXdhY2d3?=
 =?utf-8?B?K1Yrczc4aUVSOVYrRVFjRS83MmQ0QVFjYlZZVUloams2aktIbEhOc2VzaTRv?=
 =?utf-8?B?UHV4WmpDOWNvbTF1emJqWFhKWmg1R0pFUmxvZDluTTBCNGtEbHpodW81Nm5N?=
 =?utf-8?B?bXUxQXZhVnRrQ3pIR3g0TlQ2U1FjUWNSTmdXTXlrWjR0RlpObWE0QmdCQ3Fh?=
 =?utf-8?B?bmNhckVGSU5VRXRDRzU4OWE4cFo1NWVFd0NaRWZMaGZPV0lXY00rMnVHT1Fj?=
 =?utf-8?B?a092cGFLVXFnSjVNQm9pcmpjQ1Z6N3ZVUHBuSGowekxZak5zNzhEMXhFMFNj?=
 =?utf-8?B?NnQvdFkxT1Q4VE9GSHIwcTNqOHpxV2loZ2oybW1KZ2tPNldPREZ4b3F3N3dC?=
 =?utf-8?B?TUZ0OWJ2Z2ZnWWRRY1p3YVVEd3BnRzN1YmhuaFNJZk91d2ZRV1FsUndueWhq?=
 =?utf-8?Q?POMPnMn/uYQtCnDMd8aMs48=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1c5d1d-d657-475d-05c5-08d9f669da51
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 01:14:34.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auu3iff1+eHKD3Fd3eU30H3JEDEnyIoyLThPXcFNHfGDo/4vWcNYFO8+xByRkkRFWGfUBOGOlTQpmEVDS9NxHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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
 drivers/clk/imx/clk-fracn-gppll.c | 328 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  21 ++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 36c04922d789..60c8a4bb7574 100644
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
index 000000000000..6c9946a4bdb7
--- /dev/null
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -0,0 +1,328 @@
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
+	u32 val;
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

