Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380AF53DF86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352064AbiFFBtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbiFFBtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:49:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939404F9CC;
        Sun,  5 Jun 2022 18:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=layxjmg6m7pn1c9QzAVOty1MoNsLFB4bfeK//B3lc1jkVqsMcz4Ih4Ia7PgZbftrKqiEo/Hd27PLmluvARk/eJI8K/gHwkLF5ips6vX3GspQX3rVaZPR/roM8h8NofL5xvEqhCz5yecLDLXh/Ofs1IwS3VtAWa7N2uSMJvtgM3WI2uj9HWLdDBw9n7l9Xtb3Bg1GMN7e2dd6d+Mkk25vBBrIACbLiKybfkU6PmORfYhUs2WXhYAYdXCnBpkXiI50wrZv/MnfPI7cppCI2n5WP9aksd9l0XR3c2FWjzvwNoJLC1F9LYMqeoHBqR7WYowxX2YZ/xyeF2hlajDvRDtprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GRmO33QdY0dtARzi9ScMm4URWVHl3SG6xN6TjtHm9Q=;
 b=JdZfRcn+b6sdPczyaz+XQ8+Ilftfn3uYobTkxR0ApvQaoveRSc67OhGHKYhY3xwwyVTPpIdPEn9ZOSydclvJk62rsEkc/g02t0yG8JNY1dNjdtP1Se+Faeq2TjEu4GMkpsdDBt2wqVVkEFO/pxFVR301x1Gf3XebsNi7dXGky5jzZiT0b2JUhwRN0xepMn/o0DRQm9mj0LdBQ9Jo7+ex0sUKmPvE4eew+SQWjiCaqA+XSGnJ4VsBGmr1pbnElASJI/FNh0dbk+55K2Fuqh3UaWENJ9dmU7aHYdgPIxuuro2LRQXAata/vpEOAirScCoaQbcyRnYp5JHQiYClVTiN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GRmO33QdY0dtARzi9ScMm4URWVHl3SG6xN6TjtHm9Q=;
 b=lqsYwt60h1E/i2nB6FUo0XR+HT2hoLpp3sxIJMt1cmauI+bVHQXBkdggAaDNsuVMKBEOoQhOd5dM1WN2JLmPDyZDzXMHFajrW1YXDtzQfMUQknercHi6lbyDoOpvk+TZ0hRGjvzdeBFWyV36duByvQU7ySIUb7wYVObhGxsLZnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:49:08 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:49:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/7] soc: imx: add i.MX93 SRC power domain driver
