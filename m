Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875ED4FF6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiDMMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiDMMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4CF12C115
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649853068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOgoRxfzCzI5q33umdhDYElMBhuyEs/gGqSfqtPLkH4=;
        b=R9Jzal9tgfmhiU8seLBSB4fCWhXcXXgkfu4ib7bUdpWQei831Qfo23eh9wH7nYPGlkU4tJ
        mrzBnj1oi01EBKHRefxoED0bIbqX1hCvxvjdiAWQWi8B0Ve5AmlJ5LGFQEPpoTN5F1O4xk
        CeoiJSh8I+2Ut9+5aodaRABzwOI1DPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-MliuUzV0OlqnkntPXFeBzQ-1; Wed, 13 Apr 2022 08:31:07 -0400
X-MC-Unique: MliuUzV0OlqnkntPXFeBzQ-1
Received: by mail-wr1-f69.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so326652wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bOgoRxfzCzI5q33umdhDYElMBhuyEs/gGqSfqtPLkH4=;
        b=M/oQG7AJC/WEXMaJAwtEZgNXVzfEP+OKTdfCPjL7e9LZFVSlArQtF74OBcPKjrWWra
         ms07iwiUj28nz7E6L9Gz+qYEIWR4P+MJHc/Gv2CaCzKadanUJS1GOc91dhx9lJb7sJCn
         CoS8D4syQCWcTTz3783+vHg+D+Ay9EgDZhhMoI8GAEKcmCrJ6EUDXPfs2soomeF00XPB
         fxg1R0lp49ZTMaoEFhA6GP25dQHu9Ya1lVbdVkRilNBW5NKWG3R1vKsd16d9/3EmPVzH
         qIopGydo/KFrkLy9FGQrJ57+Brhs5DmZSl/tmUz9tTC/nYXrX7Si3t89IUAWQjH/fluc
         w2yA==
X-Gm-Message-State: AOAM532C8gqp5r2S51XMFLTVLLrCLD2pxvE2eVpeYL489R7nBbkiBJ+o
        09iG5VTVbuWTZZDTZBk5LEs1jgWHH9K6Ud3u+g3aA82pRkxbg3JRaoh9t099dSxJhYuHoBtAaNv
        xvNpVJap/PQq7vLdJms5bE+Ra
X-Received: by 2002:adf:e0c5:0:b0:206:1ba3:26aa with SMTP id m5-20020adfe0c5000000b002061ba326aamr32484213wri.645.1649853066491;
        Wed, 13 Apr 2022 05:31:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/66NqVU7vWO4e1lJW3L4YvkXKeRrNtgBHQuEpQdeZpBwqU+kp1AOvAjnVhG5i/3ySErOLjA==
X-Received: by 2002:adf:e0c5:0:b0:206:1ba3:26aa with SMTP id m5-20020adfe0c5000000b002061ba326aamr32484202wri.645.1649853066236;
        Wed, 13 Apr 2022 05:31:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d64e7000000b00204a13925dcsm34138874wri.11.2022.04.13.05.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:31:05 -0700 (PDT)
Message-ID: <b36bce2e-372b-65fd-8698-fc84d6ed2904@redhat.com>
Date:   Wed, 13 Apr 2022 14:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-2-david@redhat.com>
 <28142e3e-2556-0ca2-7ac5-7420ef862259@huawei.com>
 <374d2be1-e13d-e605-ff80-b9d5eee4c40e@redhat.com>
 <3b9c6cc6-c5f5-8a8d-0b0f-9ca903cfab20@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3b9c6cc6-c5f5-8a8d-0b0f-9ca903cfab20@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 11:38, Miaohe Lin wrote:
