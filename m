Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23665473A53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbhLNBjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:39:05 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244756AbhLNBiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuFtfuNPd34wG0P7/iH2G612EDJFFAeS41iyupTsfxG6ZTYDmYMI+X/HvZdTQTyo3CTDxzLWyJhhMfKIV9Bf3DLt+c9g1epjJB/480cHx0VXlGvFmFcJiEC+CenKS4JH8VuTIIBxOJksNwAChnJZ7Wt6YDSkMy2CtLV4sBGSvqw+UzbNXNPWuXJmGLWEVXBUjP3nEUoWysoNsCh1j1vbU6PcHK8uOtIM88zM+AAM77MIPp1PBxfgl6QZC3TvQ7DqCYXBXA8bN+w/2hm8c3Xq8OQGnvNEzG8s1PUvhykyBDcuAouCKc/ywcl47PMFF+Io00aSS3ywpTIeebl+MX/f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0UNsIJI0m/Nb4/xKbSWXAP6PNWwvv+hnfLAaoAMbzw=;
 b=L8/xz0iPErHOJZ00V35ganoNRIaRjf3onY3gSzTNtzKfT6ekqWMVYIbchhiOkVaLISE9n8WujwNBKeYXL/lepPzjLUO4dONaaggjuVvh7n3cKrwNd3pBznCoyD4FVRWulvj1XoUDVxO6d9pZxTuFrXZfWw5W9NH+2rpWRaj2ValTb1fzHUUNOTh3yAv/IY0DZgmnsRCKa8KDJtum48gclPHK9qOGLcqTGbfz0R6Vn+eHOF1Vdq1QE+OyL3ziFRWk35SEX5zSJ0/8E6FJ5TGdubYEevn/SydD8fIrA0lMSSnzqNwg2BqtVI28VS6zH3RrYXpsoylSFBBknybiVaDNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0UNsIJI0m/Nb4/xKbSWXAP6PNWwvv+hnfLAaoAMbzw=;
 b=X/zjMo2vezo5i3YN83rXocn/Rguf59G5zTvoNsmQh2bgSU3nkAKb21V5qDiZl2S/9pKd0K+fozIH4H4DWOCqIlx2kThiAayNG4efDVEbtlw7YoWqt6Qhot+n2jEm/MDs6sTkIWWH85kZ0EwnVh8O3hceVwZu7beGB9/tn9p4iAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:45 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:45 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 09/10] ARM: dts: ls1021a: rename the "interrupt-map" of the extirq node to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:59 +0200
