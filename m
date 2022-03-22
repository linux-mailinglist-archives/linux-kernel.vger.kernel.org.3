Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76AD4E39F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiCVH44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCVH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05B325A588
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647935721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJc58o01x4xi25HDj10JnBcdFVegGKt6zvmfuuygfHw=;
        b=D67EI+RxjaAQTDLXmu3WKISxda631SY7I8vox060KniR+z+NoHgagFXUl4e7lD7wGw+r+i
        3NwghwoPDk/SMYRtwk4IJj31BuAU7VKnRNSc+cvM17DVg4bl77nmcePLGFhuPBj4DxTszr
        Bu0FjEMvNnq054H/wVDEAgZ9E7MjhWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-xoacb8KuNJGll3OGkJbPBw-1; Tue, 22 Mar 2022 03:55:19 -0400
X-MC-Unique: xoacb8KuNJGll3OGkJbPBw-1
Received: by mail-wr1-f69.google.com with SMTP id p16-20020adfc390000000b00204006989c2so1420361wrf.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=BJc58o01x4xi25HDj10JnBcdFVegGKt6zvmfuuygfHw=;
        b=4DpLthHd+KpdB5+nbLz0ypIGlP6VlQWOYzWVpaziVwMdhj6mKYn5N7tJ3/c3C3Cw5X
         xN3q8Sv6Az4azoGF0wsjJakrdmVN12etb1k4V2AN5CYKTgVs8ePcOH2nlGu54IXztWoe
         BLhqX+nXW/H0ctO+2mWiQaUv3oTEhDQq2Sif85Vwi6L5bm2rQagCjB1a6rIuqR/+3XFO
         hfoRNfR71psFNZeZcmGJ5OdFI26chbEXQep2nPJFHw198rJN5koJoPcMcAr65zQdqUb1
         9HIkgtQFbf5XM9uk3kqBU8oSB8bCWG/x7POLj87qz9AyzHprq6HBuF5ejclEQqanMX9h
         uZhw==
X-Gm-Message-State: AOAM531b1X4oAeBp9PzqtVS/WygjO9TVqNPgBPGk/LfsWmSiFPb97g/U
        ZK9c4CAksnRZO8NnZRixbV+lYVsCCvOEgQpOxqZktjOFC9YCEWhXPFJ/1bFOCENg1fQfX5PNVRW
        2a2JUlclfroG7d4lBBACMS5D/
X-Received: by 2002:a05:600c:3d12:b0:38c:a561:f622 with SMTP id bh18-20020a05600c3d1200b0038ca561f622mr2482082wmb.139.1647935717915;
        Tue, 22 Mar 2022 00:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwte+M8exmMlZKydOJ27q3uEeckqtuo0Lnx4b7RV8jlFmFnE6yWNzJTZtfnTorfiXQkViJMcg==
X-Received: by 2002:a05:600c:3d12:b0:38c:a561:f622 with SMTP id bh18-20020a05600c3d1200b0038ca561f622mr2482054wmb.139.1647935717459;
        Tue, 22 Mar 2022 00:55:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:de00:549e:e4e4:98df:ff72? (p200300cbc708de00549ee4e498dfff72.dip0.t-ipconnect.de. [2003:cb:c708:de00:549e:e4e4:98df:ff72])
        by smtp.gmail.com with ESMTPSA id n14-20020a7bcbce000000b0038c7776a300sm1698090wmi.0.2022.03.22.00.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 00:55:17 -0700 (PDT)
Message-ID: <e63e62fc-1f94-0750-1503-181c7a35e226@redhat.com>
Date:   Tue, 22 Mar 2022 08:55:15 +0100
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
 <0414c610-7f56-2dd2-0d83-ac3a5194eb60@redhat.com>
 <62393e86.1c69fb81.bb254.3d1a@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] delayacct: track delays from ksm cow