> On 2022/4/13 17:30, David Hildenbrand wrote:
>> On 13.04.22 10:58, Miaohe Lin wrote:
>>> On 2022/3/30 0:43, David Hildenbrand wrote:
>>>> Currently, we clear PG_anon_exclusive in try_to_unmap() and forget about
>>> ...
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 14618f446139..9060cc7f2123 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -792,6 +792,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>>  						&src_mm->mmlist);
>>>>  			spin_unlock(&mmlist_lock);
>>>>  		}
>>>> +		/* Mark the swap entry as shared. */
>>>> +		if (pte_swp_exclusive(*src_pte)) {
>>>> +			pte = pte_swp_clear_exclusive(*src_pte);
>>>> +			set_pte_at(src_mm, addr, src_pte, pte);
>>>> +		}
>>>>  		rss[MM_SWAPENTS]++;
>>>>  	} else if (is_migration_entry(entry)) {
>>>>  		page = pfn_swap_entry_to_page(entry);
>>>> @@ -3559,6 +3564,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>  	struct page *page = NULL, *swapcache;
>>>>  	struct swap_info_struct *si = NULL;
>>>>  	rmap_t rmap_flags = RMAP_NONE;
>>>> +	bool exclusive = false;
>>>>  	swp_entry_t entry;
>>>>  	pte_t pte;
>>>>  	int locked;
>>>> @@ -3724,6 +3730,46 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>>>>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
>>>>  
>>>> +	/*
>>>> +	 * Check under PT lock (to protect against concurrent fork() sharing
>>>> +	 * the swap entry concurrently) for certainly exclusive pages.
>>>> +	 */
>>>> +	if (!PageKsm(page)) {
>>>> +		/*
>>>> +		 * Note that pte_swp_exclusive() == false for architectures
>>>> +		 * without __HAVE_ARCH_PTE_SWP_EXCLUSIVE.
>>>> +		 */
>>>> +		exclusive = pte_swp_exclusive(vmf->orig_pte);
>>>> +		if (page != swapcache) {
>>>> +			/*
>>>> +			 * We have a fresh page that is not exposed to the
>>>> +			 * swapcache -> certainly exclusive.
>>>> +			 */
>>>> +			exclusive = true;
>>>> +		} else if (exclusive && PageWriteback(page) &&
>>>> +			   !(swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
>>>
>>> Really sorry for late respond and a newbie question. IIUC, if SWP_STABLE_WRITES is set,
>>> it means concurrent page modifications while under writeback is not supported. For these
>>> problematic swap backends, exclusive marker is dropped. So the above if statement is to
>>> filter out these problematic swap backends which have SWP_STABLE_WRITES set. If so, the
>>> above check should be && (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)), i.e. no "!".
>>> Or am I miss something?
>>
>> Oh, thanks for your careful eyes!
>>
>> Indeed, SWP_STABLE_WRITES indicates that the backend *requires* stable
>> writes, meaning, we must not modify the page while writeback is active.
>>
>> So if and only if that is set, we must drop the exclusive marker.
>>
>> This essentially corresponds to previous reuse_swap_page() logic:
>>
>> bool reuse_swap_page(struct page *page)
>> {
>> ...
>> 	if (!PageWriteback(page)) {
>> 		...
>> 	} else {
>> 		...
>> 		if (p->flags & SWP_STABLE_WRITES) {
>> 			spin_unlock(&p->lock);
>> 			return false;
>> 		}
>> ...
>> }
>>
>> Fortunately, this only affects such backends. For backends without
>> SWP_STABLE_WRITES, the current code is simply sub-optimal.
>>
>>
>> So yes, this has to be
>>
>> } else if (exclusive && PageWriteback(page) &&
>> 	   (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
>>
> 
> I am glad that my question helps. :)
> 
>>
>> Let me try finding a way to test this, the tests I was running so far
>> were apparently not using a backend with SWP_STABLE_WRITES.
>>
> 
> That will be really helpful. Many thanks for your hard work!
> 

FWIW, I tried with zram, which sets SWP_STABLE_WRITES ... but, it seems
to always do a synchronous writeback, so it cannot really trigger this
code path.

commit f05714293a591038304ddae7cb0dd747bb3786cc
Author: Minchan Kim <minchan@kernel.org>
Date:   Tue Jan 10 16:58:15 2017 -0800

    mm: support anonymous stable page


mentions "During developemnt for zram-swap asynchronous writeback,";
maybe that can be activated somehow? Putting Minchan on CC.

-- 
Thanks,

David / dhildenb

