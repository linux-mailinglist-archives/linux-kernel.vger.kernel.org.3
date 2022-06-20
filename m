Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB755229D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiFTRLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFTRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:11:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C721DA6D;
        Mon, 20 Jun 2022 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655745096; x=1687281096;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wnnyudsj65rcrni2SbZ0KrjmSfPePVZLyNCgEZ2pjAk=;
  b=n2DXE4LbIVHumMShG0UW/Nt7UDXSB2O8fhsdUoNlXuk6KUm1h+3rk+5X
   /UaARoq5dhPkIi4GdghYtiBd67QwY95pVZt6JMMMwpx9wBsfoih0J1wS0
   KiTdmdjOmttG4NPujaxbapRJ1fr0rhqKpERLUksxNeKxe9YGk+l/RPV34
   IBXIaKBNBu/pIGyd4Y4XvSH/RrFavUN4Z8yNVFwQPJG+gvU7b5Oph76Ee
   BVFllzCvRL6BNuV7h1rc1YUxnreeX7g7FjdWdShMxWlGtCdWxYsdZ42sB
   3vEa6Xki0LDOjJJOsN13ln2MGOwvh64IQmJqvz984xLw29h+LKXSe/CUE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="259764424"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="259764424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 10:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="584743342"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2022 10:11:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A83BC14F; Mon, 20 Jun 2022 20:11:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] pinctrl: nomadik: Convert drivers to use struct pingroup and PINCTRL_PINGROUP()
Date:   Mon, 20 Jun 2022 20:11:36 +0300
Message-Id: <20220620171136.84648-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
Utilize them instead of open coded variants in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../pinctrl/nomadik/pinctrl-nomadik-db8500.c  | 295 +++++++++---------
 .../pinctrl/nomadik/pinctrl-nomadik-stn8815.c |  29 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |  11 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.h     |  16 +-
 4 files changed, 172 insertions(+), 179 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c b/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
index ac3d4d91266d..758d21f0a850 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
@@ -674,163 +674,160 @@ static const unsigned hwobs_oc4_1_pins[] = { DB8500_PIN_D17, DB8500_PIN_D16,
 	DB8500_PIN_D21, DB8500_PIN_D20,	DB8500_PIN_C20, DB8500_PIN_B21,
 	DB8500_PIN_C21, DB8500_PIN_A22, DB8500_PIN_B24, DB8500_PIN_C22 };
 
