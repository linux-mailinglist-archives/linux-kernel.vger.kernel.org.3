Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7C58044F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiGYTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGYTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:14:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A1BCAA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:14:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a23so17168924lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=MV4VzYVfr0dyzDJoYweor1lQWAAiLh97cdww1YFCrmk=;
        b=e7hVEKo2e3xM38jkrltbn32W5AVsoyKzKuqe89/rj5NhLIqdESoqHj9Uez4GIfZrO8
         M2Acfj5WB9EbSfNBKQVFi8RWg9ip7cDhlpy3EABzUiwmBtnHrCLeZlXhWaoNTyypQNJ6
         XXPcGHTnm0IGkxWu0uv+dJ10DARP96IyZs8Yt3QByBJLdKbVe6t+HkkS3hlVHTDo2WnH
         FKVfXFUhew5ySdhOxtUWz1eaUGI+GicnNU4YSD1RDk/BZfYh6jM/1Xqj8gqJJMOPLj8D
         TtzBJRBYGAvn65cRDzioJcnXgklBXBia91VH/M+QRfr1EvfQZiC/rKI0mkjOVEKeow+x
         CzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MV4VzYVfr0dyzDJoYweor1lQWAAiLh97cdww1YFCrmk=;
        b=QRvk4wThxYZIlR9KxdOikf0zgqkPvlqgU3V9FT79f1dswT5RUzczE7/zGn1cHONBwV
         8JqaabdnDEGpauPzbCuUSjIr/WTXaE1jy8f185PVX6YBQSjJ5m5+6NdII/6ki2REpiib
         Z+Ab+HNcDi0yaDPzQbZhVPdYyBID1GOnLy4rRmsOXRJo4w+y4dd/P1MKaQrAZhTN+MWq
         zmda7Y2Jwizw50DjtBy/QZiCHAf5x737X0ZTXVIurY5SQBU+Boy/i0xvkHjD2wYxnLTd
         na4mKZfMa3wI1zf9C90iYHxuamSxgxRU3WCcrh7lXOtUUvEmKtGOsihsjtf2hcAF69Xk
         cG0A==
X-Gm-Message-State: AJIora9H8hEp8yw7cXbCDf5CmnGsyucSCAjZTGmLED1z4FfoHsfkE+KQ
        fg1LcjQlmfWU/3Jz064kwkzkxI+r0Hs=
X-Google-Smtp-Source: AGRyM1tWiFsWEhe+4nhfoVFQzE7tXYQg9vXUE9CoRH285KGIvSwj6ZazRmDNuFHHcqLotj+GRE7dNw==
X-Received: by 2002:a05:6512:2821:b0:48a:6a01:3d29 with SMTP id cf33-20020a056512282100b0048a6a013d29mr5305006lfb.649.1658776451921;
        Mon, 25 Jul 2022 12:14:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru. [109.252.119.232])
        by smtp.googlemail.com with ESMTPSA id cf3-20020a056512280300b0048a71ff9c04sm2625791lfb.254.2022.07.25.12.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 12:14:11 -0700 (PDT)
Message-ID: <8d77a517-fcc1-5e74-b9d8-2a250dc751ed@gmail.com>
Date:   Mon, 25 Jul 2022 22:13:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v12 22/69] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
 <20220720021727.17018-23-Liam.Howlett@oracle.com>
 <f5e99dbb-7008-dcf8-3e85-2f161056b37a@gmail.com>
 <20220725140053.gk4ugsxxhgabzg44@revolver>
 <20220725184940.yzgz2m25sbfj5zjj@revolver>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220725184940.yzgz2m25sbfj5zjj@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.07.2022 21:49, Liam Howlett пишет:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220725 10:00]:
>> * Dmitry Osipenko <digetx@gmail.com> [220723 11:01]:
>>> 20.07.2022 05:17, Liam Howlett пишет:
>>>> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>>>>
>>>> Avoid allocating a new VMA when it a vma modification can occur.  When a
>>>> brk() can expand or contract a VMA, then the single store operation will
>>>> only modify one index of the maple tree instead of causing a node to split
>>>> or coalesce.  This avoids unnecessary allocations/frees of maple tree
>>>> nodes and VMAs.
>>>>
>>>> Move some limit & flag verifications out of the do_brk_flags() function to
>>>> use only relevant checks in the code path of bkr() and vm_brk_flags().
>>>>
>>>> Set the vma to check if it can expand in vm_brk_flags() if extra criteria
>>>> are met.
>>>>
>>>> Drop userfaultfd from do_brk_flags() path and only use it in
>>>> vm_brk_flags() path since that is the only place a munmap will happen.
>>>>
>>>> Add a wraper for munmap for the brk case called do_brk_munmap().
>>>>
>>>> Link: https://lkml.kernel.org/r/20220504011345.662299-7-Liam.Howlett@oracle.com
>>>> Link: https://lkml.kernel.org/r/20220621204632.3370049-23-Liam.Howlett@oracle.com
>>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: David Howells <dhowells@redhat.com>
>>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>>> Cc: SeongJae Park <sj@kernel.org>
>>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>> ---
>>>>  mm/mmap.c | 239 ++++++++++++++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 179 insertions(+), 60 deletions(-)
>>>>
>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>> index 02d2fd90af80..33b408653201 100644
>>>> --- a/mm/mmap.c
>>>> +++ b/mm/mmap.c
>>>> @@ -194,17 +194,40 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
>>>>  	return next;
>>>>  }
>>>>  
>>>> -static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags,
>>>> -		struct list_head *uf);
>>>> +/*
>>>> + * check_brk_limits() - Use platform specific check of range & verify mlock
>>>> + * limits.
>>>> + * @addr: The address to check
>>>> + * @len: The size of increase.
>>>> + *
>>>> + * Return: 0 on success.
>>>> + */
>>>> +static int check_brk_limits(unsigned long addr, unsigned long len)
>>>> +{
>>>> +	unsigned long mapped_addr;
>>>> +
>>>> +	mapped_addr = get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
>>>> +	if (IS_ERR_VALUE(mapped_addr))
>>>> +		return mapped_addr;
>>>> +
>>>> +	return mlock_future_check(current->mm, current->mm->def_flags, len);
>>>> +}
>>>> +static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>>>> +			 unsigned long newbrk, unsigned long oldbrk,
>>>> +			 struct list_head *uf);
>>>> +static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvma,
>>>> +			unsigned long addr, unsigned long request,
>>>> +			unsigned long flags);
>>>>  SYSCALL_DEFINE1(brk, unsigned long, brk)
>>>>  {
>>>>  	unsigned long newbrk, oldbrk, origbrk;
>>>>  	struct mm_struct *mm = current->mm;
>>>> -	struct vm_area_struct *next;
>>>> +	struct vm_area_struct *brkvma, *next = NULL;
>>>>  	unsigned long min_brk;
>>>>  	bool populate;
>>>>  	bool downgraded = false;
>>>>  	LIST_HEAD(uf);
>>>> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>>>>  
>>>>  	if (mmap_write_lock_killable(mm))
>>>>  		return -EINTR;
>>>> @@ -246,35 +269,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>>>>  
>>>>  	/*
>>>>  	 * Always allow shrinking brk.
>>>> -	 * __do_munmap() may downgrade mmap_lock to read.
>>>> +	 * do_brk_munmap() may downgrade mmap_lock to read.
>>>>  	 */
>>>>  	if (brk <= mm->brk) {
>>>>  		int ret;
>>>>  
>>>> +		/* Search one past newbrk */
>>>> +		mas_set(&mas, newbrk);
>>>> +		brkvma = mas_find(&mas, oldbrk);
>>>> +		BUG_ON(brkvma == NULL);
>>>> +		if (brkvma->vm_start >= oldbrk)
>>>> +			goto out; /* mapping intersects with an existing non-brk vma. */
>>>>  		/*
>>>> -		 * mm->brk must to be protected by write mmap_lock so update it
>>>> -		 * before downgrading mmap_lock. When __do_munmap() fails,
>>>> -		 * mm->brk will be restored from origbrk.
>>>> +		 * mm->brk must be protected by write mmap_lock.
>>>> +		 * do_brk_munmap() may downgrade the lock,  so update it
>>>> +		 * before calling do_brk_munmap().
>>>>  		 */
>>>>  		mm->brk = brk;
>>>> -		ret = __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
>>>> -		if (ret < 0) {
>>>> -			mm->brk = origbrk;
>>>> -			goto out;
>>>> -		} else if (ret == 1) {
>>>> +		mas.last = oldbrk - 1;
>>>> +		ret = do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
>>>> +		if (ret == 1)  {
>>>>  			downgraded = true;
>>>> -		}
>>>> -		goto success;
>>>> +			goto success;
>>>> +		} else if (!ret)
>>>> +			goto success;
>>>> +
>>>> +		mm->brk = origbrk;
>>>> +		goto out;
>>>>  	}
>>>>  
>>>> -	/* Check against existing mmap mappings. */
>>>> -	next = find_vma(mm, oldbrk);
>>>> +	if (check_brk_limits(oldbrk, newbrk - oldbrk))
>>>> +		goto out;
>>>> +
>>>> +	/*
>>>> +	 * Only check if the next VMA is within the stack_guard_gap of the
>>>> +	 * expansion area
>>>> +	 */
>>>> +	mas_set(&mas, oldbrk);
>>>> +	next = mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
>>>>  	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
>>>>  		goto out;
>>>>  
>>>> +	brkvma = mas_prev(&mas, mm->start_brk);
>>>>  	/* Ok, looks good - let it rip. */
>>>> -	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
>>>> +	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
>>>>  		goto out;
>>>> +
>>>>  	mm->brk = brk;
>>>>  
>>>>  success:
>>>> @@ -2805,38 +2845,55 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>>>>  }
>>>>  
>>>>  /*
>>>> - *  this is really a simplified "do_mmap".  it only handles
>>>> - *  anonymous maps.  eventually we may be able to do some
>>>> - *  brk-specific accounting here.
>>>> + * brk_munmap() - Unmap a parital vma.
>>>> + * @mas: The maple tree state.
>>>> + * @vma: The vma to be modified
>>>> + * @newbrk: the start of the address to unmap
>>>> + * @oldbrk: The end of the address to unmap
>>>> + * @uf: The userfaultfd list_head
>>>> + *
>>>> + * Returns: 1 on success.
>>>> + * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
>>>> + * possible.
>>>>   */
>>>> -static int do_brk_flags(unsigned long addr, unsigned long len,
>>>> -			unsigned long flags, struct list_head *uf)
>>>> +static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>>>> +			 unsigned long newbrk, unsigned long oldbrk,
>>>> +			 struct list_head *uf)
>>>>  {
>>>> -	struct mm_struct *mm = current->mm;
>>>> -	struct vm_area_struct *vma, *prev;
>>>> -	pgoff_t pgoff = addr >> PAGE_SHIFT;
>>>> -	int error;
>>>> -	unsigned long mapped_addr;
>>>> -	validate_mm_mt(mm);
>>>> -
>>>> -	/* Until we need other flags, refuse anything except VM_EXEC. */
>>>> -	if ((flags & (~VM_EXEC)) != 0)
>>>> -		return -EINVAL;
>>>> -	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>>>> -
>>>> -	mapped_addr = get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
>>>> -	if (IS_ERR_VALUE(mapped_addr))
>>>> -		return mapped_addr;
>>>> +	struct mm_struct *mm = vma->vm_mm;
>>>> +	int ret;
>>>>  
>>>> -	error = mlock_future_check(mm, mm->def_flags, len);
>>>> -	if (error)
>>>> -		return error;
>>>> +	arch_unmap(mm, newbrk, oldbrk);
>>>> +	ret = __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
>>>> +	validate_mm_mt(mm);
>>>> +	return ret;
>>>> +}
>>>>  
>>>> -	/* Clear old maps, set up prev and uf */
>>>> -	if (munmap_vma_range(mm, addr, len, &prev, uf))
>>>> -		return -ENOMEM;
>>>> +/*
>>>> + * do_brk_flags() - Increase the brk vma if the flags match.
>>>> + * @mas: The maple tree state.
>>>> + * @addr: The start address
>>>> + * @len: The length of the increase
>>>> + * @vma: The vma,
>>>> + * @flags: The VMA Flags
>>>> + *
>>>> + * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
>>>> + * do not match then create a new anonymous VMA.  Eventually we may be able to
>>>> + * do some brk-specific accounting here.
>>>> + */
>>>> +static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
>>>> +			unsigned long addr, unsigned long len,
>>>> +			unsigned long flags)
>>>> +{
>>>> +	struct mm_struct *mm = current->mm;
>>>> +	struct vm_area_struct *prev = NULL;
>>>>  
>>>> -	/* Check against address space limits *after* clearing old maps... */
>>>> +	validate_mm_mt(mm);
>>>> +	/*
>>>> +	 * Check against address space limits by the changed size
>>>> +	 * Note: This happens *after* clearing old mappings in some code paths.
>>>> +	 */
>>>> +	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>>>>  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
>>>>  		return -ENOMEM;
>>>>  
>>>> @@ -2846,30 +2903,56 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>>>>  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
>>>>  		return -ENOMEM;
>>>>  
>>>> -	/* Can we just expand an old private anonymous mapping? */
>>>> -	vma = vma_merge(mm, prev, addr, addr + len, flags,
>>>> -			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
>>>> -	if (vma)
>>>> -		goto out;
>>>> -
>>>>  	/*
>>>> -	 * create a vma struct for an anonymous mapping
>>>> +	 * Expand the existing vma if possible; Note that singular lists do not
>>>> +	 * occur after forking, so the expand will only happen on new VMAs.
>>>>  	 */
>>>> -	vma = vm_area_alloc(mm);
>>>> -	if (!vma) {
>>>> -		vm_unacct_memory(len >> PAGE_SHIFT);
>>>> -		return -ENOMEM;
>>>> +	if (vma &&
>>>> +	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
>>>> +	    ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)) {
>>>> +		mas->index = vma->vm_start;
>>>> +		mas->last = addr + len - 1;
>>>> +		vma_adjust_trans_huge(vma, addr, addr + len, 0);
>>>> +		if (vma->anon_vma) {
>>>> +			anon_vma_lock_write(vma->anon_vma);
>>>> +			anon_vma_interval_tree_pre_update_vma(vma);
>>>> +		}
>>>> +		vma->vm_end = addr + len;
>>>> +		vma->vm_flags |= VM_SOFTDIRTY;
>>>> +		if (mas_store_gfp(mas, vma, GFP_KERNEL))
>>>> +			goto mas_expand_failed;
>>>> +
>>>> +		if (vma->anon_vma) {
>>>> +			anon_vma_interval_tree_post_update_vma(vma);
>>>> +			anon_vma_unlock_write(vma->anon_vma);
>>>> +		}
>>>> +		khugepaged_enter_vma(vma, flags);
>>>> +		goto out;
>>>>  	}
>>>> +	prev = vma;
>>>> +
>>>> +	/* create a vma struct for an anonymous mapping */
>>>> +	vma = vm_area_alloc(mm);
>>>> +	if (!vma)
>>>> +		goto vma_alloc_fail;
>>>>  
>>>>  	vma_set_anonymous(vma);
>>>>  	vma->vm_start = addr;
>>>>  	vma->vm_end = addr + len;
>>>> -	vma->vm_pgoff = pgoff;
>>>> +	vma->vm_pgoff = addr >> PAGE_SHIFT;
>>>>  	vma->vm_flags = flags;
>>>>  	vma->vm_page_prot = vm_get_page_prot(flags);
>>>> -	if (vma_link(mm, vma, prev))
>>>> -		goto no_vma_link;
>>>> +	mas_set_range(mas, vma->vm_start, addr + len - 1);
>>>> +	if (mas_store_gfp(mas, vma, GFP_KERNEL))
>>>> +		goto mas_store_fail;
>>>>  
>>>> +	mm->map_count++;
>>>> +
>>>> +	if (!prev)
>>>> +		prev = mas_prev(mas, 0);
>>>> +
>>>> +	__vma_link_list(mm, vma, prev);
>>>> +	mm->map_count++;
>>>>  out:
>>>>  	perf_event_mmap(vma);
>>>>  	mm->total_vm += len >> PAGE_SHIFT;
>>>> @@ -2880,18 +2963,29 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>>>>  	validate_mm_mt(mm);
>>>>  	return 0;
>>>>  
>>>> -no_vma_link:
>>>> +mas_store_fail:
>>>>  	vm_area_free(vma);
>>>> +vma_alloc_fail:
>>>> +	vm_unacct_memory(len >> PAGE_SHIFT);
>>>> +	return -ENOMEM;
>>>> +
>>>> +mas_expand_failed:
>>>> +	if (vma->anon_vma) {
>>>> +		anon_vma_interval_tree_post_update_vma(vma);
>>>> +		anon_vma_unlock_write(vma->anon_vma);
>>>> +	}
>>>>  	return -ENOMEM;
>>>>  }
>>>>  
>>>>  int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>>>>  {
>>>>  	struct mm_struct *mm = current->mm;
>>>> +	struct vm_area_struct *vma = NULL;
>>>>  	unsigned long len;
>>>>  	int ret;
>>>>  	bool populate;
>>>>  	LIST_HEAD(uf);
>>>> +	MA_STATE(mas, &mm->mm_mt, addr, addr);
>>>>  
>>>>  	len = PAGE_ALIGN(request);
>>>>  	if (len < request)
>>>> @@ -2902,13 +2996,38 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>>>>  	if (mmap_write_lock_killable(mm))
>>>>  		return -EINTR;
>>>>  
>>>> -	ret = do_brk_flags(addr, len, flags, &uf);
>>>> +	/* Until we need other flags, refuse anything except VM_EXEC. */
>>>> +	if ((flags & (~VM_EXEC)) != 0)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = check_brk_limits(addr, len);
>>>> +	if (ret)
>>>> +		goto limits_failed;
>>>> +
>>>> +	if (find_vma_intersection(mm, addr, addr + len))
>>>> +		ret = do_munmap(mm, addr, len, &uf);
>>>> +
>>>> +	if (ret)
>>>> +		goto munmap_failed;
>>>> +
>>>> +	vma = mas_prev(&mas, 0);
>>>> +	if (!vma || vma->vm_end != addr || vma_policy(vma) ||
>>>> +	    !can_vma_merge_after(vma, flags, NULL, NULL,
>>>> +				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
>>>> +		vma = NULL;
>>>> +
>>>> +	ret = do_brk_flags(&mas, vma, addr, len, flags);
>>>>  	populate = ((mm->def_flags & VM_LOCKED) != 0);
>>>>  	mmap_write_unlock(mm);
>>>>  	userfaultfd_unmap_complete(mm, &uf);
>>>>  	if (populate && !ret)
>>>>  		mm_populate(addr, len);
>>>>  	return ret;
>>>> +
>>>> +munmap_failed:
>>>> +limits_failed:
>>>> +	mmap_write_unlock(mm);
>>>> +	return ret;
>>>>  }
>>>>  EXPORT_SYMBOL(vm_brk_flags);
>>>>  
>>>
>>> Hello,
>>>
>>> I cannot complete booting into graphics environment on ARM32 because
>>> do_brk_flags() now crashes with a BUG_ON() on a recent linux-next and
>>> this patch should be the cause. Please take a look, thanks in advance.
>>>
>>> ------------[ cut here ]------------
>>> kernel BUG at lib/maple_tree.c:911!
>>> Internal error: Oops - BUG: 0 [#1] SMP ARM
>>> Modules linked in:
>>> CPU: 1 PID: 692 Comm: kwin_x11 Not tainted
>>> 5.19.0-rc7-next-20220722-00130-g1583ab12487b #21
>>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>> PC is at mas_update_gap+0xac/0x1a8
>>> LR is at 0xcc343e00
>>> pc : [<c0747314>]    lr : [<cc343e00>]    psr: 60080013
>>> sp : f1299ac8  ip : 999b6000  fp : f1299ae4
>>> r10: c1062588  r9 : 00000023  r8 : 00000001
>>> r7 : 0000001f  r6 : cc0ea6a8  r5 : 00000000  r4 : f1299f54
>>> r3 : 00000000  r2 : c25a2000  r1 : 999b6000  r0 : 00000000
>>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>> Control: 10c5387d  Table: 0d28404a  DAC: 00000051
>>> Register r0 information: NULL pointer
>>> Register r1 information: non-paged memory
>>> Register r2 information: slab mm_struct start c25a2000 pointer offset 0
>>> size 168
>>> Register r3 information: NULL pointer
>>> Register r4 information: 2-page vmalloc region starting at 0xf1298000
>>> allocated at kernel_clone+0x64/0x43c
>>> Register r5 information: NULL pointer
>>> Register r6 information: slab maple_node start cc0ea600 pointer offset 168
>>> Register r7 information: non-paged memory
>>> Register r8 information: non-paged memory
>>> Register r9 information: non-paged memory
>>> Register r10 information: non-slab/vmalloc memory
>>> Register r11 information: 2-page vmalloc region starting at 0xf1298000
>>> allocated at kernel_clone+0x64/0x43c
>>> Register r12 information: non-paged memory
>>> Process kwin_x11 (pid: 692, stack limit = 0x976e11bf)
>>> ...
>>> Backtrace:
>>>  mas_update_gap from mas_wr_modify+0x1b4/0x1898
>>>  r7:0000001f r6:00000000 r5:f1299e90 r4:f1299f54
>>>  mas_wr_modify from mas_wr_store_entry+0x138/0x4d8
>>>  r10:cd26febc r9:00000023 r8:f1299f54 r7:00000cc0 r6:cd21d600 r5:f1299f54
>>>  r4:f1299e90
>>>  mas_wr_store_entry from mas_store_gfp+0x64/0x154
>>>  r9:00000023 r8:f1299f54 r7:00000cc0 r6:cd21d600 r5:cd26fea0 r4:f1299f54
>>>  mas_store_gfp from do_brk_flags+0x21c/0x318
>>>  r10:cd26febc r9:00000023 r8:f1299f54 r7:0097a000 r6:cd26fec4 r5:c25a2000
>>>  r4:cd26fea0
>>>  do_brk_flags from sys_brk+0x27c/0x3c8
>>>  r10:c25a2038 r9:00957000 r8:00000000 r7:cd21d600 r6:0097a000 r5:00957000
>>>  r4:c25a2000
>>>  sys_brk from ret_fast_syscall+0x0/0x1c
>>
>> Thanks for the report.  I'm trying to test this now in qemu.  I have a
>> few extra patches that have been sent to the linux-mm but have not made
>> it into next as of today (next-20220725) [1] [2] [3].  I don't think
>> they will make a difference but you can try them while I keep working on
>> testing arm32 on this end.
>>
>> 1. https://lore.kernel.org/linux-mm/20220722160546.1478722-1-Liam.Howlett@oracle.com/
>> 2. https://lore.kernel.org/linux-mm/20220721005828.379405-1-Liam.Howlett@oracle.com/
>> 3. https://lore.kernel.org/linux-mm/20220721005237.377987-1-Liam.Howlett@oracle.com/
>>
> 
> Dmitry,
> 
> I am having a hard time reproducing this issue.  What linux-next tag are
> you using?

The next-20220722, like my trace log says. It has been broken for about
2+ weeks in -next. For me the bug is triggered by loading KDE plasma on
NVIDIA Tegra tablet. I may try to reproduce it in Qemu if time will allow.
