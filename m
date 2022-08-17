Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF5596AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiHQID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiHQIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:03:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB12239B85;
        Wed, 17 Aug 2022 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660723413; x=1692259413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Pv7hkZ6hWMmBycZ4+WnhfRT5RtAh4O9ymOlESkLyAQ=;
  b=el0TvXszO1vTR/oJ4s3T7tAyOfh1G7cxN23l/qhLRconxkhmU+GjsnqG
   r10We7N5ZkQCB3Blm7q5LlEaeacyDSvP2nP+zIA5nXBw83oX9HbkGBrdc
   mal3sUly/xz4ef14ry4+aeN5JoXS2TGOCXQ0QeOlbqLPTW221GzBQ3UoT
   Ymfr6jYb5ouY1xU2IoEue8bNYJMqr9Nw9Hh5b32iRDT+adcm55MzE3Mma
   V7zDyixCVn3i192NO1oi2h/sOWti5ePFc15793g+bXlp1S6Y6i3ZiKBo8
   rM97qwGtQ3dRlWnDlmGNmzWGNeaoGsYxiBxRXxxhYFQ4QiYOR19taKWiM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="109399692"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 01:03:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 01:03:27 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 01:03:23 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 5/5] tty: serial: atmel: Make the driver aware of the existence of GCLK
Date:   Wed, 17 Aug 2022 10:55:18 +0300
Message-ID: <20220817075517.49575-6-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817075517.49575-1-sergiu.moga@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
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
 drivers/tty/serial/atmel_serial.c | 52 ++++++++++++++++++++++++++++++-
 drivers/tty/serial/atmel_serial.h |  1 +
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 30ba9eef7b39..0a0b46ee0955 100644
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
@@ -2115,6 +2119,8 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 		 * This is called on uart_close() or a suspend event.
 		 */
 		clk_disable_unprepare(atmel_port->clk);
+		if (atmel_port->gclk && __clk_is_enabled(atmel_port->gclk))
+			clk_disable_unprepare(atmel_port->gclk);
 		break;
 	default:
 		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
@@ -2129,7 +2135,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
-	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
+	unsigned int old_mode, mode, imr, quot, div, cd, fp = 0;
+	unsigned int baud, actual_baud, gclk_rate;
 
 	/* save the current mode register */
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
@@ -2288,6 +2295,37 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		cd /= 8;
 		mode |= ATMEL_US_USCLKS_MCK_DIV8;
 	}
+
+	/*
+	 * If there is no Fractional Part, there is a high chance that
+	 * we may be able to generate a baudrate closer to the desired one
+	 * if we use the GCLK as the clock source driving the baudrate
+	 * generator.
+	 */
+	if (!fp && atmel_port->gclk) {
+		if (__clk_is_enabled(atmel_port->gclk))
+			clk_disable_unprepare(atmel_port->gclk);
+		clk_set_rate(atmel_port->gclk, 16 * baud);
+		gclk_rate = clk_get_rate(atmel_port->gclk);
+		actual_baud = clk_get_rate(atmel_port->clk) / (16 * cd);
+		if (abs(ERROR_RATE(baud, actual_baud)) >
+		    abs(ERROR_RATE(baud, gclk_rate / 16))) {
+			mode |= ATMEL_US_GCLK;
+
+			/*
+			 * Set the Clock Divisor for GCLK to 1.
+			 * Since we were able to generate the smallest
+			 * multiple of the desired baudrate times 16,
+			 * then we surely can generate a bigger multiple
+			 * with the exact error rate for an equally increased
+			 * CD. Thus no need to take into account
+			 * a higher value for CD.
+			 */
+			cd = 1;
+			clk_prepare_enable(atmel_port->gclk);
+		}
+	}
+
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
@@ -2883,6 +2921,16 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	atmel_port->gclk = devm_clk_get_optional(&pdev->dev, "gclk");
+	if (atmel_port->gclk) {
+		ret = clk_prepare_enable(atmel_port->gclk);
+		if (ret) {
+			atmel_port->gclk = NULL;
+			return ret;
+		}
+		clk_disable_unprepare(atmel_port->gclk);
+	}
+
 	ret = atmel_init_port(atmel_port, pdev);
 	if (ret)
 		goto err_clk_disable_unprepare;
@@ -2929,6 +2977,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	 * is used
 	 */
 	clk_disable_unprepare(atmel_port->clk);
+	if (atmel_port->gclk && __clk_is_enabled(atmel_port->gclk))
+		clk_disable_unprepare(atmel_port->gclk);
 
 	return 0;
 
diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index 0d8a0f9cc5c3..fb718972f81a 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -63,6 +63,7 @@
 #define		ATMEL_US_PAR_MARK		(3 <<  9)
 #define		ATMEL_US_PAR_NONE		(4 <<  9)
 #define		ATMEL_US_PAR_MULTI_DROP		(6 <<  9)
+#define ATMEL_US_GCLK                          BIT(12)
 #define	ATMEL_US_NBSTOP		GENMASK(13, 12)	/* Number of Stop Bits */
 #define		ATMEL_US_NBSTOP_1		(0 << 12)
 #define		ATMEL_US_NBSTOP_1_5		(1 << 12)
-- 
2.25.1

