Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D287259FD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiHXO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbiHXO3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:29:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451D10D0;
        Wed, 24 Aug 2022 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661351388; x=1692887388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p+lH+5Wlft7OPjVPOMmWKBVBb/o4houeAm+ShSEsIt0=;
  b=wqpAip+yeFY2/53mvk97BPGaCDl8Ikjrtdx47aVJoIRdqqBfV+D5ds70
   zD25NBY9SGBruptgFeBy/7upP5BCRb03tGG65eBRLXmoBw7kjplrY2s4H
   9EhcqLbusfWqFhfchVDaFeK9SH5Ug6iVRWVuNgJJV/Go4b+stGg5+oro/
   6vdVSEv5EZFWqYyBEYHLExXkVD33UEBzI+4RukzZmy8z73mpUkN7e2CVh
   K0uWXFxr+2B3oKiQKZg1pc6e60K4EiAAUbUu8UTxbp3u2O7hkrenph28o
   MJMyyVtCx5Qa7q3BSVdPH+zFc7A2/1q9rm7tr7jqwIeCqQV9OEI4bspap
   w==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="177706682"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 07:29:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 07:29:47 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 07:29:44 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <rmk+kernel@arm.linux.org.uk>, <claudio@evidence.eu.com>,
        <rick@efn.org>, <ryan@bluewatersys.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2] tty: serial: atmel: Preserve previous USART mode if RS485 disabled
Date:   Wed, 24 Aug 2022 17:29:03 +0300
Message-ID: <20220824142902.502596-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever the atmel_rs485_config() driver method would be called,
the USART mode is reset to normal mode before even checking if
RS485 flag is set, thus resulting in losing the previous USART
mode in the case where the checking fails.

Some tools, such as `linux-serial-test`, lead to the driver calling
this method when doing the setup of the serial port: after setting the
port mode (Hardware Flow Control, Normal Mode, RS485 Mode, etc.),
`linux-serial-test` tries to enable/disable RS485 depending on
the commandline arguments that were passed.

Example of how this issue could reveal itself:
When doing a serial communication with Hardware Flow Control through
`linux-serial-test`, the tool would lead to the driver roughly doing
the following:
- set the corresponding bit to 1 (ATMEL_US_USMODE_HWHS bit in the
ATMEL_US_MR register) through the atmel_set_termios() to enable
Hardware Flow Control
- disable RS485 through the atmel_config_rs485() method
Thus, when the latter is called, the mode will be reset and the
previously set bit is unset, leaving USART in normal mode instead of
the expected Hardware Flow Control mode.

This fix ensures that this reset is only done if the checking for
RS485 succeeds and that the previous mode is preserved otherwise.

Fixes: e8faff7330a35 ("ARM: 6092/1: atmel_serial: support for RS485 communications")
Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---


v1 -> v2:
- split commit message to slightly shorter bits such that it would
be easier to read
- add Reviewed-by tag



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

