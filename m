Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12B5792BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiGSFtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiGSFtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:49:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED2230F79;
        Mon, 18 Jul 2022 22:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfuNm9n8H6mIvOTvnCz81KsGgAtvqo0f2ElhtEYnXNr24zfMRhoZ9CSdMtnGW3jVCe8yxfRopP0YLSon/qx3KJj1XAzyoqK1zKBlWYPtK9Q5wNMko/K7nXnxqCbpAn1QKGE1bmqf0vPCxPmtIQh3QcpjIuqdf0YQZyjbHoKzx5d4T9KNOFqjWd6ZP45Vm/ESe5M3Ps7Bf9x9u6vvhQA/7hEGbxZU0ySiWOcoeu0OwDcqS0CmuSOs4plaxMdsctQTaDD1Ys6BketaJgRWtLPcsHPc8oOMuQC5EziGBC+JV1HVwj9N4mjowGhUkinvrme6L+esc0l7udEJ6+rDio+3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18aOt61xTE1sd+tiUowLiw/C5C47JoSFlWQlZjvMoZw=;
 b=LKl59UxCOc0Yc77pEPCmW++ATtUqSD2Z5R5JnCWGJlZ0tInpAJFCDaG45ekRwVjzA30BdbtzCiB5iHq/9qvNiaVz/c5JvVY+5YbjtlWrXqq+pFTw6VTublltUr2AGYpMxXnIimYtM6byfsP/ccSH9cu1jic0vFL9cx5uujKF5glH8Ic+StEIQr2qxsSRvl1roxmU+xXyuES4ecslrW8Qa8rvtDjM2tX7kVz+HiJLwPAaPnPaWI9x17Hkmz8eOgi2amz/yxGuMLimfWiXWYqf3Nb/fi5VbbM9ugRSb0V7HBkPX1uuJ0C9tnVj+E3zWzQU0l3tpPReXyrEzn+fx8F1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18aOt61xTE1sd+tiUowLiw/C5C47JoSFlWQlZjvMoZw=;
 b=BWhZCsujX+l49UmAnppux6AwKWZAVDVx0Ho5n0sT2V8JEYSjWw1VLCEwuJOG52DdUdZjaZUkNuXdOEwsKk0iqcaz3XyEohc0z6qgghrCVLB01UUjqavBaOIhcUcbjSrH6uKIEEJG9naUoW8BAQNehbk2b0/RT7XG7VfytjzPNBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2937.eurprd04.prod.outlook.com (2603:10a6:3:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/7] dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
