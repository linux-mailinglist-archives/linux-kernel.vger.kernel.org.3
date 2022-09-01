Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796665A9106
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiIAHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiIAHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:46:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913321B9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:44:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w2so16386777pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lrUJ8hzAFO5ETYQA2u7pOpjKOW22COqLCAdhgsnw34o=;
        b=dtt0MKJH4EF6UlO2xymDJ217xbbGekm71aW+8Jbk1tG7DjPpnBaNJ/lK5NQaZTBjld
         oxebEE3rb+W1N36iJtBKdhM6ojACjsH8D4SDHp5HpnJz9yXPqLLAbOiEg2xJWShDlPjS
         F/E7hKcavJRAX4uAuhzR5tIlss9tCNoco70FnVvgB5DqN5ajRNMoHZ3aZFgFXOuHngIO
         p8IvNDwUYu/1eRqAMGFTgA7jeL52J8RJX66nEuktLEp1NSP22TJ1Zyvowitz/aYAMIst
         0s6RZh8wwYIEVHWViO5DOnPoku1jmapUF9XN9DQ2yo0OGqWkj08tJ/xabRYRE3vQpXHk
         kw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lrUJ8hzAFO5ETYQA2u7pOpjKOW22COqLCAdhgsnw34o=;
        b=BDFuwKykDLEoZSVCb49D8iQp+JqekomcvffSTz/+B+rEUIje8H3+50LPTm88wBAGUe
         w1MA6lIwrPWhGpz0ZFdsSLalCLZFK87DRV9+MH6RKmyqF3yGeYeHWJELqNLn1DVuZLS/
         tMuORoVea8/F4o6hVzrM/p0LO9p3wQWPShs39ixJ/8OWizabvPMXm3N74WeiH3orD/hB
         FfQPCmYO63zAgWx2uxjs/jnqyPL1O0ht/FWYw5N3hGtxwRM1DL0teO8hc30SMiPfl6qI
         i8FFXm+dO2NwFQmFi74Tmnvdv31r1nTLIjCuNTvlW7feo2ASe196pkbZn9+jf/Uu5KdV
         vktQ==
X-Gm-Message-State: ACgBeo1z2WLsRcK+9YwFFRwGKrS3VAldiVOsLDuuk3woyDQIhSyJf007
        fG+Vr84jW3WqsWx7+DSu5vujHbobMniX2xbK
X-Google-Smtp-Source: AA6agR5XqIwudnHiLg/ORivU1zvig75iiBBoF+nvsnuTXVutHiuyqTMZriheJdKJ4g9ee0/M+DJ3Vg==
X-Received: by 2002:a17:90a:150f:b0:1fb:aee:cd2a with SMTP id l15-20020a17090a150f00b001fb0aeecd2amr7368763pja.47.1662018286309;
        Thu, 01 Sep 2022 00:44:46 -0700 (PDT)
Received: from [10.4.97.191] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a4dce00b001fde4a4c28csm2577852pjl.37.2022.09.01.00.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:44:45 -0700 (PDT)
Message-ID: <639fa8d5-8e5b-2333-69dc-40ed46219364@bytedance.com>
Date:   Thu, 1 Sep 2022 15:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: [PATCH mm-unstable] mm: thp: fix build error with CONFIG_SHMEM
 disabled
Content-Language: en-US
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
 <20220831031951.43152-3-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220831031951.43152-3-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From 9075ff5ab459b1b1df53e74261d24f300203ee9f Mon Sep 17 00:00:00 2001
From: Qi Zheng <zhengqi.arch@bytedance.com>
Date: Thu, 1 Sep 2022 07:26:25 +0000
Subject: [PATCH mm-unstable] mm: thp: fix build error with CONFIG_SHMEM
  disabled

Fix the following build error by changing function
parameter type from struct mm_sot * to struct khugepaged_mm_slot *:

mm/khugepaged.c: In function 'khugepaged_scan_mm_slot':
 >> mm/khugepaged.c:2056:45: error: passing argument 1 of 
