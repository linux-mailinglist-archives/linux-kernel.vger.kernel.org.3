Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5E495611
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377984AbiATVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377977AbiATVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:48:06 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025CCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:48:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso13804923wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=iZ+9Vde/0m5J/ixOTvXujO7fTjmc4C/YzHsu92CkbgU=;
        b=YD6q/ZdTQbubWjlr9UczfOXKKeFRYwYwOqEFPDHUnwR2ftb39tmAibcX1JVIf8MeOc
         zsrKAt54nEaBqYW36mhu9mqkSKL1302wwEpLpg5Or6YwYSo6t5Xzrluv/hY3zTHXNdb1
         /Km5ZIGf8d0rlwnqwUBHkZuKX015ZtIAhLXae6x2r42uz6v/klOSrD7IKQh6IxX/x7tT
         Z/EZwMBfQ5jigxZDmIeClJvfrJohJpvZFb/oQBr4fzPOFlHwuwTley42LRTaflGPSgWJ
         zZ+Dp50ARGGJRvhnD4diPEqfjdUx1FXkyGFAj36x0hB876A8XYFYplhucwZlbyJeiwI9
         6GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=iZ+9Vde/0m5J/ixOTvXujO7fTjmc4C/YzHsu92CkbgU=;
        b=aMEsC9IGMVO59cR1NKKJUwPUJM6yVUOv60d+p/kvPNv3yXu5S0XNvTmsIYKnP4S90w
         hKr/EXoZAbDcYVItv0tXon+x09vnLfjLc3m+EXdCzDFWeEX7kWVNoNGsj8iOVxGTHEOg
         Pp82DXDqhkol/uHNlUzV12IeNK9/A0MbXADVj9AQlUjFBGxloMyVZOVPwFTuPt0eyTrV
         eqvY7MUBT71N7AYqbbLYnYdlE8TWRCsdLRRoT336tzsUcrPP1uICDnU5pjt7TiLyAkkJ
         PBTAfcamPU2v/okCvzjQgKf6YQWWN+N7CYVFcoB5BToM3Z/Wj4SEP40ieRMyaxOexZnE
         K89w==
X-Gm-Message-State: AOAM531gk7l5oQj1zRODQ1JDBu0bXt8DOarRGVopDruN0CiwNGa4yEWJ
        Tj3fw91CweWjkvm4ieunPafw7Q==
X-Google-Smtp-Source: ABdhPJwFF/y0N+11vxyAsFl4/d2A9pbW6P9GCRwQ4EZGYY9QRIYRVDjWVX2v/m4ZftrMFopCfGRi+A==
X-Received: by 2002:a5d:6e82:: with SMTP id k2mr917479wrz.289.1642715280545;
        Thu, 20 Jan 2022 13:48:00 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id r12sm3781306wrw.73.2022.01.20.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:48:00 -0800 (PST)
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-4-yu.tu@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V6 3/5] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Date:   Thu, 20 Jan 2022 22:40:31 +0100
In-reply-to: <20220118030911.12815-4-yu.tu@amlogic.com>
Message-ID: <1jfspi2i5s.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 18 Jan 2022 at 11:09, Yu Tu <yu.tu@amlogic.com> wrote:

