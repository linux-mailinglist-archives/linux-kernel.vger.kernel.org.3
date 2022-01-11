Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EA48A67A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbiAKDhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:37:07 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:22111
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347304AbiAKDeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOvt9PRvRZgw7VIdm4t5HykhsS46/uNxA4EtqIuJ5pbyT7fFGoj7kCabn9j84U07y5MHtLoc2rXtc/KmPi6GpyNM4Fx0NciGCkI5jjSZVgCvsJRmZjts2OyVX2lKoF0n62cvsCI4HGroP3eRoMrCHfxUpbcsZUJmlvob7KhBcrkovA351jLC2RxnUf3AeSai9N5mpO9sMndp2rxayCyrtDKMHbPD+ehmZsuQh9tgGzM9yHBS+FOUrheI2moR6F0q4k5obruQ4il8hFLmcnMWD6O1PToCys6B5rtLon7KUaWziDwt2hgEh3GLrxyXRcmCimdWLnux+HsVeaiDYSPvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+8oCB1Za4EQ4lk52XcHlIqdRQhJlOoncBUkPQUsqQY=;
 b=iz1VTwwOgLAfFHZQxHh5hBEEjCBdXDVFAZPG0rJAwVdvfncmgUx7yaForlnOYcb0I6mgU2PhRkfwivBNUIHh5tcpK++gkUBKAv2MoZMNAL3jcSULnzoLkwGeYHc0bfwsv2+9jgUEBNeIEoemi6qbMw3c0XxcG1CWCuSPtfXS9sPho1QLAt0J7GYwxABjfbvZ65JDTpVlNPwa2mEtOU6TVKUnOzv5GNrbh8+i3g3txZYE33YSMhBizzJtDvCSN7OP5R94GzmhTPxRN47+64BqMnMER/E7nKNDcvaTBmu0/mHgvN0CxZHCvcFRFOJDo6FOh0C3nIYa+/gLFTtOuHsHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+8oCB1Za4EQ4lk52XcHlIqdRQhJlOoncBUkPQUsqQY=;
 b=OrR2NRdANzDEwnDM+tz/aPG/BozRpyBt862MNO/zE1eAwFaVhDpKRM4dWH3vRTcQL2e11HtyxyzSalRpmnbbPV357Vu+mALHcAbakA+YCy7bps9kniW9tU/L/ITXin9mPpCKI9fB7TNROoiAQ4Ba9PFH8/qEd6J81g+dJ27MPIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Tue, 11 Jan 2022 11:33:26 +0800
