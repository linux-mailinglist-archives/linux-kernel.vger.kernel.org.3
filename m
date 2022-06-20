Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59C5515F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiFTKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiFTKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:34:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EF140BE;
        Mon, 20 Jun 2022 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721277; x=1687257277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yH8POsgRhRXCiIZTZnKwKTqk7N6N290ggzSM4QXCYYM=;
  b=YgJwcoE4QaHVMXFskEbHkCosnamI4givW196e1LcSLE9OO7mqhwnqEkw
   YRax77Jig2s2ueg4hgEilNHWNTe6KRTdKkU7QDwluHr2FjTXA+a4nBCOy
   6P7Nw/t/XKfquib/EW2VboZGyxUjuEiBVEVq/Hi7e+Q9Stp7N/3JqNqOy
   +bARHh0xlxzVsE8KJNXCrOXSId9lp1LUbM19Q9MtJJ4Pe+utIQFGOkL3G
   xTD1s6xg36Tb/MybiGIm0OkNb5g6kOoUpMdd2uenDU2Dqqej80Fcz86Pd
   n+sRBmK4L9Ku2Xq19JiwVuBfuKJtfQH05597NJy73Ib/eRckXqkmhd1Td
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262896078"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262896078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643055518"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/6] cleanup: Use UART_XMIT_SIZE
Date:   Mon, 20 Jun 2022 13:34:07 +0300
Message-Id: <20220620103408.37454-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
References: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both UART_XMIT_SIZE and SERIAL_XMIT_SIZE are defined. Make them all
UART_XMIT_SIZE.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/amiserial.c         | 18 +++++++++---------
 drivers/tty/mips_ejtag_fdc.c    |  2 +-
 drivers/tty/serial/meson_uart.c |  2 +-
 drivers/tty/serial/owl-uart.c   |  2 +-
 drivers/tty/serial/rda-uart.c   |  2 +-
 include/linux/serial.h          |  6 ------
 include/linux/serial_core.h     |  1 +
 7 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index afb2d373dd47..5458e2b1c125 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -51,6 +51,7 @@
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
+#include <linux/serial_core.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
@@ -283,12 +284,12 @@ static void transmit_chars(struct serial_state *info)
 
 	amiga_custom.serdat = info->xmit.buf[info->xmit.tail++] | 0x100;
 	mb();
-	info->xmit.tail = info->xmit.tail & (SERIAL_XMIT_SIZE-1);
+	info->xmit.tail = info->xmit.tail & (UART_XMIT_SIZE - 1);
 	info->icount.tx++;
 
 	if (CIRC_CNT(info->xmit.head,
 		     info->xmit.tail,
-		     SERIAL_XMIT_SIZE) < WAKEUP_CHARS)
+		     UART_XMIT_SIZE) < WAKEUP_CHARS)
 		tty_wakeup(info->tport.tty);
 
 #ifdef SERIAL_DEBUG_INTR
@@ -708,13 +709,13 @@ static int rs_put_char(struct tty_struct *tty, unsigned char ch)
 	local_irq_save(flags);
 	if (CIRC_SPACE(info->xmit.head,
 		       info->xmit.tail,
-		       SERIAL_XMIT_SIZE) == 0) {
+		       UART_XMIT_SIZE) == 0) {
 		local_irq_restore(flags);
 		return 0;
 	}
 
 	info->xmit.buf[info->xmit.head++] = ch;
-	info->xmit.head &= SERIAL_XMIT_SIZE-1;
+	info->xmit.head &= UART_XMIT_SIZE - 1;
 	local_irq_restore(flags);
 	return 1;
 }
@@ -753,15 +754,14 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 	while (1) {
 		c = CIRC_SPACE_TO_END(info->xmit.head,
 				      info->xmit.tail,
-				      SERIAL_XMIT_SIZE);
+				      UART_XMIT_SIZE);
 		if (count < c)
 			c = count;
 		if (c <= 0) {
 			break;
 		}
 		memcpy(info->xmit.buf + info->xmit.head, buf, c);
-		info->xmit.head = ((info->xmit.head + c) &
-				   (SERIAL_XMIT_SIZE-1));
+		info->xmit.head = (info->xmit.head + c) & (UART_XMIT_SIZE - 1);
 		buf += c;
 		count -= c;
 		ret += c;
@@ -788,14 +788,14 @@ static unsigned int rs_write_room(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	return CIRC_SPACE(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
+	return CIRC_SPACE(info->xmit.head, info->xmit.tail, UART_XMIT_SIZE);
 }
 
 static unsigned int rs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	return CIRC_CNT(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
+	return CIRC_CNT(info->xmit.head, info->xmit.tail, UART_XMIT_SIZE);
 }
 
 static void rs_flush_buffer(struct tty_struct *tty)
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 49907427a165..e81701a66429 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -916,7 +916,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 	mips_ejtag_fdc_write(priv, REG_FDCFG, cfg);
 
 	/* Make each port's xmit FIFO big enough to fill FDC TX FIFO */
-	priv->xmit_size = min(tx_fifo * 4, (unsigned int)SERIAL_XMIT_SIZE);
+	priv->xmit_size = min(tx_fifo * 4, (unsigned int)UART_XMIT_SIZE);
 
 	driver = tty_alloc_driver(NUM_TTY_CHANNELS, TTY_DRIVER_REAL_RAW);
 	if (IS_ERR(driver))
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 4869c0059c98..6c8db19fd572 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -162,7 +162,7 @@ static void meson_uart_start_tx(struct uart_port *port)
 
 		ch = xmit->buf[xmit->tail];
 		writel(ch, port->membase + AML_UART_WFIFO);
-		xmit->tail = (xmit->tail+1) & (SERIAL_XMIT_SIZE - 1);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 	}
 
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 44d20e5a7dd3..888e17e3f25f 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -201,7 +201,7 @@ static void owl_uart_send_chars(struct uart_port *port)
 
 		ch = xmit->buf[xmit->tail];
 		owl_uart_write(port, ch, OWL_UART_TXDAT);
-		xmit->tail = (xmit->tail + 1) & (SERIAL_XMIT_SIZE - 1);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 	}
 
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index f556b4955f59..feb2054aba37 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -353,7 +353,7 @@ static void rda_uart_send_chars(struct uart_port *port)
 
 		ch = xmit->buf[xmit->tail];
 		rda_uart_write(port, ch, RDA_UART_RXTX_BUFFER);
-		xmit->tail = (xmit->tail + 1) & (SERIAL_XMIT_SIZE - 1);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 	}
 
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 0b8b7d7c8f33..70a9866e4abb 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -9,7 +9,6 @@
 #ifndef _LINUX_SERIAL_H
 #define _LINUX_SERIAL_H
 
-#include <asm/page.h>
 #include <uapi/linux/serial.h>
 
 /* Helper for dealing with UART_LCR_WLEN* defines */
@@ -25,11 +24,6 @@ struct async_icount {
 	__u32	buf_overrun;
 };
 
-/*
- * The size of the serial xmit buffer is 1 page, or 4096 bytes
- */
-#define SERIAL_XMIT_SIZE PAGE_SIZE
-
 #include <linux/compiler.h>
 
 #endif /* _LINUX_SERIAL_H */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5518b70177b3..1767dee98021 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -296,6 +296,7 @@ struct uart_state {
 	struct uart_port	*uart_port;
 };
 
+/* The size of the serial xmit buffer is 1 page, or 4096 bytes */
 #define UART_XMIT_SIZE	PAGE_SIZE
 
 
-- 
2.30.2

