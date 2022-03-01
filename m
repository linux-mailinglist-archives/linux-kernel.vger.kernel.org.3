Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC04C8687
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiCAIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiCAIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:33:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B668396
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:32:25 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f8so8811377edf.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=nsUATk/2y14ChiOIn5CE+LTlgsRPR3DrNuBrS7JUbrQ=;
        b=bYnSfzfZPfCOIKN8Krthey4XMcGw2QKgC/LcWSj5nf7IJYtupnKl4dFnvn/oZJ0DJB
         pXJYJHK79APoUJTtn6e9ypwUH8KZQ1uBSg4I6Qp6maILe6xIPOnv1hxpWR7LfXYmV8JS
         LlSv/aFSvjleKM9FcPa7oojCWgSDjptlEsyPmwOlavHAOFVzg5zhqAk/O3ggkYOrMVVj
         awTMEOSlRt3NSZgshmKVQDjt2n45GY8H7cbf9BQFufFWl4TqVsFVMKJLRoGJQ2zVi9IN
         uA6UjX0tbaNAELz45jUapuk5dekpctdos/KxrIGfHjBh9ol1/vlqbQ2sDMKwsUoLV95t
         CUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=nsUATk/2y14ChiOIn5CE+LTlgsRPR3DrNuBrS7JUbrQ=;
        b=F2d0zW+33ygc+RIUmDngqi5tRjwKdcwT6aeqhzGXqElahIpm0Gi6GmDyAQ/n0k+OP7
         /huXMNqNcmCnOzvj+lgMaIkjA5Wr5+G5dX7wd8ZBYVa+89T5myCNYRYLKgDCxQQ/ZFeP
         mke73neyvTWblcmRb9JOqkbJPRvFPg0qh+LDGEFQoFHoKGRdr4KqmxXzPQcjzDBXQiWa
         P2+Lc3PD98sehjr5cAePyP4z4HGKtL0e9BPRUxE12sEH5rOjowP+GHfXl/OGjNebiZNm
         omR6h8A/fpcr52/lgcq4yiSRuhik+DKLYPTtNCMzMVy4ldCsKtp6BXzfCVnq0jczkC1y
         YxYQ==
X-Gm-Message-State: AOAM532Gwb8ffHCZMWG2j1vL4Bd6Jbm79U+VNhnmZKSkj43N/h+PBvnV
        kXXfESLWoeaIyrffz0HdQjfbT5c+CIblmg==
