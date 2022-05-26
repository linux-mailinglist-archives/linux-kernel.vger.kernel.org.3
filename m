Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646A8534F38
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347301AbiEZMda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347333AbiEZMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:33:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E6A451;
        Thu, 26 May 2022 05:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga0Tm4s6Pd+lzrlCZD6bZb1uw2lu87U+K0w2SRlpUxchF9KgjvRqb7R7tx1FjJIIrrHvIOmQb2k7757ineD7XMkXKNYYE7Z3xIQJIzkNIzxfcsVUL2Zz9WMw5xPXOUOWJh856fpcLID7eVW655Ol0+oRdBBWkczCYmK09WzJouC3tVCcH3IBG6QWrjtuIa5t3g0zCHXMvw0nJIZSJlepNwUC1aKSHTlTSutX00CUkpY3otwXNFQfgfcNoEQ8wwVqIF9Df5XV73TuhoFm6OoBI+b2lvQqX7DnA0b0I3NhWrCtwz0RYIUDn1N90TFVuHca7STcyRTMRzsJdJXe2ncp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GRmO33QdY0dtARzi9ScMm4URWVHl3SG6xN6TjtHm9Q=;
 b=PVlkbY91fAItj/I/4gm1C7c/U5K4CuP+nafNXofQDrdU1Yn0yxMqZEENstaILvfS/derrbbagMeyF6W8x8updXQXshtweb+hpxKRSmmXqkzNG+y5mvYj+E5Iy25cKiEAflKbMHtd0CUGBdpZ9CdcROoJTk4wr/bKFTddSCTJd5I7/Cn8BNq+ibLxHVXaAeTu/yVqHDS4hG83vLdYFKHnOZLP4/WqpCJ9vrMMObfxwfdoe7qeRoL5F8wDpZDIg5MyuTRbfxs9JUFk4Y5ODLOde3BRLGhC5CuogV4NbCtRekyhuHA9HbiSWUXxoIuRd7XCyCjmeM4SUZLeA144Sx2AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GRmO33QdY0dtARzi9ScMm4URWVHl3SG6xN6TjtHm9Q=;
 b=lES/JaCQpmxEqKs3vp688YSsepNbMd2iLsMO4zxZ5dqVad9cX+qUZtPYx2sJc11QpQ81+AKityzUGKvlKfxkxzo4pRSskAZ6573zQ32CgUCb31AE7JDcelZQ4Kpo4bDjwgHsdhEjEakdP7HFulTxNeuAFtuZhzZK0EW+rAF9BdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:32:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:32:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/7] soc: imx: add i.MX93 SRC power domain driver
