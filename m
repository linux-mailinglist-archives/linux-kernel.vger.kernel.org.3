Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F070F4E7090
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357828AbiCYKJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358714AbiCYKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:09:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76866D0AA7;
        Fri, 25 Mar 2022 03:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPhhjkHW9u89X/hpbQKIZKPxAOGR9PLbmHuazlAahg8NKzxPPAoOLlq7wjl4DZDOegZkLH/XccjKpgma63X/mqNa1EBZSRg7nwru+qejhgjoU68YljRfUP6A9mYQfjqQdsRPLFhcxjv2LhWT8wsz4WOqI/cujgsKeXpUmgxEafdfBDKmktTi1JH/3NOJvnJLzL/18a1ySlLVg1RnpDCfrwchVvr8e6iLy0rpLFbyWh8p2svP5O6omXIUxwRkiAZKzajzZWFV3TMqmcY3i8g6OYVpWuEnBls2YhwmHY6QCId+6Q0OAtOYShVC3kHYouF/2kfd5wTLoI7/xkal1sY6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HdY9LKxv1qDEYwd6t9TdtGe3VbROnKxWygh7r8u9sQ=;
 b=DJWAmy8aFyIgwM1LvnhK12Zy/9Q71+tTNYI8yL2UBBDKHin6QYoGR+yrwIsXFBNCobTJ1LTI5JpCZu3yjRl6nM4oqjmG071C9Pq/JN7jXOEkrzJdaieayCBZWbdHkyBV8iSGwO2rd2h4IpoXBnuLnRUr5T0Qb+35i1bDixhlor40FIUk+paEvZWnSzNUE4rht+0XaEZx6VpTA6eIWGyBWvnaDDtT3tQF2cN+kenoWz7W7P3WsAbslR3FBA4bm4ocDWTAy/ALxcK4K0IHsyzzXRNYy+/3To7l+Qe1/eiFNTBPnA94FQgke9CVbCqj+ngDve63kJ6jWceKlpkMeLEcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HdY9LKxv1qDEYwd6t9TdtGe3VbROnKxWygh7r8u9sQ=;
 b=F+M7loNeqm2QXcg6fNPdKQQ16brEhFPyjG8V/joBRYr9PbiBnQLjSoUl1DxduM8psgRLGXE3xxDaYmFTaRQaDPR902UEBnZh1LX/+yZhxAxMFH7LxkzAojFrbsxqjgi1t6o6rhZljs7Qy+l4vas1+CN+DRPJERtgsyVk/qQLF78=
Received: from AS9PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:20b:462::15)
 by DB7PR10MB2329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 10:07:05 +0000
Received: from VE1EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::41) by AS9PR06CA0027.outlook.office365.com
 (2603:10a6:20b:462::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Fri, 25 Mar 2022 10:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT023.mail.protection.outlook.com (10.152.18.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:07:05 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:07:04 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:07:04 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:07:01 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 15/15] ARM: dts: am335x: Guardian: Update comments
Date:   Fri, 25 Mar 2022 10:06:13 +0000
Message-ID: <20220325100613.1494-16-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fefaa06-ff7b-4bd6-96a2-08da0e473702
X-MS-TrafficTypeDiagnostic: DB7PR10MB2329:EE_
X-Microsoft-Antispam-PRVS: <DB7PR10MB23293A6751A1B2DAC6927BBAA61A9@DB7PR10MB2329.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32WeyDASrA3qXp86dN9ePa4zU8754fhO0N+8ekFNgB0NQRVFhHX5Qiq1VofBq1paSlHYPYbcJ/EL6s+Ys+0qbktz/4n8GLyKI/pH4aTY23Hib0o8F7rro8WSqV7I39yw/m+7402SwFXsBkm5WGaglvrVj11BM1Uxkpr6/XFiw8ObCzyR8mp/d8LN/O84QLF7h3TGUMml1zeLF0LPXNS4z4MUJyh7ib2IyS3OrrI8Dfk+CHhiij+fEmuys9UobJAehtIGUMPD7m/8IaCgmySC5DgWDMY9/Hc7PBLUyMxc1AtG7oScxRpY9DRARn+sNQBA1WJige8TjSiKaVoaBBTTdDEk/UGjxO7StxgoWImHP9i1Bk6W+/MaTbhswcGjXk8ApCGAPEc1wPAiy8KcXCc3DPb7TmLbM1H3KBNIkfe58VjgVJEKbuu0l4YFo1bnKp0ucAZmhWKV/e5m0UotJwfxh9Z+i2mxQK579/6D+oAFrQnitfv94o/OQMy7CQWmVfoWKSPULvLjmgrcJ3PzrCzGhMXpdK/BThyujXgR+liJ0Gxw5yERS6Afge83rK0xLqpWCvoBXKjIUv5675amOqs9df0ubR7PuaZgqwSupjRwCQS2M1/4eSEIMC31Q+pJgU8I+HTxeeJDklolVYNckZ2+QTB/065LkjyIpVAOeuVyJqEI4CuaRaosxXo9ncBg37bPZ+STnK4o8x1S5SS52lVw0Q==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2876002)(2906002)(1076003)(186003)(8676002)(107886003)(5660300002)(16526019)(356005)(336012)(8936002)(82310400004)(4326008)(47076005)(2616005)(40460700003)(6666004)(70586007)(70206006)(83380400001)(26005)(81166007)(82960400001)(54906003)(86362001)(316002)(36860700001)(110136005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:07:05.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fefaa06-ff7b-4bd6-96a2-08da0e473702
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2329
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

* Add comment to improve readability

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index cc56b4510930..1a7e187b1953 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -535,8 +535,8 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c0_scl.i2c0_scl */
 		>;
 	};
 
@@ -668,28 +668,34 @@
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)         /* GPIO0_6 */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
+			/* SPI0_CLK  - spi0_clk.spi */
 			AM33XX_IOPAD(0x950, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			/* SPI0_MOSI - spi0_d0.spi0 */
 			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			/* SPI0_MISO - spi0_d1.spi0 */
 			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* SPI0_CS0 - spi */
 			AM33XX_IOPAD(0x95c, PIN_OUTPUT_PULLUP | MUX_MODE0)
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
+			/* uart0_rxd.uart0_rxd */
 			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart0_txd.uart0_txd */
 			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
 		>;
 	};
-- 
2.20.1

