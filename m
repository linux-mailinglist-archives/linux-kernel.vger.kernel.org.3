Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90954FBAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbiDKLTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiDKLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:19:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9121B427CF;
        Mon, 11 Apr 2022 04:17:01 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4E7CB809F;
        Mon, 11 Apr 2022 11:14:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCHv2] serial: 8250: Fix runtime PM for start_tx() for empty buffer
Date:   Mon, 11 Apr 2022 14:16:57 +0300
Message-Id: <20220411111657.16744-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 932d596378b0 ("serial: 8250: Return early in .start_tx() if there
are no chars to send") caused a regression where the drivers implementing
runtime PM stopped idling. This is because serial8250_rpm_put_tx() is now
unbalanced on early return, it normally gets called at __stop_tx().

Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there are no chars to send")
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:

- Call serial8250_rpm_get_tx() only after buffer empty test as suggested
  by Uwe and Johan

- Drop RS885 related patch for now, it needs to be investigated further

---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1675,11 +1675,11 @@ static void serial8250_start_tx(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct uart_8250_em485 *em485 = up->em485;
 
-	serial8250_rpm_get_tx(up);
-
 	if (!port->x_char && uart_circ_empty(&port->state->xmit))
 		return;
 
+	serial8250_rpm_get_tx(up);
+
 	if (em485 &&
 	    em485->active_timer == &em485->start_tx_timer)
 		return;
-- 
2.35.1
