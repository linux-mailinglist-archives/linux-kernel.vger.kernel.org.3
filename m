Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CF8517D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiECGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiECGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BEC381A6;
        Mon,  2 May 2022 23:31:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5692210EF;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=787qMRnXnKwsARPvMVRxSoTbi3ggYCHSeqiE7jrlomA=;
        b=nJzPI5SKW7Sw4ahlYb5HqqCgWNJ3yzOyT/7+RfXD23gW5pXNRh4kqjoDgTPaeEcy7Vircc
        cXIeFqvVHOh2BfjuMUEiJLTS3mh+l20FAqiaNe6xorXuz+8SLejpOGaKQ4qIdilaD6J5B9
        RajEt6hha5/PEIZOTopRmj5HJINOi/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=787qMRnXnKwsARPvMVRxSoTbi3ggYCHSeqiE7jrlomA=;
        b=nxLcKC+d7YnTr/ALUk3x9lg0RKV4jS5voIICcsK2Ih9Z+iOmfQEwY1TZez2+f2bxmVve++
        +l9iNppvYwZibXCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C3492C141;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/11] serial: pic32: remove pic32_get_port() macro
Date:   Tue,  3 May 2022 08:31:17 +0200
Message-Id: <20220503063122.20957-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
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

It's just &sport->port. First, sport was not in parenthesis, so macro
expansion could be an issue. Second, it's so simple, that we can expand
the macro and make the code really straightforward.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index a6d548d5833d..32a86b12f203 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -73,21 +73,16 @@ struct pic32_sport {
 	struct device *dev;
 };
 #define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
-#define pic32_get_port(sport) (&sport->port)
 
 static inline void pic32_uart_writel(struct pic32_sport *sport,
 					u32 reg, u32 val)
 {
-	struct uart_port *port = pic32_get_port(sport);
-
-	__raw_writel(val, port->membase + reg);
+	__raw_writel(val, sport->port.membase + reg);
 }
 
 static inline u32 pic32_uart_readl(struct pic32_sport *sport, u32 reg)
 {
-	struct uart_port *port = pic32_get_port(sport);
-
-	return	__raw_readl(port->membase + reg);
+	return	__raw_readl(sport->port.membase + reg);
 }
 
 /* pic32 uart mode register bits */
@@ -789,10 +784,9 @@ static void pic32_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
 	struct pic32_sport *sport = pic32_sports[co->index];
-	struct uart_port *port = pic32_get_port(sport);
 
 	/* call uart helper to deal with \r\n */
-	uart_console_write(port, s, count, pic32_console_putchar);
+	uart_console_write(&sport->port, s, count, pic32_console_putchar);
 }
 
 /* console core request to setup given console, find matching uart
@@ -801,7 +795,6 @@ static void pic32_console_write(struct console *co, const char *s,
 static int pic32_console_setup(struct console *co, char *options)
 {
 	struct pic32_sport *sport;
-	struct uart_port *port = NULL;
 	int baud = 115200;
 	int bits = 8;
 	int parity = 'n';
@@ -814,7 +807,6 @@ static int pic32_console_setup(struct console *co, char *options)
 	sport = pic32_sports[co->index];
 	if (!sport)
 		return -ENODEV;
-	port = pic32_get_port(sport);
 
 	ret = clk_prepare_enable(sport->clk);
 	if (ret)
@@ -823,7 +815,7 @@ static int pic32_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
-	return uart_set_options(port, co, baud, parity, bits, flow);
+	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
 }
 
 static struct uart_driver pic32_uart_driver;
-- 
2.36.0

