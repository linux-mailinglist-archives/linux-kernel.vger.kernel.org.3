Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6B4903CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiAQI2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiAQI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:28:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A3CC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:28:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso22389922wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=3/jz/sBvjwOPyHXgUrOFnsqgmo8EwgAIN5LUVTqrxig=;
        b=HeVYUx/tMR+7+yvGcnSRQWReIgGRcO8omkSVULnfk190qE+Ge8j8Zhdr29Ev7uTRHq
         zV80KIakBoByN9vTeOhPF83iuaRQ0O/7/Gpqq6c0+Zy+ZL/jy0UuzUh8YXRyJaR5Owya
         j48yOnFUTxGpD8pjnwmXp9l34rznqBn9lQ1/hQy8K910WscdDOACZAHLOs0DKAxJvonX
         ncUwE9SzbfyoR3fia4xie3+ZhaFPVmRXSl2fQS7OGbmBtgpRjsjWISIdkp3gjFG0Gh8N
         h7EiW7Qr6mTipn3pyZb+0ljk9se/SYyqjbxktAHxeEnWrvzRTlqDP3GVtIiZCkDbGV6K
         DZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=3/jz/sBvjwOPyHXgUrOFnsqgmo8EwgAIN5LUVTqrxig=;
        b=i4YWlv82lOYuNqSw484YdzIsGZuc9t64wYnT7biYLrJ6Nl8VFom5+LVY7afPHLAvtV
         sjOQIampXntkC9gAvdTgA/JEczjr47Vd1gR2xXbZkvn1KJyH9+oNiqaPVWSsgRj5MqzD
         j5zG3hikQVLlQ9acbbVK0/Un77+Dd9TsmPP+JNTLNu9Nzuaq90yjFgHKRyV750+a+N3J
         NR8PuQMe951dIJM4FUvjr85uCRzysF5jR5ZOS7NRBfWtAezEIfkH/Rmdp5HQOD6qHvGd
         xshRr+skH5+7jv0gINNmIgRyDRROrtVtSiCIBfq7AWmqGSyxz5jcZ16Lb26yiFR+AdF7
         68iQ==
X-Gm-Message-State: AOAM532jbqgLDsrnMxoPdf1NqZs5JGxd6c+p+zAvfVOFJkoMrHbj/b7i
        yEsyTcEcmf1A7rSlyBZSPQtmzw==
X-Google-Smtp-Source: ABdhPJzUMHHJOUd/aJuqsQOiqUyoSOqtcqhyKv4FiLFGdjV6RbaKyRpOcxzG6MqGMneZRFM1iER4xg==
X-Received: by 2002:a5d:64c1:: with SMTP id f1mr3413887wri.87.1642408083288;
        Mon, 17 Jan 2022 00:28:03 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id c8sm5350874wri.69.2022.01.17.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:28:02 -0800 (PST)
References: <20220110085604.18042-1-yu.tu@amlogic.com>
 <20220110085604.18042-4-yu.tu@amlogic.com>
 <1j8rvnps11.fsf@starbuckisacylon.baylibre.com>
 <c9bb2f8f-6169-b4ab-5637-56c185dbf254@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V4 3/5] tty: serial: meson: The UART baud rate
