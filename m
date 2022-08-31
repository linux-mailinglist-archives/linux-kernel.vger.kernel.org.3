Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95D5A8023
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiHaOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiHaOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635302DB;
        Wed, 31 Aug 2022 07:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2Yd/KjU/MPsfob/JQoqKdRQBOcS5Nj7HKdrcXjpaDAMF1ep+0V4ZqIrwM2vZeN2+j7whb/TcTF/sVRzXE83RkgjtoIbxx+9cDrKKIQLiaz0kMEfwuWskS0IAOzP7M3CwzwVi5Y5ITnyPz8ZTJeC5nF9JQ9MEv6toXXlCygpvwp34lHcFiJzNk5GeXzt5Y3EvM4FItvK/9ccJvhLwnWNWR9U4ryXBR0Mzrqs1o5jS1czZf+Q3LcMK6QBkyBjs3EFpoxC0s08RQCoMiBsMxPzxowk/FkOFl/esrbJkLA47qjGaVVpkmvhFPqKAVbQftHhEzUlsWB+0ezMhKL4f/b9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a1p8G0F4r3km4INRRCBHxpRRRwbNRdyvfQVFnVfHAM=;
 b=n7beoOqOB+FufRI+lvZlQdDXo8dgPPomi1Dxove9CGWxZEMUXQ2j1cBdaWv5hibrFziKHp6302iNeAXwzr42FMYlQ7AEaG6rqMB3/f4OvIiMNEo4utsjGiJnhe6ffvNMaQK8XpGz0aFGVMgEsKRi2Csbdpk40tV29lr7nTu3Gj3K8Cc0v2iZFPyCqeHjDoC2USnCbqCV8e66FXwIXl2BPjwvHeSFMKXR8kGkrCY0gB7VNYvDWF2d/pQMOLtGXYho1Q4dbg5LjUwkpprDNLK1NEPrmYwzkmEk4DFdBjYSGoltZI83J/VEk0DmktCpU3/cbm8TU44JujTPSF7CY1dMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a1p8G0F4r3km4INRRCBHxpRRRwbNRdyvfQVFnVfHAM=;
 b=HN4g29VQ0bhdRdF5Ya+AufoA4grJvBZfDJqbEXbZqtzWERY+LxLaB8L4FjimGYuSq4xbEelqinGEWz+9BGIhmJ+TM4nBrufxhY9ZFSEKB5zQKsd/i5aGLNwm+iZ7Ny282AyGLOFkPUvnCPx8hZ++vtWR/NqyI8gGBKmdZsnU8Aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2394.eurprd04.prod.outlook.com (2603:10a6:3:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:24:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] arm64: dts: imx8ulp: increase the clock speed of LPSPI
