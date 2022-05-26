Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1609E534F40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347477AbiEZMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347386AbiEZMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:33:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6863A46C;
        Thu, 26 May 2022 05:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9SjXiB4jexnX3Y+Br54t7RbH/IrY8T7KyKwSDncaGqpOFM5I24/EOMeEcIPRnxQs4l+HyeMqRwntDiyxv+xZKPkiOjYx2YUz0WIDoZyM/EyYyJpdKzP+0j0yfX2cLOIFsHE1rzTD8GD+TZhfThuXMUnCsyYem9gJrZBjA84rUIITTQb0SRlyk4VGBAyrLfI9a8xMbGypvi2Ak6xCCAWp2YazouLlIdEH6mwsDvQS30luUufiqTy/EdKgq9oPU3jR1XZmtN9fzcDCIIbzIfbVGLo4kOObSwjAig2epJtJx0fQv9f+ReE1dZThjsXcw2u0zH7Nm4pbriwW+W7qMeeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXgwknCxgnC4sPJlycjjKQde5pOXYa0eLqTitX+1NVM=;
 b=Mvm9JobClanhhFSf0VMq8Lqa4KPpy80O4dTQVQgwbE4NLYvrIuNQaE4bgQkMnK4IBvGylTE+rianC+Y94j23DtB+pXwMKJbVbyMDIfxCtp1z04ss+fsozIjawcNMNZFps7S9c4/pfcajnudfotR7WAnIgyxAuH1Eaci7EN/OdaMrAeXHBoBG5/TUib7/hiQcMhhBASCYV8tywnd57aYXiRNvocoL782HduMrTdoYDsKJKohcRcje1Od9oGcwAdKaMCzItqySRbs6/xbna1BTGQeATssYDoQXeHMj6luNexW4v5w4kfI1ebt5zDnhwSyLNwx0H0NE2cRKoVs4tmqIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXgwknCxgnC4sPJlycjjKQde5pOXYa0eLqTitX+1NVM=;
 b=ZyAAANHNF3P6RwHAo9yLIIPPnffpIayRgrCGZ2T1/qMMuSwb4lcSb4yKHw0/cGhtsRrrS/v8PHJb37RkELO9M/Xf3U3xaaLslBLLg+7xMhkc9FrCqmKPAk2UFNAw5ibTXfpJR6rhE1skL2PkyIEEyRdaN1/tBHCRBmWcgIh+hHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:33:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:33:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/7] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Thu, 26 May 2022 20:34:11 +0800
