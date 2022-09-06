Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2425ADDFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiIFD1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiIFD1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:27:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C855F228;
        Mon,  5 Sep 2022 20:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhfLCYmi3hxf3rMA8ezk+ItgUNRH1UtUeF2GlH6O67S62SrrcA+lJV7NIul/dGyC26tpuS1iUBiqXGr+/kRunHcupGoyIJtc3YnaPr+4pPiSB/F5SgRMTrdmZLM0ZVGwHcCexofEWA+NAzfp7LRQAd9n6be5RvAYXXLAPY+kI69pYijeoDY925uaoYG8MwStHOZINLpW8DT4W61pXoRbuSnYTp6U/HEmlFpNBkFqfoLPbxj1V/o1Tp93fPtxwshZtWdtHpgVXFWBaqMYUkkQpEk9ip2NkBcbSntcDDNWHd+yNqSAtG28ogm0fxNdRIQMEmEvKL5wKKCT9cDDxeR+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWOpr5UGSlGjP/pOzDat3oTNcGbm6xg8m4AIGGc6u7g=;
 b=Hs/sel7X8MF9o3e4X5L9G+vT+vLD8lu1IV+bc5IJlD6B2wKVVoEPVJfoFlvsE+IGPOx2oXjqqqJXl47KUogkcMs8REwl/4lfe8Go2sl7jE38sX3a5CIN6Dooi8LH2VXQ+P0xzBrQFLptwGiYvf4OC4NGgzGwt2gNTHGv0vN/sugzZMtw3lD45/kvRo0jKFW178WgYQF4G7yajRlElYmyPam6I5JXgxJfRgkNoTdSsuNdIPS3qhPDKUgfwh6a/dryqB5A7kmmsy/VcIPqZFMqjRvsJVrkJuYXsmn2nWzozoCyVRELAsNNAtsPrdS1fAD32onIWAwnDG7YYFhFJX+WXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWOpr5UGSlGjP/pOzDat3oTNcGbm6xg8m4AIGGc6u7g=;
 b=PfybNtgsD4d9VLIfned377Udg7HpBHV2kihf3KPsEh/2GR67y20I0DoMgUmRYHTwPvLLTpy2Fv44Iu87J2YDJ3yFCIes8SKE8emjh17BM8yPQ/qrkmF68MCWYKWxd2CI3zr2Iin9CDjNuF4kgXKUy95+4POikZjBnah+V0IIF/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:27:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:27:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V9 6/6] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Tue,  6 Sep 2022 11:28:17 +0800