'khugepaged_collapse_pte_mapped_thps' from incompatible pointer type 
[-Werror=incompatible-pointer-types]
     2056 |         khugepaged_collapse_pte_mapped_thps(mm_slot);
          |                                             ^~~~~~~
          |                                             |
          |                                             struct 
khugepaged_mm_slot *
    mm/khugepaged.c:2023:65: note: expected 'struct mm_slot *' but 
argument is of type 'struct khugepaged_mm_slot *'
     2023 | static void khugepaged_collapse_pte_mapped_thps(struct 
mm_slot *mm_slot)
          | 
~~~~~~~~~~~~~~~~^~~~~~~
    cc1: some warnings being treated as errors

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
  mm/khugepaged.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2d74cf01f694..af3b07eb2389 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2020,7 +2020,7 @@ static int khugepaged_scan_file(struct mm_struct 
*mm, struct file *file,
  	BUILD_BUG();
  }

-static void khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+static void khugepaged_collapse_pte_mapped_thps(struct 
khugepaged_mm_slot *mm_slot)
  {
  }
  #endif
--
2.20.1


On 2022/8/31 11:19, Qi Zheng wrote:
> Rename private struct mm_slot to struct khugepaged_mm_slot and
> convert to use common struct mm_slot with no functional change.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/khugepaged.c | 121 ++++++++++++++++++++----------------------------
>   1 file changed, 51 insertions(+), 70 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d8e388106322..2d74cf01f694 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -23,6 +23,7 @@
>   #include <asm/tlb.h>
>   #include <asm/pgalloc.h>
>   #include "internal.h"
> +#include "mm_slot.h"
>   
>   enum scan_result {
>   	SCAN_FAIL,
> @@ -104,17 +105,13 @@ struct collapse_control {
>   };
>   
>   /**
> - * struct mm_slot - hash lookup from mm to mm_slot
> - * @hash: hash collision list
> - * @mm_node: khugepaged scan list headed in khugepaged_scan.mm_head
> - * @mm: the mm that this information is valid for
> + * struct khugepaged_mm_slot - khugepaged information per mm that is being scanned
> + * @slot: hash lookup from mm to mm_slot
>    * @nr_pte_mapped_thp: number of pte mapped THP
>    * @pte_mapped_thp: address array corresponding pte mapped THP
>    */
> -struct mm_slot {
> -	struct hlist_node hash;
> -	struct list_head mm_node;
> -	struct mm_struct *mm;
> +struct khugepaged_mm_slot {
> +	struct mm_slot slot;
>   
>   	/* pte-mapped THP in this mm */
>   	int nr_pte_mapped_thp;
> @@ -131,7 +128,7 @@ struct mm_slot {
>    */
>   struct khugepaged_scan {
>   	struct list_head mm_head;
> -	struct mm_slot *mm_slot;
> +	struct khugepaged_mm_slot *mm_slot;
>   	unsigned long address;
>   };
>   
> @@ -395,8 +392,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
>   int __init khugepaged_init(void)
>   {
>   	mm_slot_cache = kmem_cache_create("khugepaged_mm_slot",
> -					  sizeof(struct mm_slot),
> -					  __alignof__(struct mm_slot), 0, NULL);
> +					  sizeof(struct khugepaged_mm_slot),
> +					  __alignof__(struct khugepaged_mm_slot),
> +					  0, NULL);
>   	if (!mm_slot_cache)
>   		return -ENOMEM;
>   
> @@ -413,36 +411,6 @@ void __init khugepaged_destroy(void)
>   	kmem_cache_destroy(mm_slot_cache);
>   }
>   
> -static inline struct mm_slot *alloc_mm_slot(void)
> -{
> -	if (!mm_slot_cache)	/* initialization failed */
> -		return NULL;
> -	return kmem_cache_zalloc(mm_slot_cache, GFP_KERNEL);
> -}
> -
> -static inline void free_mm_slot(struct mm_slot *mm_slot)
> -{
> -	kmem_cache_free(mm_slot_cache, mm_slot);
> -}
> -
> -static struct mm_slot *get_mm_slot(struct mm_struct *mm)
> -{
> -	struct mm_slot *mm_slot;
> -
> -	hash_for_each_possible(mm_slots_hash, mm_slot, hash, (unsigned long)mm)
> -		if (mm == mm_slot->mm)
> -			return mm_slot;
> -
> -	return NULL;
> -}
> -
> -static void insert_to_mm_slots_hash(struct mm_struct *mm,
> -				    struct mm_slot *mm_slot)
> -{
> -	mm_slot->mm = mm;
> -	hash_add(mm_slots_hash, &mm_slot->hash, (long)mm);
> -}
> -
>   static inline int hpage_collapse_test_exit(struct mm_struct *mm)
>   {
>   	return atomic_read(&mm->mm_users) == 0;
> @@ -450,28 +418,31 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
>   
>   void __khugepaged_enter(struct mm_struct *mm)
>   {
> -	struct mm_slot *mm_slot;
> +	struct khugepaged_mm_slot *mm_slot;
> +	struct mm_slot *slot;
>   	int wakeup;
>   
> -	mm_slot = alloc_mm_slot();
> +	mm_slot = mm_slot_alloc(mm_slot_cache);
>   	if (!mm_slot)
>   		return;
>   
> +	slot = &mm_slot->slot;
> +
>   	/* __khugepaged_exit() must not run from under us */
>   	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
>   	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
> -		free_mm_slot(mm_slot);
> +		mm_slot_free(mm_slot_cache, mm_slot);
>   		return;
>   	}
>   
>   	spin_lock(&khugepaged_mm_lock);
> -	insert_to_mm_slots_hash(mm, mm_slot);
> +	mm_slot_insert(mm_slots_hash, mm, slot);
>   	/*
>   	 * Insert just behind the scanning cursor, to let the area settle
>   	 * down a little.
>   	 */
>   	wakeup = list_empty(&khugepaged_scan.mm_head);
> -	list_add_tail(&mm_slot->mm_node, &khugepaged_scan.mm_head);
> +	list_add_tail(&slot->mm_node, &khugepaged_scan.mm_head);
>   	spin_unlock(&khugepaged_mm_lock);
>   
>   	mmgrab(mm);
> @@ -491,21 +462,23 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>   
>   void __khugepaged_exit(struct mm_struct *mm)
>   {
> -	struct mm_slot *mm_slot;
> +	struct khugepaged_mm_slot *mm_slot;
> +	struct mm_slot *slot;
>   	int free = 0;
>   
>   	spin_lock(&khugepaged_mm_lock);
> -	mm_slot = get_mm_slot(mm);
> +	slot = mm_slot_lookup(mm_slots_hash, mm);
> +	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
>   	if (mm_slot && khugepaged_scan.mm_slot != mm_slot) {
> -		hash_del(&mm_slot->hash);
> -		list_del(&mm_slot->mm_node);
> +		hash_del(&slot->hash);
> +		list_del(&slot->mm_node);
>   		free = 1;
>   	}
>   	spin_unlock(&khugepaged_mm_lock);
>   
>   	if (free) {
>   		clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
> -		free_mm_slot(mm_slot);
> +		mm_slot_free(mm_slot_cache, mm_slot);
>   		mmdrop(mm);
>   	} else if (mm_slot) {
>   		/*
> @@ -1321,16 +1294,17 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   	return result;
>   }
>   
> -static void collect_mm_slot(struct mm_slot *mm_slot)
> +static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>   {
> -	struct mm_struct *mm = mm_slot->mm;
> +	struct mm_slot *slot = &mm_slot->slot;
> +	struct mm_struct *mm = slot->mm;
>   
>   	lockdep_assert_held(&khugepaged_mm_lock);
>   
>   	if (hpage_collapse_test_exit(mm)) {
>   		/* free mm_slot */
> -		hash_del(&mm_slot->hash);
> -		list_del(&mm_slot->mm_node);
> +		hash_del(&slot->hash);
> +		list_del(&slot->mm_node);
>   
>   		/*
>   		 * Not strictly needed because the mm exited already.
> @@ -1339,7 +1313,7 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
>   		 */
>   
>   		/* khugepaged_mm_lock actually not necessary for the below */
> -		free_mm_slot(mm_slot);
> +		mm_slot_free(mm_slot_cache, mm_slot);
>   		mmdrop(mm);
>   	}
>   }
> @@ -1352,12 +1326,14 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
>   static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>   					  unsigned long addr)
>   {
> -	struct mm_slot *mm_slot;
> +	struct khugepaged_mm_slot *mm_slot;
> +	struct mm_slot *slot;
>   
>   	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
>   
>   	spin_lock(&khugepaged_mm_lock);
> -	mm_slot = get_mm_slot(mm);
> +	slot = mm_slot_lookup(mm_slots_hash, mm);
> +	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
>   	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
>   		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
>   	spin_unlock(&khugepaged_mm_lock);
> @@ -1489,9 +1465,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>   	goto drop_hpage;
>   }
>   
> -static void khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
> +static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
>   {
> -	struct mm_struct *mm = mm_slot->mm;
> +	struct mm_slot *slot = &mm_slot->slot;
> +	struct mm_struct *mm = slot->mm;
>   	int i;
>   
>   	if (likely(mm_slot->nr_pte_mapped_thp == 0))
> @@ -2054,7 +2031,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   	__acquires(&khugepaged_mm_lock)
>   {
>   	struct vma_iterator vmi;
> -	struct mm_slot *mm_slot;
> +	struct khugepaged_mm_slot *mm_slot;
> +	struct mm_slot *slot;
>   	struct mm_struct *mm;
>   	struct vm_area_struct *vma;
>   	int progress = 0;
> @@ -2064,18 +2042,20 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   	lockdep_assert_held(&khugepaged_mm_lock);
>   	*result = SCAN_FAIL;
>   
> -	if (khugepaged_scan.mm_slot)
> +	if (khugepaged_scan.mm_slot) {
>   		mm_slot = khugepaged_scan.mm_slot;
> -	else {
> -		mm_slot = list_entry(khugepaged_scan.mm_head.next,
> +		slot = &mm_slot->slot;
> +	} else {
> +		slot = list_entry(khugepaged_scan.mm_head.next,
>   				     struct mm_slot, mm_node);
> +		mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
>   		khugepaged_scan.address = 0;
>   		khugepaged_scan.mm_slot = mm_slot;
>   	}
>   	spin_unlock(&khugepaged_mm_lock);
>   	khugepaged_collapse_pte_mapped_thps(mm_slot);
>   
> -	mm = mm_slot->mm;
> +	mm = slot->mm;
>   	/*
>   	 * Don't wait for semaphore (to avoid long wait times).  Just move to
>   	 * the next mm on the list.
> @@ -2171,10 +2151,11 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   		 * khugepaged runs here, khugepaged_exit will find
>   		 * mm_slot not pointing to the exiting mm.
>   		 */
> -		if (mm_slot->mm_node.next != &khugepaged_scan.mm_head) {
> -			khugepaged_scan.mm_slot = list_entry(
> -				mm_slot->mm_node.next,
> -				struct mm_slot, mm_node);
> +		if (slot->mm_node.next != &khugepaged_scan.mm_head) {
> +			slot = list_entry(slot->mm_node.next,
> +					  struct mm_slot, mm_node);
> +			khugepaged_scan.mm_slot =
> +				mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
>   			khugepaged_scan.address = 0;
>   		} else {
>   			khugepaged_scan.mm_slot = NULL;
> @@ -2269,7 +2250,7 @@ static void khugepaged_wait_work(void)
>   
>   static int khugepaged(void *none)
>   {
> -	struct mm_slot *mm_slot;
> +	struct khugepaged_mm_slot *mm_slot;
>   
>   	set_freezable();
>   	set_user_nice(current, MAX_NICE);

-- 
Thanks,
Qi
