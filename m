Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2494BC925
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbiBSP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:29:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbiBSP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:29:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244575D641;
        Sat, 19 Feb 2022 07:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4BE8B80968;
        Sat, 19 Feb 2022 15:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8C7C340EF;
        Sat, 19 Feb 2022 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645284515;
        bh=r3iqPCoANxpwhUGnTd+JNF0yIf5d3A5itF0q+px7HIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAS4vy5466az6eQ1Pqk0VeqKGk92+l2nyMfxbqgJjHRIoJScndcXCnCIySMhua7e+
         nBcbZDPwTh5C2ELBQod8QIoa77a5qRx53K+6GV5Hw14hgDbJuYAqjCzELSqt/C0Vr+
         ezTay4Z2icQUb+e8FfgPJPSZ1SJBQ5Pzq/haeOg4W4baApysYinOvgME0KLTLMAvl2
         /d5UEGMqpm4IsqjOppJXhq6BEJ1gHV1HdZZ+wi9/E+2a/Ktuqbl5i2gbIl19KIxhAe
         RHmMzHCYWIvXpIqxOf/J6VjUNWYOgFgHm4mMshjTJGhN0U3LHzaOGbM/7J8LXR8wS2
         NYnELHWMaHVmA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v9 5/6] serial: mvebu-uart: implement support for baudrates higher than 230400 Bd
Date:   Sat, 19 Feb 2022 16:28:17 +0100
Message-Id: <20220219152818.4319-6-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220219152818.4319-1-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Implement simple usage of fractional divisor. When main divisor D is too
large to represent requested baudrate then use divisor M from the
fractional divisor feature. All the M prescalers are set to the same and
maximal value 63, so the fractional part of the fractional divisor is not
used at all. We also determine upper limit for possible baudrates.

Experiments show that UART at baudrate 1500000 Bd with this configuration
is stable. So there is no need to implement complicated calculation of
fractional coefficients yet.

To use this feature with higher baudrates, it is required to use UART clock
provided by UART clock driver. Default boot xtal clock is not capable of
higher baudrates.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/tty/serial/mvebu-uart.c | 83 ++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 56278b29f5f5..2e9263888ddc 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -99,6 +99,7 @@
 #define UART_OSAMP		0x14
 #define  OSAMP_DEFAULT_DIVISOR	16
 #define  OSAMP_DIVISORS_MASK	0x3F3F3F3F
+#define  OSAMP_MAX_DIVISOR	63
 
 #define MVEBU_NR_UARTS		2
 
@@ -479,18 +480,60 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 		return -EOPNOTSUPP;
 
 	/*
-	 * The baudrate is derived from the UART clock thanks to two divisors:
-	 *   > D ("baud generator"): can divide the clock from 2 to 2^10 - 1.
-	 *   > M ("fractional divisor"): allows a better accuracy for
-	 *     baudrates higher than 230400.
+	 * The baudrate is derived from the UART clock thanks to divisors:
+	 *   > d1 * d2 ("TBG divisors"): can divide only TBG clock from 1 to 6
+	 *   > D ("baud generator"): can divide the clock from 1 to 1023
+	 *   > M ("fractional divisor"): allows a better accuracy (from 1 to 63)
 	 *
-	 * As the derivation of M is rather complicated, the code sticks to its
-	 * default value (x16) when all the prescalers are zeroed, and only
-	 * makes use of D to configure the desired baudrate.
+	 * Exact formulas for calculating baudrate:
+	 *
+	 * with default x16 scheme:
+	 *   baudrate = xtal / (d * 16)
+	 *   baudrate = tbg / (d1 * d2 * d * 16)
+	 *
+	 * with fractional divisor:
+	 *   baudrate = 10 * xtal / (d * (3 * (m1 + m2) + 2 * (m3 + m4)))
+	 *   baudrate = 10 * tbg / (d1*d2 * d * (3 * (m1 + m2) + 2 * (m3 + m4)))
+	 *
+	 * Oversampling value:
+	 *   osamp = (m1 << 0) | (m2 << 8) | (m3 << 16) | (m4 << 24);
+	 *
+	 * Where m1 controls number of clock cycles per bit for bits 1,2,3;
+	 * m2 for bits 4,5,6; m3 for bits 7,8 and m4 for bits 9,10.
+	 *
+	 * To simplify baudrate setup set all the M prescalers to the same
+	 * value. For baudrates 9600 Bd and higher, it is enough to use the
+	 * default (x16) divisor or fractional divisor with M = 63, so there
+	 * is no need to use real fractional support (where the M prescalers
+	 * are not equal).
+	 *
+	 * When all the M prescalers are zeroed then default (x16) divisor is
+	 * used. Default x16 scheme is more stable than M (fractional divisor),
+	 * so use M only when D divisor is not enough to derive baudrate.
+	 *
+	 * Member port->uartclk is either xtal clock rate or TBG clock rate
+	 * divided by (d1 * d2). So d1 and d2 are already set by the UART clock
+	 * driver (and UART driver itself cannot change them). Moreover they are
+	 * shared between both UARTs.
 	 */
