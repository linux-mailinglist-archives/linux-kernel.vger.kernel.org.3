Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0749A5A8B26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiIACCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIACCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:02:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240511CFA8;
        Wed, 31 Aug 2022 19:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7hGpJ2Sv41bhWVW5YlN/4tBjc4rLtV/Qmf1Ab95qVTK2lK8cD5KEecYnIv1QQmBhtpdMs8xB28jvf2rv5FIT7OgWBMjE1TPe9YPObYkr2KZ3Ve9CBLCHU22kSkhlrQd/g6gklRuRoghpVlAZs78qEWA3MRxQeI9GobcJpo+Cw40iI5fJQivd+xtoclv/Hdc+7oQftYDdfbyRQH2pq3llO3BNmmQm7Dfb6QT2UaopGO7aH1MyMhVcQSmmTMAMKsINhO9hPUE6aFHOnSSsDYl5EMXVuID/lIurVHsrNiqNU1YLTR6VhU/fUXOQxjAmZwz46DAp6f8Bgb1E7JrLe+Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RliWHG/hoezWalVNV+sQSmj+LjOk1JfSSi3qn0sqnM=;
 b=bFNYqSsMfYEAZ9y66bJpCty6D82g586Rj0gVorLYnhzC3RFmBZEIP7Ktpk2rxuA/XFtcfyfir+YTL3I2TULrwUNL+mqGk4g8p2t3qzQCLzSxih1BbAh0LLLoCOu229sZgO6sIdAzTzjR1i+2LE95GVw9x5GrWgl2u8SrlOWxPet+NU2GkriKRvvqc8eoa9HJjZZU0yr7yEPMFJKElF9bpL0RGaOxm0sg1Z5GX/0SqGlSG1LQpvs3qzBdTGSv9VdgkGlRndDNfq/H8i790LJnNggEzwxUY43/4f7fNb73FLvod7LN2SiGDS+oEEiAee7XYEb4IyIWUoeOmJEGwvylZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RliWHG/hoezWalVNV+sQSmj+LjOk1JfSSi3qn0sqnM=;
 b=jb2pWMMm4n4mUVOOc8C6BEYfXlrfxNJq7ljjv0mvGfC/+2nrM4c4rT7je/wtgUbvj2uPoSdtHOXu7eO6PWsAeETGlxH+JM5r1GVobliMIAivHhdf+bnkDyzOVxO8CH/37rKrkBeZpTFKjlhwarG0el09MTm6a96vHfVBL195xdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 02:02:29 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:02:29 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/4] ARM: dts: imx: update sdma node name format
