Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92334517F68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiECIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiECIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:09:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4E20F5A;
        Tue,  3 May 2022 01:06:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1CFE9210E5;
        Tue,  3 May 2022 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECu5gs4Na4QCx3MdAZscC5hEAd3uD+930KihhgMqo+g=;
        b=0t0WBLkRPpnbG5Rz/Q0xOIzDEvzKG6LcU1ZOE/l1sdQVgXdq9v/DmJpdnFNkepgTjiEARx
        5ACVvNNwo5QYiItuZMVvSKtSLzhxRGEEwQ3bzXD0/KO7Y2C0SoBQuX3VM5wV50Tyqv+XbI
        4wcEXjdg28GfPG51QWjlHxJbGT+/A7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECu5gs4Na4QCx3MdAZscC5hEAd3uD+930KihhgMqo+g=;
        b=rKX81hd2r72cG0nw9Qh5hiQE9cvWFh2FyS1S/LKNd9V+r0msD1fuOmFfK7hHYRGGABSxz2
        B4hWKKeRmGnmcPCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E67922C143;
        Tue,  3 May 2022 08:06:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/7] serial: pch: move size check from pop_tx one level up
Date:   Tue,  3 May 2022 10:06:07 +0200
Message-Id: <20220503080613.27601-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503080613.27601-1-jslaby@suse.cz>
References: <20220503080613.27601-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'count' is zero in the pop_tx()'s comparison against 'size'. So the 'if'
tries to find out if 'size' is negative or zero and returns in that
case. But it cannot be negative, due to previous (size < 0) check in the
caller: handle_tx().

So simply move this check from pop_tx() to handle_tx(). Now it's clear
that pop_tx() is called only if fifo_size is non-zero.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pch_uart.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index affe71f8b50c..f872613a5e83 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -791,7 +791,7 @@ static int pop_tx(struct eg20t_port *priv, int size)
 	struct uart_port *port = &priv->port;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (uart_tx_stopped(port) || uart_circ_empty(xmit) || count >= size)
+	if (uart_tx_stopped(port) || uart_circ_empty(xmit))
 		goto pop_tx_end;
 
 	do {
@@ -895,14 +895,16 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 		tx_empty = 0;
 		fifo_size--;
 	}
+
 	size = min(xmit->head - xmit->tail, fifo_size);
 	if (size < 0)
 		size = fifo_size;
-
-	tx_size = pop_tx(priv, size);
-	if (tx_size > 0) {
-		port->icount.tx += tx_size;
-		tx_empty = 0;
+	if (size) {
+		tx_size = pop_tx(priv, size);
+		if (tx_size > 0) {
+			port->icount.tx += tx_size;
+			tx_empty = 0;
+		}
 	}
 
 	priv->tx_empty = tx_empty;
-- 
2.36.0

