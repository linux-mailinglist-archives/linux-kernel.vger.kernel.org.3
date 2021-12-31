Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2583F48237D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhLaKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:37:47 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:53839 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLaKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:37:45 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 31 Dec
 2021 18:37:43 +0800
Message-ID: <50127eb4-dfa0-6b80-36c0-8c246eb4d164@amlogic.com>
Date:   Fri, 31 Dec 2021 18:37:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 6/6] tty: serial: meson: Change request_irq to
 devm_request_irq and move devm_request_irq to meson_uart_probe()
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
 <20211230102110.3861-7-yu.tu@amlogic.com>
 <CAFBinCAzDSw6jmpU-S2KGZ32D+U1fNqLgKMmkPSdz=-XN4isDA@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCAzDSw6jmpU-S2KGZ32D+U1fNqLgKMmkPSdz=-XN4isDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/31 6:41, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Dec 30, 2021 at 11:22 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>
>> Because an interrupt error occurs when the user opens /dev/ttyAML* but
>> don't close it, and then opens the same port again. This problem is
>> encountered in actual projects.
> I would like to hear from the serial driver maintainers whether the
> described problem is a userspace or driver bug.
> 
> If it's a driver bug then this should be sent as a separate patch
> (unrelated to this series) with a fixes tag.
> 
> [...]
>> +       ret = devm_request_irq(&pdev->dev, port->irq, meson_uart_interrupt,
>> +                              0, dev_name(&pdev->dev), port);
> You can replace dev_name(&pdev->dev) with NULL to achieve the same
> result with less code.
> dev_name(dev) is the default value, see [0]
> 
I think you are right, I will remove this patch. I learned a lot.
> 
> Best regards,
> Martin
> 
> 
> [0] https://elixir.bootlin.com/linux/v5.15/source/kernel/irq/devres.c#L64
> 
