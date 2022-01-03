Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA1483192
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiACNrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiACNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:47:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33DC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 05:47:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c66so21443993wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=SZdE5ojwobFzdDbmRtpX6ZlyhQPZHLmasbCPTGrgQN8=;
        b=bmhYToDsIhQ6mTtSN5i0uOj+dFe1uQ5gVqoR2rDfQS+xTgptGBlNZjRJdW7gPuKeYs
         QJnZ9PQaO8dDXxbTFYRemOqjnWQ9YxsW3hDm5iFNARyq7XoD/iph87NsbnqtW4bwx3iI
         dRysMks7ftDMxtqVFP8/Snep4icWoBommF/081T/tJ3QaT7ZNIwrqQ90+491sMFRvpJ2
         S64OsSuaUk7TPTrOf+xK355U71lLz+7oniuE4DqNKbZaTwEItysW8+Lt9TTXrzQivrJI
         4KszJMad4DhF3SWNKEEfXyryJ7y1vKK73Q8jD57bbqVunzFHvrB8+eG9taXYWdH2Y93b
         QTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=SZdE5ojwobFzdDbmRtpX6ZlyhQPZHLmasbCPTGrgQN8=;
        b=04dAtDDViBiYvfWsBPkwXO4hqxBo3+EdnDyXjyCf7RIQPW7zxPYxUj3/IukGPI30Wf
         ga47NkArCraDbcKRcwe+qzs4OnnUHqVfb0kOlDwvvBUKOZxhqM5X1d0644NpVhleNxNC
         pa3likTsoC5qwOVXIItlOxWCDY4wSJtoCFMEzrCf34s0nnwDwKBYiDyKsO/p//Lyjowp
         FeVnhcoeJxhirL13eODUXPSvNRhqh3t3RfIg4Z9AwkiHV5SMuOiDRNbZdEOdYf/wyJ6j
         kxKQx+x33Vk/apB0tUyeKllp901bM3wXHZ5fJe621xEkiUFYUXgEic3SWI/mC9A5gR03
         QA3Q==
X-Gm-Message-State: AOAM53226AwX6219qMVdTimY0R4AqQrBRXlU5bswxxwOHntzuiSUsZ4o
        7k5z3UnLYIdyimpbrtdc1hKY/w==
X-Google-Smtp-Source: ABdhPJwk0+u6uuXqJvaIcCLfBrae/3H3Pod3HrNK/XQYfIuJveMZNj0ZiV7bFXjuHr/GwpsTEmEtCQ==
X-Received: by 2002:a05:600c:643:: with SMTP id p3mr38370954wmm.130.1641217635685;
        Mon, 03 Jan 2022 05:47:15 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l16sm39426298wrx.117.2022.01.03.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:47:15 -0800 (PST)
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate
 calculation is described using the common clock code. Also added S4 chip
 uart Compatible.
Date:   Mon, 03 Jan 2022 13:40:28 +0100
In-reply-to: <20211230102110.3861-5-yu.tu@amlogic.com>
Message-ID: <1jfsq57wym.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 30 Dec 2021 at 18:21, Yu Tu <yu.tu@amlogic.com> wrote:

> Using the common Clock code to describe the UART baud rate clock makes
> it easier for the UART driver to be compatible with the baud rate
> requirements of the UART IP on different meson chips
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/Kconfig      |   1 +
>  drivers/tty/serial/meson_uart.c | 311 ++++++++++++++++++++++++++------
>  2 files changed, 257 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 780908d43557..32e238173036 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -198,6 +198,7 @@ config SERIAL_KGDB_NMI
>  config SERIAL_MESON
>  	tristate "Meson serial port support"
>  	depends on ARCH_MESON
> +	depends on COMMON_CLK
>  	select SERIAL_CORE
>  	help
>  	  This enables the driver for the on-chip UARTs of the Amlogic
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 99efe62a1507..07eb1f40aaaa 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/console.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
> @@ -65,9 +66,7 @@
>  #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>  
>  /* AML_UART_REG5 bits */
> -#define AML_UART_BAUD_MASK		0x7fffff
>  #define AML_UART_BAUD_USE		BIT(23)
> -#define AML_UART_BAUD_XTAL		BIT(24)
>  
>  #define AML_UART_PORT_NUM		12
>  #define AML_UART_PORT_OFFSET		6
> @@ -76,6 +75,21 @@
>  #define AML_UART_POLL_USEC		5
>  #define AML_UART_TIMEOUT_USEC		10000
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

