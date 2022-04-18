Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F624505BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbiDRPuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345709AbiDRPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:42 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83E36E005;
        Mon, 18 Apr 2022 08:27:28 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E3AC192009E; Mon, 18 Apr 2022 17:27:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DC9DC92009C;
        Mon, 18 Apr 2022 16:27:27 +0100 (BST)
Date:   Mon, 18 Apr 2022 16:27:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] serial: 8250: Export ICR access helpers for internal
 use
In-Reply-To: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204181517500.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ICR access helpers available outside 8250_port.c, however retain 
them as ordinary static functions so as not to regress code generation.

This is because `serial_icr_write' is currently automatically inlined by 
GCC, however `serial_icr_read' is not.  Making them both static inline 
would grow code produced, e.g.:

$ i386-linux-gnu-size --format=gnu 8250_port-{old,new}.o
      text       data        bss      total filename
     15065       3378          0      18443 8250_port-old.o
     15289       3378          0      18667 8250_port-new.o

and:

$ riscv64-linux-gnu-size --format=gnu 8250_port-{old,new}.o
      text       data        bss      total filename
     16980       5306          0      22286 8250_port-old.o
     17124       5306          0      22430 8250_port-new.o

while making them external would needlessly add a new module interface 
and lose the benefit from `serial_icr_write' getting inlined outside 
8250_port.o.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes from v4:

- Reorder as 4/5 (from 3/5).

- Drop `__maybe_unused' from `serial_icr_write'; it's used by 
  `serial_icr_read'.

New change in v4, factored out from 5/5.
---
 drivers/tty/serial/8250/8250.h      |   22 ++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |   21 ---------------------
 2 files changed, 22 insertions(+), 21 deletions(-)

linux-serial-8250-icr-access.diff
Index: linux-macro/drivers/tty/serial/8250/8250.h
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250.h
+++ linux-macro/drivers/tty/serial/8250/8250.h
@@ -120,6 +120,28 @@ static inline void serial_out(struct uar
 	up->port.serial_out(&up->port, offset, value);
 }
 
+/*
+ * For the 16C950
+ */
+static void serial_icr_write(struct uart_8250_port *up, int offset, int value)
+{
+	serial_out(up, UART_SCR, offset);
+	serial_out(up, UART_ICR, value);
+}
+
+static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
+						   int offset)
+{
+	unsigned int value;
+
+	serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
+	serial_out(up, UART_SCR, offset);
+	value = serial_in(up, UART_ICR);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return value;
+}
+
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
 
 static inline int serial_dl_read(struct uart_8250_port *up)
Index: linux-macro/drivers/tty/serial/8250/8250_port.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_port.c
+++ linux-macro/drivers/tty/serial/8250/8250_port.c
@@ -538,27 +538,6 @@ serial_port_out_sync(struct uart_port *p
 }
 
 /*
- * For the 16C950
- */
-static void serial_icr_write(struct uart_8250_port *up, int offset, int value)
-{
-	serial_out(up, UART_SCR, offset);
-	serial_out(up, UART_ICR, value);
-}
-
-static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
-{
-	unsigned int value;
-
-	serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
-	serial_out(up, UART_SCR, offset);
-	value = serial_in(up, UART_ICR);
-	serial_icr_write(up, UART_ACR, up->acr);
-
-	return value;
-}
-
-/*
  * FIFO support.
  */
 static void serial8250_clear_fifos(struct uart_8250_port *p)
