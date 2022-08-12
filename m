Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B7590CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiHLHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiHLHov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:44:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0DA6C01;
        Fri, 12 Aug 2022 00:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoA9w7EkAg4gVfCjnKd5okgCybZ5ry1+wHNsJTKsruQ1efU0rZ0xc6tDbNabU9ff/4z13hFtkXd482cAZl155MptAp5X1bmjZY8swoO8Jq1CO0lfRASxaTBdQYi1GQyjgrLNjuJ698PmVILiql1uLaTxVzkoYkD6MsCfyHvuBZOnutZiMt00wIZWoebSmR2p8qyo6/bFcXgLCRW09KJQt1xF9HsBmyyJKpWcTWLPSpxOEZ/+ovaiTZtTeOYz/a7ImYvtfKZGaCLxeppMtVzkFDIG0w4m5gIT2T+RUawg0Klgb4JEiJ8ZO9ax3s4x3zCWAjgND0rm3HUpd64bEgBcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4D8ygwJdE8rdcHYmVYOhzAHgi0Ht1cjAxGCDfvs+6M=;
 b=oVAMvDLspaNKD+kIicN55zrqmaipCnfiMQCj9OFNXzulKYuqAqkk5lzWpidkPRR81Yp/V/1vnSAoLTnTdaPta/J9mo25BAkcXqrU+tRCSBQH/hS2ZyE6fuPIzPP9HB613fl/q3QSJh4O34Iwuvd+MXl3kXdZ7tWT/DK2YXxF7Ku0QoVcnIzb3toTeU9J1pM3oLZIzAGbPHVxE+AuLnkTNVnUkUA8tIC3hBohwFTQjbHJ3O1o5hwYMUH6qSUXCN49VmrVqD5j2eSk8nbR4nP6oOZ95ZUoHDr7MtG5TWM3vAzKQksQa9rn38dfdyKmbcM8qiMEU5h8mD2uGEEwrdROAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4D8ygwJdE8rdcHYmVYOhzAHgi0Ht1cjAxGCDfvs+6M=;
 b=ZpP2rkC5n0KGZi7pd4QI8w3DKy5NC0D1BngyA2ewtIAOaXJiR+8XsNyOZP+GKgbp1PlUGkGX/Jgg8YIi8Uc5a1tNWRGmE4vrFDKE4UFwtW8TUPA1VLfrRoGe4fBN3CNUAFXt2jsC99LG6eYGQ3jpOQVYS0genNJng19rF5ODbxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2922.eurprd04.prod.outlook.com (2603:10a6:3:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Fri, 12 Aug
 2022 07:44:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/7] arm64: dts: imx93: add blk ctrl node
