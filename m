Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7248A624
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiAKDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:13:58 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:8314 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiAKDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:13:55 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 11 Jan
 2022 11:13:53 +0800
Message-ID: <2710be28-3e01-081d-a726-b37b7c053f96@amlogic.com>
Date:   Tue, 11 Jan 2022 11:13:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V5 3/5] tty: serial: meson: Using the common clock code
 describe.
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110104214.25321-1-yu.tu@amlogic.com>
 <20220110104214.25321-4-yu.tu@amlogic.com>
 <327f985f-bbf1-00ba-d203-cc9d5bbd955c@kernel.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <327f985f-bbf1-00ba-d203-cc9d5bbd955c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,
	Thank you very much for your reply.

On 2022/1/10 20:11, Jiri Slaby wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> "Subject: Using the common clock code describe."
> 
> Please reformulate that ^^^ -- I cannot make any sense of it. And avoid 
> adding a period to the subject. PLease see others' commit logs.
> 
I will correct this in the next version.

> On 10. 01. 22, 11:42, Yu Tu wrote:
>> Using the common Clock code to describe the UART baud rate clock
>> makes it easier for the UART driver to be compatible with the
>> baud rate requirements of the UART IP on different meson chips.
> 
> 
> 
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 224 +++++++++++++++++++++++---------
>>   1 file changed, 163 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c 
>> b/drivers/tty/serial/meson_uart.c
>> index 7570958d010c..1004fd0b0c9e 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -6,6 +6,7 @@
>>    */
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/console.h>
>>   #include <linux/delay.h>
>>   #include <linux/init.h>
>> @@ -65,9 +66,7 @@
>>   #define AML_UART_RECV_IRQ(c)        ((c) & 0xff)
>>   /* AML_UART_REG5 bits */
>> -#define AML_UART_BAUD_MASK        0x7fffff
>>   #define AML_UART_BAUD_USE        BIT(23)
>> -#define AML_UART_BAUD_XTAL        BIT(24)
>>   #define AML_UART_PORT_NUM        12
>>   #define AML_UART_PORT_OFFSET        6
>> @@ -76,6 +75,13 @@
>>   #define AML_UART_POLL_USEC        5
>>   #define AML_UART_TIMEOUT_USEC        10000
>> +struct meson_uart_data {
>> +    struct uart_port    port;
>> +    struct clk        *pclk;
>> +    struct clk        *baud_clk;
>> +    bool            use_xtal_clk;
>> +};
>> +
>>   static struct uart_driver meson_uart_driver;
>>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>> @@ -268,14 +274,11 @@ static void meson_uart_reset(struct uart_port 
>> *port)
>>   static int meson_uart_startup(struct uart_port *port)
>>   {
>>       u32 val;
>> -    int ret = 0;
>> +    int ret;
>> -    val = readl(port->membase + AML_UART_CONTROL);
>> -    val |= AML_UART_CLEAR_ERR;
>> -    writel(val, port->membase + AML_UART_CONTROL);
>> -    val &= ~AML_UART_CLEAR_ERR;
>> -    writel(val, port->membase + AML_UART_CONTROL);
>> +    meson_uart_reset(port);
> 
> Why is this OK? We didn't use to reset it.
This change simply optimizes the code. Because the meson_uart_reset 
function has implemented the control logic.
> 
> And why is this not done in a separate patch?
I will consider merging with the previous patch as a patch.
> 
> 
>> +    val = readl(port->membase + AML_UART_CONTROL);
>>       val |= (AML_UART_RX_EN | AML_UART_TX_EN);
>>       writel(val, port->membase + AML_UART_CONTROL);
>> @@ -293,19 +296,17 @@ static int meson_uart_startup(struct uart_port 
>> *port)
>>   static void meson_uart_change_speed(struct uart_port *port, unsigned 
>> long baud)
>>   {
>> +    struct meson_uart_data *private_data = port->private_data;
>>       u32 val;
>>       while (!meson_uart_tx_empty(port))
>>           cpu_relax();
>> -    if (port->uartclk == 24000000) {
>> -        val = ((port->uartclk / 3) / baud) - 1;
>> -        val |= AML_UART_BAUD_XTAL;
>> -    } else {
>> -        val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
>> -    }
>> +    val = readl(port->membase + AML_UART_REG5);
>>       val |= AML_UART_BAUD_USE;
>>       writel(val, port->membase + AML_UART_REG5);
>> +
>> +    clk_set_rate(private_data->baud_clk, baud);
>>   }
>>   static void meson_uart_set_termios(struct uart_port *port,
>> @@ -395,11 +396,27 @@ static int meson_uart_verify_port(struct 
>> uart_port *port,
>>   static void meson_uart_release_port(struct uart_port *port)
>>   {
>> -    /* nothing to do */
>> +    struct meson_uart_data *private_data = port->private_data;
>> +
>> +    clk_disable_unprepare(private_data->baud_clk);
>> +    clk_disable_unprepare(private_data->pclk);
>>   }
>>   static int meson_uart_request_port(struct uart_port *port)
>>   {
>> +    struct meson_uart_data *private_data = port->private_data;
>> +    int ret;
>> +
>> +    ret = clk_prepare_enable(private_data->pclk);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = clk_prepare_enable(private_data->baud_clk);
>> +    if (ret) {
>> +        clk_disable_unprepare(private_data->pclk);
>> +        return ret;
>> +    }
>> +
>>       return 0;
>>   }
>> @@ -629,55 +646,105 @@ static struct uart_driver meson_uart_driver = {
>>       .cons        = MESON_SERIAL_CONSOLE,
>>   };
>> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>> -                         const char *id)
>> +#define CLK_NAME(name) \
>> +({\
>> +    char clk_name[32];\
>> +    snprintf(clk_name, sizeof(clk_name), "%s#%s", 
>> dev_name(port->dev), #name);\
>> +    clk_name;\
>> +})
> 
> This is cryptic and duplicates the variable on the stack. Why not expand 
> the macro and delete it then?
> 
I've overdone it. I'll move it to the meson_uart_probe_clocks function 
as you suggested and delete it.
>> +
>> +static struct clk_div_table xtal_div_table[] = {
>> +    { 0, 3  },
> 
> An extra space here and there:
> 
>> +    { 1, 1  },
>> +    { 2, 2  },
>> +    { 3, 2  },
>> +};
>> +
Sorry, stupid mistake. I will correct.

>> +static int meson_uart_probe_clocks(struct uart_port *port)
>>   {
>> -    struct clk *clk = NULL;
>> -    int ret;
>> +    struct meson_uart_data *private_data = port->private_data;
>> +    struct clk *clk_baud, *clk_xtal;
>> +    struct clk_hw *hw;
>> +    struct clk_parent_data use_xtal_mux_parents[2] = {
>> +        { .index = -1, },
>> +        { .index = -1, },
>> +    };
>> -    clk = devm_clk_get(dev, id);
>> -    if (IS_ERR(clk))
>> -        return clk;
>> +    private_data->pclk = devm_clk_get(port->dev, "pclk");
>> +    if (IS_ERR(private_data->pclk))
>> +        return dev_err_probe(port->dev, PTR_ERR(private_data->pclk),
>> +                     "Failed to get the 'pclk' clock\n");
>> -    ret = clk_prepare_enable(clk);
>> -    if (ret) {
>> -        dev_err(dev, "couldn't enable clk\n");
>> -        return ERR_PTR(ret);
>> +    clk_baud = devm_clk_get(port->dev, "baud");
>> +    if (IS_ERR(clk_baud)) {
>> +        dev_err(port->dev, "Failed to get the 'baud' clock\n");
>> +        return PTR_ERR(clk_baud);
>>       }
>> -    devm_add_action_or_reset(dev,
>> -            (void(*)(void *))clk_disable_unprepare,
>> -            clk);
>> -
>> -    return clk;
>> -}
>> -
>> -static int meson_uart_probe_clocks(struct platform_device *pdev,
>> -                   struct uart_port *port)
>> -{
>> -    struct clk *clk_xtal = NULL;
>> -    struct clk *clk_pclk = NULL;
>> -    struct clk *clk_baud = NULL;
>> -
>> -    clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>> -    if (IS_ERR(clk_pclk))
>> -        return PTR_ERR(clk_pclk);
>> -
>> -    clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
>> +    clk_xtal = devm_clk_get(port->dev, "xtal");
>>       if (IS_ERR(clk_xtal))
>> -        return PTR_ERR(clk_xtal);
>> -
>> -    clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
>> -    if (IS_ERR(clk_baud))
>> -        return PTR_ERR(clk_baud);
>> +        return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
>> +                     "Failed to get the 'xtal' clock\n");
>> +
>> +    if (private_data->use_xtal_clk) {
>> +        hw = devm_clk_hw_register_divider_table(port->dev,
>> +                            CLK_NAME(xtal_div),
>> +                            __clk_get_name(clk_baud),
>> +                            CLK_SET_RATE_NO_REPARENT,
>> +                            port->membase + AML_UART_REG5,
>> +                            26, 2,
>> +                            CLK_DIVIDER_READ_ONLY,
>> +                            xtal_div_table, NULL);
>> +        if (IS_ERR(hw))
>> +            return PTR_ERR(hw);
>> +
>> +        use_xtal_mux_parents[1].hw = hw;
>> +    } else {
>> +        hw = devm_clk_hw_register_fixed_factor(port->dev,
>> +                               CLK_NAME(clk81_div4),
>> +                               __clk_get_name(clk_baud),
>> +                               CLK_SET_RATE_NO_REPARENT,
>> +                               1, 4);
>> +        if (IS_ERR(hw))
>> +            return PTR_ERR(hw);
>> +
>> +        use_xtal_mux_parents[0].hw = hw;
>> +    }
>> -    port->uartclk = clk_get_rate(clk_baud);
>> +    hw = __devm_clk_hw_register_mux(port->dev, NULL,
>> +                    CLK_NAME(use_xtal),
>> +                    ARRAY_SIZE(use_xtal_mux_parents),
>> +                    NULL, NULL,
>> +                    use_xtal_mux_parents,
>> +                    CLK_SET_RATE_PARENT,
>> +                    port->membase + AML_UART_REG5,
>> +                    24, 0x1,
>> +                    CLK_MUX_READ_ONLY,
>> +                    NULL, NULL);
>> +    if (IS_ERR(hw))
>> +        return PTR_ERR(hw);
>> +
>> +    port->uartclk = clk_hw_get_rate(hw);
>> +
>> +    hw = devm_clk_hw_register_divider(port->dev,
>> +                      CLK_NAME(baud_div),
>> +                      clk_hw_get_name(hw),
>> +                      CLK_SET_RATE_PARENT,
>> +                      port->membase + AML_UART_REG5,
>> +                      0, 23,
>> +                      CLK_DIVIDER_ROUND_CLOSEST,
>> +                      NULL);
>> +    if (IS_ERR(hw))
>> +        return PTR_ERR(hw);
>> +
>> +    private_data->baud_clk = clk_hw_get_clk(hw, "baud_rate");
>>       return 0;
>>   }
> 
> 
> 
