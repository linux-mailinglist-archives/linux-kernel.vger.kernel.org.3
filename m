Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B54E70A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358676AbiCYKJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358694AbiCYKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:09:01 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe09::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7CD0A8E;
        Fri, 25 Mar 2022 03:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcR5WzDYZTvFrngyDZhUhtMMFAHVSrO4x1UnujxfuPLqJ+tJ8Gxob9abpVK2a8m75MZ0E6UYXvvW/hdbLcNEA6050MQWHG3o4GUivBpDZx5hqEhZPMN5VBcyqt2lR2ZHQAWKfVjGAIfbcsc98NiDcdw3MnUmjDk+BF1a01TkyOEbQFlimHnt5ZCbZ2xW4dr0v7l7zd50a87Rz0vxuwG3pD82/fID6scIihJ7xbvmEcwSZypFiiEEv6uF7zbVVzex5aB/XPLFTl+5LYDWwh1x6hG3nXSqHiXZq5PlxzEY10UOwlz64oL9ysfPXECZVxarYcAzMhCJ1Hrva5iB7p675A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfZBffzK26D/piXj6luY0iiBVA2RPaub2PF/9gwd6m0=;
 b=K+x9k2Itfd/kRL32085Lk9hjhZO2d2B258jzoc2L6J1kn0NwWhIv6+lqCU8jMGGMnoxODdlYk+9Q9EFFpkaDsc9evkx3H2Y1LqSzcKi9jp/q32AUBgNm0h/5djCFtKRvp/bCdCNPrIhgFaF7Ekn6iY4neot6sSItnBXvY8TP6NnqtKPRHNU6/yVkocLgnBLBrNY30INqfp9IybsZfxXTkozNy8zvRqrWNPvZ1sOqKFGwIh4VeAIszI1uGJ980/CqlMtIsKl5a6cvdSOvWuyM6LcITHsWOV+nulB7KLx14VY0w3VgJtqTT16CrEEFYD/Gyl4sfWbGDbvD+jk3xlb1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfZBffzK26D/piXj6luY0iiBVA2RPaub2PF/9gwd6m0=;
 b=X4R5v6Dax6B+rInB/gz9oSkbU/tOb43fzUZlbfNpYJRdFAD9QvXlq9b/kZCrYEgFW18/ZYPmFm/4ENZtfK4YxTDIE6BdLYOkLKfXR6y8BUW5iL5O2GrOh711wqlFzDJr0ZeZWoGGEYNKPyZwZ+NNtX8KuqIeCvMr5hzSxJ4ATyg=
Received: from AS9PR06CA0122.eurprd06.prod.outlook.com (2603:10a6:20b:467::8)
 by AS4PR10MB5245.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 10:07:01 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::aa) by AS9PR06CA0122.outlook.office365.com
 (2603:10a6:20b:467::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19 via Frontend
 Transport; Fri, 25 Mar 2022 10:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:07:01 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:07:00 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:07:00 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:57 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 13/15] ARM: dts: am335x: Guardian: Update interface pinmux
