Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D344E2CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350528AbiCUPrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350510AbiCUPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F7E5BE7A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647877545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEcCgqphKYDMQ8nkTkwtZzF2MNThCuORpVyyiw+cLk8=;
        b=jBJJHaiXTBBkCx2SXqEvxvY17CUkYBZEE95pxEQhb0QsUo5OXeEAdmkTEr98CzJ1eqCEUp
        +OEh0CnYrjkDk1zA6HLEYmkRQ4GzzFmru/m7hzG3vvCOtTya9cJUHJ7BsU0qrSEG4sQAk6
        fF/CjnK2MwMz9lp5SVD/4rvul0CbYKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-s_RIfoj4O8y-z3tLx7MvuA-1; Mon, 21 Mar 2022 11:45:44 -0400
X-MC-Unique: s_RIfoj4O8y-z3tLx7MvuA-1
Received: by mail-wr1-f69.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so2512530wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=LEcCgqphKYDMQ8nkTkwtZzF2MNThCuORpVyyiw+cLk8=;
        b=nX8DE2X2F1koHZLZh8mL2qH1sMjPcSj+ESXpVOcZ5XDztukJHQhdBSK5gcZAEejqZh
         8OD4yENpL4cUpQy60b+7PaC40PFlimPa8kBGWsP/PUDWRfXX2e0HrZ+/4PySrWEEVOC3
         1ATzSwUCCNX7GcfyigalO9lHennpA9ek3me0Xvh5DXxWRhGKTQ1a20tiygLqR4fiaQEN
         qC4fE0dPnBb3Ck6glIOVDFaLyaeeMjo4jFHS6IMcuo7+81Z6bQRNWMK5jXGvEh/9IxL8
         ffd+TnM6JnQ9XYJBOb4i6a8LHxXGZHcU4StJ6QLMV8V/gV/KW/0pASo149PYUSqlYzxM
         Y+zg==
X-Gm-Message-State: AOAM530X7YWdklTeMXJCvApxciPNo5UaRgteHRSHv+B/JXe0cqsGrPEv
        3G75jcW9fMUgzr9N7ALL7FySX3Tr8OYTLqjZX75oMBfx1u8yqYABxhKaDw0ayTrvjazCiTE9DgS
        ix657X1GhWHmhBhJo9r2NpbP8
X-Received: by 2002:a5d:4b88:0:b0:203:e01b:b5ee with SMTP id b8-20020a5d4b88000000b00203e01bb5eemr18483724wrt.55.1647877542406;
        Mon, 21 Mar 2022 08:45:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMB9TT7JI28MTYZUSUF+RpxNq0Rxuyljwc00j1MkZkn2gwkPuAEpfei4qhtvACTiw1OW/T+g==
X-Received: by 2002:a5d:4b88:0:b0:203:e01b:b5ee with SMTP id b8-20020a5d4b88000000b00203e01bb5eemr18483710wrt.55.1647877542088;
        Mon, 21 Mar 2022 08:45:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b0038c7626c454sm12461150wmq.12.2022.03.21.08.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:45:41 -0700 (PDT)
Message-ID: <0414c610-7f56-2dd2-0d83-ac3a5194eb60@redhat.com>
Date:   Mon, 21 Mar 2022 16:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     CGEL <cgel.zte@gmail.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
 <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
 <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
 <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
 <62330402.1c69fb81.d2ba6.0538@mx.google.com>
 <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
 <6233e342.1c69fb81.692f.6286@mx.google.com>
 <2bb1c357-5335-9d96-d862-bd51c1014193@redhat.com>
 <6236c600.1c69fb81.7cd4.a900@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] delayacct: track delays from ksm cow