-#define DB8500_PIN_GROUP(a, b) { .name = #a, .pins = a##_pins,		\
-			.npins = ARRAY_SIZE(a##_pins), .altsetting = b }
-
 static const struct nmk_pingroup nmk_db8500_groups[] = {
 	/* Altfunction A column */
-	DB8500_PIN_GROUP(u0_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(u1rxtx_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(u1ctsrts_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(ipi2c_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(ipi2c_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp0txrx_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp0tfstck_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp0rfsrck_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc0_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc0_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc0_dat47_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc0dat31dir_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp1txrx_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp1_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcdb_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcdvsi0_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcdvsi1_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcd_d0_d7_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcd_d8_d11_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcd_d12_d15_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(lcd_d12_d23_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(kp_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(kpskaskb_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc2_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc2_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(ssp1_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(ssp0_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(i2c0_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(ipgpio0_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(ipgpio1_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(modem_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(kp_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp2sck_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(msp2_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc4_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc1_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc1_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(mc1dir_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(hsir_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(hsit_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(hsit_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(clkout1_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(clkout1_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(clkout2_a_1, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(clkout2_a_2, NMK_GPIO_ALT_A),
-	DB8500_PIN_GROUP(usb_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(u0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(u1rxtx_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(u1ctsrts_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(ipi2c_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(ipi2c_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp0txrx_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp0tfstck_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp0rfsrck_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc0_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc0_dat47_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc0dat31dir_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp1txrx_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcdb_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcdvsi0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcdvsi1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcd_d0_d7_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcd_d8_d11_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcd_d12_d15_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(lcd_d12_d23_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(kp_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(kpskaskb_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc2_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc2_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(ssp1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(ssp0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(i2c0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(ipgpio0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(ipgpio1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(modem_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(kp_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp2sck_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(msp2_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc4_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc1_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mc1dir_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(hsir_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(hsit_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(hsit_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(clkout1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(clkout1_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(clkout2_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(clkout2_a_2, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(usb_a_1, NMK_GPIO_ALT_A),
 	/* Altfunction B column */
-	DB8500_PIN_GROUP(trig_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(i2c4_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(i2c1_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(i2c2_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(i2c2_b_2, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(msp0txrx_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(i2c1_b_2, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(u2rxtx_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(uartmodtx_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(msp0sck_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(uartmodrx_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(stmmod_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(uartmodrx_b_2, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(spi3_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(msp1txrx_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(kp_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(kp_b_2, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(sm_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(smcs0_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(smcs1_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(ipgpio7_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(ipgpio2_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(ipgpio3_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(lcdaclk_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(lcda_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(lcd_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(lcd_d16_d23_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(ddrtrig_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(pwl_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(spi1_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(mc3_b_1, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(pwl_b_2, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(pwl_b_3, NMK_GPIO_ALT_B),
-	DB8500_PIN_GROUP(pwl_b_4, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(trig_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(i2c4_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(i2c1_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(i2c2_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(i2c2_b_2, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(msp0txrx_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(i2c1_b_2, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(u2rxtx_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(uartmodtx_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(msp0sck_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(uartmodrx_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(stmmod_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(uartmodrx_b_2, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(spi3_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(msp1txrx_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(kp_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(kp_b_2, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(sm_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(smcs0_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(smcs1_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(ipgpio7_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(ipgpio2_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(ipgpio3_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(lcdaclk_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(lcda_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(lcd_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(lcd_d16_d23_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(ddrtrig_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(pwl_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(spi1_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(mc3_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(pwl_b_2, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(pwl_b_3, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(pwl_b_4, NMK_GPIO_ALT_B),
 	/* Altfunction C column */
-	DB8500_PIN_GROUP(ipjtag_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio6_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio0_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio1_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio3_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio2_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(slim0_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ms_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(iptrigout_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(u2rxtx_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(u2ctsrts_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(u0_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio4_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio5_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio6_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio7_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(smcleale_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(stmape_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(u2rxtx_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio2_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio3_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio4_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(ipgpio5_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(mc5_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(mc2rstn_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(kp_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(smps0_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(smps1_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(u2rxtx_c_3, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(stmape_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(uartmodrx_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(uartmodtx_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(stmmod_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(usbsim_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(mc4rstn_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(clkout1_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(clkout2_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(i2c3_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(spi0_c_1, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(usbsim_c_2, NMK_GPIO_ALT_C),
-	DB8500_PIN_GROUP(i2c3_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipjtag_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio6_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio0_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio1_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio3_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio2_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(slim0_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ms_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(iptrigout_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(u2rxtx_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(u2ctsrts_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(u0_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio4_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio5_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio6_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio7_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(smcleale_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(stmape_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(u2rxtx_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio2_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio3_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio4_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(ipgpio5_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(mc5_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(mc2rstn_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(kp_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(smps0_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(smps1_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(u2rxtx_c_3, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(stmape_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(uartmodrx_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(uartmodtx_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(stmmod_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(usbsim_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(mc4rstn_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(clkout1_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(clkout2_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(i2c3_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(spi0_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(usbsim_c_2, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(i2c3_c_2, NMK_GPIO_ALT_C),
 	/* Other alt C1 column */
-	DB8500_PIN_GROUP(u2rx_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(stmape_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(remap0_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(remap1_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(ptma9_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(kp_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(rf_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(hxclk_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(uartmodrx_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(uartmodtx_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(stmmod_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(hxgpio_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(rf_oc1_2, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(spi2_oc1_1, NMK_GPIO_ALT_C1),
-	DB8500_PIN_GROUP(spi2_oc1_2, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(u2rx_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(stmape_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(remap0_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(remap1_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(ptma9_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(kp_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(rf_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(hxclk_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(uartmodrx_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(uartmodtx_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(stmmod_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(hxgpio_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(rf_oc1_2, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(spi2_oc1_1, NMK_GPIO_ALT_C1),
+	NMK_PIN_GROUP(spi2_oc1_2, NMK_GPIO_ALT_C1),
 	/* Other alt C2 column */
-	DB8500_PIN_GROUP(sbag_oc2_1, NMK_GPIO_ALT_C2),
-	DB8500_PIN_GROUP(etmr4_oc2_1, NMK_GPIO_ALT_C2),
-	DB8500_PIN_GROUP(ptma9_oc2_1, NMK_GPIO_ALT_C2),
+	NMK_PIN_GROUP(sbag_oc2_1, NMK_GPIO_ALT_C2),
+	NMK_PIN_GROUP(etmr4_oc2_1, NMK_GPIO_ALT_C2),
+	NMK_PIN_GROUP(ptma9_oc2_1, NMK_GPIO_ALT_C2),
 	/* Other alt C3 column */
-	DB8500_PIN_GROUP(stmmod_oc3_1, NMK_GPIO_ALT_C3),
-	DB8500_PIN_GROUP(stmmod_oc3_2, NMK_GPIO_ALT_C3),
-	DB8500_PIN_GROUP(uartmodrx_oc3_1, NMK_GPIO_ALT_C3),
-	DB8500_PIN_GROUP(uartmodtx_oc3_1, NMK_GPIO_ALT_C3),
-	DB8500_PIN_GROUP(etmr4_oc3_1, NMK_GPIO_ALT_C3),
+	NMK_PIN_GROUP(stmmod_oc3_1, NMK_GPIO_ALT_C3),
+	NMK_PIN_GROUP(stmmod_oc3_2, NMK_GPIO_ALT_C3),
+	NMK_PIN_GROUP(uartmodrx_oc3_1, NMK_GPIO_ALT_C3),
+	NMK_PIN_GROUP(uartmodtx_oc3_1, NMK_GPIO_ALT_C3),
+	NMK_PIN_GROUP(etmr4_oc3_1, NMK_GPIO_ALT_C3),
 	/* Other alt C4 column */
-	DB8500_PIN_GROUP(sbag_oc4_1, NMK_GPIO_ALT_C4),
-	DB8500_PIN_GROUP(hwobs_oc4_1, NMK_GPIO_ALT_C4),
+	NMK_PIN_GROUP(sbag_oc4_1, NMK_GPIO_ALT_C4),
+	NMK_PIN_GROUP(hwobs_oc4_1, NMK_GPIO_ALT_C4),
 };
 
 /* We use this macro to define the groups applicable to a function */
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
index 8d944bb3a036..c0d7c86d0939 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
@@ -303,23 +303,20 @@ static const unsigned usbhs_c_1_pins[] = { STN8815_PIN_E21, STN8815_PIN_E20,
 					   STN8815_PIN_C16, STN8815_PIN_A15,
 					   STN8815_PIN_D17, STN8815_PIN_C17 };
 
-#define STN8815_PIN_GROUP(a, b) { .name = #a, .pins = a##_pins,		\
-			.npins = ARRAY_SIZE(a##_pins), .altsetting = b }
-
 static const struct nmk_pingroup nmk_stn8815_groups[] = {
-	STN8815_PIN_GROUP(u0txrx_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(u0ctsrts_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(u0modem_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(mmcsd_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(mmcsd_b_1, NMK_GPIO_ALT_B),
-	STN8815_PIN_GROUP(u1_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(i2c1_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(i2c0_a_1, NMK_GPIO_ALT_A),
-	STN8815_PIN_GROUP(u1_b_1, NMK_GPIO_ALT_B),
-	STN8815_PIN_GROUP(i2cusb_b_1, NMK_GPIO_ALT_B),
-	STN8815_PIN_GROUP(clcd_16_23_b_1, NMK_GPIO_ALT_B),
-	STN8815_PIN_GROUP(usbfs_b_1, NMK_GPIO_ALT_B),
-	STN8815_PIN_GROUP(usbhs_c_1, NMK_GPIO_ALT_C),
+	NMK_PIN_GROUP(u0txrx_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(u0ctsrts_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(u0modem_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mmcsd_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(mmcsd_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(u1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(i2c1_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(i2c0_a_1, NMK_GPIO_ALT_A),
+	NMK_PIN_GROUP(u1_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(i2cusb_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(clcd_16_23_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(usbfs_b_1, NMK_GPIO_ALT_B),
+	NMK_PIN_GROUP(usbhs_c_1, NMK_GPIO_ALT_C),
 };
 
 /* We use this macro to define the groups applicable to a function */
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f5014d09d81a..ad3d1760b53b 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1179,17 +1179,17 @@ static const char *nmk_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
-	return npct->soc->groups[selector].name;
+	return npct->soc->groups[selector].grp.name;
 }
 
 static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
 			      const unsigned **pins,
-			      unsigned *num_pins)
+			      unsigned *npins)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = npct->soc->groups[selector].pins;
-	*num_pins = npct->soc->groups[selector].npins;
+	*pins = npct->soc->groups[selector].grp.pins;
+	*npins = npct->soc->groups[selector].grp.npins;
 	return 0;
 }
 
@@ -1526,8 +1526,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
 	int ret = -EINVAL;
 	int i;
 
-	g = &npct->soc->groups[group];
-
+	g = &npct->soc->groups[group].grp;
 	if (g->altsetting < 0)
 		return -EINVAL;
 
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.h b/drivers/pinctrl/nomadik/pinctrl-nomadik.h
index ae0bac06639f..820f07f4db32 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.h
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.h
@@ -105,21 +105,21 @@ struct nmk_function {
 
 /**
  * struct nmk_pingroup - describes a Nomadik pin group
- * @name: the name of this specific pin group
- * @pins: an array of discrete physical pins used in this group, taken
- *	from the driver-local pin enumeration space
- * @num_pins: the number of pins in this group array, i.e. the number of
- *	elements in .pins so we can iterate over that array
+ * @grp: Generic data of the pin group (name and pins)
  * @altsetting: the altsetting to apply to all pins in this group to
  *	configure them to be used by a function
  */
 struct nmk_pingroup {
-	const char *name;
-	const unsigned int *pins;
-	const unsigned npins;
+	struct pingroup grp;
 	int altsetting;
 };
 
+#define NMK_PIN_GROUP(a, b)							\
+	{									\
+		.grp = PINCTRL_PINGROUP(#a, a##_pins, ARRAY_SIZE(a##_pins)),	\
+		.altsetting = b,						\
+	}
+
 /**
  * struct nmk_pinctrl_soc_data - Nomadik pin controller per-SoC configuration
  * @pins:	An array describing all pins the pin controller affects.
-- 
2.35.1