+
 	m_divisor = OSAMP_DEFAULT_DIVISOR;
 	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
 
+	if (d_divisor > BRDV_BAUD_MAX) {
+		/*
+		 * Experiments show that small M divisors are unstable.
+		 * Use maximal possible M = 63 and calculate D divisor.
+		 */
+		m_divisor = OSAMP_MAX_DIVISOR;
+		d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
+	}
+
+	if (d_divisor < 1)
+		d_divisor = 1;
+	else if (d_divisor > BRDV_BAUD_MAX)
+		d_divisor = BRDV_BAUD_MAX;
+
 	spin_lock_irqsave(&mvebu_uart_lock, flags);
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
@@ -500,6 +543,9 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 
 	osamp = readl(port->membase + UART_OSAMP);
 	osamp &= ~OSAMP_DIVISORS_MASK;
+	if (m_divisor != OSAMP_DEFAULT_DIVISOR)
+		osamp |= (m_divisor << 0) | (m_divisor << 8) |
+			(m_divisor << 16) | (m_divisor << 24);
 	writel(osamp, port->membase + UART_OSAMP);
 
 	return 0;
@@ -529,14 +575,16 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		port->ignore_status_mask |= STAT_RX_RDY(port) | STAT_BRK_ERR;
 
 	/*
-	 * Maximal divisor is 1023 * 16 when using default (x16) scheme.
-	 * Maximum achievable frequency with simple baudrate divisor is 230400.
-	 * Since the error per bit frame would be of more than 15%, achieving
-	 * higher frequencies would require to implement the fractional divisor
-	 * feature.
+	 * Maximal divisor is 1023 and maximal fractional divisor is 63. And
+	 * experiments show that baudrates above 1/80 of parent clock rate are
+	 * not stable. So disallow baudrates above 1/80 of the parent clock
+	 * rate. If port->uartclk is not available, then
+	 * mvebu_uart_baud_rate_set() fails, so values min_baud and max_baud
+	 * in this case do not matter.
 	 */
-	min_baud = DIV_ROUND_UP(port->uartclk, 1023 * 16);
-	max_baud = 230400;
+	min_baud = DIV_ROUND_UP(port->uartclk, BRDV_BAUD_MAX *
+				OSAMP_MAX_DIVISOR);
+	max_baud = port->uartclk / 80;
 
 	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
 	if (mvebu_uart_baud_rate_set(port, baud)) {
@@ -1395,14 +1443,14 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 			 * Calculate the smallest TBG d1 and d2 divisors that
 			 * still can provide 9600 baudrate.
 			 */
-			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_MAX_DIVISOR *
 					  BRDV_BAUD_MAX);
 			if (d1 < 1)
 				d1 = 1;
 			else if (d1 > CLK_TBG_DIV1_MAX)
 				d1 = CLK_TBG_DIV1_MAX;
 
-			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_MAX_DIVISOR *
 					  BRDV_BAUD_MAX * d1);
 			if (d2 < 1)
 				d2 = 1;
@@ -1417,8 +1465,7 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 		}
 
 		/* Skip clock source which cannot provide 9600 baudrate */
-		if (rate > 9600 * OSAMP_DEFAULT_DIVISOR * BRDV_BAUD_MAX * d1 *
-			   d2)
+		if (rate > 9600 * OSAMP_MAX_DIVISOR * BRDV_BAUD_MAX * d1 * d2)
 			continue;
 
 		/*
-- 
2.34.1

