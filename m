Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11CD4A749F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiBBPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:30:47 -0500
Received: from foss.arm.com ([217.140.110.172]:37992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbiBBPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:30:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D586113E;
        Wed,  2 Feb 2022 07:30:46 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1971E3F73B;
        Wed,  2 Feb 2022 07:30:46 -0800 (PST)
Message-ID: <b7109e4d-560f-e328-ef5f-453e24031814@arm.com>
Date:   Wed, 2 Feb 2022 09:30:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Add ACPI support
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220201185001.926338-1-athierry@redhat.com>
 <412a456d-7294-a124-8a01-f052915348b4@gmail.com>
 <1ed6d576-63cb-fdd5-eaee-cc4154d25e0d@arm.com>
 <4502f052-9740-4e1e-0466-ddc92ff1fc0f@gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <4502f052-9740-4e1e-0466-ddc92ff1fc0f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/22 21:39, Florian Fainelli wrote:
> 
> 
> On 2/1/2022 12:42 PM, Jeremy Linton wrote:
>> Hi,
>>
>> On 2/1/22 13:24, Florian Fainelli wrote:
>>>
>>>
>>> On 2/1/2022 10:50 AM, Adrien Thierry wrote:
>>>> Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
>>>> use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI
>>>> firmware.
>>>>
>>>> Signed-off-by: Adrien Thierry <athierry@redhat.com>
>>>> ---
>>>>   drivers/tty/serial/8250/8250_bcm2835aux.c | 103 
>>>> +++++++++++++++++-----
>>>>   1 file changed, 83 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c 
>>>> b/drivers/tty/serial/8250/8250_bcm2835aux.c
>>>> index fd95860cd..b904b321e 100644
>>>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
>>>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
>>>> @@ -12,6 +12,7 @@
>>>>    * simultaneously to rs485.
>>>>    */
>>>> +#include <linux/acpi.h>
>>>>   #include <linux/clk.h>
>>>>   #include <linux/io.h>
>>>>   #include <linux/module.h>
>>>> @@ -44,6 +45,10 @@ struct bcm2835aux_data {
>>>>       u32 cntl;
>>>>   };
>>>> +struct bcm2835_aux_serial_acpi_driver_data {
>>>> +    resource_size_t offset;
>>>> +};
>>>> +
>>>>   static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
>>>>   {
>>>>       if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
>>>> @@ -82,8 +87,12 @@ static int bcm2835aux_serial_probe(struct 
>>>> platform_device *pdev)
>>>>   {
>>>>       struct uart_8250_port up = { };
>>>>       struct bcm2835aux_data *data;
>>>> +    struct bcm2835_aux_serial_acpi_driver_data *acpi_data;
>>>>       struct resource *res;
>>>>       int ret;
>>>> +    resource_size_t mapbase;
>>>> +    resource_size_t mapsize;
>>>> +    unsigned int uartclk;
>>>>       /* allocate the custom structure */
>>>>       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>>> @@ -108,10 +117,12 @@ static int bcm2835aux_serial_probe(struct 
>>>> platform_device *pdev)
>>>>       platform_set_drvdata(pdev, data);
>>>> -    /* get the clock - this also enables the HW */
>>>> -    data->clk = devm_clk_get(&pdev->dev, NULL);
>>>> -    if (IS_ERR(data->clk))
>>>> -        return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could 
>>>> not get clk\n");
>>>> +    if (dev_of_node(&pdev->dev)) {
>>>> +        /* get the clock - this also enables the HW */
>>>> +        data->clk = devm_clk_get(&pdev->dev, NULL);
>>>> +        if (IS_ERR(data->clk))
>>>> +            return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), 
>>>> "could not get clk\n");
>>>> +    }
>>>
>>> This does not seem necessary, if the clk is NULL when probed via 
>>> ACPI, all of the clk_* APIs will deal with that gracefully. If you 
>>> need not to treat -ENOENT as a hard error here, consider switching to 
>>> devm_clk_get_optional(). Given that you look at the 'clock-frequency' 
>>> property, you can still have some generic code, something like:
>>>
>>>      if (IS_ERR(data->clk)) {
>>>          ret = device_property_read_u32(&pdev->dev, 
>>> "clock-frequency", &uartclk);
>>>          if (ret)
>>>              return dev_err_probe(&pdev->dev, ret, "could not get 
>>> clk\n");
>>>      }
>>>
>>>>       /* get the interrupt */
>>>>       ret = platform_get_irq(pdev, 0);
>>>> @@ -125,20 +136,59 @@ static int bcm2835aux_serial_probe(struct 
>>>> platform_device *pdev)
>>>>           dev_err(&pdev->dev, "memory resource not found");
>>>>           return -EINVAL;
>>>>       }
>>>> -    up.port.mapbase = res->start;
>>>> -    up.port.mapsize = resource_size(res);
>>>> -
>>>> -    /* Check for a fixed line number */
>>>> -    ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>>> -    if (ret >= 0)
>>>> -        up.port.line = ret;
>>>> -
>>>> -    /* enable the clock as a last step */
>>>> -    ret = clk_prepare_enable(data->clk);
>>>> -    if (ret) {
>>>> -        dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
>>>> -            ret);
>>>> -        return ret;
>>>
>>> All of that path can be common, and you can just define an offset to 
>>> apply to the resource at the top after you fetched the memory 
>>> resource. The offset will be non-0 for ACPI and 0 for non-ACPI. That 
>>> is, no need for the intermediate variables and conditional paths 
>>> whether this is ACPI apply this offset, or not.
>>>
>>>> +
>>>> +    mapbase = res->start;
>>>> +    mapsize = resource_size(res);
>>>> +
>>>> +    if (has_acpi_companion(&pdev->dev)) {
>>>> +        const struct acpi_device_id *match;
>>>> +
>>>> +        match = 
>>>> acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
>>>> +        if (!match)
>>>> +            return -ENODEV;
>>>> +
>>>> +        acpi_data = (struct bcm2835_aux_serial_acpi_driver_data 
>>>> *)match->driver_data;
>>>> +
>>>> +        /* Some UEFI implementations (e.g. tianocore/edk2 for the 
>>>> Raspberry Pi)
>>>> +         * describe the miniuart with a base address that 
>>>> encompasses the auxiliary
>>>> +         * registers shared between the miniuart and spi.
>>>> +         *
>>>> +         * This is due to historical reasons, see discussion here :
>>>> +         * https://edk2.groups.io/g/devel/topic/87501357#84349
>>>> +         *
>>>> +         * We need to add the offset between the miniuart and 
>>>> auxiliary
>>>> +         * registers to get the real miniuart base address.
>>>
>>> And ACPI on the Pi4 is so widely deployed that fixing the miniuart 
>>> resources is not an option at all? This really really continues to 
>>> contribute to my impression that ACPI on the Pi4 is a fad more than a 
>>> real thing, sorry.
>>
>> The problem again, is that this resource is legacy and used by 
>> windows/vmware/etc on both the rpi3 and rpi4. So, unfortunately it 
>> cannot really be changed without breaking existing OSs.
> 
> Cannot we create another entry that only Linux would match? This is the 
> first time that an attempt for ACPIfying the 8250_bcm2835aux is done as 
> far as upstream is concerned so any cruft of legacy that is artificial 
> should really be avoided and this appear to be some.

Well, then we would have a SPCR+DBG2 mismatch when used as a console or 
debug port (which is an option here since the DT being used by the low 
level vc4 firmware selects between the console or bluetooth for the 
serial device. And in windows and likely other OS's the unused device is 
going to confuse people when it shows up but is missing a driver. So its 
not really workable without diverging the ACPI tables based on OS.

MS actually went and created a new uart type for this device a number of 
years ago when the initial edk2 port was made, and apparently that 
definition was somewhat incorrect because it uses this offset to cover 
the entire block. So it puts us in a bit of a bind, where there were 
issues with their original definitions (like this). For the most part 
the edk2 maintainers/rpi OS community tend to work these out, but 
sometimes they leak through to an OS and require changes. In this case 
Adrien initially tried to change the uart definition, and it was 
strongly NAKed by other members because linux is the odd one out here.

Thanks