Message-Id: <20220111033333.403448-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9654970f-36ca-43c1-e050-08d9d4b34f33
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB87251907F5A77531041FD45EC9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vbzQXCiHiH0t3JgSduzWZ7Gg0IBm7wSmSWqA5jNPWAj6o+ojO/M605dJ6iCnKrPSxJRUN/ftCkSs9ixbpLaWlw+gFPKKn5gKxM6Qf8GgzLW5/1Ms7B8fSdZBS5XpfQ2b0sfrYW4IMUX6ae5ipTMIK3zbKIluQx6pVp5icqnyE93G8fPxp1ELTfhYdc4KTuFZUOiyhnaKtOO7Bzym0dkgAuv1emA3JGbHXnR8vHpCIn7VnlTU0BfGEHd7zrBnNrTQqFtrY3HD9Lv/l9HfBE/H239h/aJiT2s7jXtNn0rgDpVzzOydilTXvl4E9nQ4o/6n63NtpD3O1XLBm9WHb/VBbmgCVQGVti4dp2dFGFp3xZIa7tplFelAliNJinQLqR9Rwz9YycR/Jr92xTcB4DnysoshggMCCfhhMuAVzBdnD7aFyPpR18rcVqmNOD2xEvuC9VZzQGZ/j0QRiQMHQX0jbXMt+LbRwfed/5lDAqleY7L2CvYS99kQITpnMxKAEYWCa6cveT45AaS/l1vY+j+D667JfZiJWWyyOY94ordRRvetjxgdwzgaf3yBbIjNRDLI2s0au71PWCjUt3MJlX3+tVdTv8aH7wgGjj8NMxB4OPIx1BvCEy47AFsp3GebjgzoLUg0lG5D8KQLKXd4aXgp3G8ynDRKPd8VuCGJqN+tuGjjbDLWJK6bvOQVghIXkMVe/u1Z6O6ieVDNWLI23xz9W6RG2fSki7D5BwH/Pkxczw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(4744005)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cwfgDhc1tls6NKe2WGiEZ8Yzh4m4NXsio4pae9CTrhe2dA/QVHItE16F4Alz?=
 =?us-ascii?Q?bnJCZc07xa7hK+9waMV8mAu6ELFejtdadwMvTcGBOlsJghO2NG2GX/CxYPmN?=
 =?us-ascii?Q?0pkBCVt8jM81RViIwXrICpNM9R0mK+xTgJvQm0JAJE6ipIdpl/m+Y9UKqO3W?=
 =?us-ascii?Q?9p22Ij/MIhMZy5ujMeuZq+JuxTBppIjC/ZQAoWoPLDDrOaBF806SWQcpUSeA?=
 =?us-ascii?Q?nEAbMyYbuYggpDmJJyjI2UkHmAStFaf4tKBfCrYn1BuD8m49MVUPig+mjjrh?=
 =?us-ascii?Q?PrHtUWsK8eYh/WxOQ/NAAvt4WIKVnMWLbpAgyk1CUfUN98JqRjkL7eqC1O+I?=
 =?us-ascii?Q?KU5fXtGjx3QUbAC3gI7qOllQ2GRtt5eDw+/yAaPkAJHHZuJtfdZer77jBCUX?=
 =?us-ascii?Q?vLF4BTqWFaWCjvF44/QXpM70Y6uzpwRPM9E5CFuliFyb6rZ6dTVZR5Nnv2vd?=
 =?us-ascii?Q?0MKzI70UWmOu4VebNsqmg/hayyRUhc3b2b8x6ck5U9uMooelPk8hV9SQeF+9?=
 =?us-ascii?Q?aYocu4iwBK+ZBQ5e0fyFkZwr8K2VUuh6DiEwBDIYy8Nw/hjgxBExnd/L+/g2?=
 =?us-ascii?Q?Mx1tv9G/NYUhB+FV9C4oXGkPCjQ1nWUR1nRbrCLDM80qePXyVnmPD1LojSvz?=
 =?us-ascii?Q?a2owStzQaku3nWVPU9faJq6QJTnsSKxxsuhWL59CLBciRddgZYuwbt1rRv5Q?=
 =?us-ascii?Q?gptofLSS3Ys7UDUXm1I8/oA+0eh2cn0bZt8LZN2VeyCahRltvlGJ9nDPVyvr?=
 =?us-ascii?Q?ASvJrzixB694RvDB5kjIDYvPQnG88BpfNgcmgdKJt7+rQ8XVAmeMDL3sP8Wd?=
 =?us-ascii?Q?SeBOrzUah9qSN/9pY08gsJ477eniYF4WUja1r5xGEK6TDgZNjkfCDTta11QR?=
 =?us-ascii?Q?GIu45PuRsPhOmofTH5pJYux9mWz4ZOCQ75j0rp4uWXEj/8p5LbepjFuWoZJu?=
 =?us-ascii?Q?LvT0mmRmbvLW2QSK06VM/mZDkfLlMAG+m3O7vGIfasuv/BFxZz4GIpnnSFXr?=
 =?us-ascii?Q?KuwTpaKGaNQpiAZgnNPpNkSHGfox0BVfp0CrgYCnUDVp83a/eYxhewkGPwCy?=
 =?us-ascii?Q?K9Lli2WTtcSb8A+7uHRJ3y0ZQBRFkLHR8PecOIxFKjKwaiH1fYKZPwtNWd2K?=
 =?us-ascii?Q?cg2iUVdgve8C9tg5kvFlzCf7jjj3ikqaSvPGFWqa+1stzzN0XrL8qq6Edt32?=
 =?us-ascii?Q?73tWUGGahFj/whmzNNQng2U/Adz1M1HPPAS81wORFchAjDgQytgxs4pTWu1T?=
 =?us-ascii?Q?FcDZ7oj5NhOG3Ar0mP+MpTJqT1hjANm0vdf7J0+dLuYesDfRo2puv0UzRGbz?=
 =?us-ascii?Q?G4tvoIUwNPqLuIQX2A0Wk/srT8MxlEMigjnTykk4t1TrMjg81txxeMd0FNqg?=
 =?us-ascii?Q?7HG50Hqj4n5S73ZODL0HDaSz4cifHbHN6uh9TQrb5m9q3h6ducg95st8ow1S?=
 =?us-ascii?Q?ubCM0p/F98P1c/8vzA6pv3gvK0YJF/VMTgF8BcZdLny/vF2hOv5h7q5cIvWD?=
 =?us-ascii?Q?aoFUs6cz/WBax0CDHq+qfB+7yxsZwDz1EEr7OfKo8SZkWqrIfazOL17ZGhch?=
 =?us-ascii?Q?QwzMokYuUVaTWHnrcEU3gRKb0rAWcz7EHEi7zbw1nW+z/ai+RXFzjLmcJ36r?=
 =?us-ascii?Q?nvBD7h6cvCnLgni8Zm0pKFw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9654970f-36ca-43c1-e050-08d9d4b34f33
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:44.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zdqd8TYtS+OApAn/XObgY4S851WrtFIz9AwYQ+F1kCMkRqok65+DOZPObTQWFtrcM+CVb8tuXy3/luPxQ30rzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM compatible

There are two general purpose M4, so add reg property to indicate the
id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index ed1bcb3046a9..cd9dcb63b176 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
       - fsl,imx8qxp-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx7d-cm4
       - fsl,imx7ulp-cm4
@@ -63,6 +64,9 @@ properties:
   power-domains:
     maxItems: 8
 
+  reg:
+    maxItems: 1
+
   rsrc-id:
     description:
       This property is to specify the resource id of the remote processor in SoC
-- 
2.25.1

