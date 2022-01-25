Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8346549B09A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiAYJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:40:51 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:43730 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574736AbiAYJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:36:34 -0500
Received: by mail-ej1-f41.google.com with SMTP id d10so29228716eje.10;
        Tue, 25 Jan 2022 01:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=uMgOw5Ryt+tazHG/W/vzY+daSEWrYBxAzR9U0mzM8Ek=;
        b=K0eGI4nN2+HU40WjLBJrmoTJoSo8xv0UVVO2sY8jxGQGBRf/3W0Xvem3pUVisIPxkx
         lZU4hsv0o0/uQNMFm/1x+SP5yCni2oaPVuVUdWqkuyKt4DmJ8PYRexEQDdkmTr99UVbO
         WFVHjsiAswJ/EBq+XD67MjLRt7trC0SoiA2GjPLu8QGDtcLZcmQHWgMhThB6Qvz3dCDn
         m5EoYE+TI63eQ4DELscudx5xlsts9fR28iXmOTGtQiBSbCL9Uu2l6GSpne9pPe+IfXYn
         bCQ5XoM3Fz2ADp5jzo5fobnvF+ISaUQ+928BT5VTgK+GFnNQYOmWht3UjRP0hwdpd6CG
         Ms9A==
X-Gm-Message-State: AOAM531AhDoM1H0CnOcHrdrx3DtX6PyXm1lsptfqQ+rXWQTYghRt+kzY
        Awv8sETQ8t0bQ8WsVgZ0na8=
X-Google-Smtp-Source: ABdhPJxIz7O8IMWskiQQN+rGOnZHZD+Vb53T+XBFmHDCHMTYiFBVUtGgofNy58YXprt2a8qvDL7XZw==
X-Received: by 2002:a17:907:6d11:: with SMTP id sa17mr15917404ejc.473.1643103389041;
        Tue, 25 Jan 2022 01:36:29 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id v23sm5967129ejy.177.2022.01.25.01.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 01:36:28 -0800 (PST)
Message-ID: <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
Date:   Tue, 25 Jan 2022 10:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>, wander@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
In-Reply-To: <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 01. 22, 10:08, Jiri Slaby wrote:
> On 25. 01. 22, 9:39, Jon Hunter wrote:
>>
>> On 29/10/2021 21:14, wander@redhat.com wrote:
>>> From: Wander Lairson Costa <wander@redhat.com>
>>>
>>> Note: I am using a small test app + driver located at [0] for the
>>> problem description. serco is a driver whose write function dispatches
>>> to the serial controller. sertest is a user-mode app that writes n bytes
>>> to the serial console using the serco driver.
...
>>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>>
>>
>> On the current mainline and -next branches, I have noticed that the
>> serial output on many of our Tegra boards is corrupted and so
>> parsing the serial output is failing.
>>
>> Before this change the serial console would appear as follows ...
>>
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd071]
>> [    0.000000] Linux version 5.16.0-rc6-00091-gadbfddc757ae 
>> (jonathanh@jonathanh-vm-01) (aarch64-linux-gnu-gcc (Linaro GCC 
>> 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 
>> 2.27.0.20161019) #15 SMP PREEMPT Tue Jan 25 00:15:25 PST 2022
>> [    0.000000] Machine model: NVIDIA Jetson TX1 Developer Kit
>>
>> And now I see ...
>>
>> [    0.000000] Booting Linux on physicalfd071]
>> [    0.000000] Linux version 5.16.0-rc6-athanh@j-linux-g017.08) 
>> Linaro_B20161019n 25 00:[    0.000000] Machine model: NVIDIA Jet[ 
>> 0.000000] efi: UEFI not found.
>> [    0.000000] NUMA: No NUMA configurati[    0.000000] NUMA: Faking a 
>> node at [m00000001[    0.000000] NUMA: NODE_DATA [mem 0x17[    
>> 0.000000] Zone ranges:
>>
>> Bisecting is pointing to this commit. Let me know if there are any
>> tests I can run. Otherwise we may need to disable this at least
>> for Tegra.
> 
> 
> The test is bogus:
>          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>                  port->fifosize > 1 &&
>                  (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
> 
> FCR is write only. Reading it, one gets IIR contents.

In particular, the test is checking whether there is no interrupt 
pending (UART_FCR_ENABLE_FIFO == UART_IIR_NO_INT). So it oscillates 
between use_fifo and not, depending on the interrupt state of the chip.

Could you change it into something like this:
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3396,7 +3396,7 @@ void serial8250_console_write(struct 
uart_8250_port *up, const char *s,

         use_fifo = (up->capabilities & UART_CAP_FIFO) &&
                 port->fifosize > 1 &&
-               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
+               (up->fcr & UART_FCR_ENABLE_FIFO) &&
                 /*
                  * After we put a data in the fifo, the controller will 
send
                  * it regardless of the CTS state. Therefore, only use fifo


And see whether it fixes the issue. Anyway, of what port type is the 
serial port (what says dmesg/setserial about that)?

thanks,
-- 
js
suse labs
