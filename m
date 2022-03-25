Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB64E709A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358664AbiCYKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358680AbiCYKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:09:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963DD0834;
        Fri, 25 Mar 2022 03:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQim6szMYwVnnJdvAuXkNrh6ICUVbNudLbF5F2P3ZyvpF97BwBQznz0eMRbiiv3fo4+/CGeEcBl2Jpv5kHHmOdrAEuTVcQDajWujvhtqhF2ar1L72OO4RSbi7KUUVm48mGa+eZwChoDotx77VbpzfLiNkHqp/srsIVQ5s83snWNVAn9tucVcK9Jr63qUELnTFNq8RI3mvI/Ls+71XLlTFQY2wwjI3FAWE2Z/GnOkCOYOhaDr6u1m1l/RD0tmwBORZRSltxMvZdLwrYNzGsW730L5vo2rrDOn7CZfMsQktZEs4eZqdEQCpWZOr0a258wlZSUF0ojmtggehkvecMjaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CsuGZRBg1bnnGQ4zajm4SymPsV9gpg/67+DN4hZ2KQ=;
 b=fZKIZ0JFWVdyZV0GR25aXDipcDYXhq39RciOOBm7x9Q8hfzz+U7qfxoEMowtB6seB5B4L/xitA7bM6Evqgrhip6Dwul+RQHEAbdjMgBeGqUwUHJElTQrsAaI4wZGuNRpSzIgVaGVI8Q/q0lUYaCuvYtoUQT3LG3xlh9jlKZ6JOyvL/coCxUW0yTeFlwlFX/XQQ124T82eZNdhDNRvhRTDCJk99//VencAl/wvRf1A3BMT9uj7fT372GmH2e9mVQRInL6cSYgJ24flOX26DMS1Un1l4+xN8wdTrHr2xOPBIEK4L+N4tft6V9NLVhQz1EFbUGR7Xoj8ZdFlViYNC2jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CsuGZRBg1bnnGQ4zajm4SymPsV9gpg/67+DN4hZ2KQ=;
 b=Inh/YLfeO9R5Q0TFxoZCOFuOKkwIP59Q28nYYknKbbPOf/8Sd0ZXP5GAijTDgmmEDsSVJUxz02O3qDhvzLdKlzmvDkxu8JhTZke437vy8D4JM0iFrFhkGCjHngExXxj6vme7dbxHPFZH+BW4B2mNqG4um3of00zToOQ29WQZxho=
Received: from AM5PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:206:1::32)
 by AM0PR10MB2452.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Fri, 25 Mar
 2022 10:06:59 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::d0) by AM5PR04CA0019.outlook.office365.com
 (2603:10a6:206:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:59 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:51 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:50 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:48 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 09/15] ARM: dts: am335x: Guardian: Add lcd port
Date:   Fri, 25 Mar 2022 10:06:07 +0000
Message-ID: <20220325100613.1494-10-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 646c8200-86bc-4c15-064b-08da0e473344
X-MS-TrafficTypeDiagnostic: AM0PR10MB2452:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB2452F8FE7B55EBB352D52549A61A9@AM0PR10MB2452.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghir3rOjc72lS6YfuiC06HpgfgzxCAhPYJ9lsoidoyoJWO8KllkeVVhmkEeWBK54sCLRri5vkAU27L6t59vFTD/pp6pVdSXjQSlqptvoyBm0sq3AIqeg1a8iU+xKpCN7hsBznr7X4jYAPcACf1TIExIyQhAPKh8n4EFV/s2vnqpi6QxxHeoTUspYzUdm1iVy4gewUC1M0zMWgvhW8kPBboN3gDVtZjJARy2dzfY0GnfikATrhS6jVciWSbIpjyNu8VVmSYYeyBqkKagzqYaUmC5nu6A5RKAb1HVbyfffMWJafhG7FXyfqRjBq+EzXCgR9/uaowT/W9ocvwbIkhlwP9PSy/Megnj5u7NxZzM0cISfSm0qxnwlZA1NHW43DZLZAvsLnKx/6HV5Btuvs+bWRTwOvg/uWsLipMEUEW9s+SQWOOQgxrhsMGkNuhmChuIE2QuX2hGn3no4XA+PsnlzgBhQpVGspHeTIbwHtD2QL9NVu4FGVFSR5obr8yWxviD+SFXa+t+GgS3gkdNr7wAGJ+1gsH6zwN+26/Q0BEf1594i/A7OzquoaW/CFQWXyCOa8Yq2WIMbCdtaXAiTUua1JimsMntwcfp8RJ1WcSvh1JCNMQQQAMQxk0rse06PkTA4joC897+n1gDd8RFKV2pyf+KqY05yBFaY/ojVl2Egq7njwG4zWgtEhZGvO65JhyusafUJg5K4f1kpMMhMCxDFMA==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(54906003)(70586007)(186003)(86362001)(316002)(82310400004)(8676002)(70206006)(508600001)(40460700003)(4326008)(1076003)(2616005)(26005)(5660300002)(47076005)(110136005)(16526019)(107886003)(336012)(82960400001)(356005)(6666004)(2876002)(81166007)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:59.0971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646c8200-86bc-4c15-064b-08da0e473344
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2452
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

