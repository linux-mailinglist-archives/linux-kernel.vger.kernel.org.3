Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569256D4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiGKGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiGKGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2318365;
        Sun, 10 Jul 2022 23:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN/LjUT03De4ivvUoR5S8k46i2dGe9VJ50BrwhEOnTPZ/4Gi8k5sUQvmmAcnp9Loj1abnMQgeT3hr+O7FFyXt+gUbNcPqMtDd7b9y00FkFGO7ioth9Iy8105B9P6VK5FH2IBYzlxTcDELrk6Q2eWgaedI5PisEliItKPuWF5jrA8b5tGIu6CJ5lZeoooZcYP+Hi0NcbwjfrVrFeXyM0/XR4RN68jC4xsPC60LmqnIHLaOLmBxRVhHW11kGzKWYdyBCJDKFWzX0VbDBy7+G0gOTkifKseNvIkpmVwm6jNuKyzA3I5KOdbGyIfuyHkF7yO9CHZJJfiL5js7G+rvOtupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5bdDglt1tblNlLtRJCdYhFCcgZcKfaN0LdTUoF47Yo=;
 b=DEHmKqVdhewCKD1pjTX+c1tuDmT0aalU+eFYDk0RrNeUc2aNoIfPNUEZk8ouSO+E8jFY+vgKByVcZRss0NOeHqkrPfZpBp1sY7vl6wA8HAJMYp1/uAnpm+pjw2MSHBb7mFSkDMaPWm7KLPlrSxicvGo/R32Drs//lT7GNGqF0Az5IPQzs+KREmEXoEzOP1yboZZXeIRl/LYVbLiMqoLdWCDz041BWO0lXXPycSlmOu0y5CuK4QMzFGN2CTEQlDhsGa8Ct4Y4D6NXT6/EbikFnucFJ34US9j/VnlGcgjDx7sui7Hvbc5oP713InudnvAzEZC7cd6YXmn/PQXdotxeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5bdDglt1tblNlLtRJCdYhFCcgZcKfaN0LdTUoF47Yo=;
 b=BtY2s3ynXDy7JCxGLQzi/U43BiqLcCbiaP65owpy9YO/b6lDI8USQ9sCkBIbgg0rbQ4GWTu8aMF0uv91SLUEwT9Lpc/GNi3xKPvOwTahxmvwrgbJShZbaSQecXCsZx3vc/NYl7qhcc06GIm6aXQQgyq1FB9MpPMeef/AlqPsEts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 6/6] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Mon, 11 Jul 2022 14:24:52 +0800
