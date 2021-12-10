Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F76470A79
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbhLJTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhLJTjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:39:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DAC061746;
        Fri, 10 Dec 2021 11:35:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d10so19884209lfg.6;
        Fri, 10 Dec 2021 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkaMYK6k4GTvrZV/obexn68ZFt4o4d+aNe1fFAvnH3U=;
        b=O46xpJ5fNNty60YRL6OHCxNcT9mxIwLkzi47NXcK31RgUIJ9wt7IOhpHjeraV/KG/C
         5eAnogxaII4BOOg+qChfy31HAP6VjU3/yfyD6yekmH57KxOVm0CAsE2fM6sLiNS565eE
         aXUuiXRl35ckWqGWb2bLt/AHbQPhjqBddP7qaB/DE5vMeNAaVHMhhDoY9p1OUUDvDOZr
         VYz4gDN5GBJYBQPVn9jgHIcylA2Y0e9lj+8JS+ApGZSAQJufPs0zvtP1KNk0cPT9pV4f
         P7bkDSeX5Max2sz+xgiTJ+de54iuOXb5PfHMV5d2+c0Euy37puvqQwhZf9N70DWTe8aT
         5ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkaMYK6k4GTvrZV/obexn68ZFt4o4d+aNe1fFAvnH3U=;
        b=oH/hApJQ9Z8SSPl2tXV6MxO/AMph3dhXJsMTT5dnPBGAYkJbmzOzJVBYZXFiZj3Tjd
         oSnrRuX9L0PN9TKFvDskd/FGicCBHYReKFa/yrPv5AEzz1coqSBOhS9L6/rOYlV063Ln
         /8or+GDfo80xuGWMA6xgvt2RBx48kU6UJAHDUmvDyKwLjyQ3qUK4KEu/tR7VMUm2ZAmt
         +40STa7iMewJCvUXXabBkK2HzXNrragj7JbIPbNZnMdslXKd6/XFQI3dqIz5PCn/cI2y
         eBnmusvdiNxZhwOKlbboyp2M4lhSZO4rT0C+LkqTsc2JUKlI2QH9SWuHZQOA427Bsu8m
         DuzQ==
X-Gm-Message-State: AOAM53285Kjhbp12qgICqR1O+uA4WVDCk6kjlsR7XkXRWkEfsik0uedg
        JTDXjOIwRrbYspWC1CCyOoE=
X-Google-Smtp-Source: ABdhPJzjMjkgyzWpwhjenxauzzegNdt7iGI5EKuNn44VC0Ch+IXEQO8nkPWeltJSA3OgXVbm5hLiow==
X-Received: by 2002:ac2:4e07:: with SMTP id e7mr13778298lfr.632.1639164943025;
        Fri, 10 Dec 2021 11:35:43 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.189])
        by smtp.gmail.com with ESMTPSA id g14sm393851lfv.138.2021.12.10.11.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:35:42 -0800 (PST)
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 <6c03ffef-b2e0-16ba-35f3-206af2a611d2@gmail.com>
 <YbOVmGw7ys6U51z3@smile.fi.intel.com>
 <9d688cd8-99e3-0265-06aa-d44597e7686c@omp.ru>
 <YbOpu2whB5NaXbNa@smile.fi.intel.com>
 <a0bf3377-21ed-7244-7c73-ebb50dbc44c4@omp.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <448ce97b-699d-bdab-b4e9-c9439fd81a85@gmail.com>
Date:   Fri, 10 Dec 2021 22:35:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a0bf3377-21ed-7244-7c73-ebb50dbc44c4@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 10:30 PM, Sergey Shtylyov wrote:

[...]
>>>>>>>>>>> platform_get_irq() will print a message when it fails.
>>>>>>>>>>> No need to repeat this.
>>>>>>>>>>>
>>>>>>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>>>>>>>> out a big WARN() in such case.
>>>>>>>>>>
>>>>>>>>>> The reason you should be able to remove the "if (!irq)" test is that
>>>>>>>>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>>>>>>>>>> says. But looking at platform_get_irq_optional(), which is called by
>>>>>>>>>> platform_get_irq(), the out label is:
>>>>>>>>>>
>>>>>>>>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>>>>>>>>> 	return ret;
>>>>>>>>>>
>>>>>>>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>>>>>>>>> return -ENXIO:
>>>>>>>>>>
>>>>>>>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>>>>>>>>> 		return -ENXIO;
>>>>>>>>>> 	return ret;
>>>>>>>>>
>>>>>>>>>    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>>>>>>>>> but returns -EINVAL instead.
>>>>>>>>>
>>>>>>>>>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
>>>>>>>>>
>>>>>>>>>    Of course it isn't...
>>>>>>>>
>>>>>>>> It's unsubstantiated statement. The vIRQ 0 shouldn't be returned by any of
>>>>>>>> those API calls.
>>>>>>>
>>>>>>>    We do _not_ know what needs to be fixed, that's the problem, and that's why the WARN()
>>>>>>> is there...
>>>>>>
>>>>>> So, have you seen this warning (being reported) related to libahci_platform?
>>>>>
>>>>>    No (as if you need to really see this while it's obvious from the code review).
>>>>>
>>>>>> If no, what we are discussing about then? The workaround is redundant and
>>>>>
>>>>>    I don't know. :-) Your arguments so far seem bogus (sorry! :-))...
>>>>
>>>> It seems you haven't got them at all. The problems of platform_get_irq() et al
>>>> shouldn't be worked around in the callers.
>>>
>>>    I have clearly explained to you what I'm working around there. If that wasn't clear
>>> enough, I don't want to continue this talk anymore. Good luck with your patch (not this
>>> one).
>>
>> Good luck with yours, not the one that touches platform_get_irq_optional() though!
> 
>    Mmh, I'm not touching it any way that would break what your patch was trying to do,
> unless you've re-thopught that. It also shoudn't matter whose patch gets merged 1st 
> other than some small adaptation).

   BTW, looking at [1], this comment is wrong:

+ * Return: non-zero IRQ number on success, negative error number on failure.

It doesn't mention 0 which you return from this function.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed7027fdf4ec41ed6df6814956dc11860232a9d5

MBR, Sergey
