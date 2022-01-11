Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4448A66C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiAKDgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:10 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:17636
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347260AbiAKDen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxpYdZByw4UsURPzVpCpeRafemnaQU0CwNXZZZC8DCDLk6o1RjNZEO3nvNpIAKHEdwW2T7Lc3K/rfnFZPk2yY6e4VnQHX4IMzBr+kKEq4E+kUWr81L6mBbxDrNhRJwT/+Vr8ztgJcFmg+DXqMV+HJo+fgANH2b0qYGNP6LbkMODxPcFcC/HfyKdpB+ohvbgBoepkuu8z2w32g9MoDTKILLk2ijxXVWMM2vK/A4K+nvlCiEs7SalDs9Xp2tDxoj9AbAI7OdhLK3TQ4AKrPjI/3jZyJHVRt3yJLMGJAmuUfuUGJiVyYTSq5o53H9PaPNPNWjmBhPk3EndnkT68QI3enQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgzoVi6qGXf3HsT3PvQ0cZB257NnBoVOptlB7T/+S10=;
 b=dPrqjXAevP+UDcWlkyO5Oodpe37X3WgIMKdvzL8OujjXwlEaOqQO73fbd2o6V3QDMZerH0//RwSMwo6phhtyGMwCqVlvLxUAqGfpkzaqDOUdYhf3lm1FYyD+NNUDJM8dGaIlRqQfEt4Qw475YhVHZLiMUzRKy2Iu/iQhCibtAT1mamgz6wupx71FtZiF4eUiN6Zes1aKkar6IVWH62tLM6oqEbwv7+aM2rDm76QatAsu3k239/WvRf8kfB5v6Ek3ochHthNmrGjKRz1vjHWE5Emf+yVo+WAVwyoJe1bhSifjCOlljVuJPD9IykVZWiPLBCz/xa0G9jQzz4MFL2OHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgzoVi6qGXf3HsT3PvQ0cZB257NnBoVOptlB7T/+S10=;
 b=AAUV0KXwBLuc9YiZJikhdTz4keaKjoouxpTrVSqMisAqMJgO4bD6uGQKtxoiVQG2ay1io7xDJzdNi4FJhJ8QXewrp6PU77WFP6Fh+2NMbldTlxXOxW93H5SLlpF4bi3wGYePNS+gRXQrJkabkzT+vUAQcwLNe2BDB3wCInYUUMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Tue, 11 Jan 2022 11:33:25 +0800
