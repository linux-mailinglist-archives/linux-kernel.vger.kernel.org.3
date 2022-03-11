Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3954D5EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbiCKJql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiCKJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:46:32 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE281BE4C9;
        Fri, 11 Mar 2022 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646991929;
  x=1678527929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOMLzEesVg6HYaOAZ4KCgGOM/7fxz+rqf2h1kQQi9LY=;
  b=BNklQVJb0nsShtPM3oe2hhSmq3alWsefd/ByhcFCKALmM6GV3CYDmS4l
   HVVn47z4n7iRZ23+/k3sunyeBw9YMgSkBcNFL8Oo+YRirSRw52yYz3R51
   mvZT3/GIRYtA/o9Xsv3OCdpkyoSj9K5mC+U3NUkz87qerkPPjU+L7Lw44
   YlO/nncNZS4NsPNbhaBn6Dsq7yqmv5CTZpLypwmEGfv4ubPSOP0iUH+Rz
   nlSN3jMv4GBrMCsDRbkPEmM4+hACTUptAqwnf/L/8z3NxhfHZT2xThWaN
   tZHszSbEnikF6Aw5Mh8DVAIBEcs7Hj4OAzXuChhRgB6rBw3oFzbsoo+Gi
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <krzysztof.kozlowski@canonical.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <alim.akhtar@samsung.com>
Subject: [PATCH v2 2/2] tty: serial: samsung: Add ARTPEC-8 support
Date:   Fri, 11 Mar 2022 10:45:15 +0100
Message-ID: <20220311094515.3223023-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
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

Add support for the UART block on the ARTPEC-8 SoC.  This is closely
related to the variants used on the Exynos chips.  The register layout
is identical to Exynos850 et al but the fifo size is different (64 bytes
in each direction for all instances).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2:
    - Added Krzysztof's Reviewed-by.
    - Expanded commit message
    - Fixed fifo size
    - Rebased on top of Krzysztof's "minor fixes/cleanups" series.  This needed a
      couple of fixes for build errors.
    
    (I'm always unsure if Reviewed-by should be carried over or not if the fixes
    are minor.  I apologize in advance if carring it over was the wrong thing to do
    in this case.)

 drivers/tty/serial/Kconfig       |  2 +-
 drivers/tty/serial/samsung_tty.c | 37 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0e5ccb25bdb1..bd46e35ded40 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -236,7 +236,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || ARCH_ARTPEC || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 74d466cc4152..7d011d3fa3a6 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2828,6 +2828,36 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 #define S5L_SERIAL_DRV_DATA NULL
 #endif
 
+#if defined(CONFIG_ARCH_ARTPEC)
+static const struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {
+	.info = {
+		.name		= "Axis ARTPEC-8 UART",
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
+		.fifosize	= 64,
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
+	.def_cfg = {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.has_fracval	= 1,
+	}
+};
+#define ARTPEC8_SERIAL_DRV_DATA (&artpec8_serial_drv_data)
+#else
+#define ARTPEC8_SERIAL_DRV_DATA (NULL)
+#endif
+
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c2410-uart",
@@ -2856,6 +2886,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos850-uart",
 		.driver_data	= (kernel_ulong_t)EXYNOS850_SERIAL_DRV_DATA,
+	}, {
+		.name		= "artpec8-uart",
+		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2881,6 +2914,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = S5L_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos850-uart",
 		.data = EXYNOS850_SERIAL_DRV_DATA },
+	{ .compatible = "axis,artpec8-uart",
+		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
@@ -3034,6 +3069,8 @@ OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 			s5pv210_early_console_setup);
+OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
+			s5pv210_early_console_setup);
 
 /* Apple S5L */
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
-- 
2.34.1

