Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA1458B8A1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiHFW4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiHFW4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 18:56:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA1DEB4;
        Sat,  6 Aug 2022 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659826598; x=1691362598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=54Anbbn6Cj+F7ysZBgdGDOr16hp2SIvOS2pyuVWJSck=;
  b=YYaXj/HMemD+DmYIH/esPXI42sYiiFq26tzP3jDbBIl1kVnJS1fRlwy6
   7f/nlr5fMNlYu0kf/8lmZOb1vCg4/8V7IWHTkYeVJbSPJumsdEaB3BDz8
   N/7ObhaP5/tsuGsd+S9/TAJ2WrZoqE8WwxJ5+j3xu4NoIivxXRsOuxDA3
   EoeKKkOoACgz2sm3F/CpaxUcOrXWp6cOc/bno6FdaVA9pykhzc8jtq5r3
   4OMoFG4tXarn9pTbssuYBUHAcUqbxsiqvDwekyscwGiZUuXIh7xpRJ38t
   R9u8J2CSkEhi34ciJM5aO8l3AldoEHoOyNwhgtJP/tK0XUJRz8tvtqi93
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="354395437"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="354395437"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 15:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="672063681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2022 15:56:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 821941AA; Sun,  7 Aug 2022 01:56:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] serial: pic32_uart: Convert to use GPIO descriptors
Date:   Sun,  7 Aug 2022 01:56:43 +0300
Message-Id: <20220806225643.40897-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806225643.40897-1-andriy.shevchenko@linux.intel.com>
References: <20220806225643.40897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plain global GPIO numbering schema is deprecated and is being removed
from the kernel. Convert this driver to use a new GPIO descriptor based
schema.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pic32_uart.c | 48 +++++++++------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 1562c2a48467..56516a72d661 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -50,7 +50,7 @@
  * @irq_rx_name: irq rx name
  * @irq_tx: virtual tx interrupt number
  * @irq_tx_name: irq tx name
- * @cts_gpio: clear to send gpio
+ * @cts_gpiod: clear to send GPIO
  * @dev: device descriptor
  **/
 struct pic32_sport {
@@ -65,8 +65,7 @@ struct pic32_sport {
 	const char *irq_tx_name;
 	bool enable_tx_irq;
 
-	bool hw_flow_ctrl;
-	int cts_gpio;
+	struct gpio_desc *cts_gpiod;
 
 	struct clk *clk;
 
@@ -158,25 +157,16 @@ static void pic32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 					PIC32_UART_MODE_LPBK);
 }
 
-/* get the state of CTS input pin for this port */
-static unsigned int get_cts_state(struct pic32_sport *sport)
-{
-	/* read and invert UxCTS */
-	if (gpio_is_valid(sport->cts_gpio))
-		return !gpio_get_value(sport->cts_gpio);
-
-	return 1;
-}
-
 /* serial core request to return the state of misc UART input pins */
 static unsigned int pic32_uart_get_mctrl(struct uart_port *port)
 {
 	struct pic32_sport *sport = to_pic32_sport(port);
 	unsigned int mctrl = 0;
 
-	if (!sport->hw_flow_ctrl)
+	/* get the state of CTS input pin for this port */
+	if (!sport->cts_gpiod)
 		mctrl |= TIOCM_CTS;
-	else if (get_cts_state(sport))
+	else if (gpiod_get_value(sport->cts_gpiod))
 		mctrl |= TIOCM_CTS;
 
 	/* DSR and CD are not supported in PIC32, so return 1
@@ -648,7 +638,7 @@ static void pic32_uart_set_termios(struct uart_port *port,
 					PIC32_UART_MODE_PDSEL0);
 	}
 	/* if hw flow ctrl, then the pins must be specified in device tree */
-	if ((new->c_cflag & CRTSCTS) && sport->hw_flow_ctrl) {
+	if ((new->c_cflag & CRTSCTS) && sport->cts_gpiod) {
 		/* enable hardware flow control */
 		pic32_uart_writel(sport, PIC32_SET(PIC32_UART_MODE),
 					PIC32_UART_MODE_UEN1);
@@ -875,7 +865,8 @@ static struct uart_driver pic32_uart_driver = {
 
 static int pic32_uart_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct pic32_sport *sport;
 	int uart_idx = 0;
 	struct resource *res_mem;
@@ -904,25 +895,10 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	/* Hardware flow control: gpios
 	 * !Note: Basically, CTS is needed for reading the status.
 	 */
-	sport->hw_flow_ctrl = false;
-	sport->cts_gpio = of_get_named_gpio(np, "cts-gpios", 0);
-	if (gpio_is_valid(sport->cts_gpio)) {
-		sport->hw_flow_ctrl = true;
-
-		ret = devm_gpio_request(sport->dev,
-					sport->cts_gpio, "CTS");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"error requesting CTS GPIO\n");
-			goto err;
-		}
-
-		ret = gpio_direction_input(sport->cts_gpio);
-		if (ret) {
-			dev_err(&pdev->dev, "error setting CTS GPIO\n");
-			goto err;
-		}
-	}
+	sport->cts_gpiod = devm_gpiod_get_optional(dev, "cts", GPIOD_IN);
+	if (IS_ERR(sport->cts_gpiod))
+		return dev_err_probe(dev, PTR_ERR(sport->cts_gpiod), "error requesting CTS GPIO\n");
+	gpiod_set_consumer_name(sport->cts_gpiod, "CTS");
 
 	pic32_sports[uart_idx] = sport;
 	port = &sport->port;
-- 
2.35.1

