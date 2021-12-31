Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9348239F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhLaLYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:24:41 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:22438 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLaLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:24:40 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 31 Dec
 2021 19:24:37 +0800
Message-ID: <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com>
Date:   Fri, 31 Dec 2021 19:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com>
 <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/31 7:13, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Dec 30, 2021 at 11:21 AM Yu Tu <yu.tu@amlogic.com> wrote:
> [...]
>> @@ -270,14 +284,11 @@ static void meson_uart_reset(struct uart_port *port)
>>   static int meson_uart_startup(struct uart_port *port)
>>   {
>>          u32 val;
>> -       int ret = 0;
>> +       int ret;
>>
>> -       val = readl(port->membase + AML_UART_CONTROL);
>> -       val |= AML_UART_CLEAR_ERR;
>> -       writel(val, port->membase + AML_UART_CONTROL);
>> -       val &= ~AML_UART_CLEAR_ERR;
>> -       writel(val, port->membase + AML_UART_CONTROL);
>> +       meson_uart_reset(port);
> I suggest splitting this into a separate patch. In general I think
> it's a good idea to re-use meson_uart_reset here if possible.
> However, if during testing it turns out that this doesn't work then we
> can revert this single patch which updates meson_uart_startup() only -
> instead of reverting the whole transition to the common clock
> framework.
> 
I approve of your suggestion. I will make the next patch.

> [...]
>>   static int meson_uart_request_port(struct uart_port *port)
>>   {
>> +       struct meson_uart_data *private_data = port->private_data;
>> +       int ret;
>> +
>> +       ret = clk_prepare_enable(private_data->pclk);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_prepare_enable(private_data->baud_clk);
>> +       if (ret) {
>> +               clk_disable_unprepare(private_data->pclk);
>> +               return ret;
>> +       }
> This code is from my original suggestion - and I had a doubt there
> which I forgot to add as a comment originally:
> Can you confirm that accessing the UART controller registers works
> even when "pclk" is turned off?
> I am asking this because the common clock framework can access the
> clocks at any time.
> And I have seen SoCs which would hang when trying to access a module's
> registers while the module's pclk is turned off.
On all meson platforms, the default pclk for all UART is turned on 
during the u-boot phase. When registering uart pclk in the kernel phase, 
the CLK_IGNORE_UNUSED flag is added. So the real shutdown is when the 
standby goes down, the parent clk shuts down.
.
> 
> [...]
>>          port->fifosize = 64;
> commit 27d44e05d7b85d ("tty: serial: meson: retrieve port FIFO size
> from DT") [0] from May 2021 has changed this line to:
>    port->fifosize = fifosize;
> So your patch currently does not apply to linux-next (or even Linus'
> mainline tree).
> 
So do I need to wait for [0] patch merged before I can continue to make 
changes ?
What can I do before?
> [...]
>>   static const struct of_device_id meson_uart_dt_match[] = {
>> -       { .compatible = "amlogic,meson6-uart" },
>> -       { .compatible = "amlogic,meson8-uart" },
>> -       { .compatible = "amlogic,meson8b-uart" },
>> -       { .compatible = "amlogic,meson-gx-uart" },
>> +       {
>> +               .compatible = "amlogic,meson6-uart",
>> +               .data = (void *)false,
>> +       },
>> +       {
>> +               .compatible = "amlogic,meson8-uart",
>> +               .data = (void *)false,
>> +       },
>> +       {
>> +               .compatible = "amlogic,meson8b-uart",
>> +               .data = (void *)false,
>> +       },
>> +       {
>> +               .compatible = "amlogic,meson-gxbb-uart",
>> +               .data = (void *)false,
>> +       },
>> +       {
>> +               .compatible = "amlogic,meson-gxl-uart",
>> +               .data = (void *)true,
>> +       },
>> +       {
>> +               .compatible = "amlogic,meson-g12a-uart",
>> +               .data = (void *)true,
>> +       },
>> +       {
>> +               .compatible = "amlogic,meson-s4-uart",
>> +               .data = (void *)true,
>> +       },
>> +       /*
>> +        * deprecated, don't use anymore because it doesn't differentiate
>> +        * between GXBB and GXL which have different revisions of the UART IP.
>> +        */
>> +       {
>> +               .compatible = "amlogic,meson-gx-uart",
>> +               .data = (void *)false,
>> +       },
> For this change I think it's also best to split it into separate
> changes, similar to the dt-bindings:
> 1) deprecate and replace "amlogic,meson-gx-uart"
> 2) another one to add the S4 compatible string
> 3) and a third one with the big common clock framework change (adding
> the .data attributes)
> 
> This is about the "Separate each logical change into a separate patch"
> rule from the Linux kernel patch submission guide [1]
> Also I hope that it will make it (at least a bit) easier for others to
> also review this patch.
> 
I quite agree with your suggestion. I'll do as you suggest.
> 
> Best regards,
> Martin
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/tty/serial/meson_uart.c?id=27d44e05d7b85d9d4cfe0a3c0663ea49752ece93
> [1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#separate-your-changes
> 
