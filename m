Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F051E4E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445946AbiEGG4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445960AbiEGGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:55:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866215DBF6;
        Fri,  6 May 2022 23:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaJ4oGCRxehuUNuee8Z5bHHR+9d/sNU5EbdqUR452h0v6TnaRKrd7+k9lzG3FnJpxI3A9tF2ljWYlLYrvZUjIcvfDWVLywRw5tUHCHbvq1OQE7Daqooe3kaa56R6hnTGj8qzGUOG9PHT0J9IOTOj8Y1CO25jYqbPyIoz5sQqQ74Cm+UCq2Ivt7dslUbaemJCHjnOlPK4UJd976cWMaCzab4iiRBmRzML4GOqccPKGqcOqGM8r+YbsWINB152pvC045hqyr8IWzQ45gn8/zD1wkTsmK0YJDFDCTxZTkNzK4/LauCzJ/qGusgEtZt6UpWSUbWGHF6zZ7EcvhjsQ2clZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD8Nqa2gdfJ31E/Lkv7DCfapQWbLsGCGqdLcpcuwXx4=;
 b=CAl3ReHeSlQqpjrhoBfrgiEqcpoaA6wXOSyiAYYRJR1yEaFxl8Xmz4ooYZwXP0mQSgWcW/Yqr5p8WjieUdth6AM17Chwkk8UmM28USoE8URu0+dw245rkiPrKLgKqiYO7ZMe3Y21sn1iqpX5THWJUaBRgZIlS7koMoXCx6MqBDkbRI++zTQRWGVLWG34z7EKcI+/1jn08Ase6gSP1p4RH5CRtJYK0FVeCJ+xxXyaCr3tIUF+jckqjM52NMm0j0k+S5gkLgEH6v9zRNN9psv5qgKk5s4qdHs2UZzfpVUAKCVrqrOvP6PIktO8iwdnRjSPEtAiY3YfIUZ5vgpFjBzliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD8Nqa2gdfJ31E/Lkv7DCfapQWbLsGCGqdLcpcuwXx4=;
 b=KV6AM/0tbD8TqAVTQIpKx8G6v6N7hkLPkFS4vij+bGF+VYR1lZgpMn+pvhuPKYUp3hvArif7JgOnZJoc8Gsk7BHf4oJORZb1tdvjsJrk7k1n3TA2Qno1RDeuHSbQT2QL+ml5O4LXs6KTegTl0lpvBq3Mu6d7OCHeZu26XDBJJA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2527.eurprd04.prod.outlook.com (2603:10a6:800:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:51:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 06:51:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/4] arm64: defconfig: enable i.MX93 clk & pinctrl
