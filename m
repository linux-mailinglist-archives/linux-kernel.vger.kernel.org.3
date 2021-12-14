Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB5473A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbhLNBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:48 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244687AbhLNBim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOF/RmkOnWbi9OheVCkd8YWxh7sGpaA6jpfiturOk/fUnnU57lRaCQqEZ7HenB0JtfRqrLugzTJa21UEx8sDi88fq9JphgHrC0D09f0gpJMdazXP/TqqmNEUjxZ3tNvLa81epo4LQVOPPNDrF1r3kX6Rulm/dOJR7z3+Px9k0nrMajKa0iPkvKpr/Hr1GPo7N6LOF/Vt5zGnQAwatB3KqE0s22vZf7z7M9XYWGliMr5kqijB1j+15qIno2yfwRHV++DzixAthj5sKgsqnecJUEAsBmrd7zcIzOJKQdlV51mrRrusz+HDkNC7+XxaXPk2zNx/NWzwQ8e7FMKkAzS7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqlPbn4G7+DWqsRzpvvo6bc+H+cb8p4QFdsgeFM2Jbc=;
 b=TxNDwLxy8uNTKGk0fiFPXMNEvm5Q4BFOYi7LWKjJYh6aqQ8i+Z759cCfTH9Rv39iY8IITDT6TngJIqKy16hbKn8YOOKFSnkEbyG2oEc+Ta28/PL0V6SIqtNPVkiUaHonf//wmoE/A5J0J5iv3QNLvvKBCTwMmTuChLqu1bDVw0G7oY4v5oAX7ikcDW2r2SVyPXEPVhGJuFCUvQImyrrlklOesbMOoQdoeFGk/qq5Dq+HVli5JruwmDiWTSBQiGIzd2Dz7UE17y3b+/Hm84AuHjL7eWvS47XktjNAVyVY/4dKSOLJACmZ0BMEJ592I74Lq2Yoy/8hsmExlc1R+IYV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqlPbn4G7+DWqsRzpvvo6bc+H+cb8p4QFdsgeFM2Jbc=;
 b=IccZNhn1X7goAecysJo66846pfuYddtk63siDzt9a3jiUmSW7cW2XyEufXujoJmqPGV300our9ewmrNRQbNYOksSjQnh5iOAXuB/UP/slgt7h83FdDJHMQeElN7nl4foMkGQ0NkfHBx0MdsOGgcMsClRRo/yhNhwW+eq6p48ceg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:39 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:39 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 04/10] arm64: dts: ls1043a: rename the "interrupt-map" of the extirq node to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:54 +0200
