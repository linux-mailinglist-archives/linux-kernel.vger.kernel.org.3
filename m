Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D55A8018
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiHaOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiHaOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F79D7CEB;
        Wed, 31 Aug 2022 07:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjnbfGqj0i8Ugywvr/2RZIZXQN8R9LKIB1MPUUBHJYcLaYGgS6h9Rj6KYtDmkvNLlVhsKVdewZ2ecfwmSCDyGeZyQMiRbS4yFPqtHKHVU5w+4YMt4E9nXuwLxaVVmrkvE6r7aH0tJdXVjdKA/8c0ke4UrDY6uuTEwI+uV6l9FuxzYtYcrJPElSZoSZo72OJwiWiJIBrjoFIHdCiF3rpLjyVQSHTVOaxnRaoH8gJxY/QUN31l2z0UDssCG/4UUzWLZuZcaSPge9kLLV72C29x3yYviHmahpu0wa5S6x9pcHQA3Ara0u+Vp/ojZkRvzN3Y72xmUyijVcY8i2bEqAwMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ht+jdLcaiThRpwQqbPY9CibXoZCxxog9z0D85gTEs=;
 b=nI19osGTtfzDsdtVOzpdIcyD9wDh2u/z02ODNHiBW1rt1hfV8UI9h6EJDaDDd4IsU93U/9jmFMA3K4TA0fEaoUBwa348/AvCn/hcMlegtXB/4sC2f2AqAB0pdryf6a1B+4otfRaLNEJUonA8g/ec0cL6Cwn56TPFLh9Ra1rk9eHZRlnUK8dHvfz1gi4kDj+SW1qrQUvNcJVsIKal1nsssdAgRdU9IsuAoNk6xlqYamH/Oqj9MLcr5Q4AdF9fK7RSwPcoECKY7+K8i+OqMsmRhpXo3Kvpy4+thcKqyPC1QHAo4tCvPCpNUC5jD3a6NI1Yc4ZuPC+7Iwj7YXMM6oPxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ht+jdLcaiThRpwQqbPY9CibXoZCxxog9z0D85gTEs=;
 b=gMG6ivDwb9L4l9nj1YXnarOvI7oP11SiEHeFa4CoDKGNPQ56B47aF2lvIlMY146ZfxsXoj6xDFouvvFqGZtRUJS/rSybA6wpCXT1ewt0lgY2vjBQB3GrWY1EFBYy1zJ8/v1F/vol7TZKzxSJalMSZKIgfZcpkOLBo/bX2ZcSq1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 14:24:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/6] arm64: dts: imx8ulp: add #reset-cells for pcc
