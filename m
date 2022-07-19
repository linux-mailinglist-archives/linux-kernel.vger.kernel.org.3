Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C45792B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiGSFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiGSFtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:49:36 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3349D30577;
        Mon, 18 Jul 2022 22:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7PWzLXBKa555kZ71N3iLb04nfDY6GXtCqWLwvvuAtEdAoxg5uyPQuqG2jnZAdPKeNJtMSmLxZ+secuw6NQsjMwEPH+HAxqw0Hz+kU3iIi37aKBcJ4o8yGyJRhZdhlpPTkDKfWiJwJSIo58VxbodA4tuZ0M+J3/+3lS8x7zxZr7b9tnFmZtbOUHwMSZUCvfVypd98AMG23jXfAQJH754onoZX/7xEadUElsmPgk6uBKeioQ7VENe7rmgEsdl/Jfd6bPlOCNekckNY9vrRLCSeNstj1ZGnSm7So+jJaPt8Rpy47v5zxZlEodkAm2Y7xqIuGvRFG2oAuczn3rnY2Z3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD7HkwrWjeTimNOjXI34SB4abpqiWY5ACRTfMvnrpkI=;
 b=G4y3ASW6JVK16TIKtpTfKgYkMmR3yOVODjx4AkFhe4rADW6Mm5nugSIOPrBaludx66l56ZaprJwj0ytAFnMoeepL63qzm+DX42G3rZ/zGkmXSctUXa/H32vkPx4p7/HzL53XoVMK/vB+2ZCRXxsXNRiMsbm6rM/JLYMT3MPaqu4BwJcAzH13L1xPAY2tGwSiczjhN6t9y+OT2TBhP2KRcvJ4w7mnneYVcmowF9fGqvurRpvH4iWY9yG7ys7WiAyWbLpHcAmxHzOFBDp8fiHPeaioKAW7c/3IFJAMW5H5hLo943CS6XWQbV5sQpmZcOn7ZOFKBmy0BgTNJSYAfwU89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD7HkwrWjeTimNOjXI34SB4abpqiWY5ACRTfMvnrpkI=;
 b=bHTLKLSvvN3iJBGsN0SB6AaZnlOs3qxWatS5KT0DSYTTqrjWWMEEPDtvRP3VOyjIp5r363+r3hbx4ORLfezh3KvhTs/Tl97EhIBow+AWayLkMWmrtZKxYa5bfoXfzWG/aHRzmQuhqnzDtmoeYpoT4OW6oxwrihxvkI165OrhFcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:26 +0000
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
Subject: [PATCH V3 0/7] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu blk ctrl
Date:   Tue, 19 Jul 2022 13:50:47 +0800
Message-Id: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07651c17-9e15-4495-7fcc-08da694a701e
X-MS-TrafficTypeDiagnostic: AM9PR04MB8145:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb0h9M6pY0mExXjGscIwkV0PqIjoyC9K6cHiFN9hjVLYo8jHyOZxO1oqXF9Yz2hlRZT8XHkOJvZpil1kZSIuoRnVrPa45z3vJiBSvd7yoiZQvVdofrAzU960xOEUvsXdlcfqb7a0pklUNTOgwRGx0z0bBYHPwIOdLQ6E8d7bIS6428UtcoDyEYFbyPIvf5CUSAjU6Sh4dpho9UyzGBYcuLziqhlKXP8xkDSCH9TvPhlJS4/HolKaGnNUVWJDSyCK5+DrLitSLBgE4PzsxHSJ94a0wNq15hurxREvm8Cr6itxesYvsUKKBVtEMlPP4Rqe1I2Qc9aWXAcyfnYDgu/Iiq6ETYnwniKpcWI7ffSvQKZMll+Rm2zKt2i+D1MafuQODVWfmilcMHU6tEhzGeCuc1ghDA5JIho9DVybt9cZx/CkCqTKLg6uDaC2qceB0L3GB7RMdM/bMf31HwOPAnFnFHZeGMmSb/xiSSvZYT6IRdEOhHr2w/xD47Nl0cpNkD6SFq3ni6cXSxt8D0VC7E71hzLOK3dQGiW1tb5f92tl+kz5oYPc+bXzTYm3H8nAsAyh0ZzXxZ46DaYuYAk0voX6FHTQokmqA+vDc2e+ov0rX9v2S4gyCUTHW8Xm1SpHxtzWVfniM9d/r9gvS3JiEP2F/tCNbwaRqj4Ne/pebHwL78uE78/4QM62d868vmbmLdgf1XHw8ZIf8LqdJl4dHHONUsC9D/PJZxqv4++uxwh0XnZO0bqu0YmLk3ZnJxlMs5YQ9zu4CXTHyM4RAUftZvTFLnR4l+jEbANiAaZ0SQ7JlQ3oS+h527ryVwRDTvN4+Wb3S2ONqvWkSg2IYa+qmhKEATnoo286N1QDBclzZLu7wKMMUdyBsUVlPeikr9EVxnSO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(8936002)(5660300002)(7416002)(66476007)(66556008)(8676002)(66946007)(4326008)(2906002)(38100700002)(6506007)(38350700002)(6666004)(41300700001)(6512007)(52116002)(478600001)(26005)(86362001)(316002)(6486002)(966005)(2616005)(1076003)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ha9jEWSTRPyd653tQCljxoPUrRdZrShfXTmVozvUDfCR0R6sdTB2G9C/Aq1g?=
 =?us-ascii?Q?dGhgpkG8X80H0GmCbfOhHFr26zpEkqNbaAjn3XCvqciBZKYikMHvBXah3mKn?=
 =?us-ascii?Q?xKRSM7GX8+Vv2mgOzxBqC/8jB90Rs2kcbNsVYnTEtSqU93dlC7ZPMSHk5/tR?=
 =?us-ascii?Q?iNJ/RiUgyzyuMzz0BdHoteJDmvoswkQxOAQEaSdohxnmml9IckwVE/CqzH1A?=
 =?us-ascii?Q?kDNjFzK+zB8I9E9M9AnnFygflBp6IpAae5CVxrXdJz7zmKbkAifa89XN7eIz?=
 =?us-ascii?Q?na05jEI1tIebSoEil8HK12EqtDmFd+8dYxcEWc12noSRy5USHd1DJLjGoQkY?=
 =?us-ascii?Q?RKlWeWKHcMS8x+mOGEJAAJG6hNPJPrgSEnoYcNIeP2iwudgT3oGXgbDlu1XK?=
 =?us-ascii?Q?LQ5T9T1srPfkHQz3isWli7bTNbvdjlAB4jLnhTFGk099pOERVu16fc4xrF8z?=
 =?us-ascii?Q?10YxT6zA2D5v1d7+56eEheiBsg88Ta+K+PTXvmtXBCY3Z5bjZzSSvglbGluj?=
 =?us-ascii?Q?rp/ghzCD0GR9dLHM3JUXbejv/1G80xbSLaMJ4t/5+zf773alBDV+uvvl3Md2?=
 =?us-ascii?Q?Og2RxzO83Y5GIUZOmbwxeMiuEF2aO837RPhAWQZNtiSeUyjGw6xdRiTQVUQn?=
 =?us-ascii?Q?zWZmevSGUbpETcoCb53s0xXimO9KgrYSAVHwmEjenbCAVLLutj/4yBAqUERK?=
 =?us-ascii?Q?a8V4vrzvDm+l+ZF1syawZJRpe7DbT46kYPUmqOAskFO5wVmRgxKTqGPptWCX?=
 =?us-ascii?Q?1JfNO9N3iAaBRKQyqSpKL+EavZTB2pCq5DI/Pi3gIl/NHbKWdtgplM2Bnd3j?=
 =?us-ascii?Q?PVbjZqP0zunwdvMMdTqjMOCwV54hQEnVV9j9ZJS/ULrX0S7IzGl22F6sEQ5V?=
 =?us-ascii?Q?oEmsUFvVb7x6wAujE3fYKhvV82t6UVE90omlfuyswDH7tNLvwupQ6rNMSwaa?=
 =?us-ascii?Q?qr6FdfBg/xOH638xiMvcXT46NRkVgj90I1LGxt8o39C2gzl0L1t0rB4y7f0V?=
 =?us-ascii?Q?IaiGo515AgKWw2W92LN6V3iliobCzup15tXTyv8pTdSNn49EKnsWF5WnKA0j?=
 =?us-ascii?Q?T4338tWpdfdzYiwaFGyW3Q6EKfpSapnGPzO+7AhaLhY+wQCxr/Zrtos7njsZ?=
 =?us-ascii?Q?Z4P340EjN4v7dc9vGLvfZvl16riP+R/Ct6VoWYul7TOunDgnBOhawLHI0UZA?=
 =?us-ascii?Q?IL3lER0LWLqE6U3bsY2Mia0uktvbI0enzNTX1pXJfHkDVMRB6bKr/HZ7RZhb?=
 =?us-ascii?Q?ArRZzItLW6gYwIK8t6JypZ0S4ERqqQI/hRTF0JDOKrHl5bNRPnDukmTiX/Xv?=
 =?us-ascii?Q?T64jcYvFZU3Yiy16JKbahALq7DhRv/89SIqWZhaeLGsNYIFQPK8bXBta7+zb?=
 =?us-ascii?Q?5FIPNPP7rqFP6WXRQJHuGY1/7Z9vPKOexXM9YIsLaWQmoVql1qBg+avcUr7E?=
 =?us-ascii?Q?6BZxZiDQeNJbyFRXjX4cdLxV9UUjVM4PNypPBodT71JUyaonXmX1lag73Oop?=
 =?us-ascii?Q?Zj+gmwH/OqC0Jq0t2EO24dfpLx8RB7BjcjjjyeNxuqOxVfjYZOkjXz6eZvK/?=
 =?us-ascii?Q?R5ewwt2suKPB8AbPkiTSIhB+/KgQEMAXRDdCFq6v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07651c17-9e15-4495-7fcc-08da694a701e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:25.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF0MrfLXuP90TVbhRgvg6mMo6tboNYGd4pofF5SgJ8YFtniqsQu1LliwObqXlSJazTeHpkiMa7kBVUaI1ILxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Per DT maitainer, add a new patch to clean up minItems, see patch 2

V2:
 - Add A-b from DT maintainer for patch 1
 - Per DT maintainer, I added description for items. To
 make it consistent, I also added description to i.MX8MM.
 - Per Adam, change VPU H1/h1 to VC8000E/vc8000e in the patchset.

This patchset is to add more blk ctrl support for i.MX8MP
 - Add HDMI HDCP/HRV BLK CTRL support
 - Add VPU BLK CTRL support
 - Add PGC VPU node which supplies power domain for VPU BLK
This patchset is based on:
https://lore.kernel.org/all/20220708085632.1918323-1-peng.fan@oss.nxp.com/

repo: https://github.com/MrVan/linux/tree/imx8mp-blk-ctrl

Peng Fan (7):
  dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
  dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
  dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
  soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
  soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
  arm64: dts: imx8mp: add vpu pgc nodes
  arm64: dts: imx8mp: add VPU blk ctrl node

 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 92 ++++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 45 +++++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              | 43 +++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 30 ++++++
 include/dt-bindings/power/imx8mp-power.h      |  6 ++
 5 files changed, 205 insertions(+), 11 deletions(-)

-- 
2.25.1

