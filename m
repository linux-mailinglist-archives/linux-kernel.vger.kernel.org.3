Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D484FB828
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbiDKJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344780AbiDKJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:51:14 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62EEF41FA8;
        Mon, 11 Apr 2022 02:48:35 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 446C1809F;
        Mon, 11 Apr 2022 09:45:38 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Matwey V . Kornilov" <matwey@sai.msu.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] serial: 8250: Fix runtime PM for start_tx() for RS485
Date:   Mon, 11 Apr 2022 12:48:04 +0300
Message-Id: <20220411094805.45696-1-tony@atomide.com>
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

The early return from serial8250_start_tx() added by commit e490c9144cfa
("tty: Add software emulated RS485 support for 8250") failed to call
serial8250_rpm_put_tx() that normally gets called on __stop_tx().

Likely this is a harmless issue as the RS485 using folks probably are not
using runtime PM for the serial ports.

Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1681,8 +1681,10 @@ static void serial8250_start_tx(struct uart_port *port)
 		return;
 
 	if (em485 &&
-	    em485->active_timer == &em485->start_tx_timer)
+	    em485->active_timer == &em485->start_tx_timer) {
+		serial8250_rpm_put_tx(up);
 		return;
+	}
 
 	if (em485)
 		start_tx_rs485(port);
-- 
2.35.1
