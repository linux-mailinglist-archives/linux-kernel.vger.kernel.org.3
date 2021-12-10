Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F217F4709A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245751AbhLJTFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:05:02 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:57176 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhLJTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:04:51 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru F2B7020A73F8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <YbMwBFf5e7k2o6W5@smile.fi.intel.com>
 <9e6b2e9a-e958-0c14-6570-135607041978@omp.ru>
 <YbM7xkTazM76CVvD@smile.fi.intel.com>
 <6c03ffef-b2e0-16ba-35f3-206af2a611d2@gmail.com>
 <YbOVmGw7ys6U51z3@smile.fi.intel.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9d688cd8-99e3-0265-06aa-d44597e7686c@omp.ru>
Date:   Fri, 10 Dec 2021 22:01:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbOVmGw7ys6U51z3@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 8:59 PM, Andy Shevchenko wrote:

>>>>>>>> platform_get_irq() will print a message when it fails.
>>>>>>>> No need to repeat this.
>>>>>>>>
>>>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>>>>> out a big WARN() in such case.
>>>>>>>
>>>>>>> The reason you should be able to remove the "if (!irq)" test is that
>>>>>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>>>>>>> says. But looking at platform_get_irq_optional(), which is called by
>>>>>>> platform_get_irq(), the out label is:
>>>>>>>
>>>>>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>>>>>> 	return ret;
>>>>>>>
>>>>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>>>>>> return -ENXIO:
>>>>>>>
>>>>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>>>>>> 		return -ENXIO;
>>>>>>> 	return ret;
>>>>>>
>>>>>>    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>>>>>> but returns -EINVAL instead.
>>>>>>
>>>>>>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
>>>>>>
>>>>>>    Of course it isn't...
>>>>>
>>>>> It's unsubstantiated statement. The vIRQ 0 shouldn't be returned by any of
>>>>> those API calls.
>>>>
>>>>    We do _not_ know what needs to be fixed, that's the problem, and that's why the WARN()
>>>> is there...
>>>
>>> So, have you seen this warning (being reported) related to libahci_platform?
>>
>>    No (as if you need to really see this while it's obvious from the code review).
>>
>>> If no, what we are discussing about then? The workaround is redundant and
>>
>>    I don't know. :-) Your arguments so far seem bogus (sorry! :-))...
> 
> It seems you haven't got them at all. The problems of platform_get_irq() et al
> shouldn't be worked around in the callers.

   I have clearly explained to you what I'm working around there. If that wasn't clear
enough, I don't want to continue this talk anymore. Good luck with your patch (not this
one).

[...]

MBR, Sergey
