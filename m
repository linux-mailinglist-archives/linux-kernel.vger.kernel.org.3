Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30654BF383
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiBVIWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:22:51 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F221052B9;
        Tue, 22 Feb 2022 00:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX3RTIPV1yOvNd6Q8nOWHsl/py7V49S/ZhKT4Zn5D3c/CGc9vlASVvIPslhKJ5tsyW89qcwBKL1SdFEV2b4NTYF5WVE4xxHO7g1H1Yv8jorkmnTWqVwFRUgQ+8NwwZKQdetSh/V4mtwWIq4YLzv7nuFOPFcavUry1Uly9bISb2HPjZtkya3Xq48dhL3daj9L4FEeeUP2uFfeUvDE1AHpzRdthI2aMA8Ty2dOTJtS5yQeVvjiuBzZT4jq/bSa0GkUx2r/ApamDj48vTo2JimWSSPxtjATYjerEWsllhst9aXmB1yWREjHp2YCrEDQ0YRAECay1kg2wr7jl34pj1uz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GblK9vEJ3wuarum9FCfhp/4OB0820V+zt5x09SvKRE=;
 b=N03yLnJSyTo7PjOyvu/KfQ1Te3UvnFN2F5ksEzQqhZnTZJx6e6a20VpMlFxsK0jC/SKdcJgLizVXeTJ0z5PTqB2OADFYU8/kXCdJfK98D2vMeaWFuOXplBHmKq9Pn9fFNxnFbX713/BaOeCClUx8dOpmXG4MPZsiTcbHHATlF1EXLjxqhRL/a3ViN0a7QFp6ifYAM/4w80HvCRWLaM20YJx+DhRnjv9YaVSPHDkrW/m0/Yt6I5OF+P8PHEOcHXLVnxzD20AY9MSYiSzHINyVEze4xGG59k3GV3rtTJLRubUwd15cA3Zw2b1OZW7ZsHYFZLFTw7BVju3qPzHZZn+P9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GblK9vEJ3wuarum9FCfhp/4OB0820V+zt5x09SvKRE=;
 b=QuDq1+0Q1szukY+Yu1rmBM8ZH7CTxZbhq+v7yZDzX9SNByMGYR3k0x6SIv59RWvImvE92/FrTBQJuQA2X+NyS3HyV4wGPvoAEaMlKaaihx3aHBXs9CBC3h+n1LMnB7oIWYOER79JA/rSF27MiMa2KhQX/9ohoJgcUalizqnZmVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 08:22:24 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Tue, 22 Feb 2022
 08:22:23 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: fsl: scu: add imx8dxl scu clock support
