Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277D34705ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhLJQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:42:21 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:37856 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbhLJQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:42:20 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 43106235E65B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-ide@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Jens Axboe" <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <CAHp75VcdwozpUJVB17VmCDska7euYnx1VjZLnCaZ8DHG+_3vYg@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <587c35bd-8877-030e-6236-d0d8c2b6811c@omp.ru>
Date:   Fri, 10 Dec 2021 19:38:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcdwozpUJVB17VmCDska7euYnx1VjZLnCaZ8DHG+_3vYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 11:47 AM, Andy Shevchenko wrote:

>>> platform_get_irq() will print a message when it fails.
>>> No need to repeat this.
>>>
>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>> out a big WARN() in such case.
>>
>> The reason you should be able to remove the "if (!irq)" test is that
>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>> says. But looking at platform_get_irq_optional(), which is called by
>> platform_get_irq(), the out label is:
>>
>>         WARN(ret == 0, "0 is an invalid IRQ number\n");
>>         return ret;
>>
>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>> return -ENXIO:
>>
>>         if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>                 return -ENXIO;

   -ENXIO seems to me more fitting indeed (than -EINVAL that I used).

> 
> No, this is wrong for the same reasons I explained to Sergey.

   I fail to understand you, sorry. We're going in circles, it seems... :-/

> The problem is that this is _optional API and it has been misdesigned.
> Replacing things like above will increase the mess.

   What's wrong with replacing IRQ0 with -ENXIO now? platform_get_irq_optional()
(as in your patch) could then happily return 0 ISO -ENXIO. Contrarywise, if we don't
replace IRQ0 with -ENXIO, platform_get_irq_optional() will return 0 for both IRQ0
and missing IRQ! Am I clear enough? If you don't understand me now, I don't know what
to say... :-/

> 
>>         return ret;
>>
>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
> 
> No. This is not a business of the caller to workaround implementation
> details (bugs) of the core APIs.
> If something goes wrong, then it's platform_get_irq() to blame, and
> not the libahci_platform.

   I'm repeating myself already: we don't work around the bug in platform_get_irq(),
we're working around the driver subsystems that treat 0 specially (and so don't
support IRQ0); libata treats 0 as an indication of the polling mode (moreover,
it will curse if you pass to it both IRQ == 0 and a pointer to an interrupt handler!
Am I clear enough this time? :-)

MBR, Sergey
