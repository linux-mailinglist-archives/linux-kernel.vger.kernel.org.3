Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321DB59E439
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiHWNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiHWNX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC23C8D3C3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661250211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Kxt05L7z1d52ImlEEC1KlrDepPenx6fSSchHejx0uM=;
        b=b/+Kuq80ojUrqIdwryjmFfw1fETOXBiOLqxe7+7k9O8jpWf73Qo2tXljVzI6eHMkbsC5cs
        0k2sLbAZ0imGhVl8WeNZtRAaagqImCHjRgsTDHwD1mFAEYoyCSQlpzkmr8Ch64kjfB1WHH
        y8qv2uWnxJH62QLHw5Ej2bLmoARHH3c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-ZBl-HP_aP6S_NA5VTpePtQ-1; Tue, 23 Aug 2022 06:23:30 -0400
X-MC-Unique: ZBl-HP_aP6S_NA5VTpePtQ-1
Received: by mail-wm1-f70.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so7736546wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=1Kxt05L7z1d52ImlEEC1KlrDepPenx6fSSchHejx0uM=;
        b=L+P4EbmMh8x601xzPj8gJaDzYNUDw3TqN4L4879XYs3w+XMNMLvNtEv/ty6ALRS8UJ
         cXQ3mCY+DDVbXqqAr+TQ2NwysmFkGKn5s57sn8QdmfLYAxpKeGf8GqinpaMjr8SBYGI+
         24SmMRU8yoJ3uccVXeqCv52FpCffWxOzg91uXFrc020CIAr00/Y6AODY1oe2ara8utuo
         OIwiAa04zWLhilBZwQsyZWAEQIu4oiYwnhs632g6Tja0cMG21O2J/XorRRfGNIgWu1to
         MQbuQg+K5ByNARoghpo2j4iUVoSux35EMsnAp/RFxVEmlEcbqFMZ/Yh31y3Ybp4tHZyq
         b1+g==
X-Gm-Message-State: ACgBeo2yIGK/QPc+eOxZtCkZxOWPf2EDtDbhNI5x3mtRPoet1k0zmDiz
        dGD35LEP5TOCur5DEEwodNrznQThtzNXQgDVmZGW26fpCHMJME5uKHNfXQvQv1PzgdajccVo7Lx
        h5P2NjZ4am+SOUwyUo0XDN8wy
X-Received: by 2002:adf:a30d:0:b0:225:2656:235d with SMTP id c13-20020adfa30d000000b002252656235dmr13914323wrb.716.1661250209397;
        Tue, 23 Aug 2022 03:23:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ENOYRDpGYMJbVEqOdw1Ty7+mKWBtH4vVkatfoFbGnxmW3tLacNmkRMzq7t1cgGU6El8m0Og==
X-Received: by 2002:adf:a30d:0:b0:225:2656:235d with SMTP id c13-20020adfa30d000000b002252656235dmr13914311wrb.716.1661250209077;
        Tue, 23 Aug 2022 03:23:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003a500b612fcsm20693564wmi.12.2022.08.23.03.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:23:28 -0700 (PDT)
