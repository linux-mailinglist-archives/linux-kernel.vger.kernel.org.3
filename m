Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CC4B9C09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiBQJ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:28:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiBQJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:28:33 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343DE1B8580;
        Thu, 17 Feb 2022 01:28:18 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F1C5022205;
        Thu, 17 Feb 2022 10:28:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645090092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vai3JcNhho2NPURv7arpvxFK2AjwuzWJAKxEayHRfNs=;
        b=kgLDtGqezDDwPggwOEZro7n30bgq/NTl0BH61oyiMMTgVKgy6QIVujMR94SZ3POmbR+Yhq
        PnMwrS/RKV/XI2VQYQTFHh2B/DC5rCZIJxWicZAXP58Jy29B3CXjj0Qh2w0cdbUZZrT0DH
        Pg15e76TZkXUUuydRp+X3AzDBaFQrzU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Feb 2022 10:28:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: atmel: add earlycon support
In-Reply-To: <9e499fdb-19dc-9b5a-0eb7-618acfd61605@microchip.com>
References: <20220216161822.1071245-1-michael@walle.cc>
 <9e499fdb-19dc-9b5a-0eb7-618acfd61605@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <2642ae55dca93181b0118423c8cd6f5a@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-02-17 10:12, schrieb Claudiu.Beznea@microchip.com:
> On 16.02.2022 18:18, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Add early console support which relies on the bootloader for the
>> initialization of the UART.
>> Please note, that the compatibles are taken from at91-usart MFD
>> driver.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/tty/serial/atmel_serial.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/atmel_serial.c 
>> b/drivers/tty/serial/atmel_serial.c
>> index 2d09a89974a2..50fc6d51ff0d 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2673,6 +2673,30 @@ static struct console atmel_console = {
>>         .data           = &atmel_uart,
>>  };
>> 
>> +static void atmel_serial_early_write(struct console *con, const char 
>> *s,
>> +                                    unsigned int n)
>> +{
>> +       struct earlycon_device *dev = con->data;
>> +
>> +       uart_console_write(&dev->port, s, n, atmel_console_putchar);
>> +}
>> +
>> +static int __init atmel_early_console_setup(struct earlycon_device 
>> *device,
>> +                                           const char *options)
>> +{
>> +       if (!device->port.membase)
>> +               return -ENODEV;
>> +
>> +       device->con->write = atmel_serial_early_write;
>> +
>> +       return 0;
>> +}
>> +
>> +OF_EARLYCON_DECLARE(atmelserial, "atmel,at91rm9200-usart",
>> +                   atmel_early_console_setup);
>> +OF_EARLYCON_DECLARE(atmelserial, "atmel,at91sam9260-usart",
> 
> 
> For consistency with the rest of the naming in this file could you name 
> it
> atmel_serial?

Sure, I don't have an opinion on that. It's done both ways:
omap-serial.c:OF_EARLYCON_DECLARE(omapserial, "ti,omap2-uart", 
early_omap_serial_setup);
bcm63xx_uart.c:OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", 
bcm_early_console_setup);
...

> Also, it would be good to select SERIAL_EARLYCON in Kconfig to have it
> available also for production w/o changing defconfigs.

Ahh, missed that these are enabled for all the other Kconfig symbols.
Will add it to SERIAL_ATMEL_CONSOLE.

-michael
