Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2097481624
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhL2TID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhL2TIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:08:02 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:08:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94AE9232E74;
        Wed, 29 Dec 2021 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1640804876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=z1RrlpZD1OUJk8/CuRjFiQW+xhieZiR36fLMaxbt75g=;
        b=wk8b2gGBOcR03ER20eyAWPd6iK9sQMMbamcWSjb9E9V6E+O3DSGNIo/0d5bhJ9vposLpm2
        4yDwCz2/eTtLId4NOyvV0qp8Bz0aZI6gnvcvcatrzCyTtM61AxR9p6jUMR56AozXhfHThR
        6ZVmuqghHlDaTaU0H/DRsI4ScPlTpm/711ctgy7Y0jD+DXRTKTR/TCusZFYUR8CQBs2MAv
        KsPI2vIA1qvw/KZNjlIVoO3GnkCxGg+XbQfseqzHKyGtLqZYUqvGWGjvwEHcCYIt1va21Q
        /WmRvZjV+eH8pvPeZN/SDPlXy+phVB0p/QlmP+WUJ7tAU72JYHN3hfIkjrAwqg==
Message-ID: <fca61771-3b0d-d306-39bf-7b271dc148d9@lexina.in>
Date:   Wed, 29 Dec 2021 22:07:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V2 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
Content-Language: ru
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20211229135350.9659-1-yu.tu@amlogic.com>
 <20211229135350.9659-5-yu.tu@amlogic.com>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <20211229135350.9659-5-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



