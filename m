Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022965A741F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiHaCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiHaCvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:51:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC753A3452
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:51:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l3so12907213plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JixsYLLxDTHW57kROhUr8lxsp7YTmvd3To6nn33siQw=;
        b=XmCgBryc+w4vH+i6UODSnDF5GS6BcT9ka/3hu0n16bzN1X7fcHDqoyAOn4XLWqd8Q4
         ALfszGewDmBQgkufblxXRlMAMBCbFwTH/XRC31YVv3Vw2dTlAORRQO+zSfCpTAZPiHak
         DvP4khvLd1VaRuL6gpUgHv4V7HsqCZ46JutvaedVVLQmYFVL/2XcZdzpzO18VyHUbUfV
         LWdi5/QvKvTyEr1tE3+Kpv1tlw6HzbmOVrX+ae0zeSjsuAcqn/E1peQ7f4/VSHN+canM
         2Ic5ucTDGdHOXueXcEGzdek8wY29ZB7MvyGhWqh8t5bKnJ14CjYEw9yYxCxajdQhZhO5
         bKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JixsYLLxDTHW57kROhUr8lxsp7YTmvd3To6nn33siQw=;
        b=2iYOjGJjA2bt3pG1So9J036IYxUPCgSsJmYS9z7y1qe+/JNFFExKAzxzNqpVgOb8d2
         Nfh1SkKR35FbeZ0hnsjIMiZfmThDoeZk5055t0d1zny52QOWK0XWPrFaKF0fY+Wrz3sR
         FFVz81NzK5zDYfERgCJIftep0QHegLc6ZBnko9+OwDwqtP2dF3d5Int5Lnn+Vz24pbGn
         4QDTIZJiwE60flpbWvAWb0FvQJadwcDunH/5Ed9lYx+PPuVIyTPXSCmKDEe97ehwpsnK
         +WfPpE85i9Mrp2yj+jEiASQyjhcQZDSUrB3WmHZ1WMbFgpV4/9SBqMALmGTrYkqAtdxb
         Jocg==
X-Gm-Message-State: ACgBeo0etEmrp60YUbdZMP801jzmC8dUo+uglqmU2lkwsvSkmBuMAd1l
        rDj9myMthtfUkfRe9vytyvb29Q==
X-Google-Smtp-Source: AA6agR6V/Nou2+h6x5/9K7Vf/T4XIWYUFPhzhAjxhBDHV+DFIx54j26i5L4BAHJXilfhbLUobl8IPg==
X-Received: by 2002:a17:902:ea0e:b0:16f:11bf:efe5 with SMTP id s14-20020a170902ea0e00b0016f11bfefe5mr24363051plg.57.1661914313204;
        Tue, 30 Aug 2022 19:51:53 -0700 (PDT)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 142-20020a621594000000b00534bb955b36sm10095236pfv.29.2022.08.30.19.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 19:51:52 -0700 (PDT)
Message-ID: <aa628023-c6ad-8970-ec44-28d560864174@bytedance.com>
Date:   Wed, 31 Aug 2022 10:51:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 1/7] mm: introduce common struct mm_slot
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
 <20220829143055.41201-2-zhengqi.arch@bytedance.com>
 <20220829125134.9b05f9b8caf5da4bec8f31e8@linux-foundation.org>
 <CAHbLzkrP7Ce7iTKQHvZQ-s3NMs1mhzjkNs8XMF_iOtbgJuJDUQ@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAHbLzkrP7Ce7iTKQHvZQ-s3NMs1mhzjkNs8XMF_iOtbgJuJDUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/31 01:03, Yang Shi wrote:
> On Mon, Aug 29, 2022 at 12:51 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 29 Aug 2022 22:30:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>> At present, both THP and KSM module have similar structures
>>> mm_slot for organizing and recording the information required
>>> for scanning mm, and each defines the following exactly the
>>> same operation functions:
>>>
>>>   - alloc_mm_slot
>>>   - free_mm_slot
>>>   - get_mm_slot
>>>   - insert_to_mm_slots_hash
>>>
>>> In order to de-duplicate these codes, this patch introduces a
>>> common struct mm_slot, and subsequent patches will let THP and
>>> KSM to use it.
>>
>> Seems like a good idea.
>>
>>> --- /dev/null
>>> +++ b/mm/mm_slot.h
>>> @@ -0,0 +1,55 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#ifndef _LINUX_MM_SLOT_H
>>> +#define _LINUX_MM_SLOT_H
>>> +
>>> +#include <linux/hashtable.h>
>>> +#include <linux/slab.h>
>>> +
>>> +/*
>>> + * struct mm_slot - hash lookup from mm to mm_slot
>>> + * @hash: link to the mm_slots hash list
>>> + * @mm_node: link into the mm_slots list
>>> + * @mm: the mm that this information is valid for
>>> + */
>>> +struct mm_slot {
>>> +     struct hlist_node hash;
>>> +     struct list_head mm_node;
>>> +     struct mm_struct *mm;
>>> +};
>>
>> It appears that the presence of an mm_struct in the hash list does not
>> contribute to the mm_struct's refcount?  That's somewhat unexpected.
> 
> I didn't find time to look into the series yet, but when the
> mm/mm_slot was added to the list, mmgrab() was definitely called if
> this was not changed by the series.

Yeah, and this series does not change that.

> 
>>
>> It would be helpful to add some words here describing the means by
>> which a user of mm_slot would prevent the mm_struct from getting freed
>> while on the list.  I assume "caller must maintain a reference on the
>> mm_struct while it remains on an mm_slot hash list"?
>>
>>> +#define mm_slot_entry(ptr, type, member) \
>>> +     container_of(ptr, type, member)
>>> +
>>> +static inline void *alloc_mm_slot(struct kmem_cache *cache)
>>> +{
>>> +     if (!cache)     /* initialization failed */
>>> +             return NULL;
>>> +     return kmem_cache_zalloc(cache, GFP_KERNEL);
>>> +}
>>> +
>>> +static inline void free_mm_slot(struct kmem_cache *cache, void *objp)
>>> +{
>>> +     kmem_cache_free(cache, objp);
>>> +}
>>> +
>>> +#define get_mm_slot(_hashtable, _mm)                                        \
>>> +({                                                                          \
>>> +     struct mm_slot *tmp_slot, *mm_slot = NULL;                             \
>>> +                                                                            \
>>> +     hash_for_each_possible(_hashtable, tmp_slot, hash, (unsigned long)_mm) \
>>> +             if (_mm == tmp_slot->mm) {                                     \
>>> +                     mm_slot = tmp_slot;                                    \
>>> +                     break;                                                 \
>>> +             }                                                              \
>>> +                                                                            \
>>> +     mm_slot;                                                               \
>>> +})
>>
>> Is there a reason why this must be implemented as a macro?  That's
>> preferable, although this may be overly large for inlining.  mm/util.c
>> might suit.
>>
>>> +#define insert_to_mm_slots_hash(_hashtable, _mm, _mm_slot)                  \
>>> +({                                                                          \
>>> +     _mm_slot->mm = _mm;                                                    \
>>> +     hash_add(_hashtable, &_mm_slot->hash, (unsigned long)_mm);             \
>>> +})
>>
>> Does this need to be a macro?
>>
>>
>> And the naming.  Can we please have
>>
>> mm_slot_entry
>> mm_slot_alloc
>> mm_slot_free
>> mm_slot_get
>> mm_slot_insert
>>
>> Also, "get" usually implies that a refcout is taken on the obtained
>> object, so mm_slot_lookup() would be more appropriate.
>>

-- 
Thanks,
Qi