Keeping all these internal elements around is not useful since they are
registered using devm_

> +	bool			no_clk81_input;

What is this ?

> +	bool			has_xtal_clk_sel;
> +};
> +
>  static struct uart_driver meson_uart_driver;
>  
>  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> @@ -270,14 +284,11 @@ static void meson_uart_reset(struct uart_port *port)
>  static int meson_uart_startup(struct uart_port *port)
>  {
>  	u32 val;
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
>  	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
>  	writel(val, port->membase + AML_UART_CONTROL);
>  
> @@ -295,19 +306,17 @@ static int meson_uart_startup(struct uart_port *port)
>  
>  static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>  {
> +	struct meson_uart_data *private_data = port->private_data;
>  	u32 val;
>  
>  	while (!meson_uart_tx_empty(port))
>  		cpu_relax();
>  
> -	if (port->uartclk == 24000000) {

This check shows that previous code assumed bit 24 was left untouched
Below you can see that GXBB and newer used the XTAL path while older
used the other

Your change makes this dynamic which is another "unexpected" change.
Please make the bit 24 mux RO to start with so the behavior remains unchanged
for older SoCs.

> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> -	} else {
> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> -	}
> +	val = readl(port->membase + AML_UART_REG5);
>  	val |= AML_UART_BAUD_USE;
>  	writel(val, port->membase + AML_UART_REG5);
> +
> +	clk_set_rate(private_data->baud_clk, baud);
>  }
>  
>  static void meson_uart_set_termios(struct uart_port *port,
> @@ -397,11 +406,27 @@ static int meson_uart_verify_port(struct uart_port *port,
>  
>  static void meson_uart_release_port(struct uart_port *port)
>  {
> -	/* nothing to do */
> +	struct meson_uart_data *private_data = port->private_data;
> +
> +	clk_disable_unprepare(private_data->baud_clk);
> +	clk_disable_unprepare(private_data->pclk);
>  }
>  
>  static int meson_uart_request_port(struct uart_port *port)
>  {
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
>  	return 0;
>  }
>  
> @@ -629,56 +654,175 @@ static struct uart_driver meson_uart_driver = {
>  	.cons		= MESON_SERIAL_CONSOLE,
>  };
>  
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> +static int meson_uart_register_clk(struct uart_port *port,
> +				   const char *name_suffix,
> +				   const struct clk_parent_data *parent_data,
> +				   unsigned int num_parents,
> +				   const struct clk_ops *ops,
> +				   struct clk_hw *hw)
>  {
> -	struct clk *clk = NULL;
> +	struct clk_init_data init = { };
> +	char clk_name[32];
>  	int ret;
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
>  }
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
>  	if (IS_ERR(clk_xtal))
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

Clock dividers represent HW elements. The presence of an HW element cannot
dependent on the current of the input clocks. There is no way this is right

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

This is only going to be used on meson8 and older. Worst case it should depend
on this compatible but I don't think this would be right here.

IMO, this shows that the UART "baud" input was actually fed by a
derivation of "fclk_div4" instead of "clk_81" on these older SoCs.

So instead of registering what I suspect to be a fake element, the
meson8 clock controller driver and DT should be fixed a this should go away.

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

Well the above is a bit over-complicated. If I summarize: 

GXBB and older used a fixed divider of 3. Bits 26 and 27 read
0 according to the documentation.

Chips after GXBB have 2 configurable divider of 2 and 3. bits 26 and 27
selects which of these dividers is used.

So the above could be replaced with a single divider covering bits 26 and 27
with the following divider table { 2, 2, 1, 3 }. The divider should use
RO ops and not have CLK_SET_RATE_PARENT. It can be used for all chips
variant like this, including the older ones.

The only information you need to carry if whether or not you want to
make this divider modifiable. This means using the dt data to store
clk_div_ops or clk_div_ro_ops pointer.

To avoid changing the behavior of the older platforms in this patch, I would
suggest to make everything use clk_div_ro_ops first, and make another
patch to use clk_div_ops if necessary.


> +	}
> +
> +	private_data->use_xtal_mux.reg = port->membase + AML_UART_REG5;
> +	private_data->use_xtal_mux.mask = 0x1;
> +	private_data->use_xtal_mux.shift = 24;
> +	private_data->use_xtal_mux.flags = CLK_MUX_ROUND_CLOSEST;
> +	ret = meson_uart_register_clk(port, "use_xtal", use_xtal_mux_parents,
> +				      ARRAY_SIZE(use_xtal_mux_parents),
> +				      &clk_mux_ops,

Use RO ops here to start with.
You can make this writable with another patch explicitly describing the change.

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

There is a problem with this function in CCF. It will pin the driver to
itself, making it unremovable. It is an ongoing topic. For now, just use
"hw->clk" to get the struct *clk.

> +	if (IS_ERR(private_data->baud_clk))
> +		return dev_err_probe(port->dev,

I don't think anything can defer here, so dev_err_probe() is not
necessary I think

> +				     PTR_ERR(private_data->baud_clk),
> +				     "Failed to request the 'baud_rate' clock\n");
>  
>  	return 0;
>  }
>  
>  static int meson_uart_probe(struct platform_device *pdev)
>  {
> +	struct meson_uart_data *private_data;
>  	struct resource *res_mem, *res_irq;
> +	struct clk *clk_baud, *clk_xtal;
> +	bool register_clk81_div4;
>  	struct uart_port *port;
>  	int ret = 0;
>  	int id = -1;
> @@ -711,18 +855,37 @@ static int meson_uart_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> -	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
> -	if (!port)
> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
> +				    GFP_KERNEL);
> +	if (!private_data)
>  		return -ENOMEM;
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

This is second time you call devm_clk_get() on these clocks. One
instance has to go away

> +	register_clk81_div4 = clk_get_rate(clk_xtal) != clk_get_rate(clk_baud);
> +

The above is a ugly way to distinguish the meson8 (32bit) SoC family
from the rest. This definitely not the way to achieve it.

The right is the compatible data but here I think it is not
necessary. The clock input should be fixed.

> +	port = &private_data->port;
> +
>  	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
>  	if (IS_ERR(port->membase))
>  		return PTR_ERR(port->membase);
>  
> -	ret = meson_uart_probe_clocks(pdev, port);
> -	if (ret)
> -		return ret;
> -
>  	port->iotype = UPIO_MEM;
>  	port->mapbase = res_mem->start;
>  	port->mapsize = resource_size(res_mem);
> @@ -735,6 +898,12 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	port->x_char = 0;
>  	port->ops = &meson_uart_ops;
>  	port->fifosize = 64;
> +	port->uartclk = clk_get_rate(clk_baud);
> +	port->private_data = private_data;
> +
> +	ret = meson_uart_probe_clocks(port, register_clk81_div4);
> +	if (ret)
> +		return ret;
>  
>  	meson_ports[pdev->id] = port;
>  	platform_set_drvdata(pdev, port);
> @@ -761,10 +930,42 @@ static int meson_uart_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id meson_uart_dt_match[] = {
> -	{ .compatible = "amlogic,meson6-uart" },
> -	{ .compatible = "amlogic,meson8-uart" },
> -	{ .compatible = "amlogic,meson8b-uart" },
> -	{ .compatible = "amlogic,meson-gx-uart" },
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
> +	/*
> +	 * deprecated, don't use anymore because it doesn't differentiate
> +	 * between GXBB and GXL which have different revisions of the UART IP.
> +	 */
> +	{
> +		.compatible = "amlogic,meson-gx-uart",
> +		.data = (void *)false,
> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

