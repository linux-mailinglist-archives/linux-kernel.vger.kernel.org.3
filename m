Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7275E4E70FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355340AbiCYKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356264AbiCYKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:17:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C717CB3F;
        Fri, 25 Mar 2022 03:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr19PxnVqX4y8mmLcoxxx/wqx5tt9ExegQRhxfAIOa15RTwCUDgw2yqT6KUjrvmGS98VbaKxtG9c3SM77j8KpszXBj9xupnI+c//VpfcT/MvkIKR/ldIIwhRWgUeH1l6QrCc2dgPt0PF/9s+RHWoPFrsB+NwGdWMMeoj/ZO7Dx9U3LN31wxNA+8P+OMMHA+7/JPuWwS1EOq3psGJN4NGaQIMHbOLgxFAFcDjpzglkKsBPGDFMt/iCm7bUKAY7Mj71tPe2R6RD58OZ3sl12nyse76HcrYeEA6+X6Ul9PKpeuejkrlpA4ugt7pe3t4PqwkU633+yiDCoMh0TLCUXF9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+NrdrpZx6+FM540bwCZPYub7wXC3WRNxaSj+NQq3cg=;
 b=SS0QkbDW1zSP/wY2tYOFvHgeaZibxJeaDI7kA1TaRJGvdp07/Q/75S9d+QvShiH8DRi+xHbULfmCWibBTUfgiuhcThbm3PGpqmlUO9Fdc6Kvx9xce0/Hjn/z6lBeQLNDYBmDwjClLCraVHs8hClBmZa7NWJbLS0x+kRj4lWeOTrswCfv0XVCSQYIek7N247VJPRpcdwOPqanmgY+mIkIpNiGqfMnwZhjdGoco93SoN4j2exXHbcM/6eKkLW8qbJ9pg1/m9dh7wO/y+thRI9LDuMfLpweUOiiCAID2QTchdwRl/i1sngqLwjv61b8WJfDsB/swJGEGtDiho7NcmLAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+NrdrpZx6+FM540bwCZPYub7wXC3WRNxaSj+NQq3cg=;
 b=LdD91cugiMXMqKcv8N7FsKxYhtkNRGRjqx1t9ZndIcmx2zhOASog2AaBS6YZcJVC6X/qd0BDGGlGFWPXnc1NxYSSyMwanXMxC2XG0hKhGDfB8hvH4wS1BGtIJTeAQ0q2Jl/tUySUkRtxzaTlFWsQLCSQwMyu9rHh8n8KLq/64h8=
Received: from AM6PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::16)
 by DB8PR10MB3578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 10:06:49 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::62) by AM6PR10CA0075.outlook.office365.com
 (2603:10a6:209:8c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:48 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:38 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:37 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:35 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 03/15] ARM: dts: am335x: Guardian: Add keypad
Date:   Fri, 25 Mar 2022 10:06:01 +0000
Message-ID: <20220325100613.1494-4-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74feed4a-5d0e-4c4e-5617-08da0e472d2b
X-MS-TrafficTypeDiagnostic: DB8PR10MB3578:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB3578C8AA503489B25E5EDE8DA61A9@DB8PR10MB3578.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuFy5B5fwSuQgv1978Dnwp2CMxLq7dnKhOuvXIkU7gDEngz111bXzbOkGJtP3jBvzxmI9zueoMYs5+RWQJlxxIbwzQfe6PjdbU18hZ9wc/PantFoa8xeUyfitYO9MIn2SmaVoOIoBKEOJCAAnXa36uOoMorMkP9Il+VfB4tBy7+/ID34fXfRf++Ezh198KAENyvcHvIwx3p1OGJeu4SjJfHrNeOyEFrG3zO1O2qlmvjT2+3gOL1QWbiI3FfuFPqn5NPS0TswQEqOorkQV/30dLegAEGI4zkX0TfLeLDGW2x+VnUsw6QxFbrxtWBQj7PKqHTLjnNJ0dhx43xZt2YxMiFSeok/umVrK4DxrMagFHIw5imVmx8kFN3C54TgSx32lYDul06QdRmfoC/Ej+Uhu8WjILBjeUKxK2ggG/OSMSq7gSKyRqjAvFP6hW7ywuKoKVc6Cjv2c9bL5p739PPKyZm2kyPYKZEBo/iX0F9h2eUbq4Xl69d9e8I1K66j3VdPaPB7nSdnzTuc2P7LQW8NM6tNcIgxFgxscNbNSXCYxpwxjlIuff/CrlVEuK/APaw0ALZq6mK32no+had36+RsU81ua3ra3HBXzSuNlvl0FHZzNKO+nEo7zGkay3S6MENdz2ZiKPoPTHHRGtZBouuk501JCbUuUtn4Uy0GIv+x4NlXu9ltjxGdMVx/141xxq5wSRx0Lbnzc00lfqy3jtFBxg==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(107886003)(356005)(1076003)(54906003)(316002)(4326008)(82960400001)(186003)(2616005)(26005)(40460700003)(2876002)(16526019)(2906002)(86362001)(110136005)(36860700001)(81166007)(8936002)(8676002)(70586007)(70206006)(6666004)(5660300002)(508600001)(336012)(47076005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:48.8846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74feed4a-5d0e-4c4e-5617-08da0e472d2b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3578
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

 * Add support to guardian mt gpio keypad

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 645de77bdb56..6f59c5f36c0d 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -36,6 +36,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		select-button {
+			label = "guardian-select-button";
+			linux,code = <KEY_5>;
+			gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
 		power-button {
 			label = "guardian-power-button";
 			linux,code = <KEY_POWER>;
@@ -115,6 +122,22 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	mt_keypad: mt_keypad@0 {
+		compatible = "gpio-mt-keypad";
+		debounce-delay-ms = <10>;
+		col-scan-delay-us = <2>;
+		keypad,num-lines = <5>;
+		linux,no-autorepeat;
+		gpio-activelow;
+		line-gpios = <
+			&gpio1 24 GPIO_ACTIVE_LOW    /*gpio_56*/
+			&gpio1 23 GPIO_ACTIVE_LOW    /*gpio_55*/
+			&gpio1 22 GPIO_ACTIVE_LOW    /*gpio_54*/
+			&gpio1 20 GPIO_ACTIVE_LOW    /*gpio_52*/
+			&gpio1 16 GPIO_ACTIVE_LOW    /*gpio_48*/
+		>;
+	};
 };
 
 &elm {
@@ -369,6 +392,7 @@
 	guardian_button_pins: pinmux_guardian_button_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x940, PIN_INPUT | MUX_MODE7) /* (M16) gmii1_rxd0.gpio2[21] */
+			AM33XX_IOPAD(0x884, PIN_INPUT | MUX_MODE7) /* (V9)  gpmc_csn2.gpio1[31] */
 		>;
 	};
 
-- 
2.20.1

