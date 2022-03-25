Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA24E7091
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356551AbiCYKIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358651AbiCYKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:35 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00085.outbound.protection.outlook.com [40.107.0.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F16D0805;
        Fri, 25 Mar 2022 03:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkUPXuWYKCTJ3oS7T97QhdW7Zu7H3JJIxYtugmS/vzys46OtCE2gwijttDN0v7jmRYzEtYCYFx/zAhu//KHBEGmt0DQ/pFKmMJFFtKMxom2eZoGn6Oj4cAmpe4TzrsdCefHocwf7/T4pDxZ3EdzBkFT8sO3BHmDHrMDLLJqW+3BC+ZtGbd2MqkQij5uxdddTV6N4y+0xruXstXZARdGwQknJ/lK3u9VkBCp6qPLvJBoVOwbteACy4/an35m+jh0OpCaZnz8pdLGOexB4LyTXtjjN8d+PjUuJlblyX+EZ+GfinNpTNlkPqSohWRnnFNQLASLyFhsyueXO0TKmzY/ECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB2kLQd9YZGqlvuEMU9PXqdkzW5R/vw0HsPJ6bdSse4=;
 b=Ux7vusNv8KjRMaFsZMnz6wf6bSKvsSJarEHb5UgwRvfvk2i8ijwA3EgXdSRCkFIS3wTgB+HWkzioyrkbl0nrX7G45KbjlT7z+GWBl65VncQ3GiPcwIoeDzAztpA4/EqsBwc/Mg/z75jd6Z0AOtpDmUPAb/badvA/B3fzdu1vrNfxBEn487oQynsERkgoiyn3TQ48BmmiNC7JK+azwLhbWfTtWKaKXHduJyw7j+yAMgVUg+xc8LsTmJIsaE+SnufaUES2PcYLzQs80q0tSabffq7hEvwz+wcGRQGpODexPMAAvpnYYK0EbS8gOntTM3Wq2NHKMa+zgel9taqqcIbrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB2kLQd9YZGqlvuEMU9PXqdkzW5R/vw0HsPJ6bdSse4=;
 b=WYUmbtQdQnQeFaSC0Fw+Il3/AJ3hHHfTsmCqRl8i1N8IhCsveOyxkUljbEKz+CZ4F8KfPl+d/9LciBDQOLGmZt9acqsTgWItgaLfFL/YK475eeIQVTCPm4BttaGaGSxRIW1Dbqv7iPE1nmn9Qpg7CYJrd/eN8WX8kK7jkPOgQnc=
Received: from DU2PR04CA0022.eurprd04.prod.outlook.com (2603:10a6:10:3b::27)
 by DB8PR10MB3513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 10:06:55 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::fe) by DU2PR04CA0022.outlook.office365.com
 (2603:10a6:10:3b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.199) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:55 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:53 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:52 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:50 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 10/15] ARM: dts: am335x: Guardian: Update backlight parameter