Date:   Mon, 17 Jan 2022 09:26:40 +0100
In-reply-to: <c9bb2f8f-6169-b4ab-5637-56c185dbf254@amlogic.com>
Message-ID: <1j7dayn4vh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 11 Jan 2022 at 15:04, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
> 	Thank you very much for your reply.
>
> On 2022/1/10 22:29, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> 
>> On Mon 10 Jan 2022 at 16:56, Yu Tu <yu.tu@amlogic.com> wrote:
>> Title is bad (like several other patches in this series) - Please fix it
>> Ok.
>>> Using the common Clock code to describe the UART baud rate clock
>>> makes it easier for the UART driver to be compatible with the
>>> baud rate requirements of the UART IP on different meson chips.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   drivers/tty/serial/meson_uart.c | 224 +++++++++++++++++++++++---------
>>>   1 file changed, 163 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>> index 7570958d010c..1004fd0b0c9e 100644
>>> --- a/drivers/tty/serial/meson_uart.c
>>> +++ b/drivers/tty/serial/meson_uart.c
>>> @@ -6,6 +6,7 @@
>>>    */
>>>     #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>>   #include <linux/console.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/init.h>
>>> @@ -65,9 +66,7 @@
>>>   #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>>>     /* AML_UART_REG5 bits */
>>> -#define AML_UART_BAUD_MASK		0x7fffff
>>>   #define AML_UART_BAUD_USE		BIT(23)
>>> -#define AML_UART_BAUD_XTAL		BIT(24)
>>>     #define AML_UART_PORT_NUM		12
>>>   #define AML_UART_PORT_OFFSET		6
>>> @@ -76,6 +75,13 @@
>>>   #define AML_UART_POLL_USEC		5
>>>   #define AML_UART_TIMEOUT_USEC		10000
>>>   +struct meson_uart_data {
>>> +	struct uart_port	port;
>>> +	struct clk		*pclk;
>>> +	struct clk		*baud_clk;
>>> +	bool			use_xtal_clk;
>>> +};
>>> +
>>>   static struct uart_driver meson_uart_driver;
>>>     static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>>> @@ -268,14 +274,11 @@ static void meson_uart_reset(struct uart_port *port)
>>>   static int meson_uart_startup(struct uart_port *port)
>>>   {
>>>   	u32 val;
>>> -	int ret = 0;
>>> +	int ret;
>>>   -	val = readl(port->membase + AML_UART_CONTROL);
>>> -	val |= AML_UART_CLEAR_ERR;
>>> -	writel(val, port->membase + AML_UART_CONTROL);
>>> -	val &= ~AML_UART_CLEAR_ERR;
>>> -	writel(val, port->membase + AML_UART_CONTROL);
>>> +	meson_uart_reset(port);
>>>   +	val = readl(port->membase + AML_UART_CONTROL);
>>>   	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
>>>   	writel(val, port->membase + AML_UART_CONTROL);
>>>   @@ -293,19 +296,17 @@ static int meson_uart_startup(struct uart_port
>>> *port)
>>>     static void meson_uart_change_speed(struct uart_port *port, unsigned
>>> long baud)
>>>   {
>>> +	struct meson_uart_data *private_data = port->private_data;
>>>   	u32 val;
>>>     	while (!meson_uart_tx_empty(port))
>>>   		cpu_relax();
>>>   -	if (port->uartclk == 24000000) {
>>> -		val = ((port->uartclk / 3) / baud) - 1;
>>> -		val |= AML_UART_BAUD_XTAL;
>>> -	} else {
>>> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
>>> -	}
>>> +	val = readl(port->membase + AML_UART_REG5);
>>>   	val |= AML_UART_BAUD_USE;
>>>   	writel(val, port->membase + AML_UART_REG5);
>>> +
>>> +	clk_set_rate(private_data->baud_clk, baud);
>>>   }
>>>     static void meson_uart_set_termios(struct uart_port *port,
>>> @@ -395,11 +396,27 @@ static int meson_uart_verify_port(struct uart_port *port,
>>>     static void meson_uart_release_port(struct uart_port *port)
>>>   {
>>> -	/* nothing to do */
>>> +	struct meson_uart_data *private_data = port->private_data;
>>> +
>>> +	clk_disable_unprepare(private_data->baud_clk);
>>> +	clk_disable_unprepare(private_data->pclk);
>>>   }
>>>     static int meson_uart_request_port(struct uart_port *port)
>>>   {
>>> +	struct meson_uart_data *private_data = port->private_data;
>>> +	int ret;
>>> +
>>> +	ret = clk_prepare_enable(private_data->pclk);
>>> +	if (ret)
>>> +		return ret;
>> In the previous version of the series, you already been asked to the
>> enable of pclk in the probe. Optimization should not be mixed with this
>> series
>> Please make sure all comments are addressed before re-posting
>> 
> I'm sorry. I misunderstood you earlier. I'm going to move into the probe
> function.
>>> +
>>> +	ret = clk_prepare_enable(private_data->baud_clk);
>>> +	if (ret) {
>>> +		clk_disable_unprepare(private_data->pclk);
>>> +		return ret;
>>> +	}
>>> +
>>>   	return 0;
>>>   }
>>>   @@ -629,55 +646,105 @@ static struct uart_driver meson_uart_driver = {
>>>   	.cons		= MESON_SERIAL_CONSOLE,
>>>   };
>>>   -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>>> -						 const char *id)
>>> +#define CLK_NAME(name) \
>>> +({\
>>> +	char clk_name[32];\
>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev), #name);\
>>> +	clk_name;\
>>> +})
>> 1) This result in some ugly code being inlined
>> 2) You return a pointer a local variable which is not gurantee to exist
>> anymore  outside of this ...
>> Please do this simply in the related function.
> I've overdone it. I'll move it to the meson_uart_probe_clocks function as
> you suggested.
>> 
>>> +
>>> +static struct clk_div_table xtal_div_table[] = {
>>> +	{ 0, 3  },
>>> +	{ 1, 1  },
>>> +	{ 2, 2  },
>>> +	{ 3, 2  },
>>> +};
>>> +
>>> +static int meson_uart_probe_clocks(struct uart_port *port)
>>>   {
>>> -	struct clk *clk = NULL;
>>> -	int ret;
>>> +	struct meson_uart_data *private_data = port->private_data;
>>> +	struct clk *clk_baud, *clk_xtal;
>>> +	struct clk_hw *hw;
>>> +	struct clk_parent_data use_xtal_mux_parents[2] = {
>>> +		{ .index = -1, },
>>> +		{ .index = -1, },
>>> +	};
>>>   -	clk = devm_clk_get(dev, id);
>>> -	if (IS_ERR(clk))
>>> -		return clk;
>>> +	private_data->pclk = devm_clk_get(port->dev, "pclk");
>>> +	if (IS_ERR(private_data->pclk))
>>> +		return dev_err_probe(port->dev, PTR_ERR(private_data->pclk),
>>> +				     "Failed to get the 'pclk' clock\n");
>>>   -	ret = clk_prepare_enable(clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "couldn't enable clk\n");
>>> -		return ERR_PTR(ret);
>>> +	clk_baud = devm_clk_get(port->dev, "baud");
>>> +	if (IS_ERR(clk_baud)) {
>>> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
>>> +		return PTR_ERR(clk_baud);
>>>   	}
>>>   -	devm_add_action_or_reset(dev,
>>> -			(void(*)(void *))clk_disable_unprepare,
>>> -			clk);
>>> -
>>> -	return clk;
>>> -}
>>> -
>>> -static int meson_uart_probe_clocks(struct platform_device *pdev,
>>> -				   struct uart_port *port)
>>> -{
>>> -	struct clk *clk_xtal = NULL;
>>> -	struct clk *clk_pclk = NULL;
>>> -	struct clk *clk_baud = NULL;
>>> -
>>> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>>> -	if (IS_ERR(clk_pclk))
>>> -		return PTR_ERR(clk_pclk);
>>> -
>>> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
>>> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>>>   	if (IS_ERR(clk_xtal))
>>> -		return PTR_ERR(clk_xtal);
>>> -
>>> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
>>> -	if (IS_ERR(clk_baud))
>>> -		return PTR_ERR(clk_baud);
>>> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
>>> +				     "Failed to get the 'xtal' clock\n");
>>> +
>>> +	if (private_data->use_xtal_clk) {
>>> +		hw = devm_clk_hw_register_divider_table(port->dev,
>>> +							CLK_NAME(xtal_div),
>>> +							__clk_get_name(clk_baud),
>>> +							CLK_SET_RATE_NO_REPARENT,
>>> +							port->membase + AML_UART_REG5,
>>> +							26, 2,
>>> +							CLK_DIVIDER_READ_ONLY,
>>> +							xtal_div_table, NULL);
>>> +		if (IS_ERR(hw))
>>> +			return PTR_ERR(hw);
>>> +
>>> +		use_xtal_mux_parents[1].hw = hw;
>>> +	} else {
>>> +		hw = devm_clk_hw_register_fixed_factor(port->dev,
>>> +						       CLK_NAME(clk81_div4),
>>> +						       __clk_get_name(clk_baud),
>>> +						       CLK_SET_RATE_NO_REPARENT,
>>> +						       1, 4);
>>> +		if (IS_ERR(hw))
>>> +			return PTR_ERR(hw);
>>> +
>>> +		use_xtal_mux_parents[0].hw = hw;
>>> +	}
>> Contradiction with previous series.
>> In the previous series we could clearly see that gxbb did not have the
>> /4 divider. It did not have bits 26 and 27 either.
>> Now gxbb get the /4 divider. It operated correctly without it so far, so
>> this is rather suspicious. Could you please comment on this ?
>> 
> As Martin and I discussed earlier.
> meson6 and meson8b SoC.There are not have bits 26 and 27 either.
> CLK81 is recommended for this part of SOC.
>
> GXL,GXM,GXBB and AXG SOC.The UART_EE_A_REG5[26] is added.
> UART_EE_A_REG5[26]:
> - 0x0: divide the input clock by 3 (meaning: this internally works
> with an 8MHz clock)
> - 0x1: use the input clock directly without further division (meaning:
> this internally work with an 24MHz clock)
> 8MHz is recommended for this part of SOC. Their UART IP configuration is
> the same.
>
> G12A/B,,SM1,A1 and S4 SOC.The UART_EE_A_REG5[27] is added.
> UART_EE_A_REG5[27]:
> - 0x0: use the clock as configured in UART_EE_A_REG5[26]
> - 0x1: divide the input clock by 2 (meaning: this internally works
> with an 12MHz clock)
> 12MHz is recommended for this part of SOC.
>
> NOTE:
> 1. clk81 /4 divider.
> There is a 4 divider inside, this is what the internal SOC designer told
> me. But they forgot to document it. So it makes people feel suspicious.
>
> 2.The UART_EE_A_REG5 default value is 0,except for the console port(set in
> romcode).All the baud rate clocks supported by UART can work, but different
> chip usage scenarios suggest using that clock to reduce jitter.
>
> In summary, I would like to know your suggestions, including how to change
> compatible.
> Thank you so much!

