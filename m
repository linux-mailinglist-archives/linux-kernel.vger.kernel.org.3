Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C507B4E61E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349531AbiCXKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiCXKqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1D17DFFF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648118704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQ7KlexPypooA6FYJm9ptq0BegCdasbya4hs+9/TZnw=;
        b=jRr0YCs2r0I6RjTU+Xk7x3CeoYXTWAsa5+kDOj7OdeyL0+BhLpJNFgakn1vm8U8IxiVqk1
        Dr+pkYfaTQDN8BjYie+5Bcv+rGCpmjj/yznawD2AzUfEhvXZIba7kHhVtFMbgKcWMs74kB
        oSvFcANrLfstT2mhl8pp/75S7LCSRfs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-XyeB7NqOPaeuvYKN3U1qZQ-1; Thu, 24 Mar 2022 05:02:08 -0400
X-MC-Unique: XyeB7NqOPaeuvYKN3U1qZQ-1
Received: by mail-wr1-f72.google.com with SMTP id e10-20020adf9bca000000b002059b6ffa18so101752wrc.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qQ7KlexPypooA6FYJm9ptq0BegCdasbya4hs+9/TZnw=;
        b=6b+iHdMIoJ0ngMlTsfoDNbFoIK7QTDPUGp5xa0rTJhnraG8VTLkfNGjSk1FNaa/4N1
         eas3xreu/Gl/VMtKDSAFg0oC4QWDcHSgO5K4QFhrii6/sad0W3p+y1TaRinLc+V7TXP0
         LSyt+p5dOM3GxFyJrm2lboXVEvixS/vdJ5meBeOR0RT3kDKDa+mUuifcSnySGjXor54S
         GDYWGd96yfWt4wtdQiyzZYd6/Q1JVfQbJpHKIrR4m2QH2m8k6I3XSAYZpeCRCrxYMeXK
         tjqCxPkSpkAT96kQl3GwAG9nPKKbPgH3zPc36rInOPlbyo/B3pdRbqeby4+gNBSRLddo
         lp5Q==
X-Gm-Message-State: AOAM533RL+ocFoic2YLgUHVQ89kVO5Xn5CK5PzASR8pjYzWG32ipSX5P
        +WWOBPIHCgZi7VN9EKg0pqMnPezCDCQxSCbrxTdOI03xOzaTlEZj1BvMlE4XLd8JPYlOIuMaxEW
        mNbG18rFoAKNStLnGhlRfkBaR
X-Received: by 2002:a5d:4688:0:b0:203:f0cc:da10 with SMTP id u8-20020a5d4688000000b00203f0ccda10mr3691951wrq.87.1648112096054;
        Thu, 24 Mar 2022 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfRD51IlIU/a0GHZ9SIvipCRxOPeVi0YzksbN1K4luw5OyNTpyxlPpbv0I1KWaXpJOgTdZaA==
X-Received: by 2002:a5d:4688:0:b0:203:f0cc:da10 with SMTP id u8-20020a5d4688000000b00203f0ccda10mr3691926wrq.87.1648112095733;
        Thu, 24 Mar 2022 01:54:55 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d6d0c000000b001a65e479d20sm2327670wrq.83.2022.03.24.01.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 01:54:55 -0700 (PDT)
Message-ID: <7f74c6f3-3830-a508-7357-39361ba8111f@redhat.com>
Date:   Thu, 24 Mar 2022 09:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/vmstat: add events for ksm cow
Content-Language: en-US
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, yang.yang29@zte.com.cn,
        dave.hansen@linux.intel.com, ran.xiaokai@zte.com.cn,
        yang.shi@linux.alibaba.com, saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
References: <20220323075714.2345743-1-yang.yang29@zte.com.cn>
 <614b33de-cdf0-73d2-08e3-196363d816d2@redhat.com>
 <623bcb0a.1c69fb81.ae484.a006@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <623bcb0a.1c69fb81.ae484.a006@mx.google.com>
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

