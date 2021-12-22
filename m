Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414D347CE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbhLVJAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhLVJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:00:08 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEACEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:00:07 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z8so2664730ljz.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=KspBUSbJLNlP0yC6HNjWEU5tJDHzB7XxdNZVksoaM+s=;
        b=G3Po6n+t0dCNiTjiHl28JFRRtIomiIo2s6plI3GN4f4W4/w8pC2YgvHsY7hITuw7Na
         W74jwjf4kLIkWsm9SnP+s2ZjQv3pfszbulf9B88JEPdUbTbiSjEGF4uMHDgshsUVwFds
         2ZBAhnuQWPg25wELT26N2/TzsLKkhbmSPtrUA3la9SzSkGz4j1nlt05y2g4n+mar/+9R
         Eg637tdVLlWtYfGT0x93IqYI0Wqh0Q9jK98SZXcD0PI3ceesyN2ghKsMcGgm2gZE6t/T
         Dzjxc2Ry4l5pyRW6r4nC16Fex4pPWss2m6AW4komcqxeeg/rAGCvUmkKdT2AbPzI7jS8
         tXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KspBUSbJLNlP0yC6HNjWEU5tJDHzB7XxdNZVksoaM+s=;
        b=eq/ow1wTk+NWvWf5W/usmu0IHVL4kxRakiGkmW1m7mhr7eRiWlvg23m+bAox49aeUP
         nFA+o8XYafbL3lSLUSBLyBG+wtVm+/EcUzO7mZM1o1TJXoxVycqwrjLPimrEelI3PQjn
         KcGb51I07QRv7ibGRK/qcEekzigZ2NUdrBvVLyEQ51+HEE92Ffz7SpFpKUYVk5GsNbuO
         vs0da748Wy/+zvurIc4DI1rbKVw9mWUTdIXa0y6VzsKG77hMKOV/Mny9+9fpp64o41n3
         q1/nS9wBaB9RPLKLNUtopwayAYTMJJTeDDAM6fVjtGCWjthE5WCo7vCzADSzVSGAMUxN
         vmfA==
X-Gm-Message-State: AOAM530IlFg7oj9LfLDv4fDdiyLNYRl+XyuSOuBBJIeNueq7GGT8F1/8
        2haZcEkw1byRbc8ZH2oaCpg=
X-Google-Smtp-Source: ABdhPJyCDHsw+B07eiZ2g13OQKG81eBXRjy+goqYNCSXXFoiPZV6XHY9JP5U3ouaZAp0OdTG1c3WFg==
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr1583072lji.303.1640163606198;
        Wed, 22 Dec 2021 01:00:06 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id p18sm151341lfc.297.2021.12.22.01.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:00:05 -0800 (PST)
Message-ID: <52a2a318-0efe-94af-b8b9-308c2fbb1fab@gmail.com>
Date:   Wed, 22 Dec 2021 10:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register() error
 path
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com> <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com> <YcLkA0e48+xuGsHk@hovoldconsulting.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcLkA0e48+xuGsHk@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 09:38, Johan Hovold wrote:
> On Wed, Dec 22, 2021 at 08:44:44AM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
>>> On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
>>>> On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>
>>>>> 1. Drop incorrect put_device() calls
>>>>>
>>>>> If device_register() fails then underlaying device_add() takes care of
>>>>> calling put_device() if needed. There is no need to do that in a driver.
>>>>
>>>> Did you read the documentation for device_register() that says:
>>>>
>>>>    * NOTE: _Never_ directly free @dev after calling this function, even
>>>>    * if it returned an error! Always use put_device() to give up the
>>>>    * reference initialized in this function instead.
>>>
>>> I clearly tried to be too smart and ignored documentation.
>>>
>>> I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
>>> Most kernel functions are safe to assume to do nothing that requires
>>> cleanup if they fail.
>>>
>>> E.g. if I call platform_device_register() and it fails I don't need to
>>> call anything like platform_device_put(). I just free previously
>>> allocated memory.
>>
>> And that is wrong.
> 
> It seems Rafał is mistaken here too; you certainly need to call
> platform_device_put() if platform_device_register() fail, even if many
> current users do appear to get this wrong.

Yes I was! Gosh I made up that "platform_device_put()" name and only
now I realized it actually exists!

I stand by saying this design is really misleading. Even though
platform_device_put() was obviously a bad example.

Please remember I'm just a minor kernel developer however in my humble
opinion behaviour of device_register() and platform_device_register()
should be changed.

If any function fails I expect:
1. That function to clean up its mess if any
2. Me to be responsible to clean up my mess if any

This is how "most" code (whatever it means) works.
1. If POSIX snprintf() fails I'm not expected to call *printf_put() sth
2. If POSIX bind() fails I'm not expected to call bind_put() sth
3. (...)

I'm not sure if those are the best examples but you should get my point.
