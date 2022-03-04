Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98AD4CCF8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiCDIFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiCDIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:04:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EFCA0E9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:04:05 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 142AF3F5FF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381044;
        bh=NmWyog0dSb7D+stc7tOzMzcifPRYWyFrWkHJ3CmV8CY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FWCx8qoiki7nNibJR2aQdP1hOX66Wbkh9z4KKzIiR12QQg9h2jCqrGDdrH6XuRfnH
         0FZ9uqCXjsd2cOCRoKN9i6zos7xT0Ud7xs7CblaRRaftDnhXrXdp3q9580QqqGfUpX
         a14fQfePwE+j+4r25vpUesOLxQ3IfHoVCAtpdEi3SGztcFtWtRP80int/5cz5B8E0e
         YaYmY+hENyTUXAi+OHLpndZUnkI/QhKiCmGZI1StoV3v9qSqpNN5XuSuQ3aSHqmemc
         R2xV7/eHs/wc8knGm1WU0p2Myk9O58vXzvT2wQrC9153BWCu7pbDKJJMeBHUclA5av
         Zo6XOsHHN+B2g==
Received: by mail-ej1-f72.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso4039882ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmWyog0dSb7D+stc7tOzMzcifPRYWyFrWkHJ3CmV8CY=;
        b=frLbbKqwS2J3etvtg3JfSufWTrZopSdv/dyPdX96dI4XA7Y8RjPWR17vrw51dq4ekn
         tXLMOivN51DfVuDlbr7Z6FwgGabmhCrMqjhCuEeaIpTKFRPvxYfVP8aqsswMz4F7Z7WR
         SM1DHEY41a2d+eJtSckUZYOSVCIloKZGFVJQi2badrNRBca6g2RuBUMj5deun7ypIphw
         ckR7ehnLx0lVFAjyVb+DJR6I3pdy2gU09+CJ0QxMoTRpfVAD0HxfcUrkVPKY19k5bMgo
         +9xhSqed8ggy7Z7o5uneGDtyXCTr19CGVVRV9tksn23twHOxyl/wm6B/3GnOiwSmhvPP
         tJQg==
X-Gm-Message-State: AOAM533I0/Vn4zyj+FJi0fJTZR23y9RXyiLGGG8fEK6wu/nPurrdDJQp
        gCPGAQEfFoEYn/byRs+dUVNz5417CYzifgn0Bri/FZ/sRrcEdekwVudLY0HjvGGfay7bOXf+vLK
        BMUU3t6tsrtjuIBaF2fB0v3gIX2PzDh5h3RkQj6ssgA==
X-Received: by 2002:a05:6402:484:b0:415:d931:cb2f with SMTP id k4-20020a056402048400b00415d931cb2fmr6894045edv.287.1646381042965;
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzicprBu0sVSUEL0wImjOfaeFFiH9Yvs/r/MYgmzmdBTau7LZnCjkgIIQFk9Ua165CkV2+Pwg==
X-Received: by 2002:a05:6402:484:b0:415:d931:cb2f with SMTP id k4-20020a056402048400b00415d931cb2fmr6893969edv.287.1646381041662;
        Fri, 04 Mar 2022 00:04:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] tty: serial: samsung: constify s3c24xx_serial_drv_data
Date:   Fri,  4 Mar 2022 09:03:44 +0100
Message-Id: <20220304080348.218581-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver data (struct s3c24xx_serial_drv_data) is only used to
initialize the driver properly and is not modified.  Make it const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 139 +++++++++++++++----------------
 1 file changed, 69 insertions(+), 70 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index a9a75b5b9705..0b4f40044e87 100644
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
@@ -2637,13 +2637,13 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2410_serial_drv_data)
+#define S3C2410_SERIAL_DRV_DATA (&s3c2410_serial_drv_data)
 #else
-#define S3C2410_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2410_SERIAL_DRV_DATA (NULL)
 #endif
 
 #ifdef CONFIG_CPU_S3C2412
-static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C2412 UART",
 		.type		= TYPE_S3C24XX,
@@ -2666,14 +2666,14 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2412_serial_drv_data)
+#define S3C2412_SERIAL_DRV_DATA (&s3c2412_serial_drv_data)
 #else
-#define S3C2412_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2412_SERIAL_DRV_DATA (NULL)
 #endif
 
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
 	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442)
-static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C2440 UART",
 		.type		= TYPE_S3C24XX,
@@ -2697,13 +2697,13 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2440_serial_drv_data)
+#define S3C2440_SERIAL_DRV_DATA (&s3c2440_serial_drv_data)
 #else
-#define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2440_SERIAL_DRV_DATA (NULL)
 #endif
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
-static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= TYPE_S3C6400,
@@ -2726,13 +2726,13 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
+#define S3C6400_SERIAL_DRV_DATA (&s3c6400_serial_drv_data)
 #else
