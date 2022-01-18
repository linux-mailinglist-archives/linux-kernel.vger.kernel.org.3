Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2AE4927E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiAROAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:00:36 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:64646
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243931AbiAROAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:00:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8Hh+c2cHMgLB0RQY9l8G1sz6fXnNGQpRv0CBq44NoCMhy/qn9sGChHGsH3LqtUC2Ba8pzOnVsHcR6/XEgSFWvGSmAtF1Yn4ocVYjusjg8AcOh4GE6j1kNxGhQH0kij+j5dAdjkOv/wEoV6geSr4/e2+WSHVHMSwr+5A8a0B56XX2o1510P02IhEkkb3cLyIKr4A7YZHXGRfsdi8JjRpVbFEWDFaHS6CeneupYfNNYzv2YItLXzHK6Ht4BAAIY0RKyb8AownM8ZQ6rLNUr8M6qBUsA7Dr/iubogf88lglyMJLX2zqvyBQMY1xKkh28w9nsal6hI6+dok/Is+LmJ3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3T4U0MgHqADc52zxjTxNZ8W+GimxYXDuLDnDMTmDe8=;
 b=QpJMgZTAVKDHiN9czwclOlKzFvv594br7IowVDycbgmbTGIpVN3/0FqQF4oT9xnGk/FBDjlCADCeNPpeGxx6qVE37JF0sF8aZ15TsbYR4jR4gYQUgULRB+P2GNF+MrQMvxt+T3TKxy8jyFtf22HRHvhnrL+BwAbmdoqmYKRVTLkxP6yh1Fgwq513dy9UleWZbv7C9DHqFIi2UBi1cr/lXR3CA+NiJ5DPyoZmwaQ/RurrNm4pRHTsmmdGDz8rPKWBBeAJzg472ObHGvBrYLt9YNd/gzniD+uzciGK2SOLMP9UfxBW+NLjHST/AjH2gdgAGY/iNDZIOI6rFadBKSXrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3T4U0MgHqADc52zxjTxNZ8W+GimxYXDuLDnDMTmDe8=;
 b=IqAi/zd11Duisfew48U6Q47RRe/hu8xHujvqpefpbxnc2fncsoZS2NmwHwnmKk+7SuSdqyvhK3/MJ7VihOTA8Pxxah3bPjG4m75v9enE8hf21DCE0HzEv0Dtn3rcWT44Bt5f4+odsVGaP2ru5xCFmlLknKo1JwBu4AiMm0NzGa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB5288.eurprd04.prod.outlook.com (2603:10a6:20b:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 14:00:25 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 14:00:25 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8qxp-ss-adma: Drop fsl,imx7ulp-lpuart comaptible
Date:   Tue, 18 Jan 2022 15:59:18 +0200
Message-Id: <20220118135918.2126010-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220118135918.2126010-1-abel.vesa@nxp.com>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df3ad3fc-2644-4a51-570a-08d9da8ae03e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5288:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB528820437C2E0CC95D65460AF6589@AM6PR04MB5288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlRpJaDn6+jcze4ExI6H718TFYub9d5Zsbt61JRaCBlbMYknIoKRkUHXiMshKCQXrBITcKvIqV+8+knQOd4Dp3lNwWmZ6JqYZQ/b3fvp/X0gXNTVB8fhhhRfsnXL9a9Fye2pIjIzZZqhh4mdnJ/Q3rM3xunxyS+g2DWf7AjO8fCUkf6xSi7ZOjRLbgvymy4y8tj9OF92Coi+s75qrIgiVJjAz8eaI14d29ktrtYIVN5WIQ3VJn5vx72Ukltrl3V8giXjMm20C4FzHKXS3Bi1qJZnMIiP6hb5onth44VZDsIAiqmGyBfRMfWwsjFjaHSo2mQJEvPvyklUHCL0eS9mqOVsiCxszVbLvTsr4wu8acXB9Co7M75CVctoio6YO+xmbPv7rJMOJmZA7mUPv9ixC4ds+ga4E+lD222V3L/dsegxAgOH8IcMUbmK7B7CAM3bT23NeQHmVSzLv4HlAOjn5W/eq49/khky9eYvpPO7JNz0iazar2tAbPVrYdXRxH4WOoM3A1breTMK3PIX8ynp6ClcCKF8aAkr73CORjJblwMqqgcJLHsGBXnEol59virDMJGbORuXBXkFdMn55bfJXH0CV5wpov3BudYvccxxYCOZCffgmN/GenYGZ3ik3CONPvqCxDEJIWtLXzuFibqOtgWE4BV4uqFGSt91lSD+uSsnocgZC/45sKqkDWeRUHLnzkFFbHvjFpN8blSB6MFUEY4KLBr+wlmNiWhme2Y8JqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(7416002)(4326008)(508600001)(44832011)(86362001)(6486002)(6636002)(6666004)(1076003)(8676002)(6512007)(66556008)(66946007)(66476007)(8936002)(110136005)(38100700002)(38350700002)(6506007)(36756003)(2906002)(316002)(54906003)(26005)(52116002)(83380400001)(5660300002)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FWOMzBMpgtyxpHXfOdV3R1ywRwcCC57wpg7TQw94M7ifWrRfL8XZy9QVfA4?=
 =?us-ascii?Q?3OMUYCmdtCES5jKtKO3Rwy7R8MpI+N/q6g0DmQ5ZYubgsZttsNcLFrRYme32?=
 =?us-ascii?Q?P0fA3HJLXPVXy+EaT8pvdxTDLrqfIT07CKzjnc8c7WraUI1Z4zZs195tFdph?=
 =?us-ascii?Q?ZSqXSX+Dj7c9+ej+Gv8S+pwEE4U2Dx1a1Kes2eg+IOsoxaw1g9946GvCAJsQ?=
 =?us-ascii?Q?rQx5Nds4ZsYKbE+3sAsHAYp5JpNSchqqwVYyT51o/5ZkR243Anf9w1dwi+pu?=
 =?us-ascii?Q?6RY2lA2Y+YrICTvMEsanNG4rnUdeAAhh2E8UYlyzomKQPftKqGRDWfVPvh8l?=
 =?us-ascii?Q?b6uXM4/iBuQzw7JoyMSIdhuREWznq+UYgj77tUYipaJwxKJWb3QKOZhzy00E?=
 =?us-ascii?Q?AutOAkTrfXUuObUWwNE3ZgCfxiNVruNWd+Xvb71DczvrtRCnrprhaH3TiDHV?=
 =?us-ascii?Q?kYUqO2IApgkzgTfh0ZsaV2xvWChKwlU9NniiDK+2UGXSWpmFpfka4oj3hMDp?=
 =?us-ascii?Q?8rlJo22uwA73tTM3f6q1VHBhWmuKlwu3YZnaHrZ6wdM+FoN087niN7pmFz0I?=
 =?us-ascii?Q?7R+5DnmGTl7WKpujGJe8Yz162jinM6f4QlxHGQuK6eHAWVx6JpmRNq33ch6K?=
 =?us-ascii?Q?q4tDlhPnqd+9gmzaDLEhQpqxPwlDDIg4/RPlDnSr4TwZ52xAaMI2XUacMyCQ?=
 =?us-ascii?Q?xJDTMYYW5DgJbwlP+PzZIC/Ch97TZNN3O8lTrvq7wm8BMZJOTc6hTs88P9To?=
 =?us-ascii?Q?4ql4LpMXeNAxcH3mW+V72JnfmvSPDSXnOxPoekSFvbbv4WwOa5SfxR8vPTxT?=
 =?us-ascii?Q?FReeK/SV5F/BEJpotWhs6JO0G6m4wcs8x5meazAilGLqT6Q9zsNUoU9hCbnd?=
 =?us-ascii?Q?IxOhxw2c2zibjmhg2jmWkyQ4K31Ax1g5r8T3/BdelcJI+vBm3Cccrp9j4DgK?=
 =?us-ascii?Q?GRJBkrjuSqa8WtMs3/7pHP5AlOMnpUVH67JmSumInRNSt5lHfJi7Wp6+mvct?=
 =?us-ascii?Q?ntKpwOfZhcE425dAKZaJWU5pJbBubDOqbQ5H07PVtomO1wcGyJfd33mL/RXX?=
 =?us-ascii?Q?fr+6cdifjlnZi50lx72Gej93mcwxPJlLzy4uiA+alDtHAzFZFUzSsbIS/dru?=
 =?us-ascii?Q?2BSdkZSz8wsTUNgO4Px10RkD/e/ZzR30V9CaHbPrQPGHpRZXdoV9Qbzlp9iG?=
 =?us-ascii?Q?cLRS82VS2w0xMttqwZd7+tFHPaZm8A4Pm/z49eoZ04DlJdz7qRGr8B8lilem?=
 =?us-ascii?Q?7vGTWU/8Sz7WLNaBzC/cbUBNgghRFHTe57LqChnAjz7NV69f+vLqb0mrL5gs?=
 =?us-ascii?Q?9FdsZ1BpoztJzI20hy9JFrNQTU7qEcmsaCw6jKJX8RG6X+4YAbbRejnj5Uf8?=
 =?us-ascii?Q?H9nQBvDRsTWKYn95zjXc7j0h2ibuNtgHrey9VKQhdthBZ2LOkveEQq4OgYIT?=
 =?us-ascii?Q?X6jZHsLQY2OyD2UTnjE8JcfEURreR7Fd/yPgKwhW0ZSha0yRteSpr0CTfGFn?=
 =?us-ascii?Q?mOM5zieFivF5/lNf2G85RqL2rQ5Qz4ICTGivSolnqdXLYBSV+wRCLW2x6BtZ?=
 =?us-ascii?Q?rD3DU2t5c8fX9YgM0ofEleHj+CzEErLkXHZI4iUi20qwwJYL011u4+hFoAw3?=
 =?us-ascii?Q?TYWehHzPCRqpIoYIFAFoLZs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3ad3fc-2644-4a51-570a-08d9da8ae03e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:00:25.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyFtvYvQcRi0p1hs9HhycULWIMu7oIEKRBj/Oh0BJbvWaKq340I8NsPeqZCG9iuQ4UpqEGBXMYQ8ZBSwmUayvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver differs from clocks point of view, so the i.MX8QXP
is not backwards compatible with i.MX7ULP.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
index dc1daa8dc72f..7bae516004bf 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -5,19 +5,19 @@
  */
 
 &lpuart0 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8qxp-lpuart";
 };
 
 &lpuart1 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8qxp-lpuart";
 };
 
 &lpuart2 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8qxp-lpuart";
 };
 
 &lpuart3 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8qxp-lpuart";
 };
 
 &i2c0 {
-- 
2.31.1