Date:   Tue, 22 Feb 2022 10:21:40 +0200
Message-Id: <20220222082140.2073629-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::33) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a34cfc15-c93e-43d3-cda6-08d9f5dc73fb
X-MS-TrafficTypeDiagnostic: VI1PR04MB3984:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB39846726A49F00480C397B89F63B9@VI1PR04MB3984.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlDIonAlvLV5Wb1SWya0ZvqNy5ZX6EdiR6l3aqIuacbK2P1aoA8MAzdELuEwMz1+8UYUfNobCjs6zapBy9pxQg40m/5ZI5NsEpb5W6+vEkK//3qUzznhiscBFKkGBmfmEACdizM1ns7p7gNd1m83U7iWrO49jpbMogAHEosZgEaErAOH7fznFHFfiS2RhbDbPVbT0929+HkG6MBZ6EVnLpk+wfbQ8lpSNE+53joRIVHXh67JUUio1Da5gmMyqnlgnqTHz2fzWKcs0csqUDfJoIkZ3/6LFcKb8KHUvhVIL2h58ZrigTFIMIzVryuyF/Ji75M44AqOJGraHOIxlRuLPvTCQKiddkQVk0Wm/gydcmK3nYlWt16aXOaP5UCJ+Y7Vg0imKLbbp7YA5MScJrFmogoNGdAEiCHMJiYP/RasbQ0TA/bb7XeH2kplVYjzxE9+LCxkCzAmSfbspUPFLNEd8Ac0E3L169zQ5TcsfrmE0igvgZeMupS8aKt4Q55T6n8NpW5hYfTrwy32jN9XPpFAU3kWCpuDsDkrQa4agxUG48SQw56NSbs49p1eubYlbuXvkVUqY375B5CJ1U6njLBu3KBlfOqRyAIPYpwU42cFHqh9VtSFPco3z9FC91UKAEoErLmM3TJ8u4Ke879cEubA5duBWRtitjnO7q7t029fCRbzR571W/zYSlX1RxoILuFk66t8ncWeiFnuq8tbpuD2BMjhFrDc3ifmGEeFeLu9d28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(66946007)(66476007)(66556008)(316002)(6636002)(6486002)(110136005)(54906003)(508600001)(86362001)(36756003)(38350700002)(38100700002)(4744005)(186003)(26005)(1076003)(2616005)(6666004)(6506007)(52116002)(6512007)(44832011)(2906002)(5660300002)(83380400001)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twavRBIk7E6azikYx/Iq6GL7+Zbii0r2sXntouQ/B8YyxLOM63eTD6+ov8gw?=
 =?us-ascii?Q?9xq3zmhUzo5PQP7s6Yl+T/NPu9Ic08eiS/qg84aEMlIkMEDyqJO8jEJLZXkB?=
 =?us-ascii?Q?U2pXVol9RCweiw9bfhuJC36Zg5PrNLjHt9SHLyGgf7aGk8k1njE5gMZq4ppz?=
 =?us-ascii?Q?aSB1SKzkAVdShXrpFHUHvGzJKArL7RitRJs6QScV0bq7v+ZOI2rWSUwdYzcY?=
 =?us-ascii?Q?ziVrpDJ2qKiwwyxs31YwwTYtbsMHmzLRi+709jJjpz1tmVqhxxNxeyohJT1R?=
 =?us-ascii?Q?n1sq/YeeXl6bzsQK0ZCmUob196sWKRoWsma6u94LKPlH0FMKuhdCywe4hRkf?=
 =?us-ascii?Q?Cg+iviYmJZ5L9lPmgeJb4GyqliOuyB/vAF8iDTWCRJ9mhuPotyVDfLskgQmG?=
 =?us-ascii?Q?T8xenFxB3tXw4L63MJ+s7S1b8R9+55i14ntp2uYDO2iI+c2c5g+xJJfnph59?=
 =?us-ascii?Q?EQ/K/H0+6bmzFpKfnmygGizI2lX7VKlJqR77BRypRlhzEFmS9lUmxHVBNGV4?=
 =?us-ascii?Q?QpVhqiVfHYh+ckD4DFy5JMwybPBcNxk++gBSHSVLfzjIsEARGxfvjwYaGB+l?=
 =?us-ascii?Q?SxQf6XzOQC4TomY7cZTPO/wJjiyWohlb/yxE2vHo58Yg1ZJw2lCywdHvcFUR?=
 =?us-ascii?Q?XVxBIXjEZejQ99a6pBylsJ2qusrCEoC9Y7G3ozmANEWqSYKzM3kMlH3dckFh?=
 =?us-ascii?Q?gvry6XIezG4Y+BCMPhL6J7c2v8hdKFSEqks4+eU1apWuXzwn15qBWBJkhv1c?=
 =?us-ascii?Q?/ctVSNgs8pUbEiu86FEI2va++ZbJ6kiqbBGiYMrlfv8cEUxBsgbnYt41PmRT?=
 =?us-ascii?Q?9dfUos/NuYw3P0ArPjDM9PIIj4opQb5ngiD0x4tx2kEI+IyXaPi34VDh3H0t?=
 =?us-ascii?Q?GXbOjpn8Ge1XO4oxYGtCrLeLzFEK45TIVMpnoxezdcL8R6vpGgD7il0rWw+L?=
 =?us-ascii?Q?BOGvwddNyng5X0438+EVUkgsZyPFwOS2hHKeDHjEJxPYocJUu3oFA8wUJ4z1?=
 =?us-ascii?Q?TRu+0TrSHhFxCVcnkEIVfG8aAU9gNsn5MOEo3CNGisUu5fzOcXLitTkOB/uk?=
 =?us-ascii?Q?WObRFNY/ZrhUhjCa5DzJgjK37ROp/NEg8ItPm3qxsZGzyWD9+zoDi1ROCfhh?=
 =?us-ascii?Q?chuVlgKvzgop9XucSNi2xBBdCe8I+Clx5P17f05uuUZCBIroxLQ5JByjgmWN?=
 =?us-ascii?Q?VaH21gZizULJc/AolG+M7XF8czTO6yh9wMvRs2Mmhx+LrbB7oqcTGYOm/G6W?=
 =?us-ascii?Q?y2SMI4iyeucejq4yTSYUP8zaSGEwzUioghneebfLWjle4OjnmxSGNFK4w9ag?=
 =?us-ascii?Q?E0v2UK0nRKFQZS4oFwZSOXiVmojJgWfkSNQdKlcGAiDfiO90vsxljBkFLrK9?=
 =?us-ascii?Q?lvxYC1ENmTsNTWEGm75sDrFScrf6lw3OEuTBzOK3a8lkm1++g6/GmmfPsxuY?=
 =?us-ascii?Q?6wZC6yHfJn6BiW2ybTZT8MqaTqqhRHEL3wc0eZ4HtVMrd5mwBAmx5/O+WiQc?=
 =?us-ascii?Q?M5Vozr58hPEns4B81OvshRRYRzbau5tSlMHiJF34/YOX6Z+CNtUVvLD57LG5?=
 =?us-ascii?Q?2oeWJrZ5CHx7YIVJGkA5bLMmLl8/N3WUfrKHLnAzDdLotTDxH4J5b6BfXbmA?=
 =?us-ascii?Q?ZTRWa5cNShdr58pV0BF1R9I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34cfc15-c93e-43d3-cda6-08d9f5dc73fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:22:23.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCNrLNJblNEnzl/ZpVhzO756WOjs5D7hbS/mn2F0ts6wY31HVeavIG1JQ0yVS7UZVFHHb9EsTQArQVsNjP7nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8dxl scu clock support.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index fd0061712443..a87ec15e28d2 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -86,6 +86,7 @@ This binding uses the common clock binding[1].
 
 Required properties:
 - compatible:		Should be one of:
+			  "fsl,imx8dxl-clk"
 			  "fsl,imx8qm-clk"
 			  "fsl,imx8qxp-clk"
 			followed by "fsl,scu-clk"
-- 
2.34.1