Date:   Wed, 31 Aug 2022 22:25:52 +0800
Message-Id: <20220831142552.43393-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ab9ce3-597d-42a6-ed86-08da8b5c8b18
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2394:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD7fRsDFDb02cMO9tehuRn1EY1nNcrklqfsR7VdM/B3f6bMMPZFk4gZZ3nmAHoudPm4S9GDWj7NutFCG2zXonDTkMsqTv+37ArqVN28WeShoTOXN6tWH/OGsPI4f1ORsSyUYenXFFyCtBdOB5G8mSz+58hZjb5suFwWK9kvXMP7LP9H2ZmUWFwkf+gbJw10AAYstYTenZCMpGvy4HFdVhvah8Zc0QR4ja/BkzFRgz0n+W2Db71UsT4spcETLkk/AGHQ0lZA5Frlu1iOnO4ZUS+tZMdNwL5d2S5cbAHaII0wL435BdpZ+tyht5AQUABsUMun1oGs6bVJrnZYQ1CnsqDyG2u5hMvL2gz9mLqpxZshPLa8s/QQ3mO4Xtow8dTaEs+JjZDtrSD7O0JSARVVmZLi3+7HTUb50iCx3YVltEA+lB7TVmVJTLdp3QOZ/VRJRTmDzZUEvwNwiE7gL2IBcqjfS4nrZvsOW9xM+VAbGT9dJd1oIVbQ1RhR8U+V41NvraXw5+H/Bn+f2kMOcc6qtDOjRrtJJmXgk05rDloIebRTbCEsJDFamlaO6kA6c/3uAskuSbU1u35HMS0mSCTBGTXazEmJnbyah3oNLQh5/UGVKyPOCOADERZCwx0nHJDDho2Umcn4WETC3JARCYd2nl2LuiLU7VzfPlJGl3TRQbTS03ofr8qcCo7egOQGsF6RQpmleeeFgn+K1dEUe3TLKJgXWFCJEYw9RiVJfjWeRvxlI71m9/XPfG1teWndYjywZ6HZANCKzh1MO0K6BO8QmVTFOtmcwfG3vrZ3Eu3jqCrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(316002)(83380400001)(1076003)(186003)(6486002)(54906003)(8936002)(41300700001)(2616005)(52116002)(6506007)(5660300002)(6512007)(2906002)(26005)(86362001)(8676002)(4326008)(66476007)(66946007)(66556008)(6666004)(478600001)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THUgjLJj2NtQZXzSRZ4GevgYbA8qRWC01UhZ3FhRHKX/+c96g+HvGcwnnHgr?=
 =?us-ascii?Q?I+dR3V6KombwPVWEVH/TxfLHlsARpYlIwuAdl9N3d0ar0XAQKYeUX6MTeEV0?=
 =?us-ascii?Q?StEt4nf2IDrm2dSzbv4YXCya1SJgh6niIlqbW9lMliBDd9suj0GQHgo7RZ/N?=
 =?us-ascii?Q?mnjHHEVcIlv95gdQHYZ+18zEy7Mr6anZSmbZzuOEduE/igS6/zTMo/C88R4r?=
 =?us-ascii?Q?47oLTnIf+zaYhJbTONOPhjbkir11/4Exo9zWUNR5nYO4Av4GkkPDhLjmqM6S?=
 =?us-ascii?Q?EJJtZx2hfwxLJ22RDivBxn2iKS4ihY8L3ViZRWr2WZ+N/ogVDY4M2ARDO+lS?=
 =?us-ascii?Q?edXePwR1droH2dEmF68DehjR+8oke02ABKAqZ43ZixYBHyIpYGy8QJt0clZq?=
 =?us-ascii?Q?SfpE7ZI/FDO9YNe13sBvcRJM0Wy/1S4S5w52pNClR73/N6h6W9gc63ldaAcX?=
 =?us-ascii?Q?0IPz3AjLT4UzEzvLIc3QrX+5bSWWltLIzYoPc57XVI5ia07ZeeJ2ybY64kYM?=
 =?us-ascii?Q?XUzfi+ephbdQABlWSX0gpzQgfCLFFBb5xmYDVtTGLcL/fVdolrA1Fra8uYbV?=
 =?us-ascii?Q?knSdrx/EjhhaK3giHwYR+dYwGVMc4cxOsLUEspdAUL+qpXfcKZxHBZCaumYv?=
 =?us-ascii?Q?jiFfwe8Yy3s0XUgfZWySS+MygbDn5J2IvOm8CwAlp5iJxIAC2QV5cgstlQOY?=
 =?us-ascii?Q?VX6PrIr0xLcS0wiWneLYRwOTkcDGZriVLpVi1DsJqtw7aTBmwURjbVCV3tSc?=
 =?us-ascii?Q?sSwJCBUMxvjO6YbVaQma38ytFy1i+RBVgfQWuT1dQNwmoixJMz9YyZNlqsai?=
 =?us-ascii?Q?pHfEiW3v0ujPlroKmsAQ2bSoHq0a9BZdDfbSWOdZKNdHFFZzR2Y7o/4+MwhT?=
 =?us-ascii?Q?44WPZ2gPuRXdyLCYffiBv2A39rE9K//za3tutquBHzWzrHIgxgKNdgd8ziWP?=
 =?us-ascii?Q?IdwipWB3HjlSeVYW+2UhuCuLeUGUQXRzeizOS/cllNDrVPNTlpjlX8Rp+MEl?=
 =?us-ascii?Q?2mUH65joURkwLGk9aqISXeOHQMpeqZVQ7IH8RcadqOBCotF4xxWwGSUv49ar?=
 =?us-ascii?Q?ZqHtKpPc1nzIZKjn+YL8/kGpTsav5Flt/UG1ITFpJBbYlMDFhrmuJ6tklL2h?=
 =?us-ascii?Q?mxOpxxNDY6VvYPAyN2Y2S7HWvgPZpyRyBtvxy+l6Kuq2/yDDr1HE5/XqBni+?=
 =?us-ascii?Q?sJuqAz/HW3fdCu+fFJI/WqNt4l9LUpposl19qcP3czKHwm3BksKJnaqD4boN?=
 =?us-ascii?Q?cWEITdfc0bc1R+xVLzxXORDb/dhY4UiHflwXKriTIxinB9U47lsX9e+G6yhJ?=
 =?us-ascii?Q?DqEDu0g6VqD5ZPaHS2GyTH8uDHqL2wCn0s1HN6gY3HMuvCsE5fe9EoYGY1Az?=
 =?us-ascii?Q?hJD1/09Ozqhx30Y2SCCbNousoicpK9Wq0v5k5TCYKGrrCsr9DnB1jnqQTSoM?=
 =?us-ascii?Q?zmqdA34noAJd+12XRI+V7S41FjrRdpZL/glGxlFjZp8uaw7YKlzMUJYik0eu?=
 =?us-ascii?Q?o7707rOJC2J1an/KXwMarChPwRPeKDdb3Qx+UQRXdtH/XM8UZbmxAaHVOrUg?=
 =?us-ascii?Q?dP6vZYEZqo23cXYJXq1VkXIdnBGG0+kiNkKBXwL0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ab9ce3-597d-42a6-ed86-08da8b5c8b18
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:41.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jARoTnz6Td79wEi9r0Ijt8oLL9lyM1EU5RESZ5W6ZvgTWo9onD+YI8EOBLUgbZTx7EkZwo1byUEKf4vEqu4+2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2394
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

