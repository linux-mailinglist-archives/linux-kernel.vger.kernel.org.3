Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB19595B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiHPMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiHPMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:13:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E4B44;
        Tue, 16 Aug 2022 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651707; x=1692187707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RDrxEWvz7k6Dum1EVZKsL+hLIXjBY4xQVpMumbMEgZM=;
  b=CF2T9cD3xxt0H1FsyGQ80jhmqfqnDhLXdRERqXUp4u4JwH89WvR30laz
   Eev6aTyWxBtBroue760PAgQFS5hMs4FUSA+3Pl83VQbkgC8twClFD7cy5
   1N4HxjufeFCJSAvIH71KCV6D4a5DfH0KfbkuDopriGOASb7S0rucZbXD9
   eIeEcCZE8sniw6BmNtYWwusGPthR74pPlK6CMNpzz///8eTc+/AdkW3na
   4A3aAha7Qrrr9QlcZnu+Jv2izlVhJH6SKTdLuPAQSv8Shm9B9VLP6OHhm
   ngM4aYJP2uXUN0AAdAheCgnpcUghpJpsN0p8EqMx0erPhrvIrlAQhwggh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356201199"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="356201199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:08:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="635864826"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:08:24 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] serial: 8250: Add helper for clearing IER
Date:   Tue, 16 Aug 2022 15:07:59 +0300
Message-Id: <20220816120759.11552-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of places want to clear IER with the same CAP_UUE trick.
Create a helper for that.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..25e4761e3c57 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -752,6 +752,14 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
+static void serial8250_clear_IER(struct uart_8250_port *up)
+{
+	if (up->capabilities & UART_CAP_UUE)
+		serial_out(up, UART_IER, UART_IER_UUE);
+	else
+		serial_out(up, UART_IER, 0);
+}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
@@ -1329,10 +1337,7 @@ static void autoconfig(struct uart_8250_port *up)
 	serial8250_out_MCR(up, save_mcr);
 	serial8250_clear_fifos(up);
 	serial_in(up, UART_RX);
-	if (up->capabilities & UART_CAP_UUE)
-		serial_out(up, UART_IER, UART_IER_UUE);
-	else
-		serial_out(up, UART_IER, 0);
+	serial8250_clear_IER(up);
 
 out_unlock:
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -2142,10 +2147,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	First save the IER then disable the interrupts
 	 */
 	ier = serial_port_in(port, UART_IER);
-	if (up->capabilities & UART_CAP_UUE)
-		serial_port_out(port, UART_IER, UART_IER_UUE);
-	else
-		serial_port_out(port, UART_IER, 0);
+	serial8250_clear_IER(up);
 
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	/*
@@ -3383,11 +3385,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	First save the IER then disable the interrupts
 	 */
 	ier = serial_port_in(port, UART_IER);
-
-	if (up->capabilities & UART_CAP_UUE)
-		serial_port_out(port, UART_IER, UART_IER_UUE);
-	else
-		serial_port_out(port, UART_IER, 0);
+	serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
-- 
2.30.2

