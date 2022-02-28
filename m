Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001EF4C60D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiB1CI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiB1CIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:08:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AA17A83;
        Sun, 27 Feb 2022 18:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayi0GHf4CU2cRYqwWZBc7D91XXCD/Plio2OQhA5nvheU0QyTQDPXMbXRQC9Yk9Q6jhmcOCm1raZK6i57I0sIhoFyvrYt/bxI/9CDvzjLb5aisqkIFSRVD+sHoLusDQC9PwTGjD36bq9VlhIyIr+jpK5cqit8hzf1WrPvUayxOIVZ7OnIvALneyO4UtY1xM2jKGfIDPnAP2OqPe0+4bn26xFC0CXpPuM4mSNraRehuchtaL1gttbe1J2kurEsBFQGtI6UVsvxINArgybWMEkNOLXDISGIFBweNsqLvuUIKEjseUOYXR7wFMkacn8cPL4Ca0YOiMNgtPFakBuOykrcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLPpE47/LX0ZxqHPU1XTgN2MrNlu3NuayPJ+FKBkUU4=;
 b=USA/T6jfGyZx36fXUNL/hdiVkzj0DzAwXwE0lueuLX81a7Ru8Qs+6Y0mt3uvyFWGrtCNAMeEGXb9f5IWI7BejeugyH5Df52L0yyPTrRM9hmsIQr9Yu/GZkaZHQPRKLjQxsS/nv6Phss+GEeJyWRZ4EEoS7ykj7hLWu6wwt9T03FTFnGaJes7yhkBG7gjulv+9wgYoQmf99dN/fT5FniCBkevX9PQnpIMsLm3YDquEFzn6Ofc04NdnaxbKhRNBPT1clru3ExaWdfn0Z2JbB/fKH+0JtdWXjRw/llKGKzLiKSde5Jy0eTcktwiPLUnCfCuX+Os+RPBbLGx0thFMH6reQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLPpE47/LX0ZxqHPU1XTgN2MrNlu3NuayPJ+FKBkUU4=;
 b=fV617UtOsT2ttqw3or70YYckBSly88MJOpqXCQggoNbAO3DDqPJiIdachucRNZMEGDNj0+exNRjkyh68t8wPGfoOsfAV9w/RBGimiZMiYif+PhpVbFadkW+4YEUG4IWLiwWGlYBMcp7xkaXhtpqP+BxKmoG++N5zzeaIWGOk3+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:07:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:07:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 5/5] clk: imx: add i.MX93 clk
