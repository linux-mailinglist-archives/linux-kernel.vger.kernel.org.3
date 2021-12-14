Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C9473A48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbhLNBiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:46 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244682AbhLNBil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8QVoW2MKNlDa0PFQP3JLuYZfDioLwLTYbpXl0Dw/1tc6p3EYzn+Q6pv13Z/fbG/UmP+Ras4joBiewrneaA/KhJBSA8ikjNotIv2R2+Z66Yv1QrFgCLZ/LEbq9X89QRkM3ncAaYKTyLRkVRZgl6rx+P8sity5ideYtJ0Ymru97+tmdkb11lAj6TQtMk4h+QA2CEkt0L24Z8W24C5yuEk3tDrwDAlHG7R0JuwgVgh478omlmUNkAPpXswsYMczXH+lyWN+Ezr/HaqsOp0RWjnoMM014IE/NtHVTYXOUVvzwNrrSih1QUMGaDgJgXtynFiHd1G+RZhmNnPTCreFPNSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH1M3zpTLOpFKNEbCBaMAJAGKmw9HWdaXt+TA6UNt9I=;
 b=XNYIPYA9CdUklivd49QlWKrEnV2xiphYw6MWA9X0kPArcHJIpPVkgJGmErHRxzZK1bwCf6etNCq5KhfYYvr6CCXWl6S7WunLyktQBC82tkjYNhSk5fZ+VOVIrG2p6N87fidO9CfivHc/8LWC5fpRY1Sj2BJFKs79QT0oBdDorho0cSSrNnBDbTW5ayGRUzyBZxyGG0+PylXk/7mw96wD4yGPlyTwTNvF06pIji4P5iX9R4RDPoxqPVPuGjIJFpPa7Sw4q8kxtK8429th4i43EMF0tftjtCnUSXKELeJ13jmALOl55SyiWb5EI0PHtL4QJ0h/DzME9qJKcWmhi8MIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH1M3zpTLOpFKNEbCBaMAJAGKmw9HWdaXt+TA6UNt9I=;
 b=BXrlZtyd0lTKlOVylqNLr8LrH+CK109QrN7WLpc5ZvZ0gmYK2UwInUQO7bSrl/jqzo9XXKSPJyQI1eC1GRsKuF3UZEfAkf+ZI2S5NEoyAF4hJlsrowsntHg1qGolx301FjLAY0YGQ3md21wD2EyRz4ZwDmZ71HJomQPPBoa2TjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:38 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:38 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 03/10] dt-bindings: ls-extirq: replace "interrupt-map" documentation with "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:53 +0200
