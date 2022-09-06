Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1B5AEE0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiIFOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbiIFOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:33:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE698A5A;
        Tue,  6 Sep 2022 06:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENn+MW2pLcNeGsWYNbYDyZAKwMCiHfVYuJftBGjiH261gZPV7etbgxLwLouMeH6ANEvGHwLs/Yyi1GhkxYq0pQXfA2a7+LSBIflaVVLtOHi5aKP0pmVgHrNowVk0tZP/6hZ817yB5rcBGNfMR1zyuKnBQbEF4RQHq+GMXRoSSHs2Y+FVzxy1S7rEffECDKj7zZpd9wJ+UAxlQfJ/zLE9QP6szsyW0uoxMSUVMU9YwLg/7Gmd2ZpFsEkIaweWlymG/9kHswYU6g8RwCHNZ5jpGNrkLGhCdmPFIXohuo3Uo+jWrj4n1kbYLN7If/DYjC+IK72er4+G0dRICDYqPYyXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=lZpMmGOkI8vYrzjMeIURIGhx3jZxcBW6ME59fViNf6zdK2ZJmy18DoqJhH2XjpkU72R7uxBBnvohrQvI8CCZPcv69E/CPoVYytxfj2mvf+S9FycDtoBFK34+0C+rr+AGL6yBtVP7Igldj5/BFmlc5dSiIcN1U1tFOI/uz/URD/fD9dkKRHOi1PhSpYuk5IysL4c2PDPlbk3vMHvQCpeuCxo/cu6sdIwwrsfdcgiwlbeofmVv3j6X8jGZ42TDU8SABdGj7NeM6mMA8qdbC9OT5kRoOQfBoTe6qyQfHO72GvOK2STpbPkqVDYe0a0RvgC3tG8Aq58Pn1BbBISMSmBVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=CoYGUH9fNOm+YlT9fpSKnsUBPkLe6G0JSVLJBjqqxr4jYM5lueadEKIjJlf5eW8SrA+vrLgCRklYBvdrE+CPKxlHI1BmOeJAbY792il0sYijwNP4o6cHdFxEIp4SmL5CesDJHNiMSHMt7rT3RoWfsFJXHMLXKK2yIztHLTUN21s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 13:55:07 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:55:07 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH v7 1/3] arm64: dts: imx8: add a node label to ddr-pmu