Message-Id: <20220906032817.2090160-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
References: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7696f60f-ffe1-47b1-d7a2-08da8fb7ac57
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eli9cERpeH6pGRuLqCjU1L438ZczylJ26SiHjCqkR8dQZdc9Sr0PrWkZbK2FdERK+0ERpoNjmg+oB3hRPfdKPej0d4jeARDv+xBsIFdHOaI9cDb7Js+D1kikalRhBbeL3CsV6gHm9cUpQfAlL9UfrJ678j5lJAvGlDKGHEd13pSE9jb6n6FiwYpxomjjyuNWHyTZH9Bc8bvqo3Z2b2N07i2Vsmoe3dRp6TXIOK8NqW8Iqtdaf3jehIx6F2DxWYBlSW9RoZy3ZeP6JBmKkl/A55aAiRkezaDkbvL//KNx211kpGJDoD07hBb82i4soDfFZZE5o5td2GRwqt9HMiZsIAZiT8L1v7n+bZ7/OTaYPyff6L3ZoyulVDUtMnD7z0+bqhwSPKAPMuRpYAoiaeTd95Mu5K9YRrhF01VFR9NmKqzWe5tkEBxnpwTNvPMBFm7RY9/BGg4MfnebA6suloUHFby8sgzi4HItM6Tr1k9g8Jvodp2WL3WXXRZkJl3TY8sg0yupqRMbVElQN5wTjWQrYAjd/rpXUoEoLkjJ1+8NpmU5K7s3i8ZUYWyDb7H9ai4tElhe+hUN0o86t6ubRbOml5NMp0tS08rJdM6//6Gc9aVi+Z+iQ/CdrgDDYj2raU5JPB/tP6y4oTcnajaZBTzvtw1iWqsTc7yfqKDFxqtU6okp+aVibn15Oe5uJV5U0+5CTe4wi9PBZAmHWeEkhpn9WkVCa6b5FSv9+4YjOgfaDnfnOEsCLpcrg+O228gMXJlVLSAfWlSpb4+bFPaUgXEmIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(6512007)(6506007)(6666004)(52116002)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUppxJzeCHHDSwuqN6wQ4/WlAuEdrXTTCrAZd4xxFtnA6GecKmYLzQ0b7kcU?=
 =?us-ascii?Q?anqv18LPNtEILiZgB4Ki+CbxRPdVyUnd0r5Ax+ixLUaoWrGFQxciObH6/QQ5?=
 =?us-ascii?Q?H1B8kFMsOOc99MvpVHAPsIhG6UftcbBBVVf7/mIk+zXJDheBfD4blClFgBAS?=
 =?us-ascii?Q?l0ANeB5TgN2mXOyaO/y3F3Yumn+8NsD1KWzv7GoqV4s7EzJHPY/um4i/cAhK?=
 =?us-ascii?Q?1JHo6J5OpQ/k9ZtGBG+2EIDrtIgOpv6bRXjKXOikGWKLJ/4Q2wtNhITbpwRv?=
 =?us-ascii?Q?QZwiExpKTciIr8l/N3PK7eUbWBSZEP+GmBiJgdywVQFZuBv+zwyZe0REN5uK?=
 =?us-ascii?Q?1ZTF6kMHOftHSg/YoGphnqEREfEVaMYV8K6fD90bLx8YT3rlb/NiwHzSdkkf?=
 =?us-ascii?Q?ay6kOyUlcTj2G0FzC0+l8tMwMe8gexj8Yi10Rtg3xR6hdrkEm7hKEqc/3eHF?=
 =?us-ascii?Q?y0MinPvRc8it9iklieTFKo6RODOs2yts023QeZK4F8sDxeK3asU/3yVimzRt?=
 =?us-ascii?Q?8iKlrJwu7Sptwf30XuzYuBbnaN2oAzsy+c+VF6Ya4cgHSlQkehnmJ8Or0d0m?=
 =?us-ascii?Q?Ab/x6BCueSG4vCUhLbdOqSFKUGLR+ih+qyHPxLeh88XlbwHgiALsNFH3lRUN?=
 =?us-ascii?Q?C1JTIZzkW+IS/1Ok54i9LcLPSBoqsOxkPQy3JQAumq30mLa/ZKP9PZ57fOaA?=
 =?us-ascii?Q?tQ2f3lTzF4dhXc+m81XeQxEole9geQixMv3/Lk6fHQS8sCwKRwt3OasLwLoi?=
 =?us-ascii?Q?G6tPL4taZwJlSp4F4u4SsxTIkqZbD8DgkDErs5Fb39pQ8vzjIsFnQhcSrY6v?=
 =?us-ascii?Q?GH6S5M/JsXmkGfBFCkMK3oF9382xCxt4FfSYrWgo9US4l8vDqrqUUoK0RjTP?=
 =?us-ascii?Q?zlxhYER86paNtyHJllx0a8s0ubSJt0Ntdi4PfVCc1XJng78HGFoI7FO2um8U?=
 =?us-ascii?Q?1dPYJlrEXATTPXUeewKHt62saWua/tw4owjW2AEPs5CMY47pWfbh7E6hK3dk?=
 =?us-ascii?Q?/FJCt39FyaKOjCKl5Q9QuBYiOJ4Cbs8BPoxXaQxQ7VPEdLPqMIyrFlJGxK8L?=
 =?us-ascii?Q?pTRlQh6I5Z6N0Ss+3Ycmcv0UmfOPw6eICVijXUQVxOwuLIF1nFWfkkl5FIKa?=
 =?us-ascii?Q?rC9OZfnrbzyZaeH0L8BxgtZlWsWbNQhaeyj4eQtYthkjouWn57LquoW1vKq6?=
 =?us-ascii?Q?m8Nmg0u/6eqkiz4RgSZ44BSHxosRlRbaQIOJJ9P5xWuymdQr1aA3QJIiK6wG?=
 =?us-ascii?Q?nPXrHcBKxZBgKkMU0sWHJ9sJVaLFvd6iieoMRebPsFaRnhXLDmVi5QTQUW4O?=
 =?us-ascii?Q?vwO1aok6Cm0ASJMZSO7id2rRbu9hwD6H/oUUQGKAiX2OrKLTsnwb1S4RhjbL?=
 =?us-ascii?Q?WBB055lQi7bNCvIqpYhXnkmQwnsgi2TKr8qwC1QvDC3AsrkGGMJRp4/JnW3L?=
 =?us-ascii?Q?YGpz/uP3vQttgXJW/gxmmRpF67Yj45w8BXAy9I8FN752OLo4DG25H9Lh62kD?=
 =?us-ascii?Q?b5Dd4rFoXRoT4e98runGMs5L5RlGn3JfzKSt4CCbBYNameHIdRg9w3q2re3r?=
 =?us-ascii?Q?s/PuN8x1C2uY8DNwrkqNWuE0CTIV+8vli4cQBvrO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7696f60f-ffe1-47b1-d7a2-08da8fb7ac57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:27:06.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBsZp2YKTSd+Cbk9zVvsKByIkhRUKlW0OjRhRYH3xBHxJn671A/MiruDF76Cu6xgwvFBYfCAZEQG1QAe7xtt8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3714
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
index 3281b554ed92..0a29b33be515 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -354,5 +355,25 @@ gpio1: gpio@47400080 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		media_blk_ctrl: system-controller@4ac10000 {
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
2.37.1

