Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7314C318C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiBXQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD0E21BD998
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645720449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eqRaB+OmDsS+tiyERFAL77ZX3Mk9lB9x0+1xqBpQD4=;
        b=KiHMBNqycki5imzBtyUtNSdMiCMEsgAdZr4k2O3DBZYuxe6QHmBqAbPZ5PL/tMNMN2zcAM
        clyXZdadAmDczPwZTh+SWz2E6MDrpPLE/Wqq60O8A/99qskUEQoEBjJWPob9uQKOc1yf9a
        /kmJ6WzFPldBD6fcYM70Dqmo1+6v66A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-ASyK-kXcPtCyrvFqhzM3Mw-1; Thu, 24 Feb 2022 11:03:11 -0500
X-MC-Unique: ASyK-kXcPtCyrvFqhzM3Mw-1
Received: by mail-wr1-f72.google.com with SMTP id c16-20020adfa310000000b001ed9cd8f4c7so84754wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1eqRaB+OmDsS+tiyERFAL77ZX3Mk9lB9x0+1xqBpQD4=;
        b=JLlqgMuDC7LDrn8ItBwHwAQCSWYwEguROpMLz++Vz5m773AJ+dwOLK1IyRQa+NYJnV
         jmcThj2i17uyLCJ1fiyM3FdfOTK+UfUc13whW8jDiWcG9NZnon99DRBiAziegeoi+e4d
         Qxmv2pq5+l4QffDH8lxMyNzaaI8ruxe3RMZQZk8tVTkp5C4GUEj3Ixtg6GVgE4GkVoSM
         gmFdOt7qQU20BrYPlY5nn45lLHrdOBKDxCST0OG0uDzqv7zQsDSMGinLC+PgmNVUDrcK
         9y230R3cMB6RwfPG6nGIGHjjzZmo5deQxMYSA5nDTwyi2GUQi/uyN8DCX4Sg1IC3o9/V
         1pqw==
X-Gm-Message-State: AOAM532rV7K/xHpQ6q4E0+6Teg4jcAV0zrZvCDIt0cf8Jio8EsoPBUL4
        HvJ4ZhhPi/2TZbHxr/7SD6z2TDnaVe9IWzU0ix4PLHUF0W9IJ7ehDEeVMsHgV9yMBLwOric7Ymm
        v3ZcADGy1cottTi6ga5X8Rt9R
X-Received: by 2002:a05:6000:154e:b0:1ea:7622:64ec with SMTP id 14-20020a056000154e00b001ea762264ecmr2640561wry.600.1645718588939;
        Thu, 24 Feb 2022 08:03:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHsbZlLDXxhxiQipr5H7/YAP2evctcIhHJ/SBj83uVD14RuRdumrFsG3VPPpWyzbwAGbIQcQ==
X-Received: by 2002:a05:6000:154e:b0:1ea:7622:64ec with SMTP id 14-20020a056000154e00b001ea762264ecmr2640525wry.600.1645718588516;
        Thu, 24 Feb 2022 08:03:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4900:ccb0:e874:2bce:973b? (p200300cbc7074900ccb0e8742bce973b.dip0.t-ipconnect.de. [2003:cb:c707:4900:ccb0:e874:2bce:973b])
        by smtp.gmail.com with ESMTPSA id az7sm3585565wmb.14.2022.02.24.08.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:03:08 -0800 (PST)