Message-ID: <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
Date:   Tue, 23 Aug 2022 12:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.22 12:02, Baolin Wang wrote:
> 
> 
> On 8/23/2022 4:29 PM, David Hildenbrand wrote:
>> On 23.08.22 09:50, Baolin Wang wrote:
>>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>>> hugetlb, which means it can support not only PMD/PUD size hugetlb
>>> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
>>> specified.
>>>
>>> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
>>> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
>>> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
>>> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
>>> get the correct lock, which is mm->page_table_lock.
>>>
>>> That means the pte entry of the CONT-PTE size hugetlb under current
>>> pte lock is unstable in follow_page_pte(), we can continue to migrate
>>> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
>>> some potential race issues, and following pte_xxx() validation is also
>>> unstable in follow_page_pte(), even though they are under the 'pte lock'.
>>>
>>> Moreover we should use huge_ptep_get() to get the pte entry value of
>>> the CONT-PTE size hugetlb, which already takes into account the subpages'
>>> dirty or young bits in case we missed the dirty or young state of the
>>> CONT-PTE size hugetlb.
>>>
>>> To fix above issues, introducing a new helper follow_huge_pte() to look
>>> up a CONT-PTE size hugetlb page, which uses huge_pte_lock() to get the
>>> correct pte entry lock to make the pte entry stable, as well as
>>> supporting non-present pte handling.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   include/linux/hugetlb.h |  8 ++++++++
>>>   mm/gup.c                | 11 ++++++++++
>>>   mm/hugetlb.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 72 insertions(+)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 3ec981a..d491138 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -207,6 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
>>>   struct page *follow_huge_pd(struct vm_area_struct *vma,
>>>   			    unsigned long address, hugepd_t hpd,
>>>   			    int flags, int pdshift);
>>> +struct page *follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
>>> +			     pmd_t *pmd, int flags);
>>>   struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>>   				pmd_t *pmd, int flags);
>>>   struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
>>> @@ -312,6 +314,12 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
>>>   	return NULL;
>>>   }
>>>   
>>> +static inline struct page *follow_huge_pte(struct vm_area_struct *vma,
>>> +				unsigned long address, pmd_t *pmd, int flags)
>>> +{
>>> +	return NULL;
>>> +}
>>> +
>>>   static inline struct page *follow_huge_pmd(struct mm_struct *mm,
>>>   				unsigned long address, pmd_t *pmd, int flags)
>>>   {
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 3b656b7..87a94f5 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -534,6 +534,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>>   	if (unlikely(pmd_bad(*pmd)))
>>>   		return no_page_table(vma, flags);
>>>   
>>> +	/*
>>> +	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
>>> +	 * ARM64 architecture.
>>> +	 */
>>> +	if (is_vm_hugetlb_page(vma)) {
>>> +		page = follow_huge_pte(vma, address, pmd, flags);
>>> +		if (page)
>>> +			return page;
>>> +		return no_page_table(vma, flags);
>>> +	}
>>> +
>>>   	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
>>>   	pte = *ptep;
>>>   	if (!pte_present(pte)) {
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 6c00ba1..cf742d1 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -6981,6 +6981,59 @@ struct page * __weak
>>>   	return NULL;
>>>   }
>>>   
>>> +/* Support looking up a CONT-PTE size hugetlb page. */
>>> +struct page * __weak
>>> +follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
>>> +		pmd_t *pmd, int flags)
>>> +{
>>> +	struct mm_struct *mm = vma->vm_mm;
>>> +	struct hstate *hstate = hstate_vma(vma);
>>> +	unsigned long size = huge_page_size(hstate);
>>> +	struct page *page = NULL;
>>> +	spinlock_t *ptl;
>>> +	pte_t *ptep, pte;
>>> +
>>> +	/*
>>> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
>>> +	 * follow_hugetlb_page().
>>> +	 */
>>> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
>>> +		return NULL;
>>> +
>>> +	ptep = huge_pte_offset(mm, address, size);
>>> +	if (!ptep)
>>> +		return NULL;
>>> +
>>> +retry:
>>> +	ptl = huge_pte_lock(hstate, mm, ptep);
>>> +	pte = huge_ptep_get(ptep);
>>> +	if (pte_present(pte)) {
>>> +		page = pte_page(pte);
>>> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
>>> +			page = NULL;
>>> +			goto out;
>>> +		}
>>> +	} else {
>>> +		if (!(flags & FOLL_MIGRATION)) {
>>> +			page = NULL;
>>> +			goto out;
>>> +		}
>>> +
>>> +		if (is_hugetlb_entry_migration(pte)) {
>>> +			spin_unlock(ptl);
>>> +			__migration_entry_wait_huge(ptep, ptl);
>>> +			goto retry;
>>> +		}
>>> +		/*
>>> +		 * hwpoisoned entry is treated as no_page_table in
>>> +		 * follow_page_mask().
>>> +		 */
>>> +	}
>>> +out:
>>> +	spin_unlock(ptl);
>>> +	return page;
>>> +}
>>> +
>>>   struct page * __weak
>>>   follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>>   		pmd_t *pmd, int flags)
>>
>>
>> Can someone explain why:
>> * follow_page() goes via follow_page_mask() for hugetlb
>> * __get_user_pages() goes via follow_hugetlb_page() and never via
>>    follow_page_mask() for hugetlb?
>>
>> IOW, why can't we make follow_page_mask() just not handle hugetlb and
>> route everything via follow_hugetlb_page() -- we primarily only have to
>> teach it to not trigger faults.
> 
> IMHO, these follow_huge_xxx() functions are arch-specified at first and 
> were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm: 
> hugetlb: Copy general hugetlb code from x86 to mm"), and now there are 
> still some arch-specified follow_huge_xxx() definition, for example:
> ia64: follow_huge_addr
> powerpc: follow_huge_pd
> s390: follow_huge_pud
> 
> What I mean is that follow_hugetlb_page() is a common and 
> not-arch-specified function, is it suitable to change it to be 
> arch-specified?
> And thinking more, can we rename follow_hugetlb_page() as 
> hugetlb_page_faultin() and simplify it to only handle the page faults of 
> hugetlb like the faultin_page() for normal page? That means we can make 
> sure only follow_page_mask() can handle hugetlb.
> 

If follow_hugetlb_page() can be arch-independent, why do we need the
other arch-dependent functions?

It all looks a bit weird to have two functions that walk page tables and
are hugetlb aware.

Either this screams for a cleanup or I am missing something fundamental.

-- 
Thanks,

David / dhildenb

