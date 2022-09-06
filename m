Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7C5AEDF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiIFOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiIFOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:47:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD89F0D2;
        Tue,  6 Sep 2022 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662473150; x=1694009150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73Fho7ppKG3cNkllUIc8oZOXuO1dn/FLBA9ZkmVxUtw=;
  b=fv0AJly9EEhcUvSSrHV9ix7WdBs60qegWJpjpYxkicG1wRsql9nLFoFr
   tJTrkjbgaQka18iEsv8AfCY6QuVVUXI2+jJJo03CoE8tTtQC3mB+izbh6
   4+fhkNv0sVURKWthwoHlBiGPtAzrJX1UKDFZKT3asHwpdYItmxWoCBXvH
   LbHsj6rSrHxu8I/ATrQRELYaAqN/1NCjmWOstIM3I6bAu1GQW9RCdAg8r
   WjMixDFu92ESHzwquEHZVuIVLqZZ1SjtVsVjhLQsKdMWDNbUqqdI/P9az
   YG+808Lzs14Z5wANJYA9LCPSvrY3sn6wkH0GOoxJ/9k77YmfeVhE/hJU/
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179351255"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:57:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:57:37 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:57:32 -0700
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
Subject: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of the existence of GCLK
Date:   Tue, 6 Sep 2022 16:55:11 +0300
Message-ID: <20220906135511.144725-13-sergiu.moga@microchip.com>
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

Previously, the atmel serial driver did not take into account the
possibility of using the more customizable generic clock as its
baudrate generator. Unless there is a Fractional Part available to
increase accuracy, there is a high chance that we may be able to
generate a baudrate closer to the desired one by using the GCLK as the
clock source. Now, depending on the error rate between
the desired baudrate and the actual baudrate, the serial driver will
fallback on the generic clock. The generic clock must be provided
in the DT node of the serial that may need a more flexible clock source.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---



v1 -> v2:
- take into account the different placement of the baudrate clock source
into the IP's Mode Register (USART vs UART)
- don't check for atmel_port->gclk != NULL
- use clk_round_rate instead of clk_set_rate + clk_get_rate
- remove clk_disable_unprepare from the end of the probe method



 drivers/tty/serial/atmel_serial.c | 52 ++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 6aa01ca5489c..b2b6fd6ea2a5 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/tty_flip.h>
@@ -77,6 +78,8 @@ static void atmel_stop_rx(struct uart_port *port);
 #endif
 
 #define ATMEL_ISR_PASS_LIMIT	256
+#define ERROR_RATE(desired_value, actual_value) \
+	((int)(100 - ((desired_value) * 100) / (actual_value)))
 
 struct atmel_dma_buffer {
 	unsigned char	*buf;
@@ -110,6 +113,7 @@ struct atmel_uart_char {
 struct atmel_uart_port {
 	struct uart_port	uart;		/* uart */
 	struct clk		*clk;		/* uart clock */
+	struct clk		*gclk;		/* uart generic clock */
 	int			may_wakeup;	/* cached value of device_may_wakeup for times we need to disable it */
 	u32			backup_imr;	/* IMR saved during suspend */
 	int			break_active;	/* break being received */
@@ -2117,6 +2121,8 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 		 * This is called on uart_close() or a suspend event.
 		 */
 		clk_disable_unprepare(atmel_port->clk);
+		if (__clk_is_enabled(atmel_port->gclk))
+			clk_disable_unprepare(atmel_port->gclk);
 		break;
 	default:
 		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
@@ -2131,7 +2137,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
-	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
+	unsigned int old_mode, mode, imr, quot, div, cd, fp = 0;
+	unsigned int baud, actual_baud, gclk_rate;
 
 	/* save the current mode register */
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
@@ -2297,6 +2304,43 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		cd &= 65535;
 	}
 
+	/*
+	 * If there is no Fractional Part, there is a high chance that
+	 * we may be able to generate a baudrate closer to the desired one
+	 * if we use the GCLK as the clock source driving the baudrate
+	 * generator.
+	 */
+	if (!atmel_port->has_frac_baudrate) {
+		if (__clk_is_enabled(atmel_port->gclk))
+			clk_disable_unprepare(atmel_port->gclk);
+		gclk_rate = clk_round_rate(atmel_port->gclk, 16 * baud);
+		actual_baud = clk_get_rate(atmel_port->clk) / (16 * cd);
+		if (gclk_rate && abs(ERROR_RATE(baud, actual_baud)) >
+		    abs(ERROR_RATE(baud, gclk_rate / 16))) {
+			clk_set_rate(atmel_port->gclk, 16 * baud);
+			if (!clk_prepare_enable(atmel_port->gclk)) {
+				if (atmel_port->is_usart) {
+					mode &= ~ATMEL_US_USCLKS;
+					mode |= ATMEL_US_USCLKS_GCLK;
+				} else {
+					mode &= ~ATMEL_UA_BRSRCCK;
+					mode |= ATMEL_UA_BRSRCCK_GCLK;
+				}
+
+				/*
+				 * Set the Clock Divisor for GCLK to 1.
+				 * Since we were able to generate the smallest
+				 * multiple of the desired baudrate times 16,
+				 * then we surely can generate a bigger multiple
+				 * with the exact error rate for an equally increased
+				 * CD. Thus no need to take into account
+				 * a higher value for CD.
+				 */
+				cd = 1;
+			}
+		}
+	}
+
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
@@ -2892,6 +2936,12 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	atmel_port->gclk = devm_clk_get_optional(&pdev->dev, "gclk");
+	if (IS_ERR(atmel_port->gclk)) {
+		ret = PTR_ERR(atmel_port->gclk);
+		goto err;
+	}
+
 	ret = atmel_init_port(atmel_port, pdev);
 	if (ret)
 		goto err_clk_disable_unprepare;
-- 
2.25.1