From your comment, gxbb should have "true" instead of false, isn't it ?

>
>  >>
>>> -	port->uartclk = clk_get_rate(clk_baud);
>>> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
>>> +					CLK_NAME(use_xtal),
>>> +					ARRAY_SIZE(use_xtal_mux_parents),
>>> +					NULL, NULL,
>>> +					use_xtal_mux_parents,
>>> +					CLK_SET_RATE_PARENT,
>>> +					port->membase + AML_UART_REG5,
>>> +					24, 0x1,
>>> +					CLK_MUX_READ_ONLY,
>>> +					NULL, NULL);
>>> +	if (IS_ERR(hw))
>>> +		return PTR_ERR(hw);
>>> +
>>> +	port->uartclk = clk_hw_get_rate(hw);
>>> +
>>> +	hw = devm_clk_hw_register_divider(port->dev,
>>> +					  CLK_NAME(baud_div),
>>> +					  clk_hw_get_name(hw),
>>> +					  CLK_SET_RATE_PARENT,
>>> +					  port->membase + AML_UART_REG5,
>>> +					  0, 23,
>>> +					  CLK_DIVIDER_ROUND_CLOSEST,
>>> +					  NULL);
>>> +	if (IS_ERR(hw))
>>> +		return PTR_ERR(hw);
>>> +
>>> +	private_data->baud_clk = clk_hw_get_clk(hw, "baud_rate");
>> I have already commented on the use of this function in the previous
>> version.
>> Please make sure all comments are addressed before re-posting
>> 
> I'm sorry. I misunderstood you earlier. I will be changed to
> "private_data->baud_clk = hw->clk;".What do you think?