Message-Id: <20211214013800.2703568-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e97306ec-62f7-403e-9899-08d9bea277a8
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6944FA4EF378CCDB9754EEAFE0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PIWvZ1KxkodlaS7B6CELVAOnhDGp6kN46AUAng6dV52RcJM7IMeUDjvu5GWzlXA778Y+4kBOnOzE58aHILAAl++vm8+QqkAZX9UOqkxqle6v4qoQIJhv/RUac1Rw1+KO2xcuphBjoVs7+GN1BB7wEelfp3S5QI/PbV8mXWUk5O2LHH1eZXUgAhVrwneWcMd+oVKCnb8CsCqLn9IG30ZnLgXdmrJZKnuVQUS3qj0nw/MBMDoLtAT6gB3TdBd/6YEIMfjc+JjbKNyH2I1M0R7ZQJLQ7cN6MtE2Oajv+PNS4W85vhPsh9uaeSp+zXK9yAzV/X2v1593RNITyvcWsGEYUyf95FPiKzb9A19rkoXySqlGyfEsSa0U8zEbJnl4U36PC2LgiBje0h0sgi0vKGOG6y3w4iWMQCb/Lei4/rln6el4h9ffn1fvyGd9rWG4MmPxWh/JRQ2pS60DOyxX+IrUKwCXN/1ppaHtK2yJhcTYmbp4wBrWtXRqk2bsE7kod+zKVbFi3LSpyZ/WvDD4CRSGXHpWSim17nJvLOQq8zeV7RBtfELrGtRp2yN+WLu1sopVxhEuk/DofT0xKGDtHYhaMVa6sXXyi96wdRW26MuzB3Q8zvDBE80BQEHDTSHKd/jpoBgwI7V184JCYLCY7963aMiqFcynKxUrKdhXjUBGA6OFFivkUVJYi0G89KmpdkSr53l8/oDeQ6ZMKTfb9dyvSRq1X5ROqm7N49K6N6Ix5L6hIXwneE6JRqFeCGGYVgBtYE72lQFLWkbWYM+3N0JfXyb8xzs8YlvKvR05RHfIMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAoY6XLwiO0kFBTaJnk8Avg/+Vdc6Tp7yPlzxp3R9/j0Ez2ik7gKbqGnDAxK?=
 =?us-ascii?Q?OToHp1YczI5MmW7Y9Gh7i43JozhRWSyzZxVCvdl/dqPAWzbDID3d6MNG51iM?=
 =?us-ascii?Q?+vsaMoa/UJ6dFL9fWHRARrqRGvFGogJofjd1HzUcvBqg6/hA0SOQvcDcs8hl?=
 =?us-ascii?Q?9saEFCGADfDtxlAqurQglVW0rs+cXc+NvGiraviZU7eIylzts4sMF0Hyufj/?=
 =?us-ascii?Q?WxSD2aktpNl/2FNfNXlYYCkaoDIAdBKXSnkVhlPnsl4mX5BtbJ61GbarK1M+?=
 =?us-ascii?Q?2W56JUg1x0ov9+AZPDDE68urEqf8BV3ojSpcPDXq5Eg7Il/klN9VItIwSi84?=
 =?us-ascii?Q?HD67k3z8RtiOvkyVIBbkP0uuQsAZPvpM8/DXZJxz3ugk9GCA59xwl2HheicL?=
 =?us-ascii?Q?4aLce6XGrB6lkaAsiNJI5Bgapgg/6BqolR7BIhmUwI44/KJMyzb1OmBbgqas?=
 =?us-ascii?Q?JnMpelZv3fTvnasRkuKw5jPHG69/q9ZQg++Og5maZg74w0WXYTyGw4T7ygGr?=
 =?us-ascii?Q?3aRthLhA+iAHKal77iYybo+GOjb1oBp07hwIp0j65eflNxI5kP+n8XYSgqAc?=
 =?us-ascii?Q?YuCmZ+ZqLzxmwvn4NbhoIZ3plIqhez4rNQctB+uBir4e6JYLP5Rnfvd+npsl?=
 =?us-ascii?Q?VuFXB/6c12zLbEeM1wUUzj84emHDy+pbcTqkmQDCqyOgifAiuHLfb73ZieDz?=
 =?us-ascii?Q?l7Jezkz4EdL9OESV7QHMM392xQRDswoXPWxTQ5y2LGU/pOoz+O+U+uQj6SXq?=
 =?us-ascii?Q?0H4FOUBW9C/j4VO/cPYazh77YDvA1xqsQxhAbw41Ee4zNse8a+nsEBJUfPxz?=
 =?us-ascii?Q?e5z8CddpSzJJycDLjUVmfGfy9k/6ZTbAj9qA2/AUEBC1SPrOWa602GQyFnQn?=
 =?us-ascii?Q?+7ey4v394XEBjXoIqH0isC7l5L4q+IGWqK4geIVsJaxAn+/VM2WTHKfyzHY3?=
 =?us-ascii?Q?OGpxlr0QUy8xELfqhxMvfN9ABoCu170Zzp7a9yH/SFcwRDjlM1kVljQf8by+?=
 =?us-ascii?Q?XStlXLHQbaEhAeqGbYd6lsw5uAjJh99EKBIDUXB0/giZqdEu/Y26VlsEi2gy?=
 =?us-ascii?Q?07mPBobBY458ywbsOC9hztYzFoPkq6T13bV8iuJzyOCFm165omSQQBqWBfvN?=
 =?us-ascii?Q?/QfLLBNzkAMAsGJJ+x52OGTR8WC4dgerBO+rwMfoEHLEnmoKSxvWCVil/GJU?=
 =?us-ascii?Q?fE0CjO/JTapeRirpTvFGbi/5WNNoekiKvwXc6IHfukdcXmlOThFHzclsZlCx?=
 =?us-ascii?Q?m7cKVjax+3EFXwYyG7JRpD7MxJu2Tqi3AJJAV3h1N/qPxI1oJSnu70qIwRQn?=
 =?us-ascii?Q?ZO1yu9tWDuwzPd5ECvZN3cMuSD0JQREUCyDpTTtBR1qK3OqRFaIoYDBtXcO/?=
 =?us-ascii?Q?GZJMLoL2LMWJrh7d3lc8KMi68kIoAO4OUSnfb7+E1drkfu2mdA1UBClZCgmA?=
 =?us-ascii?Q?KfT6KTtase5PkHNMb5RyFlkgSBMqgnksCWroNyLz2GHV0InuyKFiEqwjsKLG?=
 =?us-ascii?Q?MxjamPoB0q6/QeDa/Y8LEmLOiIsk+Wim+LtqWygd3ir9V+UprWNXpAagMyB7?=
 =?us-ascii?Q?XArX2wr+f7v3r6X8gHAs1yVm7CyEM6vtTxqGwPkGnAnH6I4Fkxrx8Gt5ANJT?=
 =?us-ascii?Q?wsqWlYPIAnmlnK2imeC/SO4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97306ec-62f7-403e-9899-08d9bea277a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:45.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDkSJSJ7qt5fAGVrfrkzQuPkHKUCN/Nf5ug4eC9NmDrmhQg9qQGbhgs4FFlxQWGCsFHb/YE6u3nvK3Yk1BJPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussions here:
https://lore.kernel.org/all/CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com/T/#m3449390080c5a0c8f59b8f8286a87e31e093b98b
Marc Zyngier points out that the ls-extirq driver should have never used
the "interrupt-map" keyword for mapping its channels to GIC interrupts.

This change modifies the device trees for the LS1021A to use a
driver-specific OF property for that purpose. The change is intended to
target stable kernels, to accelerate the conversion and ultimate removal
of the improperly used "interrupt-map" property.

Note that "interrupt-map-mask" isn't needed now (nor was it needed
before, it was just there to keep an apparent compatibility in form with
the reserved "interrupt-map" property). So delete it.

Fixes: d27f9d634c9b ("ARM: dts: ls1021a: add node describing external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2e69d6eab4d1..1efdfeb9c110 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -185,14 +185,13 @@ extirq: interrupt-controller@1ac {
 				#address-cells = <0>;
 				interrupt-controller;
 				reg = <0x1ac 4>;
-				interrupt-map =
+				fsl,extirq-map =
 					<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
 					<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
 					<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
 					<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
 					<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
 					<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
 
-- 
2.25.1