-#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C6400_SERIAL_DRV_DATA (NULL)
 #endif
 
 #ifdef CONFIG_CPU_S5PV210
-static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = {
 		.name		= "Samsung S5PV210 UART",
 		.type		= TYPE_S3C6400,
@@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	},
 	.fifosize = { 256, 64, 16, 16 },
 };
-#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
+#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
 #else
-#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
+#define S5PV210_SERIAL_DRV_DATA	(NULL)
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
@@ -2784,33 +2784,33 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
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
 
-#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
-#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
-#define EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos850_serial_drv_data)
+#define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
+#define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
+#define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
 
 #else
-#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
-#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
-#define EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS4210_SERIAL_DRV_DATA (NULL)
+#define EXYNOS5433_SERIAL_DRV_DATA (NULL)
+#define EXYNOS850_SERIAL_DRV_DATA (NULL)
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
-static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
+static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 	.info = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
@@ -2832,39 +2832,39 @@ static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.ufcon		= S3C2410_UFCON_DEFAULT,
 	},
 };
-#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
+#define S5L_SERIAL_DRV_DATA (&s5l_serial_drv_data)
 #else
-#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define S5L_SERIAL_DRV_DATA (NULL)
 #endif
 
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c2410-uart",
-		.driver_data	= S3C2410_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C2410_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s3c2412-uart",
-		.driver_data	= S3C2412_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C2412_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s3c2440-uart",
-		.driver_data	= S3C2440_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C2440_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s3c6400-uart",
-		.driver_data	= S3C6400_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S3C6400_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s5pv210-uart",
-		.driver_data	= S5PV210_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S5PV210_SERIAL_DRV_DATA,
 	}, {
 		.name		= "exynos4210-uart",
-		.driver_data	= EXYNOS4210_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)EXYNOS4210_SERIAL_DRV_DATA,
 	}, {
 		.name		= "exynos5433-uart",
-		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)EXYNOS5433_SERIAL_DRV_DATA,
 	}, {
 		.name		= "s5l-uart",
-		.driver_data	= S5L_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)S5L_SERIAL_DRV_DATA,
 	}, {
 		.name		= "exynos850-uart",
-		.driver_data	= EXYNOS850_SERIAL_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)EXYNOS850_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2873,23 +2873,23 @@ MODULE_DEVICE_TABLE(platform, s3c24xx_serial_driver_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id s3c24xx_uart_dt_match[] = {
 	{ .compatible = "samsung,s3c2410-uart",
-		.data = (void *)S3C2410_SERIAL_DRV_DATA },
+		.data = S3C2410_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s3c2412-uart",
-		.data = (void *)S3C2412_SERIAL_DRV_DATA },
+		.data = S3C2412_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s3c2440-uart",
-		.data = (void *)S3C2440_SERIAL_DRV_DATA },
+		.data = S3C2440_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s3c6400-uart",
-		.data = (void *)S3C6400_SERIAL_DRV_DATA },
+		.data = S3C6400_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,s5pv210-uart",
-		.data = (void *)S5PV210_SERIAL_DRV_DATA },
+		.data = S5PV210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos4210-uart",
-		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
+		.data = EXYNOS4210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos5433-uart",
-		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
+		.data = EXYNOS5433_SERIAL_DRV_DATA },
 	{ .compatible = "apple,s5l-uart",
-		.data = (void *)S5L_SERIAL_DRV_DATA },
+		.data = S5L_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos850-uart",
-		.data = (void *)EXYNOS850_SERIAL_DRV_DATA },
+		.data = EXYNOS850_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
@@ -2935,7 +2935,7 @@ module_exit(samsung_serial_exit);
  * Early console.
  */
 
-static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
+static void wr_reg_barrier(const struct uart_port *port, u32 reg, u32 val)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -2951,15 +2951,15 @@ struct samsung_early_console_data {
 	u32 txfull_mask;
 };
 
-static void samsung_early_busyuart(struct uart_port *port)
+static void samsung_early_busyuart(const struct uart_port *port)
 {
 	while (!(readl(port->membase + S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXFE))
 		;
 }
 
-static void samsung_early_busyuart_fifo(struct uart_port *port)
+static void samsung_early_busyuart_fifo(const struct uart_port *port)
 {
-	struct samsung_early_console_data *data = port->private_data;
+	const struct samsung_early_console_data *data = port->private_data;
 
 	while (readl(port->membase + S3C2410_UFSTAT) & data->txfull_mask)
 		;
@@ -3062,7 +3062,6 @@ static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(s5l, "apple,s5l-uart", apple_s5l_early_console_setup);
 #endif
 
-MODULE_ALIAS("platform:samsung-uart");
 MODULE_DESCRIPTION("Samsung SoC Serial port driver");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_LICENSE("GPL v2");
-- 
2.32.0

