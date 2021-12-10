Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DE46FF97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhLJLRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:17:55 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:45110 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhLJLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:17:54 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 545D420CBF78
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
 <15cf03b2-8d45-93b1-f0a0-d79c93cee0da@omp.ru>
 <YbMvfzKsc4CcQzSa@smile.fi.intel.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7ffe328f-2ba1-4799-5c6a-d48d88c0459d@omp.ru>
Date:   Fri, 10 Dec 2021 14:14:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbMvfzKsc4CcQzSa@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/10/21 1:44 PM, Andy Shevchenko wrote:

>>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>>>> out a big WARN() in such case.
>>>>>>
>>>>>>    And? IRQ0 is still returned! :-(
>>>>>
>>>>> It should not be returned in the first place.
>>>>
>>>>    But it still is, despite the WARN(), right?
>>>
>>> So, you admit that there is a code which does that?
>>
>>    I admit *what*?! That platfrom_get_irq() and its ilk return IRQ0 while they
>> shouldn't? =)
> 
> That there is a code beneath platform_get_irq() that returns 0, yes.

   Look at the ACPI-specific GpioInt handling code (just above the out_not_found label) --
I'm not sure the check there is correct -- I'm not very familiar with ACPI, you seem to
know it much better. :-)
   Also, 0 can be specified via the normal IRQ resource. I know of e.g. the Alchemy MIPS SoCs
that have IRQ0 used by UART0; luckily, currently SoC IRQs are mapped starting at Linux IRQ8
(but it wasn't the case in the 2.6.1x time frame where we had issue with the serial driver)...

>>> That code should be fixed first. Have you sent a patch?
>>
>>    Which code?! You got me totally muddled. =)
> 
> Above mentioned.

   What needs to be fixed in this case is the interrupt controller driver. Quoting Linus
(imprecisely :-)), IRQ #s should be either mapped starting with #1 or IRQ0 remapped at
the end of the controller's interrupt range... I currently have no information on the 
platforms requiring such kind of fixing (Alchemy don't seem to need it now)...

> ...
> 
>>>>>>> -	if (!irq)
>>>>>>> -		return -EINVAL;
>>>>>>
>>>>>>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
>>>>>> platform_get_irq() and friends gets merged....
>>>>>
>>>>> What patch?
>>>>
>>>>    https://marc.info/?l=linux-kernel&m=163623041902285
>>>>
>>>>> Does it fix platform_get_irq_optional()?
>>>>
>>>>    Of course! :-)
>>>
>>> Can you share link to lore.kernel.org, please?
>>> It will make much easier to try and comment.
>>
>>    I don't know how to uise it yet, and I'm a little busy with other IRQ0 issues ATM,

   A little bit, I meant to type.

>> so I'm afraid you're on your own here...
> 
> lore.kernel.org is the official mailing list archive for Linux kernel work
> AFAIU. Other sites may do whatever they want with that information, so -->
> they are unreliable. If you wish to follow the better process, use
> lore.kernel.org. Understanding how it works takes no more than 5 minutes
> by engineer with your kind of experience with Linux kernel development.

   OK, I'll explore this archive when I have time. BTW, does it keep the messages not
posted to LKML (I tend to only CC LKML if there's no other mailing lists to post to)?

MBR, Sergey
