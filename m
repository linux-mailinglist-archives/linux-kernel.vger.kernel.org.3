Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3269248437E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiADOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:35:59 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:6049 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiADOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:35:58 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 4 Jan
 2022 22:35:55 +0800
Message-ID: <318ec2df-b73b-520b-f5ac-d0d2fce0eff0@amlogic.com>
Date:   Tue, 4 Jan 2022 22:35:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com>
 <1jfsq57wym.fsf@starbuckisacylon.baylibre.com>
 <264367c8-2de1-ebd1-0843-e4e33a8407a6@amlogic.com>
 <1jpmp7rc1z.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jpmp7rc1z.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
	Thank you very much for your patient reply. I have learned a lot from it.

On 2022/1/4 18:36, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Tue 04 Jan 2022 at 17:57, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Hi Jerome,
>> 	Thank you very much for your reply.
>>
>> On 2022/1/3 20:40, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Thu 30 Dec 2021 at 18:21, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>> Using the common Clock code to describe the UART baud rate clock makes
>>>> it easier for the UART driver to be compatible with the baud rate
>>>> requirements of the UART IP on different meson chips
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    drivers/tty/serial/Kconfig      |   1 +
>>>>    drivers/tty/serial/meson_uart.c | 311 ++++++++++++++++++++++++++------
>>>>    2 files changed, 257 insertions(+), 55 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>> index 780908d43557..32e238173036 100644
>>>> --- a/drivers/tty/serial/Kconfig
>>>> +++ b/drivers/tty/serial/Kconfig
>>>> @@ -198,6 +198,7 @@ config SERIAL_KGDB_NMI
>>>>    config SERIAL_MESON
>>>>    	tristate "Meson serial port support"
>>>>    	depends on ARCH_MESON
>>>> +	depends on COMMON_CLK
>>>>    	select SERIAL_CORE
>>>>    	help
>>>>    	  This enables the driver for the on-chip UARTs of the Amlogic
>>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>>> index 99efe62a1507..07eb1f40aaaa 100644
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
>>>> @@ -76,6 +75,21 @@
>>>>    #define AML_UART_POLL_USEC		5
>>>>    #define AML_UART_TIMEOUT_USEC		10000
>>>>    +struct meson_uart_data {
>>>> +	struct uart_port	port;
>>>> +	struct clk		*pclk;
>>>> +	struct clk		*baud_clk;
>>>> +	struct clk_divider	baud_div;
>>>> +	struct clk_mux		use_xtal_mux;
>>>> +	struct clk_mux		xtal_clk_sel_mux;
>>>> +	struct clk_mux		xtal2_clk_sel_mux;
>>>> +	struct clk_fixed_factor	xtal_div2;
>>>> +	struct clk_fixed_factor	xtal_div3;
>>>> +	struct clk_fixed_factor	clk81_div4;
>>> Keeping all these internal elements around is not useful since they are
>>> registered using devm_
>>>
>> I'm sorry. I don't know what you mean. That's exactly what you said, but
>> what's wrong, I don't understand. Do you have any better suggestions,
>> please specify specific points, preferably give examples.
> 
> I'm saying that you don't need to keep reference to the internal
> elements of the clock tree you have registered since devm_ will take
> care of the removal later on. IOW, Once they are registered, the pointer
> is never used again so you don't need it in the private data.
> 
I understand you now. What you say is right. I will correct it.
> 
>>>> +	bool			no_clk81_input;
>>> What is this ?
>>>
>> To distinguish between clK81 and XTAL.
> 
> ... Yet, it is not used
> 
>>>> +	bool			has_xtal_clk_sel;
>>>> +};
>>>> +
>>>>    static struct uart_driver meson_uart_driver;
>>>>      static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>>>> @@ -270,14 +284,11 @@ static void meson_uart_reset(struct uart_port *port)
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
>>>>    @@ -295,19 +306,17 @@ static int meson_uart_startup(struct uart_port
>>>> *port)
>>>>      static void meson_uart_change_speed(struct uart_port *port, unsigned
>>>> long baud)
>>>>    {
>>>> +	struct meson_uart_data *private_data = port->private_data;
>>>>    	u32 val;
>>>>      	while (!meson_uart_tx_empty(port))
>>>>    		cpu_relax();
>>>>    -	if (port->uartclk == 24000000) {
>>> This check shows that previous code assumed bit 24 was left untouched
>>> Below you can see that GXBB and newer used the XTAL path while older
>>> used the other
>>> Your change makes this dynamic which is another "unexpected" change.
>>> Please make the bit 24 mux RO to start with so the behavior remains unchanged
>>> for older SoCs.
>> I agree with what you say, and I will correct it.
>>>
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
>>>> @@ -397,11 +406,27 @@ static int meson_uart_verify_port(struct uart_port *port,
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
>>>> +
>>>> +	ret = clk_prepare_enable(private_data->baud_clk);
>>>> +	if (ret) {
>>>> +		clk_disable_unprepare(private_data->pclk);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>    	return 0;
>>>>    }
>>>>    @@ -629,56 +654,175 @@ static struct uart_driver meson_uart_driver = {
>>>>    	.cons		= MESON_SERIAL_CONSOLE,
>>>>    };
>>>>    -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>>>> -						 const char *id)
>>>> +static int meson_uart_register_clk(struct uart_port *port,
>>>> +				   const char *name_suffix,
>>>> +				   const struct clk_parent_data *parent_data,
>>>> +				   unsigned int num_parents,
>>>> +				   const struct clk_ops *ops,
>>>> +				   struct clk_hw *hw)
>>>>    {
>>>> -	struct clk *clk = NULL;
>>>> +	struct clk_init_data init = { };
>>>> +	char clk_name[32];
>>>>    	int ret;
>>>>    -	clk = devm_clk_get(dev, id);
>>>> -	if (IS_ERR(clk))
>>>> -		return clk;
>>>> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
>>>> +		 name_suffix);
>>>>    -	ret = clk_prepare_enable(clk);
>>>> -	if (ret) {
>>>> -		dev_err(dev, "couldn't enable clk\n");
>>>> -		return ERR_PTR(ret);
>>>> -	}
>>>> +	init.name = clk_name;
>>>> +	init.ops = ops;
>>>> +	init.flags = CLK_SET_RATE_PARENT;
>>>> +	init.parent_data = parent_data;
>>>> +	init.num_parents = num_parents;
>>>> +
>>>> +	hw->init = &init;
>>>>    -	devm_add_action_or_reset(dev,
>>>> -			(void(*)(void *))clk_disable_unprepare,
>>>> -			clk);
>>>> +	ret = devm_clk_hw_register(port->dev, hw);
>>>> +	if (ret)
>>>> +		return dev_err_probe(port->dev, ret,
>>>> +				     "Failed to register the '%s' clock\n",
>>>> +				     clk_name);
>>>>    -	return clk;
>>>> +	return ret;
>>>>    }
>>>>    -static int meson_uart_probe_clocks(struct platform_device *pdev,
>>>> -				   struct uart_port *port)
>>>> -{
>>>> -	struct clk *clk_xtal = NULL;
>>>> -	struct clk *clk_pclk = NULL;
>>>> -	struct clk *clk_baud = NULL;
>>>> +static int meson_uart_probe_clocks(struct uart_port *port,
>>>> +				   bool register_clk81_div4)
>>>> +{
>>>> +	struct meson_uart_data *private_data = port->private_data;
>>>> +	struct clk_parent_data use_xtal_mux_parents[2] = {
>>>> +		{ .index = -1, },
>>>> +		{ .index = -1, },
>>>> +	};
>>>> +	struct clk_parent_data xtal_clk_sel_mux_parents[2] = { };
>>>> +	struct clk_parent_data xtal2_clk_sel_mux_parents[2] = { };
>>>> +	struct clk_parent_data xtal_div_parent = { .fw_name = "xtal", };
>>>> +	struct clk_parent_data clk81_div_parent = { .fw_name = "baud", };
>>>> +	struct clk_parent_data baud_div_parent = { };
>>>> +	struct clk *clk_baud, *clk_xtal;
>>>> +	int ret;
>>>>    -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>>>> -	if (IS_ERR(clk_pclk))
>>>> -		return PTR_ERR(clk_pclk);
>>>> +	private_data->pclk = devm_clk_get(port->dev, "pclk");
>>>> +	if (IS_ERR(private_data->pclk))
>>>> +		return dev_err_probe(port->dev, PTR_ERR(private_data->pclk),
>>>> +				     "Failed to get the 'pclk' clock\n");
>>>> +
>>>> +	clk_baud = devm_clk_get(port->dev, "baud");
>>>> +	if (IS_ERR(clk_baud))
>>>> +		return dev_err_probe(port->dev, PTR_ERR(clk_baud),
>>>> +				     "Failed to get the 'baud' clock\n");
>>>>    -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
>>>> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>>>>    	if (IS_ERR(clk_xtal))
>>>> -		return PTR_ERR(clk_xtal);
>>>> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
>>>> +				     "Failed to get the 'xtal' clock\n");
>>>> +
>>>> +	private_data->xtal_div3.mult = 1;
>>>> +	private_data->xtal_div3.div = 3;
>>>> +	ret = meson_uart_register_clk(port, "xtal_div3", &xtal_div_parent,
>>>> +				      1, &clk_fixed_factor_ops,
>>>> +				      &private_data->xtal_div3.hw);
>>>> +	if (ret)
>>>> +		return ret;
>>>>    -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
>>>> -	if (IS_ERR(clk_baud))
>>>> -		return PTR_ERR(clk_baud);
>>>> +	if (register_clk81_div4) {
>>> Clock dividers represent HW elements. The presence of an HW element
>>> cannot
>>> dependent on the current of the input clocks. There is no way this is right
>>>
>>>> +		private_data->clk81_div4.mult = 1;
>>>> +		private_data->clk81_div4.div = 4;
>>>> +		ret = meson_uart_register_clk(port, "clk81_div4",
>>>> +					      &clk81_div_parent, 1,
>>>> +					      &clk_fixed_factor_ops,
>>>> +					      &private_data->clk81_div4.hw);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		use_xtal_mux_parents[0].hw = &private_data->clk81_div4.hw;
>>> This is only going to be used on meson8 and older. Worst case it should
>>> depend
>>> on this compatible but I don't think this would be right here.
>>> IMO, this shows that the UART "baud" input was actually fed by a
>>> derivation of "fclk_div4" instead of "clk_81" on these older SoCs.
>>> So instead of registering what I suspect to be a fake element, the
>>> meson8 clock controller driver and DT should be fixed a this should go away.
>>>
>> Virtually all UART controllers are supported, but they are not used after
>> Meson8. So the description is more reasonable in UART driver.
> 
> No it is not. It's not virtual, the support for meson8 is there in
> mainline.
> 
> Unless you tell me there is an actual /4 divider in the UART block of
> the meson8 and older and that is was removed from the newer SoC,
> the bit above should be removed and the meson8 clock tree fixed.
> 
> I think it is more probable that the /4 was never there to begin with,
> and that clk81/4 aka "fclk_div4", which is already available from the
> clock controller, was actually routed on these older SoCs.
I will check with the chip design department if it is divided by 4. I'll 
get back to you.
> 
>>>> +	}
>>>>    -	port->uartclk = clk_get_rate(clk_baud);
>>>> +	if (private_data->has_xtal_clk_sel) {
>>>> +		private_data->xtal_div2.mult = 1;
>>>> +		private_data->xtal_div2.div = 2;
>>>> +		ret = meson_uart_register_clk(port, "xtal_div2",
>>>> +					      &xtal_div_parent, 1,
>>>> +					      &clk_fixed_factor_ops,
>>>> +					      &private_data->xtal_div2.hw);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		xtal_clk_sel_mux_parents[0].hw = &private_data->xtal_div3.hw;
>>>> +		xtal_clk_sel_mux_parents[1].fw_name = "xtal";
>>>> +
>>>> +		private_data->xtal_clk_sel_mux.reg = port->membase + AML_UART_REG5;
>>>> +		private_data->xtal_clk_sel_mux.mask = 0x1;
>>>> +		private_data->xtal_clk_sel_mux.shift = 26;
>>>> +		private_data->xtal_clk_sel_mux.flags = CLK_MUX_ROUND_CLOSEST;
>>>> +		ret = meson_uart_register_clk(port, "xtal_clk_sel",
>>>> +					      xtal_clk_sel_mux_parents,
>>>> +					      ARRAY_SIZE(xtal_clk_sel_mux_parents),
>>>> +					      &clk_mux_ops,
>>>> +					      &private_data->xtal_clk_sel_mux.hw);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		xtal2_clk_sel_mux_parents[0].hw = &private_data->xtal_clk_sel_mux.hw;
>>>> +		xtal2_clk_sel_mux_parents[1].hw = &private_data->xtal_div2.hw;
>>>> +
>>>> +		private_data->xtal2_clk_sel_mux.reg = port->membase + AML_UART_REG5;
>>>> +		private_data->xtal2_clk_sel_mux.mask = 0x1;
>>>> +		private_data->xtal2_clk_sel_mux.shift = 27;
>>>> +		private_data->xtal2_clk_sel_mux.flags = CLK_MUX_ROUND_CLOSEST;
>>>> +		ret = meson_uart_register_clk(port, "xtal2_clk_sel",
>>>> +					      xtal2_clk_sel_mux_parents,
>>>> +					      ARRAY_SIZE(xtal2_clk_sel_mux_parents),
>>>> +					      &clk_mux_ops,
>>>> +					      &private_data->xtal2_clk_sel_mux.hw);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		use_xtal_mux_parents[1].hw = &private_data->xtal2_clk_sel_mux.hw;
>>>> +	} else {
>>>> +		use_xtal_mux_parents[1].hw = &private_data->xtal_div3.hw;
>>> Well the above is a bit over-complicated. If I summarize:
>>> GXBB and older used a fixed divider of 3. Bits 26 and 27 read
>>> 0 according to the documentation.
>>> Chips after GXBB have 2 configurable divider of 2 and 3. bits 26 and 27
>>> selects which of these dividers is used.
>>> So the above could be replaced with a single divider covering bits 26 and
>>> 27
>>> with the following divider table { 2, 2, 1, 3 }. The divider should use
>>> RO ops and not have CLK_SET_RATE_PARENT. It can be used for all chips
>>> variant like this, including the older ones.
>>>
>> As you say, the way you say it is complicated. I think you're complicating
>> things.I don't understand what you're trying to achieve.
>> Can you be more specific?
> 
> I'm proposing to replace the 4 elements above, paths, parent_table and
> all with a single divider with a specific table. It accomplishes the same thing.
> 
> |--------+--------+-----------|
> | Bit 27 | Bit 26 | Div Value |
> |--------+--------+-----------|
> |      0 |      0 |         3 |
> |--------+--------+-----------|
> |      0 |      1 |         1 |
> |--------+--------+-----------|
> |      1 |      0 |         2 |
> |--------+--------+-----------|
> |      1 |      1 |         2 |
> |--------+--------+-----------|
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/clk-provider.h?h=v5.16-rc8#n602
> 
> something like:
> 
> static struct clk_div_table reg5_table[] = {
> 	{ 0, 3 },
>          { 1, 1 },
>          { 2, 2 },
>          { 3, 2 },
> };
> 
> I'm also pointing out that, since bit 26 and 27 reads 0 on the older
> SoCs, the divider would work for these too, as long as the Ops is
> read-only. So you don't even need to register different element
> depending on the SoC which simplify things a bit more.
> 
> If you prefer to keep a fixed divider for the older ones, It's fine by
> me. It gives a bit more work but it is closer to reality. The newer SoC
> could still use the custom divider regardless.
> 
> Last, and as explained on other bits, that part of the clock path should
> remain RO at first, to keep behavior stable with this change. You may
> change that later on, in a dedicated patch describing the change.
> 
I understand what you mean, and i will try to realize it. I hope you can 
help review and give me your suggestions.
>>
>>> The only information you need to carry if whether or not you want to
>>> make this divider modifiable. This means using the dt data to store
>>> clk_div_ops or clk_div_ro_ops pointer.
>>> To avoid changing the behavior of the older platforms in this patch, I
>>> would
>>> suggest to make everything use clk_div_ro_ops first, and make another
>>> patch to use clk_div_ops if necessary.
>>>
>>>> +	}
>>>> +
>>>> +	private_data->use_xtal_mux.reg = port->membase + AML_UART_REG5;
>>>> +	private_data->use_xtal_mux.mask = 0x1;
>>>> +	private_data->use_xtal_mux.shift = 24;
>>>> +	private_data->use_xtal_mux.flags = CLK_MUX_ROUND_CLOSEST;
>>>> +	ret = meson_uart_register_clk(port, "use_xtal", use_xtal_mux_parents,
>>>> +				      ARRAY_SIZE(use_xtal_mux_parents),
>>>> +				      &clk_mux_ops,
>>> Use RO ops here to start with.
>>> You can make this writable with another patch explicitly describing the change.
>> I agree with what you say, and I will correct it.
>>>
>>>> +				      &private_data->use_xtal_mux.hw);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	baud_div_parent.hw = &private_data->use_xtal_mux.hw;
>>>> +
>>>> +	private_data->baud_div.reg = port->membase + AML_UART_REG5;
>>>> +	private_data->baud_div.shift = 0;
>>>> +	private_data->baud_div.width = 23;
>>>> +	private_data->baud_div.flags = CLK_DIVIDER_ROUND_CLOSEST;
>>>> +	ret = meson_uart_register_clk(port, "baud_div",
>>>> +				      &baud_div_parent, 1,
>>>> +				      &clk_divider_ops,
>>>> +				      &private_data->baud_div.hw);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	private_data->baud_clk = devm_clk_hw_get_clk(port->dev,
>>>> +						     &private_data->baud_div.hw,
>>>> +						     "baud_rate");
>>> There is a problem with this function in CCF. It will pin the driver to
>>> itself, making it unremovable. It is an ongoing topic. For now, just use
>>> "hw->clk" to get the struct *clk.
>>>
>>>> +	if (IS_ERR(private_data->baud_clk))
>>>> +		return dev_err_probe(port->dev,
>>> I don't think anything can defer here, so dev_err_probe() is not
>>> necessary I think
>>>
>> I agree with what you say, and I will correct it.
>>>> +				     PTR_ERR(private_data->baud_clk),
>>>> +				     "Failed to request the 'baud_rate' clock\n");
>>>>      	return 0;
>>>>    }
>>>>      static int meson_uart_probe(struct platform_device *pdev)
>>>>    {
>>>> +	struct meson_uart_data *private_data;
>>>>    	struct resource *res_mem, *res_irq;
>>>> +	struct clk *clk_baud, *clk_xtal;
>>>> +	bool register_clk81_div4;
>>>>    	struct uart_port *port;
>>>>    	int ret = 0;
>>>>    	int id = -1;
>>>> @@ -711,18 +855,37 @@ static int meson_uart_probe(struct platform_device *pdev)
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
>>>> +		private_data->has_xtal_clk_sel = true;
>>>> +
>>>> +	private_data->pclk = devm_clk_get(&pdev->dev, "pclk");
>>>> +	if (IS_ERR(private_data->pclk))
>>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(private_data->pclk),
>>>> +				     "Failed to get the 'pclk' clock\n");
>>>> +
>>>> +	clk_baud = devm_clk_get(&pdev->dev, "baud");
>>>> +	if (IS_ERR(clk_baud))
>>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk_baud),
>>>> +				     "Failed to get the 'baud' clock\n");
>>>> +
>>>> +	clk_xtal = devm_clk_get(&pdev->dev, "xtal");
>>>> +	if (IS_ERR(clk_xtal))
>>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk_xtal),
>>>> +				     "Failed to get the 'xtal' clock\n");
>>>> +
>>> This is second time you call devm_clk_get() on these clocks. One
>>> instance has to go away
>>>
>> I agree with what you say, and I will correct it.
>>>> +	register_clk81_div4 = clk_get_rate(clk_xtal) != clk_get_rate(clk_baud);
>>>> +
>>> The above is a ugly way to distinguish the meson8 (32bit) SoC family
>>> from the rest. This definitely not the way to achieve it.
>>> The right is the compatible data but here I think it is not
>>> necessary. The clock input should be fixed.
>>>
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
>>>> @@ -735,6 +898,12 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>>    	port->x_char = 0;
>>>>    	port->ops = &meson_uart_ops;
>>>>    	port->fifosize = 64;
>>>> +	port->uartclk = clk_get_rate(clk_baud);
>>>> +	port->private_data = private_data;
>>>> +
>>>> +	ret = meson_uart_probe_clocks(port, register_clk81_div4);
>>>> +	if (ret)
>>>> +		return ret;
>>>>      	meson_ports[pdev->id] = port;
>>>>    	platform_set_drvdata(pdev, port);
>>>> @@ -761,10 +930,42 @@ static int meson_uart_remove(struct platform_device *pdev)
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
>>>> +	{
>>>> +		.compatible = "amlogic,meson-s4-uart",
>>>> +		.data = (void *)true,
>>>> +	},
>>>> +	/*
>>>> +	 * deprecated, don't use anymore because it doesn't differentiate
>>>> +	 * between GXBB and GXL which have different revisions of the UART IP.
>>>> +	 */
>>>> +	{
>>>> +		.compatible = "amlogic,meson-gx-uart",
>>>> +		.data = (void *)false,
>>>> +	},
>>>>    	{ /* sentinel */ },
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
>>>
> 
