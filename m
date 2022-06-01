Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1323553A104
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351358AbiFAJoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351319AbiFAJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257855C658;
        Wed,  1 Jun 2022 02:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBTCZfv4Wgh4PUmPl9Eh3EbuuNDlURaK11rESAPKo6HVpie+Gq4EF24Lvef/v2I7rAyao/zNJzcX9H+MBK9uzGcJNp9iZhbQ7t+U2g564anxZe/Ooks9VJ2kaLZXNu+/kDakSXn9zZ+CDoIln5yXneWdmwVoXstGsRJ3hoeZTFMYSUOqkn0o2oLqgPjjNYwz44O95iYvQW9MGYMc+b7fzGoLtDaG8vCSKQuGU1IGYDEmQMc2Xu+iC5AjhgmY3jd1SfGTHHjYtocGIRD/FeNU/YYaTapAKfgoP62pjZ7R2UNKimi0RF4rbMcfDKQ3vurzBPe7w4Ln4eoxQAeeCdvYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnL+NWiTNsTZR5BTaiLSpWZeivbzbsiwNwr8e0HtaeI=;
 b=BMd9gtmbCRC0MfbNWez+CXuSrPgbitqQqemYJw7XbdoBi3zZp0nSIYpjfws/lr22FNMwE6WcBb8l/S9XfdP247cuXDHAzWF7T4KLhSEGSnz4CM9Xeach82o+q801Niv9VHnfS+xouZzojfdHnCw5Anu6EMI+p3aggKVTSmnGokkl03psyb/gFLDZ9+V4G7QPDE0qcBKYNDEmVsGcPGUYEIDwZ55JLyZ5Ni2MQMLH3GGJqNxjtrDix0cTHZv4b3NAFN4kH09DDLBC2a5H+W8vqk1RyHEI50/rwjzpxg3iNIzI7MkrVSXJwDYvJcSPW/7zB+t7DXZpPy9LaDb9ptgj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnL+NWiTNsTZR5BTaiLSpWZeivbzbsiwNwr8e0HtaeI=;
 b=gZ4kwF2WuSPHocg4fjynworiLPu07Gj6392oUqEUVQTPZ4sepmSYN4gaj7G/9nUunscQG0A5bn/BXa/mJKAfRngjifSQ2AtSXj/5m2KjyBlBsCimd7G6uHlyvmgFnlMxYS8Sq8F0DdXRsipaL8bzUDYB9mCk0TYG8RkbkEEdWF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Date:   Wed,  1 Jun 2022 17:45:33 +0800
