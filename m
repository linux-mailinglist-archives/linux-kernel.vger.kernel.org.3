Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85C4E7085
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358645AbiCYKIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358626AbiCYKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:25 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03on0631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe09::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0ACFBBD;
        Fri, 25 Mar 2022 03:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgsIFjj1aVTOjuLb3yCgqhUAmuWLC+dP2ruliZi43Ts6emdymN+ku/+oDNmK1/qKRYuzHjcKbbaHwoq8HJWEpgvF2FG6umNqO6GWEkzpJ5G8oXJzbPnEPIqjMUxih/CblBgEUvAtmVJ9NUBYBTuBUSstNu3n9tD5WEr89KOdRpbdulI/hnRzjKCA2VVMx9NTGE1f2LbBdPVgwTyfjHssOXZ/5jz8sVZKtuJXRfUsbw9cNzIJDQLxU9k+pjN8a8IwNyT0FEbn8rl6dkQ1EkefvkF/j6zGgY0X70jLtOIGdfQo3kp1suqhHiHlyF4qHYuKpB0PRgK40S8yeSAFudHl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqdNEo/cOvlB6o+BdEddDKkGDUukfhIuLL9xk4VClo0=;
 b=iT/YzPOsIHvfb4sdkYDjQLLyf50Vxvq2I+L5ZFI9pGjlBQeRDTPseVwc4UWi4FG0YzY3s7JuNQ/MgtNOUvc6Co8OOzvteDKMVpwGSZT45avKS/9i0wBzF3XN0wfD32taPKOBLHwGk41hyVa5SB9NU1maE46mQ2+wQQO3UliXFFLnsZBbF3Cde8IAFT/b88GaCdFuNFy3RA+P2AwsActuCM4MtQ16nbV4GX1YEV1MGyp0hVGVjaL3B2J11E+x1dJD4h/yxSYlMeXyf6eVaiobYgt+oHLD//rIVz/tSJeMrsnTrwgI3UKgTUFyYAXdzUlA5Q14CotJHCgxaF9BwVeVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqdNEo/cOvlB6o+BdEddDKkGDUukfhIuLL9xk4VClo0=;
 b=eX2NObsJ6bo3CIWqbkCMpd5ipiD1Ff38iaaa0daOb/dNIi1AW5e6cxb/Z5MmglSDaD11dsWTzY0mX6pz3mD/xXjPFWrqKu7acbn6curkt2/OK3aarO6HLv+SNDW5+QV7Oepfj4JpCWXFfVytQKTAR6bpPPIQOuxuP5vDuhHLmrY=
Received: from AM6PR10CA0108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::49)
 by DB9PR10MB4348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:229::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 10:06:46 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::28) by AM6PR10CA0108.outlook.office365.com
 (2603:10a6:209:8c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:46 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:33 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:33 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:31 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 01/15] ARM: dts: am335x: Guardian: Update NAND partition table
Date:   Fri, 25 Mar 2022 10:05:59 +0000
Message-ID: <20220325100613.1494-2-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1057ac3-209c-4666-596e-08da0e472ba4
X-MS-TrafficTypeDiagnostic: DB9PR10MB4348:EE_
X-Microsoft-Antispam-PRVS: <DB9PR10MB4348DCBC03C707FA29D588DBA61A9@DB9PR10MB4348.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVeRm1I2DIBRVp7j2OFKZp8mKqJYs3bqLj33LFeNlWZmfb6rA5JH+ed9oleUDdrT95vhmj/TQ4dwDYQMWqvE1NEhG4jamz6rLxeJfoR1jl27+9CCmWhcTOGnsOkJRXK5IC8sY+YK6bkHC7/khTQghSU+QoBK7K1SOCDpwvpqztZv2+tRSEAyxsguaAXOvqO3LLiUVljZzwgAWOrdXrZF7UvCO3qEfE0LTIGNT9xfyZlwvnhlQfSx+txaJcK1W5Ed1lc/dtE+J8EzidneYd3dKPnMkuYtjkgxEa6Jj02N+joaWyDSMugCJkz+pTlAxVPYBrmVwb1pSGhSSCEXR70cN64le0u246NxuxCQOWKYxIW47LSxcBSg6a7lQhCdrZlvWg1xipjb73CWo2Str4GBsMDBngOLSl4oz+aFpjZlXlYpWdVzLef/ys8lWCC7NEzZOqP9aNnEA+FTyptGVypQwyt39eX7ZVoP8SpBT5eWgs2Nkbu/wGw5JEYs6eOIRSpfz+h3IZilv8CVPqgCk50ITJvLtHprtRSQdEzh96EdaVahXCCLoWi9ZMpVomDraPho2fZI8jA4gTELiEKmYRduO9zwAQ/ouwynA/V+at+7l/pP3FuHlGpZ4m467L8G/zmMVsiVtHuK1r1PpEuMCeikeE0CCovXEFtJyyMjPGZ1Cgxo9OUgzF6UBYBw9ru/PAx6RDb/3G/CUGjnoAs9VBFdwA==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(5660300002)(8936002)(110136005)(6666004)(82960400001)(82310400004)(54906003)(508600001)(316002)(86362001)(26005)(186003)(83380400001)(47076005)(81166007)(336012)(16526019)(2876002)(2906002)(36860700001)(15650500001)(1076003)(40460700003)(2616005)(107886003)(8676002)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:46.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1057ac3-209c-4666-596e-08da0e472ba4
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4348
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

 * Update partition table to save env and splash image
 * GPMC config values optimized for Bosch Guardian Board
 * NAND Chip used by Bosch Guardian Board is Micron MT29F4G08ABBFA

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 65 ++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 1918766c1f80..41b7adf78656 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -133,28 +133,29 @@
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>; /* termcount */
 		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
