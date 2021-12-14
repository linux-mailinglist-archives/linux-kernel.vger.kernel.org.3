Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32159473A52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbhLNBjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:39:04 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244737AbhLNBis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYQ698NsE0WKj+CxvGIVRgvV/Yj7/MU5EnULJ9YMBMK7CZuNlYVg9vJorNTJPvoIj/KatNrHkbHu5+ldP7Awq9+l+GAAAll+rDbwFTU0g6CZINF6q3eAOEs5jcn5MJcIWLkHmYilzVCxwIIOPJ6H3QP8OJpSBTmMCUvyopbSuz1lkaT97Sx4qd1cW7F2w94q6/vL2sdPlBGN6XC9/4zVsDutEoVLpb+HJ9wGQCNqMeDXcEGAGACai2UpuuSK4Ypjrw1G1nZOSTIqwiqiymfGbIU5ZcjTV0LyKTD+OTzzHiw1k8RWUgHeysdNMg/wbN5XnfaqPKuapFgie92X3FwgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3IHj/tRIA08a6ZMwVY89vihiWBBmaP5FRFBynMOMSE=;
 b=dVP3N5i8a44IryAX+FeXw3uwRuX4WVdRE2d9tHtB0bZJe6cn4i1irTMNYmyFAYs9MMNkPrnrbe3DKStO/Rd3bUeuzxf0Bz30OdZ1IMowjXg4JKY8iYb1waj0N5MpMmDSw89ZGHq8coz4ER/cxrmkznKVS8G0iIylFhyljjVoJZ17xNhKPiIgh/H2q11lXRyxHC4g5CGJtPitybGa5zuXQo0qSuloTjDfQLi6gku81W4hd66aP8mvqz/XFh0Xb/uBXEkNSkJm3OaUx8ZqSYFXw2YdTHXettp8Q2q0wcsbnaB9igQeI4asWsxC4t5hRlXFwFCGN9TP0gyD+06mFNtTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3IHj/tRIA08a6ZMwVY89vihiWBBmaP5FRFBynMOMSE=;
 b=l7mGhtG59J/JK0AXj0b3ztoQCNlCOZ3jWmotvkshASZqExX5D2GrygF9t+Q/XOLK0DfSv45FiWl6pPGX3ZqlNqKNNkx2cZlqIzCMyMCrPcwQqZP4bvCqv/TxOFvLm+rhA2s8hXPRRq8/gvj0LXjVdAABQ+NSQxNxbKbFPKhQ6lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:44 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:44 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 08/10] arm64: dts: lx2160a: rename the "interrupt-map" of the extirq node to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:58 +0200