X-Google-Smtp-Source: ABdhPJzrUHBJAZzS80YmptY0nPErjjPOM4jEHxZBwzUH8W3hc3yhJhzX4ceWFL2nT3TUbkIPc2/GWA==
X-Received: by 2002:a50:aa8c:0:b0:410:801c:4e2f with SMTP id q12-20020a50aa8c000000b00410801c4e2fmr22932513edc.179.1646123543706;
        Tue, 01 Mar 2022 00:32:23 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090609a900b006cd30a3c4f0sm5167184eje.147.2022.03.01.00.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:32:23 -0800 (PST)
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <20220225073922.3947-4-yu.tu@amlogic.com>
 <1j4k4jxmji.fsf@starbuckisacylon.baylibre.com>
 <ec3a884e-618c-63ff-056f-b660848276f6@amlogic.com>
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
Subject: Re: [PATCH V7 3/6] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Date:   Tue, 01 Mar 2022 09:26:38 +0100
In-reply-to: <ec3a884e-618c-63ff-056f-b660848276f6@amlogic.com>
Message-ID: <1jr17mvzse.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 01 Mar 2022 at 14:49, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
>
> On 2022/2/28 19:10, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> 
>> On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:
>> 
>>> Using the common Clock code to describe the UART baud rate clock
>>> makes it easier for the UART driver to be compatible with the
>>> baud rate requirements of the UART IP on different meson chips.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   drivers/tty/serial/meson_uart.c | 194 +++++++++++++++++++++++---------
>>>   1 file changed, 142 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>> index 7570958d010c..4768d51fac70 100644
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
>>> @@ -76,6 +75,11 @@
>>>   #define AML_UART_POLL_USEC		5
>>>   #define AML_UART_TIMEOUT_USEC		10000
>>>   +struct meson_uart_data {
>>> +	struct clk	*baud_clk;
>>> +	bool		use_xtal_clk;
>>> +};
>>> +
>>>   static struct uart_driver meson_uart_driver;
>>>     static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>>> @@ -293,19 +297,17 @@ static int meson_uart_startup(struct uart_port *port)
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
>>> @@ -395,11 +397,20 @@ static int meson_uart_verify_port(struct uart_port *port,
>>>     static void meson_uart_release_port(struct uart_port *port)
>>>   {
>>> -	/* nothing to do */
>>> +	struct meson_uart_data *private_data = port->private_data;
>>> +
>>> +	clk_disable_unprepare(private_data->baud_clk);
>>>   }
>>>     static int meson_uart_request_port(struct uart_port *port)
>>>   {
>>> +	struct meson_uart_data *private_data = port->private_data;
>>> +	int ret;
>>> +
>>> +	ret = clk_prepare_enable(private_data->baud_clk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>> I think we already discussed that. This is yet another behavior change
>> Previously, enabling the clock was done at probe time.
>> It's fine to change it, if there is a justification, but not in the same
>> change as the rework of the divider
>> 
>>>   	return 0;
>>>   }
>>>   @@ -629,57 +640,106 @@ static struct uart_driver meson_uart_driver = {
>>>   	.cons		= MESON_SERIAL_CONSOLE,
>>>   };
>>>   -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>>> -						 const char *id)
>>> -{
>>> -	struct clk *clk = NULL;
>>> -	int ret;
>>> -
>>> -	clk = devm_clk_get(dev, id);
>>> -	if (IS_ERR(clk))
>>> -		return clk;
>>> -
>>> -	ret = clk_prepare_enable(clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "couldn't enable clk\n");
>>> -		return ERR_PTR(ret);
>>> -	}
>>> +static const struct clk_div_table xtal_div_table[] = {
>>> +	{ 0, 3 },
>>> +	{ 1, 1 },
>>> +	{ 2, 2 },
>>> +	{ 3, 2 },
>>> +};
>>>   -	devm_add_action_or_reset(dev,
>>> -			(void(*)(void *))clk_disable_unprepare,
>>> -			clk);
>>> +static u32 use_xtal_mux_table;
>>>   -	return clk;
>>> -}
>>> -
>>> -static int meson_uart_probe_clocks(struct platform_device *pdev,
>>> -				   struct uart_port *port)
>>> +static int meson_uart_probe_clocks(struct uart_port *port)
>>>   {
>>> -	struct clk *clk_xtal = NULL;
>>> -	struct clk *clk_pclk = NULL;
>>> -	struct clk *clk_baud = NULL;
>>> +	struct meson_uart_data *private_data = port->private_data;
>>> +	struct clk *clk_baud, *clk_xtal;
>>> +	struct clk_hw *hw, *clk81_div4_hw;
>>> +	char clk_name[32];
>>> +	struct clk_parent_data use_xtal_mux_parents;
>>>   -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>>> -	if (IS_ERR(clk_pclk))
>>> -		return PTR_ERR(clk_pclk);
>>> +	clk_baud = devm_clk_get(port->dev, "baud");
>>> +	if (IS_ERR(clk_baud)) {
>>> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
>>> +		return PTR_ERR(clk_baud);
>>> +	}
>> Calling devm_clk_get() would not be necessary if you used "fw_name" in
>> the parent table. Same bellow
> Personally, I think it is good that you can understand your meaning, but as
> you are an expert in CCF, it is nice to write code in that way, but for
> people who are not unfamiliar with CCF, they may only care about the use of
> CCF.It's not pretty to use but it's easy to understand.

There is no magic in CCF. Stephen and the other contributor took time to
add the fw_name mechanism espcially for this. I'm suggesting and you are
expected to actually look at the code and considerer it. Lack of
"expertize" is not a valid argument.

>> 
>>>   -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
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
>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
>>> +		 "clk81_div4");
>>> +	clk81_div4_hw = devm_clk_hw_register_fixed_factor(port->dev,
>>> +							  clk_name,
>>> +							  __clk_get_name(clk_baud),
>>> +							  CLK_SET_RATE_NO_REPARENT,
>>> +							  1, 4);
>>> +	if (IS_ERR(clk81_div4_hw))
>>> +		return PTR_ERR(clk81_div4_hw);
>> So, whatever the chip type - you register a fixed 4 divider ....
> As you suggested last time, this CLK has been stored, but some chips are
> not used. If you have better suggestions, please let me know and I can 
> make corrections later.

No, never suggested that. I suspected that 4 divider design was the same
on all SoC version. You reported it was not, So I don't get this

