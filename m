Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3165ACE4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiIEIh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiIEIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:37:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834C522B2A;
        Mon,  5 Sep 2022 01:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqH5TiZMzmCxP3pJhRUqqHG4RUcZlf94c6karXTI/XQRzZOna9PzGYjEu3/ngYSNYAofjPtAduyY33tH3tjKUPo7lEUMjnKv5NkKozlZAlM/et/khTrwEbS0hf62J5OgHHmNckMUQ1bJwKzyzOmZYZibtZTly6UdEtolRs8V0S2feDJnoXmMrgbRs1ijQMFtIGqh9glfmWWNOuSbQhlm+r1ZbCCm5qdl3XX5dzTIbFhwoy7VQYt4jx2wq5Q2WxvAZVS3VywPMW6PIXwmspZAGnL5An9qdVCX1t4o5m5hAd1Qp5bXsn8+Mw7ALxoYNMmpjM+xrlNxzjW66f43t0gehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FZSikHWjMzyRAH10FzT2G6HjEwGp7aRR1AuKUyUNvM=;
 b=AsQg+pnQIGE9T0aiIvPDb/r8/6eibgg9knX57JXbtigw96Ufe+vtmz/MtgYjmLJBhThIVy3gb6I0Yzvhp8tjnYQn3a7oPtPu8Z+x7C4eRV8vS4K4ApAGM012ZAEjRkB968fBChm4M9R9c33yOC8u4PxeZxD/H+TBVhMqfIFTzLwaEXiL4RJsDQbY1XH1fI13fw/lsavrLapOIHuNnFgosyN6WMZ1uTAtF6RBDKqEWs6SIbxZkpTf6yXMePljd76SI71bvz83JkN7zpWg7HlgmUjibbOVHCC4WmSGB038zaliNryyfoAg255A8j9tgDIj7z+pUKYeqCZ2YZKHddHytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FZSikHWjMzyRAH10FzT2G6HjEwGp7aRR1AuKUyUNvM=;
 b=DN8XHgLRptsxDg7qirLVvbPj741CH+zqzbqJ6f12l/aJsKGEzjTyuWUGCstyZwgqZZ5KcwmCghftKaucFf4uIXCDuvKXFMh3UEk75VVcwM2QgwAS4K6yUTWx/9Y8IaYG/ysoSv3jyuvnmQCgQxZcPqQLW9mqM3jHP/4Jdty0wZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM0PR0402MB3666.eurprd04.prod.outlook.com (2603:10a6:208:12::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Mon, 5 Sep
 2022 08:34:54 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 08:34:54 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     festevam@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/4] ARM: dts: imx: update sdma node name format
