Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A449048E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiAQJDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:03:38 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:35786 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiAQJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:03:35 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 17 Jan
 2022 17:03:32 +0800
Message-ID: <70307ecc-b251-6adc-66c2-f7600d237f08@amlogic.com>
Date:   Mon, 17 Jan 2022 17:03:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V4 3/5] tty: serial: meson: The UART baud rate
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110085604.18042-1-yu.tu@amlogic.com>
 <20220110085604.18042-4-yu.tu@amlogic.com>
 <1j8rvnps11.fsf@starbuckisacylon.baylibre.com>
 <c9bb2f8f-6169-b4ab-5637-56c185dbf254@amlogic.com>
 <1j7dayn4vh.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1j7dayn4vh.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Jerome,
	Thank you very much for your reply.

On 2022/1/17 16:26, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Tue 11 Jan 2022 at 15:04, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Hi Jerome,
>> 	Thank you very much for your reply.
>>
>> On 2022/1/10 22:29, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Mon 10 Jan 2022 at 16:56, Yu Tu <yu.tu@amlogic.com> wrote:
>>> Title is bad (like several other patches in this series) - Please fix it
>>> Ok.
>>>> Using the common Clock code to describe the UART baud rate clock
>>>> makes it easier for the UART driver to be compatible with the
>>>> baud rate requirements of the UART IP on different meson chips.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    drivers/tty/serial/meson_uart.c | 224 +++++++++++++++++++++++---------
>>>>    1 file changed, 163 insertions(+), 61 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>>> index 7570958d010c..1004fd0b0c9e 100644
>>>> --- a/drivers/tty/serial/meson_uart.c
>>>> +++ b/drivers/tty/serial/meson_uart.c
>>>> @@ -6,6 +6,7 @@
>>>>     */
>>>>      #include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>>    #include <linux/console.h>
>>>>    #include <linux/delay.h>
>>>>    #include <linux/init.h>
>>>> @@ -65,9 +66,7 @@
>>>>    #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>>>>      /* AML_UART_REG5 bits */
>>>> -#define AML_UART_BAUD_MASK		0x7fffff
>>>>    #define AML_UART_BAUD_USE		BIT(23)
>>>> -#define AML_UART_BAUD_XTAL		BIT(24)
>>>>      #define AML_UART_PORT_NUM		12
>>>>    #define AML_UART_PORT_OFFSET		6
>>>> @@ -76,6 +75,13 @@
>>>>    #define AML_UART_POLL_USEC		5
>>>>    #define AML_UART_TIMEOUT_USEC		10000
>>>>    +struct meson_uart_data {
>>>> +	struct uart_port	port;
>>>> +	struct clk		*pclk;
>>>> +	struct clk		*baud_clk;
>>>> +	bool			use_xtal_clk;
>>>> +};
>>>> +
>>>>    static struct uart_driver meson_uart_driver;
>>>>      static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>>>> @@ -268,14 +274,11 @@ static void meson_uart_reset(struct uart_port *port)
>>>>    static int meson_uart_startup(struct uart_port *port)
>>>>    {
>>>>    	u32 val;
>>>> -	int ret = 0;
>>>> +	int ret;
>>>>    -	val = readl(port->membase + AML_UART_CONTROL);
>>>> -	val |= AML_UART_CLEAR_ERR;
>>>> -	writel(val, port->membase + AML_UART_CONTROL);
>>>> -	val &= ~AML_UART_CLEAR_ERR;
>>>> -	writel(val, port->membase + AML_UART_CONTROL);
>>>> +	meson_uart_reset(port);
>>>>    +	val = readl(port->membase + AML_UART_CONTROL);
>>>>    	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
>>>>    	writel(val, port->membase + AML_UART_CONTROL);
>>>>    @@ -293,19 +296,17 @@ static int meson_uart_startup(struct uart_port
>>>> *port)
>>>>      static void meson_uart_change_speed(struct uart_port *port, unsigned
>>>> long baud)
>>>>    {
>>>> +	struct meson_uart_data *private_data = port->private_data;
>>>>    	u32 val;
>>>>      	while (!meson_uart_tx_empty(port))
>>>>    		cpu_relax();
>>>>    -	if (port->uartclk == 24000000) {
>>>> -		val = ((port->uartclk / 3) / baud) - 1;
>>>> -		val |= AML_UART_BAUD_XTAL;
>>>> -	} else {
>>>> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
>>>> -	}
>>>> +	val = readl(port->membase + AML_UART_REG5);
>>>>    	val |= AML_UART_BAUD_USE;
>>>>    	writel(val, port->membase + AML_UART_REG5);
>>>> +
>>>> +	clk_set_rate(private_data->baud_clk, baud);
>>>>    }
>>>>      static void meson_uart_set_termios(struct uart_port *port,
>>>> @@ -395,11 +396,27 @@ static int meson_uart_verify_port(struct uart_port *port,
>>>>      static void meson_uart_release_port(struct uart_port *port)
>>>>    {
>>>> -	/* nothing to do */
>>>> +	struct meson_uart_data *private_data = port->private_data;
>>>> +
>>>> +	clk_disable_unprepare(private_data->baud_clk);
>>>> +	clk_disable_unprepare(private_data->pclk);
>>>>    }
>>>>      static int meson_uart_request_port(struct uart_port *port)
>>>>    {
>>>> +	struct meson_uart_data *private_data = port->private_data;
>>>> +	int ret;
>>>> +
>>>> +	ret = clk_prepare_enable(private_data->pclk);
>>>> +	if (ret)
>>>> +		return ret;
>>> In the previous version of the series, you already been asked to the
>>> enable of pclk in the probe. Optimization should not be mixed with this
>>> series
>>> Please make sure all comments are addressed before re-posting
>>>
>> I'm sorry. I misunderstood you earlier. I'm going to move into the probe
>> function.
>>>> +
>>>> +	ret = clk_prepare_enable(private_data->baud_clk);
>>>> +	if (ret) {
>>>> +		clk_disable_unprepare(private_data->pclk);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>    	return 0;
>>>>    }
>>>>    @@ -629,55 +646,105 @@ static struct uart_driver meson_uart_driver = {
>>>>    	.cons		= MESON_SERIAL_CONSOLE,
>>>>    };
>>>>    -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>>>> -						 const char *id)
>>>> +#define CLK_NAME(name) \
>>>> +({\
>>>> +	char clk_name[32];\
>>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev), #name);\
>>>> +	clk_name;\
>>>> +})
>>> 1) This result in some ugly code being inlined
>>> 2) You return a pointer a local variable which is not gurantee to exist
>>> anymore  outside of this ...
>>> Please do this simply in the related function.
>> I've overdone it. I'll move it to the meson_uart_probe_clocks function as
>> you suggested.
>>>
>>>> +
>>>> +static struct clk_div_table xtal_div_table[] = {
>>>> +	{ 0, 3  },
>>>> +	{ 1, 1  },
>>>> +	{ 2, 2  },
>>>> +	{ 3, 2  },
>>>> +};
>>>> +
>>>> +static int meson_uart_probe_clocks(struct uart_port *port)
>>>>    {
>>>> -	struct clk *clk = NULL;
>>>> -	int ret;
>>>> +	struct meson_uart_data *private_data = port->private_data;
>>>> +	struct clk *clk_baud, *clk_xtal;
>>>> +	struct clk_hw *hw;
>>>> +	struct clk_parent_data use_xtal_mux_parents[2] = {
>>>> +		{ .index = -1, },
>>>> +		{ .index = -1, },
>>>> +	};
>>>>    -	clk = devm_clk_get(dev, id);
>>>> -	if (IS_ERR(clk))
>>>> -		return clk;
>>>> +	private_data->pclk = devm_clk_get(port->dev, "pclk");
>>>> +	if (IS_ERR(private_data->pclk))
>>>> +		return dev_err_probe(port->dev, PTR_ERR(private_data->pclk),
>>>> +				     "Failed to get the 'pclk' clock\n");
>>>>    -	ret = clk_prepare_enable(clk);
>>>> -	if (ret) {
>>>> -		dev_err(dev, "couldn't enable clk\n");
>>>> -		return ERR_PTR(ret);
>>>> +	clk_baud = devm_clk_get(port->dev, "baud");
>>>> +	if (IS_ERR(clk_baud)) {
>>>> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
>>>> +		return PTR_ERR(clk_baud);
>>>>    	}
>>>>    -	devm_add_action_or_reset(dev,
>>>> -			(void(*)(void *))clk_disable_unprepare,
>>>> -			clk);
>>>> -
>>>> -	return clk;
>>>> -}
>>>> -
>>>> -static int meson_uart_probe_clocks(struct platform_device *pdev,
>>>> -				   struct uart_port *port)
>>>> -{
>>>> -	struct clk *clk_xtal = NULL;
>>>> -	struct clk *clk_pclk = NULL;
>>>> -	struct clk *clk_baud = NULL;
>>>> -
>>>> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>>>> -	if (IS_ERR(clk_pclk))
>>>> -		return PTR_ERR(clk_pclk);
>>>> -
>>>> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
>>>> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>>>>    	if (IS_ERR(clk_xtal))
>>>> -		return PTR_ERR(clk_xtal);
>>>> -
>>>> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
>>>> -	if (IS_ERR(clk_baud))
>>>> -		return PTR_ERR(clk_baud);
>>>> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
>>>> +				     "Failed to get the 'xtal' clock\n");
>>>> +
>>>> +	if (private_data->use_xtal_clk) {
>>>> +		hw = devm_clk_hw_register_divider_table(port->dev,
>>>> +							CLK_NAME(xtal_div),
>>>> +							__clk_get_name(clk_baud),
>>>> +							CLK_SET_RATE_NO_REPARENT,
>>>> +							port->membase + AML_UART_REG5,
>>>> +							26, 2,
>>>> +							CLK_DIVIDER_READ_ONLY,
>>>> +							xtal_div_table, NULL);
>>>> +		if (IS_ERR(hw))
>>>> +			return PTR_ERR(hw);
>>>> +
>>>> +		use_xtal_mux_parents[1].hw = hw;
>>>> +	} else {
>>>> +		hw = devm_clk_hw_register_fixed_factor(port->dev,
>>>> +						       CLK_NAME(clk81_div4),
>>>> +						       __clk_get_name(clk_baud),
>>>> +						       CLK_SET_RATE_NO_REPARENT,
>>>> +						       1, 4);
>>>> +		if (IS_ERR(hw))
>>>> +			return PTR_ERR(hw);
>>>> +
>>>> +		use_xtal_mux_parents[0].hw = hw;
>>>> +	}
>>> Contradiction with previous series.
>>> In the previous series we could clearly see that gxbb did not have the
>>> /4 divider. It did not have bits 26 and 27 either.
>>> Now gxbb get the /4 divider. It operated correctly without it so far, so
>>> this is rather suspicious. Could you please comment on this ?
>>>
>> As Martin and I discussed earlier.
>> meson6 and meson8b SoC.There are not have bits 26 and 27 either.
>> CLK81 is recommended for this part of SOC.
>>
>> GXL,GXM,GXBB and AXG SOC.The UART_EE_A_REG5[26] is added.
>> UART_EE_A_REG5[26]:
>> - 0x0: divide the input clock by 3 (meaning: this internally works
>> with an 8MHz clock)
>> - 0x1: use the input clock directly without further division (meaning:
>> this internally work with an 24MHz clock)
>> 8MHz is recommended for this part of SOC. Their UART IP configuration is
>> the same.
>>
>> G12A/B,,SM1,A1 and S4 SOC.The UART_EE_A_REG5[27] is added.
>> UART_EE_A_REG5[27]:
>> - 0x0: use the clock as configured in UART_EE_A_REG5[26]
>> - 0x1: divide the input clock by 2 (meaning: this internally works
>> with an 12MHz clock)
>> 12MHz is recommended for this part of SOC.
>>
>> NOTE:
>> 1. clk81 /4 divider.
>> There is a 4 divider inside, this is what the internal SOC designer told
>> me. But they forgot to document it. So it makes people feel suspicious.
>>
>> 2.The UART_EE_A_REG5 default value is 0,except for the console port(set in
>> romcode).All the baud rate clocks supported by UART can work, but different
>> chip usage scenarios suggest using that clock to reduce jitter.
>>
>> In summary, I would like to know your suggestions, including how to change
>> compatible.
>> Thank you so much!
> 
>  From your comment, gxbb should have "true" instead of false, isn't it ?
> 
Yes, You are right.
I don't see the need to split "amlogic, meson-gx-uart" compatible right 
now. I think the following change
{
.compatible = "amlogic,meson-gx-uart",
.data = (void *)true,
},
can satisfy all UART IP using XTAL. Because CCF automatically selects an 
appropriate clock source when setting baud rate.

I wonder if you agree with that. Or maybe you have a better idea. I'd 
like to know your opinion
>>
>>   >>
>>>> -	port->uartclk = clk_get_rate(clk_baud);
>>>> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
>>>> +					CLK_NAME(use_xtal),
>>>> +					ARRAY_SIZE(use_xtal_mux_parents),
>>>> +					NULL, NULL,
>>>> +					use_xtal_mux_parents,
>>>> +					CLK_SET_RATE_PARENT,
>>>> +					port->membase + AML_UART_REG5,
>>>> +					24, 0x1,
>>>> +					CLK_MUX_READ_ONLY,
>>>> +					NULL, NULL);
>>>> +	if (IS_ERR(hw))
>>>> +		return PTR_ERR(hw);
>>>> +
>>>> +	port->uartclk = clk_hw_get_rate(hw);
>>>> +
>>>> +	hw = devm_clk_hw_register_divider(port->dev,
>>>> +					  CLK_NAME(baud_div),
>>>> +					  clk_hw_get_name(hw),
>>>> +					  CLK_SET_RATE_PARENT,
>>>> +					  port->membase + AML_UART_REG5,
>>>> +					  0, 23,
>>>> +					  CLK_DIVIDER_ROUND_CLOSEST,
>>>> +					  NULL);
>>>> +	if (IS_ERR(hw))
>>>> +		return PTR_ERR(hw);
>>>> +
>>>> +	private_data->baud_clk = clk_hw_get_clk(hw, "baud_rate");
>>> I have already commented on the use of this function in the previous
>>> version.
>>> Please make sure all comments are addressed before re-posting
>>>
>> I'm sorry. I misunderstood you earlier. I will be changed to
>> "private_data->baud_clk = hw->clk;".What do you think?
> 
> yes
> 
>>>>      	return 0;
>>>>    }
>>>>      static int meson_uart_probe(struct platform_device *pdev)
>>>>    {
>>>> +	struct meson_uart_data *private_data;
>>>>    	struct resource *res_mem;
>>>>    	struct uart_port *port;
>>>>    	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>>>> @@ -716,18 +783,20 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>>    		return -EBUSY;
>>>>    	}
>>>>    -	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port),
>>>> GFP_KERNEL);
>>>> -	if (!port)
>>>> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
>>>> +				    GFP_KERNEL);
>>>> +	if (!private_data)
>>>>    		return -ENOMEM;
>>>>    +	if (device_get_match_data(&pdev->dev))
>>>> +		private_data->use_xtal_clk = true;
>>>> +
>>>> +	port = &private_data->port;
>>>> +
>>>>    	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
>>>>    	if (IS_ERR(port->membase))
>>>>    		return PTR_ERR(port->membase);
>>>>    -	ret = meson_uart_probe_clocks(pdev, port);
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>>    	port->iotype = UPIO_MEM;
>>>>    	port->mapbase = res_mem->start;
>>>>    	port->mapsize = resource_size(res_mem);
>>>> @@ -740,7 +809,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>>    	port->x_char = 0;
>>>>    	port->ops = &meson_uart_ops;
>>>>    	port->fifosize = fifosize;
>>>> +	port->private_data = private_data;
>>> port has private_data
>>> private_data has port
>>> Is it really necessary to have both ... looks to me that port in
>>> private_data is overkill
>>>
>> It's very thoughtful of you. I'll delete it as you suggested.
>>>>    +	ret = meson_uart_probe_clocks(port);
>>>> +	if (ret)
>>>> +		return ret;
>>>>    	meson_ports[pdev->id] = port;
>>>>    	platform_set_drvdata(pdev, port);
>>>>    @@ -766,10 +839,39 @@ static int meson_uart_remove(struct
>>>> platform_device *pdev)
>>>>    }
>>>>      static const struct of_device_id meson_uart_dt_match[] = {
>>>> -	{ .compatible = "amlogic,meson6-uart" },
>>>> -	{ .compatible = "amlogic,meson8-uart" },
>>>> -	{ .compatible = "amlogic,meson8b-uart" },
>>>> -	{ .compatible = "amlogic,meson-gx-uart" },
>>>> +	{
>>>> +		.compatible = "amlogic,meson6-uart",
>>>> +		.data = (void *)false,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,meson8-uart",
>>>> +		.data = (void *)false,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,meson8b-uart",
>>>> +		.data = (void *)false,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,meson-gxbb-uart",
>>>> +		.data = (void *)false,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,meson-gxl-uart",
>>>> +		.data = (void *)true,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,meson-g12a-uart",
>>>> +		.data = (void *)true,
>>>> +	},
>>>> +	/*
>>>> +	 * deprecated, don't use anymore because it doesn't differentiate
>>>> +	 * between GXBB, GXL and G12A which have different revisions
>>>> +	 * of the UART IP.
>>>> +	 */
>>>> +	{
>>>> +		.compatible = "amlogic,meson-gx-uart",
>>>> +		.data = (void *)false,
>>>> +	},
>>>>    	{ /* sentinel */ },
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
>>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
