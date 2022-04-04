Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175464F0F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377369AbiDDFx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377383AbiDDFxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:53:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2717C326F6;
        Sun,  3 Apr 2022 22:51:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 913F11F383;
        Mon,  4 Apr 2022 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649051483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fj+wd/2v6FRkr034Acv8LZELXHqGPrWGbj+tFgFbubY=;
        b=kaOgw6HGtvpDqeWH1CKjqQSi72DzrDVnoF0CU0UPZCWT+QQk5UOrMBokL0Cgka8ERVtZjj
        877I1qwDxQTVgsRC4IVE2UmU2+sJrkD6NpzSOVCppOQ8kOon32713rD6+VNTIx2rtvR/Ew
        nQQ/KTOILjB3Rmh8jgBCWofXDqNlv5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649051483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fj+wd/2v6FRkr034Acv8LZELXHqGPrWGbj+tFgFbubY=;
        b=27WJJ7igCjs3DXe7ttPbMZkzDZsf7bC3ueDeKiASacGR5LNYofIYb5e4rLTM/rjIhMNllA
        jzRyDzTO8KbZlYAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 583A1A3B82;
        Mon,  4 Apr 2022 05:51:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned, part II.
Date:   Mon,  4 Apr 2022 07:51:22 +0200
Message-Id: <20220404055122.31194-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
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

The below commit changed types of some hooks in struct psc_ops. It also
changed the types of the functions which are referenced in the instances
of the above struct.

However the commit did so only for CONFIG_PPC_MPC52xx, but not for
CONFIG_PPC_MPC512x. This results in build errors like:
  mpc52xx_uart.c:static unsigned int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
  mpc52xx_uart.c:static int mpc512x_psc_raw_tx_rdy(struct uart_port *port)
                        ^^^
  mpc52xx_uart.c:static int mpc5125_psc_raw_tx_rdy(struct uart_port *port)
                        ^^^

Therefore, fix the latter case now too.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 18662a1d8f35 (tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mpc52xx_uart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 8a6958377764..3acc0f185762 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -436,31 +436,31 @@ static void mpc512x_psc_fifo_init(struct uart_port *port)
 	out_be32(&FIFO_512x(port)->rximr, MPC512x_PSC_FIFO_ALARM);
 }
 
-static int mpc512x_psc_raw_rx_rdy(struct uart_port *port)
+static unsigned int mpc512x_psc_raw_rx_rdy(struct uart_port *port)
 {
 	return !(in_be32(&FIFO_512x(port)->rxsr) & MPC512x_PSC_FIFO_EMPTY);
 }
 
-static int mpc512x_psc_raw_tx_rdy(struct uart_port *port)
+static unsigned int mpc512x_psc_raw_tx_rdy(struct uart_port *port)
 {
 	return !(in_be32(&FIFO_512x(port)->txsr) & MPC512x_PSC_FIFO_FULL);
 }
 
-static int mpc512x_psc_rx_rdy(struct uart_port *port)
+static unsigned int mpc512x_psc_rx_rdy(struct uart_port *port)
 {
 	return in_be32(&FIFO_512x(port)->rxsr)
 	    & in_be32(&FIFO_512x(port)->rximr)
 	    & MPC512x_PSC_FIFO_ALARM;
 }
 
-static int mpc512x_psc_tx_rdy(struct uart_port *port)
+static unsigned int mpc512x_psc_tx_rdy(struct uart_port *port)
 {
 	return in_be32(&FIFO_512x(port)->txsr)
 	    & in_be32(&FIFO_512x(port)->tximr)
 	    & MPC512x_PSC_FIFO_ALARM;
 }
 
-static int mpc512x_psc_tx_empty(struct uart_port *port)
+static unsigned int mpc512x_psc_tx_empty(struct uart_port *port)
 {
 	return in_be32(&FIFO_512x(port)->txsr)
 	    & MPC512x_PSC_FIFO_EMPTY;
@@ -780,29 +780,29 @@ static void mpc5125_psc_fifo_init(struct uart_port *port)
 	out_be32(&FIFO_5125(port)->rximr, MPC512x_PSC_FIFO_ALARM);
 }
 
-static int mpc5125_psc_raw_rx_rdy(struct uart_port *port)
+static unsigned int mpc5125_psc_raw_rx_rdy(struct uart_port *port)
 {
 	return !(in_be32(&FIFO_5125(port)->rxsr) & MPC512x_PSC_FIFO_EMPTY);
 }
 
-static int mpc5125_psc_raw_tx_rdy(struct uart_port *port)
+static unsigned int mpc5125_psc_raw_tx_rdy(struct uart_port *port)
 {
 	return !(in_be32(&FIFO_5125(port)->txsr) & MPC512x_PSC_FIFO_FULL);
 }
 
-static int mpc5125_psc_rx_rdy(struct uart_port *port)
+static unsigned int mpc5125_psc_rx_rdy(struct uart_port *port)
 {
 	return in_be32(&FIFO_5125(port)->rxsr) &
 	       in_be32(&FIFO_5125(port)->rximr) & MPC512x_PSC_FIFO_ALARM;
 }
 
-static int mpc5125_psc_tx_rdy(struct uart_port *port)
+static unsigned int mpc5125_psc_tx_rdy(struct uart_port *port)
 {
 	return in_be32(&FIFO_5125(port)->txsr) &
 	       in_be32(&FIFO_5125(port)->tximr) & MPC512x_PSC_FIFO_ALARM;
 }
 
-static int mpc5125_psc_tx_empty(struct uart_port *port)
+static unsigned int mpc5125_psc_tx_empty(struct uart_port *port)
 {
 	return in_be32(&FIFO_5125(port)->txsr) & MPC512x_PSC_FIFO_EMPTY;
 }
-- 
2.35.1