Date:   Mon,  5 Sep 2022 16:36:15 +0800
Message-Id: <20220905083615.89605-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc325a8-8edb-47c2-9d31-08da8f1981e6
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3666:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCX9g1zXNBqxqcBVLP8570B/ImAZLDIyhXR/PGXcGPohKb0hlSDacengeKs3WkP0S3njHRy7RSKOzDW/Y8XRe4V+u71VwTCywQVByHHMK6yB3nfj9qDsmTNXy93RIJ4Qk123dPedtCw+jmaSwC9uqFqFFuC/HY2xAeBCy4eU6xYFKqvWrN4F9jjROuKFfi5VxtxMWpoRROZarCx9+ghj0qNAt8jgrFZscxXqQM9sJFSB1ofaU1kKoieIbiHm/s7Qq9FHKob/VpiZTcBHFgoA1puwVDp6mf3SFv2XLDlABhawx8Z4JszHJIFMrOoBLC4Wo5b1h4RFWgKUaVLq89XNz/K0OhWdipAxnWpaGm+C8TpCe6qJqwogRse36e/SwV83UbFImxj9pBwZjGQoR0Uhkmvck8q+wyQe7375hAjhDu8nprWujDfNscjykLseghiMMfCAzv6KdtDoo2byK6IND286zTHnHDd6mPqN9Du6NoKNevDmEcP1X1RdbznCw+RTycrUAbDoCGFqp8xM4UsDAbGMnY2zR6aJJYNiTw8U8qMzwcfBz1ffMjjDk/FZgR09BkZl+AjuoVjCJn2cbJ+qRR6kekxBdmnOwyAl0ZUDxrodq/TmBNtDMUNT4rBtDrEc8jvmVYHOT+Ts0Remc0SOaQsTJVUTQHLgi9aAB/KB4cmHyz5Bms/bhB/hfcSJF2aX41115ypyfie3fO30QoPVQxZpBpSds8r5fWHdfwZwBYSgbHT6a/c9eI58XqhQubfxoZeM/uGqmCsUYVSF53G0ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(478600001)(186003)(38100700002)(6486002)(38350700002)(6512007)(6666004)(6506007)(83380400001)(2616005)(52116002)(1076003)(26005)(41300700001)(44832011)(8936002)(86362001)(5660300002)(66946007)(66556008)(8676002)(36756003)(15650500001)(66476007)(2906002)(4326008)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knxqM6fuencvOkX691w34vFLkJC6hBIxZXf47J0ZtVuOmNJKga3OFLAXB3Ra?=
 =?us-ascii?Q?X4Us1VgaVdZbs80wZ3dSImnDlcnZEDLZLxD86PgUv8Nvjejs8LSEBLLYgrFr?=
 =?us-ascii?Q?u0MLoqcjDj3pAngbG0By5IGHUxZYwvgpq5q+ZiztxEm175bYauSziPNNVDrr?=
 =?us-ascii?Q?LMakqsDnjJWUd/1zAPsMxa1bCbEm+ovQnIOxlPThDEOjoN0JVHeQM3S/I82D?=
 =?us-ascii?Q?+z0s9iqDna6cWxqv5kiqdDpEqKWRc63sUqgFAaZ7i0XweoVnN83umYglVpkM?=
 =?us-ascii?Q?m673ElzeuUBbM0rGUI7tSx1dXYYZa3tGN+PPfYqdq9rvWIboObOsfhuR5ewF?=
 =?us-ascii?Q?RiDu/lGUczLbg09JK66lfJfNJzGbYO7k9sltZnnnoaKczmgne6ygFE0njd+O?=
 =?us-ascii?Q?2h6cNq1jtWyUpPUcv4r3MWFrkUNgrhWA9bya8GKXdN+YqnX3VCpi9JiQUzfM?=
 =?us-ascii?Q?psb01jRZtKvNuBPSS6RHqHj2G2EB8LUKzbxqOvFrRyTwA8aUgfmRmNXQsEC/?=
 =?us-ascii?Q?t5PbnTWcu1Y+wE+0qx6T3Xw/vOWFw4n/3lVxZmP0J0KFwnS/+6LtFJXQ95k9?=
 =?us-ascii?Q?S6+WVR6rEeM73X81+bTo2x3Sv1C6Rp7AVs9n6ysP7/uSQ3tbVwQITz7MEz8r?=
 =?us-ascii?Q?vkj0zHV3Gl1oIHP3GXvUTE9FFEJcxWEOUi4FwSoN7znnabVAJN5Fk1gLd9Hh?=
 =?us-ascii?Q?znQ1E8AZXtr/wRPNcuGiBOFuMsZeV89pBYBG1qKumbuMGZmS4GczwOENsw4/?=
 =?us-ascii?Q?t8OYK8M5uH5UneXmO+YZQSMTAlfkcuPVgCqeyQ5G2CzChiVrb6+4Hj8LeJC5?=
 =?us-ascii?Q?8dELWf8C3nM5q/buznpVw9bggLUQAyrPw4nXsyKtJXOnpqVG78hLLSWn8sPm?=
 =?us-ascii?Q?I6HPYNdZ1ZhpmU2fLPb9HJKx2Hq4cgR3zmBiuH2V9oxdRsfHsIN08ffZcpmn?=
 =?us-ascii?Q?tKeOT4yniWQU2MTAwROqptnuun2ZisKr9xjSIXBYl/+E4aspmEBD/15tF9m/?=
 =?us-ascii?Q?WI7oFWTcnaCbVKc9/XX433P8P4XT4Ojk7YAM8VWaZv2+RphN9MLBMaATAwSJ?=
 =?us-ascii?Q?CRvbrh0OHEtbr21Ei+ZvUdG7mSajq0mWvkeeOiyfMBYBl9AUvGbVRyiU6Q/t?=
 =?us-ascii?Q?qCvhiBmOMK6LJZSqY6XACSMBN4einDrQQTdI67Qv5VgBU69iN4YiOkCMeF0C?=
 =?us-ascii?Q?R7vR1dAQVdlMoDRPm1RS9vm106ofPJL2nj2IMktUE0R5biSSs4F8xmDA7U+0?=
 =?us-ascii?Q?nW8Zk0ewlZ8ReyFpGTTtBs/0ns1Sv5Vb9HKtKkRC8Nxsk+ZjyhGv0xMbGUWl?=
 =?us-ascii?Q?3Spj1Kw22mi01pETNg+Wj7I924pZ/6j6MtEMJCEw2wmt7N8H9SA2bIYIok6e?=
 =?us-ascii?Q?Z4A0GAuQ2yonJNieVzzE2ntbw+Jf5qb0fMlRTRxz2beAHK+yQeBUuOcKF1x2?=
 =?us-ascii?Q?9jjtA5lm58am+IAc6HnCOimJzBjtaZ7ETBnSa22lRbXTxa727JsESgOZUyME?=
 =?us-ascii?Q?5gy0Jf1nCOdQJFnNj8jwCfOhh4lgHS3fvIIrwBp/EMj9/9oW8Ank+XTU2yWQ?=
 =?us-ascii?Q?hpHiLd4ZqioUfWQz8XLCjeMa2WhMbIbtLRk4TllK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc325a8-8edb-47c2-9d31-08da8f1981e6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 08:34:54.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrnsiB6iBwWSKEyN39MHmyyLS4U7P6o4WkApxt7noKASHrnKdkIeVtby1lqRKKT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3666
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names should be generic, so change the sdma node name format 'sdma'
into 'dma-controller'.

