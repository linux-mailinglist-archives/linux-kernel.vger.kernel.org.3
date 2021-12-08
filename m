Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E790A46D441
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhLHNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:22:36 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:18166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234256AbhLHNWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:22:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOAfMoEd4v4om27BErO14jNmqj613ydqpch6x0X1mu42XV4QN9gyCKNCDD4/2dEZB8tljS5USJb9SmsJyMixoIIuV30JZtoREtoErCfb0Tq8HTNJLUI26mb/Q031e3dDKHjqBDhiBajVxOynpXGjmhjBoJtAstLFn3Qvs0tBuHp6o3HD5O8wo+bb4Qg/M70dNFCdtAht93783DQKNMlWDAQO381NN1nHT+zd+u4h7SfP96KwHj5Iabq0L3kKHc1UKuHELVuy+FjoSm97fuzkU75Wbjqm3+1zGXyli787i6BRonrcWD394l3CVDi1dWvK4VWrOmFlJ0KH6uXWpLQ4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo8gSVizQwS6+dRcQtdP3RVlX0f2ox0uPju9c3mkAww=;
 b=iyREq8VbxVqfD2qKLcx4JGT08Nyrp5TaH5AgeFSVKbZcUZSDoiPNKGcHeL7dkGzVK5AVdFFGG+pkF3hvIsMsZnTuMNKE5rGHxeteH2deDQZyIJFQU1aGlbxwicvJkEO6No4W6TTbcRFNq/5mGIMEtzU4o0KmR6KI7Ny0nA6ghUT2P1o++Y0+8hydbvjB8x4097AA2ZarY80iRzA13MV1E+32RBiYF9E4nv7wP6u9KQhAClDKvehvt/OjmXah8+Uu+HLkFEXvmRsQXiqP9A9ycBGm4TjtUu/W1mVDHFqffxO+aAxLogXtpblMsE/1xN82vc1lCML/fRLEcGQL7yPhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo8gSVizQwS6+dRcQtdP3RVlX0f2ox0uPju9c3mkAww=;
 b=kaDFO8dWemrfKlUFSu+bO9gi+lcmfXubZR7kGdU7SA9wxq1p4++XGsiqmNnuk259Zu29pwEUHWGpiUHUnaPZPNa34kdtaHctlr1qylGiuzjxj2dJ6a3H8agVdnwub9eL9I3yzvWO2KXJdqjmhnVRw5dDoLWiC+NSj5iD/Ag52n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 13:19:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 13:18:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/3] arm64: dts: imx8ulp: add scmi firmware node
