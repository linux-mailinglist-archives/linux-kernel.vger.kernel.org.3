Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA524FF50F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiDMKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiDMKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C1444CD6B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649846767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMrQzeHJx65ULsPidB1Cy7egdCXwBqVKyaotDwys9D8=;
        b=JwMtCvUH8mQ0bCf+4oT39jebtcN60PX83I9uBLnCfu+AMpo86Azl4ZZiUxhTxmmwiDVDGX
        QtGyCs+iVoEuY9U+dDW977JRpyDelgoU/cBen/RLPd17hXGrLbs+/il/+d//uNFCoZ5yHN
        +oliUwzImcl5Gr6wGHXhf6i1Q0B8xRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-I1B33PXBMC2-3UfTqW76_Q-1; Wed, 13 Apr 2022 06:46:05 -0400
X-MC-Unique: I1B33PXBMC2-3UfTqW76_Q-1
Received: by mail-wm1-f69.google.com with SMTP id o35-20020a05600c512300b0038e83a52c71so729497wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rMrQzeHJx65ULsPidB1Cy7egdCXwBqVKyaotDwys9D8=;
        b=pjXf7rspPnoUfxnbiBdWkefAZwotRQiLRzQQa1DK6bJqUeJZrcXhLjpBxnAg/2VTDc
         baGhRhAteykVY7QlHOmOMMpRYycZwPIuhq2Gb5YPED7IOLbz9cFGmFQsk+ishuu0rlJt
         mR4wFfIWQIGjxG391a3DwMRjEPiGx+6Rpwaa5PwFgDy9h2/zf0y0WS3JKXDZpfQOEPgM
         APCGFZ14PVGhsbEE2bNiuixicMDuA4U6GQpPH9X6uRkdOLNN8qJkgYF0nF3RACXDGgna
         JQSj28wpcnAbCTG6ZZLJx3xAhOgznUDBM7xYz4YmsVr9LNitbW7KGUQBCGgOs6uQaF4e
         vSPA==
X-Gm-Message-State: AOAM533/Ve1196UzU4Es1d0SXA1mqAk7txFR3iu6jOk5HLYrb2HElk11
        fw9cZpFgZD0GphsigktjiED8PuYgNo6kUrU8AZKnk23WYCrMdGR3bxmGx45N7vYHMA4DYKlYVg4
        0QQR+EgzoRCfb3jvCSVVYaLX7
X-Received: by 2002:a5d:64e3:0:b0:204:1a79:f1b9 with SMTP id g3-20020a5d64e3000000b002041a79f1b9mr31493935wri.330.1649846764476;
        Wed, 13 Apr 2022 03:46:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEgLTvJmgrjkbK02uLgII+/AmFmuSpAgxgKBasTqf2hkbHQN6DeKq8Ko3tGGIQPNDjLXqeBg==
X-Received: by 2002:a5d:64e3:0:b0:204:1a79:f1b9 with SMTP id g3-20020a5d64e3000000b002041a79f1b9mr31493915wri.330.1649846764163;
        Wed, 13 Apr 2022 03:46:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id t4-20020adfe104000000b00205b50f04f0sm30804760wrz.86.2022.04.13.03.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:46:03 -0700 (PDT)
Message-ID: <ac725bcb-313a-4fff-250a-68ba9a8f85fb@redhat.com>
Date:   Wed, 13 Apr 2022 12:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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

This is the kind of review I was hoping for :)


@Andrew, the following change is necessary:

diff --git a/mm/memory.c b/mm/memory.c
index 3ad39bd66203..8b3cb73f5e44 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3747,7 +3747,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
                         */
                        exclusive = true;
                } else if (exclusive && PageWriteback(page) &&
-                          !(swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
+                          (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
                        /*
                         * This is tricky: not all swap backends support
                         * concurrent page modifications while under writeback.


Do you:

a) Want to squash it
b) Want me to resend a new version of this patch only
c) Want me to resend a new version of the patch set

In the meantime, I'll try testing with a suitable backend. IIRC, zram should do the trick.

-- 
Thanks,

David / dhildenb