Date:   Mon, 28 Feb 2022 10:09:08 +0800
Message-Id: <20220228020908.2810346-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de5263d4-ee01-43f2-c646-08d9fa5f17c2
X-MS-TrafficTypeDiagnostic: PAXPR04MB8734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB873425312DACEDCA3337A27CC9019@PAXPR04MB8734.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XbtDkx8aSyJNBCjK0QNGOgl3BXL0INSTvzLQMzcD2VrO98rXdmDPELQlNdsqL0FIMzwpUc3mRQj6MQTddpzPL0Wq/tvRcxU9i8CX7nOOYUK5kqyYF8+pVYLt2J4AwVPle2WJBntn1b2HkQ7rdroE1TppwQZY+zJEGQIpHbSLgj88QatRdPK4yMBaDU8DvWNlPAHAvBvFtMJu/JTKNAVwrp89hU72NlpRo8MsaH5KN6PpnQwp1w3+zWaxFGchEGUcOQ6hQdgErXM8p0HmldMq7Xli2+m6TfJmAJpuW+rcFZCGFmuDS4ctioMiO9cVVavWoGyojVH43BKAxCFq/Cj3P4IBygJKPtNRm/1pkgtA63lrvZt0wVI5H2GGIIyjW2qbRORtpso1BOwA9ENiVRL91bcQDT/Hbtc2Bs891l+3sQY2/tXtWIS5coyLaClG9FmQkrcfTlVsxKOuN/UYxtWnCu/Pgt3fKoBB5z/phsggzhTXm0w2NG5KT7dPx9+9YRMel0J5Ihwt4Wb/c6QpqqHdIDBP2wbvPfLk6YwBhddskCHM7NT3X/MU0UE6mWRvqwh/Lkkg32qrIezmg82/b+u0/BD4rdmKeXOXUcMsc7BHY1onnpj+8C18nzOxWKicv7JTTwWL0yqynSnuaGMX/T070w+VMVFWlpH00yMy2lJaVQHr5IUXVXPNYjN3s0cINKHYQHr2koMyBSApIq/bklu6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(66946007)(7416002)(66556008)(1076003)(86362001)(83380400001)(4326008)(8936002)(508600001)(186003)(26005)(6486002)(6506007)(52116002)(8676002)(6666004)(38100700002)(38350700002)(30864003)(316002)(2906002)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIoefKTK2Kqlcfo+gcxze0YTsWSxIvizHzZSMhSI2Sjnhhm4RN26BSpNm5e2?=
 =?us-ascii?Q?nCva/CIgeCLdho1j621nJUU7bzXPWO4BuoI8mASzGV5s3852EOAthvDH6cDP?=
 =?us-ascii?Q?sngfGe6wqwVYk+EMNALc+9+qa0exo+F0TRKLOfVTfaxcYQTeSh2P9zhrxlTf?=
 =?us-ascii?Q?n/pxyzEStfbX5t9DbvmIntM7/2ErdyEXjrXsFWy0ylpOrA9ripSpK5sbu+iX?=
 =?us-ascii?Q?lrQne4G02ntjR33T9dgnTviMSI2ZNFEmK02YCretmX1XjkJ+9dy6bPf9CKZA?=
 =?us-ascii?Q?RVTm44xF7xCTJZT5XoTHqu+aouLw3lmJsdeIqKvAHGsKLt5SIOeoXTNAKF4p?=
 =?us-ascii?Q?udtKM1/oq36i6FCkRLe0m/UjFloW7vzsJf2VRgxm/ky6BhIJY4Ab+vMJBsGb?=
 =?us-ascii?Q?w1V1qbuO9NQ3DgBFdB2tPBaKfwKuB5/b1JaJtWWgNnsQxU+bTB2Knf85YPgY?=
 =?us-ascii?Q?uagMQ8R7w1oIBcMUyACLJJzF7IoMJD+qZh1EdnLOh70x+KnUEO2NidGRQFvd?=
 =?us-ascii?Q?HruemizcpjVTNv0lNBFJVBDoJNuelbvgokYI5kmLh/UgBnvwoy4Tffdhu25i?=
 =?us-ascii?Q?WC5bNThTnvMTE1SoBA5MA14zmRrBaaFYp9rjJ3PsflCARSQy8eVSbolLKoYS?=
 =?us-ascii?Q?ALeD8lfS6ghdxRleOtvJ51NYxwa4tJjg0R3m7ho4J6JOesAxVHBM15noGh8K?=
 =?us-ascii?Q?acIxYx/qCautdDkT904YMfPbKYSOls7xL2OjA8knZZZMI+qWOeDEvrc5U8CW?=
 =?us-ascii?Q?qt0qfptDU9LnIWA7hn/nwj3EKfpGRip9wngcT4WlbP5pSFa7uwwSn0W6z9o6?=
 =?us-ascii?Q?92ElckBAeSJRPIGF080NPo4XYoUTRV76/OsmY7Wu5j15IldQ7B8ecJavNoam?=
 =?us-ascii?Q?vqC0o+4c6PltEnn3YISmN39ZcF/0fNztWosJrZDoakzeiWmpGD6D8ah1CqaE?=
 =?us-ascii?Q?Qttd5HVeuoc6TNBlw4abrnfmBaQg+4vCd17ILAPXuoir4Lm1Mx0tsRjX9ggV?=
 =?us-ascii?Q?CcaAtBsGIB0Y23ewSM14JqYqNuQXCIbHG++5Tr7sk1xiHnTyU4w2WK3mVimc?=
 =?us-ascii?Q?A8cWfivz2YztTk0VpHp2t9+tzVOOzXYXu6xkluO0cSpETeqFvZnHmnGbRfI4?=
 =?us-ascii?Q?g6M6O+gvQmaBrO+/PjGQ8LzBK5wUSY67mMWq2a3klufpFKrvfkgHWCZzO2l5?=
 =?us-ascii?Q?ZQyyitcd/10APStRNZIa/E8ojHF0o6+WP3LtznXxw+ULrT2WcR/A4PdENhx4?=
 =?us-ascii?Q?laQrCvBPt2r9dw1xqCAXAq1P/OhyX8mMkMqyzN8Q/ma9pqZ6VKGNSKEU5BMu?=
 =?us-ascii?Q?XZzj4yJh2NCapTSYOkNy3e/zjth0HYXxGLQF6qqFMUti55ixHrmldH8gJ6NV?=
 =?us-ascii?Q?/r9vgVnBRhhvq/mRahixvd2LEDdRF+N0+Kz9+qyQjBeFyU9Q+1BF5Qo+8ixv?=
 =?us-ascii?Q?vAN9HQxtiKO2JvlT0HGvcAzWkgTDH0wk425lhbYOrhdTTxGNcIBYoZeQJ0pl?=
 =?us-ascii?Q?Lr1YqiV+zF94pdDvgMu3KNL0jfSXFdtxJCZeE+1/foi/B3J5NAIu6Zno9/tK?=
 =?us-ascii?Q?R5svIM1xSd6AwhRgV1ZA3plfSlvEcd8VzJO3Lc/BlTgAf+O9DSTlYGfDxkmh?=
 =?us-ascii?Q?7HR5knksaZFI4UmQ5CVcwE4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5263d4-ee01-43f2-c646-08d9fa5f17c2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:07:37.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvctHl5XQ6tfy50WFfpyg1UR8Ab/ggNas1bUINdGSn6wX9BEcT8YvfMxpb6BWYfd48XCSVFiOr8wkOBm8sOcRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 clk driver. i.MX93 clk hardware design is different compared
