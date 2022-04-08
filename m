Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81AA4F8E56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiDHEIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiDHEIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:08:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41112C9CC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:06:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j17so5876277pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lC/S2KdK6htJ/0XVw5t63OQ6XQqy6Czgh49cIxpFamo=;
        b=OchzGeA90SPwbI5e/TKwnVYF6eponyzo16YY6YV3WAdcJWFCrwon7p5/SuunSFpTSF
         KMJAzi6Lh0fDtcXRzyTcxVNSL7SFq45xs3CoV+T024uucXl8Sv0cBI5SiTSRTIHI2fPd
         IL/O9XUux2/dpn6KIl+ImaLl7gsyt/dDmIUfpKKJGlq2Vlcvwh48Lt5W9gWGMxhMnx6j
         JeXIiryUCutyaqmkgvLrNiHpi7OHkuTjHDPstovLtzwCksu01qbZuuivZtXv8jfKEAcD
         XbbkhA/0KYmjIR4LlSqdK69OPJdfOLj8Hz5dz1h+WJnQAB7ZfC5KCYx9i5LnRTHO881J
         HNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lC/S2KdK6htJ/0XVw5t63OQ6XQqy6Czgh49cIxpFamo=;
        b=Yv2m5H1H5oeNC1exoPRLktADY48PwZrVAd6qvUqZ7cgV4gAtTif0EMpQKvlGe16lF7
         haLRT9olTZgxc1O7g4UXfc5ybqhqMIJjn52WKav+tFWOdZ1GbPMIiqRcqynQgE2QFZIp
         jtIoKfGUHd/xpqsZs++Gy5JfBfo7sJS0b9JKY970oHnhhpcwtPbhWKNYWxhqS9ue4J4Y
         ifOpShKNt4xL+lMRKaz/i4qgly4P1zzGjUlmjhY6e+hjT0HHke2+zdD8YpqjtFKzULcN
         QvpGzxppcC1eucdotqftLkGTPqqa8IjYXF/6b2WX1Y0PrppQOz/FuCs9zkxleLb8wvBc
         nlYw==
X-Gm-Message-State: AOAM5330p/lI+/QtPIwqNfJ+cpGG6nJGZ1tySuxiWcEKfEzBiFhwXK+Z
        dO6QdW7LwkgoU4OELJiQ5XHDlQ==
X-Google-Smtp-Source: ABdhPJxwbpowte1lbWo5ckVfns8sKuidwHES4wRQvJgShvpcBXb7aUjn412jk2xtuJW/r4/YkGhJhw==
X-Received: by 2002:aa7:8154:0:b0:505:68a6:600d with SMTP id d20-20020aa78154000000b0050568a6600dmr6000019pfn.35.1649390786223;
        Thu, 07 Apr 2022 21:06:26 -0700 (PDT)
Received: from [10.255.182.146] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm23723547pfi.163.2022.04.07.21.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 21:06:25 -0700 (PDT)
Message-ID: <35195a61-d531-aeb2-5565-146e345f8bf6@bytedance.com>
Date:   Fri, 8 Apr 2022 12:06:20 +0800
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220407205419.f656419a8f4665a2dc781133@linux-foundation.org>
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



On 2022/4/8 11:54 AM, Andrew Morton wrote:
> On Fri, 8 Apr 2022 11:50:05 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>>
>> On 2022/4/8 10:54 AM, Muchun Song wrote:
>>> On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
>>>> In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
>>>> before calling percpu_ref_put(), which will cause the value of
>>>> percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
>>>> returns.
>>>>
>>>> 	CPU0				CPU1
>>>>
>>>> percpu_ref_switch_to_atomic_sync(&ref)
>>>> --> percpu_ref_switch_to_atomic(&ref)
>>>>       --> percpu_ref_get(ref);	/* put after confirmation */
>>>> 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
>>>>
>>>> 					percpu_ref_switch_to_atomic_rcu
>>>> 					--> percpu_ref_call_confirm_rcu
>>>> 					    --> data->confirm_switch = NULL;
>>>> 						wake_up_all(&percpu_ref_switch_waitq);
>>>>
>>>>       /* here waiting to wake up */
>>>>       wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
>>>> 						(A)percpu_ref_put(ref);
>>>> /* The value of &ref is unstable! */
>>>> percpu_ref_is_zero(&ref)
>>>> 						(B)percpu_ref_put(ref);
>>>>
>>>> As shown above, assuming that the counts on each cpu add up to 0 before
>>>> calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
>>>> to atomic mode, percpu_ref_is_zero() can return true. But actually it will
>>>> return different values in the two cases of A and B, which is not what
>>>> we expected.
>>>>
>>>> Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
>>>> just to ensure that the conversion to atomic mode is completed, but it
>>>> should not return with an extra reference count.
>>>>
>>>> Calling wake_up_all() after percpu_ref_put() ensures that the value of
>>>> percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
>>>> So just do it.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Are any users affected by this?  If so, I think a Fixes tag
>>> is necessary.
>>
>> Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
>> affected by this.
>>
>> I see that this patch has been merged into the mm tree, can Andrew help
>> me add the following Fixes tag?
> 
> Andrew is helpful ;)
> 
> Do you see reasons why we should backport this into -stable trees?
> It's 8 years old, so my uninformed guess is "no"?

Hmm, although the commit 490c79a65708 add wake_up_all(), it is no
problem for the usage at that time, maybe the correct Fixes tag is the
following:

Fixes: 210f7cdcf088 ("percpu-refcount: support synchronous switch to 
atomic mode.")

But in fact, there is no problem with it, but all current users expect
the refcount is stable after percpu_ref_switch_to_atomic_sync() returns.

I have no idea as which Fixes tag to add.

> 

-- 
Thanks,
Qi