Acked-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since (implicit) v4:
modify the commit message in patch v5.
---
 arch/arm/boot/dts/imx25.dtsi   | 2 +-
 arch/arm/boot/dts/imx31.dtsi   | 2 +-
 arch/arm/boot/dts/imx35.dtsi   | 2 +-
 arch/arm/boot/dts/imx50.dtsi   | 2 +-
 arch/arm/boot/dts/imx51.dtsi   | 2 +-
 arch/arm/boot/dts/imx53.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index bc4de0c05511..5f90d72b840b 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -515,7 +515,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx25-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 112>, <&clks 68>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 5c4938b0d5a1..95c05f17a6d5 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -297,7 +297,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx31-sdma";
 				reg = <0x53fd4000 0x4000>;
 				interrupts = <34>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 8e41c8b7bd70..d650f54c3fc6 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -284,7 +284,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx35-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 9>, <&clks 65>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index c0c7575fbecf..3d9a9f37f672 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -421,7 +421,7 @@ ecspi2: spi@63fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@63fb0000 {
+			sdma: dma-controller@63fb0000 {
 				compatible = "fsl,imx50-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 592d9c23a447..853707574d2e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -504,7 +504,7 @@ ecspi2: spi@83fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@83fb0000 {
+			sdma: dma-controller@83fb0000 {
 				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
 				reg = <0x83fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b7a6469d3472..56b3c13f4eb7 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -710,7 +710,7 @@ ecspi2: spi@63fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@63fb0000 {
+			sdma: dma-controller@63fb0000 {
 				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 4f7fefc14d0a..ff1e0173b39b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -929,7 +929,7 @@ dcic2: dcic@20e8000 {
 				interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 06a515121dfc..61dd78467aea 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -747,7 +747,7 @@ spdc: spdc@20e8000 {
 				interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 4d075e2bf749..514ed4dbd6fd 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -842,7 +842,7 @@ gpr: iomuxc-gpr@20e4000 {
 				reg = <0x020e4000 0x4000>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6sx-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c95efd1d8c2d..2b5996395701 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -744,7 +744,7 @@ gpt2: timer@20e8000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
 					     "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 29148285f9fc..0fc9e6b8b05d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1224,7 +1224,7 @@ qspi: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@30bd0000 {
+			sdma: dma-controller@30bd0000 {
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.1

