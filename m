Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7411248A7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348102AbiAKGVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:21:10 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:9134
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232725AbiAKGVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:21:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGipKYz53tePpDM3g8BdJY0TzbDWxSDa5TYgCXBRs01OykUfPNGtHBJtUrYM4WObeT5lZG70Oc3nMOYdHhmsYtIgU27Hy1cXsXd0n4GtfFMefM+vdU+CBA85l0EAkckLgeveuuoUO8jlD3WY0i2jDokAJ7y3CWsp2irTyMmYkmToCjSx3/ziV2h1DPXXgZJ0sfiZgKDQkicuw4vNEIJCNhCD72aj78N+lOO/5Am8o7Cmj9QUfSbwl8yVSBVQfWEaaUgX4B2s08Tp8c6SWt+WshYnUgJB8LtJyQOCGI6+NTMbAATY/ccAldkPQa6veMHAoMZ/2Wv8lqus6hpJ/KJAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaoLoQMwG+m/LB9BVbiKLiZdY2BjnkSjXP5qhg4OVjY=;
 b=i6q2Y//dw54TDmmzom76126qrNwXP9S42MstqF40Dw5AFaUZMgmQ9lMw/VSTTgbXADJiiag3cwdBcuQ5GPdJx30RaEAH5mdnh7PEpk1d78y3dtiMppeW3mueLYb/Y4t6l+6Y78/EYzX0aVpx8TE6PiMmcgWbx36kblHVUEFIZ/YLwNSAHLWMJZbu0xLkys4PvrGq1ZW71CMq/TtwYCnvlUURWGUARTA2OqWw6BUTbhVle4QHauzCalR574lHpAjilzrfQ5TfjLf4B8UDeV/GZdWiNN7H0Tfzn4WmXq14xoaLciPAb0nrjSzOwjy51asw1FMkAyMxnI13BWirJau4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaoLoQMwG+m/LB9BVbiKLiZdY2BjnkSjXP5qhg4OVjY=;
 b=g40lfz0evsJEebuViPsjtMZ99bdzfV+zN7MpzCaPyBzHy41jfYLYHNJX5tcDW8LCIe0ZvwMXGoU882hsnHeHa4pgV+mGUcG0QHjke1EoRSLw0vrzZuVNoeEw0jTrA6oi4Cqv87zBV7CAd60Jp9Buk+p91EkOgZwK5jCGkpPiAM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8711.eurprd04.prod.outlook.com (2603:10a6:10:2de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 06:21:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 06:21:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8: add mu5/6 node
Date:   Tue, 11 Jan 2022 14:20:13 +0800
Message-Id: <20220111062013.1027517-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b577603-465a-41dc-dada-08d9d4ca8c76
X-MS-TrafficTypeDiagnostic: DU2PR04MB8711:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8711E836F370A519E3739721C9519@DU2PR04MB8711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzS2zP+dDebZb1rQhKuZrfXb8t2AVND+WMHgCdpu3ppCsEF4KJQlMNvZHGC4msNy/8rB5JwHaZ5nRMal7FRoo4+iwZRt5pDxLQmueWvlJbGwvcQFzW4OeAgk2Iv2IBxvgljdyLHqzKqI9OhitlJOsB7ul3i+req0abMLJuFbqdXqm7AMSpzKpNdGdYnMrbhdgxLUK1BtKFVGz1YgZuKrByVI4TYtzd6+8futw++8VvANG72LCPhXQS82DcRchaG+gzE490a0CRzJlnvZUAscb1bqKzfFrML4f83sSXfszzPKv9fKoQNeZyDliqzquDcqYG3rTslYTibTmHlhbyHdL/kzJMOpIF3sXxmClvK0sg599QRwBjrOnS2ntZ7BlxdZXu90Cy6rLvMk5QlR9ip93ZZgJTnYpQsmmntRYKsmOfzQu7MRxzWAqlD2qB1KA3RBOgHxq25isbUCpv519HJ9Sduq18tzugBNDa+SDogAbEOaUitsqQX1BWT9w+3LSaFr6bHQICo9/u7yW8ZGnK/PRiYngkXJKAnjByk50ZltBLHjDWYWB/Tnuo97cnZ5mhREI0cXze3yGmoiIBVRRftky80KnYH0rJy2qoxIGqE0vK2CL3b+pMTkHJBGAr6voeQJy3DoujQNZFOITaVITvHgswDVYkWknLh0WCuMXA5ppzcilEjx6Fh28ks1+O9rZmqX7XWFzbfLAFhpFRPzJ0CMHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8936002)(6486002)(83380400001)(6512007)(52116002)(4326008)(6666004)(1076003)(316002)(5660300002)(186003)(26005)(66556008)(38350700002)(66946007)(8676002)(6506007)(66476007)(86362001)(508600001)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AG8IWWdPHcdQSq3cYYbkbvm2HBdYRze23pIWbJjCVnFZBimBxEs7bYHdFYIT?=
 =?us-ascii?Q?n4Q/yb1M5XrMVz6eiTQBxGwhsV3lpjm9URJJMcbAyVyAW0gLO8oTAOXtXVvo?=
 =?us-ascii?Q?pfd9bdDib+AsbE/AhiF+FSL4lc6rg9ZLxooj7jpU42VW9Yb0m3gnXEaz2sEJ?=
 =?us-ascii?Q?GiKS6IQhANxjBAG1DoQeM5VdK82sXrRm+7ZT/j3P3ppnyUeipACy4uMYr0f8?=
 =?us-ascii?Q?eUj6Q5vjscqdk7zrFyAwWBu+Li9/UC17YBsLBkzHFpqOZ+yWmr8uxL1WjBOB?=
 =?us-ascii?Q?T6MQSQ8w+M4tzAkMRoYtdptWAZ3Gk2yT6MEirF/wQX14M9J8uf8ko8+XfqOl?=
 =?us-ascii?Q?nD35gi56AJp+pc6MfePdr6RVtKAm4ABz3ypbEHOvKUN6sa2ZGl6v8Gv+Uetx?=
 =?us-ascii?Q?7QxwRxNl6U1XQNOetiYCUI6nxgR7NOL2Oru1rF7y5Yu/of1TcGyR4mGNAXUt?=
 =?us-ascii?Q?ab0DcLPqMmvpNDyrLQgbZ2+5StTPQRUXY2NwZx353Xu7dHpyDXP8WnMSOGIY?=
 =?us-ascii?Q?qsn4JaXgJYeleCqf39Tu1ugG/JWTF6jPi9hUXU8JOLCvgMDjIoljD26FkKC3?=
 =?us-ascii?Q?DTh+4zo2OQJcptm6TdM0RgSSgbOiNmq/17fHfnO4ppzhXMxtitSlxRG7hp3W?=
 =?us-ascii?Q?LHw2LZTCjIwvlD+rcn/tA7kzZHaqQUt3lB5UxskDxMaUHh1WHffjil6Terr5?=
 =?us-ascii?Q?Ih2YLik3+10tfx2YV/LhXL2Z+CwyFegOgSOp9vwXFYdV+cHwUzZm9GLbY9IY?=
 =?us-ascii?Q?itLW8GZsLn63fXeEuf4PpMqUd3DDFWE8oVwNmNcQ6/gkiFZbep0RkVXiPOEQ?=
 =?us-ascii?Q?bzl+NaMLXlDWoA3k6ku69jIxFQx82/miB6+WibKZmkBJRd31k08LcQz5b0Hd?=
 =?us-ascii?Q?3LAs3GfGfZdN5PB0XeM5lIvYvCXq6F9CA7REDT1vQqsuzulO65u/RPaSB15I?=
 =?us-ascii?Q?M+cwPKhccQpZeW7koMDgPxWRLOd+LjkYZrRvyGZIRPK+tFPyuBcCJnkeHNyq?=
 =?us-ascii?Q?oTEr3dZWnDYz5JexmU4Up5w6WLqe+vSi7XX2rpzCIUYwCPXPsmuVWXdDZzHK?=
 =?us-ascii?Q?gV4GfaJgwp+5FDJrBXEAQr0YmOlhTimn/30Ow8VwurjT95qbLTkyoGvfNC+n?=
 =?us-ascii?Q?bLq+Pu87nKHWR7R5DXBoYx+0ZUVieBjz46hthB0ygOcCmP1TF/mXM1HC7y3q?=
 =?us-ascii?Q?KzVSE76HH/JXXLjEXoLsZRQpmarIe1zuo1Vi5qFhqA61lbOGVNbVJp9uf0++?=
 =?us-ascii?Q?naHD6CU1t5Rkwm3RvXk1jyFbFpTY9d8gDpRp2M5kGLkxfLZUaqz+gbZo+GDS?=
 =?us-ascii?Q?2dUULc/DaV1gG+k8wbxWtICN0cE3UI6mc6KRGqEQa1YjsF0u2gDB+Rc1ZW+9?=
 =?us-ascii?Q?QVr959bYeFF6S7bixZfX99LiLYh5vhVo0ldugfZPFmUUcWBOhucCg5p9YTDl?=
 =?us-ascii?Q?KIh2sLSCt7Tp/0UXpNfwrf315MXsCms8EkJf9yPdLkRQwO9swEkL0FPwMqd/?=
 =?us-ascii?Q?lMnfLobafk1rxurJG15uf78ImWafWNXPRM18QSmYi6olwfmc8bW8ELsOSzV8?=
 =?us-ascii?Q?KxlRYJaD24CnH6+8dQs08dW0rnUFIZ049Ghh70h5Xdq1vHFvd+E/EcQCHiUw?=
 =?us-ascii?Q?Oy6KWyHLAb/FJ8jWjeKZNPQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b577603-465a-41dc-dada-08d9d4ca8c76
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 06:21:05.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcUlrkfRw+6XY7DbmX5fR2mdJ0OSRnjoJ4Q8oE0IaoUIFoIY2WyBFP9lSbpzhurMtinxnbiSU1GwonIKIvX99Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mu5/6 for i.MX8QXP/QM, these two mu will be used for
communicating with general purpose Cortex-M4 cores.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi  | 16 ++++++++++++++++
 .../arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi |  8 ++++++++
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi      |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index ee4e585a9c39..6446e6df7a9a 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -141,6 +141,22 @@ lsio_mu4: mailbox@5d1f0000 {
 		status = "disabled";
 	};
 
+	lsio_mu5: mailbox@5d200000 {
+		reg = <0x5d200000 0x10000>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_MU_5A>;
+		status = "disabled";
+	};
+
+	lsio_mu6: mailbox@5d210000 {
+		reg = <0x5d210000 0x10000>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_MU_6A>;
+		status = "disabled";
+	};
+
 	lsio_mu13: mailbox@5d280000 {
 		reg = <0x5d280000 0x10000>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
index 30896610c654..669aa14ce9f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
@@ -56,6 +56,14 @@ &lsio_mu4 {
 	compatible = "fsl,imx8-mu-scu", "fsl,imx8qm-mu", "fsl,imx6sx-mu";
 };
 
+&lsio_mu5 {
+	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu6 {
+	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
 &lsio_mu13 {
 	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
index 11395479ffc0..8e2152c6eb88 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
@@ -56,6 +56,14 @@ &lsio_mu4 {
 	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 };
 
+&lsio_mu5 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu6 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
 &lsio_mu13 {
 	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 };
-- 
2.25.1