>> 
>>> +
>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
>>> +		 "xtal_div");
>>> +	hw = devm_clk_hw_register_divider_table(port->dev,
>>> +						clk_name,
>>> +						__clk_get_name(clk_baud),
>>> +						CLK_SET_RATE_NO_REPARENT,
>>> +						port->membase + AML_UART_REG5,
>>> +						26, 2,
>>> +						CLK_DIVIDER_READ_ONLY,
>>> +						xtal_div_table, NULL);
>>> +	if (IS_ERR(hw))
>>> +		return PTR_ERR(hw);
>>> +
>>> +	if (private_data->use_xtal_clk) {
>>> +		use_xtal_mux_table = 1;
>>> +		use_xtal_mux_parents.hw = hw;
>>> +	} else {
>>> +		use_xtal_mux_parents.hw = clk81_div4_hw;
>> ... which you may end up not using in the end
>> This is bad.
> If you have better suggestions, please let me know and I can make
> corrections later.
>> 
>>> +	}
>>>   -	port->uartclk = clk_get_rate(clk_baud);
>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
>>> +		 "use_xtal");
>>> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
>>> +					clk_name,
>>> +					1,
>>> +					NULL, NULL,
>>> +					&use_xtal_mux_parents,
>>> +					CLK_SET_RATE_PARENT,
>>> +					port->membase + AML_UART_REG5,
>>> +					24, 0x1,
>>> +					CLK_MUX_READ_ONLY,
>>> +					&use_xtal_mux_table, NULL);
>>> +
>>> +	if (IS_ERR(hw))
>>> +		return PTR_ERR(hw);
>>> +
>>> +	port->uartclk = clk_hw_get_rate(hw);
>>> +
>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
>>> +		 "baud_div");
>>> +	hw = devm_clk_hw_register_divider(port->dev,
>>> +					  clk_name,
>>> +					  clk_hw_get_name(hw),
>>> +					  CLK_SET_RATE_PARENT,
>>> +					  port->membase + AML_UART_REG5,
>>> +					  0, 23,
>>> +					  CLK_DIVIDER_ROUND_CLOSEST,
>>> +					  NULL);
>>> +	if (IS_ERR(hw))
>>> +		return PTR_ERR(hw);
>>> +
>>> +	private_data->baud_clk = hw->clk;
>>>     	return 0;
>>>   }
>>>     static int meson_uart_probe(struct platform_device *pdev)
>>>   {
>>> +	struct meson_uart_data *private_data;
>>>   	struct resource *res_mem;
>>>   	struct uart_port *port;
>>> +	struct clk *pclk;
>>>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>>>   	int ret = 0;
>>>   	int irq;
>>> @@ -705,6 +765,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>   	if (!res_mem)
>>>   		return -ENODEV;
>>>   +	pclk = devm_clk_get(&pdev->dev, "pclk");
>>> +	if (IS_ERR(pclk))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
>>> +				     "Failed to get the 'pclk' clock\n");
>>> +
>>> +	ret = clk_prepare_enable(pclk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>   	irq = platform_get_irq(pdev, 0);
>>>   	if (irq < 0)
>>>   		return irq;
>>> @@ -724,9 +793,13 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>   	if (IS_ERR(port->membase))
>>>   		return PTR_ERR(port->membase);
>>>   -	ret = meson_uart_probe_clocks(pdev, port);
>>> -	if (ret)
>>> -		return ret;
>>> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
>>> +				    GFP_KERNEL);
>>> +	if (!private_data)
>>> +		return -ENOMEM;
>>> +
>>> +	if (device_get_match_data(&pdev->dev))
>>> +		private_data->use_xtal_clk = true;
>> As long as the device matches a compatible below, the flag will end up
>> 'true', regardless of values in the the dt_match table.
>> I don't think this is the intended behavior.
>> It highlights that proper testing of this series is important.
>> Being at Amlogic, I'm sure you can test on more than just g12a and s4
>> 
> I believe with your experience this may be a real problem. I heard that
> your company has our boards. If so, can you help verify it?
>>>     	port->iotype = UPIO_MEM;
>>>   	port->mapbase = res_mem->start;
>>> @@ -740,6 +813,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>   	port->x_char = 0;
>>>   	port->ops = &meson_uart_ops;
>>>   	port->fifosize = fifosize;
>>> +	port->private_data = private_data;
>>> +
>>> +	ret = meson_uart_probe_clocks(port);
>>> +	if (ret)
>>> +		return ret;
>>>     	meson_ports[pdev->id] = port;
>>>   	platform_set_drvdata(pdev, port);
>>> @@ -766,10 +844,22 @@ static int meson_uart_remove(struct platform_device *pdev)
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
>>> +		.compatible = "amlogic,meson-gx-uart",
>>> +		.data = (void *)true,
>>> +	},
>>>   	{ /* sentinel */ },
>>>   };
>>>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
>> 