Message-Id: <20220711062452.3575032-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334a147a-81e1-463b-4f88-08da6305e457
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2UTU3HlNwM8rHFiiv9mivVf8qIV1SIcFqv1798f2OY+fJ4u+5daUOPU+nzb3/YmNoRXdMTBtnoRdUwmdl46CZd7tQA497pI4fuebrFaaUo/cO0A2w5OOY5JeU0fTrYaSBCl0Cge03aYc2v1ApfQ/XqubI+Q+asOpXRSqq/RiNV83ffiSCY9jfT+LW7ApvQh8vaswqKo3NreTCjALh5lxNL5Fcu5mErtyHGb8EvAT4mYejluOVLmCd5abs2QLw+7QxaZb4mm8eXAyv8W3V8Fg3p7h7jHoeSKbP7XVPIjOTsCbX4n2hCACWsTKysIY9WRkgimfdzrsnPuke+8CkQHIqHdGUFeHJbX41UnqOrcwRfsi+cMH3BDm2w/7fJcswp/pUZijdstGSGKntQFhRwO0wexAaWbhxFUfDw/n5hF1oQXlF3Q5Dfu6i5Q+FfOXfiiqRMF5x0VWs3qJDOtaKjTGEllMaeYQz0Nl0VNsFNPj35td12QZZr7KuH19X5i4lWu5J/crtBQktx7sPCygWwStOeQ2yDj5/kqOCIhzHzZ+3yB8z0bgr+e6jLRUclkrzMuKWju7VnGpPnmqVDrxe8Op+MbbXTNpuZEfFAbEsHt1MgCPwO1i018pKMl+yncoT35Y24IaJq2EHq9JF1sTG7mP9tJ9yfhW5tZe458vKealrhuQ/xmpBXpo3Zdxv1MZEQQoNy/moH7jb76D22d8ula2ljN7+kdmG13FfYiXWp39eMz27jVc6ef5Vj02VM6fsK0R+FPa9EeoN1AgfsNOKXgyuGwBFfEcuZFKTenp5fEfepmdR7EWhVDXhVWJBsEEAV0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5Gb/iDDYMh+4zbdUkHZwOoRXMUk96NyXaHUsCdzU37n+0eyqav92v69juvo?=
 =?us-ascii?Q?+owgMA4LfEX3cX/tIkIIxppvpwdk/xuucQ4qu/71bVNdmj7PN2LfXYrLE/b7?=
 =?us-ascii?Q?puyfYF9Hmo/LY9kAR3ErePrdifCzsU7v36WzjxgMx1JGsBdejXpodEyjUPVS?=
 =?us-ascii?Q?A7LmO+bqFNdO4PKwTd95Kgmehu0pmjQsQzXjw3XcIO7efmkqscg34su+dP4T?=
 =?us-ascii?Q?MXuY39GXOL4r0xIodXE/2MdpopHkqleRCcDxYBIfeTZh9P7SmqkZ6Vync/4s?=
 =?us-ascii?Q?Mh6AWet2tVVwS4diAVUcnfu4ikdptHVUqfK4n16mqp2dopzjRo322Ay6pXd6?=
 =?us-ascii?Q?K8ws0uJDsbvGfaoDbSF7RBd0Oj+fWrv2Few8fp847vgukVupHAgP8LbVz0Ur?=
 =?us-ascii?Q?t/VdCB8RS4nyHT1poOmJGXTa1vj5Esng6vGBg1brdqn86KZLuezFOpmndjdN?=
 =?us-ascii?Q?6O0KJd3EICW7WlryoTgfLj4wdiM5TQLkg//0zex2SPY+urxqUSB/L62GzoUe?=
 =?us-ascii?Q?z3WrsMDx7pg83Lkqd/pXaho4MXg8HVlSFFJpKTI0hYDiWhc2rE3a/0l+fh/N?=
 =?us-ascii?Q?HhDgWrZ8cTY7Wm2LlRDu1eLdF0TM6aGDfibvFXTKNJ2nWwXky4S/8kYTZ7r3?=
 =?us-ascii?Q?+xBFLFBlO2ePVuSxAfp6W4gPSlPGuyALleVA42jBOWTlW3EqgF94iWB49S9R?=
 =?us-ascii?Q?XhTALs1UCN8MfC8xWDYZBAOythzzbfmdzL0jJUXgTqZb0kv3C6LE/6/HbCpe?=
 =?us-ascii?Q?IF1Vk7MytNLR9ZRh4h1L4F+Fv5Q2OlbkpYnt1JfFeadetB96deuiZzbhPaag?=
 =?us-ascii?Q?DXRBk4MIuptjL9zaf75EA8pGKTiDbdM4TFIY9H/4fCwfElYFXspEgUnBBsV5?=
 =?us-ascii?Q?uOHqwvpo6M8b6twcu6h1BqkygF+2hO1+ISDPBZ6CASde4ohTEy07N/FjFKcT?=
 =?us-ascii?Q?8V2vvVhYoOb3adeIIqkGEFpaZYKgz60A1Puu5lTW51QO6zavxuk8sD0UJQQH?=
 =?us-ascii?Q?jlg0OyMC6DRrBsabLyWhcHwMKYs5HmdAKHN/MYO71QCob/jmuwOr/Ei2OyJ7?=
 =?us-ascii?Q?e0LUkbeGrFWxfDkEnuM8xE8azqE2nWIO6AJlSe83nvaITqVapduPZXW5iWq9?=
 =?us-ascii?Q?3aFn4DtU9VsygxtkNnGErwmg6VTigSzZCTg3feH13HM+y+7h+yqHz5qfiQSW?=
 =?us-ascii?Q?nkSVYdwGX0o7qAoOzJ2XiR23C3eaJKRBVWZf4+SUo95LV63JrlOEut7thK1O?=
 =?us-ascii?Q?CgOGds6Xx0rM3upOph3yS3ruxINRwzETmjcvF0gdoDmhpo7Z1P6KLnyIDK1P?=
 =?us-ascii?Q?P5A+ojdHfRnwLHkOQpttlf2F+prL89muM0h4lo/o0z0Fubh0wFl8CzlASHXQ?=
 =?us-ascii?Q?8vJD5Y/5AzgGEU0HNO/nB8ca0gA3qX0rBHz8f5vwKNQhg46049u13BfAcJfu?=
 =?us-ascii?Q?Rmqk3aLrPMSuAHqMnroMKRKIe8Eg8XEKx134Q2PxbEwhxddYsjFXZ1jIdp0f?=
 =?us-ascii?Q?f6bMm431+/BjC9auxJdEj24gJZiSCC1qfLV95zDYdHm9KtB+lwFJHJEl8mI0?=
 =?us-ascii?Q?HP5YZzOEdKdwooVYeXTWUteIatZBJMVMRXHUgHN9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334a147a-81e1-463b-4f88-08da6305e457
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:38.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL1H3dOmx4F8T0P0slW7w0fFfF/0RWr7D2Knth2ubKxgvjrtld6Nj69Qp3nuSUMVUga1QNWBjSLzc/sl9QflHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 883d38920db4..7b93e5037a27 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -346,5 +347,25 @@ gpio1: gpio@47400080 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		media_blk_ctrl: power-controller@4ac10000 {
+			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+			reg = <0x4ac10000 0x10000>;
+			power-domains = <&mediamix>;
+			clocks = <&clk IMX93_CLK_MEDIA_APB>,
+				 <&clk IMX93_CLK_MEDIA_AXI>,
+				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_CAM_PIX>,
+				 <&clk IMX93_CLK_PXP_GATE>,
+				 <&clk IMX93_CLK_LCDIF_GATE>,
+				 <&clk IMX93_CLK_ISI_GATE>,
+				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
+				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
+			clock-names = "apb", "axi", "nic", "disp", "cam",
+				      "pxp", "lcdif", "isi", "csi", "dsi";
+			#power-domain-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1