Date:   Sat,  7 May 2022 14:53:09 +0800
Message-Id: <20220507065309.3964937-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
References: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5573f0-34a7-4122-df29-08da2ff60b81
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2527:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25271D81DCADBD2388CF7F39C9C49@VI1PR0401MB2527.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XXRL1VX7eKMQAG8pObgxuzLQbYr2eIZe4JjR5qZ1QIcRU/2cPHfsgZUpQ0BLL+gqOShti/PZqEKA0H5FlHJ15XnFKZI29xiO8G4e9/Z3O2yMltmALi7VLlY5SGsdd8G2tMPl5w5N/tojG0VK8GKPdaHFGzkdyG6KT9Dgi/7pfQhDvLumZoNnIHu9vNa/EQf9YosMSiMmnH55tCZtLVLnF9/xW6EFgyRJZ3IvgM+sIDRTBh16bDuG/7+VyFAa7ej8DuKgTd2mwHVZvXpxwSTiYJqhCGgXmukQZ/P7cg6pzAVT71Gpqp4RT4ySGogjdjTgW4dGu2edb7lsaL9IEaow8bVRe9pSrcHvGLMRqGcXsZuc5i62C2JVysKPqFIQMHA7Wr6KMRVwMcsz9/3MFAkbkXSLiAH22XC+WendqzK1hHltWlVKWfaEc9j9Eae8IedGdhwH9QkY3TyraU2X19czW//taallStIpP8NzGWXNk9rryyW42hxDQy6ZbQ7CiCXSxUpyZTzLYVGVMug989vy+Y90kZY4mCxEP9p3vdorB9Erh6yQLZCZl3GEZnnbiUSKgAoRTLJrUYjQVnoaHkfbzl8me66AP+yLrNiNmJnYEFC036/YXPfhw1GJIWWsT2fy3v3UPxYuPwlXRKC6n3HCnLqjyHV73MlmYLUt/m/jfe63eJER5D7FsdHM2n2HxNmdFoEH5QEgg4D2OOVqxzmig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(186003)(38100700002)(66556008)(66946007)(38350700002)(66476007)(8676002)(4326008)(52116002)(6506007)(26005)(1076003)(2906002)(6666004)(6486002)(508600001)(5660300002)(8936002)(316002)(2616005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzRDJXHdUy/4R71ef4lNEV7qq8VSN/9x/XGxdX119BwuCiILPYVO+TywZfdP?=
 =?us-ascii?Q?tZ50QOsjrxyZ2QGxqlA/eS5jUmw8r+WhUNd3lefvQRArTYKaL7q+qocTRTdq?=
 =?us-ascii?Q?yJNV1Zt59oS8A/pI1DJLFtgc8QTSThrI0vt/PytTI1yotQLzsV/HbpZJJmIy?=
 =?us-ascii?Q?6nM7p3kRyhKC24lzdmbTHqBTrk9uFTqTeQlGYVioWTCd/4/9F86GoCTKHvDF?=
 =?us-ascii?Q?SjvFGOCbluNLm231VXsIh0yDZKdVX6o7C1O810rRkEQNXQgjKXWXTyWwZCAc?=
 =?us-ascii?Q?ijgf7t7TnhsMkGVLSBa/oL0nX77djSWUv5cFqq9n0VER18Dl8HLjYrnXorlo?=
 =?us-ascii?Q?5tugJZfNS3DHjkRS+Jph6Dt+So4Rs9x8ImAzNt3hu/ktl9/ioh0dRHJo32cC?=
 =?us-ascii?Q?QdShjuHFMI5i2uNf2YVSE+E2MnramqrW9+iYh6JQJE6xVIyWk2+d4EYA6g2L?=
 =?us-ascii?Q?tON5WbecGnnmc9T16imr7Dch89Lwc0fIyn5nQoTl4OouulCrSQfa1Wngk2bN?=
 =?us-ascii?Q?P+NEVFZlAdLLfwIIF+cu90ca9eHKvovggUi4ZGYpuJGjhWhkCZ7a2PR9poBr?=
 =?us-ascii?Q?JZNcs4mWb8fRt/uK02SiPspK3ihPAeiuYaI3H2IJMN2B4MVRHhCpzP5bxC7N?=
 =?us-ascii?Q?Fu1l7sK9m/mPZhHf8W0Yq9/HHzOEioFnlQYvyZNkgVvGBa6T9AiMoirOPhHf?=
 =?us-ascii?Q?o3MZPF9J3ErqEarl1Y3OvAyKRhQjA0mzkw+0P0kN4HGMPYbExfminT/Iytd0?=
 =?us-ascii?Q?1h6okQaQJ6uLDOY3lGH2Au2jdGdAhFHlvFThL4MsBrS2XSs+vuTR6ZIIxNKE?=
 =?us-ascii?Q?1PHfS3I4pSruH+yTJ7ojI2tdAGy16l6TImVIg++3Jw6Zj1QEnRJ9LuEpeuOa?=
 =?us-ascii?Q?5bPLgrL9pQ1Xci7wY6DckFUxw36Ub58QUAfj/Lp1S9TpUqrvjnFGaOsVWFSZ?=
 =?us-ascii?Q?NQ+ltTuzPctX7Sjrh6g5N8gzZHtXfoNPr3yh0LGY3zADhv0a1FW2soxFmfSm?=
 =?us-ascii?Q?mxV4xPSaoLG+az57py6YYbxWxZj+WpdrQP0AmIDdgokyoBdswYqsLRtoC45Q?=
 =?us-ascii?Q?9we+cSEYFLsdGOoSGWfqN2piaBjNIeLZ5EeFI4gGtqSUjEzcAUGZwQLkY1cJ?=
 =?us-ascii?Q?KJQyb/bIrCRlGUoBDT7qPLmejjkgg9fppOloKw8de64QwEBWJr7aWHD+zC50?=
 =?us-ascii?Q?RX2A8bsyYZoEBkZHKSqsC6tnvCSfI8ffbpsTPPH0uMrZLPR/gs4H1pbutLXm?=
 =?us-ascii?Q?ZY2V2nSNgnBe78DiSqnpHBJEgv7Pz4bfRkBKsPGeEkzLc0pWmgqkQmKB3O8r?=
 =?us-ascii?Q?e3w/Pj6yw1l317s5lTrb8f/HTdfEtj1GD8jKk4V+kh9snn17Tq1dsZ97Bd93?=
 =?us-ascii?Q?qFx0zOrbbLEY0KNfEVuru6ZDKuCVyFxtP018wpHgeAL9HStMGVrIoOC5GIbn?=
 =?us-ascii?Q?am3ppF8yjdojbVakJCLsZf9YMdzfZXORDU2w/T5UygtrVKUdBNGQA0GhAIji?=
 =?us-ascii?Q?OY1ZbrBqGQmhMIpjtqPrq1Do+gFYBFYIRTAgbeEghg2NUKgp34CIOinLNzEU?=
 =?us-ascii?Q?mw5EXHoeDUIXbMRi93+IzPc+O4bW9W0dHM+hp9U7WCrfDbVEM6n+LSe+uveB?=
 =?us-ascii?Q?ePhA1tDv5BI5696PisT8MChIMpXdMgCvhlPC+F+5MMv/uLGQC+ZqVdSCfjyG?=
 =?us-ascii?Q?yGEohhkqQ+Y4PmvOxWZKRJOkeXBuGKdWFZGgCy3NMYN8NOiNU8YB4KnLHqJ1?=
 =?us-ascii?Q?B4Bud1yxnw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5573f0-34a7-4122-df29-08da2ff60b81
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:51:43.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oxuqci9R7mtEnH3N1QrUhOduzCOUnVDl4+1NrAHFlk+SDtozbOHzEU9fESswa+4QYSE8pLbwGxB4CfOXBMMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable i.MX93 clk and pinctrl driver for booting the system

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c79bb743926d..849e997a365e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -526,6 +526,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
@@ -1025,6 +1026,7 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
+CONFIG_CLK_IMX93=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
-- 
2.25.1

