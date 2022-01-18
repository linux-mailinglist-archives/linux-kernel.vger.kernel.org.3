Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD175491D32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356383AbiARD1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:27:06 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:19715 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355316AbiARDLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:11:30 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 18 Jan 2022
 11:09:56 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V6 3/5] tty: serial: meson: Describes the calculation of the UART baud rate clock using a clock frame
Date:   Tue, 18 Jan 2022 11:09:09 +0800
Message-ID: <20220118030911.12815-4-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118030911.12815-1-yu.tu@amlogic.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the common Clock code to describe the UART baud rate clock
makes it easier for the UART driver to be compatible with the
baud rate requirements of the UART IP on different meson chips.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 195 +++++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 53 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 7570958d010c..92fa91c825e6 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -65,9 +66,7 @@
 #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
 
 /* AML_UART_REG5 bits */
-#define AML_UART_BAUD_MASK		0x7fffff
 #define AML_UART_BAUD_USE		BIT(23)
-#define AML_UART_BAUD_XTAL		BIT(24)
 
 #define AML_UART_PORT_NUM		12
 #define AML_UART_PORT_OFFSET		6
@@ -76,6 +75,11 @@
 #define AML_UART_POLL_USEC		5
 #define AML_UART_TIMEOUT_USEC		10000
 
+struct meson_uart_data {
+	struct clk	*baud_clk;
+	bool		use_xtal_clk;
+};
+
 static struct uart_driver meson_uart_driver;
 
 static struct uart_port *meson_ports[AML_UART_PORT_NUM];
@@ -293,19 +297,17 @@ static int meson_uart_startup(struct uart_port *port)
 
 static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
 {
+	struct meson_uart_data *private_data = port->private_data;
 	u32 val;
 
 	while (!meson_uart_tx_empty(port))
 		cpu_relax();
 
-	if (port->uartclk == 24000000) {
-		val = ((port->uartclk / 3) / baud) - 1;
-		val |= AML_UART_BAUD_XTAL;
-	} else {
-		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
-	}
+	val = readl(port->membase + AML_UART_REG5);
 	val |= AML_UART_BAUD_USE;
 	writel(val, port->membase + AML_UART_REG5);
+
+	clk_set_rate(private_data->baud_clk, baud);
 }
 
 static void meson_uart_set_termios(struct uart_port *port,
@@ -395,11 +397,20 @@ static int meson_uart_verify_port(struct uart_port *port,
 
 static void meson_uart_release_port(struct uart_port *port)
 {
-	/* nothing to do */
+	struct meson_uart_data *private_data = port->private_data;
+
+	clk_disable_unprepare(private_data->baud_clk);
 }
 
 static int meson_uart_request_port(struct uart_port *port)
 {
+	struct meson_uart_data *private_data = port->private_data;
+	int ret;
+
+	ret = clk_prepare_enable(private_data->baud_clk);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -629,57 +640,105 @@ static struct uart_driver meson_uart_driver = {
 	.cons		= MESON_SERIAL_CONSOLE,
 };
 
-static inline struct clk *meson_uart_probe_clock(struct device *dev,
-						 const char *id)
-{
-	struct clk *clk = NULL;
-	int ret;
-
-	clk = devm_clk_get(dev, id);
-	if (IS_ERR(clk))
-		return clk;
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "couldn't enable clk\n");
-		return ERR_PTR(ret);
-	}
-
-	devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			clk);
-
-	return clk;
-}
+static struct clk_div_table xtal_div_table[] = {
+	{0, 3},
+	{1, 1},
+	{2, 2},
+	{3, 2},
+};
 
