Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8AB55A2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiFXUnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiFXUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:43:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC692B7D4;
        Fri, 24 Jun 2022 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656103391; x=1687639391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EhPWsojq58v2YfbXuxjbSxZz3HBzOiryDlqpjPm/vg=;
  b=chcNnrAJMf8GgUdDSJXOdMxxjCqBTPt8II+yUuZ/CYiO4k2RbQqOMGor
   BIzErKBN7Rxq0bD2oR/vfQytzr4d4IJOT/zOYLPYXbGlt06RRHUH+gGmT
   cikSB1SbWWmLRr5QtDrkhbPqVVN86PmShcieHUoNaaAVKIUTmfzrHFv0i
   07N/M8Av/VCVFz+DBdKbPyARfWHhnJlkBldQuCazBvoYU4jYWLh8JRs7S
   urjAM8GvPOIuaX8yahgGDtESrL2x4t1fNQcRb22EaPYKRSBMIJfyrAPJa
   yXEwUcCR5T3VYIvafeqcgLHhlT3TGC3MtqWSLSRAi8UPs3q1wjgswRqx7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261509654"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="261509654"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:43:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593381202"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:43:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Subject: [PATCH v9 6/6] serial: 8250_dwlib: Support for 9th bit multipoint addressing
Date:   Fri, 24 Jun 2022 23:42:10 +0300
Message-Id: <20220624204210.11112-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
References: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 9th bit multipoint addressing mode for DW UART. 9th bit addressing
can be used only when HW RS485 is available.

Updating RAR (receive address register) is bit tricky because busy
indication is not be available when DW UART is strictly 16550
compatible, which is the case with the hardware I was testing with. RAR
should not be updated while receive is in progress which is now
achieved by deasserting RE and waiting for one frame (in case rx would
be in progress, the driver seems to have no way of knowing it w/o busy
indication). Because of this complexity, it's better to avoid doing it
unless really needed.

Co-developed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Co-developed-by: Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 102 ++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index d1ff3daeb0ba..da330ef46446 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -3,8 +3,10 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/property.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
@@ -16,9 +18,18 @@
 #define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
 #define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
 #define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
+#define DW_UART_RAR	0xc4 /* Receive Address Register */
+#define DW_UART_TAR	0xc8 /* Transmit Address Register */
+#define DW_UART_LCR_EXT	0xcc /* Line Extended Control Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
+/* Receive / Transmit Address Register bits */
+#define DW_UART_ADDR_MASK		GENMASK(7, 0)
+
+/* Line Status Register bits */
+#define DW_UART_LSR_ADDR_RCVD		BIT(8)
+
 /* Transceiver Control Register bits */
 #define DW_UART_TCR_RS485_EN		BIT(0)
 #define DW_UART_TCR_RE_POL		BIT(1)
@@ -28,6 +39,12 @@
 #define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
 #define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
 
+/* Line Extended Control Register bits */
+#define DW_UART_LCR_EXT_DLS_E		BIT(0)
+#define DW_UART_LCR_EXT_ADDR_MATCH	BIT(1)
+#define DW_UART_LCR_EXT_SEND_ADDR	BIT(2)
+#define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -82,9 +99,83 @@ void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct
 		p->status |= UPSTAT_AUTOCTS;
 
 	serial8250_do_set_termios(p, termios, old);