* Add port to the node lcdc

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index e0186043f18c..75ac8686091a 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -260,6 +260,11 @@
 &lcdc {
 	blue-and-red-wiring = "crossed";
 	status = "okay";
+	port {
+		lcdc_0: endpoint@0 {
+			remote-endpoint = <0>;
+		};
+	};
 };
 
 &mmc1 {
@@ -405,64 +410,113 @@
 
 	lcd_disen_pins: pinmux_lcd_disen_pins {
 		pinctrl-single,pins = <
+			/* P9_27, mcasp0_fsr.gpio3[19] (lcd_disen) */
 			AM33XX_IOPAD(0x9a4, PIN_OUTPUT_PULLUP | SLEWCTRL_SLOW | MUX_MODE7)
 		>;
 	};
 
 	lcd_pins_default: pinmux_lcd_pins_default {
 		pinctrl-single,pins = <
+			/* (U10) gpmc_ad8.lcd_data23 */
 			AM33XX_IOPAD(0x820, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (T10) gpmc_ad9.lcd_data22 */
 			AM33XX_IOPAD(0x824, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (T11) gpmc_ad10.lcd_data21 */
 			AM33XX_IOPAD(0x828, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (U12) gpmc_ad11.lcd_data20 */
 			AM33XX_IOPAD(0x82c, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (T12) gpmc_ad12.lcd_data19 */
 			AM33XX_IOPAD(0x830, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (R12) gpmc_ad13.lcd_data18 */
 			AM33XX_IOPAD(0x834, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (V13) gpmc_ad14.lcd_data17 */
 			AM33XX_IOPAD(0x838, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* (U13) gpmc_ad15.lcd_data16 */
 			AM33XX_IOPAD(0x83c, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			/* lcd_data0.lcd_data0 */
 			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data1.lcd_data1 */
 			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data2.lcd_data2 */
 			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data3.lcd_data3 */
 			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data4.lcd_data4 */
 			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data5.lcd_data5 */
 			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data6.lcd_data6 */
 			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data7.lcd_data7 */
 			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data8.lcd_data8 */
 			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data9.lcd_data9 */
 			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data10.lcd_data10 */
 			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data11.lcd_data11 */
 			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data12.lcd_data12 */
 			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data13.lcd_data13 */
 			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data14.lcd_data14 */
 			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_data15.lcd_data15 */
 			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_vsync.lcd_vsync */
 			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_hsync.lcd_hsync */
 			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_pclk.lcd_pclk */
 			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			/* lcd_ac_bias_en.lcd_ac_bias_en */
 			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
 		>;
 	};
 
 	lcd_pins_sleep: pinmux_lcd_pins_sleep {
 		pinctrl-single,pins = <
+			/* lcd_data0.lcd_data0 */
 			AM33XX_IOPAD(0x8a0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data1.lcd_data1 */
 			AM33XX_IOPAD(0x8a4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data2.lcd_data2 */
 			AM33XX_IOPAD(0x8a8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data3.lcd_data3 */
 			AM33XX_IOPAD(0x8ac, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data4.lcd_data4 */
 			AM33XX_IOPAD(0x8b0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data5.lcd_data5 */
 			AM33XX_IOPAD(0x8b4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data6.lcd_data6 */
 			AM33XX_IOPAD(0x8b8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data7.lcd_data7 */
 			AM33XX_IOPAD(0x8bc, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data8.lcd_data8 */
 			AM33XX_IOPAD(0x8c0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data9.lcd_data9 */
 			AM33XX_IOPAD(0x8c4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data10.lcd_data10 */
 			AM33XX_IOPAD(0x8c8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data11.lcd_data11 */
 			AM33XX_IOPAD(0x8cc, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data12.lcd_data12 */
 			AM33XX_IOPAD(0x8d0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data13.lcd_data13 */
 			AM33XX_IOPAD(0x8d4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data14.lcd_data14 */
 			AM33XX_IOPAD(0x8d8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_data15.lcd_data15 */
 			AM33XX_IOPAD(0x8dc, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_vsync.lcd_vsync */
 			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_hsync.lcd_hsync */
 			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_pclk.lcd_pclk */
 			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			/* lcd_ac_bias_en.lcd_ac_bias_en */
 			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
 		>;
 	};
-- 
2.20.1