Date:   Thu, 26 May 2022 20:34:08 +0800
Message-Id: <20220526123411.270083-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526123411.270083-1-peng.fan@oss.nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a2ed988-b4d4-4400-3e2b-08da3f13d913
X-MS-TrafficTypeDiagnostic: DB9PR04MB8363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB83639C4C4BDA842785277BA9C9D99@DB9PR04MB8363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bT35dnjC/b0mTrbaO3XWjAMFHk7gRrgUmVGU6zs9FF62Nhes/NpAb8i0/QT7tevvmASOhmQ/STJCZg2GAR9rbSy2R6IlJCLZyEzxpRs+ahsAy3qTM2wZkt4d43vdrNO3ZTrNIC5JVKiD2svjfUF/6UjxiuAUaV6UjLE0eVJvA95V7IPQirk1k8kT3jcXwRVuhioOPdT1c6+QhZruScD74KjbBUQ0Cof81RrLa1Q8OhnnRlN4AsVXlZ5yAliynKd/r/4EAcIkK1WIAEQneYegvcaH5CFv28pfWolTWYcUWM2hE0WfsRCaKpr4Yt+eCuf8/YBg/xid0OOdZhJ5z0JS2IFYe0lTSj0hu8tf5aApWfLHXa9YUyrfvspj7tC9djTxyssQjKkTjfJfBlA9gGVxiNdzdvpoE046szR3lImprHwERgIOITlHg2KemL9Nr/anYESrQl6Hhz3y9i/txDdE+JNdXomT38xrMSoT2SHLRrj5WqhZYu6jUfPmYgZ4ieG0QxSpjlimyaEEHRd4YawLaLsdR1Y0enRM3QnyHAxe8wqNCQuxeItcNgiInH7wAflVqaJUF1ndKetBspSNMWjvRdzJt4E1JYBLXDR1zE9vXCebOpEQOcwaHfR5E0I8NNT+km3+2EbkulotAlBYAEzQAgMElywr0CVtf5XsZ3Dr0zChleLHb5jlJySV8wda90eU5RnINvdjjCWhvyf62MLvUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6486002)(186003)(2906002)(26005)(6512007)(66476007)(66946007)(83380400001)(66556008)(4326008)(38100700002)(7416002)(86362001)(5660300002)(2616005)(1076003)(8676002)(316002)(8936002)(6506007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lflm269kqF1mLVgZNoqrR7DaQTjEeHGCvVv2WLuwYKYcPM7sDh+3tGawnYYt?=
 =?us-ascii?Q?8npGdwz3nr2BBK2Vg+rSLkNRoH1aJxe8jUiRMkcvP27s8em2FC9GvgVuABQh?=
 =?us-ascii?Q?FhxB3CBHsu5U7eqf8DOAS8fRzmTEE0QREH22gJT59aIXK1u3usvdEg56e/EK?=
 =?us-ascii?Q?LrK74Uvw3zihJfOrR3ITXxi2DF+znpnXU92VYfoYE0DQUTh9k472sdftrFLv?=
 =?us-ascii?Q?WMpQbzE0CggOohj9U08ImVkBEJcUuqr68eHv0cE0/9J90giR3UkKxmGik8hz?=
 =?us-ascii?Q?SRk31wEnMhQiESGUp95UUtjHZc+M3f0wbQq0k+GhtBDZuV070yvTQMocs3jX?=
 =?us-ascii?Q?hBDwlI9TFo/ibfD2WAkoSKlHXIXnMpLjK4+q2CZEAqpdCC5jpsb5l9+goqrJ?=
 =?us-ascii?Q?qLmjohrpJUWO79OSAZgZMl4xko6MG0lzRnhEZJubpQYrogZBEpIR8VXscfc1?=
 =?us-ascii?Q?ooLqlkOU3yZOwmyjQEIWRSjgNnh9COQGTqHjIuGx0A18Y7PFehVHzRnkueJj?=
 =?us-ascii?Q?3Gik0gPp2ZyTZ0mG3BmNgQmf0XCK4ehM3IimLpTqQBo/HBk95t8k/htC6swH?=
 =?us-ascii?Q?bywuQOssXuHpYIZHT/0IdM0Q8yinbUHcfRykRLIrbYAKeFceFsbtKDSqhc1s?=
 =?us-ascii?Q?MLNbzlGtLU1XGichT5Zz1QgcCPNs6zU4vK/wmbC+os6txHM08gwk/tA+KD9Y?=
 =?us-ascii?Q?zEiUMFbHZumfxjEnKi+LLeEfeDcHQ9lnK0/fKIpRdddhWLELKqcbV9f7cie1?=
 =?us-ascii?Q?rPb0YPUBeDg8M74MfpYQWUo9pzXvwLKruCPvBkV+JYAacs2YFjS09zoPtw6U?=
 =?us-ascii?Q?GYvK71pPXdl5yWqGzjKcMx/gHNvBcDBDRwflQ/GKf5mx2wcwZB8u61+zkC4f?=
 =?us-ascii?Q?6HA636jneED3+RB8Gd/w98Eg6NAD1q6j9R3vTymG0OE4Ny008RgGMBWpghlg?=
 =?us-ascii?Q?BLsbzIVFVfeXUwELz/FrZgYZE/sqt0Whhq2wJ3JuMDEwMVttt3jcTjV6vT8J?=
 =?us-ascii?Q?N6ldJWaGmq6oIO9fOwKHkXUJdHN0DhetvlTFHMTKogKz/9+T8h/b9eXJGOQ7?=
 =?us-ascii?Q?qGIX0Of2HAIEFJLXqRmrbgVbTgRl21hnnjtoVTwXRaQvKCYqZ9aoodyjzlS5?=
 =?us-ascii?Q?7+xrRWgURUQ5qdXMxjzMAfyoEYUiqP0yXIGN1VCbEXtERwdfAMQKVAYSZ2Hu?=
 =?us-ascii?Q?NX+CZ26SSBwikTE2X1gZdVQ10eNVVEp7TpfolNsoWltuH6YOB6DVHQsWqMaB?=
 =?us-ascii?Q?H4PgktxOjd/YCutBPc++Ig9FfDCDmSZRskFuzsmezK/BrleVRQso9dRoO/M3?=
 =?us-ascii?Q?4Q5xLiAP2lXVzUFRLYdKXAYx7Sn4WMPWw+jWKOoZEXbfssBrQe7IL5kbCImJ?=
 =?us-ascii?Q?ODIugb318Mm5UAtcbSzyDO7pPdmQFLlgjRTiF+BZt1FADIO6cZHEy0khqugM?=
 =?us-ascii?Q?j2rsv1JmrZoW/tndPNwVev89hXphVin3v6zJQzQ2BfUpf+Zg2YqU257KFQaY?=
 =?us-ascii?Q?gxERLtTBJi75Ng6RcV4gLUM8yB/GFAngaeX5r0pIGECOQqUA2bdw4HFcxnOw?=
 =?us-ascii?Q?V1lQj2UiC3qCbR7C2/4D2tVArl6plcROFGSZsd0ZGQXkekDpblHDJ60wq+/k?=
 =?us-ascii?Q?vQ3U2iGYFyCY/UiTxrRv/thq6bKmX1PH+dDw6E3tb5LwhG43i0+yJEGjJTh6?=
 =?us-ascii?Q?TgDsFkQQ0b7Mobx/nffiV7fpzBTzUU5XAZT1aISNKWDYZQA8DYd+DiTVDX/m?=
 =?us-ascii?Q?uTRi1mCHRQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2ed988-b4d4-4400-3e2b-08da3f13d913
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:32:50.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+bF1vnaJ9w39/2wWlx3TljIN3uHyJ8RnyCSJodW1QJrjpQbOxIzSbwCudDA5Xc6XUFCEUjSlnC0JTmYF0nyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support controlling power domain managed by System Reset
Controller(SRC). Current supported power domain is mediamix power
domain.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig    |  10 ++
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/imx93-pd.c | 271 +++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/soc/imx/imx93-pd.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a840494e849a..5bfc1dfea28b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,14 @@ config SOC_IMX8M
 	  support, it will provide the SoC info like SoC family,
 	  ID and revision etc.
 
+config SOC_IMX9
+	tristate "i.MX9 SoC family support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC && ARM64
+	select SOC_BUS
+	select PM_GENERIC_DOMAINS
+	help
+	  If you say yes here you get support for the NXP i.MX9 family
+	  support.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 63cd29f6d4d2..e3ed07a6bcf9 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
new file mode 100644
index 000000000000..c6d204b51c14
--- /dev/null
+++ b/drivers/soc/imx/imx93-pd.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/power/imx93-power.h>
+
+#define IMX93_SRC_MEDIAMIX_OFF		0x2400
+
+#define MIX_SLICE_SW_CTRL_OFF		0x20
+#define SLICE_SW_CTRL_PSW_CTRL_OFF_MASK	BIT(4)
+#define SLICE_SW_CTRL_PDN_SOFT_MASK	BIT(31)
+
+#define MIX_FUNC_STAT_OFF		0xB4
+
+#define FUNC_STAT_PSW_STAT_MASK		BIT(0)
+#define FUNC_STAT_RST_STAT_MASK		BIT(2)
+#define FUNC_STAT_ISO_STAT_MASK		BIT(4)
+
+struct imx93_slice_info {
+	char *name;
+	u32 mix_off;
+};
+
+struct imx93_plat_data {
+	u32 num_slice;
+	struct imx93_slice_info *slices;
+};
+
+struct imx93_power_domain {
+	struct generic_pm_domain genpd;
+	struct device *dev;
+	void * __iomem base;
+	const struct imx93_slice_info *slice_info;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+#define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
+
+struct imx93_slice_info imx93_slice_infos[] = {
+	[IMX93_POWER_DOMAIN_MEDIAMIX] = {
+		.name      = "mediamix",
+		.mix_off = IMX93_SRC_MEDIAMIX_OFF,
+	}
+};
+
+struct imx93_plat_data imx93_plat_data = {
+	.num_slice = ARRAY_SIZE(imx93_slice_infos),
+	.slices = imx93_slice_infos,
+};
+
+static int imx93_pd_on(struct generic_pm_domain *genpd)
+{
+	struct imx93_power_domain *domain = to_imx93_pd(genpd);
+	const struct imx93_slice_info *slice_info =  domain->slice_info;
+	void * __iomem addr = domain->base + slice_info->mix_off;
+	u32 val;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	if (ret) {
+		dev_err(domain->dev, "failed to enable clocks for domain: %s\n", genpd->name);
+		return ret;
+	}
+
+	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
+	val &= ~SLICE_SW_CTRL_PDN_SOFT_MASK;
+	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
+
+	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
+				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
+	if (ret) {
+		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx93_pd_off(struct generic_pm_domain *genpd)
+{
+	struct imx93_power_domain *domain = to_imx93_pd(genpd);
+	const struct imx93_slice_info *slice_info =  domain->slice_info;
+	void * __iomem addr = domain->base + slice_info->mix_off;
+	int ret;
+	u32 val;
+
+	/* Power off MIX */
+	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
+	val |= SLICE_SW_CTRL_PDN_SOFT_MASK;
+	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
+
+	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
+				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
+	if (ret) {
+		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
+		return ret;
+	}
+
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	return 0;
+};
+
+static const struct of_device_id imx93_power_domain_ids[] = {
+	{ .compatible = "fsl,imx93-src", .data = &imx93_plat_data, },
+	{},
+};
+
+static int imx93_pd_remove(struct platform_device *pdev)
+{
+	struct imx93_power_domain *pd = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	const struct imx93_plat_data *data = of_device_get_match_data(dev);
+	u32 num_domains = data->num_slice;
+	struct device_node *slice_np, *np;
+	int ret;
+
+	slice_np = of_get_child_by_name(pdev->dev.of_node, "slice");
+
+	for_each_child_of_node(slice_np, np) {
+		struct imx93_power_domain *domain;
+		u32 index;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		ret = of_property_read_u32(np, "reg", &index);
+		if (ret) {
+			dev_err(dev, "Failed to read 'reg' property\n");
+			of_node_put(np);
+			return ret;
+		}
+
+		if (index >= num_domains) {
+			dev_warn(dev, "Domain index %d is out of bounds\n", index);
+			continue;
+		}
+
+		domain = &pd[index];
+
+		of_genpd_del_provider(np);
+
+		pm_genpd_remove(&domain->genpd);
+		clk_bulk_put_all(domain->num_clks, domain->clks);
+	};
+
+	return 0;
+}
+
+static int imx93_pd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx93_plat_data *data = of_device_get_match_data(dev);
+	const struct imx93_slice_info *slice_info = data->slices;
+	struct imx93_power_domain *pd;
+	u32 num_domains = data->num_slice;
+	struct device_node *slice_np, *np;
+	void __iomem *base;
+	bool is_off;
+	int ret;
+
+	slice_np = of_get_child_by_name(dev->of_node, "slice");
+	if (!slice_np) {
+		dev_err(dev, "No slices specified in DT\n");
+		return -EINVAL;
+	}
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pd = devm_kcalloc(dev, num_domains, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pd);
+
+	for_each_child_of_node(slice_np, np) {
+		struct imx93_power_domain *domain;
+		u32 index;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		ret = of_property_read_u32(np, "reg", &index);
+		if (ret) {
+			dev_err(dev, "Failed to read 'reg' property\n");
+			of_node_put(np);
+			return ret;
+		}
+
+		if (index >= num_domains) {
+			dev_warn(dev, "Domain index %d is out of bounds\n", index);
+			continue;
+		}
+
+		domain = &pd[index];
+
+		domain->num_clks = of_clk_bulk_get_all(np, &domain->clks);
+		if (domain->num_clks < 0) {
+			return dev_err_probe(domain->dev, domain->num_clks,
+					     "Failed to get %s's clocks\n",
+					     slice_info[index].name);
+		}
+
+		domain->genpd.name = slice_info[index].name;
+		domain->genpd.power_off = imx93_pd_off;
+		domain->genpd.power_on = imx93_pd_on;
+		domain->slice_info = &slice_info[index];
+		domain->base = base;
+
+		is_off = readl(domain->base + slice_info->mix_off + MIX_FUNC_STAT_OFF) &
+			FUNC_STAT_ISO_STAT_MASK;
+		/* Just to sync the status of hardware */
+		if (!is_off) {
+			ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+			if (ret) {
+				dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
+					domain->genpd.name);
+				clk_bulk_put_all(domain->num_clks, domain->clks);
+				return 0;
+			}
+		}
+
+		dev_info(dev, "%s: state: %x\n", domain->genpd.name,
+			 readl(domain->base + MIX_FUNC_STAT_OFF));
+		ret = pm_genpd_init(&domain->genpd, NULL, is_off);
+		if (ret) {
+			dev_err(dev, "failed to init genpd\n");
+			clk_bulk_put_all(domain->num_clks, domain->clks);
+			return ret;
+		}
+
+		ret = of_genpd_add_provider_simple(np, &domain->genpd);
+		if (ret) {
+			clk_bulk_put_all(domain->num_clks, domain->clks);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx93_dt_ids[] = {
+	{ .compatible = "fsl,imx93-src", .data = &imx93_plat_data, },
+	{ }
+};
+
+static struct platform_driver imx93_power_domain_driver = {
+	.driver = {
+		.name	= "imx93_power_domain",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx93_dt_ids,
+	},
+	.probe = imx93_pd_probe,
+	.remove = imx93_pd_remove,
+};
+module_platform_driver(imx93_power_domain_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX93 power domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

