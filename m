Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43593517D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiECGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiECGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960AF381B1;
        Mon,  2 May 2022 23:31:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B8CB1F74A;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDGq2MehCOuWbouH8qY7t2f0w7/Wwz3YBeWZPEhcmus=;
        b=FKJ8qSQJInvQR3s5rJMHC9K+NJk9VbJ7/e4VvVXMP3P28/siEuTnY4Fy45CwsFsELW8RVJ
        wr1w5R7pF6/NLCYrtyRrdn7X5pW3I1iD1EYqMSun1NlWlVrgXW4g5P1KueJ0SyXCSrRPeI
        o7MctBUPzKFET8c1l/429EAQ+1XLyPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDGq2MehCOuWbouH8qY7t2f0w7/Wwz3YBeWZPEhcmus=;
        b=KDD3IkJ2LZ6OIyANkpCZUBsxLCPHiMTRkCgmpmhMnZP85FChGfQ/cBqTttbyvr6V2jaFPB
        d7Yl1bkS+hiOyUAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0DD9A2C141;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/11] serial: pic32: simplify clk handling
Date:   Tue,  3 May 2022 08:31:15 +0200
Message-Id: <20220503063122.20957-5-jslaby@suse.cz>
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

struct pic32_sport::ref_clk is only set, but not read. That means we can
remove it. And when we do so, pic32_enable_clock() and
pic32_disable_clock() are simple wrappers around clk_prepare_enable()
and clk_disable_unprepare() respectively. So we can remove the former
two from the code and replace it by the latter two.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 1e8ff6004e8e..42269e96b3f8 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -68,7 +68,6 @@ struct pic32_sport {
 	bool hw_flow_ctrl;
 	int cts_gpio;
 
-	int ref_clk;
 	struct clk *clk;
 
 	struct device *dev;
@@ -138,23 +137,6 @@ static inline void pic32_wait_deplete_txbuf(struct pic32_sport *sport)
 		udelay(1);
 }
 
-static inline int pic32_enable_clock(struct pic32_sport *sport)
-{
-	int ret = clk_prepare_enable(sport->clk);
-
-	if (ret)
-		return ret;
-
-	sport->ref_clk++;
-	return 0;
-}
-
-static inline void pic32_disable_clock(struct pic32_sport *sport)
-{
-	sport->ref_clk--;
-	clk_disable_unprepare(sport->clk);
-}
-
 /* serial core request to check if uart tx buffer is empty */
 static unsigned int pic32_uart_tx_empty(struct uart_port *port)
 {
@@ -491,7 +473,7 @@ static int pic32_uart_startup(struct uart_port *port)
 
 	local_irq_save(flags);
 
-	ret = pic32_enable_clock(sport);
+	ret = clk_prepare_enable(sport->clk);
 	if (ret) {
 		local_irq_restore(flags);
 		goto out_done;
@@ -611,7 +593,7 @@ static void pic32_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	pic32_uart_dsbl_and_mask(port);
 	spin_unlock_irqrestore(&port->lock, flags);
-	pic32_disable_clock(sport);
+	clk_disable_unprepare(sport->clk);
 
 	/* free all 3 interrupts for this UART */
 	free_irq(sport->irq_fault, port);
@@ -835,7 +817,7 @@ static int pic32_console_setup(struct console *co, char *options)
 		return -ENODEV;
 	port = pic32_get_port(sport);
 
-	ret = pic32_enable_clock(sport);
+	ret = clk_prepare_enable(sport->clk);
 	if (ret)
 		return ret;
 
@@ -965,7 +947,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
 		/* The peripheral clock has been enabled by console_setup,
 		 * so disable it till the port is used.
 		 */
-		pic32_disable_clock(sport);
+		clk_disable_unprepare(sport->clk);
 	}
 #endif
 
@@ -986,7 +968,7 @@ static int pic32_uart_remove(struct platform_device *pdev)
 	struct pic32_sport *sport = to_pic32_sport(port);
 
 	uart_remove_one_port(&pic32_uart_driver, port);
-	pic32_disable_clock(sport);
+	clk_disable_unprepare(sport->clk);
 	platform_set_drvdata(pdev, NULL);
 	pic32_sports[sport->idx] = NULL;
 
-- 
2.36.0

