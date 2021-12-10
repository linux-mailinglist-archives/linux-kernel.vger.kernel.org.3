Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2764706D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbhLJRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbhLJRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:19:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F239C061746;
        Fri, 10 Dec 2021 09:15:47 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m12so14717353ljj.6;
        Fri, 10 Dec 2021 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J13OympFdoRAqUE6TRZ9GucjYjrLdPVDzqg/euxca8U=;
        b=nK7tp/OlI3lHeVcHXb2WDKFqQEd2De/oG5vKSxDVTxyQJt0nTyfjmqPNo5GW5O0SYs
         K9Q8lNRLxYrr/wGhnghVLkXaqb0IskH57JXa1EG4wdrG4CeJB5RW0GlWpNzxrNjw92Jw
         S41wHEE/ZOKe7aF2baEdtTHhvjQOksy3PvybEoHonkr4eGiMMqzrnqUV8YgQwFU8xuvJ
         IoZeK+FbHBM0wLiKOTRajnWsVDqxhtXqo2K7ISP1n6nrfp3Hb7Qu1eBID2SNzNV1Ew6Y
         wJEXsK8/D2B5RvxhSyQqGq8qjtYayh92gXuTdOvskohiAkxHVuX1YDeLvbTXvkyLMOX1
         +EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J13OympFdoRAqUE6TRZ9GucjYjrLdPVDzqg/euxca8U=;
        b=wVFlfWM4b0UCfx1Fy8Fin/lYQdGYtUse0KndSKWk1saOa1mE1YFCuj0xyJWEAxMGDr
         /KJDGMr42fMUdmBL8TeWswbgLR0nUVqq+6wTtPvgwdH3ybi5BVVQKuxXCnCNUTKslg4g
         hCs28MvcOI8jHxklRNlZnD3hHhpzbBHHrwjOb04SBAZPE3Niiqk2w9GufhyViGrwZ2pC
         pXQOy67rc8Y+rmEmjtbA1SLUxSRZfo8+jwGadDQV8hNd81GCFiHTVHydXpss1z+sS0Db
         T7LRL58FSShjEwW8cOKPvMJzpRWltxRW6FU9rGdcCaShUplVQ6Bi8OfBwtjQNhPkW7iK
         JFRQ==
X-Gm-Message-State: AOAM532OdFXH8SUrBYp11wmsEB8WJaQ6NKaXbJ6+AT22ZUPJ7U3JbA11
        txEAYYy1kfvn/d5+6tl+zMZpClo14KM=
X-Google-Smtp-Source: ABdhPJzmhFKnfGz0NoL8egcPxCcB+IfcHYfWlu5Y0Atg2t6T/78YjFf4NEE4tJEYS8Ph8QRHdD1+Dw==
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr13541972ljp.202.1639156545538;
        Fri, 10 Dec 2021 09:15:45 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.189])
        by smtp.gmail.com with ESMTPSA id w8sm364070lfa.206.2021.12.10.09.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:15:44 -0800 (PST)
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <YbMwBFf5e7k2o6W5@smile.fi.intel.com>
 <9e6b2e9a-e958-0c14-6570-135607041978@omp.ru>
 <YbM7xkTazM76CVvD@smile.fi.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <6c03ffef-b2e0-16ba-35f3-206af2a611d2@gmail.com>
Date:   Fri, 10 Dec 2021 20:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbM7xkTazM76CVvD@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 2:36 PM, Andy Shevchenko wrote:

>>>>>> platform_get_irq() will print a message when it fails.
>>>>>> No need to repeat this.
>>>>>>
>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>>> out a big WARN() in such case.
>>>>>
>>>>> The reason you should be able to remove the "if (!irq)" test is that
>>>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>>>>> says. But looking at platform_get_irq_optional(), which is called by
>>>>> platform_get_irq(), the out label is:
>>>>>
>>>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>>>> 	return ret;
>>>>>
>>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>>>> return -ENXIO:
>>>>>
>>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>>>> 		return -ENXIO;
>>>>> 	return ret;
>>>>
>>>>    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>>>> but returns -EINVAL instead.
>>>>
>>>>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
>>>>
>>>>    Of course it isn't...
>>>
>>> It's unsubstantiated statement. The vIRQ 0 shouldn't be returned by any of
>>> those API calls.
>>
>>    We do _not_ know what needs to be fixed, that's the problem, and that's why the WARN()
>> is there...
> 
> So, have you seen this warning (being reported) related to libahci_platform?

   No (as if you need to really see this while it's obvious from the code review).

> If no, what we are discussing about then? The workaround is redundant and

   I don't know. :-) Your arguments so far seem bogus (sorry! :-))...

> no need to have a dead code in the driver, really.

  "Jazz isn't dead, it just smells funny". :-)

>>> If it is the case, go and fix them, no need to workaround
>>> in each of the callers.
>>
>>    There's a need to work around as long as IRQ0 ican be returned, otherwise
>>    we get partly functioning or non-functioning drivers...
> 
> You get them unfunctioning anyways

   The drivers would be broken in not quite obvious ways. With IRQ0 check, they just
don't probe anymore. See the explanation of the IRQ0 check (in the drivers) in my
previous mail...

> and you get the big WARN() even before this patch.

   As if that was enough...
   The IRQ0 problem exists for at least 15 (if not 20) years...

MBR, Sergey
