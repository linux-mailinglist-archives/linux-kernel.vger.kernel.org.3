Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8559D46D443
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhLHNWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:22:40 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:38374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234256AbhLHNWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:22:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTD2p9rZr6Cu5uPLRncJ1z6ZcVUGUqGwqFCtFh2ixliFW/x6y7cJAC8JYkklYRtPxIInUfN/DCqVoD5JIIYr2orPsGvQvE7gJdBmNzvgTk/WZBBUxDibuvJbBmK5Vw2Ec9rxjP9Lywz05/9Z2Im4fiq4jI4gJmXQBZPFFxnFEUpLzLKbzas0SptmekW30r7ETZRoAeR12I9XKoBmtZTjs5IO28RzyhyA+BXLFZMshuo4xJidR4uUnzIL1smS7XdRSK4AP01mMt10H/zv+pWkqjqiYFHM+6e4bt2M3HnK31v7YAcqXNEJxuUXWFO1j7AifHGR4ZM0i7vjY10QhxGAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DoDSgu/kXlHLBsvr0b3xnspM+ExpDPzV2AFhx5g6sw=;
 b=WiYiefk4FABtHNnL4Eu1ufu3GnJFY4naxJi2c/nqO+Y7+iJzZ7auTd6zUhttG+zqjEW1jaV3stls9MFgafI5LGd1gqG2/NvJNzj2PjnlZ+vBlo4rRZqXzNsXgltHxi7c7raju+pnbjuXVfEcVu7Spozn7UyiPSofncnAIzVkzjPbERHkQ8HQHUHvQMUeaBcQWOs+CyvrFoKfvTdLcSZH5XysnABFEI6iQfNxJoRwjwEgg6rGKoFKsTMDAJzehDTd6ACjoD3h+nC81sHpaDEu0chf+ZSegdgQs4bTU772iP9gd6pzrSBX1JIQ4bQ82WzmjRqp/QSIm6QMVty9H/4v7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DoDSgu/kXlHLBsvr0b3xnspM+ExpDPzV2AFhx5g6sw=;
 b=G2JMKiXSZLFVAWXgh3DLqTvc9f90Wtwq20KZT23eLYncY+D0BI4FWaV2opng6c1setQogTNeufGtVuJjN4hpGmG4+2HG2LVhwLp6D+PD5Rn8riacVL9MiT64VhS1xxFfS2FQiLX/viC8NpbJlJUpZHeP5kWLpMPOZgLw/ReVhh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 13:19:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 13:19:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] arm64: dts: imx8ulp: add power domain entry for usdhc
