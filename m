Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A1502B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354072AbiDONkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354114AbiDONkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:40:04 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41B11C31;
        Fri, 15 Apr 2022 06:35:52 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 15 Apr
 2022 21:35:45 +0800
Message-ID: <77c83f45-3782-624d-36c4-dec5c53cdd09@amlogic.com>
Date:   Fri, 15 Apr 2022 21:35:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] tty: serial: meson: Added 12Mhz as the clock source
 for calculating baud rate
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220407081355.13602-1-yu.tu@amlogic.com>
 <20220407081355.13602-3-yu.tu@amlogic.com>
 <bedff186-8ce4-3cfd-aa67-f0375daf29b4@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <bedff186-8ce4-3cfd-aa67-f0375daf29b4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
	Thank you for your reply.

On 2022/4/7 22:03, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 07/04/2022 10:13, Yu Tu wrote:
>> Starting with the g12A chip, add a 12Mhz clock to calculate the baud
>> rate, since the BT module uses 3Mhz baud rate. 8Mhz calculations can
>> lead to baud rate bias, causing some problems.
> 
> The commit message isn't clear enough, 12MHz is a new intermediate clock
> rate, not a new clock source of the UART module.
> 
> Please explain a /2 divider over XTAL was introduced since G12A, and
> is preferred to be used over the still present /3 divider since it
> provides much closer frequencies vs the request baudrate.
> 
I will prepare the next version of the code as you requested.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c 
>> b/drivers/tty/serial/meson_uart.c
>> index 8e59624935af..7e77693a1318 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -68,6 +68,7 @@
>>   #define AML_UART_BAUD_MASK        0x7fffff
>>   #define AML_UART_BAUD_USE        BIT(23)
>>   #define AML_UART_BAUD_XTAL        BIT(24)
>> +#define AML_UART_BAUD_XTAL_DIV2        BIT(27)
>>   #define AML_UART_PORT_NUM        12
>>   #define AML_UART_PORT_OFFSET        6
>> @@ -80,6 +81,10 @@ static struct uart_driver meson_uart_driver;
>>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>> +struct meson_uart_data {
>> +    bool has_xtal_div2;
>> +};
>> +
>>   static void meson_uart_set_mctrl(struct uart_port *port, unsigned 
>> int mctrl)
>>   {
>>   }
>> @@ -293,13 +298,20 @@ static int meson_uart_startup(struct uart_port 
>> *port)
>>   static void meson_uart_change_speed(struct uart_port *port, unsigned 
>> long baud)
>>   {
>> -    u32 val;
>> +    struct meson_uart_data *private_data = port->private_data;
>> +    u32 val = 0;
>>       while (!meson_uart_tx_empty(port))
>>           cpu_relax();
>>       if (port->uartclk == 24000000) {
>> -        val = DIV_ROUND_CLOSEST(port->uartclk / 3, baud) - 1;
>> +        unsigned int xtal_div = 3;
>> +
>> +        if (private_data->has_xtal_div2) {
>> +            xtal_div = 2;
>> +            val |= AML_UART_BAUD_XTAL_DIV2;
>> +        }
>> +        val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, baud) - 1;
>>           val |= AML_UART_BAUD_XTAL;
>>       } else {
>>           val =  DIV_ROUND_CLOSEST(port->uartclk / 4, baud) - 1;
>> @@ -691,6 +703,7 @@ static int meson_uart_probe_clocks(struct 
>> platform_device *pdev,
>>   static int meson_uart_probe(struct platform_device *pdev)
>>   {
>> +    struct meson_uart_data *private_data;
>>       struct resource *res_mem;
>>       struct uart_port *port;
>>       u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>> @@ -733,6 +746,13 @@ static int meson_uart_probe(struct 
>> platform_device *pdev)
>>       if (!port)
>>           return -ENOMEM;
>> +    private_data = devm_kzalloc(&pdev->dev, sizeof(struct 
>> meson_uart_data), GFP_KERNEL);
>> +    if (!private_data)
>> +        return -ENOMEM;
>> +
>> +    if ((bool)device_get_match_data(&pdev->dev))
>> +        private_data->has_xtal_div2 = true;
> 
> It should be much cleaner to pass meson_uart_data to meson_uart_dt_match 
> .data,
> and then you can retrieve device_get_match_data() and put the result into
> port->private_data.
> This will avoid a devm_kzalloc().
> 
> Then in meson_uart_change_speed() change the test to check for NULL 
> private_data:
> if (private_data && private_data->has_xtal_div2)
> 
>> +
>>       ret = meson_uart_probe_clocks(pdev, port);
>>       if (ret)
>>           return ret;
>> @@ -749,6 +769,7 @@ static int meson_uart_probe(struct platform_device 
>> *pdev)
>>       port->x_char = 0;
>>       port->ops = &meson_uart_ops;
>>       port->fifosize = fifosize;
>> +    port->private_data = private_data;
>>       meson_ports[pdev->id] = port;
>>       platform_set_drvdata(pdev, port);
> 
> Neil
>
I will prepare the next version of the code as you requested.

> .
