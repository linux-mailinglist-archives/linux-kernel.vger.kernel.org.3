Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4749483BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiADG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:26:44 -0500
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:3758
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbiADG0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:26:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q81m9oX30Fpjl8sxbVIveterlRZFv0I3H0vfeH67qOxCwaTROp43VHCJNgJoC7Mu3j9+3eG9deZzJ12IiKgERWVXuv0QcGGFaVS1fn9UdXhNd6FulbrTKdMKLeQZFLBqWyaHPKrYRG+IpOZ9hVesoJE1tPMpCC0d6ACgOtsYrak+8oIt7O9Nb52ciqfFjZpMFkKJ87ET0X0Yn5gfEzNm2IDP8k6zhUYYrV6cWbL6S4M2ZRu531kIihzaBNDBVCA6iu68toOcfsRa+0ybVTe25lCrp6dhdic2IRn07dOwSEMJrR0MXQBwg6rsU1zCKg5A8U5VUdqX7ur1CAVWNa2Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmr2Upi8hpiVRft1TEXa7J2GHYaP3gN/L836Kla1saY=;
 b=N5C/pOmO2DPw/DhzN4dnZmaBBxozEM7fR945V7ccgbgmQCvP/dPik/qrRs5qPwOTrd3mqxmUhdu75rAnOWJxW4ywGpb6qo5zYhALz/OpYtr5I6UJDNNhEl+b8ORi2cN/5rHAf5a4Lqp5CTR5TqfeC/1g5iAVTttoPe69/ruYAz7PlnWiX/XiiVtqpft+FIGEsz+qWitCKevuPNF9iYnCe4SEYiGchyAjHh112t8mEhzA1/bixSmFn854irYT6zBxzobMxKGdTu8t7ermuQ9jgki16dxhBvV+3AcO0hGgB9C5QQ20krZbWdBR97XSbgOFp1B/jjF20MHlGA5Z1M0hAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmr2Upi8hpiVRft1TEXa7J2GHYaP3gN/L836Kla1saY=;
 b=Jdnw//GNK/QNow+jhMwlEKAWDkGGL4etwgKBVf3jBwgjrW2YPd27cBXA1d5Th432u6b9Hi21GgxYMtb5QLql/YfNr7IDUbJbaN0V43nO4XD70mfVxlPcOa8SIFT4vg3pHIKymAu2+Csu133q+BjrpuxPk88OBaVUQvIsZDP1Nyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8446.eurprd04.prod.outlook.com (2603:10a6:10:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:26:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:26:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
