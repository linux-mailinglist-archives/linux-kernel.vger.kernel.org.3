Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E524D11AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbiCHIKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbiCHIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680B3D1F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:29 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52F7F3F61B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726968;
        bh=tfYTw7M8SGNblLSK+OTR7ft1x+niAVfIowhtu3q65AY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=HXjJB6B9B6ejGdITG09qJCNIaaq/CcWIRiUKd5IwqDV5xmOgX6TbUBTKCt5PtWdUP
         /RoLR2JTax1E7McLkeWzlUzm5trNDQnZr79E7iCwXN9MDL+3aW+S0j9CyUjuEFVo7E
         Y+06/0+dEHC/IOaCftyrIdocS1jCmpSCxiiUM1zolPQyVGnKSD/z4sNya0mJCosypN
         8fmlRzlUNcnB1EIc22zkB9TOgWuYNl21C//HKYkDEbbzSpmy9S66TGzubrRt4Zgrsc
         h+yuDNS7bk1bFv6o0NjwwJu9wbetchyRboMJW68xtW0e2RFngzUnzsi7NeeD98m9OW
         DeNZYSW92pwOQ==
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so8186818ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfYTw7M8SGNblLSK+OTR7ft1x+niAVfIowhtu3q65AY=;
        b=Pjv77QsPpmFyt5g9ZIq+IiGDuQOGAVeS96IPcKQkMgX1/qADz8IdgZQfp1eTPJl9HJ
         Mi25jub1YA3jg93KPJF3TCkfuUiQLN6K0axWUgLOMce6pQFS0XUnxypwYoIFoVsewst5
         U/56iv5lv6/CZqix06yTxiLKGZyOHN0g5Mhu/h57/y+6oR7X502QEb1jwFFF/gjegytQ
         ocJjNUipGELYj/BGpMhrhWIwjxjqI3M9cOZ2SIeKR3gujpggVsYLfAp1FulmIFOs1gu7
         BSekI7nRHCeuZboIJBGqXtqHeIn5vGV4QepkWOSI15FILEbXEKwyiheV12PenP8JQ4HJ
         QqGw==
X-Gm-Message-State: AOAM533hPUKLBigYJNxk49lJuFK+Rzdg+4Jl9UZT1c8d/wGOCIru4JYt
        +SgSBQUt4aJOl3Onq9LpR9aPziBmvoONm0jY3/mhNZuUMOAEc8xzQ86ozRmO9vArvYSnBuesafp
        6RsRZiu5EM+HwFIE/HSCGLuZGCHWIRjeND00FFm4X1Q==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr12097008ejc.701.1646726967879;
        Tue, 08 Mar 2022 00:09:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4S5b8cDkgWsMD2VwX44UQxX1h1DDN2AljrAE6McGdTq0MBRrLMyFtooQYg29GydbisVK9qQ==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr12096985ejc.701.1646726967665;
        Tue, 08 Mar 2022 00:09:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 4/8] tty: serial: samsung: constify s3c24xx_serial_drv_data
Date:   Tue,  8 Mar 2022 09:09:15 +0100
Message-Id: <20220308080919.152715-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
References: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver data (struct s3c24xx_serial_drv_data) is only used to
initialize the driver properly and is not modified.  Make it const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 58 ++++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 66434eb58db8..c4b13f2d6e26 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -136,14 +136,14 @@ struct s3c24xx_uart_port {
 	unsigned int			tx_mode;
 	unsigned int			rx_mode;
 
-	struct s3c24xx_uart_info	*info;
+	const struct s3c24xx_uart_info	*info;
 	struct clk			*clk;
 	struct clk			*baudclk;
 	struct uart_port		port;
-	struct s3c24xx_serial_drv_data	*drv_data;
+	const struct s3c24xx_serial_drv_data	*drv_data;
 
 	/* reference to platform data */
-	struct s3c2410_uartcfg		*cfg;
+	const struct s3c2410_uartcfg	*cfg;
 
 	struct s3c24xx_uart_dma		*dma;
 
@@ -221,7 +221,7 @@ static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
 	local_irq_restore(flags);
 }
 
-static inline struct s3c24xx_uart_port *to_ourport(struct uart_port *port)
+static inline struct s3c24xx_uart_port *to_ourport(const struct uart_port *port)
 {
 	return container_of(port, struct s3c24xx_uart_port, port);
 }
@@ -573,13 +573,13 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 	}
 }
 
-static inline struct s3c24xx_uart_info
+static inline const struct s3c24xx_uart_info
 	*s3c24xx_port_to_info(struct uart_port *port)
 {
 	return to_ourport(port)->info;
 }
 
