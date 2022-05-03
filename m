Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E55517F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiECIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiECILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:11:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4A20F7B;
        Tue,  3 May 2022 01:08:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D78FF1F74D;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skhWprJCJ9t6aVTQc28O4ZVcV9NM7tx+rRuIGq1wdK8=;
        b=KJyGJXf/KNj47pQAJa51hizUKGF/rUo3yyva6EIxtov2pyh/MG8TGF7eKLMrir3oKSNXX9
        zpb7mHzVa6Fqfa/FFYnk4QWZRE9vYHAP91sM5JlOPmMGqp7+HJ24AoQg5Z/zjmO/ScT976
        2LuIDKq0DuNnNrS7tB8oFHFXBMpYbp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skhWprJCJ9t6aVTQc28O4ZVcV9NM7tx+rRuIGq1wdK8=;
        b=w0BM0TlC7C3V6PVXQtAeRKGEQSr9oesqQWMotY9BIpcO7RSLlctQnlGOmWckm6jlWudcU7
        Gq5IbV4MiJQLDrCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A664A2C145;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/7] serial: pch: simplify pop_tx() even more
Date:   Tue,  3 May 2022 10:08:07 +0200
Message-Id: <20220503080808.28332-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503080808.28332-1-jslaby@suse.cz>
References: <20220503080613.27601-1-jslaby@suse.cz>
 <20220503080808.28332-1-jslaby@suse.cz>
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

1) take uart_tx_stopped into account every loop (the same as other uart
   drivers)
2) no need for 'count' variable, operate on 'size' directly

This allows inlining this into handle_tx() nicely in the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pch_uart.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index ae1d6b641253..e1eadf519089 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -759,21 +759,19 @@ static void pch_dma_tx_complete(void *arg)
 
 static bool pop_tx(struct eg20t_port *priv, unsigned int size)
 {
-	unsigned int count = 0;
 	struct uart_port *port = &priv->port;
 	struct circ_buf *xmit = &port->state->xmit;
+	bool ret = false;
 
-	if (uart_tx_stopped(port))
-		return false;
-
-	while (!uart_circ_empty(xmit) && count < size) {
+	while (!uart_tx_stopped(port) && !uart_circ_empty(xmit) && size) {
 		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
-		count++;
+		size--;
+		ret = true;
 	}
 
-	return count;
+	return ret;
 }
 
 static int handle_rx_to(struct eg20t_port *priv)
-- 
2.36.0