29.12.2021 16:53, Yu Tu пишет:
> Using the common Clock code to describe the UART baud rate clock makes
> it easier for the UART driver to be compatible with the baud rate
> requirements of the UART IP on different meson chips
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/Kconfig      |   1 +
>   drivers/tty/serial/meson_uart.c | 303 ++++++++++++++++++++++++++------
>   2 files changed, 249 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 780908d43557..32e238173036 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -198,6 +198,7 @@ config SERIAL_KGDB_NMI
>   config SERIAL_MESON
>   	tristate "Meson serial port support"
>   	depends on ARCH_MESON
> +	depends on COMMON_CLK
>   	select SERIAL_CORE
>   	help
>   	  This enables the driver for the on-chip UARTs of the Amlogic
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 99efe62a1507..9b07e3534969 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/console.h>
>   #include <linux/delay.h>
>   #include <linux/init.h>
> @@ -65,9 +66,7 @@
>   #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>   
>   /* AML_UART_REG5 bits */
> -#define AML_UART_BAUD_MASK		0x7fffff
>   #define AML_UART_BAUD_USE		BIT(23)
> -#define AML_UART_BAUD_XTAL		BIT(24)
>   
>   #define AML_UART_PORT_NUM		12
>   #define AML_UART_PORT_OFFSET		6
> @@ -76,6 +75,21 @@
>   #define AML_UART_POLL_USEC		5
>   #define AML_UART_TIMEOUT_USEC		10000
>   
> +struct meson_uart_data {
> +	struct uart_port	port;
> +	struct clk		*pclk;
> +	struct clk		*baud_clk;
> +	struct clk_divider	baud_div;
> +	struct clk_mux		use_xtal_mux;
> +	struct clk_mux		xtal_clk_sel_mux;
> +	struct clk_mux		xtal2_clk_sel_mux;
> +	struct clk_fixed_factor	xtal_div2;
> +	struct clk_fixed_factor	xtal_div3;
> +	struct clk_fixed_factor	clk81_div4;
> +	bool			no_clk81_input;
> +	bool			has_xtal_clk_sel;
> +};
> +
>   static struct uart_driver meson_uart_driver;
>   
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> @@ -270,14 +284,11 @@ static void meson_uart_reset(struct uart_port *port)
>   static int meson_uart_startup(struct uart_port *port)
>   {
>   	u32 val;
> -	int ret = 0;
> +	int ret;
>   
> -	val = readl(port->membase + AML_UART_CONTROL);
> -	val |= AML_UART_CLEAR_ERR;
> -	writel(val, port->membase + AML_UART_CONTROL);
> -	val &= ~AML_UART_CLEAR_ERR;
> -	writel(val, port->membase + AML_UART_CONTROL);
> +	meson_uart_reset(port);
>   
> +	val = readl(port->membase + AML_UART_CONTROL);
>   	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
>   	writel(val, port->membase + AML_UART_CONTROL);
>   
> @@ -295,19 +306,17 @@ static int meson_uart_startup(struct uart_port *port)
>   
>   static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>   {
> +	struct meson_uart_data *private_data = port->private_data;
>   	u32 val;
>   
>   	while (!meson_uart_tx_empty(port))
>   		cpu_relax();
>   
> -	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> -	} else {
> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> -	}
> +	val = readl(port->membase + AML_UART_REG5);
>   	val |= AML_UART_BAUD_USE;
>   	writel(val, port->membase + AML_UART_REG5);
> +
> +	clk_set_rate(private_data->baud_clk, baud);
>   }
>   
>   static void meson_uart_set_termios(struct uart_port *port,
> @@ -397,11 +406,27 @@ static int meson_uart_verify_port(struct uart_port *port,
>   
>   static void meson_uart_release_port(struct uart_port *port)
>   {
> -	/* nothing to do */
> +	struct meson_uart_data *private_data = port->private_data;
> +
> +	clk_disable_unprepare(private_data->baud_clk);
> +	clk_disable_unprepare(private_data->pclk);
>   }
>   
>   static int meson_uart_request_port(struct uart_port *port)
>   {
> +	struct meson_uart_data *private_data = port->private_data;
> +	int ret;
> +
> +	ret = clk_prepare_enable(private_data->pclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(private_data->baud_clk);
> +	if (ret) {
> +		clk_disable_unprepare(private_data->pclk);
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -629,56 +654,175 @@ static struct uart_driver meson_uart_driver = {
>   	.cons		= MESON_SERIAL_CONSOLE,
>   };
>   
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> +static int meson_uart_register_clk(struct uart_port *port,
> +				   const char *name_suffix,
> +				   const struct clk_parent_data *parent_data,
> +				   unsigned int num_parents,
> +				   const struct clk_ops *ops,
> +				   struct clk_hw *hw)
>   {
> -	struct clk *clk = NULL;
> +	struct clk_init_data init = { };
> +	char clk_name[32];
>   	int ret;
>   
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 name_suffix);
>   
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> -	}
> +	init.name = clk_name;
> +	init.ops = ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_data = parent_data;
> +	init.num_parents = num_parents;
> +
> +	hw->init = &init;
>   
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> +	ret = devm_clk_hw_register(port->dev, hw);
> +	if (ret)
> +		return dev_err_probe(port->dev, ret,
> +				     "Failed to register the '%s' clock\n",
> +				     clk_name);
>   
> -	return clk;
> +	return ret;
>   }
>   
> -static int meson_uart_probe_clocks(struct platform_device *pdev,
> -				   struct uart_port *port)
> -{
> -	struct clk *clk_xtal = NULL;
> -	struct clk *clk_pclk = NULL;
> -	struct clk *clk_baud = NULL;
> +static int meson_uart_probe_clocks(struct uart_port *port,
> +				   bool register_clk81_div4)
> +{
> +	struct meson_uart_data *private_data = port->private_data;
> +	struct clk_parent_data use_xtal_mux_parents[2] = {
> +		{ .index = -1, },
> +		{ .index = -1, },
> +	};
> +	struct clk_parent_data xtal_clk_sel_mux_parents[2] = { };
> +	struct clk_parent_data xtal2_clk_sel_mux_parents[2] = { };
> +	struct clk_parent_data xtal_div_parent = { .fw_name = "xtal", };
> +	struct clk_parent_data clk81_div_parent = { .fw_name = "baud", };
> +	struct clk_parent_data baud_div_parent = { };
> +	struct clk *clk_baud, *clk_xtal;
> +	int ret;
>   
> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
> -	if (IS_ERR(clk_pclk))
> -		return PTR_ERR(clk_pclk);
> +	private_data->pclk = devm_clk_get(port->dev, "pclk");
> +	if (IS_ERR(private_data->pclk))
> +		return dev_err_probe(port->dev, PTR_ERR(private_data->pclk),
> +				     "Failed to get the 'pclk' clock\n");
> +
> +	clk_baud = devm_clk_get(port->dev, "baud");
> +	if (IS_ERR(clk_baud))
> +		return dev_err_probe(port->dev, PTR_ERR(clk_baud),
> +				     "Failed to get the 'baud' clock\n");
>   
> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>   	if (IS_ERR(clk_xtal))
> -		return PTR_ERR(clk_xtal);
> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
> +				     "Failed to get the 'xtal' clock\n");
> +
> +	private_data->xtal_div3.mult = 1;
> +	private_data->xtal_div3.div = 3;
> +	ret = meson_uart_register_clk(port, "xtal_div3", &xtal_div_parent,
> +				      1, &clk_fixed_factor_ops,
> +				      &private_data->xtal_div3.hw);
> +	if (ret)
> +		return ret;
>   
> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
> -	if (IS_ERR(clk_baud))
> -		return PTR_ERR(clk_baud);
> +	if (register_clk81_div4) {
> +		private_data->clk81_div4.mult = 1;
> +		private_data->clk81_div4.div = 4;
> +		ret = meson_uart_register_clk(port, "clk81_div4",
> +					      &clk81_div_parent, 1,
> +					      &clk_fixed_factor_ops,
> +					      &private_data->clk81_div4.hw);
> +		if (ret)
> +			return ret;
> +
> +		use_xtal_mux_parents[0].hw = &private_data->clk81_div4.hw;
> +	}
>   
> -	port->uartclk = clk_get_rate(clk_baud);
> +	if (private_data->has_xtal_clk_sel) {
> +		private_data->xtal_div2.mult = 1;
> +		private_data->xtal_div2.div = 2;
> +		ret = meson_uart_register_clk(port, "xtal_div2",
> +					      &xtal_div_parent, 1,
> +					      &clk_fixed_factor_ops,
> +					      &private_data->xtal_div2.hw);
> +		if (ret)
> +			return ret;
> +
> +		xtal_clk_sel_mux_parents[0].hw = &private_data->xtal_div3.hw;
> +		xtal_clk_sel_mux_parents[1].fw_name = "xtal";
> +
> +		private_data->xtal_clk_sel_mux.reg = port->membase + AML_UART_REG5;
> +		private_data->xtal_clk_sel_mux.mask = 0x1;
> +		private_data->xtal_clk_sel_mux.shift = 26;
> +		private_data->xtal_clk_sel_mux.flags = CLK_MUX_ROUND_CLOSEST;
> +		ret = meson_uart_register_clk(port, "xtal_clk_sel",
> +					      xtal_clk_sel_mux_parents,
> +					      ARRAY_SIZE(xtal_clk_sel_mux_parents),
> +					      &clk_mux_ops,
> +					      &private_data->xtal_clk_sel_mux.hw);
> +		if (ret)
> +			return ret;
> +
> +		xtal2_clk_sel_mux_parents[0].hw = &private_data->xtal_clk_sel_mux.hw;
> +		xtal2_clk_sel_mux_parents[1].hw = &private_data->xtal_div2.hw;
> +
> +		private_data->xtal2_clk_sel_mux.reg = port->membase + AML_UART_REG5;
> +		private_data->xtal2_clk_sel_mux.mask = 0x1;
> +		private_data->xtal2_clk_sel_mux.shift = 27;
> +		private_data->xtal2_clk_sel_mux.flags = CLK_MUX_ROUND_CLOSEST;
> +		ret = meson_uart_register_clk(port, "xtal2_clk_sel",
> +					      xtal2_clk_sel_mux_parents,
> +					      ARRAY_SIZE(xtal2_clk_sel_mux_parents),
> +					      &clk_mux_ops,
> +					      &private_data->xtal2_clk_sel_mux.hw);
> +		if (ret)
> +			return ret;
> +
> +		use_xtal_mux_parents[1].hw = &private_data->xtal2_clk_sel_mux.hw;
> +	} else {
> +		use_xtal_mux_parents[1].hw = &private_data->xtal_div3.hw;
> +	}
> +
> +	private_data->use_xtal_mux.reg = port->membase + AML_UART_REG5;
> +	private_data->use_xtal_mux.mask = 0x1;
> +	private_data->use_xtal_mux.shift = 24;
> +	private_data->use_xtal_mux.flags = CLK_MUX_ROUND_CLOSEST;
> +	ret = meson_uart_register_clk(port, "use_xtal", use_xtal_mux_parents,
> +				      ARRAY_SIZE(use_xtal_mux_parents),
> +				      &clk_mux_ops,
> +				      &private_data->use_xtal_mux.hw);
> +	if (ret)
> +		return ret;
> +
> +	baud_div_parent.hw = &private_data->use_xtal_mux.hw;
> +
> +	private_data->baud_div.reg = port->membase + AML_UART_REG5;
> +	private_data->baud_div.shift = 0;
> +	private_data->baud_div.width = 23;
> +	private_data->baud_div.flags = CLK_DIVIDER_ROUND_CLOSEST;
> +	ret = meson_uart_register_clk(port, "baud_div",
> +				      &baud_div_parent, 1,
> +				      &clk_divider_ops,
> +				      &private_data->baud_div.hw);
> +	if (ret)
> +		return ret;
> +
> +	private_data->baud_clk = devm_clk_hw_get_clk(port->dev,
> +						     &private_data->baud_div.hw,
> +						     "baud_rate");
> +	if (IS_ERR(private_data->baud_clk))
> +		return dev_err_probe(port->dev,
> +				     PTR_ERR(private_data->baud_clk),
> +				     "Failed to request the 'baud_rate' clock\n");
>   
>   	return 0;
>   }
>   
>   static int meson_uart_probe(struct platform_device *pdev)
>   {
> +	struct meson_uart_data *private_data;
>   	struct resource *res_mem, *res_irq;
> +	struct clk *clk_baud, *clk_xtal;
> +	bool register_clk81_div4;
>   	struct uart_port *port;
>   	int ret = 0;
>   	int id = -1;
> @@ -711,18 +855,37 @@ static int meson_uart_probe(struct platform_device *pdev)
>   		return -EBUSY;
>   	}
>   
> -	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
> -	if (!port)
> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
> +				    GFP_KERNEL);
> +	if (!private_data)
>   		return -ENOMEM;
>   
> +	if (device_get_match_data(&pdev->dev))
> +		private_data->has_xtal_clk_sel = true;
> +
> +	private_data->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(private_data->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(private_data->pclk),
> +				     "Failed to get the 'pclk' clock\n");
> +
> +	clk_baud = devm_clk_get(&pdev->dev, "baud");
> +	if (IS_ERR(clk_baud))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk_baud),
> +				     "Failed to get the 'baud' clock\n");
> +
> +	clk_xtal = devm_clk_get(&pdev->dev, "xtal");
> +	if (IS_ERR(clk_xtal))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk_xtal),
> +				     "Failed to get the 'xtal' clock\n");
> +
> +	register_clk81_div4 = clk_get_rate(clk_xtal) != clk_get_rate(clk_baud);
> +
> +	port = &private_data->port;
> +
>   	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
>   	if (IS_ERR(port->membase))
>   		return PTR_ERR(port->membase);
>   
> -	ret = meson_uart_probe_clocks(pdev, port);
> -	if (ret)
> -		return ret;
> -
>   	port->iotype = UPIO_MEM;
>   	port->mapbase = res_mem->start;
>   	port->mapsize = resource_size(res_mem);
> @@ -735,6 +898,12 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	port->x_char = 0;
>   	port->ops = &meson_uart_ops;
>   	port->fifosize = 64;
> +	port->uartclk = clk_get_rate(clk_baud);
> +	port->private_data = private_data;
> +
> +	ret = meson_uart_probe_clocks(port, register_clk81_div4);
> +	if (ret)
> +		return ret;
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);
> @@ -761,10 +930,34 @@ static int meson_uart_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id meson_uart_dt_match[] = {
> -	{ .compatible = "amlogic,meson6-uart" },
> -	{ .compatible = "amlogic,meson8-uart" },
> -	{ .compatible = "amlogic,meson8b-uart" },
> -	{ .compatible = "amlogic,meson-gx-uart" },

You can't drop used item without patch for dts files.

arch/arm64/boot/dts/amlogic$ grep amlogic,meson-gx-uart *|wc -l
16

> +	{
> +		.compatible = "amlogic,meson6-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson8-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson8b-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxl-uart",
> +		.data = (void *)true,
> +	},
> +	{
> +		.compatible = "amlogic,meson-g12a-uart",
> +		.data = (void *)true,
> +	},
> +	{
> +		.compatible = "amlogic,meson-s4-uart",
> +		.data = (void *)true,
> +	},
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