Date:   Thu,  1 Sep 2022 10:04:02 +0800
Message-Id: <20220901020402.50206-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40bf43f5-7baa-4d7c-48f3-08da8bbe067e
X-MS-TrafficTypeDiagnostic: AS8PR04MB8724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIbUOrzHt78J9UqKidPjZzddthquHYdJ72uzNL9+dRGUYoWAKrqLACPuEfjKAAr3y93OkVhfqVOkH9En8SBMBaBFVkdwWvbaspHwbZJUoMSDiLQLXOfjgKbSi3gCvsvUKG81xtT/6y1ElLIDNjEM4UNfJNVDSihYTHQkDHpi4JnSf2bjeuEiNKcbhZkW/HnsqzQEhOx6HV19QM6aGxxmiUU09qf71zsT9Rl/1hH7TxY7bHw/nCjVK05ophNlBmfvzvkvaet+EvS1rePKfE+SDeFmGAzcYVbjgs5e81P8m9KPVz/XGn2t22oKBm9bsYdU65mHO7OYMAe3B6p+smGJLiWz3K0ds0TzHyV2x6wThxmAvo+eQHh0tQQWbjkx1BSTIqmtVoBYyeM6CnoZgU4aasykldzvo+thyAFlvPLnr0b/Hwm2BpOLrB9QRqEObAt7WpOuDI++aj3vBaZxLz5lWtWtkQSSZrbNOi1Wzk29okZqMc72uO5KPcqLyaTnri8d+GNNX7mKV90KQtqOGeG856JvGz1JpEpCKWPHoao17z4F0P2QW+KFGPgWU8xUD6Mwb+/PJECuacr7bFKSvG/lOCbTafUgriEJ7uoKkXGyWxLE/H75JKLHk/4+eTO066uarG/0fScYwFl4lUjyIdcYDFCyiVoZsuJj5Osd/7/IbZ5mVBtLVuj7ZzrQ1lvLB43JL8GkKsyPD+WV1OUCnsqs9+48pjh2N35/Duwni2Mw9DS7GVG8pO7W6xKIQLBuRbeB8eGZWGQATb1nwcVhvgO2DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(8936002)(4326008)(8676002)(66476007)(66556008)(66946007)(6486002)(478600001)(26005)(6512007)(2616005)(1076003)(83380400001)(186003)(6666004)(44832011)(5660300002)(86362001)(52116002)(2906002)(41300700001)(316002)(6506007)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAKnG6WX7PSp7P8OkHEKhz1f/ut6+UppTIMGVenWvUWQzxNXTO//qbGUVXQL?=
 =?us-ascii?Q?cI/jmu7YVILKFoMCyWR/pUiPCKchVBXv/c0Nd5OCPBBh4UhoQpahtOqs0V4R?=
 =?us-ascii?Q?wthKDJ/dC90rzlYpdKmKfDtlOxFU1dWxkKCz7FNJLy28A3zjQ2I0sJbgaJW9?=
 =?us-ascii?Q?fvI72GbRqvE9O/YSnNErLLQypS2GciNIph/iD5OtA2zWk1/50Lq1qcTdnkFn?=
 =?us-ascii?Q?qVVOjUtOf7ibQNhhisqR53TWp198E9tiysJa0ug6nV/AtUBuZnm+rNL5lBnJ?=
 =?us-ascii?Q?GrIScOdFx70qC6QCnn2/2wFKcX4ShB9CYnq3BLwgod324IsHADFG+FKA1GtA?=
 =?us-ascii?Q?rHJ6dF8Td2g19LRhf/gUVZUZzOX0Y6YF6xwbAN2wGqnPVunzhT8VWIRcu2v+?=
 =?us-ascii?Q?wF82uoWwiXKy83OwacnJuOHgQ83asVllRlJk9FNrMyvl3O/jmlLSxBiTy3xE?=
 =?us-ascii?Q?ybSIDxntfi4sWe0rGdrR9hJD7XjzrQmxGdm6BJ+D6cw7XKwhgeFSTmhA/NlK?=
 =?us-ascii?Q?48VzeJabUyoXzswSXjO2P3Aj5k3noXnyTAjvN9eDZtpxhnro6HC1SX84cy5B?=
 =?us-ascii?Q?nj0lat6yi638hdcPT26ZCF6vnhkF3XKqmajcT8Ul1TWK2pj8MFU+s64q/MFa?=
 =?us-ascii?Q?V3cqRbbmaVyifd9wV28IiAxwX0K4aJNNPROPqi/6lfI5jeFJl0I34h6zIZ+P?=
 =?us-ascii?Q?iIDNxZT9iH1Anm2gAs3rAKtcsrIeTNCLRwLmUsArJI8Lb5TYzfjF8PzlGWxl?=
 =?us-ascii?Q?pNT8XKPe4CbC/wSJe8q0YlTCF/7gMQoU0SdJWJg3/vmVEUQT4/5Q8ZHZsE4Y?=
 =?us-ascii?Q?EdWtcuf42U2fPWx2qBF252ez0um7RluhKzdmGt1AjqH+OvolVfYM7hPcMp0z?=
 =?us-ascii?Q?s13n5pLeOdNrPn9yMmZE7yVl/rRTw0EGLUglW0r8M1k9Fo1AY1Ipjyt2oebc?=
 =?us-ascii?Q?cmukyVCwKR41ohfcd2nWkaSKShw3wpKITjeUMmOmTiYLZ1T5jzj+JM4fhZ3S?=
 =?us-ascii?Q?yejq7Ahp3eaJXaFfU9RgpflEt8/9aLBuDQPs9bcwaRUwX+XI5LNo7Dhf3FeM?=
 =?us-ascii?Q?lFd1Y4jZRm/9VQ82xI3L8S81S9V+z0naXXFDYk8fC8sShc/6K1ztB3IjUqqg?=
 =?us-ascii?Q?pChI3VLdhGBB8ixeK1IGkt/Q1+2YyQo6n51lXb7emAakEl4VF0qaA/C6dC83?=
 =?us-ascii?Q?pJUVWkMbMOADh13/dFnl1zucJPepi7WbyTUHUdLZQW8pvm+1WwwwQjZaLa2+?=
 =?us-ascii?Q?RTNeJUJ1pnn2KirGE6+bJ76Trb53Q0M4VRCy+N0X1UMGZkAC6pTk+Mytk+7A?=
 =?us-ascii?Q?Irr3EDFDaLA1WKcgPhAMMDIUo8XDKc/q+2kBU4rRJtjg5PvBsswiue40y7Zb?=
 =?us-ascii?Q?8Z0uEVLCplkHTHhIElfkVKRyarOOBqKcYnA/wZD0bpTRFf323O204LPusgSs?=
 =?us-ascii?Q?jjdO+84Ydmte/5EIVmNj4V5GsNVG5YD4mNfCgdtDI2xUeiadvmdgUSNzzxes?=
 =?us-ascii?Q?hptYrV8fyDQx13L5EU8Tchz81/fdj4Fycq+keyPnEpBtTjV4yKhwzjdblWeV?=
 =?us-ascii?Q?AIHy20qlmjdy+JIaEawgwLh8Ko6c0dOrK44ebbSc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bf43f5-7baa-4d7c-48f3-08da8bbe067e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 02:02:29.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+Dr1KiTdKUVxkfxCpCzMpL+1hI4cm1Squa4ACLa4RM45kbCPgA+Iaax1Q03/Y66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change the sdma node name format 'sdma' into 'dma-controller'.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
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

