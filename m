Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC66547134B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhLKKZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:25:26 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:42448 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhLKKZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:25:25 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru F0FE922F2569
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
Date:   Sat, 11 Dec 2021 13:25:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.12.2021 2:45, Damien Le Moal wrote:

[...]
>>>> platform_get_irq() will print a message when it fails.
>>>> No need to repeat this.
>>>>
>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>> out a big WARN() in such case.
>>>
>>> The reason you should be able to remove the "if (!irq)" test is that
>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>>> says. But looking at platform_get_irq_optional(), which is called by
>>> platform_get_irq(), the out label is:
>>>
>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>> 	return ret;
>>>
>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>> return -ENXIO:
>>>
>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>> 		return -ENXIO;
>>> 	return ret;
>>
>>     My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>> but returns -EINVAL instead.
> 
> Thinking more about this, shouldn't this change go into platform_get_irq()
> instead of platform_get_irq_optional() ?

    Why? platform_get_irq() currently just calls platform_get_irq_optional()...

> The way I see it, I think that the intended behavior for
> platform_get_irq_optional() is:
> 1) If have IRQ, return it, always > 0
> 2) If no IRQ, return 0

    That does include the IRQ0 case, right?

> 3) If error, return < 0
> no ?

   I completely agree, I (after thinking a bit) have no issues with that...

> And for platform_get_irq(), case (2) becomes an error.
> Is this the intended semantic ?

    I don't see how it's different from the current behavior. But we can do 
that as well, I just don't see whether it's really better...

> I am really not sure here as the functions kdoc description and the code do not
> match. Which one is correct ?

    It seems both are wrong. :-)

[...]

MBR, Sergey
