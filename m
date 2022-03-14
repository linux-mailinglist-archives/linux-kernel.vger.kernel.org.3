Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0F4D7E53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiCNJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiCNJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:15:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F43ED3A;
        Mon, 14 Mar 2022 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647249290; x=1678785290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tek9pvUQ8wIJl35VuH25V3YzoAX1Jt0Th31Nu4xv2nI=;
  b=FgbKYYTflQBXhV6z6qK9fn7th8zg/svYGcOtiKtj1y/YjHVF/SRW9Bqg
   ag+HN3oaQb9yiHSwPSFREzAVzoPJAxkvbfBkXqgP8GqUzwWeYXBTrU70u
   k7ByhR4AEcV6TvLjkHzcaCw8tDL/4MJZjjL5F3M+rlFbZnoj66qIjzthe
   84KVh+6b0BLdORGCbENeTpzn76yBPG5TAnm4ipUa+DJFV2oTJ77OoGRv3
   1AKEnPWEh2VnbizJTtpjaJ/Esv5ryAUXsWQmXUdYJYcHZD7n1yde8qurI
   qZAMy/Kifmt8smQK5aU1aLjpqVppRaVndaUjcDIsfL9vtf5Z4O9IlVTv/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="319201111"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="319201111"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 02:14:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="556322465"
Received: from srafikbh-mobl1.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 02:14:42 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] serial: 8250: fix XOFF/XON sending when DMA is used
Date:   Mon, 14 Mar 2022 11:14:32 +0200
Message-Id: <20220314091432.4288-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314091432.4288-1-ilpo.jarvinen@linux.intel.com>
References: <20220314091432.4288-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 8250 UART is using DMA, x_char (XON/XOFF) is never sent
to the wire. After this change, x_char is injected correctly.

Create uart_xchar_out() helper for sending the x_char out and
accounting related to it. It seems that almost every driver
does these same steps with x_char. Except for 8250, however,
almost all currently lack .serial_out so they cannot immediately
take advantage of this new helper.

The downside of this patch is that it might reintroduce
the problems some devices faced with mixed DMA/non-DMA transfer
which caused revert f967fc8f165f (Revert "serial: 8250_dma:
don't bother DMA with small transfers"). However, the impact
should be limited to cases with XON/XOFF (that didn't work
with DMA capable devices to begin with so this problem is not
very likely to cause a major issue, if any at all).

Reported-by: Gilles Buloz <gilles.buloz@kontron.com>
Tested-by: Gilles Buloz <gilles.buloz@kontron.com>
Fixes: 9ee4b83e51f74 ("serial: 8250: Add support for dmaengine")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c  | 11 ++++++++++-
 drivers/tty/serial/8250/8250_port.c |  4 +---
 drivers/tty/serial/serial_core.c    | 14 ++++++++++++++
 include/linux/serial_core.h         |  2 ++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 890fa7ddaa7f..b3c3f7e5851a 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -64,10 +64,19 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	struct uart_8250_dma		*dma = p->dma;
 	struct circ_buf			*xmit = &p->port.state->xmit;
 	struct dma_async_tx_descriptor	*desc;
+	struct uart_port		*up = &p->port;
 	int ret;
 
-	if (dma->tx_running)
+	if (dma->tx_running) {
+		if (up->x_char) {
+			dmaengine_pause(dma->txchan);
+			uart_xchar_out(up, UART_TX);
+			dmaengine_resume(dma->txchan);
+		}
 		return 0;
+	} else if (up->x_char) {
+		uart_xchar_out(up, UART_TX);
+	}
 
 	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
 		/* We have been called from __dma_tx_complete() */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b12bfc1ed67..63e9bc6fce06 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1799,9 +1799,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	int count;
 
 	if (port->x_char) {
-		serial_out(up, UART_TX, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
+		uart_xchar_out(port, UART_TX);
 		return;
 	}
 	if (uart_tx_stopped(port)) {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0db90be4c3bc..f67540ae2a88 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -644,6 +644,20 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	tty_port_tty_wakeup(&state->port);
 }
 
+/*
+ * This function performs low-level write of high-priority XON/XOFF
+ * character and accounting for it.
+ *
+ * Requires uart_port to implement .serial_out().
+ */
+void uart_xchar_out(struct uart_port *uport, int offset)
+{
+	serial_port_out(uport, offset, uport->x_char);
+	uport->icount.tx++;
+	uport->x_char = 0;
+}
+EXPORT_SYMBOL_GPL(uart_xchar_out);
+
 /*
  * This function is used to send a high-priority XON/XOFF character to
  * the device
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c58cc142d23f..8c32935e1059 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -458,6 +458,8 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
+void uart_xchar_out(struct uart_port *uport, int offset);
+
 #ifdef CONFIG_MAGIC_SYSRQ_SERIAL
 #define SYSRQ_TIMEOUT	(HZ * 5)
 
-- 
2.30.2

