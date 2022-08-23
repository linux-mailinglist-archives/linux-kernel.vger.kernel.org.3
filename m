Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEAC59D0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiHWFvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbiHWFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:51:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB35EDFB;
        Mon, 22 Aug 2022 22:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJBIPNP33Ep1qVT4gwWgh1mz+o+pyH5VShUskAPNaJ+lzYy6sxTnTvP+vbkb/whslnyi6q6NVnCzyEyaZAS0Y0HI0YAvn38Ee9JM4yusgnMCGyvnB2JzxO6aWEEPbjjxSjDvSHiqjLZbplanKtfBEstblf6DS15rPt2Rk5IgZRGCYXmxV8qmLCdGymUqgrLR5b2nOjxYm3GYLDo2malxm2Z7e1x9zSM5XHyGQEWzMmOKmxfmCpf6eY4dCB88XCE8e/Tt9qtCMtCBq9U8WRSbaVnvCBoJ8HY5C5P6MAtg/f0Y8CHoAb37q3tCpR5WFglRpUUPk6o2//t5BOQm8uCdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWOpr5UGSlGjP/pOzDat3oTNcGbm6xg8m4AIGGc6u7g=;
 b=QLwinCLVYB2pJf2pqh/L/eTfQQYeSHWZbjJBgdFfcQTPspScdVKC2Is72Ufr9UWro5DL4rptLL0GDUK0N1W9Rj/c4vcLq8lg4NeBlYVY2a9HHwdtD96GgfAeWucmNdS26+Vfo7bVYS4dKwWDyjeZVIJ2OiVYzkcsteyvEYIoBeZqW2TJnxOwgTJ06RpieHkPb+ez1SawwfWWX+FhtmHvGwB0Uv8bNbfkCIj3DjO/FZExSRRCwcJN3aQH/OmCoB2Qz/0IHD5VgDNsGS0phjuKxw+gg/qHU+NbF+OyFlv6UcxmLpSCIELSbOucUow6a06Pcw48ZDfKNZgCno40a79DvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWOpr5UGSlGjP/pOzDat3oTNcGbm6xg8m4AIGGc6u7g=;
 b=H/lzjIpW3YC2DgIJfhb8m+S6sRFUaViLTKCwGNKqq3CSylE8zojw7VDLPmk5r95UoM8mtC1ouwUgc7EGXipcB5uALX2HDUGvX+0w/WkEOcYX1FUJqjm3XFy5d64G2BhcjvN0MDoxdbpZrkQf6zQ9fqUUHsXoooBCjKKV0KigxnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:51:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:51:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 6/6] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Tue, 23 Aug 2022 13:52:15 +0800
