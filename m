Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184E52CDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiESH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiESH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:56:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1302377EC;
        Thu, 19 May 2022 00:56:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 862FD1F9E1;
        Thu, 19 May 2022 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652947014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXHY8JVWrJXbjkxIlODH6Ln+qVUsnqrb5wJPAMkjwV0=;
        b=Vh8riL80coyXN59zIPICaLEe6JlUNIsDlXsYGl1hkaD9Ji2l3XhmzOijdxB3ZFODqLHqmj
        L1FLDZ6uOuuTPEGEo1fqiiJMSZw8OdYA+JpiuQzPa9rCQBe1Jm+lFbg07mqJAsXNlucg2z
        Gkx1qBo8drOewZdpYqF8qDBGBYwB3KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652947014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXHY8JVWrJXbjkxIlODH6Ln+qVUsnqrb5wJPAMkjwV0=;
        b=rV6IEgozOOHPLh8Du81MyQvm7sB8XktoUySMnsKbq7nHmdgHkkkCfEYgaxzfuUeca8UPAT
        eiZADluWcZbnfMAA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B39E2C141;
        Thu, 19 May 2022 07:56:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] serial: pmac_zilog: remove tracing prints
Date:   Thu, 19 May 2022 09:56:52 +0200
Message-Id: <20220519075653.31356-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519075653.31356-1-jslaby@suse.cz>
References: <20220519075653.31356-1-jslaby@suse.cz>
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

Remove debug printouts upon function enter/exit. This can be achieved
better by tracing.

Remove also the one protected by DEBUG_HARD which is not defined anyway.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pmac_zilog.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 9a2150bf477a..c6961f299f3b 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -24,7 +24,6 @@
  */
 
 #undef DEBUG
-#undef DEBUG_HARD
 #undef USE_CTRL_O_SYSRQ
 
 #include <linux/module.h>
@@ -442,9 +441,6 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
 	spin_lock(&uap_a->port.lock);
 	r3 = read_zsreg(uap_a, R3);
 
-#ifdef DEBUG_HARD
-	pmz_debug("irq, r3: %x\n", r3);
-#endif
 	/* Channel A */
 	push = false;
 	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
@@ -609,8 +605,6 @@ static void pmz_start_tx(struct uart_port *port)
 	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char status;
 
-	pmz_debug("pmz: start_tx()\n");
-
 	uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
 	uap->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
 
@@ -632,7 +626,7 @@ static void pmz_start_tx(struct uart_port *port)
 		struct circ_buf *xmit = &port->state->xmit;
 
 		if (uart_circ_empty(xmit))
-			goto out;
+			return;
 		write_zsdata(uap, xmit->buf[xmit->tail]);
 		zssync(uap);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -641,8 +635,6 @@ static void pmz_start_tx(struct uart_port *port)
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 			uart_write_wakeup(&uap->port);
 	}
- out:
-	pmz_debug("pmz: start_tx() done.\n");
 }
 
 /* 
@@ -655,13 +647,9 @@ static void pmz_stop_rx(struct uart_port *port)
 {
 	struct uart_pmac_port *uap = to_pmz(port);
 
-	pmz_debug("pmz: stop_rx()()\n");
-
 	/* Disable all RX interrupts.  */
 	uap->curregs[R1] &= ~RxINT_MASK;
 	pmz_maybe_update_regs(uap);
-
-	pmz_debug("pmz: stop_rx() done.\n");
 }
 
 /* 
@@ -906,8 +894,6 @@ static int pmz_startup(struct uart_port *port)
 	unsigned long flags;
 	int pwr_delay = 0;
 
-	pmz_debug("pmz: startup()\n");
-
 	uap->flags |= PMACZILOG_FLAG_IS_OPEN;
 
 	/* A console is never powered down. Else, power up and
@@ -943,8 +929,6 @@ static int pmz_startup(struct uart_port *port)
 	pmz_interrupt_control(uap, 1);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	pmz_debug("pmz: startup() done.\n");
-
 	return 0;
 }
 
@@ -953,8 +937,6 @@ static void pmz_shutdown(struct uart_port *port)
 	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned long flags;
 
-	pmz_debug("pmz: shutdown()\n");
-
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupt requests for the channel */
@@ -983,8 +965,6 @@ static void pmz_shutdown(struct uart_port *port)
 		pmz_set_scc_power(uap, 0);	/* Shut the chip down */
 
 	spin_unlock_irqrestore(&port->lock, flags);
-
-	pmz_debug("pmz: shutdown() done.\n");
 }
 
 /* Shared by TTY driver and serial console setup.  The port lock is held
@@ -1229,8 +1209,6 @@ static void __pmz_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned long baud;
 
-	pmz_debug("pmz: set_termios()\n");
-
 	/* XXX Check which revs of machines actually allow 1 and 4Mb speeds
 	 * on the IR dongle. Note that the IRTTY driver currently doesn't know
 	 * about the FIR mode and high speed modes. So these are unused. For
@@ -1264,8 +1242,6 @@ static void __pmz_set_termios(struct uart_port *port, struct ktermios *termios,
 		pmz_maybe_update_regs(uap);
 	}
 	uart_update_timeout(port, termios->c_cflag, baud);
-
-	pmz_debug("pmz: set_termios() done.\n");
 }
 
 /* The port lock is not held.  */
-- 
2.36.1