Message-ID: <499012d5-7762-f12d-2382-1a36eaebb626@redhat.com>
Date:   Thu, 24 Feb 2022 17:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [davidhildenbrand:cow_fixes_part_2 21/27] mm/hugetlb.c:6051
 follow_hugetlb_page() error: uninitialized symbol 'unshare'.
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
References: <202202241452.QrPElUkk-lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202202241452.QrPElUkk-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 16:19, Dan Carpenter wrote:
> tree:   git://github.com/davidhildenbrand/linux cow_fixes_part_2
> head:   6a519d5bcfc204824056f340a0cfc86207962151
> commit: d41af2eea859d0123cf08a88eae48239d5bdae2b [21/27] mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220224/202202241452.QrPElUkk-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> mm/hugetlb.c:6051 follow_hugetlb_page() error: uninitialized symbol 'unshare'.
> 
> vim +/unshare +6051 mm/hugetlb.c
> 
> 28a35716d31798 Michel Lespinasse  2013-02-22  5977  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> 63551ae0feaaa2 David Gibson       2005-06-21  5978  			 struct page **pages, struct vm_area_struct **vmas,
> 28a35716d31798 Michel Lespinasse  2013-02-22  5979  			 unsigned long *position, unsigned long *nr_pages,
> 4f6da93411806d Peter Xu           2020-04-01  5980  			 long i, unsigned int flags, int *locked)
> 63551ae0feaaa2 David Gibson       2005-06-21  5981  {
> d5d4b0aa4e1430 Kenneth W Chen     2006-03-22  5982  	unsigned long pfn_offset;
> d5d4b0aa4e1430 Kenneth W Chen     2006-03-22  5983  	unsigned long vaddr = *position;
> 28a35716d31798 Michel Lespinasse  2013-02-22  5984  	unsigned long remainder = *nr_pages;
> a5516438959d90 Andi Kleen         2008-07-23  5985  	struct hstate *h = hstate_vma(vma);
> 0fa5bc4023c188 Joao Martins       2021-02-24  5986  	int err = -EFAULT, refs;
> 63551ae0feaaa2 David Gibson       2005-06-21  5987  
> 63551ae0feaaa2 David Gibson       2005-06-21  5988  	while (vaddr < vma->vm_end && remainder) {
> 63551ae0feaaa2 David Gibson       2005-06-21  5989  		pte_t *pte;
> cb900f41215447 Kirill A. Shutemov 2013-11-14  5990  		spinlock_t *ptl = NULL;
> d41af2eea859d0 David Hildenbrand  2021-12-16  5991  		bool unshare;
> 2a15efc953b26a Hugh Dickins       2009-09-21  5992  		int absent;
> 63551ae0feaaa2 David Gibson       2005-06-21  5993  		struct page *page;
> 63551ae0feaaa2 David Gibson       2005-06-21  5994  
> 02057967b5d3b7 David Rientjes     2015-04-14  5995  		/*
> 02057967b5d3b7 David Rientjes     2015-04-14  5996  		 * If we have a pending SIGKILL, don't keep faulting pages and
> 02057967b5d3b7 David Rientjes     2015-04-14  5997  		 * potentially allocating memory.
> 02057967b5d3b7 David Rientjes     2015-04-14  5998  		 */
> fa45f1162f28cb Davidlohr Bueso    2019-01-03  5999  		if (fatal_signal_pending(current)) {
> 02057967b5d3b7 David Rientjes     2015-04-14  6000  			remainder = 0;
> 02057967b5d3b7 David Rientjes     2015-04-14  6001  			break;
> 02057967b5d3b7 David Rientjes     2015-04-14  6002  		}
> 02057967b5d3b7 David Rientjes     2015-04-14  6003  
> 4c887265977213 Adam Litke         2005-10-29  6004  		/*
> 4c887265977213 Adam Litke         2005-10-29  6005  		 * Some archs (sparc64, sh*) have multiple pte_ts to
> 2a15efc953b26a Hugh Dickins       2009-09-21  6006  		 * each hugepage.  We have to make sure we get the
> 4c887265977213 Adam Litke         2005-10-29  6007  		 * first, for the page indexing below to work.
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6008  		 *
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6009  		 * Note that page table lock is not held when pte is null.
> 4c887265977213 Adam Litke         2005-10-29  6010  		 */
> 7868a2087ec13e Punit Agrawal      2017-07-06  6011  		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
> 7868a2087ec13e Punit Agrawal      2017-07-06  6012  				      huge_page_size(h));
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6013  		if (pte)
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6014  			ptl = huge_pte_lock(h, mm, pte);
> 2a15efc953b26a Hugh Dickins       2009-09-21  6015  		absent = !pte || huge_pte_none(huge_ptep_get(pte));
> 2a15efc953b26a Hugh Dickins       2009-09-21  6016  
> 2a15efc953b26a Hugh Dickins       2009-09-21  6017  		/*
> 2a15efc953b26a Hugh Dickins       2009-09-21  6018  		 * When coredumping, it suits get_dump_page if we just return
> 3ae77f43b1118a Hugh Dickins       2009-09-21  6019  		 * an error where there's an empty slot with no huge pagecache
> 3ae77f43b1118a Hugh Dickins       2009-09-21  6020  		 * to back it.  This way, we avoid allocating a hugepage, and
> 3ae77f43b1118a Hugh Dickins       2009-09-21  6021  		 * the sparse dumpfile avoids allocating disk blocks, but its
> 3ae77f43b1118a Hugh Dickins       2009-09-21  6022  		 * huge holes still show up with zeroes where they need to be.
> 2a15efc953b26a Hugh Dickins       2009-09-21  6023  		 */
> 3ae77f43b1118a Hugh Dickins       2009-09-21  6024  		if (absent && (flags & FOLL_DUMP) &&
> 3ae77f43b1118a Hugh Dickins       2009-09-21  6025  		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6026  			if (pte)
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6027  				spin_unlock(ptl);
> 2a15efc953b26a Hugh Dickins       2009-09-21  6028  			remainder = 0;
> 2a15efc953b26a Hugh Dickins       2009-09-21  6029  			break;
> 2a15efc953b26a Hugh Dickins       2009-09-21  6030  		}
> 63551ae0feaaa2 David Gibson       2005-06-21  6031  
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6032  		/*
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6033  		 * We need call hugetlb_fault for both hugepages under migration
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6034  		 * (in which case hugetlb_fault waits for the migration,) and
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6035  		 * hwpoisoned hugepages (in which case we need to prevent the
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6036  		 * caller from accessing to them.) In order to do this, we use
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6037  		 * here is_swap_pte instead of is_hugetlb_entry_migration and
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6038  		 * is_hugetlb_entry_hwpoisoned. This is because it simply covers
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6039  		 * both cases, and because we can't follow correct pages
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6040  		 * directly from any kind of swap entries.
> 9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6041  		 */
> d41af2eea859d0 David Hildenbrand  2021-12-16  6042  		if (absent ||
> d41af2eea859d0 David Hildenbrand  2021-12-16  6043  		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
> 
> Can absent be true
> 
> 2b7403035459c7 Souptick Joarder   2018-08-23  6044  			vm_fault_t ret;
> 87ffc118b54dcd Andrea Arcangeli   2017-02-22  6045  			unsigned int fault_flags = 0;
> 4c887265977213 Adam Litke         2005-10-29  6046  
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6047  			if (pte)
> cb900f41215447 Kirill A. Shutemov 2013-11-14  6048  				spin_unlock(ptl);
> 87ffc118b54dcd Andrea Arcangeli   2017-02-22  6049  			if (flags & FOLL_WRITE)
> 87ffc118b54dcd Andrea Arcangeli   2017-02-22  6050  				fault_flags |= FAULT_FLAG_WRITE;
> 
> And FOLL_WRITE is not set?
> 
> d41af2eea859d0 David Hildenbrand  2021-12-16 @6051  			else if (unshare)
>                                                                                  ^^^^^^^
> Uninitialized warning...
> 

Yes, I messed it up during a refactoring when moving the initialization
into __follow_hugetlb_must_fault(). I'll just move it back out

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c2a7dd8a48d..f5a310789b58 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5962,7 +5962,6 @@ static inline bool
__follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
 {
        pte_t pteval = huge_ptep_get(pte);

-       *unshare = false;
        if (is_swap_pte(pteval))
                return true;
        if (huge_pte_write(pteval))
@@ -5988,7 +5987,7 @@ long follow_hugetlb_page(struct mm_struct *mm,
struct vm_area_struct *vma,
        while (vaddr < vma->vm_end && remainder) {
                pte_t *pte;
                spinlock_t *ptl = NULL;
-               bool unshare;
+               bool unshare = false;
                int absent;
                struct page *page;


Thanks!

-- 
Thanks,

David / dhildenb