Date:   Wed,  8 Dec 2021 21:17:54 +0800
Message-Id: <20211208131755.1799041-3-peng.fan@oss.nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:3:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 13:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9146d757-f9b4-4287-4545-08d9ba4d4ba6
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9496650C1E9C3F98D486F692C96F9@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EV8y4eOIAblrSCTIB8MrvPA6Ed0WYiz+n8gS9jw47col4B0pszJWGKA5Fb1xfDFaVH7jaHav4qUvyQxvnFfoY3hDXJfFzeAcwZILaexuFbuPAokeEQTPj2+QrK8GP5Y0mWPOI3BUbfze/rGaF4pOwEWig+uAeu8Nr4QJG0jwXSF3rTzQSPrF/WptD+Qlhzcwz5RvOFvbx0duTf6sCnztAptz0tnl0EOaDvzf1osVpVL2hObppdActPD889mXTaW3xqPK/ib5hdCnR/12kiTYSjguq1D1fXVQ7ePpGiAR9+jGHqhgpSXQ5ukUY8GrasvhIZErimXpJ09mp69B7toZpykJZQfPjmy/No3apamwb87iZHdszwyT8E1fnCjc0cmtX+ApKQ8cEvpWHPM0dIUS/Dk3pQHlypUtU1uC72iq4I6yjACF2tKxcYD6Qpb9k0gf5VYhvASaHgBc80SYVn/y4DdM4CnRsNEgettEEF9BPSbcBrv/PswNiVDU2DDWVGi3NMYDFLaejWHvEE4vYw7cy/hr7n95eA1zMRDkK3K/kp35vLNlMztQCx1+JTUwgyMJ+vct1ecw+7ItPQJ/U1BEJi3TczArpVI5XwI4smUANSrKt8W+ymwSOG5k5bI6TrUJVbNq9e0i0iEE55fjHKNE90irE2D3JSeDb/0pnN2u6ur6hGNz9yqQoxR8IQNt6LEAQ9bDSgXa+AXuPHxB5VVI8vn6MNAQeDuZ87b0xXrEMZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(52116002)(6506007)(6512007)(66476007)(6486002)(5660300002)(66946007)(66556008)(86362001)(8676002)(4326008)(8936002)(1076003)(956004)(316002)(2616005)(2906002)(38350700002)(38100700002)(508600001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9G5EjW1OS5Nuyf2NQnRccfA9IE663L5jIwBakQihCkQWvicVwonmGu5v52xR?=
 =?us-ascii?Q?nPiUsfTcvmVR4K0zDF/9lOEa4D5/4pWcQMkhRjQOIG+XlwJ0oID/xccoW6TJ?=
 =?us-ascii?Q?CrCaKUuJJVGqceOufP1Sn7pch5gTfQxeOOckWt4L5egn6C49wYpjF1Alu29C?=
 =?us-ascii?Q?Q0MkCbinarM6hW4HKH+PIBzTZcWtQTrQkWtNhMoFr19kMsvvYhgW12w47Y4K?=
 =?us-ascii?Q?vvdKFBLKL2bmEM0qF6x6roSx2J7i4hJl49RmYR6vNsV8A977LxmBB4l4GLxX?=
 =?us-ascii?Q?sKLv3zWyecH0bjo8quGRj/iwZZ6680X6zZNXbU0BtKyzHQKt7iScCmWLnHyK?=
 =?us-ascii?Q?SD+l1o/fjBMmsXzyEAcnRqLpvQJH/Hvjy3n9r51Uy9v2JAbc9pXEl6TYKnZI?=
 =?us-ascii?Q?+9nYy0GH1dcTLbGf1X8MWBRB+/Zc5ffKeP4B+OcGhiiQpMSzE3NleFZJqptH?=
 =?us-ascii?Q?dbONtsB/8lrlQyEFBhAdy/ufUzIqMj0iDw0tcP4tqqRIqU+QA+6MhFILaq8/?=
 =?us-ascii?Q?FtfVLrywcaZSkET4hjfnDwzsjkMoIlQ+4tRghkczYG16Ifg744ZIUx2aMHTy?=
 =?us-ascii?Q?g2Wl5VtfVVQAvdW75tcUmLqRTtRZsxgXHDabhBAdkkK30tHfaiiHGVotTzzm?=
 =?us-ascii?Q?qUgt9sknV8VkQZo2f9ky3zUPrjdl41nb2mGuzFvv66aHagaHV+/RY6qBDMWJ?=
 =?us-ascii?Q?5M6idQMfKqfe5YInB8iecW23nt/V45pCvRqYEX4VMnwYmaJbEAYtlQ+aFena?=
 =?us-ascii?Q?mPRCkj03H/xru6TG3xnCajOfVJzKVFIj+YqyuE93Fnabwne/Z83j2GJjEPyb?=
 =?us-ascii?Q?Oc+fRA1pxp0tEL01PxJZg2uArIVZDh24HGYaIwsIDWj5mlO+YDiLec5z8ctk?=
 =?us-ascii?Q?dL9loIZ1ag9D1r5uI9MA77YBJ+yZKO8k7woHJjSrspcWzgcTP6O7PLZxYIIi?=
 =?us-ascii?Q?tAexG3TqyZhcca0zlEuOqy4T+sXdYweSdDIZOyY3J2KSZ8oSPfsd5dWRlafK?=
 =?us-ascii?Q?vFTPkq00HF4S70z6+fVYpsTayXQ7yaScWQNjpsudNkiqmoNFL1hEM9u/C1tQ?=
 =?us-ascii?Q?jACvP13rVqt/D8Wly2poAw2WB0oEgWUhrvQsadpjyi9KubG/aH3O4qOMKxh6?=
 =?us-ascii?Q?DzNOe8kqjN8IsZ8RhSJWjt36amYkri3CpxbQwmqdCoTLa3/HbEyjoPryxXCd?=
 =?us-ascii?Q?mFdAbEIn+jHiIKWTqHKP7ny9flnMdTbe7ntOUhDCcwu210mWw+Z8euQ72voJ?=
 =?us-ascii?Q?kHR5XIls1dPw30kOoL36aw3MYG4hLTPtEBWMCsKnC8cJ5UhMfYp7+kGdTNew?=
 =?us-ascii?Q?o8KhKe8Nd9X02NUZ9sLCF4hdYHGPgy+JCFyvw8Wido0ezlRjHYof1kqDNJVi?=
 =?us-ascii?Q?xhWYCC5gMa0mky/BjafmyHMhURfD0/t7tB1G/drz58BhHaoM/dBd0KKAOeLJ?=
 =?us-ascii?Q?wEpGlegu33n9Pec/yqZkZonfJD2qxxByW5JyHfyQP3TDFHPorbav3s1K7AUL?=
 =?us-ascii?Q?TpShmnEMwxbth4H3IOG8+Se2Galbgs4djLPMA+OEads+9Pmq5DBY1XyysyLv?=
 =?us-ascii?Q?QB8cONBG3KFBJ6eUP0ky9RapQve/6xMl0rQA12nhNX/sLf4FWiOw/dnN2CU5?=
 =?us-ascii?Q?EbqwuvbYjms9+jG4WoCUuG4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9146d757-f9b4-4287-4545-08d9ba4d4ba6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:18:59.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzGKfA+HdUOU6KnWBunbTCribD7gk+V+eT7n+9HUbqe6/qWtce5qp1972jXxp+Y19eJEV97mrnVU30AtxtrwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP use scmi firmware based power domain and sensor support.
So add the firmware node and the sram it uses.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index fb8714379026..8ee040e3cbae 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/imx8ulp-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/imx8ulp-power.h>
 
 #include "imx8ulp-pinfunc.h"
 
@@ -102,6 +103,40 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
+	sram@2201f000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x2201f000 0x0 0x1000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x2201f000 0x1000>;
+
+		scmi_buf: scmi-buf@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x400>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0xc20000fe>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			shmem = <&scmi_buf>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_sensor: protocol@15 {
+				reg = <0x15>;
+				#thermal-sensor-cells = <0>;
+			};
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.25.1