-static int meson_uart_probe_clocks(struct platform_device *pdev,
-				   struct uart_port *port)
+static int meson_uart_probe_clocks(struct uart_port *port)
 {
-	struct clk *clk_xtal = NULL;
-	struct clk *clk_pclk = NULL;
-	struct clk *clk_baud = NULL;
+	struct meson_uart_data *private_data = port->private_data;
+	struct clk *clk_baud, *clk_xtal;
+	struct clk_hw *hw;
+	char clk_name[32];
+	struct clk_parent_data use_xtal_mux_parents[2] = {
+		{ .index = -1, },
+		{ .index = -1, },
+	};
 
-	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
-	if (IS_ERR(clk_pclk))
-		return PTR_ERR(clk_pclk);
+	clk_baud = devm_clk_get(port->dev, "baud");
+	if (IS_ERR(clk_baud)) {
+		dev_err(port->dev, "Failed to get the 'baud' clock\n");
+		return PTR_ERR(clk_baud);
+	}
 
-	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
+	clk_xtal = devm_clk_get(port->dev, "xtal");
 	if (IS_ERR(clk_xtal))
-		return PTR_ERR(clk_xtal);
-
-	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
-	if (IS_ERR(clk_baud))
-		return PTR_ERR(clk_baud);
+		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
+				     "Failed to get the 'xtal' clock\n");
+
+	if (private_data->use_xtal_clk) {
+		snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
+			 "xtal_div");
+		hw = devm_clk_hw_register_divider_table(port->dev,
+							clk_name,
+							__clk_get_name(clk_baud),
+							CLK_SET_RATE_NO_REPARENT,
+							port->membase + AML_UART_REG5,
+							26, 2,
+							CLK_DIVIDER_READ_ONLY,
+							xtal_div_table, NULL);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		use_xtal_mux_parents[1].hw = hw;
+	} else {
+		snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
+			 "clk81_div4");
+		hw = devm_clk_hw_register_fixed_factor(port->dev,
+						       clk_name,
+						       __clk_get_name(clk_baud),
+						       CLK_SET_RATE_NO_REPARENT,
+						       1, 4);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		use_xtal_mux_parents[0].hw = hw;
+	}
 
-	port->uartclk = clk_get_rate(clk_baud);
+	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
+		 "use_xtal");
+	hw = __devm_clk_hw_register_mux(port->dev, NULL,
+					clk_name,
+					ARRAY_SIZE(use_xtal_mux_parents),
+					NULL, NULL,
+					use_xtal_mux_parents,
+					CLK_SET_RATE_PARENT,
+					port->membase + AML_UART_REG5,
+					24, 0x1,
+					CLK_MUX_READ_ONLY,
+					NULL, NULL);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	port->uartclk = clk_hw_get_rate(hw);
+
+	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
+		 "baud_div");
+	hw = devm_clk_hw_register_divider(port->dev,
+					  clk_name,
+					  clk_hw_get_name(hw),
+					  CLK_SET_RATE_PARENT,
+					  port->membase + AML_UART_REG5,
+					  0, 23,
+					  CLK_DIVIDER_ROUND_CLOSEST,
+					  NULL);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	private_data->baud_clk = hw->clk;
 
 	return 0;
 }
 
 static int meson_uart_probe(struct platform_device *pdev)
 {
+	struct meson_uart_data *private_data;
 	struct resource *res_mem;
 	struct uart_port *port;
+	struct clk *pclk;
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int irq;
@@ -705,6 +764,15 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_mem)
 		return -ENODEV;
 
+	pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
+				     "Failed to get the 'pclk' clock\n");
+
+	ret = clk_prepare_enable(pclk);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -724,9 +792,13 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 
-	ret = meson_uart_probe_clocks(pdev, port);
-	if (ret)
-		return ret;
+	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
+				    GFP_KERNEL);
+	if (!private_data)
+		return -ENOMEM;
+
+	if (device_get_match_data(&pdev->dev))
+		private_data->use_xtal_clk = true;
 
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
@@ -740,6 +812,11 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
 	port->fifosize = fifosize;
+	port->private_data = private_data;
+
+	ret = meson_uart_probe_clocks(port);
+	if (ret)
+		return ret;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
@@ -766,10 +843,22 @@ static int meson_uart_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id meson_uart_dt_match[] = {
-	{ .compatible = "amlogic,meson6-uart" },
-	{ .compatible = "amlogic,meson8-uart" },
-	{ .compatible = "amlogic,meson8b-uart" },
-	{ .compatible = "amlogic,meson-gx-uart" },
+	{
+		.compatible = "amlogic,meson6-uart",
+		.data = (void *)false,
+	},
+	{
+		.compatible = "amlogic,meson8-uart",
+		.data = (void *)false,
+	},
+	{
+		.compatible = "amlogic,meson8b-uart",
+		.data = (void *)false,
+	},
+	{
+		.compatible = "amlogic,meson-gx-uart",
+		.data = (void *)true,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
-- 
2.33.1

