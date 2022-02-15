Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029F4B731A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiBOP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiBOP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:29:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC26BB560;
        Tue, 15 Feb 2022 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644938901; x=1676474901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqN5X2iLznt65YzLlooZYAUtte4i0cWwOvSYcPDxBq4=;
  b=PHcHMJqceK4cUex40tKQ0FlI9QZK6Cf5iNycrJ+bND1rCAVqRcuQqVJl
   +rLGNUZQYcMNqwPIIACvesI1onPD0GWdOgXIr/LtHPEjv1FyrBjIcGEtd
   OLAL+ME6pod1fbpVDNHwO3aiqtGFV/k0BdF+yURZHA30jc7m5ENWEw0gd
   2YeQvc/EQIjQqZ6FMpm3OMJuBjramM4Mj8fQdTijQ61LLTIdCHkYXmgbo
   bbEmKUSr5f7PEjSDwna6It/VHPPCGD9b6PIUboplwyD6/ewAiCbWjZ/Lw
   7Ne03bpPvl48cxr9IJXyd2Pt5pHDmHyuCEfDchrAEGkjf1GrNL9lzu1G5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250576906"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250576906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 07:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="624853745"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Feb 2022 07:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BC4451DD; Tue, 15 Feb 2022 17:28:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 4/4] pinctrl: icelake: Add Ice Lake-N PCH pin controller support
Date:   Tue, 15 Feb 2022 17:28:00 +0200
Message-Id: <20220215152800.21104-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
References: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pinctrl/GPIO support for Intel Ice Lake-N PCH. The Ice Lake-N
PCH GPIO is based on the same version of the Intel GPIO hardware than
Intel Cannon Lake with different set of pins and ACPI ID.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-icelake.c | 291 +++++++++++++++++++++++-
 1 file changed, 283 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
index 429b5a83acf0..27c248cc16f7 100644
--- a/drivers/pinctrl/intel/pinctrl-icelake.c
+++ b/drivers/pinctrl/intel/pinctrl-icelake.c
@@ -2,7 +2,7 @@
 /*
  * Intel Ice Lake PCH pinctrl/GPIO driver
  *
- * Copyright (C) 2018, Intel Corporation
+ * Copyright (C) 2018, 2022 Intel Corporation
  * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  *	    Mika Westerberg <mika.westerberg@linux.intel.com>
  */
@@ -19,7 +19,8 @@
 #define ICL_PADCFGLOCK	0x080
 #define ICL_HOSTSW_OWN	0x0b0
 #define ICL_GPI_IS	0x100
-#define ICL_GPI_IE	0x110
+#define ICL_LP_GPI_IE	0x110
+#define ICL_N_GPI_IE	0x120
 
 #define ICL_GPP(r, s, e, g)				\
 	{						\
@@ -29,20 +30,26 @@
 		.gpio_base = (g),			\
 	}
 
-#define ICL_COMMUNITY(b, s, e, g)			\
+#define ICL_COMMUNITY(b, s, e, ie, g)			\
 	{						\
 		.barno = (b),				\
 		.padown_offset = ICL_PAD_OWN,		\
 		.padcfglock_offset = ICL_PADCFGLOCK,	\
 		.hostown_offset = ICL_HOSTSW_OWN,	\
 		.is_offset = ICL_GPI_IS,		\
-		.ie_offset = ICL_GPI_IE,		\
+		.ie_offset = (ie),			\
 		.pin_base = (s),			\
 		.npins = ((e) - (s) + 1),		\
 		.gpps = (g),				\
 		.ngpps = ARRAY_SIZE(g),			\
 	}
 