Message-Id: <20211214013800.2703568-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003cbb92-386e-4486-f2fd-08d9bea2735f
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6944D5A230E5878C80089664E0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+65JZI/tS4bT3l5aHKgSHPT6kIBiS6UMQXR0Tbo/XG61KUEljrtpX6xgNZaPJieYD/IqEdNH06DoLdlfFR9l6F8arNaxW03GU1vVNsNcUn8cS/zUBil5x3yj9XDvB1v923GN7gUhK+PyhfMSiplq9UZe7PmoMCuLoWrK1jRb5+btQlDQUX2HC7l2h+0Q45b2s05WYCqJjZByFRcyNN4Ee9fUjER83+bMyFcCgf+1pP28NyDeCRXtLQ0YgacB7W8AgFpp2BQIh86WtenjB/1Vr8JSKO9I/0WDRHJPifJ+vjGvt3W+LIQW+6Zc9OxfeEodNSOKrwroupI6cWw4xeA3/Snkx9jZFmQ5WlOL3sHMtUs2X+EYworzRQg7vai+E6NmrUIiNkH+iwTh2IvTxi8ZyULg9DqbFaztoxfEfw75N1DbNZYPmiZo5+wt3gPcXW2K8VFNnPTJgc1MbCWNuAgq1uMd0RByiEp0fD6NmJP0RQPj8GZB/lcHLVXwcXhaJE63bVwjs/JivzaxVa1/IktGd41jugBhMfK4J8QQaS3TqoaaWhUKBE49FVP0aNppkE6lO5M9SySBlr5RyKF+QADKPsSddDYgFfRbXUaH513+aoNKAELxL1gVWysZ2luI4xx+LGdoqKaYAIrI15L0FGYMJDJs2JB9JTURx11XChw5rclzDKn1dXLGev79v+SongaJ7y//E/Y0RyDKVG4IBZokw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FnIGeNuh6/Myrd3e5VkJxY/dv2YvQ+veP6lU4xTPw1XYRXwi8xJf8rxA2+s?=
 =?us-ascii?Q?M5jfvdqi1hi2hZIiBl8lSBMOGqKBkgStoK+LjEwSyVYfiiQ1NEYeNac6vVFk?=
 =?us-ascii?Q?MRsGsS0MQsa3iopHOXg6RzqJD7X6QFP/JwsrWAALQBcXc/NjIJU9rFnWzVen?=
 =?us-ascii?Q?/l/2Wduhp8HzY8LBLuCDRHEhjlGKC+TxGcC9+iT9L9nCf3H8DO2ePhjb7+Kk?=
 =?us-ascii?Q?kzaWMa26Uzghrw1azLfUSYDVO8nwVrRj1axlEkj4mbT5DkS1pc9byzPmoT/+?=
 =?us-ascii?Q?BPBc0WCqmb3VQHTz0TtRUt9PWxbCDjeQ+5OJb2H2QU0+KVbMVqov4SJ63SmY?=
 =?us-ascii?Q?k8u8eKkGVWITbVndPu7iU9Q2llk4DT+NipBGFIybIU/Typ6/dgq1cqU5mqFV?=
 =?us-ascii?Q?nlPQ1OwOVKKEOqP+2y1zAWz4HQet3fHU5duyC+fwY8iPPHiY3g87W0jzMNpd?=
 =?us-ascii?Q?SB7B+MXqFeU3OJ/jmeAGZhUjx8yRk+0VTzj/0g5JxYopWZ50GI6hiBWf5bBi?=
 =?us-ascii?Q?VCwIs9PdEbVawVnewJXSa7SG47F00vlngog8AKeslPZsd7rWIwkmQmx6Unng?=
 =?us-ascii?Q?fxgETbaLrsugWIcz/7hS2BxvsnRIZKNYm5w0tXnsfIoWcVldXEfQxMjdbLJt?=
 =?us-ascii?Q?alKZB6/QaCihzNijHeH1D/9gHYUhbr0/d/zyXLUaueUch/duF68Fx8K8gYPn?=
 =?us-ascii?Q?wTy2P47CS3j/k351ilpJ6nIGr/PYuFaN1jKuJRuEi7/6WRPFBEIvUs5pKROb?=
 =?us-ascii?Q?QK617p+roEfRgPDf977L8G5YhqITo1+dULbwZOixvVLLjm/dPd4XtO2jYPAQ?=
 =?us-ascii?Q?H5jhm34t936n496BC2gnVa8sEXi/+CSHoOiyb5Q57esm15pgUa4Vltmgklv/?=
 =?us-ascii?Q?ZmBC5l0EqJ+XO6fKOqwMN9x6D5ZDqp3sRH85l/JHGtERZsSRuQ4QYLe8TtP8?=
 =?us-ascii?Q?WU0as7hlAAKzO0c1dxY5GONs6CddiBbmCtfxrSROYQMqB5vD1Tx2mbXOlIjT?=
 =?us-ascii?Q?yCbNvHufQ8/V4iqhksMTKpl4vavwqhz0a0d9vjJ6YRp/ISjM1tviLgT2hmtm?=
 =?us-ascii?Q?lON/BMS3WOX+xi8m51NVdRiJbNfTNR7L6SSV+irVNbquX7dYnia9yyqB4jtR?=
 =?us-ascii?Q?nVLPVeOnn4rqhr1D+fewCHL+cP58jlCNvMwgTr/hFx/AzEmZJZaDyDIdXxhv?=
 =?us-ascii?Q?ev+DE2XMG6K4eLLmfXpCJu5tLQFMmle/j47PYeWdSB89RchtpZ5yLSsWprC5?=
 =?us-ascii?Q?eAR7zCBEAfMugW01ZvVyLxwMBT/9Ad/GePwwUx/E8iTNeDhXL9tCOZJxpSIg?=
 =?us-ascii?Q?p/AfvQdWNPEJomrIdaI8ATg5d2/M0wnDLzewlpGbZZmvebtvwZCvCmFGmAmB?=
 =?us-ascii?Q?tMamWEQg/lasoi/+gIMQt6Y8+MV4QJbfdKvTskUjQJ0QLyMKqy8y6I68x7ix?=
 =?us-ascii?Q?0T+Unj1SyS31OUXn1dUkmfFlIaIg4a7qo4gdfkidtQXuGsybqhBlHwYE6ONV?=
 =?us-ascii?Q?SwgdRCaH/maXdmo4XaOnTQRMDwZO5stwQ7mSMC+5vbpbK9gKs2WAwYcpo5Z4?=
 =?us-ascii?Q?FweZ2cV2zrF1NjCrRF2EC4sI/aSRiR/7oi4Jb63+J15qWuH80xgudMNRQKij?=
 =?us-ascii?Q?nE1lZ3Q2o+M998dVs254Kuo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003cbb92-386e-4486-f2fd-08d9bea2735f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:38.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yajUmPwI9+JV+WOHUNP40nh3ys9nxZGMY//cA2ckq9JWhMj0HVnOPUbOHd/vFO7EwVc9b4PSxrER5zU1BXRgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change does 3 things at once:
- documents the recently added "fsl,extirq-map" property, which replaces
  "interrupt-map"
- clarifies the format of the property whose name is changing
- hides the "interrupt-map" property, that the driver still supports for
  backwards compatibility reasons, although not for long.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../bindings/interrupt-controller/fsl,ls-extirq.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
index 4d47df1a5c91..cddf1aa032be 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -18,9 +18,13 @@ Required properties:
 - reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
   the SCFG or the External Interrupt Control Register (IRQCR) in
   the ISC.
-- interrupt-map: Specifies the mapping from external interrupts to GIC
-  interrupts.
-- interrupt-map-mask: Must be <0xffffffff 0>.
+- fsl,extirq-map: An array of elements through which the mapping between
+  external interrupts and GIC interrupts is specified. The first member of each
+  array element is the index of the extirq line. The second member must be
+  zero. The third member must be a phandle to the interrupt parent (the GIC).
+  The remaining number of members in an array element depends on the
+  #interrupt-cells property of the interrupt parent, and are used to specify
+  the parent interrupt.
 
 Example:
 	scfg: scfg@1570000 {
@@ -37,14 +41,13 @@ Example:
 			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0x1ac 4>;
-			interrupt-map =
+			fsl,extirq-map =
 				<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
 				<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
 				<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
 				<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
 				<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
 				<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-map-mask = <0xffffffff 0x0>;
 		};
 	};
 
-- 
2.25.1

