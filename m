Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EFA51D245
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389538AbiEFHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiEFHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:32:56 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96A66F97;
        Fri,  6 May 2022 00:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwgYSsK1Xcfo2gOS1cdyvpe+fG/hpIQ33lFYx0ZFlJmHAcGiePi6M371/YwELb64JxjeU4/Fdj6EpEsZHVL8NYQlhw1kjvrzrAD0wI+Br2pE8qqLa3YVG8DKXe3hv7+lTqXATZdyhOMv5YTbI+zZUaFicbrbnvTi8iBp1hJ0OD4MV1dIDVXyiGipyX6kL+xsN05sFBKzZIkVmcBlRZ/kfFTSxBa3yzJu+02DHtX3dEE2e69VWoxdiCFeG9yRNRAQn+NpHgFEbvIF7TES4OxuDEpVe7JaYxbXZ4yyjUsHT1EZEcuMFAFUKuVKRyBlOJD+xck8TXlxUy26paRl0segCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpmYBC/isXjTkDVRznKgiK/+FZEmaiU+i3rlY86ykXQ=;
 b=JebdVzLymu5C5BXWr20pa+ffqJdElhh29EYqlCtlSwGPaK2GSH6NEap4mYVygw4CbE23rsVXHNDjgd2CxLHOp2uoXx4dqUTzxsWkm/ic4zkf4XBc4nCK/MflirfHXHmqvHSqIHJ8V7kcNhmPoP36dt8IUEUTygCEnvxrd7VgkoP0PW0vdkGtIOrw1lxok71eHGBrKEwlF8hILtuE0Hv1YAV7cU6I2cR0sPv/3fPaTUSdDKQYyzf7zRqrH4/q5+RMExqg4U6wjgeCVgMk0tS7KsWr39g0Gr36BZDb84G9XXr+RrcS2J5OhxsxXYj60m53XvarZ042grQWa1NDrTJjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpmYBC/isXjTkDVRznKgiK/+FZEmaiU+i3rlY86ykXQ=;
 b=gg8BYAjqOCdYDh7yPwP2AnSwwZedulysFT2EZIhQ1EIL7O2PZH5hYqmu4zIQdrsRUfryyf+2WUJ12Sp1jRbqvBM/Ss3AqwmXTJao4+JppBucSr52VHEehIR7MvVgmKYEU6uVXhWEujWSfoeF0OPFISHYEQFccfGcDFaQ9NUjr2Y=
Received: from AM6PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:20b:c0::14)
 by AM0PR10MB3969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 07:29:08 +0000
