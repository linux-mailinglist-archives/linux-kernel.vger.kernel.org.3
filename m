Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF174F8DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiDHDwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiDHDwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:52:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0CB2AF1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:50:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so6800422pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yri1+dD9YTtfEYoo0sek4XbFS6BxTvyBbf5TNk3U90o=;
        b=WODuTTNn47Q2SBC5Dxw0wpqxb9ydKvbKEXjfJrxlphLYM5jZo75Ao+s4Rp4Jnct4Ri
         JKRnje18SncYap4SF6hKm1LHj/Jg8MJU2H+lusXwU77kDdI+f6PP+/qsm6kYd1tjKoZC
         H6lAmkjBN/Mx3Jj9Y3t3HJVdJIkH/ZWSAqJf/IafIxNN8g4yntO9wmPOh2S1tjCwFQN9
         bRpodm0/QpjyG4eHxDjVOKLWfn6FQK56DkJi51tdUVDkJIbxIC9+4hjDWa8oE2IgOKQY
         OazY8XwIprG+ry6nOk4zX4e8QQBd+yU45fnp5+3ynOyC9+mKx6WGq78m/5whGjA4JMIY
         TLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yri1+dD9YTtfEYoo0sek4XbFS6BxTvyBbf5TNk3U90o=;
        b=TVjsgNbUffSdgdLyqnBPDEgwmOdQ9x5UOzfmME0w/abxnY44lPuRg7SnXAJFcKRnP/
         gAnr3TwUnYsYljOYpilwuW5YElNKvRcZqG/cxjTr5/zAqlm0YxWpCwdMffs/14k82zDt
         Bm15Ermj0bg4nF5gExdCwzkGYzurDIsLCLcG8c4aTtUQXsOp+F4oZvXGpxrfjlFN1lqE
         pH49TzSSLhwrK6327Qyyi6bbwfxPJF/9nxcPi3ZapwpoxtXVlNIbtGG2qYNeKao6gKUT
         66kOAdlbgdrftNdZQCKe/cIwiqqi8V3TucI+Nf9D39A6gPzwZrz8ThZJ/4yFn+AFMCh1
         sKtA==
X-Gm-Message-State: AOAM530k+RvDbSybnOTObUqxN5q5noJU1uX3Uk3zbW5MybENl0m3c6XI
        z0zyz9cWyHFlVXkp0oOXl5RuNg==
X-Google-Smtp-Source: ABdhPJxJhrpv+/5wGqS06IUZyOqAj6WaVRKhTM/L7ukRNxpkiNA7K2w4rulR6PU9LDEe/khCqVIi2w==
X-Received: by 2002:a17:90a:6389:b0:1c9:ee11:6c2c with SMTP id f9-20020a17090a638900b001c9ee116c2cmr19697230pjj.107.1649389812176;
        Thu, 07 Apr 2022 20:50:12 -0700 (PDT)
Received: from [10.255.182.146] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s31-20020a056a001c5f00b00504e93e536bsm4201026pfw.97.2022.04.07.20.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 20:50:11 -0700 (PDT)
Message-ID: <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
Date:   Fri, 8 Apr 2022 11:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
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



On 2022/4/8 10:54 AM, Muchun Song wrote:
> On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
>> In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
>> before calling percpu_ref_put(), which will cause the value of
>> percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
>> returns.
>>
>> 	CPU0				CPU1
>>
>> percpu_ref_switch_to_atomic_sync(&ref)
>> --> percpu_ref_switch_to_atomic(&ref)
>>      --> percpu_ref_get(ref);	/* put after confirmation */
>> 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
>>
>> 					percpu_ref_switch_to_atomic_rcu
>> 					--> percpu_ref_call_confirm_rcu
>> 					    --> data->confirm_switch = NULL;
>> 						wake_up_all(&percpu_ref_switch_waitq);
>>
>>      /* here waiting to wake up */
>>      wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
>> 						(A)percpu_ref_put(ref);
>> /* The value of &ref is unstable! */
>> percpu_ref_is_zero(&ref)
>> 						(B)percpu_ref_put(ref);
>>
>> As shown above, assuming that the counts on each cpu add up to 0 before
>> calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
>> to atomic mode, percpu_ref_is_zero() can return true. But actually it will
>> return different values in the two cases of A and B, which is not what
>> we expected.
>>
>> Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
>> just to ensure that the conversion to atomic mode is completed, but it
>> should not return with an extra reference count.
>>
>> Calling wake_up_all() after percpu_ref_put() ensures that the value of
>> percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
>> So just do it.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Are any users affected by this?  If so, I think a Fixes tag
> is necessary.

Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
affected by this.

I see that this patch has been merged into the mm tree, can Andrew help
me add the following Fixes tag?

Fixes: 490c79a65708 ("percpu_ref: decouple switching to atomic mode and 
killing")

Thanks,
Qi

> 
> The fix LGTM.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Thanks.
> 

-- 
Thanks,
Qi