-static inline struct s3c2410_uartcfg
+static inline const struct s3c2410_uartcfg
 	*s3c24xx_port_to_cfg(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport;
@@ -594,7 +594,7 @@ static inline struct s3c2410_uartcfg
 static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
 				     unsigned long ufstat)
 {
-	struct s3c24xx_uart_info *info = ourport->info;
+	const struct s3c24xx_uart_info *info = ourport->info;
 
 	if (ufstat & info->rx_fifofull)
 		return ourport->port.fifosize;
@@ -986,7 +986,7 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 
 static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned long ufstat = rd_regl(port, S3C2410_UFSTAT);
 	unsigned long ufcon = rd_regl(port, S3C2410_UFCON);
 
@@ -1405,7 +1405,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 
 static inline int s3c24xx_serial_getsource(struct uart_port *port)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned int ucon;
 
 	if (info->num_clks == 1)
@@ -1419,7 +1419,7 @@ static inline int s3c24xx_serial_getsource(struct uart_port *port)
 static void s3c24xx_serial_setsource(struct uart_port *port,
 			unsigned int clk_sel)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned int ucon;
 
 	if (info->num_clks == 1)
@@ -1438,7 +1438,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			unsigned int req_baud, struct clk **best_clk,
 			unsigned int *clk_num)
 {
-	struct s3c24xx_uart_info *info = ourport->info;
+	const struct s3c24xx_uart_info *info = ourport->info;
 	struct clk *clk;
 	unsigned long rate;
 	unsigned int cnt, baud, quot, best_quot = 0;
@@ -1522,7 +1522,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 				       struct ktermios *termios,
 				       struct ktermios *old)
 {
-	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
+	const struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	struct clk *clk = ERR_PTR(-EINVAL);
 	unsigned long flags;
@@ -1691,7 +1691,7 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 
 static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 
 	if (flags & UART_CONFIG_TYPE)
 		port->type = info->port_type;
@@ -1703,7 +1703,7 @@ static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
 static int
 s3c24xx_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 
 	if (ser->type != PORT_UNKNOWN && ser->type != info->port_type)
 		return -EINVAL;
@@ -1873,9 +1873,9 @@ s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
  */
 
 static void s3c24xx_serial_resetport(struct uart_port *port,
-				   struct s3c2410_uartcfg *cfg)
+				     const struct s3c2410_uartcfg *cfg)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
 
 	ucon &= (info->clksel_mask | info->ucon_mask);
@@ -1979,7 +1979,7 @@ s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
 static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
 {
 	struct device *dev = ourport->port.dev;
-	struct s3c24xx_uart_info *info = ourport->info;
+	const struct s3c24xx_uart_info *info = ourport->info;
 	char clk_name[MAX_CLK_NAME_LENGTH];
 	unsigned int clk_sel;
 	struct clk *clk;
@@ -2021,7 +2021,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 				    struct platform_device *platdev)
 {
 	struct uart_port *port = &ourport->port;
-	struct s3c2410_uartcfg *cfg = ourport->cfg;
+	const struct s3c2410_uartcfg *cfg = ourport->cfg;
 	struct resource *res;
 	int ret;
 
@@ -2156,7 +2156,7 @@ static const struct of_device_id s3c24xx_uart_dt_match[];
 
 static int probe_index;
 
-static inline struct s3c24xx_serial_drv_data *
+static inline const struct s3c24xx_serial_drv_data *
 s3c24xx_get_driver_data(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
@@ -2419,7 +2419,7 @@ static struct uart_port *cons_uart;
 static int
 s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
 {
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned long ufstat, utrstat;
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
@@ -2615,7 +2615,7 @@ static struct console s3c24xx_serial_console = {
 #endif /* CONFIG_SERIAL_SAMSUNG_CONSOLE */
 
 #ifdef CONFIG_CPU_S3C2410
-static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C2410 UART",
 		.type		= TYPE_S3C24XX,
@@ -2643,7 +2643,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 #endif
 
 #ifdef CONFIG_CPU_S3C2412
-static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C2412 UART",
 		.type		= TYPE_S3C24XX,
@@ -2673,7 +2673,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
 	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442)
-static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C2440 UART",
 		.type		= TYPE_S3C24XX,
@@ -2703,7 +2703,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
-static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= TYPE_S3C6400,
@@ -2732,7 +2732,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 #endif
 
 #ifdef CONFIG_CPU_S5PV210
-static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S5PV210 UART",
 		.type		= TYPE_S3C6400,
@@ -2784,17 +2784,17 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.has_fracval	= 1,				\
 	}							\
 
-static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
 	EXYNOS_COMMON_SERIAL_DRV_DATA(),
 	.fifosize = { 256, 64, 16, 16 },
 };
 
-static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 	EXYNOS_COMMON_SERIAL_DRV_DATA(),
 	.fifosize = { 64, 256, 16, 256 },
 };
 
-static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	EXYNOS_COMMON_SERIAL_DRV_DATA(),
 	.fifosize = { 256, 64, 64, 64 },
 };
@@ -2810,7 +2810,7 @@ static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
-static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 	.info = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
-- 
2.32.0

