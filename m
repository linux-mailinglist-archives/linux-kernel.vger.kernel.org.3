Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048F5A0A30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiHYH0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC2CFB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661412334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYqYKEGJ+KP7LBoMzmuzXA931mPNc1sqXqZsujDSc4k=;
        b=djQzdmWKjiIT+xMvMquWNoOTegMPTtzBH0O6MYitTc9Li+QLiqRc3mdgUTjJWSa8q+O9K/
        JIZ9lanpQ8VtoAz7VWaT7Z1tYttrg6hO6IlWvcz7wwrYY+eMwHnR/RqBeKNp8GNcSumB3w
        hMGwC3uRLdQ/TdJhsmLaP1tmpJuHnEQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-423-yn0OX3ZTOimH6ORVBDvDcg-1; Thu, 25 Aug 2022 03:25:33 -0400
X-MC-Unique: yn0OX3ZTOimH6ORVBDvDcg-1
Received: by mail-wm1-f72.google.com with SMTP id az42-20020a05600c602a00b003a552086ba9so2085306wmb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=OYqYKEGJ+KP7LBoMzmuzXA931mPNc1sqXqZsujDSc4k=;
        b=rVESn4kxDeW7BTMsXzSjrTRWQXQe5vBAlP48PkjvJ6AGkpGgFhBX0EHq/0SeYGdf7/
         SVj9bTPmJdmUvlYLuJSQ1CJuHV6hWGlEzfSQXa8Vf1C2xmovW/5azE7op1y/JT3tOu7w
         a1NzFhtBvPN19dAtO4JG4qboNaeVkFy83R9uQNm69lYFpS991rHz1Z3Rm60REhurmrs5
         MTkakSaDnvO7c6vd7x7tJqlMskvkiio9l2rnfpaGeA46Cn6Cxv7kRSyCFvCG4FlizTQB
         /3CpaWLPvARybPk2FyA/0iau+K1Z6z1la6V7b9kUiufl5psmXRKT3EO11IkF1ao+FPqL
         zu/A==
X-Gm-Message-State: ACgBeo08k+WZDvyIvRW2nNwtu0ox7iN+L60HcLgV54aRHqvxWGBOxAaW
        mSyGhkhSePrTMWLblBrgu7xTu40DEZu8AJ5XqQqOgakVezMIiyIkf35mq9kejKEzl9gkHIOX5M2
        eBogeEb2bGwhBPKwkbuJ/KNUI
X-Received: by 2002:a1c:7c08:0:b0:3a6:2569:4986 with SMTP id x8-20020a1c7c08000000b003a625694986mr7314967wmc.117.1661412332464;
        Thu, 25 Aug 2022 00:25:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uRmhuzDhvDxgRxM6tzXCcfyWriynxXUjR84DVwohmFa/ChGoAnFeQNl95dlMx4+Wnun3CrA==
X-Received: by 2002:a1c:7c08:0:b0:3a6:2569:4986 with SMTP id x8-20020a1c7c08000000b003a625694986mr7314952wmc.117.1661412332224;
        Thu, 25 Aug 2022 00:25:32 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b003a3561d4f3fsm4564405wmq.43.2022.08.25.00.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:25:31 -0700 (PDT)
Message-ID: <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
Date:   Thu, 25 Aug 2022 09:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
In-Reply-To: <Ywa1jp/6naTmUh42@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the primary concern the locking?  If so, I am not sure we have an issue.
> As mentioned in your commit message, current code will use
> pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
> will either be the mm wide lock or pmd_page lock.  To me, it seems that
> either would provide correct synchronization for CONT-PTE entries.  Am I
> missing something or misreading the code?
> 
> I started looking at code cleanup suggested by David.  Here is a quick
> patch (not tested and likely containing errors) to see if this is a step
> in the right direction.
> 
> I like it because we get rid of/combine all those follow_huge_p*d
> routines.
> 

Yes, see comments below.

> From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Wed, 24 Aug 2022 15:59:15 -0700
> Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
>  follow_page_mask
> 
> At the beginning of follow_page_mask, there currently is a call to
> follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
> architecture which (incorrectly) provides a follow_huge_addr routine
> that does not return error.  Instead, at each level of the page table a
> check is made for a hugetlb entry.  If a hugetlb entry is found, a call
> to a routine associated with that page table level such as
> follow_huge_pmd is made.
> 
> All the follow_huge_p*d routines are basically the same.  In addition
> huge page size can be derived from the vma, so we know where in the page
> table a huge page would reside.  So, replace follow_huge_addr with a
> new architecture independent routine which will provide the same
> functionality as the follow_huge_p*d routines.  We can then eliminate
> the p*d_huge checks in follow_page_mask page table walking as well as
> the follow_huge_p*d routines themselves.>
> follow_page_mask still has is_hugepd hugetlb checks during page table
> walking.  This is due to these checks and follow_huge_pd being
> architecture specific.  These can be eliminated if
> hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
> that need to do follow_huge_pd processing.

But won't the

> +	/* hugetlb is special */
> +	if (is_vm_hugetlb_page(vma))
> +		return hugetlb_follow_page_mask(vma, address, flags);

code route everything via hugetlb_follow_page_mask() and all these
(beloved) hugepd checks would essentially be unreachable?

At least my understanding is that hugepd only applies to hugetlb.

Can't we move the hugepd handling code into hugetlb_follow_page_mask()
as well?

I mean, doesn't follow_hugetlb_page() also have to handle that hugepd
stuff already ... ?

[...]

>  
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long haddr = address & huge_page_mask(h);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte, entry;
> +
> +	/*
> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> +	 * follow_hugetlb_page().
> +	 */
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> +		return NULL;
> +
> +	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	if (!pte)
> +		return NULL;
> +
> +retry:
> +	ptl = huge_pte_lock(h, mm, pte);
> +	entry = huge_ptep_get(pte);
> +	if (pte_present(entry)) {
> +		page = pte_page(entry);
> +		/*
> +		 * try_grab_page() should always succeed here, because we hold
> +		 * the ptl lock and have verified pte_present().
> +		 */
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (is_hugetlb_entry_migration(entry)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait_huge(pte, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;


This is neat and clean enough to not reuse follow_hugetlb_page(). I
wonder if we want to add some comment to the function how this differs
to follow_hugetlb_page().

... or do we maybe want to rename follow_hugetlb_page() to someting like
__hugetlb_get_user_pages() to make it clearer in which context it will
get called?


I guess it might be feasible in the future to eliminate
follow_hugetlb_page() and centralizing the faulting code. For now, this
certainly improves the situation.

-- 
Thanks,

David / dhildenb