> Using the common Clock code to describe the UART baud rate clock
> makes it easier for the UART driver to be compatible with the
> baud rate requirements of the UART IP on different meson chips.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 195 +++++++++++++++++++++++---------
>  1 file changed, 142 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 7570958d010c..92fa91c825e6 100644
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
> @@ -76,6 +75,11 @@
>  #define AML_UART_POLL_USEC		5
>  #define AML_UART_TIMEOUT_USEC		10000
>  
> +struct meson_uart_data {
> +	struct clk	*baud_clk;
> +	bool		use_xtal_clk;
> +};
> +
>  static struct uart_driver meson_uart_driver;
>  
>  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> @@ -293,19 +297,17 @@ static int meson_uart_startup(struct uart_port *port)
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
> @@ -395,11 +397,20 @@ static int meson_uart_verify_port(struct uart_port *port,
>  
>  static void meson_uart_release_port(struct uart_port *port)
>  {
> -	/* nothing to do */
> +	struct meson_uart_data *private_data = port->private_data;
> +
> +	clk_disable_unprepare(private_data->baud_clk);
>  }
>  
>  static int meson_uart_request_port(struct uart_port *port)
>  {
> +	struct meson_uart_data *private_data = port->private_data;
> +	int ret;
> +
> +	ret = clk_prepare_enable(private_data->baud_clk);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -629,57 +640,105 @@ static struct uart_driver meson_uart_driver = {
>  	.cons		= MESON_SERIAL_CONSOLE,
>  };
>  
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> -{
> -	struct clk *clk = NULL;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> -	}
> -
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> -
> -	return clk;
> -}
> +static struct clk_div_table xtal_div_table[] = {
> +	{0, 3},
> +	{1, 1},
> +	{2, 2},
> +	{3, 2},
> +};
>  
> -static int meson_uart_probe_clocks(struct platform_device *pdev,
> -				   struct uart_port *port)
> +static int meson_uart_probe_clocks(struct uart_port *port)
>  {
> -	struct clk *clk_xtal = NULL;
> -	struct clk *clk_pclk = NULL;
> -	struct clk *clk_baud = NULL;
> +	struct meson_uart_data *private_data = port->private_data;
> +	struct clk *clk_baud, *clk_xtal;
> +	struct clk_hw *hw;
> +	char clk_name[32];
> +	struct clk_parent_data use_xtal_mux_parents[2] = {
> +		{ .index = -1, },
> +		{ .index = -1, },
> +	};

You are using hw pointers later, you don't need to init the index to -1
I think

>  
> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
> -	if (IS_ERR(clk_pclk))
> -		return PTR_ERR(clk_pclk);
> +	clk_baud = devm_clk_get(port->dev, "baud");
> +	if (IS_ERR(clk_baud)) {
> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
> +		return PTR_ERR(clk_baud);
> +	}
>  
> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>  	if (IS_ERR(clk_xtal))
> -		return PTR_ERR(clk_xtal);
> -
> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
> -	if (IS_ERR(clk_baud))
> -		return PTR_ERR(clk_baud);
> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
> +				     "Failed to get the 'xtal' clock\n");
> +
> +	if (private_data->use_xtal_clk) {
> +		snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +			 "xtal_div");
> +		hw = devm_clk_hw_register_divider_table(port->dev,
> +							clk_name,
> +							__clk_get_name(clk_baud),
> +							CLK_SET_RATE_NO_REPARENT,
> +							port->membase + AML_UART_REG5,
> +							26, 2,
> +							CLK_DIVIDER_READ_ONLY,
> +							xtal_div_table, NULL);
> +		if (IS_ERR(hw))
> +			return PTR_ERR(hw);
> +
> +		use_xtal_mux_parents[1].hw = hw;
> +	} else {
> +		snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +			 "clk81_div4");
> +		hw = devm_clk_hw_register_fixed_factor(port->dev,
> +						       clk_name,
> +						       __clk_get_name(clk_baud),
> +						       CLK_SET_RATE_NO_REPARENT,
> +						       1, 4);
> +		if (IS_ERR(hw))
> +			return PTR_ERR(hw);
> +
> +		use_xtal_mux_parents[0].hw = hw;
> +	}

The above is still wrong.

use_xtal_mux_parents initialize both parent to nothing
And you init the parent in the conditional above.
It is means only one path is actually set instead of both.

The mux always has 2 sources - Both should be set regardless of the HW version
You just add
* /4 on path 0 on legacy SoC
* the funky divider on path 1 on newer SoC.

>  
> -	port->uartclk = clk_get_rate(clk_baud);
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "use_xtal");
> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
> +					clk_name,
> +					ARRAY_SIZE(use_xtal_mux_parents),
> +					NULL, NULL,
> +					use_xtal_mux_parents,
> +					CLK_SET_RATE_PARENT,
> +					port->membase + AML_UART_REG5,
> +					24, 0x1,
> +					CLK_MUX_READ_ONLY,
> +					NULL, NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	port->uartclk = clk_hw_get_rate(hw);
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "baud_div");
> +	hw = devm_clk_hw_register_divider(port->dev,
> +					  clk_name,
> +					  clk_hw_get_name(hw),
> +					  CLK_SET_RATE_PARENT,
> +					  port->membase + AML_UART_REG5,
> +					  0, 23,
> +					  CLK_DIVIDER_ROUND_CLOSEST,
> +					  NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	private_data->baud_clk = hw->clk;
>  
>  	return 0;
>  }
>  
>  static int meson_uart_probe(struct platform_device *pdev)
>  {
> +	struct meson_uart_data *private_data;
>  	struct resource *res_mem;
>  	struct uart_port *port;
> +	struct clk *pclk;
>  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>  	int ret = 0;
>  	int irq;
> @@ -705,6 +764,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	if (!res_mem)
>  		return -ENODEV;
>  
> +	pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
> +				     "Failed to get the 'pclk' clock\n");
> +
> +	ret = clk_prepare_enable(pclk);
> +	if (ret)
> +		return ret;
> +

I think this is unbalanced. 

>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> @@ -724,9 +792,13 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	if (IS_ERR(port->membase))
>  		return PTR_ERR(port->membase);
>  
> -	ret = meson_uart_probe_clocks(pdev, port);
> -	if (ret)
> -		return ret;
> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
> +				    GFP_KERNEL);
> +	if (!private_data)
> +		return -ENOMEM;
> +
> +	if (device_get_match_data(&pdev->dev))
> +		private_data->use_xtal_clk = true;
>  
>  	port->iotype = UPIO_MEM;
>  	port->mapbase = res_mem->start;
> @@ -740,6 +812,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	port->x_char = 0;
>  	port->ops = &meson_uart_ops;
>  	port->fifosize = fifosize;
> +	port->private_data = private_data;
> +
> +	ret = meson_uart_probe_clocks(port);
> +	if (ret)
> +		return ret;
>  
>  	meson_ports[pdev->id] = port;
>  	platform_set_drvdata(pdev, port);
> @@ -766,10 +843,22 @@ static int meson_uart_remove(struct platform_device *pdev)
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
> +		.compatible = "amlogic,meson-gx-uart",
> +		.data = (void *)true,
> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

