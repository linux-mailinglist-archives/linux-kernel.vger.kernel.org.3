Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8C4F8F07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiDHGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiDHGau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:30:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC28654A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:28:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fu5so7773727pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Br5LmK6nq3U1CMGhLvbfnGvSCpmEH6bnjhJxgA+ANDc=;
        b=XRQxVTp0UjrQE+0dxzV3BWqyhAfGjYNmCmAfXmihCUoizoYiv6esmwTl2zufz8w2uP
         kLj3HlRnWG7m5O6kNpESs121XW5IY/kW+hdpgzcdzLAb1/czspF9wCBPnYcx+rgxe46f
         GbSQefCvNrszqOdMEfmu/i0Zjk1m+oC/zwjPybp710dYlPWZOQKTy66OW71m3+/vpjl2
         E3r+vR8mx+4Le0EtD5aCcXD8ytwUV4SM5SgNZe2JWmmrbiLYu5InJrt+IucLBR4mXYA6
         DLfIRloquRFlSwexHgXvx9m1N4j89PJamBhtXmIIbTo/pAWp3xuIcUwqgywSaN2K/T43
         ciWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Br5LmK6nq3U1CMGhLvbfnGvSCpmEH6bnjhJxgA+ANDc=;
        b=Wyt03Zfx/fjf5AmsfIZW2/SWZG3pPZ+8hqB9QFHI2AL0H24CDe6h25C46MGS6GsjPC
         tP8QSw+qjqB1HnxMn0rjkOKt2BZ1loHbUZIQH8UEr7g5Nhtd4lESR4Le4ozemdvqSJvL
         97R0tkH1MMsznjXBUc4+SI+uAjNRCnmDEUfFi7Z+wW236rjXx/UkIXjD8cRU7Rz47lzv
         VjwucBJ25W//NPgivxVNzw+bJV0nHo59g+WT5xQf5j2b5Y5tYGSVUqj2/Z9niYexJ+Sn
         MTKMPBngV2RkOe804/pq2WbwhwJLPZPbityDIpjeetw3KUP8YI8/PkXZ8WKPxLb3uZRs
         IbDA==
X-Gm-Message-State: AOAM531skNhsTGnpyE9ZFhKCb9B9hT0gKjcDPkKEbyan8/b0KSnRKS1+
        btD2bzX53urVA4zPy13jtMOyug==
X-Google-Smtp-Source: ABdhPJwfPZEsuTJTC4HDVf3PL7Z0TonE+kb/GGzgZsL3jkkNuuCHjBjoBMEuLKkbX8IlVFZ730jUZw==
X-Received: by 2002:a17:903:2302:b0:157:1c5f:14f0 with SMTP id d2-20020a170903230200b001571c5f14f0mr3711035plh.138.1649399327236;
        Thu, 07 Apr 2022 23:28:47 -0700 (PDT)
Received: from [10.255.182.146] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s10-20020a63a30a000000b003987eaef296sm20747184pge.44.2022.04.07.23.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 23:28:46 -0700 (PDT)
Message-ID: <aad36908-3e95-a8c9-533d-2a39ea76cd3a@bytedance.com>
Date:   Fri, 8 Apr 2022 14:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Content-Language: en-US
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
 <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
 <20220407205419.f656419a8f4665a2dc781133@linux-foundation.org>
 <35195a61-d531-aeb2-5565-146e345f8bf6@bytedance.com>
 <20220407211018.875696691e4411a7b5c8f63f@linux-foundation.org>
 <d546cbce-b1d6-9499-3093-796cad7be9aa@bytedance.com>
 <Yk/OtIKckFprZrGx@fedora>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Yk/OtIKckFprZrGx@fedora>
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



On 2022/4/8 1:57 PM, Dennis Zhou wrote:
> On Fri, Apr 08, 2022 at 12:14:54PM +0800, Qi Zheng wrote:
>>
>>
>> On 2022/4/8 12:10 PM, Andrew Morton wrote:
>>> On Fri, 8 Apr 2022 12:06:20 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>>
>>>>
>>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>>
>>>>>>> Are any users affected by this?  If so, I think a Fixes tag
>>>>>>> is necessary.
>>>>>>
>>>>>> Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
>>>>>> affected by this.
>>>>>>
>>>>>> I see that this patch has been merged into the mm tree, can Andrew help
>>>>>> me add the following Fixes tag?
>>>>>
>>>>> Andrew is helpful ;)
>>>>>
>>>>> Do you see reasons why we should backport this into -stable trees?
>>>>> It's 8 years old, so my uninformed guess is "no"?
>>>>
>>>> Hmm, although the commit 490c79a65708 add wake_up_all(), it is no
>>>> problem for the usage at that time, maybe the correct Fixes tag is the
>>>> following:
>>>>
>>>> Fixes: 210f7cdcf088 ("percpu-refcount: support synchronous switch to
>>>> atomic mode.")
>>>>
>>>> But in fact, there is no problem with it, but all current users expect
>>>> the refcount is stable after percpu_ref_switch_to_atomic_sync() returns.
>>>>
>>>> I have no idea as which Fixes tag to add.
>>>
>>> Well the solution to that problem is to add cc:stable and let Greg
>>> figure it out ;)
>>>
>>> The more serious question is "should we backport this".  What is the
>>> end-user-visible impact of the bug?  Do our users need the fix or not?
>>
>> The impact on the current user is that it is possible to miss an opportunity
>> to reach 0 due to the case B in the commit message:
>>
> 
> Did you find this bug through code inspection or was the finding
> motivated by a production incident?

I find this bug through code inspection, because I want to use
percpu_ref_switch_to_atomic_sync()+percpu_ref_is_zero() to do something
similar.

> 
> The usage in block/blk-pm.c looks problematic, but I'm guessing this is
> a really, really hard bug to trigger. You need to have the wake up be

Agree, I manually added the delay in wake_up_all() and percpu_ref_put()
to trigger the case B.

> faster than an atomic decrement. The q_usage_counter allows reinit so it
> skips the __percpu_ref_exit() call.
> 
> Thanks,
> Dennis

-- 
Thanks,
Qi