with i.MX8M. It supports 4 sources for each clk root and the sources
are separated into a few groups, low speed/fast io/audio and etc.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig     |   6 +
 drivers/clk/imx/Makefile    |   2 +
 drivers/clk/imx/clk-imx93.c | 338 ++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx93.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 45641b8bdc50..cc464a42d646 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -106,6 +106,12 @@ config CLK_IMX8ULP
 	help
 	    Build the driver for i.MX8ULP CCM Clock Driver
 
+config CLK_IMX93
+	tristate "IMX93 CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
+	help
+	    Build the driver for i.MX93 CCM Clock Driver
+
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
 	depends on SOC_IMXRT
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 60c8a4bb7574..88b9b9285d22 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -28,6 +28,8 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
+obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
 				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o \
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
new file mode 100644
index 000000000000..56d0d34cbdec
--- /dev/null
+++ b/drivers/clk/imx/clk-imx93.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <dt-bindings/clock/imx93-clock.h>
+
+#include "clk.h"
+
+enum clk_sel {
+	LOW_SPEED_IO_SEL,
+	NON_IO_SEL,
+	FAST_SEL,
+	AUDIO_SEL,
+	VIDEO_SEL,
+	TPM_SEL,
+	CKO1_SEL,
+	CKO2_SEL,
+	MISC_SEL,
+	MAX_SEL
+};
+
+static const char *parent_names[MAX_SEL][4] = {
+	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
+	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
+	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "sys_pll_pfd2"},
+	{"osc_24m", "audio_pll", "video_pll", "clk_ext1"},
+	{"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd0"},
+	{"osc_24m", "sys_pll_pfd0", "audio_pll", "clk_ext1"},
+	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "audio_pll"},
+	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "video_pll"},
+	{"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd2"},
+};
+
+static const struct imx93_clk_root {
+	u32 clk;
+	char *name;
+	u32 off;
+	enum clk_sel sel;
+	unsigned long flags;
+} root_array[] = {
+	/* a55/m33/bus critical clk for system run */
+	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_A55_MTR_BUS,	"a55_mtr_bus_root",	0x0080,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_A55,		"a55_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_M33,		"m33_root",		0x0180,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_BUS_WAKEUP,		"bus_wakeup_root",	0x0280,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPIT1,		"lpit1_root",		0x0600,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPIT2,		"lpit2_root",		0x0680,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPTMR2,		"lptmr2_root",		0x0780,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_TPM1,		"tpm1_root",		0x0800,	TPM_SEL, },
+	{ IMX93_CLK_TPM2,		"tpm2_root",		0x0880,	TPM_SEL, },
+	{ IMX93_CLK_TPM3,		"tpm3_root",		0x0900,	TPM_SEL, },
+	{ IMX93_CLK_TPM4,		"tpm4_root",		0x0980,	TPM_SEL, },
+	{ IMX93_CLK_TPM5,		"tpm5_root",		0x0a00,	TPM_SEL, },
+	{ IMX93_CLK_TPM6,		"tpm6_root",		0x0a80,	TPM_SEL, },
+	{ IMX93_CLK_FLEXSPI1,		"flexspi1_root",	0x0b00,	FAST_SEL, },
+	{ IMX93_CLK_CAN1,		"can1_root",		0x0b80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_CAN2,		"can2_root",		0x0c00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART1,		"lpuart1_root",		0x0c80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART2,		"lpuart2_root",		0x0d00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART3,		"lpuart3_root",		0x0d80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART4,		"lpuart4_root",		0x0e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART5,		"lpuart5_root",		0x0e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART6,		"lpuart6_root",		0x0f00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART7,		"lpuart7_root",		0x0f80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART8,		"lpuart8_root",		0x1000,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C1,		"lpi2c1_root",		0x1080,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C2,		"lpi2c2_root",		0x1100,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C3,		"lpi2c3_root",		0x1180,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C4,		"lpi2c4_root",		0x1200,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C5,		"lpi2c5_root",		0x1280,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C6,		"lpi2c6_root",		0x1300,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C7,		"lpi2c7_root",		0x1380,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C8,		"lpi2c8_root",		0x1400,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI1,		"lpspi1_root",		0x1480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI2,		"lpspi2_root",		0x1500,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI3,		"lpspi3_root",		0x1580,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI4,		"lpspi4_root",		0x1600,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI5,		"lpspi5_root",		0x1680,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI6,		"lpspi6_root",		0x1700,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI7,		"lpspi7_root",		0x1780,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI8,		"lpspi8_root",		0x1800,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C1,		"i3c1_root",		0x1880,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C2,		"i3c2_root",		0x1900,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_USDHC1,		"usdhc1_root",		0x1980,	FAST_SEL, },
+	{ IMX93_CLK_USDHC2,		"usdhc2_root",		0x1a00,	FAST_SEL, },
+	{ IMX93_CLK_USDHC3,		"usdhc3_root",		0x1a80,	FAST_SEL, },
+	{ IMX93_CLK_SAI1,		"sai1_root",		0x1b00,	AUDIO_SEL, },
+	{ IMX93_CLK_SAI2,		"sai2_root",		0x1b80,	AUDIO_SEL, },
+	{ IMX93_CLK_SAI3,		"sai3_root",		0x1c00,	AUDIO_SEL, },
+	{ IMX93_CLK_CCM_CKO1,		"ccm_cko1_root",	0x1c80,	CKO1_SEL, },
+	{ IMX93_CLK_CCM_CKO2,		"ccm_cko2_root",	0x1d00,	CKO2_SEL, },
+	{ IMX93_CLK_CCM_CKO3,		"ccm_cko3_root",	0x1d80,	CKO1_SEL, },
+	{ IMX93_CLK_CCM_CKO4,		"ccm_cko4_root",	0x1e00,	CKO2_SEL, },
+	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
+	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
+	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
+	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_TSTMR2,		"tstmr2_root",		0x2880,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_MQS1,		"mqs1_root",		0x2900,	AUDIO_SEL, },
+	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
+	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
+	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
+};
+
+static const struct imx93_clk_ccgr {
+	u32 clk;
+	char *name;
+	char *parent_name;
+	u32 off;
+	unsigned long flags;
+} ccgr_array[] = {
+	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, },
+	/* M33 critical clk for system run */
+	{ IMX93_CLK_CM33_GATE,		"cm33",		"m33_root",		0x8040, CLK_IS_CRITICAL },
+	{ IMX93_CLK_ADC1_GATE,		"adc1",		"osc_24m",		0x82c0, },
+	{ IMX93_CLK_WDOG1_GATE,		"wdog1",	"osc_24m",		0x8300, },
+	{ IMX93_CLK_WDOG2_GATE,		"wdog2",	"osc_24m",		0x8340, },
+	{ IMX93_CLK_WDOG3_GATE,		"wdog3",	"osc_24m",		0x8380, },
+	{ IMX93_CLK_WDOG4_GATE,		"wdog4",	"osc_24m",		0x83c0, },
+	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
+	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
+	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
+	{ IMX93_CLK_MU_A_GATE,		"mu_a",		"bus_aon_root",		0x84c0, },
+	{ IMX93_CLK_MU_B_GATE,		"mu_b",		"bus_aon_root",		0x8500, },
+	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"wakeup_axi_root",	0x8540, },
+	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
+	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi",	"flexspi_root",		0x8640, },
+	{ IMX93_CLK_GPIO1_GATE,		"gpio1",	"m33_root",		0x8880, },
+	{ IMX93_CLK_GPIO2_GATE,		"gpio2",	"bus_wakeup_root",	0x88c0, },
+	{ IMX93_CLK_GPIO3_GATE,		"gpio3",	"bus_wakeup_root",	0x8900, },
+	{ IMX93_CLK_GPIO4_GATE,		"gpio4",	"bus_wakeup_root",	0x8940, },
+	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, },
+	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, },
+	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"lpit1_root",		0x8a00, },
+	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"lpit2_root",		0x8a40, },
+	{ IMX93_CLK_LPTMR1_GATE,	"lptmr1",	"lptmr1_root",		0x8a80, },
+	{ IMX93_CLK_LPTMR2_GATE,	"lptmr2",	"lptmr2_root",		0x8ac0, },
+	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"tpm1_root",		0x8b00, },
+	{ IMX93_CLK_TPM2_GATE,		"tpm2",		"tpm2_root",		0x8b40, },
+	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"tpm3_root",		0x8b80, },
+	{ IMX93_CLK_TPM4_GATE,		"tpm4",		"tpm4_root",		0x8bc0, },
+	{ IMX93_CLK_TPM5_GATE,		"tpm5",		"tpm5_root",		0x8c00, },
+	{ IMX93_CLK_TPM6_GATE,		"tpm6",		"tpm6_root",		0x8c40, },
+	{ IMX93_CLK_CAN1_GATE,		"can1",		"can1_root",		0x8c80, },
+	{ IMX93_CLK_CAN2_GATE,		"can2",		"can2_root",		0x8cc0, },
+	{ IMX93_CLK_LPUART1_GATE,	"lpuart1",	"lpuart1_root",		0x8d00, },
+	{ IMX93_CLK_LPUART2_GATE,	"lpuart2",	"lpuart2_root",		0x8d40, },
+	{ IMX93_CLK_LPUART3_GATE,	"lpuart3",	"lpuart3_root",		0x8d80, },
+	{ IMX93_CLK_LPUART4_GATE,	"lpuart4",	"lpuart4_root",		0x8dc0, },
+	{ IMX93_CLK_LPUART5_GATE,	"lpuart5",	"lpuart5_root",		0x8e00, },
+	{ IMX93_CLK_LPUART6_GATE,	"lpuart6",	"lpuart6_root",		0x8e40, },
+	{ IMX93_CLK_LPUART7_GATE,	"lpuart7",	"lpuart7_root",		0x8e80, },
+	{ IMX93_CLK_LPUART8_GATE,	"lpuart8",	"lpuart8_root",		0x8ec0, },
+	{ IMX93_CLK_LPI2C1_GATE,	"lpi2c1",	"lpi2c1_root",		0x8f00, },
+	{ IMX93_CLK_LPI2C2_GATE,	"lpi2c2",	"lpi2c2_root",		0x8f40, },
+	{ IMX93_CLK_LPI2C3_GATE,	"lpi2c3",	"lpi2c3_root",		0x8f80, },
+	{ IMX93_CLK_LPI2C4_GATE,	"lpi2c4",	"lpi2c4_root",		0x8fc0, },
+	{ IMX93_CLK_LPI2C5_GATE,	"lpi2c5",	"lpi2c5_root",		0x9000, },
+	{ IMX93_CLK_LPI2C6_GATE,	"lpi2c6",	"lpi2c6_root",		0x9040, },
+	{ IMX93_CLK_LPI2C7_GATE,	"lpi2c7",	"lpi2c7_root",		0x9080, },
+	{ IMX93_CLK_LPI2C8_GATE,	"lpi2c8",	"lpi2c8_root",		0x90c0, },
+	{ IMX93_CLK_LPSPI1_GATE,	"lpspi1",	"lpspi1_root",		0x9100, },
+	{ IMX93_CLK_LPSPI2_GATE,	"lpspi2",	"lpspi2_root",		0x9140, },
+	{ IMX93_CLK_LPSPI3_GATE,	"lpspi3",	"lpspi3_root",		0x9180, },
+	{ IMX93_CLK_LPSPI4_GATE,	"lpspi4",	"lpspi4_root",		0x91c0, },
+	{ IMX93_CLK_LPSPI5_GATE,	"lpspi5",	"lpspi5_root",		0x9200, },
+	{ IMX93_CLK_LPSPI6_GATE,	"lpspi6",	"lpspi6_root",		0x9240, },
+	{ IMX93_CLK_LPSPI7_GATE,	"lpspi7",	"lpspi7_root",		0x9280, },
+	{ IMX93_CLK_LPSPI8_GATE,	"lpspi8",	"lpspi8_root",		0x92c0, },
+	{ IMX93_CLK_I3C1_GATE,		"i3c1",		"i3c1_root",		0x9300, },
+	{ IMX93_CLK_I3C2_GATE,		"i3c2",		"i3c2_root",		0x9340, },
+	{ IMX93_CLK_USDHC1_GATE,	"usdhc1",	"usdhc1_root",		0x9380, },
+	{ IMX93_CLK_USDHC2_GATE,	"usdhc2",	"usdhc2_root",		0x93c0, },
+	{ IMX93_CLK_USDHC3_GATE,	"usdhc3",	"usdhc3_root",		0x9400, },
+	{ IMX93_CLK_SAI1_GATE,		"sai1",		"sai1_root",		0x9440, },
+	{ IMX93_CLK_SAI2_GATE,		"sai2",		"sai2_root",		0x9480, },
+	{ IMX93_CLK_SAI3_GATE,		"sai3",		"sai3_root",		0x94c0, },
+	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
+	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
+	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
+	{ IMX93_CLK_LCDIF_GATE,		"lcdif",	"media_apb_root",	0x9640, },
+	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, },
+	{ IMX93_CLK_ISI_GATE,		"isi",		"media_apb_root",	0x96c0, },
+	{ IMX93_CLK_NIC_MEDIA_GATE,	"nic_media",	"media_apb_root",	0x9700, },
+	{ IMX93_CLK_USB_CONTROLLER_GATE, "usb_controller", "hsio_root",		0x9a00, },
+	{ IMX93_CLK_USB_TEST_60M_GATE,	"usb_test_60m",	"hsio_usb_test_60m_root", 0x9a40, },
+	{ IMX93_CLK_HSIO_TROUT_24M_GATE, "hsio_trout_24m", "osc_24m",		0x9a80, },
+	{ IMX93_CLK_PDM_GATE,		"pdm",		"pdm_root",		0x9ac0, },
+	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
+	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
+	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
+	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
+	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"enet_root",		0x9e00, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
+	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
+	{ IMX93_CLK_TSTMR2_GATE,	"tstmr2",	"bus_wakeup_root",	0x9f00, },
+	{ IMX93_CLK_TMC_GATE,		"tmc",		"osc_24m",		0x9f40, },
+	{ IMX93_CLK_PMRO_GATE,		"pmro",		"osc_24m",		0x9f80, }
+};
+
+static struct clk_hw_onecell_data *clk_hw_data;
+static struct clk_hw **clks;
+
+static int imx93_clocks_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct imx93_clk_root *root;
+	const struct imx93_clk_ccgr *ccgr;
+	void __iomem *base = NULL;
+	int i, ret;
+
+	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+					  IMX93_CLK_END), GFP_KERNEL);
+	if (!clk_hw_data)
+		return -ENOMEM;
+
+	clk_hw_data->num = IMX93_CLK_END;
+	clks = clk_hw_data->hws;
+
+	clks[IMX93_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
+	clks[IMX93_CLK_24M] = imx_obtain_fixed_clk_hw(np, "osc_24m");
+	clks[IMX93_CLK_32K] = imx_obtain_fixed_clk_hw(np, "osc_32k");
+	clks[IMX93_CLK_EXT1] = imx_obtain_fixed_clk_hw(np, "clk_ext1");
+
+	clks[IMX93_CLK_SYS_PLL_PFD0] = imx_clk_hw_fixed("sys_pll_pfd0", 1000000000);
+	clks[IMX93_CLK_SYS_PLL_PFD0_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd0_div2",
+								    "sys_pll_pfd0", 1, 2);
+	clks[IMX93_CLK_SYS_PLL_PFD1] = imx_clk_hw_fixed("sys_pll_pfd1", 800000000);
+	clks[IMX93_CLK_SYS_PLL_PFD1_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd1_div2",
+								    "sys_pll_pfd1", 1, 2);
+	clks[IMX93_CLK_SYS_PLL_PFD2] = imx_clk_hw_fixed("sys_pll_pfd2", 625000000);
+	clks[IMX93_CLK_SYS_PLL_PFD2_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd2_div2",
+								    "sys_pll_pfd2", 1, 2);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
+	base = of_iomap(np, 0);
+	of_node_put(np);
+	if (WARN_ON(!base))
+		return -ENOMEM;
+
+	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", base + 0x1200,
+							&imx_fracn_gppll);
+	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", base + 0x1400,
+							&imx_fracn_gppll);
+
+	np = dev->of_node;
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(IS_ERR(base)))
+		return PTR_ERR(base);
+
+	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
+		root = &root_array[i];
+		clks[root->clk] = imx93_clk_composite_flags(root->name,
+							    parent_names[root->sel],
+							    4, base + root->off,
+							    root->flags);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
+		ccgr = &ccgr_array[i];
+		clks[ccgr->clk] = imx_clk_hw_gate4_flags(ccgr->name,
+							 ccgr->parent_name,
+							 base + ccgr->off, 0,
+							 ccgr->flags);
+	}
+
+	imx_check_clk_hws(clks, IMX93_CLK_END);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret < 0) {
+		dev_err(dev, "failed to register clks for i.MX93\n");
+		goto unregister_hws;
+	}
+
+	return 0;
+
+unregister_hws:
+	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
+
+	return ret;
+}
+
+static const struct of_device_id imx93_clk_of_match[] = {
+	{ .compatible = "fsl,imx93-ccm" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
+
+static struct platform_driver imx93_clk_driver = {
+	.probe = imx93_clocks_probe,
+	.driver = {
+		.name = "imx93-ccm",
+		.suppress_bind_attrs = true,
+		.of_match_table = of_match_ptr(imx93_clk_of_match),
+	},
+};
+module_platform_driver(imx93_clk_driver);
-- 
2.25.1