Message-Id: <20220823055215.1139197-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0969f4cd-2b4b-4685-8fad-08da84cb7538
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgSna0rilA0VubzTEXsvPcXABfKJrrwPShwJgX3yLjgsPWaF0NSENfQsCchOp63+TN/9dqv0gok1lIhJYeMldb+isVlPsDU/bM18+doh2bdR+G2re7KRDot6XiQAxccyHvg4Bu2OyUWOgH3335DYuR81Rjbogm+hYtPmlL6EHtTl0fz0RoJzhIObvKGDCO2yUjwdXAwaGdlEnzd7EZcCPo4c0+jv+6qCv3Jiv25zEsja9ykzBR8NFVX+IU6kLp1YNDkMuhqodfpA6hyaTknXQtnusg968ac/sTVTEwcvD65+QozoZ9NOMqw1TySrJpaE65eVKn/aCqrxstdLoDdEJ1ioCuHKdRyI+0ahf3NXlZRPRwEco+LHJ/F1UO6VVGS/wjog+iuHhYt5o0YXIO9NcWKTcXGwZCiz0IEEkcLrJIabxhOB4sG6UxkgfqPQVtGCqhBXQ/Gyt1TLNBYbqquOSFfmkLDWmP5iF4qNTV3afKZn7ugHo4uuNxWzCk9q7y6SAEBdx6l06PPuWcmin6BLWVPJjskEzkZlWTa0myul1Et6DutmSHJDayvLdQPq3yTlYnEEbuWnNx+wyv0g4SZh5np258l7mS2AnPRZuquBJJ2IoXyT0JbJrFWXuXSWbc8GTrwTDITWMOBWAhDJpCLD3D2gQgQo6PDSr5iH6xhbXIV8MKAu3quq1ZB+xhlzWOkUyqLgrnZDJLi9DGPHPTlulOAplRINx156hgf6GcWm28cuN+ZfweqRaGWu1VxFWMm+Zqr1+XvXgKcwNwlyYHSIsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(83380400001)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(6512007)(6486002)(6666004)(86362001)(52116002)(6506007)(5660300002)(2906002)(186003)(41300700001)(1076003)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75GGMCgG/MQ8yeVX+qkVrsVWeT4ouXs0zmJg2q77yj05L6haux5ucSOBCeQc?=
 =?us-ascii?Q?gbsqxl9vuom6MJGln8wbDKaZx7neAPNCuKquvTDfbEeSPwX02G/MbR5XFb00?=
 =?us-ascii?Q?5bc2VnhnGMNDP/3vyTbNoyj9ADvFb20TYFRxy2OFWkECGIqiCm5Yx9JN8F4z?=
 =?us-ascii?Q?ZjucOt5NT7dYTiTMv2zjs4YACgqzQbKMef2WWVXHFo6FnFuHUm0dJJG/74Pp?=
 =?us-ascii?Q?oacaf5CgBWLbrPd7UU8q7bolkuGTLJx6t3CEHhycoOjaaGbt2Wz6RVTVgNRA?=
 =?us-ascii?Q?gqWKcHO9XNjaMTes3KQZOD2aUpTvlQzu9Ii3v6QMg0zUGK5f7yHzVH5J05uC?=
 =?us-ascii?Q?Es+ifaHd/Dh0qoBUxwp1DUsoQw0pUjExVExHwm1/sT/zdQk3Y9825W6GSiHQ?=
 =?us-ascii?Q?IvYqI04uiEKxNKsw6nMthcXNberzccLoKfIDQHm8k/EpqWw2dnFhLxjf1yCa?=
 =?us-ascii?Q?MbKLfxeiQ+2UGDlDulkRcqz+aimcEz17hqSovpeCSwvc3NKIaeiE1OTg2xQM?=
 =?us-ascii?Q?qV0tcwbQV8yQVhBGO4qYiswIWN10S4ZvC4hmyeJMxCjYjlxf/dRxJN5p4zvi?=
 =?us-ascii?Q?dafVJ+u0XrsfZBff7u1jfi1nbbi9z9KtnUbnuXnoYtMI+C6jK5jqiaHh9erK?=
 =?us-ascii?Q?RNQ0fJD38A2IIrRAKsvkKwexsALN/pRiSfAApCk+6OxW4f17d1mHgGTzanXL?=
 =?us-ascii?Q?1jOxYdl4O8LxXDxjSMeqV7sHbdnWfxZXJL1QBr5Lohyg2JNm1iobK8y4pIFB?=
 =?us-ascii?Q?m8p1w1z5cURo8faVU7GgSOyxhsJv9DuhrPtwObn2QimSqlhBSIBMCSrC9nkb?=
 =?us-ascii?Q?vgqz49zR19HPJ4nf1fkAdLlfsZjhI2TnhRrBhkJRRQt5SUyDsaHPxrT1Olac?=
 =?us-ascii?Q?FXvcKJRPgFRHmPD66rJual7+YYopr/JK2VzlfMN0f/EKCiBVWDT3kkhWlPXf?=
 =?us-ascii?Q?hKNOrfkHRqmUc2lMBon9ElgqU1EeuffvGXwKwOfLAwzJuUAI/6lanYGx6ICd?=
 =?us-ascii?Q?m7VWR+Qih/7hEuAHZaCRCZHmDoCNNbqtjn6tnQFi42D16RlB0aYeFMV1ptcy?=
 =?us-ascii?Q?HgdMFs8Yvf3MhkeAfGILF6uSQDsxkenaN5UwBQWAt/e1bAiPjUCmAMr6ASr0?=
 =?us-ascii?Q?eS827jhYpcrFFGj1QGubNzQx5cLNitLzoaBHcYQJqXnC2mEoX4DLIQ6KHoy+?=
 =?us-ascii?Q?nOLCFLiKNrq89FAWLV4cetMs6+DfmRK77Kf49PV+syBTwsk3yPqQJKiWc+pK?=
 =?us-ascii?Q?1bC6EMNoW89S+zgHGhjBwLhFLC99Mhn2t+jGkg8mzzlu85eBEF+Wk0gIYsF9?=
 =?us-ascii?Q?T+fyMryk2HJs6ei5fHKqyhJwlndzP5BUAIOsbHBKb8Hv8GWzISyg7QTp3TwV?=
 =?us-ascii?Q?KYkReOx7rITIOYHSDtj0rp9VC9iA0bJ6NLEVxNZ/5ERk/C4md9Dvdd4MtbxM?=
 =?us-ascii?Q?jiRDaCs97XRmiq46JybZs1ueeTVKFH1AOBKMF5juhT554LKPksTGnAMtRh79?=
 =?us-ascii?Q?7SsT0/j5L0juPr/1bhn/x7sslfwF+YKmcnbzwBqx9/J4/YgA4Ta/EmR8rvNR?=
 =?us-ascii?Q?zil3OYRH9JTv2JkF1gdQAWScEcY349L3SjoKLgS9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0969f4cd-2b4b-4685-8fad-08da84cb7538
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:51:00.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysvLZMRCAcIrkCDhhaL4kgvnEdCrgPDMgMgDLQYlCsIPlSHlKSi7RwjgfnBOp6fv4rbxEGkOuqDc2cB4PUNfuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

