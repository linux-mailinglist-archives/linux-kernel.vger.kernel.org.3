Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C24F8D72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiDHERH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiDHERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:17:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFAD2D3126
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:15:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so6765550pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 21:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pOCryi92y3m1WkTBJLqgjo+HtAoZSo+2BAEOkz/hDyU=;
        b=A6eqfmfvzLeXiy68rSdZQhgf8H4Hu16PlZ9UlNjlgjJW9F8Jo7pIiIJhwksooVtT4t
         FMb6AbovM2vuBKTG7o8khYQoaE9a7ZGGZwx1GSP8hjCT8wQYJk3CrGHJGBey/3GFGjZp
         MV2djrxZBLrthdxvzrq12WcuypZRrTtg6NVhClVhwTDHwU+6Cge4yzEkU8wmfZ1PJPcr
         VIahloi7EeAuO18oAMqY1TVrLSTpKIWmcaJbjfUQsxy4VhxaoQ8TX31kD8pxP87mPqJb
         49BRaKRo5dEzCWYjthE663qTY7z4XHNus5FupBEBJn0TV09kQthVsUfiSsxBpP1trUZy
         h4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pOCryi92y3m1WkTBJLqgjo+HtAoZSo+2BAEOkz/hDyU=;
        b=kYhPNQv3Di4RN2R1xJjr/4OvtFybiVWleBifuVYUmfA9yFtT8Wvkbi7aIyBY+ImABu
         RndKSprC++RHSjvoZLa5NDwM8ErSbAO4EMvHZ8v4dCb/sLex+5eb5ErTwiqbJEdDyqcm
         Ee33Qh6FToFQGEkW+U+hUoSBkwNc/Rw4uFsvUfhIeI5FsoEPP8LTwlUcpFDM+UFJbC18
         KbbaoGB2SXih8H4yd5ez9G2stV5XNowarw9t6sFnU4elWuujuhr+x4aXIoXZ3Pn/5Myo
         vZ6FpScIzcmnbfQVtNqd5TD4VOpX2osiWGdwqM51o6R4tq2xRIHlm8//rg4iov8Gc4px
         cBUA==
X-Gm-Message-State: AOAM532dPKYpP7/aOGD2RuAQBhgIjPXUtCGa7Y0Dob+bbpRkCugnaQuM
        gd4rHUGPkAjOM6ji95QtdKJjXw==
X-Google-Smtp-Source: ABdhPJxJxGb8VUnjuiRO0COy24E2Vzk3Io06caBr41iKv2K+P5tj3YHBgTo/DBgjCuUKEqSAwf3Wlg==
X-Received: by 2002:a63:6984:0:b0:398:8db9:7570 with SMTP id e126-20020a636984000000b003988db97570mr13741565pgc.373.1649391300498;
        Thu, 07 Apr 2022 21:15:00 -0700 (PDT)
Received: from [10.255.182.146] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm24915810pfo.208.2022.04.07.21.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 21:14:59 -0700 (PDT)
Message-ID: <d546cbce-b1d6-9499-3093-796cad7be9aa@bytedance.com>
Date:   Fri, 8 Apr 2022 12:14:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
 <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
 <20220407205419.f656419a8f4665a2dc781133@linux-foundation.org>
 <35195a61-d531-aeb2-5565-146e345f8bf6@bytedance.com>
 <20220407211018.875696691e4411a7b5c8f63f@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220407211018.875696691e4411a7b5c8f63f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/8 12:10 PM, Andrew Morton wrote:
> On Fri, 8 Apr 2022 12:06:20 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>
>>>>> Are any users affected by this?  If so, I think a Fixes tag
>>>>> is necessary.
>>>>
>>>> Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
>>>> affected by this.
>>>>
>>>> I see that this patch has been merged into the mm tree, can Andrew help
>>>> me add the following Fixes tag?
>>>
>>> Andrew is helpful ;)
>>>
>>> Do you see reasons why we should backport this into -stable trees?
>>> It's 8 years old, so my uninformed guess is "no"?
>>
>> Hmm, although the commit 490c79a65708 add wake_up_all(), it is no
>> problem for the usage at that time, maybe the correct Fixes tag is the
>> following:
>>
>> Fixes: 210f7cdcf088 ("percpu-refcount: support synchronous switch to
>> atomic mode.")
>>
>> But in fact, there is no problem with it, but all current users expect
>> the refcount is stable after percpu_ref_switch_to_atomic_sync() returns.
>>
>> I have no idea as which Fixes tag to add.
> 
> Well the solution to that problem is to add cc:stable and let Greg
> figure it out ;)
> 
> The more serious question is "should we backport this".  What is the
> end-user-visible impact of the bug?  Do our users need the fix or not?

The impact on the current user is that it is possible to miss an 
opportunity to reach 0 due to the case B in the commit message:

/* The value of &ref is unstable! */
percpu_ref_is_zero(&ref)
						(B)percpu_ref_put(ref);

Thanks,
Qi

> 

-- 
Thanks,
Qi
