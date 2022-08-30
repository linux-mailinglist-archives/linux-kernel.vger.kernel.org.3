Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DCF5A5A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiH3D5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH3D5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:57:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E5AA371
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:57:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u22so9885283plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gkm9ZF11qnsrXUp6mwF300lhXi7QKePgAYd+Mxulk6k=;
        b=2Fd+CNOvbQZUVJI5uw9mDQDrU0f0myoKMYM9K6WPSupS2wBXw1tQYLhPYNXAcscIjJ
         insioEzVOSwIGGtiPdbICGXI3AO+2pyAGrN5X3nNtcjHe/OcAlKey87XfUILA35nD2Sx
         doF4rhCYcsTzLGI7PXdLK3hOdLEw1AvJmaq9FRWU1mkZRqpzod5dq+BK+oT+yEMBVYRz
         X3VA4qvKkuiE7+QXQtKbMx0inlmzWFlXe6TNQpX3tuoCCnx82TbMk7rI87BpAGOUzdEw
         YkriaqTq8SnfII9CPAlLHlYK9CCTrnrur5HKyCGBumLPD2dke99sAkZd5E18x8vXlA4S
         hXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gkm9ZF11qnsrXUp6mwF300lhXi7QKePgAYd+Mxulk6k=;
        b=JUfWE2EiJ3/ZwJmGU7ar0E6BE8rwWAksDGXO8u6QkEOkB9bCDVC5p9lOUHNGDsEs18
         9fTj6S7DqvJXA8bEHMh31SNhCIpIDxvtwgc4TSG9pIctYzHkpsVEDmvIUyBFoh4agpVn
         ke+cmiajK3v1ZAzxPFSZNkIsGdl2ZruZU7XBWt00TpFhwTALIIIjSxfUdMN6Uvx5+anW
         Hn7yeGMEYgc0gNq9AiyveTOpRqBcHvNpsC33oXXXaLskarAPhJDrERQCrLLY2UW7jadU
         FNIOBe8wQTuiX3EuwlhTulfJVUuG5jSlEQ2ZnLW/La3J+T+qiJa6rhZhl1ysTwwfQ+Gz
         haRQ==
X-Gm-Message-State: ACgBeo16+XjzfMx/5YUOhm8uc2IdfkzM57RbHEnVvNUhCT5xkmodDLG3
        5s5FZqquNlnah1YEpdaSG0hjMQ==
X-Google-Smtp-Source: AA6agR5184wQdD03/aZ2LVPrLnbPfcwT3Ga+pxSmo5FI+ZocRGP6fwtukImQ3Q46lKVrLcXny2tFbw==
X-Received: by 2002:a17:902:9a44:b0:171:3541:2c75 with SMTP id x4-20020a1709029a4400b0017135412c75mr18957412plv.15.1661831854700;
        Mon, 29 Aug 2022 20:57:34 -0700 (PDT)
Received: from [10.4.115.67] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79732000000b00539aa7f0b53sm418163pfg.104.2022.08.29.20.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 20:57:34 -0700 (PDT)
Message-ID: <0752da43-0e5c-54c9-4c82-bb966ff93b43@bytedance.com>
Date:   Tue, 30 Aug 2022 11:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 1/7] mm: introduce common struct mm_slot
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
 <20220829143055.41201-2-zhengqi.arch@bytedance.com>
 <20220829125134.9b05f9b8caf5da4bec8f31e8@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220829125134.9b05f9b8caf5da4bec8f31e8@linux-foundation.org>
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



On 2022/8/30 03:51, Andrew Morton wrote:
> On Mon, 29 Aug 2022 22:30:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> At present, both THP and KSM module have similar structures
>> mm_slot for organizing and recording the information required
>> for scanning mm, and each defines the following exactly the
>> same operation functions:
>>
>>   - alloc_mm_slot
>>   - free_mm_slot
>>   - get_mm_slot
>>   - insert_to_mm_slots_hash
>>
>> In order to de-duplicate these codes, this patch introduces a
>> common struct mm_slot, and subsequent patches will let THP and
>> KSM to use it.
> 
> Seems like a good idea.
> 
>> --- /dev/null
>> +++ b/mm/mm_slot.h
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#ifndef _LINUX_MM_SLOT_H
>> +#define _LINUX_MM_SLOT_H
>> +
>> +#include <linux/hashtable.h>
>> +#include <linux/slab.h>
>> +
>> +/*
>> + * struct mm_slot - hash lookup from mm to mm_slot
>> + * @hash: link to the mm_slots hash list
>> + * @mm_node: link into the mm_slots list
>> + * @mm: the mm that this information is valid for
>> + */
>> +struct mm_slot {
>> +	struct hlist_node hash;
>> +	struct list_head mm_node;
>> +	struct mm_struct *mm;
>> +};
> 
> It appears that the presence of an mm_struct in the hash list does not
> contribute to the mm_struct's refcount?  That's somewhat unexpected.

Hi,

The reason is that khugepaged_exit()/ksm_exit() will be called first in
__mmput() to remove mm from the linked list. So it is prevented the
mm_struct from getting freed while on the list.

> 
> It would be helpful to add some words here describing the means by
> which a user of mm_slot would prevent the mm_struct from getting freed
> while on the list.  I assume "caller must maintain a reference on the
> mm_struct while it remains on an mm_slot hash list"?
> 
>> +#define mm_slot_entry(ptr, type, member) \
>> +	container_of(ptr, type, member)
>> +
>> +static inline void *alloc_mm_slot(struct kmem_cache *cache)
>> +{
>> +	if (!cache)	/* initialization failed */
>> +		return NULL;
>> +	return kmem_cache_zalloc(cache, GFP_KERNEL);
>> +}
>> +
>> +static inline void free_mm_slot(struct kmem_cache *cache, void *objp)
>> +{
>> +	kmem_cache_free(cache, objp);
>> +}
>> +
>> +#define get_mm_slot(_hashtable, _mm)					       \
>> +({									       \
>> +	struct mm_slot *tmp_slot, *mm_slot = NULL;			       \
>> +									       \
>> +	hash_for_each_possible(_hashtable, tmp_slot, hash, (unsigned long)_mm) \
>> +		if (_mm == tmp_slot->mm) {				       \
>> +			mm_slot = tmp_slot;				       \
>> +			break;						       \
>> +		}							       \
>> +									       \
>> +	mm_slot;							       \
>> +})
> 
> Is there a reason why this must be implemented as a macro?  That's

Since _hashtable is an array name, IIUC, this cannot be passed as a
function parameter, so I chose to implement it as a macro.

> preferable, although this may be overly large for inlining.  mm/util.c
> might suit.
> 
>> +#define insert_to_mm_slots_hash(_hashtable, _mm, _mm_slot)		       \
>> +({									       \
>> +	_mm_slot->mm = _mm;						       \
>> +	hash_add(_hashtable, &_mm_slot->hash, (unsigned long)_mm);	       \
>> +})
> 
> Does this need to be a macro?

Ditto.

> 
> 
> And the naming.  Can we please have
> 
> mm_slot_entry
> mm_slot_alloc
> mm_slot_free
> mm_slot_get
> mm_slot_insert
> 
> Also, "get" usually implies that a refcout is taken on the obtained
> object, so mm_slot_lookup() would be more appropriate.

These names are better, will modify to it in the next version.

Thanks,
Qi

-- 
Thanks,
Qi