Message-Id: <20220601094537.3390127-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52b0af07-598f-477c-0b6c-08da43b34c66
X-MS-TrafficTypeDiagnostic: AS4PR04MB9507:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS4PR04MB950748BD4D3537E8919F0AAAC9DF9@AS4PR04MB9507.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4pfi7wPs4ySpkfnOiBhu6v7wJRyEmLeaRMej9QsWenKTOCUizKz299O4i8rh7sgdJ7Lv6LomzCkEIFpWUk2EvBl/jdvWU+RL6bcnY8HI8uIaBZ2bdHOux3Yu8bF0IJEiEXNJaki+LAFu9u+J3i6X2MJqOBa1jxfMxrqby8Jr4ff44H+JbHAdlmsGeIPvNEXhC6YYdFFbBRkUnEL2ThfcrI0wT88aSo7vppUTudqcSCqDrun3jGPYMhxJ62w/HMl8rCCjbTNf9Aj1BEe1b5aezJ9pBjl7SpWVLtkPuTpL5h5vtFpliQngClmK9YdBHgWBNtfUURfV0sD25019JGIJws1Pr4ETB2bO2to6vdx0piKK9+gA+eomZYoVa3j9qQsR7tktXbqBq95/WvYSCpMtevacVr7mlF6Snny0HvDehm9pVSucScO/yB6l2fFzIn3+4rCUSTnVctJ7C7LEBMo5mgL731mQs46egkUoVbXW4oD0RO/iXTAsk4vwuES7hRHIX0JcNJ7fAby7ffETZvHLGLnzxnk2CgIpTuh4IMEazkgZKGbknpE1ppJQ7oA5a6qDX2QSh7D1ML2VxWemPSCVg831rxipvBCjdVdMz0Brcf9e8fdiDdHGQFM8yIBc/YoKRM/a4u0EknmEVcA3tdLPeIJYZ5D7+/ZIQr8TZ47VuDvwu3SOrfEOILpgoEDWQWFrRR02eQZwoaXDAshwSzby0M+pEjeHnICqpfvXQNh5sY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(921005)(6512007)(6486002)(86362001)(5660300002)(52116002)(38350700002)(38100700002)(7416002)(6666004)(4326008)(66476007)(8676002)(66946007)(66556008)(26005)(6506007)(316002)(186003)(1076003)(83380400001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWSYtOhXXRuVb0d90Q/Lgo1M5uIs6SFJXjQPnYXiAAAaPJ9ANhMwzeUSeYMD?=
 =?us-ascii?Q?MP5bY2xRfJjJ6GuZ2T5ktrXY/6KSdGqlLVw0K+l6VmPlErBBpSVrxM4j+2j8?=
 =?us-ascii?Q?JECjfNo5jeZxhR8MjhlCRga3L7XF5QOXynm5WsV5c7Jc0wl4C0Z6+XGnrsWc?=
 =?us-ascii?Q?7F9z0hXmqRc4AobAdIa7u+P0ZSQZMaQov4pY5qqfO8Dd+0hTtKae81eh/T2y?=
 =?us-ascii?Q?+4nla/NDc86SKreyFU+zO0gBTlLql9i3Qob64tMo4ATDmlQ5vCma82rgxhHW?=
 =?us-ascii?Q?gxeY5bRLYLj0ABPB+ctw6yURKAOd/K14FIh0p1byiZFuJA7hp6vsQTdOGQux?=
 =?us-ascii?Q?XS4YqW3NcsUsKrX+2cbtu3iK5qir/r7xXEJt5/Xj69aqBEWRLPUXIUKV2CZZ?=
 =?us-ascii?Q?OMwWcu58XRAviQO8okK4ZEKGsJIxVWVHEV/veng8MMY8cjPsHz5ZtpeIVb/c?=
 =?us-ascii?Q?MClrMmCH0ldgo7ocPfiq9nf++F2LpuOWHuFCj3S+QISDF6XkPY2I3LkbkC85?=
 =?us-ascii?Q?AVdPvmjGiC3bYB5RU31HJvtW1tR63LOX8fHqMhTRQzJlmgqcfDs4zlm3nCOM?=
 =?us-ascii?Q?n3Kg+CwJ1Lod5wy/ZzCI9aOdxg9bcwx1CuNKC63wfg77k37FgCHj0BJ3WM4K?=
 =?us-ascii?Q?NO1g+3FSiXpFnHvscfVebT4Y8F8TDOtSnWMbpqYQ2gp1bqoFcQ+sEsNtrcRD?=
 =?us-ascii?Q?bwGtSzx6M22EeIpw3zfHS1GnAY7+fV40ebLZcgGVMpMp1ehkMhOysgauO0v8?=
 =?us-ascii?Q?StdkfQYb32WNsE4WBNIti4+/XU5ygZxNChqlyTId3wWQWKva4zrWiqQnECbD?=
 =?us-ascii?Q?ttfAXUBQRZiRjRmACAAJ7cDaWtejNgZjYYC8VXun5f3j1KjTXG/3VpZJyK4j?=
 =?us-ascii?Q?k59LHQ8dIz6Oy7WcGL220jHOUwrpAgPuAmVKgZFg5dQplXCw3hkRLwzvGjkJ?=
 =?us-ascii?Q?rK51DVgBfLAuzUBVhLGkum7y/1Z566c4fuRdmB7Fd2gndoxjlh2axiKCrGS6?=
 =?us-ascii?Q?1kNOnqXPYKCscPLvDCOKhC/nHYtoHI4pGGgXAlZhHANdHVOadShmeSOfbay8?=
 =?us-ascii?Q?t3St1X256BweVJb7bJO18uAAyuW05Blq3VAGWZxoDWABQoLg08wybHYTMULs?=
 =?us-ascii?Q?ZeevJ9Y8vkX0vDqWJl53uBdTxjdJpklSvH6oIX3XAlQmNm12GswO+kRqz0Bx?=
 =?us-ascii?Q?I5nhwbZwXEUKfiFiZivPXH13XSwSZa9p/dY6Yd3RoSgbq/HutHG/FEe/Bl4I?=
 =?us-ascii?Q?flZ7OFlLkcioi9Wm1O9uBYH6enuXbzvx7CvRmr107JjP8nPFSYL3wETW/lry?=
 =?us-ascii?Q?F45k4q9DG7HAbUiTobnyy+zAeBT6oTSMY1Lzx8V+pPGAwRGRF/ycmpej2hm2?=
 =?us-ascii?Q?XRXpwbKMvK6exdkDdL+nJf0ZAkajTTffgp1L2EgtgfJRZVfLPdRBxndIfCqY?=
 =?us-ascii?Q?lu7iQ0EmdjY1fNG0n2MALz6QbfjiGGpfFO2tIFZPBKzyfvNtZXBnwZsgp1Ty?=
 =?us-ascii?Q?PHckgsok8b+YI8/wUSIWovsp4s7tGSK8wXIjOvQc/NNLq2vvol+tGWLGoG5U?=
 =?us-ascii?Q?TqoXQwdNWu3w6t0UaPKw/nUsu7C4Co7Lsr/bB4jAxp18Hzvi8pC7nO+0R7iI?=
 =?us-ascii?Q?HoRv2wTuPPocWzbucjCftR3V2zcmXhSd9gPzM0Mwe+xXlKvA2cwK20zli8KS?=
 =?us-ascii?Q?lcxxNP+aTP204hbz+EKbtNpZn20AmON29Kg7kaIvxeVmHRVS1bxtul3J3zaW?=
 =?us-ascii?Q?JaEpP8S7vw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b0af07-598f-477c-0b6c-08da43b34c66
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:18.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q11NyAG0zeOKS425EJG9UagHzNv+nfusj4UWbi2hs/3yCBGdla/G3NOnagns626ECS7b29PekrwqsKMqlWYk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect paths for i.MX8MP media blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi |  1 +
 drivers/soc/imx/imx8m-blk-ctrl.c          | 31 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index d9542dfff83f..2a1c6ff37e03 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/interconnect/fsl,imx8mp.h>
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 7f49385ed2f8..423cac0c9cb6 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -37,6 +38,8 @@ struct imx8m_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
+	const char * const *path_names;
+	int num_paths;
 	const char *gpc_name;
 	u32 rst_mask;
 	u32 clk_mask;
@@ -52,11 +55,13 @@ struct imx8m_blk_ctrl_domain_data {
 };
 
 #define DOMAIN_MAX_CLKS 4
+#define DOMAIN_MAX_PATHS 4
 
 struct imx8m_blk_ctrl_domain {
 	struct generic_pm_domain genpd;
 	const struct imx8m_blk_ctrl_domain_data *data;
 	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
 	struct device *power_dev;
 	struct imx8m_blk_ctrl *bc;
 };
@@ -117,6 +122,10 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	if (data->mipi_phy_rst_mask)
 		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
+	ret = icc_bulk_set_bw(data->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	/* disable upstream clocks */
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
@@ -228,6 +237,18 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		for (j = 0; j < data->num_clks; j++)
 			domain->clks[j].id = data->clk_names[j];
 
+		for (j = 0; j < data->num_paths; j++) {
+			domain->paths[j].name = data->path_names[j];
+			domain->paths[j].avg_bw = INT_MAX;
+			domain->paths[j].peak_bw = INT_MAX;
+		}
+
+		ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to get noc entries\n");
+			goto cleanup_pds;
+		}
+
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to get clock\n");
@@ -647,6 +668,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif1",
 		.rst_mask = BIT(4) | BIT(5) | BIT(23),
 		.clk_mask = BIT(4) | BIT(5) | BIT(23),
+		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_ISI] = {
 		.name = "mediablk-isi",
@@ -655,6 +678,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isi",
 		.rst_mask = BIT(6) | BIT(7),
 		.clk_mask = BIT(6) | BIT(7),
+		.path_names = (const char *[]){"isi0", "isi1", "isi2"},
+		.num_paths = 3,
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
 		.name = "mediablk-mipi-csi2-2",
@@ -672,6 +697,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif2",
 		.rst_mask = BIT(11) | BIT(12) | BIT(24),
 		.clk_mask = BIT(11) | BIT(12) | BIT(24),
+		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_ISP] = {
 		.name = "mediablk-isp",
@@ -680,6 +707,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isp",
 		.rst_mask = BIT(16) | BIT(17) | BIT(18),
 		.clk_mask = BIT(16) | BIT(17) | BIT(18),
+		.path_names = (const char *[]){"isp0", "isp1"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_DWE] = {
 		.name = "mediablk-dwe",
@@ -688,6 +717,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "dwe",
 		.rst_mask = BIT(19) | BIT(20) | BIT(21),
 		.clk_mask = BIT(19) | BIT(20) | BIT(21),
+		.path_names = (const char *[]){"dwe"},
+		.num_paths = 1,
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_DSI_2] = {
 		.name = "mediablk-mipi-dsi-2",
-- 
2.25.1