+
+	/* Filter addresses which have 9th bit set */
+	p->ignore_status_mask |= DW_UART_LSR_ADDR_RCVD;
+	p->read_status_mask |= DW_UART_LSR_ADDR_RCVD;
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
+/*
+ * Wait until re is de-asserted for sure. An ongoing receive will keep
+ * re asserted until end of frame. Without BUSY indication available,
+ * only available course of action is to wait for the time it takes to
+ * receive one frame (there might nothing to receive but w/o BUSY the
+ * driver cannot know).
+ */
+static void dw8250_wait_re_deassert(struct uart_port *p)
+{
+	ndelay(p->frame_time);
+}
+
+static void dw8250_update_rar(struct uart_port *p, u32 addr)
+{
+	u32 re_en = dw8250_readl_ext(p, DW_UART_RE_EN);
+
+	/*
+	 * RAR shouldn't be changed while receiving. Thus, de-assert RE_EN
+	 * if asserted and wait.
+	 */
+	if (re_en)
+		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+	dw8250_wait_re_deassert(p);
+	dw8250_writel_ext(p, DW_UART_RAR, addr);
+	if (re_en)
+		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);
+}
+
+static void dw8250_rs485_set_addr(struct uart_port *p, struct serial_rs485 *rs485,
+				  struct ktermios *termios)
+{
+	u32 lcr = dw8250_readl_ext(p, DW_UART_LCR_EXT);
+
+	if (rs485->flags & SER_RS485_ADDRB) {
+		lcr |= DW_UART_LCR_EXT_DLS_E;
+		if (termios)
+			termios->c_cflag |= ADDRB;
+
+		if (rs485->flags & SER_RS485_ADDR_RECV) {
+			u32 delta = p->rs485.flags ^ rs485->flags;
+
+			/*
+			 * rs485 (param) is equal to uart_port's rs485 only during init
+			 * (during init, delta is not yet applicable).
+			 */
+			if (unlikely(&p->rs485 == rs485))
+				delta = rs485->flags;
+
+			if ((delta & SER_RS485_ADDR_RECV) ||
+			    (p->rs485.addr_recv != rs485->addr_recv))
+				dw8250_update_rar(p, rs485->addr_recv);
+			lcr |= DW_UART_LCR_EXT_ADDR_MATCH;
+		} else {
+			lcr &= ~DW_UART_LCR_EXT_ADDR_MATCH;
+		}
+		if (rs485->flags & SER_RS485_ADDR_DEST) {
+			/*
+			 * Don't skip writes here as another endpoint could
+			 * have changed communication line's destination
+			 * address in between.
+			 */
+			dw8250_writel_ext(p, DW_UART_TAR, rs485->addr_dest);
+			lcr |= DW_UART_LCR_EXT_SEND_ADDR;
+		}
+	} else {
+		lcr = 0;
+	}
+	dw8250_writel_ext(p, DW_UART_LCR_EXT, lcr);
+}
+
 static int dw8250_rs485_config(struct uart_port *p, struct ktermios *termios,
 			       struct serial_rs485 *rs485)
 {
@@ -109,6 +200,9 @@ static int dw8250_rs485_config(struct uart_port *p, struct ktermios *termios,
 		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
 		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
 	} else {
+		if (termios)
+			termios->c_cflag &= ~ADDRB;
+
 		tcr &= ~DW_UART_TCR_RS485_EN;
 	}
 
@@ -123,6 +217,10 @@ static int dw8250_rs485_config(struct uart_port *p, struct ktermios *termios,
 
 	dw8250_writel_ext(p, DW_UART_TCR, tcr);
 
+	/* Addressing mode can only be set up after TCR */
+	if (rs485->flags & SER_RS485_ENABLED)
+		dw8250_rs485_set_addr(p, rs485, termios);
+
 	return 0;
 }
 
@@ -142,7 +240,8 @@ static bool dw8250_detect_rs485_hw(struct uart_port *p)
 
 static const struct serial_rs485 dw8250_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_RTS_ON_SEND |
-		 SER_RS485_RTS_AFTER_SEND,
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_ADDRB | SER_RS485_ADDR_RECV |
+		 SER_RS485_ADDR_DEST,
 };
 
 void dw8250_setup_port(struct uart_port *p)
@@ -155,6 +254,7 @@ void dw8250_setup_port(struct uart_port *p)
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
 		p->rs485_config = dw8250_rs485_config;
+		up->lsr_save_mask = LSR_SAVE_FLAGS | DW_UART_LSR_ADDR_RCVD;
 		p->rs485_supported = &dw8250_rs485_supported;
 	} else {
 		p->rs485_config = serial8250_em485_config;
-- 
2.30.2

