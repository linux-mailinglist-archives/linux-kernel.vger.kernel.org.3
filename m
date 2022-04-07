Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333A4F79BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbiDGIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiDGIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:32:28 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B3152823;
        Thu,  7 Apr 2022 01:30:28 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 7 Apr 2022
 16:15:22 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH 1/3] tty: serial: meson: Use DIV_ROUND_CLOSEST to calculate baud rates
Date:   Thu, 7 Apr 2022 16:13:53 +0800
Message-ID: <20220407081355.13602-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220407081355.13602-1-yu.tu@amlogic.com>
References: <20220407081355.13602-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to chip process differences, chip designers recommend using baud
rates as close to and larger as possible in order to reduce clock
errors.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2bf1c57e0981..8e59624935af 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -299,10 +299,10 @@ static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
 		cpu_relax();
 
 	if (port->uartclk == 24000000) {
-		val = ((port->uartclk / 3) / baud) - 1;
+		val = DIV_ROUND_CLOSEST(port->uartclk / 3, baud) - 1;
 		val |= AML_UART_BAUD_XTAL;
 	} else {
-		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+		val =  DIV_ROUND_CLOSEST(port->uartclk / 4, baud) - 1;
 	}
 	val |= AML_UART_BAUD_USE;
 	writel(val, port->membase + AML_UART_REG5);
-- 
2.33.1