Message-Id: <20211214013800.2703568-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05c6bc96-5260-4f56-e6ec-08d9bea27419
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB694483FE7184DEEE2CA5C1D5E0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVerSN560qQqqWPFtjXaC2mL0Sx11MkniNg33t59C+SqUeMhtvvXt1/NUP1qxAsKnJD0zl4q54lvzl0plqz6ab7yMAOVs3YVMjqJkvzbc+ZezZlWmw3BP+O/uSOdqxGbRtmqxswJgxdHZLwKZJGa/sBS+Q/iwUJnkKjB/P1Xtrv39XT7UzbJrJax9cXPCubMemFpO4yui7AVI2lMDJk0Cnz2bMjUaz5WSQWOnPB5XLHmJYUAGJO4Z+ZfP/pszxKLUDEz6fCe9ETk3UPLNsYw1Q4WmUav9cQsqMoN8oa5F2j7k6to4X686fB/DoK9q4Hw8w7BHBX2Ugl0SNowFewgqo69IL9EcoCN25j7JdvioeC3n3oFoArkPHgzwMitN3nPc5CS9O0iT+ZPoAhoffjkHm1UZKbv6g6fMJW+yvSPfD51spxGhRb7llF40VcDiDweBxhQRzg3R0mP1NlgsdTHUsw2xkZvvzJrQMmE4IZFC3wr7LrY+WXGR2zrTCrpS3ROiDGpO+CFP1FIEBOBRTqIDcARos+DlcL0na68Fi9rcFe4tFcfEX7mxdtjF0BSkLhmHWp33gBVx5+Af49FGQYcarKPa32I/0y8ARap7QYBuC62gGdcv7ukgsgT49QwUt0REwj4YterHb/Bv8fCV18kB0ptea6xYJTCLGSt52G0j5o21Abaj2rBFz6NNu0jYhuFB8ndppcKJDpLklITWFQ9RrFKVKKFCisVSWyAeHQfYWycxpfq20dZFs+3GWDj4DTSD0kEqULnBRdZdeNaMrMOBQQFgucSfnIeE8saC6ByJFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKM50s1fghKnaHigu7hXDeY6ZgUnv3Rt/BYhc27Tc8cH/Yvq8PUd7kRWaWGa?=
 =?us-ascii?Q?NtUvcKML/qgngH//AIb4zSL5XqW155caeESpqNmd4/520pgfyvkYqWKaPT2r?=
 =?us-ascii?Q?/PfC62K2eu+n+QavABUI66iKhyZ2sYNnT84E5Q6TZRB6cSFr0jRAe/4hFZuL?=
 =?us-ascii?Q?TavxKd9FXgsXqomzquiWDcjnlMJmw0cl8kZw9NUXDp4T3PlG/FWH86sTYipr?=
 =?us-ascii?Q?Co1CCza0Jc7kR5+Ou96RR7BlngDEGuix1MQydQCNhyf4YA0Vx3gMUUSa2tDm?=
 =?us-ascii?Q?fgO1ZOwBt/QgAnrOSq/7lucEUU2K93nuzOOrigU6RXyhNoZHJDw89OBlC64p?=
 =?us-ascii?Q?7wTbvszLqmtAZbZNtyW6BmhEdJ20pbaLYasbYr8YAhvTXmV5VWRpHS3ATP80?=
 =?us-ascii?Q?8DnQd0mRnlEA43KDaO9DPL8Bm66USjjYLvWjGNWfSLhC08yabYFtMZ39q0MU?=
 =?us-ascii?Q?tViJs1EmRixWYqM+Le0zH974NHLcJMLMKTJP1ue4A9Apxk87oUCUsvF0bWP0?=
 =?us-ascii?Q?pC8hkIvNQ25sKrQobS4soQfeplimsTTeBL0KQnlZfqUpVPC9zyhkeUW0+gkE?=
 =?us-ascii?Q?kJOWZLcYmYmK9Z19Y/h4KqjlqDkxwjpuLAuyLxOSJ2yVZj+EDR6yvshVu3Qm?=
 =?us-ascii?Q?KlHSS/p3IV7mNbpRFENZFQQl/Qkh7FGIHbCOs2i7+d+cvqiA+ebddVLYWq+J?=
 =?us-ascii?Q?oqGLVAhJiTkEAILas+UkdKnjMmjqvsybNAoTFXDZvK654YlYF3dJLIv5q67K?=
 =?us-ascii?Q?4y+vKpYasDKRLgAnze7kR9Tife5HWXDJ+yfteL3woklJoAN/un2Ngr8Wbc9p?=
 =?us-ascii?Q?ipRdLRkHgobSQm552lpvHyy4E4QX7qnQf+z/ZLm6uBgD4iiw40JHh1OfM8mi?=
 =?us-ascii?Q?mFJ5uzAo+RlTTYsE7W3Jd6mwoe0stUE/WZlETUP/Bmyml5448FsVJ6sbEcbI?=
 =?us-ascii?Q?1SUIIHbZNUpug+ybf69NGPpejuIhPiJZRUCWsrfMmwqNyuXdj4bAxgNUudi8?=
 =?us-ascii?Q?U31q8JoTGBqwFR/ni3cwm0mNI3w4DoAWO59g6Z5vsSplqAzcnkkQQ9Wm2Zlj?=
 =?us-ascii?Q?tQmTcbE0kiIix0liu7OdYamCamCZ/UODI6uWuIOu03RrEr7Ffn3N967bMQlt?=
 =?us-ascii?Q?CQts/O4qc4xq2lCG9FHjpsrMO0R9AnTC6IgP8uaKRzJ5fzpLpibiHI7T9vnN?=
 =?us-ascii?Q?CSu0M0mRrCiioVHMcK8ejshQqLDFLevDqNFKOfgm1yABuLy8pBAj5pbupP5S?=
 =?us-ascii?Q?R6uiaDItvotKI5vIteEkc7U8QK9LS5RY7a525DCpYpCUgDAFa3a0Dj2Sln1u?=
 =?us-ascii?Q?cajeuzKTCoiT4Q40ZzgVUHLMmm6HVxPo7iz9P92pAczIAetskFRk4Iw7JHuD?=
 =?us-ascii?Q?yi7cdmVVcmye5Ld+Y2uEHFr+SR9EP74Q4ZQsYYVNH1zrkhE7F91SCJP1CyX1?=
 =?us-ascii?Q?u1139O9ToIFKHePqiLqn6/J+ZMtwxhpiBdKBP1gJGqvsFIEkrDXOAX6N/pD3?=
 =?us-ascii?Q?ATm1eOQvvPt3jrRKwpYMza/4tXCwG+Vv403hDPC7Ez6VkiSQhHDf2aGNRHQK?=
 =?us-ascii?Q?a2QTuO5ISBYK6OO5DRzZrPWKHZncmk3jVqsTl7iN90zi4/df//rZRiDUCnkp?=
 =?us-ascii?Q?fO29y87ceQoSF+BU0B9CHlw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c6bc96-5260-4f56-e6ec-08d9bea27419
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:39.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soOXfQqFFPV6L2cc/uOHA+mGabu9Pba3aKxN1j7f85qkgXWNmFRyboikbXqIAQx2WsClcNd15Y0asGOx/wEKVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussions here:
https://lore.kernel.org/all/CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com/T/#m3449390080c5a0c8f59b8f8286a87e31e093b98b
Marc Zyngier points out that the ls-extirq driver should have never used
the "interrupt-map" keyword for mapping its channels to GIC interrupts.

This change modifies the device trees for the LS1043A to use a
driver-specific OF property for that purpose. The change is intended to
target stable kernels, to accelerate the conversion and ultimate removal
of the improperly used "interrupt-map" property.

Note that "interrupt-map-mask" isn't needed now (nor was it needed
before, it was just there to keep an apparent compatibility in form with
the reserved "interrupt-map" property). So delete it.

Fixes: 3f8c61a567eb ("arm64: dts: ls1043a: add DT node for external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 01b01e320411..62958b784171 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -322,7 +322,7 @@ extirq: interrupt-controller@1ac {
 				#address-cells = <0>;
 				interrupt-controller;
 				reg = <0x1ac 4>;
-				interrupt-map =
+				fsl,extirq-map =
 					<0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					<1 0 &gic GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
 					<2 0 &gic GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
@@ -335,7 +335,6 @@ extirq: interrupt-controller@1ac {
 					<9 0 &gic GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
 
-- 
2.25.1

