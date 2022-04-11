Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1D4FB82C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbiDKJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbiDKJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:51:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23C084160B;
        Mon, 11 Apr 2022 02:48:38 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3556C8191;
        Mon, 11 Apr 2022 09:45:42 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH 2/2] serial: 8250: Fix runtime PM for start_tx() for empty buffer
Date:   Mon, 11 Apr 2022 12:48:05 +0300
Message-Id: <20220411094805.45696-2-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411094805.45696-1-tony@atomide.com>
References: <20220411094805.45696-1-tony@atomide.com>
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
runtime PM stopped idling.

We need to call serial8250_rpm_put_tx() on early exit, it normally gets
called later on at __stop_tx().

Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there are no chars to send")
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1677,8 +1677,10 @@ static void serial8250_start_tx(struct uart_port *port)
 
 	serial8250_rpm_get_tx(up);
 
-	if (!port->x_char && uart_circ_empty(&port->state->xmit))
+	if (!port->x_char && uart_circ_empty(&port->state->xmit)) {
+		serial8250_rpm_put_tx(up);
 		return;
+	}
 
 	if (em485 &&
 	    em485->active_timer == &em485->start_tx_timer) {
-- 
2.35.1