+#define ICL_LP_COMMUNITY(b, s, e, g)			\
+	ICL_COMMUNITY(b, s, e, ICL_LP_GPI_IE, g)
+
+#define ICL_N_COMMUNITY(b, s, e, g)			\
+	ICL_COMMUNITY(b, s, e, ICL_N_GPI_IE, g)
+
 /* Ice Lake-LP */
 static const struct pinctrl_pin_desc icllp_pins[] = {
 	/* GPP_G */
@@ -329,10 +336,10 @@ static const struct intel_padgroup icllp_community5_gpps[] = {
 };
 
 static const struct intel_community icllp_communities[] = {
-	ICL_COMMUNITY(0, 0, 58, icllp_community0_gpps),
-	ICL_COMMUNITY(1, 59, 152, icllp_community1_gpps),
-	ICL_COMMUNITY(2, 153, 215, icllp_community4_gpps),
-	ICL_COMMUNITY(3, 216, 240, icllp_community5_gpps),
+	ICL_LP_COMMUNITY(0, 0, 58, icllp_community0_gpps),
+	ICL_LP_COMMUNITY(1, 59, 152, icllp_community1_gpps),
+	ICL_LP_COMMUNITY(2, 153, 215, icllp_community4_gpps),
+	ICL_LP_COMMUNITY(3, 216, 240, icllp_community5_gpps),
 };
 
 static const unsigned int icllp_spi0_pins[] = { 22, 23, 24, 25, 26 };
@@ -403,10 +410,278 @@ static const struct intel_pinctrl_soc_data icllp_soc_data = {
 	.ncommunities = ARRAY_SIZE(icllp_communities),
 };
 
+/* Ice Lake-N */
+static const struct pinctrl_pin_desc icln_pins[] = {
+	/* SPI */
+	PINCTRL_PIN(0, "SPI0_IO_2"),
+	PINCTRL_PIN(1, "SPI0_IO_3"),
+	PINCTRL_PIN(2, "SPI0_MOSI_IO_0"),
+	PINCTRL_PIN(3, "SPI0_MISO_IO_1"),
+	PINCTRL_PIN(4, "SPI0_TPM_CSB"),
+	PINCTRL_PIN(5, "SPI0_FLASH_0_CSB"),
+	PINCTRL_PIN(6, "SPI0_FLASH_1_CSB"),
+	PINCTRL_PIN(7, "SPI0_CLK"),
+	PINCTRL_PIN(8, "SPI0_CLK_LOOPBK"),
+	/* GPP_B */
+	PINCTRL_PIN(9, "CORE_VID_0"),
+	PINCTRL_PIN(10, "CORE_VID_1"),
+	PINCTRL_PIN(11, "VRALERTB"),
+	PINCTRL_PIN(12, "CPU_GP_2"),
+	PINCTRL_PIN(13, "CPU_GP_3"),
+	PINCTRL_PIN(14, "SRCCLKREQB_0"),
+	PINCTRL_PIN(15, "SRCCLKREQB_1"),
+	PINCTRL_PIN(16, "SRCCLKREQB_2"),
+	PINCTRL_PIN(17, "SRCCLKREQB_3"),
+	PINCTRL_PIN(18, "SRCCLKREQB_4"),
+	PINCTRL_PIN(19, "SRCCLKREQB_5"),
+	PINCTRL_PIN(20, "EXT_PWR_GATEB"),
+	PINCTRL_PIN(21, "SLP_S0B"),
+	PINCTRL_PIN(22, "PLTRSTB"),
+	PINCTRL_PIN(23, "SPKR_GSPI0_CS1B"),
+	PINCTRL_PIN(24, "GSPI0_CS0B"),
+	PINCTRL_PIN(25, "GSPI0_CLK"),
+	PINCTRL_PIN(26, "GSPI0_MISO_TBT_LSX3_A"),
+	PINCTRL_PIN(27, "GSPI0_MOSI_TBT_LSX3_B"),
+	PINCTRL_PIN(28, "GSPI1_CS0B"),
+	PINCTRL_PIN(29, "GSPI1_CLK_NFC_CLK"),
+	PINCTRL_PIN(30, "GSPI1_MISO_NFC_CLKREQ"),
+	PINCTRL_PIN(31, "GSPI1_MOSI"),
+	PINCTRL_PIN(32, "GSPI1_CS1B"),
+	PINCTRL_PIN(33, "GSPI0_CLK_LOOPBK"),
+	PINCTRL_PIN(34, "GSPI1_CLK_LOOPBK"),
+	/* GPP_A */
+	PINCTRL_PIN(35, "ESPI_IO_0"),
+	PINCTRL_PIN(36, "ESPI_IO_1"),
+	PINCTRL_PIN(37, "ESPI_IO_2"),
+	PINCTRL_PIN(38, "ESPI_IO_3"),
+	PINCTRL_PIN(39, "ESPI_CSB"),
+	PINCTRL_PIN(40, "ESPI_CLK"),
+	PINCTRL_PIN(41, "ESPI_RESETB"),
+	PINCTRL_PIN(42, "SMBCLK"),
+	PINCTRL_PIN(43, "SMBDATA"),
+	PINCTRL_PIN(44, "SMBALERTB"),
+	PINCTRL_PIN(45, "CPU_GP_0"),
+	PINCTRL_PIN(46, "CPU_GP_1"),
+	PINCTRL_PIN(47, "USB2_OCB_1"),
+	PINCTRL_PIN(48, "USB2_OCB_2"),
+	PINCTRL_PIN(49, "USB2_OCB_3"),
+	PINCTRL_PIN(50, "DDSP_HPD_A_TIME_SYNC_0"),
+	PINCTRL_PIN(51, "DDSP_HPD_B_TIME_SYNC_1"),
+	PINCTRL_PIN(52, "DDSP_HPD_C"),
+	PINCTRL_PIN(53, "USB2_OCB_0"),
+	PINCTRL_PIN(54, "PCHHOTB"),
+	PINCTRL_PIN(55, "ESPI_CLK_LOOPBK"),
+	/* GPP_S */
+	PINCTRL_PIN(56, "SNDW1_CLK"),
+	PINCTRL_PIN(57, "SNDW1_DATA"),
+	PINCTRL_PIN(58, "SNDW2_CLK"),
+	PINCTRL_PIN(59, "SNDW2_DATA"),
+	PINCTRL_PIN(60, "SNDW3_CLK_DMIC_CLK_1"),
+	PINCTRL_PIN(61, "SNDW3_DATA_DMIC_DATA_1"),
+	PINCTRL_PIN(62, "SNDW4_CLK_DMIC_CLK_0"),
+	PINCTRL_PIN(63, "SNDW4_DATA_DMIC_DATA_0"),
+	/* GPP_R */
+	PINCTRL_PIN(64, "HDA_BCLK"),
+	PINCTRL_PIN(65, "HDA_SYNC"),
+	PINCTRL_PIN(66, "HDA_SDO"),
+	PINCTRL_PIN(67, "HDA_SDI_0"),
+	PINCTRL_PIN(68, "HDA_RSTB"),
+	PINCTRL_PIN(69, "HDA_SDI_1_I2S1_RXD"),
+	PINCTRL_PIN(70, "I2S1_SFRM"),
+	PINCTRL_PIN(71, "I2S1_TXD"),
+	/* GPP_H */
+	PINCTRL_PIN(72, "GPPC_H_0"),
+	PINCTRL_PIN(73, "CNV_RF_RESET_B"),
+	PINCTRL_PIN(74, "MODEM_CLKREQ"),
+	PINCTRL_PIN(75, "SX_EXIT_HOLDOFFB"),
+	PINCTRL_PIN(76, "I2C2_SDA"),
+	PINCTRL_PIN(77, "I2C2_SCL"),
+	PINCTRL_PIN(78, "I2C3_SDA"),
+	PINCTRL_PIN(79, "I2C3_SCL"),
+	PINCTRL_PIN(80, "I2C4_SDA"),
+	PINCTRL_PIN(81, "I2C4_SCL"),
+	PINCTRL_PIN(82, "CPU_VCCIO_PWR_GATEB"),
+	PINCTRL_PIN(83, "I2S2_SCLK"),
+	PINCTRL_PIN(84, "CNV_RF_RESET_B"),
+	PINCTRL_PIN(85, "MODEM_CLKREQ"),
+	PINCTRL_PIN(86, "I2S2_RXD"),
+	PINCTRL_PIN(87, "I2S1_SCLK"),
+	PINCTRL_PIN(88, "GPPC_H_16"),
+	PINCTRL_PIN(89, "GPPC_H_17"),
+	PINCTRL_PIN(90, "GPPC_H_18"),
+	PINCTRL_PIN(91, "GPPC_H_19"),
+	PINCTRL_PIN(92, "GPPC_H_20"),
+	PINCTRL_PIN(93, "GPPC_H_21"),
+	PINCTRL_PIN(94, "GPPC_H_22"),
+	PINCTRL_PIN(95, "GPPC_H_23"),
+	/* GPP_D */
+	PINCTRL_PIN(96, "SPI1_CSB_BK_0_SBK_0"),
+	PINCTRL_PIN(97, "SPI1_CLK_BK_1_SBK_1"),
+	PINCTRL_PIN(98, "SPI1_MISO_IO_1_BK_2_SBK_2"),
+	PINCTRL_PIN(99, "SPI1_MOSI_IO_0_BK_3_SBK_3"),
+	PINCTRL_PIN(100, "ISH_I2C0_SDA"),
+	PINCTRL_PIN(101, "ISH_I2C0_SCL"),
+	PINCTRL_PIN(102, "ISH_I2C1_SDA"),
+	PINCTRL_PIN(103, "ISH_I2C1_SCL"),
+	PINCTRL_PIN(104, "ISH_SPI_CSB_GSPI2_CS0B_TBT_LSX4_A"),
+	PINCTRL_PIN(105, "ISH_SPI_CLK_GSPI2_CLK_TBT_LSX4_B"),
+	PINCTRL_PIN(106, "ISH_SPI_MISO_GSPI2_MISO_TBT_LSX5_A"),
+	PINCTRL_PIN(107, "ISH_SPI_MOSI_GSPI2_MOSI_TBT_LSX5_B"),
+	PINCTRL_PIN(108, "ISH_UART0_RXD_I2C4B_SDA"),
+	PINCTRL_PIN(109, "ISH_UART0_TXD_I2C4B_SCL"),
+	PINCTRL_PIN(110, "ISH_UART0_RTSB_GSPI2_CS1B"),
+	PINCTRL_PIN(111, "ISH_UART0_CTSB_CNV_WCEN"),
+	PINCTRL_PIN(112, "SPI1_IO_2"),
+	PINCTRL_PIN(113, "SPI1_IO_3"),
+	PINCTRL_PIN(114, "I2S_MCLK"),
+	PINCTRL_PIN(115, "CNV_MFUART2_RXD"),
+	PINCTRL_PIN(116, "CNV_MFUART2_TXD"),
+	PINCTRL_PIN(117, "CNV_PA_BLANKING"),
+	PINCTRL_PIN(118, "I2C5_SDA_ISH_I2C2_SDA"),
+	PINCTRL_PIN(119, "I2C5_SCL_ISH_I2C2_SCL"),
+	PINCTRL_PIN(120, "GSPI2_CLK_LOOPBK"),
+	PINCTRL_PIN(121, "SPI1_CLK_LOOPBK"),
+	/* vGPIO */
+	PINCTRL_PIN(122, "CNV_BTEN"),
+	PINCTRL_PIN(123, "CNV_WCEN"),
+	PINCTRL_PIN(124, "CNV_BT_HOST_WAKEB"),
+	PINCTRL_PIN(125, "CNV_BT_IF_SELECT"),
+	PINCTRL_PIN(126, "vCNV_BT_UART_TXD"),
+	PINCTRL_PIN(127, "vCNV_BT_UART_RXD"),
+	PINCTRL_PIN(128, "vCNV_BT_UART_CTS_B"),
+	PINCTRL_PIN(129, "vCNV_BT_UART_RTS_B"),
+	PINCTRL_PIN(130, "vCNV_MFUART1_TXD"),
+	PINCTRL_PIN(131, "vCNV_MFUART1_RXD"),
+	PINCTRL_PIN(132, "vCNV_MFUART1_CTS_B"),
+	PINCTRL_PIN(133, "vCNV_MFUART1_RTS_B"),
+	PINCTRL_PIN(134, "vUART0_TXD"),
+	PINCTRL_PIN(135, "vUART0_RXD"),
+	PINCTRL_PIN(136, "vUART0_CTS_B"),
+	PINCTRL_PIN(137, "vUART0_RTS_B"),
+	PINCTRL_PIN(138, "vISH_UART0_TXD"),
+	PINCTRL_PIN(139, "vISH_UART0_RXD"),
+	PINCTRL_PIN(140, "vISH_UART0_CTS_B"),
+	PINCTRL_PIN(141, "vISH_UART0_RTS_B"),
+	PINCTRL_PIN(142, "vCNV_BT_I2S_BCLK"),
+	PINCTRL_PIN(143, "vCNV_BT_I2S_WS_SYNC"),
+	PINCTRL_PIN(144, "vCNV_BT_I2S_SDO"),
+	PINCTRL_PIN(145, "vCNV_BT_I2S_SDI"),
+	PINCTRL_PIN(146, "vI2S2_SCLK"),
+	PINCTRL_PIN(147, "vI2S2_SFRM"),
+	PINCTRL_PIN(148, "vI2S2_TXD"),
+	PINCTRL_PIN(149, "vI2S2_RXD"),
+	PINCTRL_PIN(150, "vSD3_CD_B"),
+	/* GPP_C */
+	PINCTRL_PIN(151, "GPPC_C_0"),
+	PINCTRL_PIN(152, "GPPC_C_1"),
+	PINCTRL_PIN(153, "GPPC_C_2"),
+	PINCTRL_PIN(154, "GPPC_C_3"),
+	PINCTRL_PIN(155, "GPPC_C_4"),
+	PINCTRL_PIN(156, "GPPC_C_5"),
+	PINCTRL_PIN(157, "SUSWARNB_SUSPWRDNACK"),
+	PINCTRL_PIN(158, "SUSACKB"),
+	PINCTRL_PIN(159, "UART0_RXD"),
+	PINCTRL_PIN(160, "UART0_TXD"),
+	PINCTRL_PIN(161, "UART0_RTSB"),
+	PINCTRL_PIN(162, "UART0_CTSB"),
+	PINCTRL_PIN(163, "UART1_RXD_ISH_UART1_RXD"),
+	PINCTRL_PIN(164, "UART1_TXD_ISH_UART1_TXD"),
+	PINCTRL_PIN(165, "UART1_RTSB_ISH_UART1_RTSB"),
+	PINCTRL_PIN(166, "UART1_CTSB_ISH_UART1_CTSB"),
+	PINCTRL_PIN(167, "I2C0_SDA"),
+	PINCTRL_PIN(168, "I2C0_SCL"),
+	PINCTRL_PIN(169, "I2C1_SDA"),
+	PINCTRL_PIN(170, "I2C1_SCL"),
+	PINCTRL_PIN(171, "UART2_RXD_CNV_MFUART0_RXD"),
+	PINCTRL_PIN(172, "UART2_TXD_CNV_MFUART0_TXD"),
+	PINCTRL_PIN(173, "UART2_RTSB_CNV_MFUART0_RTS_B"),
+	PINCTRL_PIN(174, "UART2_CTSB_CNV_MFUART0_CTS_B"),
+	/* HVCMOS */
+	PINCTRL_PIN(175, "L_BKLTEN"),
+	PINCTRL_PIN(176, "L_BKLTCTL"),
+	PINCTRL_PIN(177, "L_VDDEN"),
+	PINCTRL_PIN(178, "SYS_PWROK"),
+	PINCTRL_PIN(179, "SYS_RESETB"),
+	PINCTRL_PIN(180, "MLK_RSTB"),
+	/* GPP_E */
+	PINCTRL_PIN(181, "ISH_GP_0_IMGCLKOUT_0"),
+	PINCTRL_PIN(182, "ISH_GP_1"),
+	PINCTRL_PIN(183, "IMGCLKOUT_1"),
+	PINCTRL_PIN(184, "ISH_GP_2_SATA_DEVSLP_0"),
+	PINCTRL_PIN(185, "IMGCLKOUT_2"),
+	PINCTRL_PIN(186, "SATA_LEDB_SPI1_CS1B"),
+	PINCTRL_PIN(187, "IMGCLKOUT_3"),
+	PINCTRL_PIN(188, "ISH_GP_3_SATA_DEVSLP_1"),
+	PINCTRL_PIN(189, "FIVR_DIGPB_0"),
+	PINCTRL_PIN(190, "SML0CLK"),
+	PINCTRL_PIN(191, "SML0DATA"),
+	PINCTRL_PIN(192, "BSSB_LS3_RX"),
+	PINCTRL_PIN(193, "BSSB_LS3_TX"),
+	PINCTRL_PIN(194, "BSSB_LS0_RX"),
+	PINCTRL_PIN(195, "BSSB_LS0_TX"),
+	PINCTRL_PIN(196, "BSSB_LS1_RX"),
+	PINCTRL_PIN(197, "BSSB_LS1_TX"),
+	PINCTRL_PIN(198, "BSSB_LS2_RX"),
+	PINCTRL_PIN(199, "BSSB_LS2_TX"),
+	PINCTRL_PIN(200, "FIVR_DIGPB_1"),
+	PINCTRL_PIN(201, "CNV_BRI_DT"),
+	PINCTRL_PIN(202, "CNV_BRI_RSP"),
+	PINCTRL_PIN(203, "CNV_RGI_DT"),
+	PINCTRL_PIN(204, "CNV_RGI_RSP"),
+	/* GPP_G */
+	PINCTRL_PIN(205, "SD3_CMD"),
+	PINCTRL_PIN(206, "SD3_D0"),
+	PINCTRL_PIN(207, "SD3_D1"),
+	PINCTRL_PIN(208, "SD3_D2"),
+	PINCTRL_PIN(209, "SD3_D3"),
+	PINCTRL_PIN(210, "SD3_CDB"),
+	PINCTRL_PIN(211, "SD3_CLK"),
+	PINCTRL_PIN(212, "SD3_WP"),
+};
+
+static const struct intel_padgroup icln_community0_gpps[] = {
+	ICL_GPP(0, 0, 8, INTEL_GPIO_BASE_NOMAP),	/* SPI */
+	ICL_GPP(1, 9, 34, 32),				/* GPP_B */
+	ICL_GPP(2, 35, 55, 64),				/* GPP_A */
+	ICL_GPP(3, 56, 63, 96),				/* GPP_S */
+	ICL_GPP(4, 64, 71, 128),			/* GPP_R */
+};
+
+static const struct intel_padgroup icln_community1_gpps[] = {
+	ICL_GPP(0, 72, 95, 160),			/* GPP_H */
+	ICL_GPP(1, 96, 121, 192),			/* GPP_D */
+	ICL_GPP(2, 122, 150, 224),			/* vGPIO */
+	ICL_GPP(3, 151, 174, 256),			/* GPP_C */
+};
+
+static const struct intel_padgroup icln_community4_gpps[] = {
+	ICL_GPP(0, 175, 180, INTEL_GPIO_BASE_NOMAP),	/* HVCMOS */
+	ICL_GPP(1, 181, 204, 288),			/* GPP_E */
+};
+
+static const struct intel_padgroup icln_community5_gpps[] = {
+	ICL_GPP(0, 205, 212, INTEL_GPIO_BASE_ZERO),	/* GPP_G */
+};
+
+static const struct intel_community icln_communities[] = {
+	ICL_N_COMMUNITY(0, 0, 71, icln_community0_gpps),
+	ICL_N_COMMUNITY(1, 72, 174, icln_community1_gpps),
+	ICL_N_COMMUNITY(2, 175, 204, icln_community4_gpps),
+	ICL_N_COMMUNITY(3, 205, 212, icln_community5_gpps),
+};
+
+static const struct intel_pinctrl_soc_data icln_soc_data = {
+	.pins = icln_pins,
+	.npins = ARRAY_SIZE(icln_pins),
+	.communities = icln_communities,
+	.ncommunities = ARRAY_SIZE(icln_communities),
+};
+
 static INTEL_PINCTRL_PM_OPS(icl_pinctrl_pm_ops);
 
 static const struct acpi_device_id icl_pinctrl_acpi_match[] = {
 	{ "INT3455", (kernel_ulong_t)&icllp_soc_data },
+	{ "INT34C3", (kernel_ulong_t)&icln_soc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, icl_pinctrl_acpi_match);
-- 
2.34.1