In-Reply-To: <6236c600.1c69fb81.7cd4.a900@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.22 07:13, CGEL wrote:
> On Fri, Mar 18, 2022 at 09:24:44AM +0100, David Hildenbrand wrote:
>> On 18.03.22 02:41, CGEL wrote:
>>> On Thu, Mar 17, 2022 at 11:05:22AM +0100, David Hildenbrand wrote:
>>>> On 17.03.22 10:48, CGEL wrote:
>>>>> On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
>>>>>> On 17.03.22 03:03, CGEL wrote:
>>>>>>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
>>>>>>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
>>>>>>>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>>>>>>>
>>>>>>>>> Delay accounting does not track the delay of ksm cow.  When tasks
>>>>>>>>> have many ksm pages, it may spend a amount of time waiting for ksm
>>>>>>>>> cow.
>>>>>>>>>
>>>>>>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
>>>>>>>>> cow happens. This could help users to decide whether to user ksm
>>>>>>>>> or not.
>>>>>>>>>
>>>>>>>>> Also update tools/accounting/getdelays.c:
>>>>>>>>>
>>>>>>>>>     / # ./getdelays -dl -p 231
>>>>>>>>>     print delayacct stats ON
>>>>>>>>>     listen forever
>>>>>>>>>     PID     231
>>>>>>>>>
>>>>>>>>>     CPU             count     real total  virtual total    delay total  delay average
>>>>>>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
>>>>>>>>>     IO              count    delay total  delay average
>>>>>>>>>                         0              0              0ms
>>>>>>>>>     SWAP            count    delay total  delay average
>>>>>>>>>                         0              0              0ms
>>>>>>>>>     RECLAIM         count    delay total  delay average
>>>>>>>>>                         0              0              0ms
>>>>>>>>>     THRASHING       count    delay total  delay average
>>>>>>>>>                         0              0              0ms
>>>>>>>>>     KSM             count    delay total  delay average
>>>>>>>>>                      3635      271567604              0ms
>>>>>>>>>
>>>>>>>>
>>>>>>>> TBH I'm not sure how particularly helpful this is and if we want this.
>>>>>>>>
>>>>>>> Thanks for replying.
>>>>>>>
>>>>>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
>>>>>>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
>>>>>>> get to know how much memory ksm saved by reading
>>>>>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
>>>>>>> ksm cow delay, and this is important of some delay sensitive tasks. If
>>>>>>> users know both saved memory and ksm cow delay, they could better use
>>>>>>> madvise(, , MADV_MERGEABLE).
>>>>>>
>>>>>> But that happens after the effects, no?
>>>>>>
>>>>>> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
>>>>>> results.
>>>>>>
>>>>> Image user are developing or porting their applications on experiment
>>>>> machine, they could takes those benchmark as feedback to adjust whether
>>>>> to use madvise(, , MADV_MERGEABLE) or it's range.
>>>>
>>>> And why can't they run it with and without and observe performance using
>>>> existing metrics (or even application-specific metrics?)?
>>>>
>>>>
>>> I think the reason why we need this patch, is just like why we need                                                                                                     
>>> swap,reclaim,thrashing getdelay information. When system is complex,
>>> it's hard to precise tell which kernel activity impact the observe
>>> performance or application-specific metrics, preempt? cgroup throttle?
>>> swap? reclaim? IO?
>>>
>>> So if we could get the factor's precise impact data, when we are tunning
>>> the factor(for this patch it's ksm), it's more efficient.
>>>
>>
>> I'm not convinced that we want to make or write-fault handler more
>> complicated for such a corner case with an unclear, eventual use case.
> 
> IIRC, KSM is designed for VM. But recently we found KSM works well for
> system with many containers(save about 10%~20% of total memroy), and
> container technology is more popular today, so KSM may be used more.
> 
> To reduce the impact for write-fault handler, we may write a new function
> with ifdef CONFIG_KSM inside to do this job?

Maybe we just want to catch the impact of the write-fault handler when
copying more generally?

> 
>> IIRC, whenever using KSM you're already agreeing to eventually pay a
>> performance price, and the price heavily depends on other factors in the
>> system. Simply looking at the number of write-faults might already give
>> an indication what changed with KSM being enabled.
>>
> While saying "you're already agreeing to pay a performance price", I think
> this is the shortcoming of KSM that putting off it being used more widely.
> It's not easy for user/app to decide how to use madvise(, ,MADV_MERGEABLE).

... and my point is that the metric you're introducing might absolutely
not be expressive for such users playing with MADV_MERGEABLE. IMHO
people will look at actual application performance to figure out what
"harm" will be done, no?

But I do see value in capturing how many COW we have in general --
either via a counter or via a delay as proposed by you.

> 
> Is there a more easy way to use KSM, enjoying memory saving while minimum
> the performance price for container? We think it's possible, and are working
> for a new patch: provide a knob for cgroup to enable/disable KSM for all tasks
> in this cgroup, so if your container is delay sensitive just leave it, and if
> not you can easy to enable KSM without modify app code.
> 
> Before using the new knob, user might want to know the precise impact of KSM.
> I think write-faults is indirection. If indirection is good enough, why we need
> taskstats and PSI? By the way, getdelays support container statistics.

Would anything speak against making this more generic and capturing the
delay for any COW, not just for KSM?

-- 
Thanks,

David / dhildenb