Date:   Tue,  4 Jan 2022 14:25:40 +0800
Message-Id: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d24d8cef-5a24-4f05-8bb7-08d9cf4b2b23
X-MS-TrafficTypeDiagnostic: DB9PR04MB8446:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB84469F9A861AFA4373FB9A6BC94A9@DB9PR04MB8446.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGhs6TMOgVRBJ3g7wDR17yWFepZmE5JTDjqfpSrV4f8X2ZrmB9QaqKutjStCEcOA3kuVkznC3HfgrkWxygzkUOu03gXNMCrkzTQv0XWbApeFcbc3AmypQmKpHk6MePyVJ8jdYJER/Cs0aVPQ4LWVTCxK+D/WGuaxB4p+d4eeBq9ZORQdZcnEszFpA/i6j4E7+MoNL7HtoLsTYHmKSZt0WBeH+rbJIb5UcZVcUKYLb2HgCbIpm6pJnNBlpjTy8LWLWy/ySPRg2huRLMdetvkbdPgfBSvtjDeowOP9jvu5FxiFUllJrMHGp124p/Tbl52S9eydCGOUeEiGtqoGNk3FYCt/0hYimJyTMj0mcK71WHxS7rfWcFOL8ldtbIiFemzKBqtG8mSm1DKTMgJ4uidnB9Fjof44YplUqT/pybMd3Y/jWC/nIe/dCktVTUHzXMTxomyUAOyPWLBeADx6GRD+ehlmSP+RjVGugNVyf1gLq9d5Jvn9tP+rp7Pov1MYvz2GlH6gU104SLjyeGoS/TVIbayYeNJgm3RGw1/GLkHt0g5TshSRc/0k1CoA7Puvx6eJwWCg0TvRlvaLbB99OKyK2b4HY3D7mjh729hntV0lh9kiHzgf+zHaVWL2xFOAts6nhUnpTwSL8dFgtPzZk4G3EAOI1TwOeMEVQi5f3abbEQBsS2N66aw2CCkR3A30KYFzGnArpv5pJAfR9bZZt/rDgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(2906002)(66946007)(66556008)(1076003)(66476007)(38350700002)(508600001)(4744005)(38100700002)(52116002)(6506007)(6486002)(4326008)(86362001)(83380400001)(26005)(5660300002)(8676002)(8936002)(2616005)(316002)(186003)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItkMvonp4Yxr7riMr7iOmk6ucFSennbFZIqr6Tk+6Vf59+LlatNcB0/BjyBA?=
 =?us-ascii?Q?K17aFYVLupiA2yqJs/YyLgEU9KLU5Ajs3+nSXG82XOuQBfTb4EwdVIwPQlLz?=
 =?us-ascii?Q?Uj9R96YrCMO/rxUVEeVniHuCvvFooIk8si8lUIYlDYJAqx9koECyABJp+d3g?=
 =?us-ascii?Q?ATZC9VRmm76Yo6qRXl+P4ymkRBtT5jT0uNBmRQL+fMcGhtaGoGl6rCuZZ/TV?=
 =?us-ascii?Q?nzH1s/JrRJ+f+iPmXwl0O0FhyFVoE5qv20dyUsxHqToCevzraQiYq5Bjmqvf?=
 =?us-ascii?Q?18ls0JoI5urugQlE+oAVd4KA0rHqGR8jb+oNGQ9s6y6Ri9HuPKBIhLO4QGy0?=
 =?us-ascii?Q?dLtGKCsAAibn946JfUrvZ4AMvWkuMPhRiE2ztNg8Oauz4RbRlEADVoBw2ZKb?=
 =?us-ascii?Q?LJWOAfumId7LKiBV4JkZuKBFJqyTagARnvEe1xnwOgiEGN0yL583xIXiSj2r?=
 =?us-ascii?Q?Pnem/zVSy9eDl6On/PY11ii8oK8+Y98VvbtGsri0u7RjaSLcGmUsEOQYKDxw?=
 =?us-ascii?Q?ZCiXs9Ta2aNkREiwhJgw15p1Gsk+1+FzS8O7BU6FVWWHx9PIE3jEyKUVZdNW?=
 =?us-ascii?Q?B60t6wTzReCPoXjZ4H2izlxP1EnK67My9QB9H6f/bO9p7SWJ2AORDMssf2We?=
 =?us-ascii?Q?aO0VtKgAkaKabYxjTtL/RzQItYMlrBdIsCxHF9JYJPmx7oko2Xyo9f+CIzf9?=
 =?us-ascii?Q?6p711+vhcp7a0OPLr4y+3ZRSyReNr7daa0Q6CgqHmeZ0IIyJFNwqZtvRXiBn?=
 =?us-ascii?Q?XDvf3DKqhd6bupUkIMSmlsH8MV39BegbIlGhOpopq42YDtGUsWgsAYzj3m0F?=
 =?us-ascii?Q?3OOk7BEPCRoQrf9e8wV8w/Yx+Ut/9TOyi4DKI8KIrzO14IhAVmw0qN1ZeYeF?=
 =?us-ascii?Q?qRQiYZ8lOVgw8/Z9WNycLIoBp+yb6DQjlhDmQ3aSYfRK1Ubny16nT6/uefX2?=
 =?us-ascii?Q?AzzWLyUiCc5UQasH8kBfUk5QrU+12Ru5fCgv/yZ6ArtLDdNiaTH+nFljhVBE?=
 =?us-ascii?Q?Lce2b8WUfYIVUD03uLdDSBAM9Jbu9i+4xa4Y0bYBeLYHu/zEY/tTsP423MDf?=
 =?us-ascii?Q?XkGywDoRrds6OoapL66uBrS3YRN35k2UyB9TSatpSJJll7qLCRMSM07TJ4HN?=
 =?us-ascii?Q?uHnEpLO+IQTE66hV3gTaBNdkLTJeGwzPzqklhF0G+FliYos/GaHVFyNVeTrq?=
 =?us-ascii?Q?/VIdxK1S9Eg2rBNMtQ4IU/YHS0MiHHSUCNLB1yLHrI9s9ao82Wx7c/BdXCxM?=
 =?us-ascii?Q?Km/aXs5quvvGvypc8Y/CrbO/zyJ0TsKkwt0vxP+2hI2XaxSWA6XOdYAsErTn?=
 =?us-ascii?Q?qi6TAhzkb7AvaRR3br9RY/UfgW3swAAYYgc0FJ4Ef7Xo+7bJfBomH/fKWIDm?=
 =?us-ascii?Q?bZzdPICYEClXQ1yo1DQxIWC/H4UER7yRR2COfKTCXxOklsL/1IJUReLGxMnA?=
 =?us-ascii?Q?HaGDR8vtarV85EEN/Gqs7YcpaPndvmU1nCCoUfZAoKku1Yy8l2YhkpZgkm+Z?=
 =?us-ascii?Q?BPt/zHGiCi7wgldBPsQW27TWOopToZTXH2rBWjCbEePgc5XgdsgTUObRGIvE?=
 =?us-ascii?Q?cW6TKZHDoYWrhDL8R41lrT5rQUh8ylURAeK2snyuHDVzpAhLACdYD+DHjqQQ?=
 =?us-ascii?Q?OGd8r+egWo1iToesJizduHs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24d8cef-5a24-4f05-8bb7-08d9cf4b2b23
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:26:40.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wkp137JvipmW79B+ozfgj/4GYKVZDwNyo+EXSReWD9eTflWh7fPvDzipMQe3c0/blcMZRreBQfOxlSZG60gxbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8446
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset includes a few fixes for low power and i.MX8 SECO MU support

Franck LENORMAND (1):
  mailbox: imx: add i.MX8 SECO MU support

Peng Fan (2):
  dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
  mailbox: imx: introduce rxdb callback

Ranjani Vaidyanathan (2):
  mailbox: imx: Add support for identifying SCU wakeup source from sysfs
  mailbox: imx: enlarge timeout while reading/writing messages to SCFW

Robin Gong (2):
  mailbox: imx: fix wakeup failure from freeze mode
  mailbox: imx: fix crash in resume on i.mx8ulp

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
 drivers/mailbox/imx-mailbox.c                 | 249 +++++++++++++++++-
 2 files changed, 243 insertions(+), 7 deletions(-)

-- 
2.25.1

