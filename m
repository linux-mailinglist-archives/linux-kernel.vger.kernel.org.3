Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77229517D71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiECGfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiECGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5B381A4;
        Mon,  2 May 2022 23:31:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7AF231F74B;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FwR3pXwiEOYd31NngXicEXAdD76ELJgZWCXDrPYOL0=;
        b=zRUcISbqM8NXpz3wFjJwzYVahoO/8aL9BJKXgLGyHjze0jqC6q287e39652ixdGFkS+qTN
        N566Cl+qTp8B+oGXcM4pUSpZXvkkitWuitFy/cyNK99oY/Qd1kLfiPSLE4j1g/mPVYj7uX
        4pdRMjfIDlqNl2tvS0l/VJiA2csST/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FwR3pXwiEOYd31NngXicEXAdD76ELJgZWCXDrPYOL0=;
        b=pjbYBlwL4bWrTcQFCB5K1RFPfDbFqlCK85z+11pUFJ+TcwD+i6cgaQsApGAWat3Ik697L8
        S71w6JJ0hMk/77DQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 507702C143;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/11] serial: pic32: simplify pic32_sport::enable_tx_irq handling
Date:   Tue,  3 May 2022 08:31:16 +0200
Message-Id: <20220503063122.20957-6-jslaby@suse.cz>
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

Make it a bool, so use true+false. And remove the wrap-around macro --
i.e. access the member directly.

It makes the code more obvious.

BTW the macro did not have 'sport' in parentheses, so it was potentially
problematic wrt expansion.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 42269e96b3f8..a6d548d5833d 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -63,7 +63,7 @@ struct pic32_sport {
 	const char *irq_rx_name;
 	int irq_tx;
 	const char *irq_tx_name;
-	u8 enable_tx_irq;
+	bool enable_tx_irq;
 
 	bool hw_flow_ctrl;
 	int cts_gpio;
@@ -74,7 +74,6 @@ struct pic32_sport {
 };
 #define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
 #define pic32_get_port(sport) (&sport->port)
-#define tx_irq_enabled(sport) (sport->enable_tx_irq)
 
 static inline void pic32_uart_writel(struct pic32_sport *sport,
 					u32 reg, u32 val)
@@ -195,16 +194,16 @@ static unsigned int pic32_uart_get_mctrl(struct uart_port *port)
  */
 static inline void pic32_uart_irqtxen(struct pic32_sport *sport, u8 en)
 {
-	if (en && !tx_irq_enabled(sport)) {
+	if (en && !sport->enable_tx_irq) {
 		enable_irq(sport->irq_tx);
-		tx_irq_enabled(sport) = 1;
-	} else if (!en && tx_irq_enabled(sport)) {
+		sport->enable_tx_irq = true;
+	} else if (!en && sport->enable_tx_irq) {
 		/* use disable_irq_nosync() and not disable_irq() to avoid self
 		 * imposed deadlock by not waiting for irq handler to end,
 		 * since this callback is called from interrupt context.
 		 */
 		disable_irq_nosync(sport->irq_tx);
-		tx_irq_enabled(sport) = 0;
+		sport->enable_tx_irq = false;
 	}
 }
 
@@ -497,7 +496,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	 * For each irq request_irq() is called with interrupt disabled.
 	 * And the irq is enabled as soon as we are ready to handle them.
 	 */
-	tx_irq_enabled(sport) = 0;
+	sport->enable_tx_irq = false;
 
 	sport->irq_fault_name = kasprintf(GFP_KERNEL, "%s%d-fault",
 					  pic32_uart_type(port),
-- 
2.36.0

