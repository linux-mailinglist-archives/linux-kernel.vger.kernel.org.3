Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F13A49BCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiAYUV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:21:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:16186 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbiAYUVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643142080; x=1674678080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5bzSfljY1YSz8887v/yq7xlM6sikYIoDRsSS5+W86wQ=;
  b=PwurqGaDbIUN6c3pVDM4Tpx0bSEGFG41pElQeFEs70aQwxdlcL/cXtjl
   YbmIWuksrBakBWKelrxxeSrTejIqPg6e7MoBKuJJ8AqxF2GCCUG7cqZ4h
   RAZYFGX1KbYKqAqMv4qzTii03L7n/FB8mbEytEfMVL68VQVCKmLW/q3Zk
   lgoXvhAjNZF5Ew0hOyB4p9s4Dsx1WMkZ6die+h8pVqRw0dIpqfD3opXkz
   mpeHaD9vDmvLieASYMsLtM2K3Nk1nn6cOTb+7Z2KHwq1VBrv+JT0/6rt5
   OHnBCcmtv/1co7YHlTEeUEoKIh98Qhtx0rfnvVWHQ2FokX3E4Y9nLBefD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246353990"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246353990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 12:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="624600071"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2022 12:21:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83E2F287; Tue, 25 Jan 2022 22:21:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/4] fbtft: Replace 'depends on FB_TFT' by 'if FB_TFT ... endif'
Date:   Tue, 25 Jan 2022 22:21:17 +0200
Message-Id: <20220125202118.63362-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'depends on FB_TFT' by 'if FB_TFT ... endif'
for the sake of deduplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbtft/Kconfig | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/video/fbtft/Kconfig b/drivers/video/fbtft/Kconfig
index 4d29e8c1014e..14ea3c6a60da 100644
--- a/drivers/video/fbtft/Kconfig
+++ b/drivers/video/fbtft/Kconfig
@@ -10,87 +10,75 @@ menuconfig FB_TFT
 	select FB_DEFERRED_IO
 	select FB_BACKLIGHT
 
+if FB_TFT
+
 config FB_TFT_AGM1264K_FL
 	tristate "FB driver for the AGM1264K-FL LCD display"
-	depends on FB_TFT
 	help
 	  Framebuffer support for the AGM1264K-FL LCD display (two Samsung KS0108 compatible chips)
 
 config FB_TFT_BD663474
 	tristate "FB driver for the BD663474 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for BD663474
 
 config FB_TFT_HX8340BN
 	tristate "FB driver for the HX8340BN LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for HX8340BN
 
 config FB_TFT_HX8347D
 	tristate "FB driver for the HX8347D LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for HX8347D
 
 config FB_TFT_HX8353D
 	tristate "FB driver for the HX8353D LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for HX8353D
 
 config FB_TFT_HX8357D
 	tristate "FB driver for the HX8357D LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for HX8357D
 
 config FB_TFT_ILI9163
 	tristate "FB driver for the ILI9163 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9163
 
 config FB_TFT_ILI9320
 	tristate "FB driver for the ILI9320 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9320
 
 config FB_TFT_ILI9325
 	tristate "FB driver for the ILI9325 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9325
 
 config FB_TFT_ILI9340
 	tristate "FB driver for the ILI9340 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9340
 
 config FB_TFT_ILI9341
 	tristate "FB driver for the ILI9341 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9341
 
 config FB_TFT_ILI9481
 	tristate "FB driver for the ILI9481 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9481
 
 config FB_TFT_ILI9486
 	tristate "FB driver for the ILI9486 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ILI9486
 
 config FB_TFT_PCD8544
 	tristate "FB driver for the PCD8544 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for PCD8544
 
@@ -108,62 +96,52 @@ config FB_TFT_S6D02A1
 
 config FB_TFT_S6D1121
 	tristate "FB driver for the S6D1211 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for S6D1121
 
 config FB_TFT_SEPS525
 	tristate "FB driver for the SEPS525 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for SEPS525
 	  Say Y if you have such a display that utilizes this controller.
 
 config FB_TFT_SH1106
 	tristate "FB driver for the SH1106 OLED Controller"
-	depends on FB_TFT
 	help
 	  Framebuffer support for SH1106
 
 config FB_TFT_SSD1289
 	tristate "FB driver for the SSD1289 LCD Controller"
-	depends on FB_TFT
 	help
 	  Framebuffer support for SSD1289
 
 config FB_TFT_SSD1305
 	tristate "FB driver for the SSD1305 OLED Controller"
-	depends on FB_TFT
 	help
 	  Framebuffer support for SSD1305
 
 config FB_TFT_SSD1306
 	tristate "FB driver for the SSD1306 OLED Controller"
-	depends on FB_TFT
 	help
 	  Framebuffer support for SSD1306
 
 config FB_TFT_SSD1331
 	tristate "FB driver for the SSD1331 LCD Controller"
-	depends on FB_TFT
 	help
 	  Framebuffer support for SSD1331
 
 config FB_TFT_SSD1351
 	tristate "FB driver for the SSD1351 LCD Controller"
-	depends on FB_TFT
 	help
 	  Framebuffer support for SSD1351
 
 config FB_TFT_ST7735R
 	tristate "FB driver for the ST7735R LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for ST7735R
 
 config FB_TFT_ST7789V
 	tristate "FB driver for the ST7789V LCD Controller"
-	depends on FB_TFT
 	help
 	  This enables generic framebuffer support for the Sitronix ST7789V
 	  display controller. The controller is intended for small color
@@ -173,30 +151,27 @@ config FB_TFT_ST7789V
 
 config FB_TFT_TINYLCD
 	tristate "FB driver for tinylcd.com display"
-	depends on FB_TFT
 	help
 	  Custom Framebuffer support for tinylcd.com display
 
 config FB_TFT_TLS8204
 	tristate "FB driver for the TLS8204 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for TLS8204
 
 config FB_TFT_UC1611
 	tristate "FB driver for the UC1611 LCD controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for UC1611
 
 config FB_TFT_UC1701
 	tristate "FB driver for the UC1701 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for UC1701
 
 config FB_TFT_UPD161704
 	tristate "FB driver for the uPD161704 LCD Controller"
-	depends on FB_TFT
 	help
 	  Generic Framebuffer support for uPD161704
+
+endif
-- 
2.34.1

