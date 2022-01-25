Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA849B229
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355489AbiAYKke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:40:34 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45010 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358978AbiAYKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:38:09 -0500
Received: by mail-ed1-f45.google.com with SMTP id u24so15885674eds.11;
        Tue, 25 Jan 2022 02:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FnyumMuINSTl10b4Z1f77CLpKT4vvjCzwh3tAHHSoQs=;
        b=LHb1lUmkmFukBRLZLG55kHFJYkFpiiMl6Qm9cGVq5/DiaCbmFVUcVu+Qz2pmZ+W/2r
         Yd5YJSI46gE9HvD1W9pQOr0NV5c5YjyV++wZM00lcRmm6IeKjxZ7pl2KvL5z6mQR2uke
         si+NzFWWeXY84P1oVHzeHjPrJ3/2i2CM0JHMXUi7R3INRxyjxI6RgMmvuRKeQ3iQ5PS4
         EOtRX9Iw84A9NWhfKKUzY6eMdqlLH/x9ZPFKzcuXw6GfBw9ur2nsWB1/okGDiXJ64kwf
         kUcAgRp8KFrMbAsOyohNJ7FVknVgPlxrP9dmD4xCvx5pMyonLHs42mdHPs3YFj/EZ5BZ
         DI8w==
X-Gm-Message-State: AOAM530TyXOtYrKdoWTqi4yCy+XfwdczgoF4zceRyC74sayjNgaLGGQ1
        EJbiMVtNmQybEPpIpeehVHA=
X-Google-Smtp-Source: ABdhPJzcd86llx4XOWtpgGa1Ng7tiuLZoGKKB7qTySUUk++C9x0aCvnCJ78BWfFojtkGWywurGWJTQ==
X-Received: by 2002:a50:9e6c:: with SMTP id z99mr19963324ede.71.1643107087231;
        Tue, 25 Jan 2022 02:38:07 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id gu2sm5944053ejb.221.2022.01.25.02.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 02:38:06 -0800 (PST)
Message-ID: <b6392347-c347-137a-d97e-f621b3a7e099@kernel.org>
Date:   Tue, 25 Jan 2022 11:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
To:     Wander Costa <wcosta@redhat.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <CAAq0SUm-NQ6kwxhSJsOwHaBsi7dagAy8Pj4vOHOd6wy33Nqp2g@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAAq0SUm-NQ6kwxhSJsOwHaBsi7dagAy8Pj4vOHOd6wy33Nqp2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 01. 22, 11:18, Wander Costa wrote:
>> In particular, the test is checking whether there is no interrupt
>> pending (UART_FCR_ENABLE_FIFO == UART_IIR_NO_INT). So it oscillates
>> between use_fifo and not, depending on the interrupt state of the chip.
>>
>> Could you change it into something like this:
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -3396,7 +3396,7 @@ void serial8250_console_write(struct
>> uart_8250_port *up, const char *s,
>>
>>           use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>>                   port->fifosize > 1 &&
>> -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
>> +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
>>                   /*
>>                    * After we put a data in the fifo, the controller will
>> send
>>                    * it regardless of the CTS state. Therefore, only use fifo
>>
> 
> Indeed I made a mistake here. Independent of the reported this, this
> should be fixed.
> Jiri, do you intend to send an official patch or should I do so?

Please you send the fix after testing the fifo mode still works with 
that fix.

thanks,
-- 
js
