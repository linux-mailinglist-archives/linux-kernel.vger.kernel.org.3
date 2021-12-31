Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850A482381
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhLaKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:42:42 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:62273 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLaKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:42:40 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 31 Dec
 2021 18:42:34 +0800
Message-ID: <63c79fb5-e405-7d23-1083-7758bfbcf19d@amlogic.com>
Date:   Fri, 31 Dec 2021 18:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 5/6] tty: serial: meson: meson_uart_shutdown omit clear
 AML_UART_TX_EN bit
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
 <20211230102110.3861-6-yu.tu@amlogic.com>
 <CAFBinCC7pvT4=LhowZQpH-_5=90KBnczcRfYc3tLQr8hEh49Zg@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCC7pvT4=LhowZQpH-_5=90KBnczcRfYc3tLQr8hEh49Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/31 6:44, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Dec 30, 2021 at 11:22 AM Yu Tu <yu.tu@amlogic.com> wrote:
> [...]
>>          val = readl(port->membase + AML_UART_CONTROL);
>> -       val &= ~AML_UART_RX_EN;
>> +       val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
>>          val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
>>          writel(val, port->membase + AML_UART_CONTROL);
> This looks fine to me but I think it would be good to Cc the author of
> commit 855ddcab352c15 ("ARM: meson: serial: only disable tx irq on
> stop")
> The meson_uart driver which Carlo added eight years ago did clear
> AML_UART_TX_EN here, but it was changed with the commit I mentioned
> above.
> 
I'm going to delete this change this time. Because there is no bug at 
present, if this is a bug encountered later, i will prepare to submit 
this change.
> 
> Best regards,
> Martin
> 