Date:   Wed,  8 Dec 2021 21:17:55 +0800
Message-Id: <20211208131755.1799041-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
References: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:3:2::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:3:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 13:18:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14cbf8bc-cc58-4842-e5e8-08d9ba4d4de5
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9496E748F6F9E4F4EC9FC1BAC96F9@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29goKAJatfIiO4e0ICHwxKJGGJ1hGaVeH+TaNk21AK+IWtGzjiixQtoxeFJfnZP1MZHDFT85dyz+AWfYr81D40v8MLB8tRZqHXwUGrzt/ei2Pxk1oIosgbqozqP19gzyTSx7qE4LarvS1h7VSlvkGvq8VhIuASwIR6YHmgEk4uYzJyni+iyxoLTR0cEf2eFyWU44+bmp3pIswlhbzukTZ2euzbgX4teEnoYCL4e996V320h/KqretJuxlofGmxkvQBvSWq0y9v60VtWbgyZShjOaI6n5lrFaoLtrZp+IgbIq3gOw5xUTJ7p7/ypNF8UaPkpCjZC5n40BsZerJE6fIwjB49cdD4P43MbPIPnFe6Shym/yIVEyZLsu9vd6i1tgbirTI+FOFSvl4hi3hDs1vOIPTt9g4fqEr6S03d+Tp9QhklnlVBIvrFvAnEXpARiAiraoeQ9fUGCQWFlutFVs2bSKZNcuk/pzdO20bnSG6gwTBVnTWJrqdcwR/uC52z6kmj3FRtvxq5qej4autkI/Y/7Ar9hHs/Kvz9Xvw5w9KpSbVTWVZti7ZSDUOukAjjze8zZ5DdfouWIMWvYCFvpKG8pjqUjzCKZoQk9Lq9ZgEPW/CjK70xAa5yfNG7EmmxR72uXhuIt2QTbGDvoT9XDCjFxEF/TosOCHsLE1kW8VpDcVpi1QY2CgItgKLGBo7JlDLqCfz+KSB0Gbcd7zZTkRdYQB+gudPr+3yqAwPbqhT60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(52116002)(6506007)(6512007)(66476007)(6486002)(5660300002)(66946007)(66556008)(6666004)(86362001)(8676002)(4326008)(8936002)(1076003)(956004)(316002)(2616005)(2906002)(38350700002)(38100700002)(508600001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8xU6OquQJqivHlvtBgJExZcWDrFFuDjxwdD7kRI9EQwX7V2uJjMwnBuwY6s?=
 =?us-ascii?Q?PlRGhBwZLqTOXHp0RKj5iU18UCgcAZCS0f5FjvZe29e/QFhCHohhdae9AW/p?=
 =?us-ascii?Q?KlDG9mR/ACgOtFti0IT4sM1rhP0Cas1K+zal4ezKelt5AsSePvD/Rnp/jNiZ?=
 =?us-ascii?Q?5jezjIYx5j6BWJK1ilTq/1Aq06AjUMvVl9lbS3ZKOTYm7dAZvrp+s/68Ij5z?=
 =?us-ascii?Q?TG1qF6EXn2NkfZaYGMiHH5tpfbfK+RTE0xqo7Rm0qJC2+twfe7CcsSKH4nJM?=
 =?us-ascii?Q?D25qiKS2VUtxx0jinUWfRVh0vreO3rQugWN/vWZ0VlhQQzW4q6OKjVAUs8bv?=
 =?us-ascii?Q?Ad3h6V+1cSolNIIP734Bo40LnrlZvl4jZCPK3LBLek+R5qwtENnRhIoKiq7L?=
 =?us-ascii?Q?SyxJF0Wo8iKgMiOJ62mT1oSu/aj6c2yCBi+krndz8jh9D8ela7p11fsgrNmg?=
 =?us-ascii?Q?z5k6WBl8Ssei0Dg92o7BEVSuutbvHKiaLeJo7akhy5cFUnVlzEuVhj7eP3D3?=
 =?us-ascii?Q?+eO86bWNF4QltXE2CJAW4R7gz/I7OtXS1i4inpDIeqvCXjkYvm5gSAJszC+d?=
 =?us-ascii?Q?/Ps+r2vB3cPmtyNPRKyLzj1wIbIPp1lQ6felEjKWxqH03R1jqOVjbRklcjJl?=
 =?us-ascii?Q?gyeeAHB1eosGWDvI4v/xYyYRHcmhGKSX6HAVHrnj4oOGnLiDqHk/gFbZ8Tki?=
 =?us-ascii?Q?1hpVGCluYWFojFsmpRFOoSYfpXxScjn5Z1Zv5WRpd8oWqTiO1jDxyz4z/MLc?=
 =?us-ascii?Q?scTUKWGCJQHNhzUoJyKEwRsGZN1pVk6ebwcEmLHcHcWhch2VDxQ9uW7kqIJQ?=
 =?us-ascii?Q?76ER/UnTi9C/wW67LGXGvju/RfuG53uOWW8EtvtDvYIpM/0zj3FX/Ma8qW7d?=
 =?us-ascii?Q?8CyG3IAYT6CroXlpXjrjhDrLP/xSbPqagpyUWJe89N8zEQY4E0QfuXCy6RDN?=
 =?us-ascii?Q?DW8XiV0too9Nbvby5OjMebJz5brS826jOZsqI6d4/S9/3L/mMo31GXEfxxQN?=
 =?us-ascii?Q?6bxvj0E54r2IVlZpqWOik12hEC9YJbsmJBMxkAiMNHpt7sISdmpnECY0JJhi?=
 =?us-ascii?Q?aTGnVjldSPztmf50gCZaXMYHf3FS93xq+j3Re3qt7MDhYQJNNiIKChisRZnd?=
 =?us-ascii?Q?V6RzKHD4vnlBzH2mfEUU18HF5L23gwlz2sOZ+WDPm+JGqR8sIeRjrpII0k0m?=
 =?us-ascii?Q?H/O2Bs4M93/XQ0S4va83gV8vBlaGXCBi1EHldT5SN2bW/Bn1zVwqecxS5QIe?=
 =?us-ascii?Q?atVVIgYAcyiHB5tMW4VjEiSR8pJ8LpwrUdCX+5qA3AI6UpkDEOPQW8iVuSW1?=
 =?us-ascii?Q?Lm4gYim8+8OzfNOTMtOGsfyCT/uOwiV5rNrVEtp3b/l94n3jEtD+WrqCJHPD?=
 =?us-ascii?Q?419J0FKkr3hamNR5Z5prNMK9avjs+NRj8GlvJdjDa4wa0FBZhYrTTgqABwGG?=
 =?us-ascii?Q?SS0s0uOyn9axa1Mp6Ms1fHQeGXaJJoq9cUprJZ+1cj4WXWSENZGJq7A1yymp?=
 =?us-ascii?Q?hRLFkMwnGBq47GaayWUgh6kY4jtVDxH79lDIurCYdpFHefAUlVm++ozB4s+Y?=
 =?us-ascii?Q?mJIs8VQ1tJq0ND5siTmWZT7Szmi7jmmRUyHmxLrdi2GGC8OXHbXI6yvi6Moa?=
 =?us-ascii?Q?LKUUMLPUAimAzFpWjRdc/cc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cbf8bc-cc58-4842-e5e8-08d9ba4d4de5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:19:03.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v9iIYh8ZF5SiV976pX4cGrzJcCWYAR5THj3ablAZ5qyEVMJ24IiIjZL4Wmlb3050MbL8rWaeOwBSn4eM1MyiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add power domain for USDHC node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8ee040e3cbae..a987ff7156bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -329,6 +329,7 @@ usdhc0: mmc@298d0000 {
 					 <&cgc1 IMX8ULP_CLK_XBAR_AD_DIVPLAT>,
 					 <&pcc4 IMX8ULP_CLK_USDHC0>;
 				clock-names = "ipg", "ahb", "per";
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
@@ -343,6 +344,7 @@ usdhc1: mmc@298e0000 {
 					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
 					 <&pcc4 IMX8ULP_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
@@ -357,6 +359,7 @@ usdhc2: mmc@298f0000 {
 					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
 					 <&pcc4 IMX8ULP_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
-- 
2.25.1