Date:   Wed, 31 Aug 2022 22:25:49 +0800
Message-Id: <20220831142552.43393-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b7eaa8-4144-4ed7-25a9-08da8b5c8384
X-MS-TrafficTypeDiagnostic: DB8PR04MB7083:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TV+sugqJ70f8X0PSlBEI6JxOIkEE7KWYdxwCGwYQflOwDcQOI58my79KqQqS/J2XvH8w9GWAc6qwAUxDadkJg73bHHzjRCdGFsuKXrt2vDCSUgkrklqiFy8oxqAUFrVWIrVOipDrt9BeGyF0SdYy0a0YU/0ptEZza/mciJ9rxMpNf9EYunFtX7WQJE+Y9Qzg/elDKt4fNGid5l9ZkvDXsG8T7/wQwlapASynm0ciiuOSiQMgyjgPBfOFPxmvZSqhvMoVnnVkYRBxWh4uu1D+M/IsgK2tmVtW+sDhiXOjYW01BtAdgtroksgD83XidqrReI+NeK5W4pQEJBDRe/w69sXylDKBCSMsB4MjjkNVTmcKyGSZnxvpXDUSU8lr2Wgl+4kZ7Ord5j6fAUiQahiNrVk3kj3l6ho8kBLg8Bnrqq6vHn4PF0MBXEztDREPiJbeuoMItRWtBpL5riu8nXXG2a/XuFDTV7kjvFIft06jQV5eVPZ3WKNAbH0IhqWg8tj8YRYwa0DXzizcuppEhScABMyT/QqfJKjcbqGAwAP9ETWJFxD3KqQP0sb6MJ4hUmnRM6qJaKX2oD6goImCYQOaGy1iJn1B9OJYMZ5P82QowJQcv9QcOCGQqdmluCOpmxkRDflKajCO+sK7vZCeND2qA/LONC2AXW/uJ7ZetQrXcCYUesanpCepJhd3lzt9I9sqGl98KP5fvhDm15paYoentU7VgbwQE8UEi7b+WZhM9MsRic2oPLs7B1H7a9MJqrAinE2SRKQ3MSyFw8/xgv+oSGGAZtQnxO9g41Aw8fUkxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(86362001)(5660300002)(2906002)(66946007)(66556008)(66476007)(38100700002)(38350700002)(8936002)(316002)(8676002)(4326008)(83380400001)(26005)(52116002)(1076003)(6512007)(2616005)(6666004)(6486002)(186003)(478600001)(41300700001)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AomlzKsgCJIFnzHTrSYim/ag2tjpz62Zn4t1zLLpSUOm7kGg+o0nQk6NvUqp?=
 =?us-ascii?Q?hR3yksxH7vJftRvScCkegbcEtO+ken3llkD2yCqnEBd0L92yM5kee8Vdw/Ng?=
 =?us-ascii?Q?ARYC+rRT0g9xmIOHB2E/0nXcHkLmjYgpd3hvNFYNnkCfIm8c3SOwsqXx3uBf?=
 =?us-ascii?Q?J+3ngGCGWbLpy2eakh2antZ8GQyU7Csc1xM0aDlOB/KKoSI1FtBfqQEIHcQr?=
 =?us-ascii?Q?PcQWIi+X2P88RZ0CAgJOGMIjmv7y0q6dyLtHwdZIlis7cMXCwp2Onm8reeZ7?=
 =?us-ascii?Q?8UCHv0bSYwQK18V5oGHGsE9fGDpldn28IpBKIrpp5+VXOqQ4xisuQvaRK2bS?=
 =?us-ascii?Q?kp8t1BiGjJNjg/8eON0YHekutK1HKNyZBbgZza0U9CC6Mxp5gMQMp+Jorp8W?=
 =?us-ascii?Q?n9cyM1E3hIa53uiSX2PfTN3Gu7KH+mXxx1g7k394KyqgUewv1ocypakgmML0?=
 =?us-ascii?Q?xm84dTJKkgdtq3Txf0dZlsoBnKIs+gdoClmXXGx+Tccg8pDYYUs13h0yFSb1?=
 =?us-ascii?Q?Tl8fZFvBoaZKVTT0qLRUOLBv6J2iCUwgt0ArqXv4I2ddvkPok1MPkObtUhFr?=
 =?us-ascii?Q?h95ygRL5L4enkbhwTjfjLOH6/IqzOzecnnMQqefnBFwNy4ZORKI1FDWifnJu?=
 =?us-ascii?Q?auy6FAcYswBYiG8ublS8uMXJKSuHrLtkdlCtrIEbSn01QhGl40fCOKFvVvF7?=
 =?us-ascii?Q?k6yBSU5PUhCC+5SnvLuH/iWyhutuvmcit8TUz0QEybP+T3ybZqC/iF6ozsfZ?=
 =?us-ascii?Q?Ze+enPuZcgOu0p+BjgRwQ5zeTzxuf9N21AJo9h6L+MaqjACjqjPok3V1E5+U?=
 =?us-ascii?Q?ap1kj0taF/qF2tSls/VQGl5X/V/potIxDC0UREXXjfZbGybFxNHBMdE85O7A?=
 =?us-ascii?Q?gx9gbWj6CIJNYR86fpzfgL35rglMUPUxMovmM09BEALp0k4sTETdEJy3o3pd?=
 =?us-ascii?Q?4bSuqcJeryPKA3rVXzcaeNQCoj8//NmQovt2EnsXvGNywg5CtwwYuddR5g/Z?=
 =?us-ascii?Q?q+Ze43qjTI4iwuTf72aB9eJVPLtQjz7O8kaJFw/hn1j2JNCZRyiuIrJ9MRbh?=
 =?us-ascii?Q?ZFnJsemiTUnn40sVxAA98m2Vide5eHfLApX+uXCQY7/k61ItRcoo1wm2QRDK?=
 =?us-ascii?Q?lHFhoKvjTdqfEUWjLfmvOFbGavkWmhWTPol6CWYVNOn94KLxUXJ2ayrKoUUP?=
 =?us-ascii?Q?tMp6mEa6g9FrP3SSeBrSPery6M/IwW1Pf4rxiiad5n+zoE0sEs4zbkoPhOFE?=
 =?us-ascii?Q?bRBpx+2h7UDp+sYZfzKi48VJl5CRBjYmKM4DKQV+Z8UsiMhh3MDg8M2Je76S?=
 =?us-ascii?Q?IdSxjb4VQnjqswPjcraFAzd9sS3Qsk1xJofUBGF7xgSPd5jsgzybx0sz5Jze?=
 =?us-ascii?Q?W1kQlE174lLILXdnJBLMLP0ciaKZT9VK2cGyni+Sm78DLsCXk79CcEYDbqe3?=
 =?us-ascii?Q?IFsSUHGiC7BKDdYDwFSFG7C4Kkr2yRuMpr94EyWEBl1eapv7Hawru5Vb9Vk4?=
 =?us-ascii?Q?+OZ0yuncXRGGkmY/3pKXYT4oyRKBqOVb/Ov6oKtPy9V/jgLUDYYB6TVYHRfN?=
 =?us-ascii?Q?9LBN46fRpJbzJQMfsT06SfdNoB9WC41roxOPLH+D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b7eaa8-4144-4ed7-25a9-08da8b5c8384
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:28.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEEA/b/5JPM9rQU4x7UOmPUlbIu4hgFn4RRPZvP+NpBC7BXDIv0dXvgndM/KGk5E2QR2WKNpzalUDzF/o/YaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The binding file clock/imx8ulp-pcc-clock.yaml indicates '#reset-cells'
is a required property, add it.

Fixes: fe6291e96313 ("arm64: dts: imx8ulp: Add the basic dtsi file for imx8ulp")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 7a88d7016b49..88bb30384024 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -171,6 +171,7 @@ pcc3: clock-controller@292d0000 {
 				compatible = "fsl,imx8ulp-pcc3";
 				reg = <0x292d0000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 
 			tpm5: tpm@29340000 {
@@ -269,6 +270,7 @@ pcc4: clock-controller@29800000 {
 				compatible = "fsl,imx8ulp-pcc4";
 				reg = <0x29800000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 
 			lpi2c6: i2c@29840000 {
@@ -421,6 +423,7 @@ pcc5: clock-controller@2da70000 {
 				compatible = "fsl,imx8ulp-pcc5";
 				reg = <0x2da70000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
-- 
2.37.1