On 24.03.22 02:36, CGEL wrote:
> On Wed, Mar 23, 2022 at 07:43:04PM +0100, David Hildenbrand wrote:
>> On 23.03.22 08:57, cgel.zte@gmail.com wrote:
>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>
>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
>>> to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
>>> get to know how much memory ksm saved by reading
>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
>>> of ksm cow, and this is important of some delay sensitive tasks.
>>>
>>> So add ksm cow events to help users evaluate whether or how to use ksm.
>>>
>>> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
>>> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>>> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>> ---
>>> v2:
>>> - fix compile error when CONFIG_KSM is not set
>>> ---
>>>  include/linux/vm_event_item.h |  2 ++
>>>  mm/memory.c                   | 20 +++++++++++++++++---
>>>  mm/vmstat.c                   |  2 ++
>>>  3 files changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
>>> index 16a0a4fd000b..6f32be04212f 100644
>>> --- a/include/linux/vm_event_item.h
>>> +++ b/include/linux/vm_event_item.h
>>> @@ -131,6 +131,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>>  		SWAP_RA_HIT,
>>>  #ifdef CONFIG_KSM
>>>  		KSM_SWPIN_COPY,
>>> +		KSM_COW_SUCCESS,
>>> +		KSM_COW_FAIL,
>>>  #endif
>>>  #endif
>>>  #ifdef CONFIG_X86
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 4111f97c91a0..c24d5f04fab5 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3257,6 +3257,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>  	__releases(vmf->ptl)
>>>  {
>>>  	struct vm_area_struct *vma = vmf->vma;
>>> +	vm_fault_t ret = 0;
>>> +	bool ksm = 0;
>>>  
>>>  	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>>>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> @@ -3294,6 +3296,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>  	 */
>>>  	if (PageAnon(vmf->page)) {
>>>  		struct page *page = vmf->page;
>>> +		ksm = PageKsm(page);
>>>  
>>>  		/*
>>>  		 * We have to verify under page lock: these early checks are
>>> @@ -3302,7 +3305,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>  		 *
>>>  		 * PageKsm() doesn't necessarily raise the page refcount.
>>>  		 */
>>> -		if (PageKsm(page) || page_count(page) > 3)
>>> +		if (ksm || page_count(page) > 3)
>>>  			goto copy;
>>>  		if (!PageLRU(page))
>>>  			/*
>>> @@ -3316,7 +3319,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>  			goto copy;
>>>  		if (PageSwapCache(page))
>>>  			try_to_free_swap(page);
>>> -		if (PageKsm(page) || page_count(page) != 1) {
>>> +		if (ksm || page_count(page) != 1) {
>>
>> I think we really want to recheck here, after locking the page.
>> Consequently, just do a PageKsm() check below.
>>
>>>  			unlock_page(page);
>>>  			goto copy;
>>>  		}
>>> @@ -3339,7 +3342,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>  	get_page(vmf->page);
>>>  
>>>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -	return wp_page_copy(vmf);
>>> +	ret = wp_page_copy(vmf);
>>> +
>>> +#ifdef CONFIG_KSM
>>> +	if (ksm) {
>>> +		if (unlikely(ret & VM_FAULT_ERROR))
>>> +			count_vm_event(KSM_COW_FAIL);
>>> +		else
>>> +			count_vm_event(KSM_COW_SUCCESS);
>>> +	}
>>> +#endif
>>
>> Do we really care if we failed or not? I mean, the failure case will
>> usually make your app crash either way ... due to OOM.
>>
> I think we need failed count. Because ksm cow oom is a little different
> from general OOM. User may wonder I am not allocing new memory, why it
> cause OOM? And OOM may have big impact for some kind of tasks, so we
> better let user know that, do we?

The log will be flooded by messages from the OOM handler, how will one
counter regarding KSM help? I really don't think this is of any use.

-- 
Thanks,

David / dhildenb

