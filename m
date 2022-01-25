Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4191A49B03F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573691AbiAYJaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:30:21 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:41818 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454759AbiAYJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:08:46 -0500
Received: by mail-ej1-f46.google.com with SMTP id a8so28931898ejc.8;
        Tue, 25 Jan 2022 01:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ypoRciFXETZg7D+mm/iMOvDTuDfcE51oTHl422AtP98=;
        b=WK93OHzxp4QsjxtVWdKlEp9IDp3e888hQbhp92KJRivpJsaOzSDDo6V44a9Osew9+O
         ZEpB63qZNbA9NLZrdluc7pyZ1oIRHPUwueBBGWxyLAL3PUuymwJvwoA9xOAkVwx68RLa
         SCQWjrzX6nBRFMa78cf77AxduDBZu2p9AnrZYQBXb9KLfhCmT+44kLIdODGA+Rv17iqf
         E66kZB8obrkjwIXryXX42xBgeeoa1QEgcfk/G0XeDLlrH0O8j8TSly20ZKXX/sS4oANo
         2slNK/JuDP5Dxd/7aaI0Ob8UxicsriaIWgsFcb0uqTt7gVcbOR/W8I5xtt3mNTFcPv5i
         y2rg==
X-Gm-Message-State: AOAM531l6HdQ7KnwSVoAIN1YeAdvrB/imDb3x86Dje8IzRnRX9IwsvoT
        UJLX2nQYIDQ4ytUK7Lx+KQ4=
X-Google-Smtp-Source: ABdhPJz64chg3lj7jKSpU+1OmZsz8rAk/qzuHcbWwn5XSsVHTC4fnm5wdLdxr7s8RBhK3sEKwc6Sig==
X-Received: by 2002:a17:906:3887:: with SMTP id q7mr15484527ejd.89.1643101717956;
        Tue, 25 Jan 2022 01:08:37 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d5sm5850708ejr.200.2022.01.25.01.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 01:08:37 -0800 (PST)
Message-ID: <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
Date:   Tue, 25 Jan 2022 10:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 01. 22, 9:39, Jon Hunter wrote:
> 
> On 29/10/2021 21:14, wander@redhat.com wrote:
>> From: Wander Lairson Costa <wander@redhat.com>
>>
>> Note: I am using a small test app + driver located at [0] for the
>> problem description. serco is a driver whose write function dispatches
>> to the serial controller. sertest is a user-mode app that writes n bytes
>> to the serial console using the serco driver.
>>
>> While investigating a bug in the RHEL kernel, I noticed that the serial
>> console throughput is way below the configured speed of 115200 bps in
>> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
>> I got 2.5KB/s.
>>
>> $ time ./sertest -n 2500 /tmp/serco
>>
>> real    0m0.997s
>> user    0m0.000s
>> sys     0m0.997s
>>
>> With the help of the function tracer, I then noticed the serial
>> controller was taking around 410us seconds to dispatch one single byte:
>>
>> $ trace-cmd record -p function_graph -g serial8250_console_write \
>>     ./sertest -n 1 /tmp/serco
>>
>> $ trace-cmd report
>>
>>              |  serial8250_console_write() {
>>   0.384 us   |    _raw_spin_lock_irqsave();
>>   1.836 us   |    io_serial_in();
>>   1.667 us   |    io_serial_out();
>>              |    uart_console_write() {
>>              |      serial8250_console_putchar() {
>>              |        wait_for_xmitr() {
>>   1.870 us   |          io_serial_in();
>>   2.238 us   |        }
>>   1.737 us   |        io_serial_out();
>>   4.318 us   |      }
>>   4.675 us   |    }
>>              |    wait_for_xmitr() {
>>   1.635 us   |      io_serial_in();
>>              |      __const_udelay() {
>>   1.125 us   |        delay_tsc();
>>   1.429 us   |      }
>> ...
>> ...
>> ...
>>   1.683 us   |      io_serial_in();
>>              |      __const_udelay() {
>>   1.248 us   |        delay_tsc();
>>   1.486 us   |      }
>>   1.671 us   |      io_serial_in();
>>   411.342 us |    }
>>
>> In another machine, I measured a throughput of 11.5KB/s, with the serial
>> controller taking between 80-90us to send each byte. That matches the
>> expected throughput for a configuration of 115200 bps.
>>
>> This patch changes the serial8250_console_write to use the 16550 fifo
>> if available. In my benchmarks I got around 25% improvement in the slow
>> machine, and no performance penalty in the fast machine.
>>
>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> 
> On the current mainline and -next branches, I have noticed that the
> serial output on many of our Tegra boards is corrupted and so
> parsing the serial output is failing.
> 
> Before this change the serial console would appear as follows ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd071]
> [    0.000000] Linux version 5.16.0-rc6-00091-gadbfddc757ae 
> (jonathanh@jonathanh-vm-01) (aarch64-linux-gnu-gcc (Linaro GCC 
> 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 
> 2.27.0.20161019) #15 SMP PREEMPT Tue Jan 25 00:15:25 PST 2022
> [    0.000000] Machine model: NVIDIA Jetson TX1 Developer Kit
> 
> And now I see ...
> 
> [    0.000000] Booting Linux on physicalfd071]
> [    0.000000] Linux version 5.16.0-rc6-athanh@j-linux-g017.08) 
> Linaro_B20161019n 25 00:[    0.000000] Machine model: NVIDIA Jet[    
> 0.000000] efi: UEFI not found.
> [    0.000000] NUMA: No NUMA configurati[    0.000000] NUMA: Faking a 
> node at [m00000001[    0.000000] NUMA: NODE_DATA [mem 0x17[    0.000000] 
> Zone ranges:
> 
> Bisecting is pointing to this commit. Let me know if there are any
> tests I can run. Otherwise we may need to disable this at least
> for Tegra.


The test is bogus:
         use_fifo = (up->capabilities & UART_CAP_FIFO) &&
                 port->fifosize > 1 &&
                 (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)

FCR is write only. Reading it, one gets IIR contents.

regards,
-- 
js
suse labs
