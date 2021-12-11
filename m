Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA632471342
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhLKKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:13:57 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:56150 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhLKKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:13:56 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 5EB4D20EBC8C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <8ec4a971-29ba-77f7-7c48-ad88decea70f@omp.ru>
Date:   Sat, 11 Dec 2021 13:13:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 <9d688cd8-99e3-0265-06aa-d44597e7686c@omp.ru>
 <YbOpu2whB5NaXbNa@smile.fi.intel.com>
 <a0bf3377-21ed-7244-7c73-ebb50dbc44c4@omp.ru>
 <448ce97b-699d-bdab-b4e9-c9439fd81a85@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <448ce97b-699d-bdab-b4e9-c9439fd81a85@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.2021 22:35, Sergei Shtylyov wrote:

[...]
>>>>>>>>>>>> platform_get_irq() will print a message when it fails.
>>>>>>>>>>>> No need to repeat this.
>>>>>>>>>>>>
>>>>>>>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>>>>>>>>> out a big WARN() in such case.
>>>>>>>>>>>
>>>>>>>>>>> The reason you should be able to remove the "if (!irq)" test is that
>>>>>>>>>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>>>>>>>>>>> says. But looking at platform_get_irq_optional(), which is called by
>>>>>>>>>>> platform_get_irq(), the out label is:
>>>>>>>>>>>
>>>>>>>>>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>>>>>>>>>> 	return ret;
>>>>>>>>>>>
>>>>>>>>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>>>>>>>>>> return -ENXIO:
>>>>>>>>>>>
>>>>>>>>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>>>>>>>>>> 		return -ENXIO;
>>>>>>>>>>> 	return ret;
>>>>>>>>>>
>>>>>>>>>>     My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>>>>>>>>>> but returns -EINVAL instead.
>>>>>>>>>>
>>>>>>>>>>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
>>>>>>>>>>
>>>>>>>>>>     Of course it isn't...
>>>>>>>>>
>>>>>>>>> It's unsubstantiated statement. The vIRQ 0 shouldn't be returned by any of
>>>>>>>>> those API calls.
>>>>>>>>
>>>>>>>>     We do _not_ know what needs to be fixed, that's the problem, and that's why the WARN()
>>>>>>>> is there...
>>>>>>>
>>>>>>> So, have you seen this warning (being reported) related to libahci_platform?
>>>>>>
>>>>>>     No (as if you need to really see this while it's obvious from the code review).
>>>>>>
>>>>>>> If no, what we are discussing about then? The workaround is redundant and
>>>>>>
>>>>>>     I don't know. :-) Your arguments so far seem bogus (sorry! :-))...
>>>>>
>>>>> It seems you haven't got them at all. The problems of platform_get_irq() et al
>>>>> shouldn't be worked around in the callers.
>>>>
>>>>     I have clearly explained to you what I'm working around there. If that wasn't clear
>>>> enough, I don't want to continue this talk anymore. Good luck with your patch (not this
>>>> one).
>>>
>>> Good luck with yours, not the one that touches platform_get_irq_optional() though!
>>
>>     Mmh, I'm not touching it any way that would break what your patch was trying to do,
>> unless you've re-thopught that. It also shoudn't matter whose patch gets merged 1st
>> other than some small adaptation).
> 
>     BTW, looking at [1], this comment is wrong:
> 
> + * Return: non-zero IRQ number on success, negative error number on failure.
> 
> It doesn't mention 0 which you return from this function.

    Also, your commit log is wrong in the description of how to handle the result:

<<
Now:
	ret = platform_get_irq_optional(...);
	if (ret != -ENXIO)
		return ret; // respect deferred probe
	if (ret > 0)
		...we get an IRQ...
 >>

    The (ret != -ENXIO) check also succeeds on the (positive) IRQ #s, so the 
following code becomes unreachable. :-/

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed7027fdf4ec41ed6df6814956dc11860232a9d5

MBR, Sergey
