Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB754664F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358468AbhLBOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:19:20 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:13287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358437AbhLBOTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:19:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E49vuNyocRizMHEx9mS2vgRHu1vyOexXH9cRp/OiUtKP8AnSgW8HXvBr8Bx48XLkTsVG9PpjN8gJD/czVIIIwRTe4LGUVZ/V3ILZIoxJpwlc6DjoIYOs8NMiqVvWSDOfkIOVXWBXIed5Rh0xfgnwBHke4Cy4xbieiXtwAgWLODxBY6OzXh5sQ+zoqwlw1BBE6O+m6C2A5JCcmsTeGHE7Y9nafmnuA+gjf6LQvpVTxp7Q0ijkvt6Q9ojNxosaaMuIDnDk4XcFb98YbL/RJfsLNrQC6uFzbIPNd/B7g/OJDNR5a8beW5Mxm6GUoG3ZgPvh1V+QuLVFnJBVjAgoVst5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UJ0PuY75BMEBDgv0zV4OqedLzT1rSTO0gbgps5hHxk=;
 b=FZhsrgKsEwkQJG9B70zEV5pX/PieQu+zYOfojg+48SjpBuqRxF75GxmyjYZCIMlgpQyOUxe/lW+1wJY8bpbLToQp8Cbbr9SnCwU56ex0IEuqCUIg+NIJBtzIx7smO7n5fw7ocf62FLOoTVC20ipHNByiNw6lGPNjOl3GYpLCFhUMLg9quKbzDqcvYmD0H/PHxBwKpzJjdDJCKaWGHwOpqOFp9LVXJqUm/NzHrA+UncWKZ3TY11AA42R90SNkaIsSZTybIGkJc/LsVoo9ggJbEeErhP/3bAlmtk20pzSkeekBypgWuj85DWn30WtV+L4Twz2IZud3PNdTq4UL44iZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UJ0PuY75BMEBDgv0zV4OqedLzT1rSTO0gbgps5hHxk=;
 b=lojGY6YyG4HvkJHjNPzosJjkgWHP67AkRQHJ3CVgF/ctxyScEl62YRD6YX/nezJ7FnTnooUw2hOsCAsPynuoYxcf6ydJZUoV9xf/EENtNjbPYywVPTBTzFR6bBTjZP/qCp1stBwgVZO19T9LzQk+9IxosM8XO6JLTABeJWbBEsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:15:50 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802%3]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 14:15:50 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/4] arm64: dts: ls1028a-rdb: sort nodes alphabetically by label