+		ti,nand-xfer-type = "prefetch-dma";
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
 		gpmc,sync-clk-ps = <0>;
 		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
+		gpmc,cs-rd-off-ns = <30>;
+		gpmc,cs-wr-off-ns = <30>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <30>;
+		gpmc,adv-wr-off-ns = <30>;
 		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-on-ns = <0>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
+		gpmc,we-off-ns = <15>;
+		gpmc,oe-on-ns = <1>;
+		gpmc,oe-off-ns = <15>;
+		gpmc,access-ns = <30>;
+		gpmc,rd-cycle-ns = <30>;
+		gpmc,wr-cycle-ns = <30>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wr-access-ns = <40>;
+		gpmc,wr-access-ns = <0>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 
 		/*
@@ -198,18 +199,33 @@
 		};
 
 		partition@6 {
-			label = "u-boot-env";
-			reg = <0x300000 0x40000>;
+			label = "u-boot-2";
+			reg = <0x300000 0x100000>;
 		};
 
 		partition@7 {
-			label = "u-boot-env.backup1";
-			reg = <0x340000 0x40000>;
+			label = "u-boot-2.backup1";
+			reg = <0x400000 0x100000>;
 		};
 
 		partition@8 {
+			label = "u-boot-env";
+			reg = <0x500000 0x40000>;
+		};
+
+		partition@9 {
+			label = "u-boot-env.backup1";
+			reg = <0x540000 0x40000>;
+		};
+
+		partition@10 {
+			label = "splash-screen";
+			reg = <0x580000 0x40000>;
+		};
+
+		partition@11 {
 			label = "UBI";
-			reg = <0x380000 0x1fc80000>;
+			reg = <0x5c0000 0x1fa40000>;
 		};
 	};
 };
@@ -470,20 +486,35 @@
 
 	nandflash_pins: pinmux_nandflash_pins {
 		pinctrl-single,pins = <
+			/* (U7) gpmc_ad0.gpmc_ad0 */
 			AM33XX_IOPAD(0x800, PIN_INPUT | MUX_MODE0)
+			/* (V7) gpmc_ad1.gpmc_ad1 */
 			AM33XX_IOPAD(0x804, PIN_INPUT | MUX_MODE0)
+			/* (R8) gpmc_ad2.gpmc_ad2 */
 			AM33XX_IOPAD(0x808, PIN_INPUT | MUX_MODE0)
+			/* (T8) gpmc_ad3.gpmc_ad3 */
 			AM33XX_IOPAD(0x80c, PIN_INPUT | MUX_MODE0)
+			/* (U8) gpmc_ad4.gpmc_ad4 */
 			AM33XX_IOPAD(0x810, PIN_INPUT | MUX_MODE0)
+			/* (V8) gpmc_ad5.gpmc_ad5 */
 			AM33XX_IOPAD(0x814, PIN_INPUT | MUX_MODE0)
+			/* (R9) gpmc_ad6.gpmc_ad6 */
 			AM33XX_IOPAD(0x818, PIN_INPUT | MUX_MODE0)
+			/* (T9) gpmc_ad7.gpmc_ad7 */
 			AM33XX_IOPAD(0x81c, PIN_INPUT | MUX_MODE0)
+			/* (T17) gpmc_wait0.gpmc_wait0 */
 			AM33XX_IOPAD(0x870, PIN_INPUT | MUX_MODE0)
+			/* (U17) gpmc_wpn.gpmc_wpn */
 			AM33XX_IOPAD(0x874, PIN_OUTPUT | MUX_MODE0)
+			/* (V6) gpmc_csn0.gpmc_csn0 */
 			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)
+			/* (R7) gpmc_advn_ale.gpmc_advn_ale */
 			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)
+			/* (T7) gpmc_oen_ren.gpmc_oen_ren */
 			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)
+			/* (U6) gpmc_wen.gpmc_wen */
 			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)
+			/* (T6) gpmc_be0n_cle.gpmc_be0n_cle */
 			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)
 		>;
 	};
-- 
2.20.1

