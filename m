Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD04CCF92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiCDIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiCDIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:04:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE93B6D20
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:04:08 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6FE593F610
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381047;
        bh=tkFzw6lPD+d7IUHuEyg4SR+Uqauf7bGHXxHOG6uOhJE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=shpzYs4NrDEGw3bzhLKfCpTnH9anXHrY2aBd8Fg0xjiECeA5egf8mUY+3+y4jW4Sf
         FUpVHjNbzCwso1u5dvb0A2v+df16pZJhJN00cc8ewrtFdRWPklNXuj7QU6Dk7OL1G7
         fcQZEOjXiUjU5wfFIGzR70bL8o2NDE3s8w5YVOORyXdF3LyEnW2hxVqDJYqnxwy8fm
         wy0h5MSsF2qD/fmJfTZ6jVECrdr0j3nKpwOmOfv6GMYE+urGND7AxMerRub05m2fo4
         0Btc07JhesHRVLP7iewUkYXob7BKKXsKaG1xP2aSHYYhhGIRXXfhrpuCPq+IY1HDB1
         5vVJGfO1oSi3w==
Received: by mail-ed1-f71.google.com with SMTP id m12-20020a056402510c00b00413298c3c42so4187234edd.15
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkFzw6lPD+d7IUHuEyg4SR+Uqauf7bGHXxHOG6uOhJE=;
        b=BlyZs9b81fdiBRazJaM58hjbblZ4x0sKnqwdHbHY86animoHeuVW1SQoarhmMV4V/B
         m+e0C7l1T8AJyNFI0Ai1gvJ5qoAoqYMChLpNoLUa3iZwlalBaXzJtG7DvnyCxdJaJ6MQ
         u5rckIol+DKiaxBGncoTATmBwQ6hy1CBfPKtWbs4eTUb/dXQ24nIPt3CpKjBhQiNr+uM
         ChVICGAdJZP8EcTTZ53oKW7sKOwyJrvpjbiEHgYJ0h9UiwoN0YOGtBQYCG3g+ZtM9bbP
         9OZbUpvLq0/xkp4YNWis7Y/x3VrdqKOLo0SkjFz3Em0ZQ7yLSW8WZgBWtrIXHjoUgXum
         syrQ==
X-Gm-Message-State: AOAM5338Kg46kr8zt5Ll3IL6l5Dv8CrPmT/vqap9zeMdMnwEnZwDi//0
        LKWC6r0Tcbh68w/qXUNPT53vFidr9HhsS2dnhgfTg3zcDHPrenYuJmdcmr0xL9L/9Np9ILzQ8SH
        36rPrs8VXaUNCOVUuwr23NytRyUs3WXat41S2G3JcBg==
X-Received: by 2002:aa7:c3d8:0:b0:415:a0a9:1f18 with SMTP id l24-20020aa7c3d8000000b00415a0a91f18mr13900981edr.412.1646381046224;
        Fri, 04 Mar 2022 00:04:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAoYlFqtIS/wNs7p5E3iZzy6T1pQuvHkOTV8Oa+pnRvMS1Gv2k/UzkFrbgh4dvOK2sCCYu/Q==
X-Received: by 2002:aa7:c3d8:0:b0:415:a0a9:1f18 with SMTP id l24-20020aa7c3d8000000b00415a0a91f18mr13900967edr.412.1646381046030;
        Fri, 04 Mar 2022 00:04:06 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] tty: serial: samsung: constify variables and pointers
Date:   Fri,  4 Mar 2022 09:03:47 +0100
Message-Id: <20220304080348.218581-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify variables, data pointed by several pointers and
"udivslot_table" static array.  This makes code a bit safer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 38 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index eecefff5c4a4..00e7c34fad46 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -164,7 +164,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-static u32 rd_reg(struct uart_port *port, u32 reg)
+static u32 rd_reg(const struct uart_port *port, u32 reg)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -179,7 +179,7 @@ static u32 rd_reg(struct uart_port *port, u32 reg)
 
 #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
