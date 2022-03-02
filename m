Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF94C9B12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiCBCQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiCBCQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:16:00 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCC4A6538;
        Tue,  1 Mar 2022 18:15:17 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 2 Mar
 2022 10:15:14 +0800
Message-ID: <6f120165-b6ec-ab71-ee42-e3246726f4f1@amlogic.com>
Date:   Wed, 2 Mar 2022 10:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <1j8rtvxnkv.fsf@starbuckisacylon.baylibre.com>
 <d0da38f1-72c1-d111-2d0d-2bfa2faf1a1d@amlogic.com>
 <1jilsyvyz9.fsf@starbuckisacylon.baylibre.com>
 <0054cf2f-f09d-5b01-d6ca-0dc877a757c3@amlogic.com>
 <c23fe6e7-879a-fab6-71ba-fcebdaf7ae37@baylibre.com>
 <4712c41c-fc9f-e8d1-c233-a6c2de0c23dd@amlogic.com>
In-Reply-To: <4712c41c-fc9f-e8d1-c233-a6c2de0c23dd@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
	I have no problem with trying to revert this list of submissions. I'm 
sorry about that.

On 2022/3/1 18:12, Yu Tu wrote:
> Hi Neil,
>      Thank you very much for your advice.
> 
> On 2022/3/1 17:27, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> On 01/03/2022 10:01, Yu Tu wrote:
>>> Hi Jerome,
>>>
>>> On 2022/3/1 16:36, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>>
>>>> On Tue 01 Mar 2022 at 13:54, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> Hi Jerome,
>>>>>
>>>>> On 2022/2/28 18:59, Jerome Brunet wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>> On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>>
>>>>>>> Using the common Clock code to describe the UART baud rate
>>>>>>> clock makes it easier for the UART driver to be compatible
>>>>>>> with the baud rate requirements of the UART IP on different
>>>>>>> meson chips. Add Meson S4 SoC compatible.
>>>>>>>
>>>>>>> The test method:
>>>>>>> Start the console and run the following commands in turn:
>>>>>>> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>>>>>>>
>>>>>>> Since most SoCs are too old, I was able to find all the platforms 
>>>>>>> myself
>>>>>>> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it 
>>>>>>> with
>>>>>>> G12A and S4.
>>>>>> GXL based board are still very common an easy to come by.
>>>>>> I'm quite surprised that you are unable to test on this SoC family
>>>>> The fact of the matter is that the S4 is our end-2020 chip, the 
>>>>> G12A is
>>>>> five years old, and the GXL is seven years old. If you must ask for a
>>>>> test, I will report this problem to the leadership to coordinate 
>>>>> resources.
>>>>
>>>> The age of the SoC is irrelevant. SoCs don't get deprecated based on 
>>>> age
>>>> in mainline. It is not just GXL, same goes for meson8.
>>>>
>>>> These SoCs are actively used. Boards with these SoCs are still sold and
>>>> easily available. See the VIM1 or the Libretech boards.
>>>>
>>>> Breaking things for the the users of these SoCs is not acceptable.
>>>> So yes, looking at your series, I strongly recommend you do more tests.
>>>>
>>> You have a point there. Let's go back to the root of the problem. I 
>>> aim to increase S4. The S4 uses 12MHZ to calculate baud. That's all.
>>> Change it to CCF as you suggested. The changes are so large that you 
>>> ask to test all the chips.
>>> I also mentioned last time that using CCF would lead to a longer 
>>> drive probe time and affect the board startup time. If this problem 
>>> is not solved, can we reject the way you suggest using CCF?
>>
>> I have a much simpler proposal (non-tested):
>>
> I can test it for you. But if you need to add S4 chips. Again, we need 
> to add a judgment. Is that acceptable to you?
> 
> What we've been talking about for a long time is how to make the least 
> changes and the least impact for the S4.
> 
> The fact is that Amlogic has recommended 12MHz for baud rates for all 
> chips starting with the G12A. I really doubt whether the G12A/B and SM1 
> were tested before. So if we want to upload subsequent Amlogic chips, 
> not only the S4 needs to solve the 12MHz problem, but other chips can't 
> get around this area.
>> ============><===================================================
>> diff --git a/drivers/tty/serial/meson_uart.c 
>> b/drivers/tty/serial/meson_uart.c
>> index 45e00d928253..eda3fdad60d1 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -76,6 +76,12 @@
>>   #define AML_UART_POLL_USEC        5
>>   #define AML_UART_TIMEOUT_USEC        10000
>>
>> +struct meson_uart_data {
>> +    struct clk    *clk_pclk;
>> +    struct clk    *clk_xtal;
>> +    struct clk    *clk_baud;
>> +};
>> +
>>   static struct uart_driver meson_uart_driver;
>>
>>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>> @@ -293,16 +299,17 @@ static int meson_uart_startup(struct uart_port 
>> *port)
>>
>>   static void meson_uart_change_speed(struct uart_port *port, unsigned 
>> long baud)
>>   {
>> +    struct meson_uart_data *private_data = port->private_data;
>>       u32 val;
>>
>>       while (!meson_uart_tx_empty(port))
>>           cpu_relax();
>>
>> -    if (port->uartclk == 24000000) {
>> -        val = ((port->uartclk / 3) / baud) - 1;
>> +    if (clk_is_match(private_data->clk_baud, private_data->clk_xtal)) {
>> +        val = ((clk_get_rate(private_data->clk_baud) / 3) / baud) - 1;
>>           val |= AML_UART_BAUD_XTAL;
>>       } else {
>> -        val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
>> +        val = ((clk_get_rate(private_data->clk_baud) * 10 / (baud * 
>> 4) + 5) / 10) - 1;
>>       }
>>       val |= AML_UART_BAUD_USE;
>>       writel(val, port->membase + AML_UART_REG5);
>> @@ -666,31 +673,26 @@ static inline struct clk 
>> *meson_uart_probe_clock(struct device *dev,
>>   }
>>
>>   static int meson_uart_probe_clocks(struct platform_device *pdev,
>> -                   struct uart_port *port)
>> +                   struct meson_uart_data *private_data)
>>   {
>> -    struct clk *clk_xtal = NULL;
>> -    struct clk *clk_pclk = NULL;
>> -    struct clk *clk_baud = NULL;
>> -
>> -    clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>> -    if (IS_ERR(clk_pclk))
>> -        return PTR_ERR(clk_pclk);
>> +    private_data->clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
>> +    if (IS_ERR(private_data->clk_pclk))
>> +        return PTR_ERR(private_data->clk_pclk);
>>
>> -    clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
>> -    if (IS_ERR(clk_xtal))
>> -        return PTR_ERR(clk_xtal);
>> +    private_data->clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
>> +    if (IS_ERR(private_data->clk_xtal))
>> +        return PTR_ERR(private_data->clk_xtal);
>>
>> -    clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
>> -    if (IS_ERR(clk_baud))
>> -        return PTR_ERR(clk_baud);
>> -
>> -    port->uartclk = clk_get_rate(clk_baud);
>> +    private_data->clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
>> +    if (IS_ERR(private_data->clk_baud))
>> +        return PTR_ERR(private_data->clk_baud);
>>
>>       return 0;
>>   }
>>
>>   static int meson_uart_probe(struct platform_device *pdev)
>>   {
>> +    struct meson_uart_data *private_data;
>>       struct resource *res_mem;
>>       struct uart_port *port;
>>       u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>> @@ -714,6 +716,11 @@ static int meson_uart_probe(struct 
>> platform_device *pdev)
>>       if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
>>           return -EINVAL;
>>
>> +    private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
>> +                    GFP_KERNEL);
>> +    if (!private_data)
>> +        return -ENOMEM;
>> +
>>       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       if (!res_mem)
>>           return -ENODEV;
>> @@ -733,7 +740,7 @@ static int meson_uart_probe(struct platform_device 
>> *pdev)
>>       if (!port)
>>           return -ENOMEM;
>>
>> -    ret = meson_uart_probe_clocks(pdev, port);
>> +    ret = meson_uart_probe_clocks(pdev, private_data);
>>       if (ret)
>>           return ret;
>>
>> @@ -749,6 +756,7 @@ static int meson_uart_probe(struct platform_device 
>> *pdev)
>>       port->x_char = 0;
>>       port->ops = &meson_uart_ops;
>>       port->fifosize = fifosize;
>> +    port->private_data = private_data;
>>
>>       meson_ports[pdev->id] = port;
>>       platform_set_drvdata(pdev, port);
>> ============><===================================================
>>
>> Neil
>>
>>>>>>
>>>>>>>
>>>>>>> Yu Tu (6):
>>>>>>>     tty: serial: meson: Move request the register region to probe
>>>>>>>     tty: serial: meson: Use devm_ioremap_resource to get register 
>>>>>>> mapped
>>>>>>>       memory
>>>>>>>     tty: serial: meson: Describes the calculation of the UART 
>>>>>>> baud rate
>>>>>>>       clock using a clock frame
>>>>>>>     tty: serial: meson: Make some bit of the REG5 register writable
>>>>>>>     tty: serial: meson: The system stuck when you run the stty 
>>>>>>> command on
>>>>>>>       the console to change the baud rate
>>>>>>>     tty: serial: meson: Added S4 SOC compatibility
>>>>>>>
>>>>>>> V6 -> V7: To solve the system stuck when you run the stty command on
>>>>>>> the console to change the baud rate.
>>>>>>> V5 -> V6: Change error format as discussed in the email.
>>>>>>> V4 -> V5: Change error format.
>>>>>>> V3 -> V4: Change CCF to describe the UART baud rate clock as 
>>>>>>> discussed
>>>>>>> in the email.
>>>>>>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it 
>>>>>>> must change
>>>>>>> the DTS before it can be deleted
>>>>>>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some 
>>>>>>> changes as
>>>>>>> discussed in the email
>>>>>>>
>>>>>>> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/ 
>>>>>>>
>>>>>>>
>>>>>>>    drivers/tty/serial/meson_uart.c | 221 
>>>>>>> ++++++++++++++++++++++----------
>>>>>>>    1 file changed, 154 insertions(+), 67 deletions(-)
>>>>>>>
>>>>>>>
>>>>>>> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8
>>>>>>
>>>>
>>
