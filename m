Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF64F8DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiDHES7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiDHES5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:18:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2517C2190
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:16:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a42so824060pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ahIvTqLjbXRzNKd9L9AZ6yqiUOeFsB+LyTwpIETN3bw=;
        b=ydNJB3c7gF/8QAKJJITL+Pw+A+Gzh3b8MGAy4GcKtMXy+rimoOfva+sGxfzfS9vCWj
         mNik6sB/prq6r8a+UJ4xypTN6Po558fMa6L7vHtqC4CAgPqCb68elKST/vkCO6JhmyQ2
         5UsLTcF0cjGcxCST4DGimacF0cINev1hdGGeElChQDN3RR9bCoCjqFWhAXpX+Po43xKv
         a6kr1sZ0B70ECX8U14brDt5jRJzIgCewMp6RwNg0YcIp/YsLaITnkwKCiFE6rTCEwpYc
         YhXXxdzG77PQptmFcjK2lcJDpflxgU0FWZsmeo1mEnPyzOufDrWmfwc4F439OQVuNhee
         KObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ahIvTqLjbXRzNKd9L9AZ6yqiUOeFsB+LyTwpIETN3bw=;
        b=artfKhP3smi9bNYNaEo4MqeMfBSzSc/5jrI/1QygDNcoZDDWSqnEmrEsDThBQGHEbo
         NlKktWapH5+5gLg8M/lSQ/W+r+YYoEzR+FlYFAsCqTSE6zcoCyxKSY93BPlhOC7cm8X3
         g0vKLq89Oa7f6Bzkfebb0RyfRSQMd0QZvoSb81KmwM7KPNnL6fvvsacadHTiJ5Jdc8+F
         vO3P6ZmSCEZuw3kjCkeYHXAaFdrCYR7a2f8fSo99XCNY1vA1+Mo4k0f876B9GsbxDjcJ
         wvGPef8/vdt/H3JAw2gUthIa/2h3e1+kmhljyuwJMq/v5bLb58BLis5q/fIa3hjHOdMk
         Inpw==
X-Gm-Message-State: AOAM532IjyO1wU9nhMF/gzEeDF6Iz1mBmOL0CLfKlW3D/bS6hXtHVztk
        Cu/2vXLcdqemaE8Pg+2oXd+OSg==
X-Google-Smtp-Source: ABdhPJw5K0e+ahOciFMUsq3B9hVA92+60mfnczGabrxHa6jm6hQ7AyHeQ0w/K3tWgCi1GpIguHgxNQ==
X-Received: by 2002:a63:af47:0:b0:398:4be1:ce1d with SMTP id s7-20020a63af47000000b003984be1ce1dmr14021742pgo.514.1649391414251;
        Thu, 07 Apr 2022 21:16:54 -0700 (PDT)
Received: from [10.255.182.146] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b0036407db4728sm20072849pga.26.2022.04.07.21.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 21:16:53 -0700 (PDT)
Message-ID: <60c4b8a3-e526-d51e-c880-cd14ce23d718@bytedance.com>
Date:   Fri, 8 Apr 2022 12:16:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
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
 <d546cbce-b1d6-9499-3093-796cad7be9aa@bytedance.com>
In-Reply-To: <d546cbce-b1d6-9499-3093-796cad7be9aa@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/8 12:14 PM, Qi Zheng wrote:
> 
> 
> On 2022/4/8 12:10 PM, Andrew Morton wrote:
>> On Fri, 8 Apr 2022 12:06:20 +0800 Qi Zheng 
>> <zhengqi.arch@bytedance.com> wrote:
>>
>>>
>>>
>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>
>>>>>> Are any users affected by this?  If so, I think a Fixes tag
>>>>>> is necessary.
>>>>>
>>>>> Looks all current users(blk_pre_runtime_suspend() and 
>>>>> set_in_sync()) are
>>>>> affected by this.
>>>>>
>>>>> I see that this patch has been merged into the mm tree, can Andrew 
>>>>> help
>>>>> me add the following Fixes tag?
>>>>
>>>> Andrew is helpful ;)
>>>>
>>>> Do you see reasons why we should backport this into -stable trees?
>>>> It's 8 years old, so my uninformed guess is "no"?
>>>
>>> Hmm, although the commit 490c79a65708 add wake_up_all(), it is no
>>> problem for the usage at that time, maybe the correct Fixes tag is the
>>> following:
>>>
>>> Fixes: 210f7cdcf088 ("percpu-refcount: support synchronous switch to
>>> atomic mode.")
>>>
>>> But in fact, there is no problem with it, but all current users expect
>>> the refcount is stable after percpu_ref_switch_to_atomic_sync() returns.
>>>
>>> I have no idea as which Fixes tag to add.
>>
>> Well the solution to that problem is to add cc:stable and let Greg
>> figure it out ;)
>>
>> The more serious question is "should we backport this".  What is the
>> end-user-visible impact of the bug?  Do our users need the fix or not?
> 
> The impact on the current user is that it is possible to miss an 
> opportunity to reach 0 due to the case B in the commit message:

There may be performance issues, but should not cause serious bugs.

> 
> /* The value of &ref is unstable! */
> percpu_ref_is_zero(&ref)
>                          (B)percpu_ref_put(ref);
> 
> Thanks,
> Qi
> 
>>
> 

-- 
Thanks,
Qi