-static void wr_reg(struct uart_port *port, u32 reg, u32 val)
+static void wr_reg(const struct uart_port *port, u32 reg, u32 val)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -195,7 +195,7 @@ static void wr_reg(struct uart_port *port, u32 reg, u32 val)
 
 /* Byte-order aware bit setting/clearing functions. */
 
-static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
+static inline void s3c24xx_set_bit(const struct uart_port *port, int idx,
 				   unsigned int reg)
 {
 	unsigned long flags;
@@ -208,7 +208,7 @@ static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
 	local_irq_restore(flags);
 }
 
-static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
+static inline void s3c24xx_clear_bit(const struct uart_port *port, int idx,
 				     unsigned int reg)
 {
 	unsigned long flags;
@@ -221,19 +221,19 @@ static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
 	local_irq_restore(flags);
 }
 
-static inline struct s3c24xx_uart_port *to_ourport(const struct uart_port *port)
+static inline struct s3c24xx_uart_port *to_ourport(struct uart_port *port)
 {
 	return container_of(port, struct s3c24xx_uart_port, port);
 }
 
 /* translate a port to the device name */
 
-static inline const char *s3c24xx_serial_portname(struct uart_port *port)
+static inline const char *s3c24xx_serial_portname(const struct uart_port *port)
 {
 	return to_platform_device(port->dev)->name;
 }
 
-static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
+static int s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 {
 	return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
 }
@@ -358,7 +358,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 
 static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 {
-	struct uart_port *port = &ourport->port;
+	const struct uart_port *port = &ourport->port;
 	u32 ucon;
 
 	/* Mask Tx interrupt */
@@ -387,7 +387,7 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 
 static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
 {
-	struct uart_port *port = &ourport->port;
+	const struct uart_port *port = &ourport->port;
 	u32 ucon, ufcon;
 
 	/* Set ufcon txtrig */
@@ -580,9 +580,9 @@ static inline const struct s3c24xx_uart_info
 }
 
 static inline const struct s3c2410_uartcfg
-	*s3c24xx_port_to_cfg(struct uart_port *port)
+	*s3c24xx_port_to_cfg(const struct uart_port *port)
 {
-	struct s3c24xx_uart_port *ourport;
+	const struct s3c24xx_uart_port *ourport;
 
 	if (port->dev == NULL)
 		return NULL;
@@ -591,7 +591,7 @@ static inline const struct s3c2410_uartcfg
 	return ourport->cfg;
 }
 
-static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
+static int s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *ourport,
 				     unsigned long ufstat)
 {
 	const struct s3c24xx_uart_info *info = ourport->info;
@@ -947,8 +947,8 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
 /* interrupt handler for s3c64xx and later SoC's.*/
 static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 {
-	struct s3c24xx_uart_port *ourport = id;
-	struct uart_port *port = &ourport->port;
+	const struct s3c24xx_uart_port *ourport = id;
+	const struct uart_port *port = &ourport->port;
 	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
 	irqreturn_t ret = IRQ_HANDLED;
 
@@ -966,8 +966,8 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 /* interrupt handler for Apple SoC's.*/
 static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 {
-	struct s3c24xx_uart_port *ourport = id;
-	struct uart_port *port = &ourport->port;
+	const struct s3c24xx_uart_port *ourport = id;
+	const struct uart_port *port = &ourport->port;
 	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
 	irqreturn_t ret = IRQ_NONE;
 
@@ -1499,7 +1499,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
  * This table takes the fractional value of the baud divisor and gives
  * the recommended setting for the UDIVSLOT register.
  */
-static u16 udivslot_table[16] = {
+static const u16 udivslot_table[16] = {
 	[0] = 0x0000,
 	[1] = 0x0080,
 	[2] = 0x0808,
@@ -1675,7 +1675,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 static const char *s3c24xx_serial_type(struct uart_port *port)
 {
-	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	const struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	switch (ourport->info->type) {
 	case TYPE_S3C24XX:
@@ -2450,7 +2450,7 @@ s3c24xx_port_configured(unsigned int ucon)
 
 static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 {
-	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	const struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned int ufstat;
 
 	ufstat = rd_regl(port, S3C2410_UFSTAT);
-- 
2.32.0

