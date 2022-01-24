Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2D49794B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiAXHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:16:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58092 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiAXHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 280871F3B8;
        Mon, 24 Jan 2022 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqmPmdOQqxIy+RmLUMMFIm6zUExbIA52ZsUr3TrP9ZY=;
        b=H0O9WYGBqfQX1AO6Gwvu+U3X4yE18KTuJCiy22/yPBfsC6JXHHGvQqyxay/PQtxQc0/Pj7
        bEmt0fapGm31hmJ9Ru4pu0zELNu0vdF8B3chmK2XIQY7+UI4SKhulBaMpmU53hCjqJEerg
        qNlljR1cDrWxG+Qml6wGKS7Ax1rhvBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqmPmdOQqxIy+RmLUMMFIm6zUExbIA52ZsUr3TrP9ZY=;
        b=MAJA+/wdDjO3kqC+GJYOv8tOLkV0tgUacI9zMEFX9krugYcEAv2TcJbBlY9wK5V07lf8PB
        m1Fbg6ZhjLfxTtCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9C9BA3B81;
        Mon, 24 Jan 2022 07:14:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/11] mxser: switch from xmit_buf to kfifo
Date:   Mon, 24 Jan 2022 08:14:26 +0100
Message-Id: <20220124071430.14907-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfifo for xmit buffer handling. The change is mostly
straightforward. It saves complexity both on the stuffing side
(mxser_write() and mxser_put_char()) and pulling side
(mxser_transmit_chars()). In fact, the loop in mxser_write() can be
completely deleted as the wrap of the buffer is taken care of in the
kfifo code now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 74 +++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4ddc12a63666..836c9eca2946 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -275,9 +275,6 @@ struct mxser_port {
 	u8 read_status_mask;
 	u8 ignore_status_mask;
 	u8 xmit_fifo_size;
-	unsigned int xmit_head;
-	unsigned int xmit_tail;
-	unsigned int xmit_cnt;
 
 	spinlock_t slock;
 };
@@ -813,7 +810,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	(void) inb(info->ioaddr + UART_MSR);
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
-	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
+	kfifo_reset(&port->xmit_fifo);
 
 	/*
 	 * and set the speed of the serial port
@@ -901,9 +898,8 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
-
 	spin_lock_irqsave(&info->slock, flags);
-	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
+	kfifo_reset(&info->port.xmit_fifo);
 
 	outb(info->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		info->ioaddr + UART_FCR);
@@ -920,50 +916,34 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	int c, total = 0;
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
+	int written;
+	bool is_empty;
 
-	while (1) {
-		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-					  SERIAL_XMIT_SIZE - info->xmit_head));
-		if (c <= 0)
-			break;
-
-		memcpy(info->port.xmit_buf + info->xmit_head, buf, c);
-		spin_lock_irqsave(&info->slock, flags);
-		info->xmit_head = (info->xmit_head + c) &
-				  (SERIAL_XMIT_SIZE - 1);
-		info->xmit_cnt += c;
-		spin_unlock_irqrestore(&info->slock, flags);
-
-		buf += c;
-		count -= c;
-		total += c;
-	}
+	spin_lock_irqsave(&info->slock, flags);
+	written = kfifo_in(&info->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&info->port.xmit_fifo);
+	spin_unlock_irqrestore(&info->slock, flags);
 
-	if (info->xmit_cnt && !tty->flow.stopped)
+	if (!is_empty && !tty->flow.stopped)
 		if (!tty->hw_stopped || mxser_16550A_or_MUST(info))
 			mxser_start_tx(info);
 
-	return total;
+	return written;
 }
 
 static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
-
-	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1)
-		return 0;
+	int ret;
 
 	spin_lock_irqsave(&info->slock, flags);
-	info->port.xmit_buf[info->xmit_head++] = ch;
-	info->xmit_head &= SERIAL_XMIT_SIZE - 1;
-	info->xmit_cnt++;
+	ret = kfifo_put(&info->port.xmit_fifo, ch);
 	spin_unlock_irqrestore(&info->slock, flags);
 
-	return 1;
+	return ret;
 }
 
 
@@ -971,7 +951,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
-	if (!info->xmit_cnt || tty->flow.stopped ||
+	if (kfifo_is_empty(&info->port.xmit_fifo) || tty->flow.stopped ||
 			(tty->hw_stopped && !mxser_16550A_or_MUST(info)))
 		return;
 
@@ -981,16 +961,15 @@ static void mxser_flush_chars(struct tty_struct *tty)
 static unsigned int mxser_write_room(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	int ret;
 
-	ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
-	return ret < 0 ? 0 : ret;
+	return kfifo_avail(&info->port.xmit_fifo);
 }
 
 static unsigned int mxser_chars_in_buffer(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	return info->xmit_cnt;
+
+	return kfifo_len(&info->port.xmit_fifo);
 }
 
 /*
@@ -1379,7 +1358,7 @@ static void mxser_start(struct tty_struct *tty)
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	if (info->xmit_cnt)
+	if (!kfifo_is_empty(&info->port.xmit_fifo))
 		__mxser_start_tx(info);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
@@ -1610,7 +1589,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		return;
 	}
 
-	if (!port->xmit_cnt || tty->flow.stopped ||
+	if (kfifo_is_empty(&port->port.xmit_fifo) || tty->flow.stopped ||
 			(tty->hw_stopped && !mxser_16550A_or_MUST(port))) {
 		__mxser_stop_tx(port);
 		return;
@@ -1618,18 +1597,19 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 
 	count = port->xmit_fifo_size;
 	do {
-		outb(port->port.xmit_buf[port->xmit_tail++],
-			port->ioaddr + UART_TX);
-		port->xmit_tail &= SERIAL_XMIT_SIZE - 1;
-		port->icount.tx++;
-		if (!--port->xmit_cnt)
+		unsigned char c;
+
+		if (!kfifo_get(&port->port.xmit_fifo, &c))
 			break;
+
+		outb(c, port->ioaddr + UART_TX);
+		port->icount.tx++;
 	} while (--count > 0);
 
-	if (port->xmit_cnt < WAKEUP_CHARS)
+	if (kfifo_len(&port->port.xmit_fifo) < WAKEUP_CHARS)
 		tty_wakeup(tty);
 
-	if (!port->xmit_cnt)
+	if (kfifo_is_empty(&port->port.xmit_fifo))
 		__mxser_stop_tx(port);
 }
 
-- 
2.34.1