Date:   Mon,  6 Jun 2022 09:50:22 +0800
Message-Id: <20220606015025.180840-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606015025.180840-1-peng.fan@oss.nxp.com>
References: <20220606015025.180840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff04cfe4-3cd0-497e-9ea0-08da475ebed1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4840CF12EC04DB4FA8D5CA56C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUhFOMyGfYqKUTVvFD5UHp1sOFGzv6VteBjvzAVqOKgXZSXW2cKHAkg+M/b2dqEpmy/wJIJFlF9JFLz6kPYi3IPa4HklKfdtST6FhJuFG1fd0R634aBOc9Ojtse66Td+3IT3kfUABGbpbgJhlJH0GB4PHcVlpD6CB0edl9YxOLw/oHzxSawoe0PTsnrSlxBzsu3A+ASnhdG9rQwqbvtCTqj3HAnmsTSZ3ouN4EGtz2ot6U5OH+0Zh8w+ToxPIT1nMI5xdwDcX6rz5XR1gvVoElOaB/XsVDOffjmbJHeV827V0EkQfKpVJBIw/7VjYOC4C/ucweY7EhUaOIXDvyn+s7nx4TzpFkuQ18Phfi2PhKLkSPqy9gLlm07qOb8jQ9d5pnsamlW+qyqQuwSqE2wm7mo50xm214fdPC1YN02InZ5L0+2/PQ2eeGRlg1ZyY8eYeYUILf+jNf2wr1jRfiJW2njsRxPwufoTdXRfjHgUIkEKVGXcHJi3MS+dWUF9rdbXxhrIO5MrcvhiugBuDYw0lyW3NepJoO+FoOW6amTM3ei6IRPgHtXg3b81LA2BsKUMa0FpOeLpb37Z9+uOWePxO+I/19BvaWO6iTDCDO1JPLC4WJcQ13H3kyPkMSY9X78QDfrpDMs8NaqsML8OniRcBcp7a17ZMUmeD8q+ozbrj2uBKmsnksWAq+rzSRBfmMfONicUgvxMsqVbAy+EBIxUfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nflKYlfTRyGsRIDV1jTIw/2i0hBIwl9ajSG8p01AapJIbymmUpSuzZmLokPT?=
 =?us-ascii?Q?wb+gCoYTPltCC1ymbuwJ9oAXVDxAnQXuLBR5xyKu8We6WkmjAahKtCLozEVp?=
 =?us-ascii?Q?3JeCluzT9IQm8Gvi94RBUc3m84tz8R40QBMU/phoNFS4ir2xsV0tac5elsxE?=
 =?us-ascii?Q?wt7hDZgyb8L4k6duIvbVxsevYRI130c8KQo1QINyRaQ/2DwXXhnTO9GIKYyB?=
 =?us-ascii?Q?OUUaBMOGOkJ6iTSIZn3kl+0d8RhwNsWxIqxzHsk3JE+ZILCy7DMlM0NAhWUZ?=
 =?us-ascii?Q?iIKm16o74bY7BoOcgmFeCq/He4c2Mq9/WFPbAgW3/ngT/79PkhnxfIHT120I?=
 =?us-ascii?Q?/qJxJ+zJoBSd9IzdCyKCn5/KlQh91lWzQ9I4k+kDhDReoTyTsyMWwhP6Qt7r?=
 =?us-ascii?Q?MYkMi1wo+wFicoSn0g/jokzFq6bV5dyQ2K2Ntg16V3VhhftAo0nXeQr9wbn1?=
 =?us-ascii?Q?irOhkhPjKYJ2JuD2YEJ6rgJClTHErDGVogwWdTt74yQ/cIp6yV00nKw9FQQa?=
 =?us-ascii?Q?c2IAs1NV+OF3A7+DDXwcMf1M4OVHBB4EdJ3yKvebL1u5qk6nwUf2ImZidnWl?=
 =?us-ascii?Q?XyfjvKzvuFr5a6X7pX/Pc6YuUxidDksQ9dMS9G4hV5/Cjrg/yQEDiMbeXeWq?=
 =?us-ascii?Q?zCL9TT9LELKlpFGSBPdrm9WKc74NSlbaMuUD9XUqWDHYVP8ftR9h2ZEstoCy?=
 =?us-ascii?Q?yZLk3W8DKx1Hnpu4+f0kZRb9a/tuPn1Ze5/Dx/V4lb89qDgavLfrQDAhuk0W?=
 =?us-ascii?Q?uoppJhJQhrx12Eo5Ko9EQ7uUxYv0eU33c4wfCL9jvfw9oJRayttTZ3w/G1As?=
 =?us-ascii?Q?SmRqzP5Skf4n//2fbMLVgkYHrALUliW2VEUeUQ9tz/asOT+F53FBK8jXwdxp?=
 =?us-ascii?Q?KZYnCHtSyvzbqIDaqA+c0cUOoXcJSoVfUXOZsHNMPQZhjAm3U8IkLLZuMbbS?=
 =?us-ascii?Q?w8kPepuajvS9lzY9RzLiEFuAbOqFVtYFK1g6CeARdiO2c9FTKBdseSyIHl/U?=
 =?us-ascii?Q?VFzsnXA6ODDePBmWDFuqF9qmlQTh6CFX5EKOHRhEIFuzoCN9l8d2ZNNKUDwC?=
 =?us-ascii?Q?3DmMAwFXNxX27FN8wUjEskv/PhIRVxeiyJa9/cEn66Jg/2+VrsxEeSWlkwEq?=
 =?us-ascii?Q?G16RbX+UmK2BD16jwnacuuRT8upZTTumyhXMzSd7bTm3G+F56dkXD47DfupW?=
 =?us-ascii?Q?sBcXerMhoV7rKRk5raQu/0OZkM42j2RtQ0LHKKB2sAo9WqohSV8p8ko3j7dX?=
 =?us-ascii?Q?NRy99u7PjI55VadCLG9giqxi8p30yeP9uA1ylzKDtQoiRWxOuiOJEXkya9PL?=
 =?us-ascii?Q?25894pMMpsJPaEiNFouP3Q/JUof8MJfHGL4jf6gTpx+SRrtzGxTTTDNcDbKY?=
 =?us-ascii?Q?jlZxn04Mo+DRjx5uEB8Ygo8LCsYK0G2E7pSeTJr8vDRuo66FoiqmU1gqVxRP?=
 =?us-ascii?Q?YKLCuMsaf3vDxsmEIAL+z1qimck+hBjq8RPiztEb37PIa4bKZTh1SPKmFDv1?=
 =?us-ascii?Q?VrD2uGGJApIeb5nPqW2iWLv+qkukFy4VKJxBeeOLlSGpOI6s55Y0oFCTvecA?=
 =?us-ascii?Q?27slPSSdAYcz8N7uebTZpFvhqtqK/sPvzgoIcK0DQkliGgC2S8LxaCNPQdS/?=
 =?us-ascii?Q?chJ+etDxHiqBywvmOD6Qgz0v9Y7cAKzabGQd+LZCYoK0NKR6nkYSekD89miq?=
 =?us-ascii?Q?+QbTTTD693bUCYsalNJXT+nvL1gJTPL/ZcV4by7Xa7bPZkq7X82LVEGWD0DA?=
 =?us-ascii?Q?6NFcGNbD4g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff04cfe4-3cd0-497e-9ea0-08da475ebed1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:49:08.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov7rlPSYHOpy6eDyFb88N22qOJmzQNKDK6fH4ScIp+zGvrqHFMTLk109bvikQ3hIiyygwNCfRu8zmW///7ngCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
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