Date:   Fri, 12 Aug 2022 15:46:06 +0800
Message-Id: <20220812074609.53131-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812074609.53131-1-peng.fan@oss.nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697291cb-d20f-41fa-2d3d-08da7c3686e8
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2922:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33SaeFyAndL1TFHD+Kqm/7i5V3TLNR2rCy7u1c/AIUTQIqO8sbHg0SGpBxT0RN2MBdlx5pQLV830CphDQZRJ/WxfZ7g4x9P5W0j4Is64j9KQFYIedXQwJGj4upHiXmj/hpvI2Ea/EVP4FlKmzQ0gj+v7W5+jVRvpI5ivRhAovdf96X/OhSca2gHTYrBmzwLsrbf4efHBpuNrDwpT+xfxl/NAMtZohTphHXQc0YDXfLPbvZ6Xn/fBYeUrh/JzhkwWkvovHmotqJ1ctk9zc8BwnQOwrabnWyqnzu8Mhlf/9XSkpBjHdet01NawYyTxgS5a9B4ugE2gM3xr4ZOFkKJtfiZCBx4iSxz0ZGnwGoX2B5l47BCv7ikf7mikpSR4LIlcm4eDUTJD5Dq8iXzwhn1Cw0sCJZrU7CE+1wf800EX4GxWoR5AsnTGq1N8n122WTbedpmt7NyNUMPFbfAI4q7TTNRcNvRdPMkCuJcScAGRUSA8smUFiA9uPyH702MUtbDNpYkQJSAbAhzuR2kBgfaqBiBOTFGkw4G0On7/kHUfqTpRemcbG5kDMfSQ2Z92jp+Om4DwIDpuSHP0H/XYJiCv2KJ7OSfWo5M8dpTlw6irGbvkIvdTyBJp0ppWnG9s6YbY8+SQcqGmihsyPUipSsIElDGa5CJfyRZem7kAGAM5Uj5tv5YTisDiNy5d1hOD0j7t+C3yPtsmZrH6xOCDKyhxspddsLUKFoHum1/p7KaqCM82gg2ItQfKYeLPkcOnkdaRGpF9If/KmRYpgVRhphVAYGBkECk3/rj9gdzsQBXzIpx/p74WUMTyqFNxaVWFDOKs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(86362001)(4744005)(66556008)(8676002)(4326008)(66946007)(2906002)(66476007)(38350700002)(38100700002)(8936002)(316002)(52116002)(1076003)(41300700001)(186003)(83380400001)(6506007)(2616005)(478600001)(6666004)(5660300002)(6486002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ns9SvxBx2B+nc3CGXfkNgPa0xQrPrXcJySuYATYnP8lNQ3akUZYKw9dVo8FI?=
 =?us-ascii?Q?sC3U/RT1ZOFJXNkTlhIZVIW3eo8ObXSAXPzB6LGZw/sDCvHBqQYmoTeraYcN?=
 =?us-ascii?Q?GyTGZD5kZd9syrFk7nbInxwbBBQahrlQ0c8cFnaZQ8dlADLMK15S6Jf0vVdk?=
 =?us-ascii?Q?eh/j8vnuJK+3OiMnGMnGLKvT3BOHUv16o9AeBZSZ23CIeNphxNjBoZu62gf2?=
 =?us-ascii?Q?4BiostUW39Ag8HRE5gKSHSaU7N4vC8mZtSXya1+IL2wTZP2FpzQ6zTO6kvcd?=
 =?us-ascii?Q?6reosMsqN5T+pS1LhLNU+kEmfspSDYXb/Cu8SQxGamDj3NcgAT1wnCf8vAmc?=
 =?us-ascii?Q?OPLeW8a43xWQJ4WDi7FKDG3R3Xkb8j7Uj8LV5JMu7OSEv99yX6aKY9j70KAZ?=
 =?us-ascii?Q?NH2I5jJaFYHBwFttNChEN2ivZRH04UbDrkwpNKijo2XU5uH8djdn+0NgqOnu?=
 =?us-ascii?Q?iQY1P81LLi4qppWQlYOaSntTYGpYUwBJm78TjxBFEFY0eyRPOWXMkMy6TOyO?=
 =?us-ascii?Q?Q2co9jiuUX5rnvQXYv5I7FZpPAcPBJ0O3ovz9K3d6kbhkWOxQx1q0Q9qlrOi?=
 =?us-ascii?Q?F67mpiMQlSYg7Jy1b7YfqhzRHsHqueAuIhw76oXcXFELmqJVxyNRzsvn7Z0L?=
 =?us-ascii?Q?DfRLnC5XZCKGzMDphnOUbs5xuefNB3FS7Go24kc1NvLNmna9R+AMe5nmwruA?=
 =?us-ascii?Q?nHe6X0BSSXLuRpYEyRv7uyomUpgy2uJfAMAX5SKzxN4f4tzB1ZbpkxucCKd+?=
 =?us-ascii?Q?49nRO+igs2Vz6MHh3GgPxkAgES4JFcCLCQFYg+rg503y+PJ0Qgm80NJ4owsl?=
 =?us-ascii?Q?xOSqm6ukZDYVGmx4wGAnHSWIEOV6WCvO1bsZloZvY9DB/RqREsl5/4GQZx3o?=
 =?us-ascii?Q?Z+Fvgk0UWm7UeYLsTvDxN7+83OSLi70UYqH9YLdTz9QApOfx3WXDq9Jij/lc?=
 =?us-ascii?Q?UNxUK7qD/C4yBxTUe8iy5gq/RoNlv8vVIQfvcKDFxBwFT7304Gumop9bqhT6?=
 =?us-ascii?Q?qQLKAIZYmQKiXywTBZqQPNgGIUESZI7ZzXcVch73ihOrdAXNzm2pAG+GAZIk?=
 =?us-ascii?Q?41gzZP1Ctwwfr815sluXFf/E29AesGG9cMig2FEiab+m5PqhKxPyxwV4Aa2G?=
 =?us-ascii?Q?P4tfkWhddZ9oJmBtdFYLydp2yUULoP0oC0IwjXgV8PbvWrcTvc9M64479yg7?=
 =?us-ascii?Q?59p3TA0B5gUujSz4kGi9jE+Phmgh6OUqZoP8NVryXEeQgqPrFSiV8vEO2Gdu?=
 =?us-ascii?Q?wYvHxSP8ej20vdXqeVcbmP9XaDlmSA/k8qqMveoO8v6HVASqbfWNvsWTEcM5?=
 =?us-ascii?Q?Nk5MRLfM3IJxLbUpj/sWu//sz+m4V/4g9G6jELRTm1HraSW9etu/e8mLL9OA?=
 =?us-ascii?Q?nZsK3gNfQ6SBZ+K5XMUTijP5ivpqL+jqwzpo6Cl3R9/CbrNxvrQH8BXX3GWB?=
 =?us-ascii?Q?BLnZsVWbtd0FVUfsFaxfQqbDgIPmboytHfBRusFrRE6mzeeF3WpmZErW3r9i?=
 =?us-ascii?Q?Dy0TZswtjzfJ3vT9ABhnIg9pctRFyB/ICGQSPYudmu3dDXyCu6j/O6dWS6SI?=
 =?us-ascii?Q?4XsbcBW58ba0mAY0Uj9zh7ubiw54WAx/Jme+K83y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697291cb-d20f-41fa-2d3d-08da7c3686e8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:46.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQE+717Hr2mIrGtwjiGr4ae3C/ocyxMd2tLKC1xAI0TMl+KUievQWM59w+hA1k36X0LS0hMCUa0btNGqMzB99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 BLK CTRL MIX node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index dd76472ced46..55f396723adb 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -112,6 +112,11 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
+			anomix_ns_gpr: blk-ctrl-ns-anomix@44210000 {
+				compatible = "syscon";
+				reg = <0x44210000 0x1000>;
+			};
+
 			mu1: mailbox@44230000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x44230000 0x10000>;
@@ -174,6 +179,11 @@ aips2: bus@42000000 {
 			#size-cells = <1>;
 			ranges;
 
+			wakeupmix_gpr: blk-ctrl-wakeupmix@42420000 {
+				compatible = "syscon";
+				reg = <0x42420000 0x1000>;
+			};
+
 			mu2: mailbox@42440000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x42440000 0x10000>;
-- 
2.37.1

