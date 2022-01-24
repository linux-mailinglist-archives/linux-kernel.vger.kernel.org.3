Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905ED497946
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiAXHPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:15:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbiAXHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1910821902;
        Mon, 24 Jan 2022 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRMgZ5FDBy6Zkj47m+UUogIIvf9qagcdtK0/L6BvNPA=;
        b=BtpSyL/z69pXszzVJdDm5iETX2Dd43UIy2dPNP8K7QvIRak2taUAFnz23cy2O1Jiqvr7Vq
        zil0nXOw0KWWM9FQMst4zn++bwQL+KjI7ZWdNMHZBPUdQBU12QgPCHwcHIRcM2WkEXSQwA
        5/hovVM5WaQBUy0sxlIJK8KCXg0l+A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRMgZ5FDBy6Zkj47m+UUogIIvf9qagcdtK0/L6BvNPA=;
        b=+R4sp2+NfSpgTHzh5kh+TUg8nCcTaFu4fBkIOwCLvJ06/BNGATDp0j52dqCFL2jj2to1gA
        UnN+r9YDm+qW8+AA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CB112A3B85;
        Mon, 24 Jan 2022 07:14:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/11] serial: mcf: use helpers in mcf_tx_chars()
Date:   Mon, 24 Jan 2022 08:14:30 +0100
Message-Id: <20220124071430.14907-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use uart_circ_empty() instead of open-coding it via xmit->head & tail.
Use preexisting mcf_stop_tx() to avoid stop-tx code duplication.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mcf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index c7cec7d03620..2aec62b5d6c4 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -338,7 +338,7 @@ static void mcf_tx_chars(struct mcf_uart *pp)
 	}
 
 	while (readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY) {
-		if (xmit->head == xmit->tail)
+		if (uart_circ_empty(xmit))
 			break;
 		writeb(xmit->buf[xmit->tail], port->membase + MCFUART_UTB);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE -1);
@@ -348,9 +348,8 @@ static void mcf_tx_chars(struct mcf_uart *pp)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (xmit->head == xmit->tail) {
-		pp->imr &= ~MCFUART_UIR_TXREADY;
-		writeb(pp->imr, port->membase + MCFUART_UIMR);
+	if (uart_circ_empty(xmit)) {
+		mcf_stop_tx(port);
 		/* Disable TX to negate RTS automatically */
 		if (port->rs485.flags & SER_RS485_ENABLED)
 			writeb(MCFUART_UCR_TXDISABLE,
-- 
2.34.1