Date:   Thu,  2 Dec 2021 16:15:25 +0200
Message-Id: <20211202141528.2450169-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
References: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AM0PR01CA0110.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 14:15:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ce2e17f-3f5d-4315-2aa9-08d9b59e3e18
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3838:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3838B2D67B8C5B77C0A44DDCE0699@VI1PR0402MB3838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKwqtPRRqLutEykLGJrKRYCci+BrokjSx6ROSg3cjLHStt9asFNxlKVWynW5RvInmIhr+rLUgs+oViGc0zhaqCVQwJxO87zWC0cqIwRAFoMWp2iW9u4xNibVRuK6pHZX4v1ErNiNKQ6l+QGBGOetB476sTb/rXm7L8wI+mGnkPdGt1yBwN2YFHA3ujKld+QC1vnhh/8PjQsYDkc8nNbCKaAzhfzilP31S9u9bo22Jcu2em1nO8iCr+vvqBPIdXPx/decxCk8S55vPNrn9tWX3HKkt88oR6XqRaMwtkojqxZFKBarl/kcZUaEMfqLyoUvhFqkj5RVlgDwzKY2eK/2NDATmSKWJWTBKfqx2fLwdeTjCrzIvkSXGR2EVuHrh3SVWIuCoyTuFzGJGQ43Snh8wowxnZii/84d7WEDH4FBXccEZUEBrWVf2GfpQgJ8U0JnZIe+9huLLBg26NthusycXs1Fh/kjki2lJmZQD01d83RobLiUdS3akU3HS2z0uH1RETwpXG1ZFmO6EsrQY5jpZI1i85D1x507FWGVE8pBYTL/zDOaz1myAwJbBxg+bFlGhI9Lff9ctwEz++CCUzhRYxHtrWLSsE9YV5IFeMaYF2P6OzFAHxTRnyDExxx/B45DMTiSDoi6Twx1zJVygVmM+eiKdpQGqHAE73qipggXAAYfunriEtzNfnQB3GqnabIegllVfAfM/3K7eyi5YwPNqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(1076003)(6506007)(38350700002)(6486002)(44832011)(83380400001)(6666004)(186003)(66946007)(52116002)(956004)(316002)(26005)(508600001)(8676002)(36756003)(6512007)(5660300002)(54906003)(38100700002)(2906002)(66476007)(2616005)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HpAF+A83Im0gH4eAiujq++o45ollUaS17Bt17kWrrv6cOocGMKiOvIdZd8Kh?=
 =?us-ascii?Q?i6sahx3yzWWmUQBpuTLyFj1aEhQnv6XHyfTLRNRLNnPauGmtabprJD8G4t7v?=
 =?us-ascii?Q?d+x8T0oM1I84C0pgEz8Y0xsQPnROeUJNfbTI29ahliqzk2LNUx2Oki5xKFvh?=
 =?us-ascii?Q?O9SHUT2sy80I0fd9wNGzGJY6wo69I4Lkm8SsE8RlmeYO9s5/lVNHa1f6NApk?=
 =?us-ascii?Q?XJOUPQEDRi+PqCjKBS890eW6GMMHtCuh8auPHHWmWcoYZ3WOt4Hs5xB1mfo2?=
 =?us-ascii?Q?fJbL/oFDkvoAww3tk8537cIR6+FHzgGlc9yZHmq+Swz2U6WIMNPP4zkgOO7b?=
 =?us-ascii?Q?px5uGHPrUuLS97TjsmNF/Lmf4Y999V0H+JWkwLLJqPELkL8x6bmZTHxAyI9W?=
 =?us-ascii?Q?UUVQiR5ThEf8eXIeB6TPvsu32hgDSv+EujrfOHt7n0JEMzxAoD5/P+BvGS3I?=
 =?us-ascii?Q?pqEMITSqsEAVSEP3clDFVVAZ2yId05HLx4p0Ms4XPBpQe8T4iYMtuax7RhL2?=
 =?us-ascii?Q?sUP6OtDwU0fWygkg9aj7e1VX0gft0XifpEvKN6I89BzsZnvxjZomiRrKlM3f?=
 =?us-ascii?Q?lvcjdYWruzrMJpeMVXcb6Xb8W6nCUnLLHny9viM3tOS41I0m18UEIG1Ot0VG?=
 =?us-ascii?Q?qwrbnFPLt6UANcWPL0j6advQwxdAaVArXRNPJQ9+EXI0FvtIVEylJBspCO6x?=
 =?us-ascii?Q?E8qwyfBvkKLegiwZUBdVNe/2ykyL2sNEdCfohYsCCwu1q1mn7TTjec8qulQI?=
 =?us-ascii?Q?XAIQf/TpS0sJbrcW/Cq61kCvrwQx9GvgxHp7G5TQZ5cEOh0jYfZHONDkslt/?=
 =?us-ascii?Q?agzYmbA6I/lyXyaswqL4R4m/pV4MrimUiq6P2Fv0S25U8Kuuu5SKUKXvuCbW?=
 =?us-ascii?Q?WmUVs3LWT8V/jBFc0JfE27sTX8iss9rgL8r7DRDRo98APBvj1WgZmtNPkJrJ?=
 =?us-ascii?Q?69awOCqAoVREYsAqTDVOJ3mSJNODuXbnQSqZ4j7Uto9MRz809J5MIsUiKw+B?=
 =?us-ascii?Q?ML5/4l4ji23xQdna9CbJIKX9y30DpIIRr8WW0kJM5kI7uRmJksuPwTO0Xnlr?=
 =?us-ascii?Q?WKIJwE9LvqjDuFPy1Brjo8ktCBNPfuC6iUP17KBNf5JxJifioPrg8qB/SyHS?=
 =?us-ascii?Q?HjPkVNUN66kcf5N6Yf0YULO1B0sg1ZYIENffJ0FgowtqpjOMOFYGCb+kqJJ9?=
 =?us-ascii?Q?8/o9dDZD/CDR3ltINTNJnB04kP4D+LNoiP7Ejp7Ldg8MMY6zrKkX0bQCMN6/?=
 =?us-ascii?Q?8vbVWCgy5MiqxwtGbYzzt1F1THEEO9DYbEXc0Sp17f8PfiBJ5tWl7Q0K/Y/0?=
 =?us-ascii?Q?ojA2p64h/ViJ3TG83Y6LrNS60eaNPbZ96Pig9aHLzL2TGNI3iS3VFpIKLr/n?=
 =?us-ascii?Q?BZnGyqga2N/g7E6KGfm8ESlQXYnNwttAI2a9Rs9Cz0dYEguFdfJCAaoDUR94?=
 =?us-ascii?Q?nMYu66TYjVwZPjXE7E3XULEjeUCdPXIpL8IQTpOWGD85tEjUPTOEu7b/iYSp?=
 =?us-ascii?Q?iHnSA56CB6VJrhkxaU0w/hzFNfbwZo6e+hZYCStIP/LUXvl7e0chuZ/n1Kxi?=
 =?us-ascii?Q?K9F9SjlCH/sog6BPoioBa11HoGESl7DQySXu1sUuZHKLeLF7ul8xPfQVAazm?=
 =?us-ascii?Q?F5YVi2nqdRytlYee37FqiSQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce2e17f-3f5d-4315-2aa9-08d9b59e3e18
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:15:50.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OiYqm1YcS2ROk6ZgFmLpELcFJ0tnKumF9vb4V1bU8mJ0zDAnJ/zu9NmDNpphjGbE+HHTcOJ+OtkR6VFrF0SKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for this board's device tree synchronization with U-Boot,
we must find a common node ordering pattern. Alphabetical sounds about
right.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 7719f44bcaed..a6f41aa9004a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -102,6 +102,48 @@ can-transceiver {
 	};
 };
 
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&enetc_mdio_pf3 {
+	sgmii_phy0: ethernet-phy@2 {
+		reg = <0x2>;
+	};
+
+	/* VSC8514 QSGMII quad PHY */
+	qsgmii_phy0: ethernet-phy@10 {
+		reg = <0x10>;
+	};
+
+	qsgmii_phy1: ethernet-phy@11 {
+		reg = <0x11>;
+	};
+
+	qsgmii_phy2: ethernet-phy@12 {
+		reg = <0x12>;
+	};
+
+	qsgmii_phy3: ethernet-phy@13 {
+		reg = <0x13>;
+	};
+};
+
+&enetc_port0 {
+	phy-handle = <&sgmii_phy0>;
+	phy-mode = "sgmii";
+	managed = "in-band-status";
+	status = "okay";
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
@@ -188,48 +230,6 @@ rtc@51 {
 	};
 };
 
-&duart0 {
-	status = "okay";
-};
-
-&duart1 {
-	status = "okay";
-};
-
-&enetc_mdio_pf3 {
-	sgmii_phy0: ethernet-phy@2 {
-		reg = <0x2>;
-	};
-
-	/* VSC8514 QSGMII quad PHY */
-	qsgmii_phy0: ethernet-phy@10 {
-		reg = <0x10>;
-	};
-
-	qsgmii_phy1: ethernet-phy@11 {
-		reg = <0x11>;
-	};
-
-	qsgmii_phy2: ethernet-phy@12 {
-		reg = <0x12>;
-	};
-
-	qsgmii_phy3: ethernet-phy@13 {
-		reg = <0x13>;
-	};
-};
-
-&enetc_port0 {
-	phy-handle = <&sgmii_phy0>;
-	phy-mode = "sgmii";
-	managed = "in-band-status";
-	status = "okay";
-};
-
-&enetc_port2 {
-	status = "okay";
-};
-
 &mscc_felix {
 	status = "okay";
 };
-- 
2.25.1

