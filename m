Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5447D594
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbhLVRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLVRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:06:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07913C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:06:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b73so2063738wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vw1KhbhuKWFVCrYw7Go1sbi4Em3+r21Grhp7IO/l0wQ=;
        b=f7Oiv0nzZdLq7r6eSykUMzJBdK/SfzOwckGNl8JPVZjpvfuyMMf/0GkH0sGMShEquM
         SeTCOhWWEpVP8so4r/uQwtEGFbOKRV1NqO6bqPu+9XW2LxnaHw/h9Kbo7A2iTJ3BT5pU
         0G+rw5zgCNNjLk3u6X1v/d2wBV7NWVEcuFJ9NSdT7PirpNhiGwcKuhm6ZN7tTVHdKUS6
         YjCML8M1zUbLcUwA8SWVJBgtu5WUDc5FnlBuwbucZUn2WlGPeBlprMssxB6oXEGRdg9X
         tIW6bkyCmoDN7ugsYwOser7/hBmkH+vnWIYyqhYbeo/oAFdQWDZHMfGTAkf90q1w9wxv
         5/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vw1KhbhuKWFVCrYw7Go1sbi4Em3+r21Grhp7IO/l0wQ=;
        b=787xtTSfRvGLcHq6MbEwf99MX/of+gXfd1ORlbhTHdJxuEpD+riN6ho1YAjg3eCM66
         OdJcjQ96GwewC1TZE4qYjcd0nacbXMplqkBMR6DVN7QiMwIZ/H2gwz2B59uIOVEPdcLc
         8umzJ8IzJcEItF/YYvdQPjjg17ECwB/lve4oNkr8w98s5pi7PmbBZ4teGcnmKb+7Kj/S
         AyD118cdfxHAdyGWIrbvfVdLLAqEPZDnkMd8nsNFqys280RDGSzj4lHu5TY9MH5ooWmO
         JMeSU3DSXb6s2ySExQ/5ncr7KT4QNpduKQ6cBuvaFIcmmXWJRK0tIP3ElbnyXkj3WYBq
         8K9Q==
X-Gm-Message-State: AOAM531o97s3ScZpAdVoNqB4XPAcxDRF1FuSKNobKXQdbXJknFfyfmmn
        aIa7cF07ryW9ym8EoBR+CjWLeA==
X-Google-Smtp-Source: ABdhPJyQmswUtojvAlvB17/lzqSERlYocStmQn9nmnj/YPKjY9JXZ0amCSmSPxEao4rcvX9UU73HVQ==
X-Received: by 2002:a1c:495:: with SMTP id 143mr1545038wme.178.1640192786590;
        Wed, 22 Dec 2021 09:06:26 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:7800:3dae:64a4:7964:a371? (p200300d9970878003dae64a47964a371.dip0.t-ipconnect.de. [2003:d9:9708:7800:3dae:64a4:7964:a371])
        by smtp.googlemail.com with ESMTPSA id u10sm2429065wrs.28.2021.12.22.09.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 09:06:26 -0800 (PST)
Message-ID: <4d786a02-1560-25ed-4603-8419672ec044@colorfullife.com>
Date:   Wed, 22 Dec 2021 18:06:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ipc/sem: do not sleep with a spin lock held
Content-Language: en-US
To:     Vasily Averin <vvs@virtuozzo.com>, cgel.zte@gmail.com,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, rdunlap@infradead.org, dbueso@suse.de,
        unixbhaskar@gmail.com, chi.minghao@zte.com.cn, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211222081026.484058-1-chi.minghao@zte.com.cn>
 <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
 <1181e64b-94c0-908a-b9e9-1a38f4610430@virtuozzo.com>
 <02171384-9d1e-19fa-5fa1-5f84b720a03e@virtuozzo.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <02171384-9d1e-19fa-5fa1-5f84b720a03e@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

On 12/22/21 16:50, Vasily Averin wrote:
> On 22.12.2021 18:31, Vasily Averin wrote:
>> On 22.12.2021 14:45, Manfred Spraul wrote:
>>> Hi Minghao,
>>>
>>> On 12/22/21 09:10, cgel.zte@gmail.com wrote:
>>>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>>>
>>>> We can't call kvfree() with a spin lock held, so defer it.
>> I'm sorry, but I do not understand why exactly we cannot use kvfree?
>> Could you explain it in more details?
> Got it,
> there is cond_resched() called in __vfree() -> __vunmap()
>
> However I'm still not sure that in_interrupt() is used correctly here.

I see three different topics:

- is the current code violating the API? I think yes, thus there is a 
bug that needs to be fixed.

- Where is __vunmap() sleeping? Would it be possible to make __vunmap() 
safe to be called when owning a spinlock?

- should kvfree() use vfree() [i.e. unsafe when owning a spinlock] or 
vfree_atomic [i.e. a bit slower, but safe]


As we did quite many s/kfree/kvfree/ changes, perhaps just switching to 
vfree_atomic() is the best solution.

@Andrew: What would you prefer?

In addition, if we do not use vfree_atomic(): Then I would propose to 
copy the might_sleep_if() from vfree() into kvfree()

--

     Manfred