Message-Id: <20220111033333.403448-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc064bb0-3ad7-4c15-47c1-08d9d4b34d22
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB87253007BECD4A384EF03B45C9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aghh1tLDgNX0xkrOi38PKroKr9Zs4wQSTZ/dI2GNy7afZ/Sqs7cu2l6mn8xJQpEssoTFQ46equ2HO2TAlmrVhY3iRm+CaoRtH5+mUk6U2RFSmukXJKj8bFTjXQucuT+6C1QDGesUqc51RD/6m7l1mvLHFGTfRiibJqO8EYVOdyGNMIzve6MIxP8QaIEEnBbeCAIo5A9wFJIlZAAnQTL/vREHo6YBhtd9jtPRn8LDed/o0c0kxAnZpsXrn0iD5yq7tPKPu8AqSj6FpuGLJxajLQs7N6mI1SX3Re+HhQ5BT5EqQm4Kc56hQgmYPRbSgV/ICZXnuR02yvoDbAzLdFdpdZWorPVE0PwCTE2VD1e9y+mSZ5iKDsd9wMkAUUS/8qPrGFVpdyENvpD065eHD4Qv1E84ktEK+EhCcHXLpp9pSYx5RSGffa3gvpLCi3vw+VaVL9hpESiAm0C803q6Ci/ilEw1XX9lUFiTnoFbce+Zl6RREVP8DA46c24eATjORFKc6NYyBh1gELiTnxEypRN5x+kNUYke5Isa1wzaxkn2ER25apt/Bz0cMmlUuq/FOXMShWy14/ior+ophI7fBzPsoQ7zilNkBTr8Z39tAAEK6KvCPvNRE0OB5xGR7OjY405oSyYZctfr/d3Fnj1PPgehcQD/KWWbv8lCWgDOpck1pGKAiDpYjc4v/caa67g14Ebfmf27U4LE9BnTAS69WD01NkgDa9h8s6Hgi9/OxXp6F/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pzp0HdniZcylY8TNHT/31qJdL0XjJDb1nSSL7dDjpG84zrhBBIf9gk49pYYe?=
 =?us-ascii?Q?N3JqnJVCXHLDEmMzMf4MQWAeAszP1rn7OCbykGU0+1VoUOvi/ALT3vqdtLJw?=
 =?us-ascii?Q?ukaatVxzxVV4Q5SH0DgXDpH0X/fElWwoz3RAszz/qDT+0ekWg24kNx1OsHDa?=
 =?us-ascii?Q?mF77qfltggWKG8O9Bz3nX6ysG6KuIMq1fTRK49d3LQkn6C+/NBzGW5mFSS/r?=
 =?us-ascii?Q?g0Is6DqCEidETeLUJBiz9M7pr1cYZ+M1phRE9ijOIWg3iiQ1Ijwu+IEjQZ6/?=
 =?us-ascii?Q?JFoc3CvZsdPhlgYSe1hEpf42hC37Q9nL/FwDBsNFmHQE3ub6WA3EF23HvLBS?=
 =?us-ascii?Q?2khFUsVzD9DGKOJzrjz3W51e+/U5dE6ruuEkQvpNP1RbF7qSh6y3Ob2/A6ma?=
 =?us-ascii?Q?/RvwxsAcT1BkT2fnw+wHgt8AdJbFyV1QomFylS/yEI3EzfnRknUTzV22jThj?=
 =?us-ascii?Q?k5x//gZzl/AK66lDMpPGPuwpu0wKNkBiwcaEcZWI3BhcV/+TyY43K+YQ3iB7?=
 =?us-ascii?Q?a9pM7+X1gtEs4CE1aBHx52mbrV3aad1omVgPPgys20dfEUvcHultf54cpm3E?=
 =?us-ascii?Q?pRisZthzIisCe/JCYzjvHBCeSh6FXTWGKV1squy9Jl79G+yiPSHc7avVsV3A?=
 =?us-ascii?Q?YYhQPxrCsImfFASauHbKNntBzdH+e+O6u/w+KZQNXx9YL5XJE3JFPE2qv4tH?=
 =?us-ascii?Q?AwTR9SHez9y9GWVhA41j/WC+GKJBHD5PtcqIveEcCtYYQfNVwRWeZkN8McSQ?=
 =?us-ascii?Q?Bkqbn3t4XRA0mIw27YGdxW2SBkXTTl08q0WAC+mCFD5J20YV+GpkkHbfQzgk?=
 =?us-ascii?Q?lFSrVCtD57LNNr/weJvK4T+WJocW3i4uRo2Y7hEM8EsSurrZEfyffp0Y3K5h?=
 =?us-ascii?Q?ljraWPf0CIqjTTtt2f8+7eyu199Oyq/tOmQvJtDnMK/x/iiCzga5tWylzCbE?=
 =?us-ascii?Q?xH7CCidHK6rqUq5BGD+V9sM1ukhivvxZXqfti6ytpbo1xCDabOL/aE+LZytS?=
 =?us-ascii?Q?zDpr5829LwhM5WKQgqlHZ2RghRoVeaSwVZPIBklyR91GBFBkzx3EZfLAsKiX?=
 =?us-ascii?Q?Id+ySDu/HiCKA9bx7lzTwtci5dx2VAHZLO3GiwCEbegW//V2NSvJLQFC2Tx9?=
 =?us-ascii?Q?7SXqROv+oU0Iabl4guiQPNB0qyG8E58pmpSKKvLyZtE8iTAYOO4Ob2+dSXc3?=
 =?us-ascii?Q?yiQR9vhR9yh4wSMXJFydzxl9ladQqilnLu6yO5V1QFCKm64+U9Vdmg4pk1uV?=
 =?us-ascii?Q?DzZiqLOSvLlsCvLxVqBdZTwAqyan1xt9grI44Q6UQqWvB9lMUuyJNV3/bMob?=
 =?us-ascii?Q?MINmeC2/qC8wASbaNM1jVSQNhZi9dUC5o789r1TWyDQL4lXuW3jwgNsAVPcv?=
 =?us-ascii?Q?5iyXvmIIs2USP4Neymf1xxPJ5yUPph5T84iG+jfEj/fslq3Pcc53Jd9NuWMj?=
 =?us-ascii?Q?tvivQaKQnaH8gRx1lvNddxMS09C623f5yUxSjih7w4bOqXMHFdodQ2Sx/uMH?=
 =?us-ascii?Q?uDilSllKgLx5BviGc3vxLe7WoQwllcB08CRAdw4zFKIy+uBlJZuIbTYYO0Qn?=
 =?us-ascii?Q?k51mNNcBOGXbLdNYZmyzCJSjWf4wBtZ7h4rS+E8hdQdgPl6mxaZG8HKtARU/?=
 =?us-ascii?Q?79XBiyIfIttLgzjaTfamZPk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc064bb0-3ad7-4c15-47c1-08d9d4b34d22
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:40.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UozgP5agO6G4pSfPTl8BPs/dK4p6EbN3RGNzkEKbpPG+UprwRW3/CTWTUO2YZk+eJYrItaZ55uRb+DLFkMb9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QXP compatible

Add a new property rsrc-id for SoC which supports SCFW. This rsrc-id
is used to check whether remote process is under control of Linux or
not.

To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
cores, need power up M4 through SCFW, then M4 could start. So introduce
power-domains property

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index fc16d903353e..ed1bcb3046a9 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -19,6 +19,7 @@ properties:
       - fsl,imx8mm-cm4
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
+      - fsl,imx8qxp-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx7d-cm4
       - fsl,imx7ulp-cm4
@@ -59,6 +60,15 @@ properties:
       Indicate whether need to load the default firmware and start the remote
       processor automatically.
 
+  power-domains:
+    maxItems: 8
+
+  rsrc-id:
+    description:
+      This property is to specify the resource id of the remote processor in SoC
+      which supports SCFW
+    maxItems: 1
+
 required:
   - compatible
 
-- 
2.25.1