Date:   Tue, 19 Jul 2022 13:50:49 +0800
Message-Id: <20220719055054.3855979-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc9f6349-f173-4ab8-0e60-08da694a7728
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCFIAvt4ADOBW/ElyvpB5TTLXvmwMgKeXdO4f22kLX7HG6P/z0ypyX/l0BJjCNKiPlwn6X3z/VDIAJushKs9gSYtZG21+0S2lMzC6uWgJ41hXeoBgaD8Hgnrsuc1aGPTZehuy5hjq6bhnbvKgWZ2JltDtMyKJp556/safC3N2OVmDVLbUzGMS7bDnU2P17MQwwmctASEqbYowlTXJWFfo5O3cMSl+P9qq917r5yFr5/PfSoCjhdtxbkOi+b6aFXmyl+sXoeGiblNkTZcIVXMnPYZqVMtcRaubFE3BoWzEKSN67uqUv8blfaM51GB94ZGPjoRMtdl+HYXwO0KQiC3IRRHc3Xo3tPcqIbRPB4nCV/Mqp/Dv39Fu3MWld/Xsn8WMnmWdTMk18I1T6QWGylOCMSVZ3YLArwz6DN6bs1DQFoJiDKJApmbLPgP8LwhUvhlOiOanIfDvBhZQLwsouIiBzhmbQY51HYU4sE0FbjBId5JcBzk9yDAmQjb//Q2f55yoCFS3xq4MFR4L3Mb7cvHc9tkVY25+R+PBtIJ2vFn19QdUv5VUmmB2BKmYZqSjLZk5lYf1DSlZA1+jPjfP/hf/yxv6hRLjE+7mca3Hn0bmOZAQUE8zZoNeYxRvePq9mPjgPYFv2RFt109LOBcHW6midSaTN6SEb2PPuctvOOOuglULD9e1d/t1179DTMn9zjnqQLf2O/+0nvushJlyhGmk3lTtPs18dn8MpfPuRMlugKGHhTzL94N3SosD++5fj7PwY1dAbN0JiPg6Zer633PKAgvu16dvGC2Z5sKy5t2hsL18W/+UdUv5qYTISSMGE4W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(41300700001)(7416002)(26005)(6512007)(6506007)(38100700002)(6666004)(2906002)(52116002)(38350700002)(2616005)(83380400001)(1076003)(186003)(316002)(66476007)(8936002)(478600001)(4326008)(86362001)(66556008)(8676002)(66946007)(5660300002)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8Nb6RAZ3RaQ7H2+rm7spxOrp3PM8B14ZGRjPSaijm3Xjph8ybbykUI58dHz?=
 =?us-ascii?Q?inU2pk+smmv6ZIRyrZE3gigEG0YbXw3B0sV4Lxm0+NmQs6J6UPPZpUNJ5rSB?=
 =?us-ascii?Q?GNszuj9lGTpDm2LWUNPyVtelr/6We/jMI16qA8deBbMY4petY1e8vDxbIBya?=
 =?us-ascii?Q?JYZj2TFRAsq/SQCqL3ceiDQLzTh+5T2IqRwRi3QaG+rDODlRHHPJ98lZLYHi?=
 =?us-ascii?Q?8FfWaoMMVoercdOr5kA4C7hKWbrhQzrUcG/zirjv8D902q7Yt3bEN7qHE5Lo?=
 =?us-ascii?Q?OWSQkpqPnupzHoCQp2stZRrbcQLb6m+NU4a/GWHVJPGz3sELokNkh89XiDQt?=
 =?us-ascii?Q?83FR/5VC9Z3fOGoOAn2D3jvyh/iz1S9UxKshfnFn0aMAi81b8GqcjpLJ4YtO?=
 =?us-ascii?Q?9l4bdCPGkHgsMX1SX2FJ0ZxFnFtYdx4OeJrGWS4c1i7AhZ00UmW3uadfnpqF?=
 =?us-ascii?Q?jzmd+QKRASghwwJBWQA3fEKQIjwi13uooPkZ4Y/3smJdF08YNMX6TIkd3xIZ?=
 =?us-ascii?Q?NvVYVT3npby0+5YBWPkalhqm1EAqzOTeFagVMFhBzmQMcdGg3rIJ1lM4Qv6R?=
 =?us-ascii?Q?XAFWWr2AB6xftmrSd9nkIOdltuNTu6SeZaTyvUblVzQSCTeDC2b1/ECBht0m?=
 =?us-ascii?Q?H6Ej0Qd1PjdRlmvzlKhxwnnYgbe+m+PW2vM/gIk3C36+r7MwM6lWQjrRKR17?=
 =?us-ascii?Q?DHgMHp1T7abEyboGLE0uAV/WU+QPqBPBZR/Q6QzoAjN3Q/YTbShHzHtH59fa?=
 =?us-ascii?Q?idp6k23SPKp/ISenIlS4XbVq8iVaqx9gHtSIY4DWPVyR2WIJTdw9WhzO930o?=
 =?us-ascii?Q?c2aP9bv3ato6w+tnPvALqf6Sx+Sq0R75bIRvg3M0LsDk63NSwewHsL40hN8U?=
 =?us-ascii?Q?LVGs8JLCnOcrsnavtXWZPM9ylFpCexzPZ+XJf2fBBM4EKPpwQtG6UPoNmw6U?=
 =?us-ascii?Q?LRUOIEPqy++U94L2oee39lP6ppuXlBj5kzSF5CXU7IeZzOu7L5g4pOnkQYu8?=
 =?us-ascii?Q?A7LD/o8BiY1vdJHbJKkVS35PSp75qeUU7Dzq7w1LmBjtlsKiNpjDk6nhy5az?=
 =?us-ascii?Q?HdBZ5Hh05rGnaslby1rRvUoAv8vhyivAyDfwpM5G/eKNflqG3KRxC0E7BRWj?=
 =?us-ascii?Q?qs9Rx925qZkolgmvHIgRbN12Kdopn+m453KgNV3TO4mLHNvnNvG8glMXp8pL?=
 =?us-ascii?Q?LtVZv0RnkPEj79iTVPElEaTlMob8/EmotOU1XxJhpc/SDbRRO00X7nHD/xOz?=
 =?us-ascii?Q?gOHbDf5Yq1VjXqpaIvzzUeQHlHLvccZaTK9Rartre4xNlD2C4HkL0rW/9xPb?=
 =?us-ascii?Q?dwSeNwoTZQ8maCI7IS35zmWPGLlgmjevmQ90gf8V+1kUGkIdv7r0kdOoAXCn?=
 =?us-ascii?Q?8asVffdEvxTHP5MxVc1xQ+NpsMA3EsVYFhPnQyTy3SNaLKUXe3ovXUc/Xoef?=
 =?us-ascii?Q?jIp6QF0nwyfJC+JWoFDVq7iEDQeAAFC20gzNEC+pZbmL8t5gnmeSjdf0vWZF?=
 =?us-ascii?Q?MJE7TwaT3EBjf/E1iFHoHVKlxQFrwK5Pjd4Sg0mh2kSu7KZFgg7pvRn5kg3b?=
 =?us-ascii?Q?RVi12id89CusW8BzvNk1z27FdiN2AmCMBdQ2fA6m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9f6349-f173-4ab8-0e60-08da694a7728
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:37.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 034XnljYc+aLsuVMYLvw7XdOY+B1c69jTVsNDOCb4saCney6evhW+HNbmg8SiAq3f4ELa8c9gEwzAqwpcFUOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

minItems and maxItems are set as the same value. In such case minItems is
not necessary. So drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index 26487daa64d9..b3fb529b399c 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -27,7 +27,6 @@ properties:
     const: 1
 
   power-domains:
-    minItems: 4
     maxItems: 4
 
   power-domain-names:
@@ -38,7 +37,6 @@ properties:
       - const: h1
 
   clocks:
-    minItems: 3
     maxItems: 3
 
   clock-names:
-- 
2.25.1