yes

>>>     	return 0;
>>>   }
>>>     static int meson_uart_probe(struct platform_device *pdev)
>>>   {
>>> +	struct meson_uart_data *private_data;
>>>   	struct resource *res_mem;
>>>   	struct uart_port *port;
>>>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>>> @@ -716,18 +783,20 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>   		return -EBUSY;
>>>   	}
>>>   -	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port),
>>> GFP_KERNEL);
>>> -	if (!port)
>>> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
>>> +				    GFP_KERNEL);
>>> +	if (!private_data)
>>>   		return -ENOMEM;
>>>   +	if (device_get_match_data(&pdev->dev))
>>> +		private_data->use_xtal_clk = true;
>>> +
>>> +	port = &private_data->port;
>>> +
>>>   	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
>>>   	if (IS_ERR(port->membase))
>>>   		return PTR_ERR(port->membase);
>>>   -	ret = meson_uart_probe_clocks(pdev, port);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>   	port->iotype = UPIO_MEM;
>>>   	port->mapbase = res_mem->start;
>>>   	port->mapsize = resource_size(res_mem);
>>> @@ -740,7 +809,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>   	port->x_char = 0;
>>>   	port->ops = &meson_uart_ops;
>>>   	port->fifosize = fifosize;
>>> +	port->private_data = private_data;
>> port has private_data
>> private_data has port
>> Is it really necessary to have both ... looks to me that port in
>> private_data is overkill
>> 
> It's very thoughtful of you. I'll delete it as you suggested.
>>>   +	ret = meson_uart_probe_clocks(port);
>>> +	if (ret)
>>> +		return ret;
>>>   	meson_ports[pdev->id] = port;
>>>   	platform_set_drvdata(pdev, port);
>>>   @@ -766,10 +839,39 @@ static int meson_uart_remove(struct
>>> platform_device *pdev)
>>>   }
>>>     static const struct of_device_id meson_uart_dt_match[] = {
>>> -	{ .compatible = "amlogic,meson6-uart" },
>>> -	{ .compatible = "amlogic,meson8-uart" },
>>> -	{ .compatible = "amlogic,meson8b-uart" },
>>> -	{ .compatible = "amlogic,meson-gx-uart" },
>>> +	{
>>> +		.compatible = "amlogic,meson6-uart",
>>> +		.data = (void *)false,
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,meson8-uart",
>>> +		.data = (void *)false,
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,meson8b-uart",
>>> +		.data = (void *)false,
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,meson-gxbb-uart",
>>> +		.data = (void *)false,
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,meson-gxl-uart",
>>> +		.data = (void *)true,
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,meson-g12a-uart",
>>> +		.data = (void *)true,
>>> +	},
>>> +	/*
>>> +	 * deprecated, don't use anymore because it doesn't differentiate
>>> +	 * between GXBB, GXL and G12A which have different revisions
>>> +	 * of the UART IP.
>>> +	 */
>>> +	{
>>> +		.compatible = "amlogic,meson-gx-uart",
>>> +		.data = (void *)false,
>>> +	},
>>>   	{ /* sentinel */ },
>>>   };
>>>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
>> 
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