Message-Id: <20220526123411.270083-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 226b3bf0-cb2d-4eea-91e8-08da3f13e181
X-MS-TrafficTypeDiagnostic: DB9PR04MB8363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8363F78FC77FA7499361569FC9D99@DB9PR04MB8363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdxS9bM2vEA4H0YhDOrNETj7f8IfNmDg4ud/yHSEWW+87ezxYNmPyIzz0IQ+HnB0N/R+ZJ2e/MVrgsvAxC70K0MahpU+021Ep3wUrpWsUpxICTxq4bcbd4QrRjL5x5LRZp2rMSFiEKvDW+GlxSCrt1MM10zGhTv539WuS4qVlwEN/c3UOxunJzzENAU4tRcj/40C+dTUY6alv694AgIl2A6GfAWMCnUAZ2dyVSrzLW/RGr7EEj1KCPHoFPszbgMrLHSwUZI0wOy9ClDCGRNIWce/dWLDC3SrV98y6Z3pwofSFj2niV/Jf9Qljjk7D3iI3zNbLS8RS7S9xbYeZnVyS4wAbpKC/+HmziLlyZInUmd40mAfKpTESTirF/Kn/rQpq7gOHLOuAT6CBOPy9/ZjiFcXkMYt+jtgw/ZeUnxHiO6gmzMMXaOk6qdJWb8blB7QjIXzOFLNWloSevoOtnaIx84BTqPXihRnsTki/M0d7DYXTq6u1Z5qVnvcl5XVN1Rfmlbkw7fFZXrGiF5TXe8GpGd57XiyzLUalPHCx8NI/yX6oO78uoXEkAJHTNwiIk5kXhj3XKy+Wy+EePzu9wl79JlzrcATeXvAOS0hnuIc5v8DDsaCMu7iy7zIgFcXowszpJH9czxST6aIbMm+QD288IndaanuTLFiqZ70J6PwRTTgMsFH+YU1RBR4reVnvW2cVtw4WNGrypP/otJj73Zr2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6486002)(186003)(2906002)(26005)(6512007)(66476007)(66946007)(83380400001)(66556008)(4326008)(38100700002)(7416002)(86362001)(5660300002)(2616005)(1076003)(8676002)(316002)(8936002)(6506007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ck5YCj+Kt0oS/eGWzWLKc7WHb1ZYmYWcFChL+V/Z/VZUNSPs8sd9ZuQA0lun?=
 =?us-ascii?Q?m4LRbE7XjGYNMIRQ3lOjyWgdDlW+4AA/5vF3VvzBGOE3rYp0o53r1SEVt8gJ?=
 =?us-ascii?Q?V6RUvF6lUSLRFVTFP7ngHSpLt6HuIbTHX5O1XXQq6qkuRAlANstEGGaSouSI?=
 =?us-ascii?Q?mgNYFZ+gd/UdyRWXl7lsF9Uw5zx624ZpaAsy+iXkUyIla2I5SJ0VYnBlxWRq?=
 =?us-ascii?Q?R5rk6N/iGuLb7XECkIxZgQhST8zFL9FwVsE2F8xDsNA684zDk7hZsaj68/WF?=
 =?us-ascii?Q?cgrFbBBkm4RCQg+hOeKDmmYD8iApfk0mKsVP/avQ1MfuhQjEI2Dw9wIijiAS?=
 =?us-ascii?Q?oN8h2NoV/3b1a4uh26s3w5g6D3cExOTwGV2vIoXnb7Q0FtYDparvUvNcvyCZ?=
 =?us-ascii?Q?fpYSQDTyBDIgYCWqd3eXnQyExJla/3Fuo6fGxD7C4EAPZqHglTnd11l4yX8s?=
 =?us-ascii?Q?uXqz9CtIGOdicoRmWHtw4OYQLPK+Gm0cIXdq3YkomTraOrvgHJZc9o4I6xM+?=
 =?us-ascii?Q?hQZvPXiEwBofNEOgnf+lX03NRnmNE1bx6KhkVno03L6kQnasELJfaMswPCX2?=
 =?us-ascii?Q?lWiZ07EgK1pA5q0PhUUquliQZhMHwN7+WbuQSLleU4ER9GlxK2w43EK59cUN?=
 =?us-ascii?Q?XKx6WvP1vl5nCELQ7B4jyW4tUkzsif0o1+obUciThkVo1PtssQM2Y3zhChyE?=
 =?us-ascii?Q?EGIQJlMGYfLEJDjhg/9aX1auwFIV3NZfxzm0FQQuu45/mS6zlkdq//ErcVJm?=
 =?us-ascii?Q?im7gkwHlIxiZxzbKFTtyFQNJLxRWhv7EwYvOmCsKMJ6/EeSpMeg1nDvKGS/O?=
 =?us-ascii?Q?u/t2mIE6j0D2AzFSQy/Lnt0H6LBVcGicMUz9WRmD1kntKIEwmO8WB4Faeyff?=
 =?us-ascii?Q?5WOuGhvhS1pVHg4+LlkDGXuQ48OZmBNa8CRC4h3dzE+qR+JXgJfMc3czJjpC?=
 =?us-ascii?Q?WAVPYlR14FcnLd5ZNSpNUWl2iFEfef/qhKrgKb037KRal2CJvSzypp0S/Hja?=
 =?us-ascii?Q?JiEMgNd1r1i1PnxLcd5p0GdkeWIIw0RpjEC4bN0kWb3GyPQqe9ld4cfPlzsJ?=
 =?us-ascii?Q?ibdGiRn3CYFP6A1X47x+yj9KD8MPaKBRj1qhwkydOKHvMk4JqjjQZjK7sHPN?=
 =?us-ascii?Q?E8fGmSDuX03blEMu6IU9nwRiwNgQzv5WAmVBPCfWmd/SZ/2L2LJdR0FPWRQ1?=
 =?us-ascii?Q?n6yZNtIgZWIecE84CZH0JPtlNfOljNHMSAXhyMRhCaK19Gjcp/j6/eFP+0lI?=
 =?us-ascii?Q?jPLYrSUscaU47BQvnWDSGiPi6MepmvUc99WDgWFVWiFuTgz735UFeKxiaunU?=
 =?us-ascii?Q?BT2Q8LykcEWIXBQ+B1N6QaC9o98SPxcO6tdnq6jZWPowfI+8nEOmIW2vzlbd?=
 =?us-ascii?Q?3A4wntTgDFLw0aDFT7zk+APurKXheNZej1151pF+WA4Cj7aklDUmJ7f9z1Rx?=
 =?us-ascii?Q?Mj7+BpJAeD+uy6Z+3cXXZRDlDSDnJOlIKF+ZVzz/SRa59rtld1AhiNWYKvBR?=
 =?us-ascii?Q?rgtCGN6fpjrZ2u7fhq1GXeYNMuP0AM7a1rMKM/6xNQthnluvYRS/jDsgsfz8?=
 =?us-ascii?Q?cmLoS58nZuAUXPL955wOHaUlRvlplbw34tPQLXjxFSDDaMESIY91oWabofTW?=
 =?us-ascii?Q?J6/6LrriHbVlFifMQPCqblCuhshT7OPlI71xQpXj2zR33SubStcKd45QToCH?=
 =?us-ascii?Q?oqcE2Qt5QcpYQylCNYlF7zkAEMz6M0AXsfk/042kfrRKUKTasX7scHUqyw74?=
 =?us-ascii?Q?RKq9VHm/8Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226b3bf0-cb2d-4eea-91e8-08da3f13e181
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:33:04.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxMhLlU1SeUITmF9G4hBYy6FM/3N6rHf7SPJo/rAcmIH+HMHP/2yRZI7rj2a9cC0uTtvJV8hstH1MtKzGDtraA==
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

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f7d4f769db00..493d4be710e7 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -348,5 +348,25 @@ gpio1: gpio@47400080 {
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

