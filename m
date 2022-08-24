Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23A59F8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiHXLs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiHXLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:48:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93154857CD;
        Wed, 24 Aug 2022 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661341702; x=1692877702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MZDAJgikHNjzvh5Y3euMJ9onTXF+3A93fahuugd7kik=;
  b=Yu2zKcZesyumT/T3xMsL8cWwAGseMgPbSbKOjbd3BW0ugdbJsbZSfqEu
   wfQsYJd5wlNeXVjas8j2Bj4XUv+x0BpZznAc3jNivUKJ66+/3zXIPJD3Z
   2ygimufaUWQII1k+8BwLykIu6mpYn535WM7XffmNApDFvnI2pQcCE+A3i
   lFcAlmI0Y+bhdcOvKDqBuBE0/gpgkl6eTNDuQ/pvIyfvjtJxg+yuz0R8J
   590iPf3BoU3AYjOqlnstT8Ti9b/wXY0xKvEedVKSqvPdN1wXkoSmTmmy+
   kqG4Fz14zePD/kO+lzoh38GHLB82cFXAdMkq3bNKzcsjWEXxd+cWLmS24
   A==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="170713015"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 04:48:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 04:48:20 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 04:48:17 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <rmk+kernel@arm.linux.org.uk>, <claudio@evidence.eu.com>,
        <rick@efn.org>, <michael@evidence.eu.com>, <ryan@bluewatersys.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH] tty: serial: atmel: Preserve previous USART mode if RS485 disabled
Date:   Wed, 24 Aug 2022 14:42:57 +0300
Message-ID: <20220824114255.444655-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever the atmel_rs485_config driver method would be called,
the USART mode is reset to normal mode before even checking if
RS485 flag is set, thus resulting in losing the previous USART
mode in the case where the checking fails. Some tools, such as
`linux-serial-test`, lead to the driver calling this method
when doing the setup of the serial port: after setting the port
mode (Hardware Flow Control, Normal Mode, RS485 Mode, etc.),
`linux-serial-test` tries to enable/disable RS485 depending on
the commandline arguments passed. If we were to, for example, enable
Hardware Flow Control through `linux-serial-test`, the tool would
make the driver set the corresponding bit to 1 (ATMEL_US_USMODE_HWHS
bit in the ATMEL_US_MR register) through the atmel_set_termios method
and then proceed to disabling RS485. This, in turn, causes the
ATMEL_US_USMODE_HWHS bit of the ATMEL_US_MR mode register to be unset
and, if the checking for RS485 fails, leads to having the mode set
back to the ATMEL_US_USMODE_NORMAL normal mode. Since in hardware
flow control mode the meanings of the ATMEL_US_RTSDIS and
ATMEL_US_RTSEN bits are swapped, this leads to our endpoint leaving
the RTS line to high when wanting to receive, which is the opposite
of what the other endpoint is expecting in order to start transmitting.
This fix ensures that this reset is done only if the checking for RS485
succeeds.

Fixes: e8faff7330a35 ("ARM: 6092/1: atmel_serial: support for RS485 communications")
Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0a0b46ee0955..c29b1fb48694 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -298,9 +298,6 @@ static int atmel_config_rs485(struct uart_port *port, struct ktermios *termios,
 
 	mode = atmel_uart_readl(port, ATMEL_US_MR);
 
-	/* Resetting serial mode to RS232 (0x0) */
-	mode &= ~ATMEL_US_USMODE;
-
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		if (rs485conf->flags & SER_RS485_RX_DURING_TX)
@@ -310,6 +307,7 @@ static int atmel_config_rs485(struct uart_port *port, struct ktermios *termios,
 
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  rs485conf->delay_rts_after_send);
+		mode &= ~ATMEL_US_USMODE;
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
-- 
2.25.1