Received: from AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:c0:cafe::2) by AM6PR08CA0026.outlook.office365.com
 (2603:10a6:20b:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Fri, 6 May 2022 07:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 AM5EUR03FT063.mail.protection.outlook.com (10.152.16.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 07:29:08 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 6 May
 2022 09:29:02 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 6 May 2022 09:29:02 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 6 May 2022
 09:28:57 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>,
        <mkorpershoek@baylibre.com>, <davidgow@google.com>,
        <m.felsch@pengutronix.de>, <swboyd@chromium.org>,
        <fengping.yu@mediatek.com>, <y.oudjana@protonmail.com>,
        <rdunlap@infradead.org>, <colin.king@intel.com>,
        <Gireesh.Hiremath@in.bosch.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: [PATCH v2 1/4] ARM: dts: am335x: Guardian: switch to AM33XX_PADCONF pinmux macro
Date:   Fri, 6 May 2022 07:27:34 +0000
Message-ID: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c2f344-43eb-4588-262a-08da2f321b87
X-MS-TrafficTypeDiagnostic: AM0PR10MB3969:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB3969AC956725FC14727FAD74A6C59@AM0PR10MB3969.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBEzwcpWiBVPC0zZyvdWhpIqOs0DryCSnJqBeJDgJTf4ubBOY+m0ptIotEnH3m/F45D8I3j21NF0XfajU5GBnfqfSjcXvDFmPTWtsdJeao4Bjr+Q8e1+T8D/k31wLa0+85cmeGbFYccRrFMs4HMcdnVM5YoqsMtvSO7vf04ixzsUO9vWEDRWE1HzDv1P3Wtmxb2ykUPSGazmRLqKyx1CYEWFvYSVhX4kLYHrjvozsPV7MzXNQlJvQ5c/YC6idZOA9mGGooFfbHWmNC54EPcyuEzc/OeD2pLpKq1q2xhJ4Mc4oziuv2jYpRPDh9m7A0+C2KlTrUK5lE/7rwSYBU/lv4crpuQtwOIqDOhDQBlchF5FQxtQ6iK4DZ2UJ9MXbMNqmoqreLjTfiEnEewJtxFtFyQ6qkarSQ1n5Be5u5OPoF50jsb5WYfqD/kvP2VdMIcLTvLnVEjSHL//JNl61dgDp5itUn6A+d3WvUfYv7Igh9/wWCmaNpIMh4HoyofKHxcBtLCJUZfCXbKno1GVU5uCxOYcMhT37v3DZLYMI2/H6mtOYWdMYoIdpwnxkcPjuYGSnafbwDN3U6IorpVp6yT/0Vviu8QHwJhFoZif1xtb8sJED5wHr/TXrUqatntrEeUDFt0L7UK5lkVXlHtN9vsV3rjFUzVgfnhjU2WAhc2A0y9Ci2RtFFDwA0Ak42evJnalINvabrCoCMaJPH+foczGsJZ3SzRVEPFMNrWTfW79zHk=
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(186003)(16526019)(47076005)(86362001)(1076003)(83380400001)(107886003)(336012)(356005)(7416002)(81166007)(5660300002)(82960400001)(36860700001)(2906002)(8936002)(40460700003)(508600001)(70586007)(70206006)(8676002)(4326008)(110136005)(6666004)(316002)(54906003)(921005)(7049001)(30864003)(26005)(82310400005)(2876002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:29:08.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c2f344-43eb-4588-262a-08da2f321b87
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3969
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

switch the pin definitions from AM33XX_IOPAD to AM33XX_PADCONF macro

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---

No changes since v1

 arch/arm/boot/dts/am335x-guardian.dts | 229 +++++++++++++++-----------
 1 file changed, 132 insertions(+), 97 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 1a7e187b1953..94d9e51cd0f9 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -485,7 +485,7 @@
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
 			/* xdma_event_intr1.clkout2 */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
 		>;
 	};
 
@@ -493,254 +493,289 @@
 		pinctrl-single,pins = <
 			/* ADC_BATSENSE_EN */
 			/* (A14) MCASP0_AHCLKx.gpio3[21] */
-			AM33XX_IOPAD(0x9ac, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
 			/* ADC_COINCELL_EN */
 			/* (J16) MII1_TX_EN.gpio3[3] */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
 			/* ASP_ENABLE */
 			/* (A13) MCASP0_ACLKx.gpio3[14] */
-			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT_PULLUP, MUX_MODE7)
 			/* (D16) uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE7)
 			/* (D15) uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE7)
 			/*SWITCH-OFF_3V6*/
 			/* (M18) gpio0[1] */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE7)
 			/* MIRACULIX */
 			/* (H17) gmii1_crs.gpio3[1] */
-			AM33XX_IOPAD(0x90c, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_OUTPUT_PULLDOWN, MUX_MODE7 )
 			/* (H18) rmii1_refclk.gpio0[29] */
-			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
 			/* (J18) gmii1_txd3.gpio0[16] */
-			AM33XX_IOPAD(0x91c, PIN_INPUT           | MUX_MODE7 )
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_INPUT, MUX_MODE7)
 			/* (J17) gmii1_rxdv.gpio3[4] */
-			AM33XX_IOPAD(0x918, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	guardian_beeper_pins: pinmux_dmtimer7_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5) /* (E18) timer7 */
+			/* (E18) timer7 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT, MUX_MODE5)
 		>;
 	};
 
 	guardian_button_pins: pinmux_guardian_button_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x940, PIN_INPUT | MUX_MODE7) /* (M16) gmii1_rxd0.gpio2[21] */
