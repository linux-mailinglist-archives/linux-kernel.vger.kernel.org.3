Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C247C53E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhLURqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLURqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:46:06 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36747C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:46:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id k23so22654433lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=o3FlXCy0JHrz9XJouLhS1NxteMKReYlLkU+f0JM7tZE=;
        b=ldSGImC+D7OASpfYABoWYdQZil6R7YQl9uwJ9nhNQ11mVa/B2we65v34UXSuIhCFsU
         S9l8s3NTa/ekzkDLhBzEJXR6P4p+CAK2ah6HZ6ncRTjAds2xAXZbA2yq1Js1YAIb+z7p
         Ez/nELy9gX/oQnrFA2E4UIuVzt11C0fUZ+AjIFDpievLXI5CkXEk1htklrBXJEewzJrR
         0fSh5QpFK2kVoOcM20h1hBvIQFyso3hBzJ9BPMe7ZxkKZsZTEaJ+Yx6N5o7qLbVs+iUj
         qT46wSwfu4TZ5TMjIEF3FuMzQcjfrEW2OyRkuRWkapAoc05NYXG/+EvV6SPxlxLhpt1H
         8uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o3FlXCy0JHrz9XJouLhS1NxteMKReYlLkU+f0JM7tZE=;
        b=GGCpNJrWwP2y1SXkY+FXAeY4lt/nszaQ7w4+cSccF/7P72oh570+446qSmHNd9suuF
         jr4KIBl3TlhxuZUyGHDrlPmLJeOTVWhwj15NMd8PxEBS/sGNOnn1Kj4NcUxk+jRxGu69
         P2q/aSOhAFvvjL4gAtRqbfZrEwghKx2ISS+1mH6sY6foe/PZx/x1g6XVCanX2Y+uL/HN
         KydApGFRN9/0gyy5EADdcu3DhRxcpjqbPcaXNLwQUHKBvZhxNQQfXFiEQ8PEOOpDTt+Y
         OXObXap4DlQnrGCudCEXUCZTvhwWRmia1arSCC6e32Bzp7+YapN0dIFepnsDSjkCxLrQ
         7MNA==
X-Gm-Message-State: AOAM531+2qRHBXkaPUO6uG8wvgTCMoYmPOwfAUCQrN+EmGkZVb7lGak9
        LmygNk2BMRHKGB2YfsgrXX3x5HxphM8=
X-Google-Smtp-Source: ABdhPJzQszLfhnJaVMazVJc8Dptwp2fxNLkTZXEzcA4OXINsZH1iskg+qq0aLV+90k8HzRGy6rDUDw==
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr3468967ljj.105.1640108764434;
        Tue, 21 Dec 2021 09:46:04 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id c6sm700637lff.268.2021.12.21.09.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:46:04 -0800 (PST)
Message-ID: <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
Date:   Tue, 21 Dec 2021 18:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register() error
 path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcH7fw5S6aSXswvb@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> 1. Drop incorrect put_device() calls
>>
>> If device_register() fails then underlaying device_add() takes care of
>> calling put_device() if needed. There is no need to do that in a driver.
> 
> Did you read the documentation for device_register() that says:
> 
>   * NOTE: _Never_ directly free @dev after calling this function, even
>   * if it returned an error! Always use put_device() to give up the
>   * reference initialized in this function instead.

I clearly tried to be too smart and ignored documentation.

I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
Most kernel functions are safe to assume to do nothing that requires
cleanup if they fail.

E.g. if I call platform_device_register() and it fails I don't need to
call anything like platform_device_put(). I just free previously
allocated memory.

When calling device_register() / device_add() it seems device always
gets partially registered (even if it fails!). Enough to make it safe to
depend on core subsystem calling .release() after device_put().

So what initially looks like unbalanced device_put() call is actually
some device_add() specific magic behaviour ;)

Sorry. I should have checked documentation before posting patches.
That's not my best day.


>> 2. Use device_unregister()
>>
>> Now that we don't call put_device() we can use above helper.
>>
>> Fixes: 3360acdf8391 ("nvmem: core: fix leaks on registration errors")
>> Cc: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> That put_device() was explicitly added by Johan but after checking
>> device_register() twice I still think it's incorrect. I hope I didn't
>> miss sth obvious and I didn't mess it up.
>> ---
>>   drivers/nvmem/core.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 785a56e33f69..f7f31af7226f 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -901,12 +901,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   
>>   	rval = device_register(&nvmem->dev);
>>   	if (rval)
>> -		goto err_put_device;
>> +		return ERR_PTR(rval);
> 
> Where do you call put_device() to free the allocated memory?
> 
> You just leaked the kzalloc() call to allocate the memory pointed to by
> nvmem :(
> 
> I think the code is fine as-is.

Yeah, I forgot about:

ida_free(&nvmem_ida, nvmem->id);
kfree(nvmem);
