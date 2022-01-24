Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84B497938
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiAXHOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58038 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiAXHOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E00FA1F38F;
        Mon, 24 Jan 2022 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSk7hKrcCNXUhWO61RD0aeiO4YU6KlDqpYa7y+nvyoo=;
        b=wWaXyPQapUwKn6BQoIJ4MZnU9W7o6063JvCs15lx84B/6ttYsyS9ricCi0RlNEQkWlIVxd
        SatQM91YlIM4B/iB2PepbmuD1CKvoYpnEmsB9XBNYtnKgYyQ6+USQaz7ijv1ymdQAkhS/W
        IgKjPpz/V+7GMfHrajh/fp0GL6bdZYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008471;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSk7hKrcCNXUhWO61RD0aeiO4YU6KlDqpYa7y+nvyoo=;
        b=0RW8RAtCfXpHVnJwz5czHIc6b7WZxaPLSv1cYOHKlLBesoXpwWZRVX1bSKcrrftChz8glH
        J2tFBKNy282zfcAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A62D1A3B81;
        Mon, 24 Jan 2022 07:14:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/11] serial: core: clean up EXPORT_SYMBOLs
Date:   Mon, 24 Jan 2022 08:14:20 +0100
Message-Id: <20220124071430.14907-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some EXPORT_SYMBOLs are grouped at one location. Some follow functions
they export, but a newline is present before them. Fix all these and
move them where they belong.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/serial_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index dc40c4155356..1f6df577c75b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -105,6 +105,7 @@ void uart_write_wakeup(struct uart_port *port)
 	BUG_ON(!state);
 	tty_port_tty_wakeup(&state->port);
 }
+EXPORT_SYMBOL(uart_write_wakeup);
 
 static void uart_stop(struct tty_struct *tty)
 {
@@ -351,7 +352,6 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 	 */
 	port->timeout = (HZ * size) / baud + HZ/50;
 }
-
 EXPORT_SYMBOL(uart_update_timeout);
 
 /**
@@ -453,7 +453,6 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 	WARN_ON(1);
 	return 0;
 }
-
 EXPORT_SYMBOL(uart_get_baud_rate);
 
 /**
@@ -478,7 +477,6 @@ uart_get_divisor(struct uart_port *port, unsigned int baud)
 
 	return quot;
 }
-
 EXPORT_SYMBOL(uart_get_divisor);
 
 /* Caller holds port mutex */
@@ -2220,6 +2218,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 
 	return 0;
 }
+EXPORT_SYMBOL(uart_suspend_port);
 
 int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 {
@@ -2305,6 +2304,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 
 	return 0;
 }
+EXPORT_SYMBOL(uart_resume_port);
 
 static inline void
 uart_report_port(struct uart_driver *drv, struct uart_port *port)
@@ -2599,6 +2599,7 @@ int uart_register_driver(struct uart_driver *drv)
 out:
 	return retval;
 }
+EXPORT_SYMBOL(uart_register_driver);
 
 /**
  *	uart_unregister_driver - remove a driver from the uart core layer
@@ -2622,6 +2623,7 @@ void uart_unregister_driver(struct uart_driver *drv)
 	drv->state = NULL;
 	drv->tty_driver = NULL;
 }
+EXPORT_SYMBOL(uart_unregister_driver);
 
 struct tty_driver *uart_console_device(struct console *co, int *index)
 {
@@ -2956,6 +2958,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	return ret;
 }
+EXPORT_SYMBOL(uart_add_one_port);
 
 /**
  *	uart_remove_one_port - detach a driver defined port structure
@@ -3036,6 +3039,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	return ret;
 }
+EXPORT_SYMBOL(uart_remove_one_port);
 
 /*
  *	Are the two ports equivalent?
@@ -3212,14 +3216,6 @@ bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 EXPORT_SYMBOL_GPL(uart_try_toggle_sysrq);
 #endif
 
-EXPORT_SYMBOL(uart_write_wakeup);
-EXPORT_SYMBOL(uart_register_driver);
-EXPORT_SYMBOL(uart_unregister_driver);
-EXPORT_SYMBOL(uart_suspend_port);
-EXPORT_SYMBOL(uart_resume_port);
-EXPORT_SYMBOL(uart_add_one_port);
-EXPORT_SYMBOL(uart_remove_one_port);
-
 /**
  * uart_get_rs485_mode() - retrieve rs485 properties for given uart
  * @port: uart device's target port
-- 
2.34.1