-			AM33XX_IOPAD(0x884, PIN_INPUT | MUX_MODE7) /* (V9)  gpmc_csn2.gpio1[31] */
+			/* (M16) gmii1_rxd0.gpio2[21] */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT, MUX_MODE7)
+			/* (V9)  gpmc_csn2.gpio1[31] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT, MUX_MODE7)
 		>;
 	};
 
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c0_scl.i2c0_scl */
+			/* i2c0_sda.i2c0_sda */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	led_bl_pins: gpio_led_bl_pins {
 		pinctrl-single,pins = <
 			/* P9_14, gpmc_a[2].GPIO1[18] (backlight control) */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE7)
 		>;
 	};
 
 	lcd_disen_pins: pinmux_lcd_disen_pins {
 		pinctrl-single,pins = <
 			/* P9_27, mcasp0_fsr.gpio3[19] (lcd_disen) */
-			AM33XX_IOPAD(0x9a4, PIN_OUTPUT_PULLUP | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_MCASP0_FSR, PIN_OUTPUT_PULLUP | SLEWCTRL_SLOW, MUX_MODE7)
 		>;
 	};
 
 	lcd_pins_default: pinmux_lcd_pins_default {
 		pinctrl-single,pins = <
 			/* (U10) gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (T10) gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (T11) gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (U12) gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (T12) gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (R12) gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (V13) gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* (U13) gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE1)
 			/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA0, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 			/* lcd_ac_bias_en.lcd_ac_bias_en */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | SLEWCTRL_SLOW | MUX_MODE0)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT | SLEWCTRL_SLOW, MUX_MODE0)
 		>;
 	};
 
 	lcd_pins_sleep: pinmux_lcd_pins_sleep {
 		pinctrl-single,pins = <
 			/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA0, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA1, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8a8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA2, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8ac, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA3, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA4, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA5, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8b8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA6, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8bc, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA7, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA8, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA9, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8c8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA10, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8cc, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA11, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d0, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA12, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d4, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA13, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8d8, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA14, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8dc, PULL_DISABLE | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_DATA15, PULL_DISABLE | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_VSYNC, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW, MUX_MODE7)
 			/* lcd_ac_bias_en.lcd_ac_bias_en */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW | MUX_MODE7)
+			AM33XX_PADCONF
+			(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN | SLEWCTRL_SLOW, MUX_MODE7)
 		>;
 	};
 
 	guardian_led_pins: pinmux_guardian_led_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x868, PIN_OUTPUT | MUX_MODE7) /* (T16) gpmc_a10.gpio1[26] */
+			/* (T16) gpmc_a10.gpio1[26] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_OUTPUT, MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)         /* GPIO0_6 */
+			/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* mmc0_clk.mmc0_clk */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* mmc0_cmd.mmc0_cmd */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
+			/* GPIO0_6 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)
 		>;
 	};
 
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
 			/* SPI0_CLK  - spi0_clk.spi */
-			AM33XX_IOPAD(0x950, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 			/* SPI0_MOSI - spi0_d0.spi0 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLUP, MUX_MODE0)
 			/* SPI0_MISO - spi0_d1.spi0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* SPI0_CS0 - spi */
-			AM33XX_IOPAD(0x95c, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* uart0_txd.uart0_txd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
 			/* K18 uart2_rxd.mirx_txd */
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE1)
 			/* L18 uart2_txd.mirx_rxd */
-			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLDOWN | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE1)
 		>;
 	};
 
 	nandflash_pins: pinmux_nandflash_pins {
 		pinctrl-single,pins = <
 			/* (U7) gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x800, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT, MUX_MODE0)
 			/* (V7) gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x804, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT, MUX_MODE0)
 			/* (R8) gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x808, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT, MUX_MODE0)
 			/* (T8) gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT, MUX_MODE0)
 			/* (U8) gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x810, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT, MUX_MODE0)
 			/* (V8) gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x814, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT, MUX_MODE0)
 			/* (R9) gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x818, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT, MUX_MODE0)
 			/* (T9) gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT, MUX_MODE0)
 			/* (T17) gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x870, PIN_INPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT, MUX_MODE0)
 			/* (U17) gpmc_wpn.gpmc_wpn */
-			AM33XX_IOPAD(0x874, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_OUTPUT, MUX_MODE0)
 			/* (V6) gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)
 			/* (R7) gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)
 			/* (T7) gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)
 			/* (U6) gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)
 			/* (T6) gpmc_be0n_cle.gpmc_be0n_cle */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 };
-- 
2.20.1