Date:   Fri, 25 Mar 2022 10:06:11 +0000
Message-ID: <20220325100613.1494-14-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f21843dc-2c7f-4367-abda-08da0e473484
X-MS-TrafficTypeDiagnostic: AS4PR10MB5245:EE_
X-Microsoft-Antispam-PRVS: <AS4PR10MB52458E3FD131133F014CBC29A61A9@AS4PR10MB5245.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asmSsc3uqTK3tD9Ribafu8schBqerksR9qC8w9flTVAhfR+M87xvpTGCe0eNednY32VvqTptkF+0r9GDbHXTJvXA7o8NIeDR2xLdyFWV7RR6IeU6bj38M5qNv4U3mWaYax9twdkGoq2BRcQYGeZ+WMa7f8M7pdQeMlsw+enyJR5SLf4V4PnOGFFgaD3z0yXsPSTqo5nGKj0xZcfR2q11PznVZqD0rm92ASVXbPpOSn+IW9YfpgiTDlE9EEeUpbhGcKfRamz6hxJppYCjq2/96YAhty4QVHDukzSM8KTqGYIE8tnY6thKFUMBMX3Q0ejyecQrzq70SisW+MzC1QHr8q33twp8oPLILE+6HFZmYYANQCiCfLWhOB62faOueB7qnxgGwchvyHhZXE2+yV7eVPWexqGWHkRtlAUdPPouANtNUhPlVG5O+mHe5nHHQgrQmhFuFuG9glwE7Ediok7qH3o4wxL+Hc5wj3W6JoG+uH+eYfEqcBBt2QydgS9PUAm4tGa56mLbKdRaU40w5Tn/ZSQTOL2P4REchAU1JtEdljrIEtaDgtesDG6YB/4T8gqdz4YMssU3OHljdP9eDgRpZhzmACk++l41OJ4yxYxIUjNHZ9ECBZrRcRgn2FiP4kGK833pnudBVyonbMEkFv36S23/jbOgxfPxYmzq0jnegnhxSsOyXKCl77BjXVEW6ZjbJrFqTxSWhvIdnd34Gwt5ArEdLI6Vj6Nf/053PAKYPU4HU0Z6TpwLAX8/Bb57TDQZpfCMqMXzkG0mC8KjYJB4XQ==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(82310400004)(36860700001)(6666004)(81166007)(70206006)(8676002)(4326008)(70586007)(5660300002)(86362001)(40460700003)(1076003)(26005)(107886003)(8936002)(508600001)(2616005)(186003)(16526019)(2906002)(82960400001)(2876002)(356005)(110136005)(15650500001)(316002)(83380400001)(336012)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:07:01.1975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21843dc-2c7f-4367-abda-08da0e473484
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5245
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

* Update interface pinmux for
  - poweroff button
  - battery and coincell enable
  - ASP and Miraculix

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 44 ++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 93576f136368..b225210d5e11 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -64,6 +64,11 @@
 		};
 	};
 
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+	};
+
 	panel {
 		compatible = "ti,tilcdc,panel";
 		pinctrl-names = "default", "sleep";
@@ -401,14 +406,45 @@
 
 &am33xx_pinmux {
 	pinctrl-names = "default";
-	pinctrl-0 = <&clkout2_pin &gpio_pins>;
+	pinctrl-0 = <&clkout2_pin &guardian_interface_pins>;
 
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
+			/* xdma_event_intr1.clkout2 */
 			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
 		>;
 	};
 
+	guardian_interface_pins: pinmux_interface_pins {
+		pinctrl-single,pins = <
+			/* ADC_BATSENSE_EN */
+			/* (A14) MCASP0_AHCLKx.gpio3[21] */
+			AM33XX_IOPAD(0x9ac, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			/* ADC_COINCELL_EN */
+			/* (J16) MII1_TX_EN.gpio3[3] */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			/* ASP_ENABLE */
+			/* (A13) MCASP0_ACLKx.gpio3[14] */
+			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			/* (D16) uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE7)
+			/* (D15) uart1_txd.uart1_txd */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE7)
+			/*SWITCH-OFF_3V6*/
+			/* (M18) gpio0[1] */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			/* MIRACULIX */
+			/* (H17) gmii1_crs.gpio3[1] */
+			AM33XX_IOPAD(0x90c, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			/* (H18) rmii1_refclk.gpio0[29] */
+			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+			/* (J18) gmii1_txd3.gpio0[16] */
+			AM33XX_IOPAD(0x91c, PIN_INPUT           | MUX_MODE7 )
+			/* (J17) gmii1_rxdv.gpio3[4] */
+			AM33XX_IOPAD(0x918, PIN_OUTPUT_PULLDOWN | MUX_MODE7 )
+		>;
+	};
+
 	guardian_beeper_pins: pinmux_dmtimer7_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5) /* (E18) timer7 */
@@ -422,12 +458,6 @@
 		>;
 	};
 
-	gpio_pins: pinmux_gpio_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x928, PIN_OUTPUT | MUX_MODE7)
-			AM33XX_IOPAD(0x990, PIN_OUTPUT | MUX_MODE7)
-		>;
-	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-- 
2.20.1