Message-Id: <20211214013800.2703568-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8461971-04d8-4f8d-06f4-08d9bea276f1
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6944BBCC785E50611447AD49E0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UM5Rt0o3h57CkVIbA5RIZK7U86jnPE4wy7j7nxOsgW83AKK0+e2lXHJwFaeVrdcEHsyGk4TnF3BXLSI4R0kaxJYjw9/ob+H9Z/rGv3Kj/7ASJmwM0XVIxEXhVY46xyu1a1UeHUH4n/uvore7MDgCfykSWPbGHVDN5W4/7sShIRz6R7+E8lUJSDfOxsEDQALd4QjeOYbfHrJZkhbUFp6rot6dtnzUjnCzTtxFGJfF2jyVCUNL0N+VTv9JXo8sA78YZQbpUBel7r7iLfFXMXPo3N2drQA5ezkekd3Nl6C77MXvwxBqzlLg7RkcWCZyO1STxBZUwdYt85Mmzk9yr/LjC8/mC1dUj4JlaoNt5lV9Scd2RSjLJ4OfvHJxsU5ehzhPqqwOI20gTDjBs7n9NPTwVAKBT1zksL/Vg7W21Bu0rLXxJkYOaW8dG+gFsRbED5x3/4NJc0YqtoZQTEy/RF+b3ezQFERi04xycQ41BkDX2wlwReK1yNAgCvL4W0itvKaZoFkZrTTYjJ7f2odfOU/kF9kaZTiet9TLefW2byWI3NRz3wTSZvE5iiD5cK48X7eI/oKVpDSiPYMKh4koipuNqNzVErcHIc/viB8NWoRzNJzFbPpiM1ZWU0cBvB+8Bd9KRsDXOtNxA09HDceL4htoBfaJux0Y4qyOGNPiGDLy7byLFN8XsWARJsPqlQfrZTI/l2K/W5DX5/YKNIb/93tMDmcVodhSpuVUyBCgs85JVgwjoaAVvGcbZjb/sFFXSXXXstCcrEhg1GxUjikMrmkJayVc7eMuESbhILezAhaUxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdpIqFY3Y0zsaN1vklIfi2YdwkZV4aTsEnXM/S3tW08FcULKySDLQydekUeT?=
 =?us-ascii?Q?VHvZ5fxOCb+HEyNQrcQEXIu2bHbqeSNfLyvVVmKuQy5Ykz0T4FxGBBX1/KjK?=
 =?us-ascii?Q?Aywm7SzX35FL2t0YL5escAwWhO2c2CpW5r1ABw0xennIvfQH7YpTi4DsRnHs?=
 =?us-ascii?Q?gYgDFwkIW1MN+RdgsZk95eQYVqZazfCz8lELFKUGwhbe33Fki+c4rgku4qAa?=
 =?us-ascii?Q?bOE4QDidPvA+7QaS5RxugFUMZ5YETmwz++39QtkSQ8MSWPMA9nUispln1SuG?=
 =?us-ascii?Q?IlMOyF08kHrX0OipWcbWPflX/5KIOp18tmYwOy1JxF9oQMbihxNXiJbX1SXm?=
 =?us-ascii?Q?SCLOfgeWOXxrJgiY2rfsEkhzfuflyearA4u2BYxrsmoWuO54/ZmIN9Om7373?=
 =?us-ascii?Q?PHfkz0St8fTrxpsXPU+tpc7mr9sMxr962J720EtMTNjTmupbtTALsXxFaGVn?=
 =?us-ascii?Q?sfy4eNkoFvyksQJUcVx2FZR6eksdlHkCwPrZpkQLnAhoeVC3XOT70qd+8n3a?=
 =?us-ascii?Q?wKN8izaL1Ca5z+dI14xCOWmcXp0Nyas+oIwwcJa9tx8Kva8ZOSQm4EcANGx/?=
 =?us-ascii?Q?PVAxrs2l+hSGNzJbW2v5Brz3tCNPvO89Yv300CTzDHNa1WtCFPDfKyazdN0H?=
 =?us-ascii?Q?SDmDOpbHhuW6jF1yIQNJTQG0PlZEievSKdLbfNoo1rZBekrmL1b9pvzGfgIe?=
 =?us-ascii?Q?LF6ADPeqvNQ/E3H60hYVWf+I7k116wuJ9l33cLtAyBBV6+CmvlKnAHA981ni?=
 =?us-ascii?Q?Egcvhk1BvgZf+ltd8RfgPwSqC0kuFeDrGTTvJE2SsJzpMqSoOjFhWp6Hur7F?=
 =?us-ascii?Q?haTyM6Qs36PZZALwt49qkDlf/iSa/VxS+vBqZYaZIMc/0J7yZpnYt01R9j/J?=
 =?us-ascii?Q?10IVy2fAPApYl59hNOawS/kjT9naVafITXKWwomvEDu8TxKMlIMJGx22EP8w?=
 =?us-ascii?Q?DcfH1WdH6a55mIzcoY8+kYBsSnlbbmHJYG6XxMQSvkWqA9Qrl6Wzqzl41fQP?=
 =?us-ascii?Q?/Shg0LJSgHnM0HWYgqAfVAxzo04eHCGxm2mt1TUfqyiQfbGIgQ2PK5xrmpwV?=
 =?us-ascii?Q?CvdQZgCehFdPPeiSdheeKzKrxTPgvfWxnmCr1dDKEb4D02WJJb4m8S8HLs9a?=
 =?us-ascii?Q?dAZIyS4CoP3ggspoLHBruwitu5fpNOELJByG2lIFgEUvZN0Pqb0TcBduOgxm?=
 =?us-ascii?Q?0lhnK9w7YmyuJR3ha4SPYRLG/I0Q0JWVK7C/7aZsI1rz35ZQKBWr2HqVZtrU?=
 =?us-ascii?Q?DiggAoLCwXF0wCpSvjijLEFiiMkvJ3hkCymRRw3j2zn31zgA8YESUKzXIV8q?=
 =?us-ascii?Q?FnO/K7gQfh9TUx3I4d5GA/6kKgmgmH11Hvb9yW9Cd3Fmnl0jK+RQ+tE89Fgq?=
 =?us-ascii?Q?yeoMYi6V3UtS4jMw94HQ/FEMIf74q0qF52bQBimKKRlejylcoKKBMRwAJOdS?=
 =?us-ascii?Q?026l+o5E1++BLK7JknTP2/qjP7l+rl9kCCtfRb61r+pfA7SSv+M/lZExWRbA?=
 =?us-ascii?Q?JL2BB+hkOvKdGT1rQudH80EKrwcJv99JbcvaJYThRPdL6kBctUk5/8hqW221?=
 =?us-ascii?Q?0JoaDuQjRwRMZlYFt9or182fh7wSUDLqetWry/3ML73I2GtgE0biLYai7NVz?=
 =?us-ascii?Q?edbH1vpEjKrs5ULTwP7mJmE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8461971-04d8-4f8d-06f4-08d9bea276f1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:44.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLPa7sDjwzFmnlsN6LtSXb5h+3rb08ct1EFC3Q6Q3PdRTAhuUheQAiGN9PaNtw3A9oLawqLm1WW4UFyYu7M8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussions here:
https://lore.kernel.org/all/CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com/T/#m3449390080c5a0c8f59b8f8286a87e31e093b98b
Marc Zyngier points out that the ls-extirq driver should have never used
the "interrupt-map" keyword for mapping its channels to GIC interrupts.

This change modifies the device trees for LX2160A and LX2162A to use a
driver-specific OF property for that purpose. The change is intended to
target stable kernels, to accelerate the conversion and ultimate removal
of the improperly used "interrupt-map" property.

Note that "interrupt-map-mask" isn't needed now (nor was it needed
before, it was just there to keep an apparent compatibility in form with
the reserved "interrupt-map" property). So delete it.

Fixes: 332b6a79b415 ("arm64: dts: lx2160a: add DT node for external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c4b1a59ba424..c12cc402b566 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -679,7 +679,7 @@ extirq: interrupt-controller@14 {
 				#address-cells = <0>;
 				interrupt-controller;
 				reg = <0x14 4>;
-				interrupt-map =
+				fsl,extirq-map =
 					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
@@ -692,7 +692,6 @@ extirq: interrupt-controller@14 {
 					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
 
-- 
2.25.1