Date:   Fri, 25 Mar 2022 10:06:08 +0000
Message-ID: <20220325100613.1494-11-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd06a8b-226e-41fb-d59d-08da0e47312e
X-MS-TrafficTypeDiagnostic: DB8PR10MB3513:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB351318CB2002D4C44E00246AA61A9@DB8PR10MB3513.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iCTLP3j4HzEHS9x274pcHfTpuKoZy1Eo+HnkvCamkBndnbUp4/HpkjxwtV2OcDGWTVmkymr37KajiNwn9Dg2mUu33WvTlTuJ+GbPaY+JRgKvYgF6xzCzEP8HDvDNlyzf4ziEC/4beTvfDu0VNoo+Jc5uf8t/PmqK4Ly4VxpxciNig3cATQFgGugw+I+RNSLWD/NY2kAsLv4UTWZgpstlwmcDy0puOkLaTUIz+K58ffRDpvwluUweOs1tZLP0/wv5+nm+7Q4rGcpGHwp/OU0YntBlmgvoAPzUFkVvxhQAGKvZPB11m1Mb9K94W94knsXqfgX9c+wkC0XsIEGSuykXltTe6jYkgBoTfXy/sqJmvXtp8ktjIBskNzSgX/sR3WfPqbebd+U0g5iG3PntM5uD+B2PLQHypBNUifUWzqIBuHWR/GpBFuc2wgaZQNSPZdgrZod2zoNkXYBY0FnRFpzv63SUmhWsR9joKA1Ksqeh8KjuOlkCBdnLQIiqjzFVyaaAe76C850F6DGNOTfbQJHMqAheX3R68yCnWDVZ4Ax/DaWPsrCsYjBNAD1wC94cf+ysaGlsDkdKBBEmhU9XPMmDS/88HqXmXtzjmj+OOUi4KIKx5ckoezX8eFRBhBifCRL42uLT+/Xxb03RzJoAQshJQqNqozZ1yUsUKmo0lw6E3OzeNOO6ZBw6zSfEDm7H0ijTHW1UGDXg4rz6W/PurvxUJsCPqUS6RDjh5Ra0wbtdpaQcmY4XYxc3yKGMsu63EwKIg2SF9le/ZjsL6pBU0AZmDXTDkS2dVoTkibS1Iim1wE=
X-Forefront-Antispam-Report: CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(107886003)(5660300002)(83380400001)(1076003)(2876002)(16526019)(2906002)(2616005)(966005)(81166007)(82960400001)(8936002)(40460700003)(356005)(26005)(336012)(186003)(15650500001)(82310400004)(508600001)(8676002)(47076005)(110136005)(70586007)(4326008)(6666004)(54906003)(70206006)(316002)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:55.5868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd06a8b-226e-41fb-d59d-08da0e47312e
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3513
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

 * Update default brightness and dimming frequency
 * Enable current sink, while initialization

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 31 +++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 75ac8686091a..fab844815065 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -291,14 +291,34 @@
 #include "tps65217.dtsi"
 
 &tps {
+  /*
+   * Configure pmic to enter OFF-state instead of SLEEP-state ("RTC-only
+   * mode") at poweroff.  Most BeagleBone versions do not support RTC-only
+   * mode and risk hardware damage if this mode is entered.
+   *
+   * For details, see linux-omap mailing list May 2015 thread
+   *  [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
+   * In particular, messages:
+   *  http://www.spinics.net/lists/linux-omap/msg118585.html
+   *  http://www.spinics.net/lists/linux-omap/msg118615.html
+   *
+   * You can override this later with
+   *  &tps {  /delete-property/ ti,pmic-shutdown-controller;  }
+   * if you want to use RTC-only mode and made sure you are not affected
+   * by the hardware problems. (Tip: double-check by performing a current
+   * measurement after shutdown: it should be less than 1 mA.)
+   */
 	ti,pmic-shutdown-controller;
 	interrupt-parent = <&intc>;
 	interrupts = <7>; /* NMI */
 
 	backlight {
 		isel = <1>;  /* 1 - ISET1, 2 ISET2 */
-		fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
-		default-brightness = <100>;
+		fdim = <500>; /* TPS65217_BL_FDIM_500HZ */
+		default-brightness = <50>;
+		/* 1(on) - enable current sink, while initialization */
+		/* 0(off) - disable current sink, while initialization */
+		isink-en = <1>;
 	};
 
 	regulators {
@@ -408,6 +428,13 @@
 		>;
 	};
 
+	led_bl_pins: gpio_led_bl_pins {
+		pinctrl-single,pins = <
+			/* P9_14, gpmc_a[2].GPIO1[18] (backlight control) */
+			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE7)
+		>;
+	};
+
 	lcd_disen_pins: pinmux_lcd_disen_pins {
 		pinctrl-single,pins = <
 			/* P9_27, mcasp0_fsr.gpio3[19] (lcd_disen) */
-- 
2.20.1