In-Reply-To: <62393e86.1c69fb81.bb254.3d1a@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.22 04:12, CGEL wrote:
> On Mon, Mar 21, 2022 at 04:45:40PM +0100, David Hildenbrand wrote:
>> On 20.03.22 07:13, CGEL wrote:
>>> On Fri, Mar 18, 2022 at 09:24:44AM +0100, David Hildenbrand wrote:
>>>> On 18.03.22 02:41, CGEL wrote:
>>>>> On Thu, Mar 17, 2022 at 11:05:22AM +0100, David Hildenbrand wrote:
>>>>>> On 17.03.22 10:48, CGEL wrote:
>>>>>>> On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
>>>>>>>> On 17.03.22 03:03, CGEL wrote:
>>>>>>>>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
>>>>>>>>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
>>>>>>>>>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>>>>>>>>>
>>>>>>>>>>> Delay accounting does not track the delay of ksm cow.  When tasks
>>>>>>>>>>> have many ksm pages, it may spend a amount of time waiting for ksm
>>>>>>>>>>> cow.
>>>>>>>>>>>
>>>>>>>>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
>>>>>>>>>>> cow happens. This could help users to decide whether to user ksm
>>>>>>>>>>> or not.
>>>>>>>>>>>
>>>>>>>>>>> Also update tools/accounting/getdelays.c:
>>>>>>>>>>>
>>>>>>>>>>>     / # ./getdelays -dl -p 231
>>>>>>>>>>>     print delayacct stats ON
>>>>>>>>>>>     listen forever
>>>>>>>>>>>     PID     231
>>>>>>>>>>>
>>>>>>>>>>>     CPU             count     real total  virtual total    delay total  delay average
>>>>>>>>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
>>>>>>>>>>>     IO              count    delay total  delay average
>>>>>>>>>>>                         0              0              0ms
>>>>>>>>>>>     SWAP            count    delay total  delay average
>>>>>>>>>>>                         0              0              0ms
>>>>>>>>>>>     RECLAIM         count    delay total  delay average
>>>>>>>>>>>                         0              0              0ms
>>>>>>>>>>>     THRASHING       count    delay total  delay average
>>>>>>>>>>>                         0              0              0ms
>>>>>>>>>>>     KSM             count    delay total  delay average
>>>>>>>>>>>                      3635      271567604              0ms
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> TBH I'm not sure how particularly helpful this is and if we want this.
>>>>>>>>>>
>>>>>>>>> Thanks for replying.
>>>>>>>>>
>>>>>>>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
>>>>>>>>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
>>>>>>>>> get to know how much memory ksm saved by reading
>>>>>>>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
>>>>>>>>> ksm cow delay, and this is important of some delay sensitive tasks. If
>>>>>>>>> users know both saved memory and ksm cow delay, they could better use
>>>>>>>>> madvise(, , MADV_MERGEABLE).
>>>>>>>>
>>>>>>>> But that happens after the effects, no?
>>>>>>>>
>>>>>>>> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
>>>>>>>> results.
>>>>>>>>
>>>>>>> Image user are developing or porting their applications on experiment
>>>>>>> machine, they could takes those benchmark as feedback to adjust whether
>>>>>>> to use madvise(, , MADV_MERGEABLE) or it's range.
>>>>>>
>>>>>> And why can't they run it with and without and observe performance using
>>>>>> existing metrics (or even application-specific metrics?)?
>>>>>>
>>>>>>
>>>>> I think the reason why we need this patch, is just like why we need                                                                                                     
>>>>> swap,reclaim,thrashing getdelay information. When system is complex,
>>>>> it's hard to precise tell which kernel activity impact the observe
>>>>> performance or application-specific metrics, preempt? cgroup throttle?
>>>>> swap? reclaim? IO?
>>>>>
>>>>> So if we could get the factor's precise impact data, when we are tunning
>>>>> the factor(for this patch it's ksm), it's more efficient.
>>>>>
>>>>
>>>> I'm not convinced that we want to make or write-fault handler more
>>>> complicated for such a corner case with an unclear, eventual use case.
>>>
>>> IIRC, KSM is designed for VM. But recently we found KSM works well for
>>> system with many containers(save about 10%~20% of total memroy), and
>>> container technology is more popular today, so KSM may be used more.
>>>
>>> To reduce the impact for write-fault handler, we may write a new function
>>> with ifdef CONFIG_KSM inside to do this job?
>>
>> Maybe we just want to catch the impact of the write-fault handler when
>> copying more generally?
>>
> We know kernel has different kind of COW, some are transparent for user.
> For example child process may cause COW, and user should not care this
> performance impact, because it's kernel inside mechanism, user is hard
> to do something. But KSM is different, user can do the policy tuning in
> userspace. If we metric all the COW, it may be noise, doesn't it?

Only to some degree I think. The other delays (e.g., SWAP, RECLAIM) are
also not completely transparent to the user, no? I mean, user space
might affect them to some degree with some tunables, but it's not
completely transparent for the user either.

IIRC, we have these sources of COW that result in a r/w anon page (->
MAP_PRIVATE):
(1) R/O-mapped, (possibly) shared anonymous page (fork() or KSM)
(2) R/O-mapped, shared zeropage (e.g., KSM, read-only access to
    unpopulated page in MAP_ANON)
(3) R/O-mapped, shared file/device/... page that requires a private copy
    on modifications (e.g., MAP_PRIVATE !MAP_ANON)

Note that your current patch won't catch when KSM placed the shared
zeropage (use_zero_page).

Tracking the overall overhead might be of value I think, and it would
still allow for determining how much KSM is involved by measuring with
and without KSM enabled.

>>>
>>>> IIRC, whenever using KSM you're already agreeing to eventually pay a
>>>> performance price, and the price heavily depends on other factors in the
>>>> system. Simply looking at the number of write-faults might already give
>>>> an indication what changed with KSM being enabled.
>>>>
>>> While saying "you're already agreeing to pay a performance price", I think
>>> this is the shortcoming of KSM that putting off it being used more widely.
>>> It's not easy for user/app to decide how to use madvise(, ,MADV_MERGEABLE).
>>
>> ... and my point is that the metric you're introducing might absolutely
>> not be expressive for such users playing with MADV_MERGEABLE. IMHO
>> people will look at actual application performance to figure out what
>> "harm" will be done, no?
>>
>> But I do see value in capturing how many COW we have in general --
>> either via a counter or via a delay as proposed by you.
>>
> Thanks for your affirmative. As describe above, or we add a vm counter:
> KSM_COW? 

As I'm messing with the COW logic lately (e.g., [1]) I'd welcome vm
counters for all different kind of COW-related events, especially

(1) COW of an anon, !KSM page
(2) COW of a KSM page
(3) COW of the shared zeropage
(4) Reuse instead of COW

I used some VM counters myself to debug/test some of my latest changes.

>>>
>>> Is there a more easy way to use KSM, enjoying memory saving while minimum
>>> the performance price for container? We think it's possible, and are working
>>> for a new patch: provide a knob for cgroup to enable/disable KSM for all tasks
>>> in this cgroup, so if your container is delay sensitive just leave it, and if
>>> not you can easy to enable KSM without modify app code.
>>>
>>> Before using the new knob, user might want to know the precise impact of KSM.
>>> I think write-faults is indirection. If indirection is good enough, why we need
>>> taskstats and PSI? By the way, getdelays support container statistics.
>>
>> Would anything speak against making this more generic and capturing the
>> delay for any COW, not just for KSM?
> I think we'd better to export data to userspace that is meaning for user.
> User may no need kernel inside mechanism'data.

Reading Documentation/accounting/delay-accounting.rst I wonder what we
best put in there.

"Tasks encounter delays in execution when they wait for some kernel
resource to become available."

I mean, in any COW event we are waiting for the kernel to create a copy.


This could be of value even if we add separate VM counters.



[1]
https://lore.kernel.org/linux-mm/20220315104741.63071-2-david@redhat.com/T/

-- 
Thanks,

David / dhildenb

