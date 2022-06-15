Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572F454C901
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348998AbiFOMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348940AbiFOMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:49:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CF818E06;
        Wed, 15 Jun 2022 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655297339; x=1686833339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lsr0reZ0ljc/IDxdZ6OVGhyBg7O/sLBaX8TSU3lbY7E=;
  b=MLyYnuCn8wTc2HvPCzROwU2mTHlUTJRsBpv/EwOZgNcq4cYupuKXMefF
   6WpbV2YuwBPGTpycHH5PU0PQt3QJdqwwJqSFdc7ZVOB/Em2Ve5nKzYR9M
   AVZcnK1rGCVcXkVOKnbwB4A9Kwz7jc6MQ6BjJ1RZ5UYCLQG8Bke6WqOrJ
   HaMs9M9glvmduQFyFeMGrtwZ3+zVyhEbrfRkKHMzcB11TTjhirxmGferK
   q/epu4a1hC1XroM5nkM3SqKrK245JAH4Td7f376THmGBcYm33WPL9fjrU
   yTPZCJSDuo3xJxwosVkwH8wcoEfgp40bRYeulSE+0+alSdf6wtuMFnIl0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261973580"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="261973580"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:48:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="687288103"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:48:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 1/6] serial: 8250: make saved LSR larger
Date:   Wed, 15 Jun 2022 15:48:24 +0300
Message-Id: <20220615124829.34516-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW flags address received as BIT(8) in LSR. In order to not lose that
on read, enlarge lsr_saved_flags to u16.

Adjust lsr/status variables and related call chains to use u16.
Technically, some of these type conversion would not be needed but it
doesn't hurt to be consistent.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h         |  4 ++--
 drivers/tty/serial/8250/8250_exar.c    |  2 +-
 drivers/tty/serial/8250/8250_fsl.c     |  2 +-
 drivers/tty/serial/8250/8250_ingenic.c |  2 +-
 drivers/tty/serial/8250/8250_omap.c    |  7 +++----
 drivers/tty/serial/8250/8250_port.c    | 17 +++++++++--------
 include/linux/serial_8250.h            |  6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b120da57c61f..0ff5688ba90c 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -133,9 +133,9 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
  *
  *	Returns LSR value or'ed with the preserved flags (if any).
  */
-static inline unsigned int serial_lsr_in(struct uart_8250_port *up)
+static inline u16 serial_lsr_in(struct uart_8250_port *up)
 {
-	unsigned int lsr = up->lsr_saved_flags;
+	u16 lsr = up->lsr_saved_flags;
 
 	lsr |= serial_in(up, UART_LSR);
 	up->lsr_saved_flags = lsr & LSR_SAVE_FLAGS;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 528779b40049..8be3c9ecd623 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -195,7 +195,7 @@ static int xr17v35x_startup(struct uart_port *port)
 
 static void exar_shutdown(struct uart_port *port)
 {
-	unsigned char lsr;
+	u16 lsr;
 	bool tx_complete = false;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct circ_buf *xmit = &port->state->xmit;
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 9c01c531349d..e76b8bd3d4a1 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -25,7 +25,7 @@
 
 int fsl8250_handle_irq(struct uart_port *port)
 {
-	unsigned char lsr, orig_lsr;
+	u16 lsr, orig_lsr;
 	unsigned long flags;
 	unsigned int iir;
 	struct uart_8250_port *up = up_to_u8250p(port);
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index cff91aa03f29..2b2f5d8d24b9 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -54,7 +54,7 @@ static void early_out(struct uart_port *port, int offset, uint8_t value)
 
 static void ingenic_early_console_putc(struct uart_port *port, unsigned char c)
 {
-	uint8_t lsr;
+	u16 lsr;
 
 	do {
 		lsr = early_in(port, UART_LSR);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ac8bfa042391..0dcecbbc3967 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1115,8 +1115,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 	return omap_8250_rx_dma(up);
 }
 
-static unsigned char omap_8250_handle_rx_dma(struct uart_8250_port *up,
-					     u8 iir, unsigned char status)
+static u16 omap_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir, u16 status)
 {
 	if ((status & (UART_LSR_DR | UART_LSR_BI)) &&
 	    (iir & UART_IIR_RDI)) {
@@ -1130,7 +1129,7 @@ static unsigned char omap_8250_handle_rx_dma(struct uart_8250_port *up,
 }
 
 static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
-				     unsigned char status)
+				     u16 status)
 {
 	/*
 	 * Queue a new transfer if FIFO has data.
@@ -1164,7 +1163,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = up->port.private_data;
-	unsigned char status;
+	u16 status;
 	u8 iir;
 
 	serial8250_rpm_get(up);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c860f5964138..f417c29507e1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1508,7 +1508,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
 	struct uart_8250_em485 *em485 = p->em485;
 
 	if (em485) {
-		unsigned char lsr = serial_lsr_in(p);
+		u16 lsr = serial_lsr_in(p);
 		u64 stop_delay = 0;
 
 		if (!(lsr & UART_LSR_THRE))
@@ -1565,7 +1565,7 @@ static inline void __start_tx(struct uart_port *port)
 
 	if (serial8250_set_THRI(up)) {
 		if (up->bugs & UART_BUG_TXEN) {
-			unsigned char lsr = serial_lsr_in(up);
+			u16 lsr = serial_lsr_in(up);
 
 			if (lsr & UART_LSR_THRE)
 				serial8250_tx_chars(up);
@@ -1719,7 +1719,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
+void serial8250_read_char(struct uart_8250_port *up, u16 lsr)
 {
 	struct uart_port *port = &up->port;
 	unsigned char ch;
@@ -1788,7 +1788,7 @@ EXPORT_SYMBOL_GPL(serial8250_read_char);
  * (such as THRE) because the LSR value might come from an already consumed
  * character.
  */
-unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
+u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 {
 	struct uart_port *port = &up->port;
 	int max_count = 256;
@@ -1908,7 +1908,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
  */
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
-	unsigned char status;
+	u16 status;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	bool skip_rx = false;
 	unsigned long flags;
@@ -1994,7 +1994,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
-	unsigned int lsr;
+	u16 lsr;
 
 	serial8250_rpm_get(up);
 
@@ -2117,7 +2117,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 static int serial8250_get_poll_char(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned char lsr;
+	u16 lsr;
 	int status;
 
 	serial8250_rpm_get(up);
@@ -2173,7 +2173,8 @@ int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
-	unsigned char lsr, iir;
+	unsigned char iir;
+	u16 lsr;
 	int retval;
 
 	if (!port->fifosize)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ff84a3ed10ea..4565f25ba9a2 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -119,7 +119,7 @@ struct uart_8250_port {
 	 * be immediately processed.
 	 */
 #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
-	unsigned char		lsr_saved_flags;
+	u16			lsr_saved_flags;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
@@ -170,8 +170,8 @@ extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 				      unsigned int quot_frac);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
-unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
-void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr);
+u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
+void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
 void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
-- 
2.30.2

