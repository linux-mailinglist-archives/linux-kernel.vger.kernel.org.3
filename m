Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CB48A5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiAKCsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:48:45 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:13127 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiAKCso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:48:44 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 11 Jan
 2022 10:48:42 +0800
Message-ID: <cad33ab0-26d3-5b78-3bcf-62217aa70871@amlogic.com>
Date:   Tue, 11 Jan 2022 10:48:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V5 2/5] tty: serial: meson: Move request the register
 region.
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
 <20220110104214.25321-3-yu.tu@amlogic.com>
 <01066e66-5d97-ab40-b4a6-99e962b47073@kernel.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <01066e66-5d97-ab40-b4a6-99e962b47073@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri ,
	Thank you very much for your reply.

On 2022/1/10 19:58, Jiri Slaby wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 10. 01. 22, 11:42, Yu Tu wrote:
>> This simplifies resetting the UART controller during probe
>> and will make it easier to integrate the common clock code
>> which will require the registers at probe time as well.
> 
> And you are *also* switching devm_request_mem_region+devm_ioremap into 
> devm_ioremap_resource without even noting it here. It should've been 
> done in a separate patch.
> 
I can change it as you suggest。
The switching devm_request_mem_region+devm_ioremap into
devm_ioremap_resource in a separate patch.

> And no, do not resend a new version in the next few days. Having v5 in 
> 20 days is a bit too much. Give maintainers and reviewers some more 
> space to express themselves.
I am so sorry if PATCH is sent too frequently, which has disturbed you.
How often should I send it? Or under what circumstances can I send the 
next version?

>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 24 ++++++------------------
>>   1 file changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c 
>> b/drivers/tty/serial/meson_uart.c
>> index 45e00d928253..7570958d010c 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -395,24 +395,11 @@ static int meson_uart_verify_port(struct 
>> uart_port *port,
>>   static void meson_uart_release_port(struct uart_port *port)
>>   {
>> -    devm_iounmap(port->dev, port->membase);
>> -    port->membase = NULL;
>> -    devm_release_mem_region(port->dev, port->mapbase, port->mapsize);
>> +    /* nothing to do */
>>   }
>>   static int meson_uart_request_port(struct uart_port *port)
>>   {
>> -    if (!devm_request_mem_region(port->dev, port->mapbase, 
>> port->mapsize,
>> -                     dev_name(port->dev))) {
>> -        dev_err(port->dev, "Memory region busy\n");
>> -        return -EBUSY;
>> -    }
>> -
>> -    port->membase = devm_ioremap(port->dev, port->mapbase,
>> -                         port->mapsize);
>> -    if (!port->membase)
>> -        return -ENOMEM;
>> -
>>       return 0;
>>   }
>> @@ -733,6 +720,10 @@ static int meson_uart_probe(struct 
>> platform_device *pdev)
>>       if (!port)
>>           return -ENOMEM;
>> +    port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
>> +    if (IS_ERR(port->membase))
>> +        return PTR_ERR(port->membase);
>> +
>>       ret = meson_uart_probe_clocks(pdev, port);
>>       if (ret)
>>           return ret;
>> @@ -754,10 +745,7 @@ static int meson_uart_probe(struct 
>> platform_device *pdev)
>>       platform_set_drvdata(pdev, port);
>>       /* reset port before registering (and possibly registering 
>> console) */
>> -    if (meson_uart_request_port(port) >= 0) {
>> -        meson_uart_reset(port);
>> -        meson_uart_release_port(port);
>> -    }
>> +    meson_uart_reset(port);
>>       ret = uart_add_one_port(&meson_uart_driver, port);
>>       if (ret)
> 
> thanks,