LPSPI transfer max speed is half of the root clock.
Increase the root clock speed to support faster data transmission.

And update the parent clock of all i2c/spi with IMX8ULP_CLK_FROSC_DIV2
which could produce accurate clock for i2c/spi usage.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index d95c0e9b15d6..06ce5f19aa8a 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -224,7 +224,7 @@ lpi2c4: i2c@29370000 {
 					 <&pcc3 IMX8ULP_CLK_LPI2C4>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
@@ -237,7 +237,7 @@ lpi2c5: i2c@29380000 {
 					 <&pcc3 IMX8ULP_CLK_LPI2C5>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
@@ -270,8 +270,8 @@ lpspi4: spi@293b0000 {
 					 <&pcc3 IMX8ULP_CLK_LPSPI4>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
-				assigned-clock-rates = <16000000>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
+				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
 
@@ -285,8 +285,8 @@ lpspi5: spi@293c0000 {
 					 <&pcc3 IMX8ULP_CLK_LPSPI5>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
-				assigned-clock-rates = <16000000>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
+				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
 		};
@@ -313,7 +313,7 @@ lpi2c6: i2c@29840000 {
 					 <&pcc4 IMX8ULP_CLK_LPI2C6>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
@@ -326,7 +326,7 @@ lpi2c7: i2c@29850000 {
 					 <&pcc4 IMX8ULP_CLK_LPI2C7>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
-- 
2.37.1

