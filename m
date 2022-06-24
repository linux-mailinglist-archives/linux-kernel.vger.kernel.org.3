Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9C55A31D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiFXUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiFXUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:55:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847684896;
        Fri, 24 Jun 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656104101; x=1687640101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4aZHN2G/eQajxFyFoeTD1MtcxfTjtBeZalxelXiSht4=;
  b=Ec7WCRBFPEhszrfZLXXnLZjcYFBH/XJu8sFFJK/g8ESsU4x8Ab+EGktw
   KxTwwHbZV4ObZvcFwMZilgXn12YZwtxyU6E6Fenhf81Vzr6ZKHq4CA063
   UzT5FUBh9nyPWYwIJpEWpvRDrpYBxsiNKrvAJGvfxq9gwaITIU3NuWx3U
   WFC7IKjSHOhg6rupJRwONvCWvxyttQHLbDKbxM151j7Se1MvqZCdy4Euq
   yNIuP6KwNt9YKxyPBjiB2B0N/6TCeg+pREeASQ3jJNaq4mKYMRCITk+KE
   DEdPLGz7Dx59jS+WL3Shx6vnXOPIajy5CW/6Xo5Q94WZbJOdxWmm0BXKo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="367408231"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="367408231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:55:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593384295"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:54:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH v3 5/6] serial: Convert SERIAL_XMIT_SIZE to UART_XMIT_SIZE
Date:   Fri, 24 Jun 2022 23:54:23 +0300
Message-Id: <20220624205424.12686-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624205424.12686-1-ilpo.jarvinen@linux.intel.com>
References: <20220624205424.12686-1-ilpo.jarvinen@linux.intel.com>
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
 6 files changed, 13 insertions(+), 19 deletions(-)

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
-- 
2.30.2

