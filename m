Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31FC5AEDBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiIFOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiIFOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:38:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F49A964;
        Tue,  6 Sep 2022 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662472857; x=1694008857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pk0hBeRzv9yrSvjx77z7pR8KMLbpypDtOQMtHWLcCCU=;
  b=OWPO9sIzkxP4jocz/tYqCEZPLZBqAyq6myzvB1OVIVjJN+6TmZhgdVBH
   uCGp7bXKA4cMtUf1S3g6cthOgsgMnpjpEqNV+xqVVCva96n3Hk6JROMxv
   UOleduYl7jCJ7jYwGEH7s3HgFoSef66iEN3cHXJrekfkbDoZ0b1mT4Xfh
   ylfBkPI8pAYIeWkXLrpYkvJUjpWM8LIPmVLSlm4RoWvB4nWp6YPKUNmOj
   KOWvK7xVqrs6MSGKfMyw57daMPKUT3CTuZG5bW+6dcnX8TaGIOIGTvcPl
   neJdUZz7k9+inxZjsLicfSRfCuh3zv2HyFKGOv4NEKx4InCS5DmRT6poh
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="175830165"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:57:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:57:26 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:57:21 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 10/13] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
Date:   Tue, 6 Sep 2022 16:55:09 +0300
Message-ID: <20220906135511.144725-11-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the driver only divides the clock divisor if the
IP handled at that point is USART, since UART IP's do not support
implicit peripheral clock division. Instead, in the case of UART,
go with the highest possible clock divisor.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before and is mainly meant as both cleanup
and as a way to introduce a new field into struct atmel_uart_port that will be
used by the last patch to diferentiate between USART and UART regarding the
location of the Baudrate Clock Source bitmask.




 drivers/tty/serial/atmel_serial.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7450d3853031..6aa01ca5489c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -150,6 +150,7 @@ struct atmel_uart_port {
 	u32			rts_low;
 	bool			ms_irq_enabled;
 	u32			rtor;	/* address of receiver timeout register if it exists */
+	bool			is_usart;
 	bool			has_frac_baudrate;
 	bool			has_hw_timer;
 	struct timer_list	uart_timer;
@@ -1825,6 +1826,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 	 */
 	atmel_port->has_frac_baudrate = false;
 	atmel_port->has_hw_timer = false;
+	atmel_port->is_usart = false;
 
 	if (name == new_uart) {
 		dev_dbg(port->dev, "Uart with hw timer");
@@ -1834,6 +1836,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 		dev_dbg(port->dev, "Usart\n");
 		atmel_port->has_frac_baudrate = true;
 		atmel_port->has_hw_timer = true;
+		atmel_port->is_usart = true;
 		atmel_port->rtor = ATMEL_US_RTOR;
 		version = atmel_uart_readl(port, ATMEL_US_VERSION);
 		switch (version) {
@@ -1863,6 +1866,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
+			atmel_port->is_usart = true;
 			atmel_port->rtor = ATMEL_US_RTOR;
 			break;
 		case 0x203:
@@ -2282,10 +2286,17 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		cd = uart_get_divisor(port, baud);
 	}
 
-	if (cd > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
+	/*
+	 * BRGR is 16-bit, so switch to slower clock.
+	 * Otherwise, keep the highest possible value for the clock divisor.
+	 */
+	if (atmel_port->is_usart && cd > 65535) {
 		cd /= 8;
 		mode |= ATMEL_US_USCLKS_MCK_DIV8;
+	} else {
+		cd &= 65535;
 	}
+
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
-- 
2.25.1

