Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65314827B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiAANaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 08:30:24 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:46969 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAANaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 08:30:23 -0500
Received: from [10.18.89.180] (10.18.89.180) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Sat, 1 Jan
 2022 21:30:13 +0800
Message-ID: <7278bace-a2b9-0cfc-55b3-c19311e3352e@amlogic.com>
Date:   Sat, 1 Jan 2022 21:30:12 +0800
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
 <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com>
 <CAFBinCB2nF0TwRE1uJ4UTB_avcqRBfOHR1CDSe29dB1o-YjEHQ@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCB2nF0TwRE1uJ4UTB_avcqRBfOHR1CDSe29dB1o-YjEHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.89.180]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
     Thank you very much for your reply.

On 2021/12/31 23:32, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Dec 31, 2021 at 12:24 PM Yu Tu <yu.tu@amlogic.com> wrote:
> [...]
>>>>    static int meson_uart_request_port(struct uart_port *port)
>>>>    {
>>>> +       struct meson_uart_data *private_data = port->private_data;
>>>> +       int ret;
>>>> +
>>>> +       ret = clk_prepare_enable(private_data->pclk);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       ret = clk_prepare_enable(private_data->baud_clk);
>>>> +       if (ret) {
>>>> +               clk_disable_unprepare(private_data->pclk);
>>>> +               return ret;
>>>> +       }
>>> This code is from my original suggestion - and I had a doubt there
>>> which I forgot to add as a comment originally:
>>> Can you confirm that accessing the UART controller registers works
>>> even when "pclk" is turned off?
>>> I am asking this because the common clock framework can access the
>>> clocks at any time.
>>> And I have seen SoCs which would hang when trying to access a module's
>>> registers while the module's pclk is turned off.
>> On all meson platforms, the default pclk for all UART is turned on
>> during the u-boot phase. When registering uart pclk in the kernel phase,
>> the CLK_IGNORE_UNUSED flag is added. So the real shutdown is when the
>> standby goes down, the parent clk shuts down.
> Interesting, thanks for sharing that u-boot turns these clocks on.
> Let's say someone wanted to make u-boot save power and turn off all
> UART clocks except the one for uart_AO (where we typically connect the
> serial console).
> In that case the pclk of uart_C (just to choose an example here) is
> turned off. Would there be a problem then accessing the registers of
> uart_C before clk_prepare_enable is called?
The way you describe it, it does hang. This would not be recommended on 
actual projects.

At present, AmLogic chips are older than S4 Soc, and we have no way to 
deal with this problem. We have to tell customers not to use it in this 
way。Customers rarely use it in real projects.On the S4 SOC we will use 
a clock like the UART pclk to control the shutdown using two registers, 
one safe (need to operate in EL3) and one normal (EL1). It will only be 
closed if both registers are closed. This mainly prevents misoperation.

With your experience, I'd like to know how you deal with this kind of 
problem.
> 
> [...]
>>>>           port->fifosize = 64;
>>> commit 27d44e05d7b85d ("tty: serial: meson: retrieve port FIFO size
>>> from DT") [0] from May 2021 has changed this line to:
>>>     port->fifosize = fifosize;
>>> So your patch currently does not apply to linux-next (or even Linus'
>>> mainline tree).
>>>
>> So do I need to wait for [0] patch merged before I can continue to make
>> changes ?
> These changes are already merged.
> 
>> What can I do before?
> You should base your changes on top of the tty.git/tty-next branch [1]
> where Greg (the maintainer of this tree) will pick up the patches once
> they are good (got enough Acked-by/Reviewed-by, etc.).
> I suspect that you based your changes on an older or stable kernel
> version (let's say 5.10). New functionality should always get into the
> -next tree where various auto-build robots will compile-test the
> changes and we even have Kernel CI where changes are tested on real
> hardware (BayLibre even maintains Amlogic boards in their Kernel CI
> labs). Let's say Amlogic updates to Linux 5.17 next year then the
> patches are already included in that kernel version - instead of being
> only available in Linux 5.10.
> 
I'm sorry, I did branch confirm there was a mistake, I have corrected.
> 
> Best regards,
> Martin
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-next
> 
