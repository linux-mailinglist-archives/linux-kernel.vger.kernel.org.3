Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F84CF3FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiCGIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiCGIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:51:57 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C80711C13;
        Mon,  7 Mar 2022 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646643063;
  x=1678179063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytKQtShjwa35NIFSZwwjBXyX3q9doQnHdIn7CTmZOnE=;
  b=itMBBlJLc5ATqGMPf2RjsNgsvdlgfKitS22SB/CD7/cylMt0By0ZSrd+
   ZYhmJZ9QDs2ncC1DuIiLw0xLLKK8XA1XoRyKwRTTVR1rfwzf5UykJxJBd
   qeDEVhUmyRT0l3ws8oQpuA9MmsmMp55RUnkHGfxd6Korf+AN3zU/Hixls
   ILZRiJiP9yJ79ebacAgtdu44bxTcdZcsd+FqaAEhiXSHEmfFEThCEUHzG
   5qjyGO/W+x1BQRvHTdTnY6Z8ENfIS5sWy2PeK0zxAH39bEfQeeG+IyCtA
   2DC1NL8JuCmZQ42vHidHNJwQ2YY9of9yI7U7CnUXQ4N9eU/4Es4oOm+88
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <krzysztof.kozlowski@canonical.com>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <alim.akhtar@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] tty: serial: samsung: Add ARTPEC-8 support
Date:   Mon, 7 Mar 2022 09:50:53 +0100
Message-ID: <20220307085053.1636475-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
References: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the UART on the ARTPEC-8 SoC.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/tty/serial/Kconfig       |  2 +-
 drivers/tty/serial/samsung_tty.c | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..ae120d3d933a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -237,7 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || ARCH_ARTPEC || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..4f9e74c6bcef 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2837,6 +2837,36 @@ static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 #define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif
 
+#if defined(CONFIG_ARCH_ARTPEC)
+static struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Axis ARTPEC-8 UART",
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
+		.fifosize	= 128,
+		.has_divslot	= 1,
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.has_fracval	= 1,
+	}
+};
+#define ARTPEC8_SERIAL_DRV_DATA ((kernel_ulong_t)&artpec8_serial_drv_data)
+#else
+#define ARTPEC8_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#endif
+
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c2410-uart",
@@ -2866,6 +2896,10 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 		.name		= "exynos850-uart",
 		.driver_data	= EXYNOS850_SERIAL_DRV_DATA,
 	},
+	{
+		.name		= "artpec8-uart",
+		.driver_data	= ARTPEC8_SERIAL_DRV_DATA,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, s3c24xx_serial_driver_ids);
@@ -2888,6 +2922,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
 	{ .compatible = "apple,s5l-uart",
 		.data = (void *)S5L_SERIAL_DRV_DATA },
+	{ .compatible = "axis,artpec8-uart",
+		.data = (void *)ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos850-uart",
 		.data = (void *)EXYNOS850_SERIAL_DRV_DATA },
 	{},
@@ -3043,6 +3079,8 @@ OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 			s5pv210_early_console_setup);
+OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
+			s5pv210_early_console_setup);
 
 /* Apple S5L */
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
-- 
2.34.1