Date:   Tue,  6 Sep 2022 08:53:38 -0500
Message-Id: <20220906135345.38345-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135345.38345-1-shenwei.wang@nxp.com>
References: <20220906135345.38345-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c608e7-8ebf-4c2d-bb8e-08da900f67be
X-MS-TrafficTypeDiagnostic: PAXPR04MB8749:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddx6umDuTWUaLXhOBoEmhEATEJqgJjB4HQBvqUdsVTz/zsAjy80sphe8Xfs43xLQfML/r4OvWBHSsx0JRxp5mMylcg6He660sPEofO7LAMm8kS1vtsY2wTdWdiCcKxXZJ/ycM0r+u0vO+YP54NHIkIt1fWy2t0N49K3Fuew0S5b9O6d5PjTxHSrd36DkB0843GpYwZ7Wc1aYi+A/ueQ9H0rX9+jceq/zU7oX5jooR7SPYRZ66XrVmepCc/sDjE1zpMuyE0VKiTiEoFVuEjh1R4D9DRwCuHpPCrL2TovB+ymbS2x4aVa2IwMcc4BtzbJNJjig1azVUlNkx/LqelBX2+SQdYmkIrYpTJ5Wv/cfTYYt7nPGsSGH9gb8MAh+bIEGaQhDiO2BIapfxyD5fKif+sptiTZ/6TLXLKDti70LSm7mClmQfyloE0EYL4P4THphtdER82xUXl4oYZlneqpuXD29F15fgdPnoijzl8ikQ9mSJGEGQIIej0O8o5DMoDcv6thg5lF9x6a53OTRWss6n1cWU99EfVEzi7I9kMrAd8PaYtZ5Kk32IBSqfpVZ/V3ldJSqkGB7P9ezEr7QbP+Z6CF+hUpnBPIp/0n+E4pt99LQx4wAyaoURebcjwGd+j0d/Nk2t6LBe6hAiGNTcya8KzC9bwet5ww8vPoD7hcII4l0ubgOhBJ82QiuRQ0wOSlbawIWwDxw2Ji1RIcLK9LJORoGueWB3ia/S3JPcC9xnN3B1HsoFkUWBe6qS5EpRyWe9uv+AigqfhcpSHB1fuNTtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(86362001)(36756003)(66556008)(66946007)(66476007)(4326008)(38350700002)(38100700002)(6486002)(6512007)(478600001)(6506007)(52116002)(41300700001)(83380400001)(6666004)(26005)(55236004)(1076003)(186003)(316002)(54906003)(110136005)(4744005)(2906002)(2616005)(7416002)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLib4lGH9oQrPjh007ehhwbdSU179RQbbt99IccZ/cRHbys7hJO87n2WS3RV?=
 =?us-ascii?Q?oq2FFjw9TX9DTDjJ3OQyaI2wM7V3nCuL5DhpKm/RZLEGFd649rxSt4YVn4Do?=
 =?us-ascii?Q?wX/JXphnpmpwAtSrxnnT6ufOtCF4REYT4JLclNGmYClXV7AAwASuuN/jLBzp?=
 =?us-ascii?Q?emTD6hJnLINy/lwcQIIzFcLhKLvL9iS792qiSjPw5ClAIvMG8yDMAri/pjOG?=
 =?us-ascii?Q?9tFYIbYg876Raomjd1v83UCNtnC1yQVzYuMk5oqJQ71TdJacr2JbFt9PN8Ca?=
 =?us-ascii?Q?gqeYZ/VG2YYxNdy5mD3j9uUwwmFAGN3yZluU8kMLq3FyIR8VVDCxj4asdd1O?=
 =?us-ascii?Q?nrBdR+1wfydZ1gj+TKGp6Phy5YWwbHB9rZ+hWc5CYUn2n4EkJz1XPIopw1gV?=
 =?us-ascii?Q?xJr5oe+VEBrk8vMIUELD3UbHawKeuy08zuHDmIaOPnGIF32COe+GjjV2k218?=
 =?us-ascii?Q?qa6PqgZIIzthAbiHRoGRA5F88NL5h7p6ddxlKHNo5Wy7rQZ19l3vyx9cXdd9?=
 =?us-ascii?Q?RSOfdtd2ZiybBslwoT0EeXASQZ/1JY/1SfRlkQyp6cLR1zBsgW3rJW3JitsZ?=
 =?us-ascii?Q?zOPDiqcetZ6n3a7hGjm5XXKzFGnEGlQslBSfRMt3+eQ5CJil/YiTyCm3MbI7?=
 =?us-ascii?Q?NkMlunvcxoxZp8XKTlkgpdXYa8Qp6nB+28dyXR67cbEX58wbp97TOM6jyoba?=
 =?us-ascii?Q?k9zFseh4HkrBIMziyrHoO12J3/B5Viy49Qna548qquuZ1rvwWjyfmbQXzA8P?=
 =?us-ascii?Q?5NgaVHyA6xxa0VK1Ednc+Y57FOUtBIgBeqTLxKyZy/MWV2PsBv+tAKzU6Jp4?=
 =?us-ascii?Q?qfCdS8W0lVyQMUdQmHzIwwkZcb7VnahOUE3PIKBLhqBt9wGgsW05tozdwOyk?=
 =?us-ascii?Q?jmam9q9wXpNNFrrr+3ZZkcONrNAs8vMGIJnGk31XojvJZQ29Ibww6vpaGHaS?=
 =?us-ascii?Q?5gs5Iwy6MqETigzCC7rMAMnsUFGDkK7Rsi7N9UrLGVWvcrk5fFnbSItdZRim?=
 =?us-ascii?Q?6zHo0D7fCO4HpfA2YuqMddYdiL+sZvt6g+LEQ17Uhjej3V75j7lRrw/D+dhB?=
 =?us-ascii?Q?yLfu1E0gvjNQ7qSmMngpCxBGu71oGygYKHQoZXLH/ii0m7eAHRkbNkGdmW/Z?=
 =?us-ascii?Q?U99/9njlYp3aC+UCjOogFahvwBYk9WDdbE7tFSTnb4R0hW7QHbLJTfXJ8Bft?=
 =?us-ascii?Q?iUQbUjZT47i9cpHFU0cl1E6jP+5tJ0+s9St/yXaIDY3kGGzwk6T48xzzXBgo?=
 =?us-ascii?Q?n05R9awhZEtTQ97EV2+/91Jd+W5mUs8K/3pWvq1BG4SP0UbPMy0ReKG+EhvD?=
 =?us-ascii?Q?kzLL9MJevlFwtSlfprWGUF5bSUBiBRR8h+5zeIEwoo2d/Hx/IQu3mJEF8IAU?=
 =?us-ascii?Q?SnHbT/0tFGb5/9+upeKMpw7PU/kjcU9c/CbmrnWRTV2irjYTZ4EkSjuiF8d1?=
 =?us-ascii?Q?RFy3CeHYem/i0Zp2F62zozTB9XEPW4zdXQ1KklfHLpk0g3iHT4UdevaIctxD?=
 =?us-ascii?Q?rxMfiU1cmB237rZ8gej9cJvxQmXrs+qWACRbcKh7R2BWwW2X7nrvB6eeE3TA?=
 =?us-ascii?Q?2U/xBOZNFN5ZA9LFo3SB55ZXf00L4HvYS+Z02UHOo2FCXtdP6+6twJDRFaRm?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c608e7-8ebf-4c2d-bb8e-08da900f67be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:55:06.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A40ClMcJY+fxbO7oslsntvUVTdUQbPZeR3eQ0RGpoW4iDX3qEIV+VOh5aGCVFfZOy1gbMDoTlff19OqBsQf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ddr-pmu on i.mx8dxl has a different interrupt number.
Add a node label to ddr-pmu so that it could be referred
and changed in i.mx8dxl dts.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 8b5cad4e2700..7d5183c6c5be 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -10,7 +10,7 @@ ddr_subsys: bus@5c000000 {
 	#size-cells = <1>;
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
-	ddr-pmu@5c020000 {
+	ddr_pmu0: ddr-pmu@5c020000 {
 		compatible = "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

