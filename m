Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9001949C3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiAZGpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiAZGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:45:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5C8C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:45:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k17so4005435plk.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=V3Qtmx4ujZL+JpPAka/e9U58tDRKWOh92HiNAvxHwuw=;
        b=dhIU0VkSMcr4Td30irV9b0ctsu0ojbYIUKIgLt8ii7BbHEno7LDg3720G08J5MhY6W
         WVMgCPXLXgiZmlt0Hue5m9rRk+Yzkc/KhDMR1ul5z9l9lEKq8AAYwve19GfWVOyyBN7V
         pH3OoGW/j1HDqGHCwMXcFRVfdGDli4awMXpQTTzttk4Bs6fS/CejDpDIvbABcub3oNDn
         ERBKPmwVTqijxmwqq3IHOWXjHP7OHKG9mX563J1fpZgSIxc2ZVR2ya31qrPPvnR1sMAd
         Ikx33jfGYn7QdnKb9ze0rWSfJRSW1vSrIFyt+614UJKGV665irKdczkbEWjd4Ho0LZZ5
         Deeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=V3Qtmx4ujZL+JpPAka/e9U58tDRKWOh92HiNAvxHwuw=;
        b=mIQXS05tFpeNEudTWuLfBq9I61+W8AtTQZPSM4YZFD3/H7KX9eteqXYoOXPAZUcyOz
         45IK28aGLRpwdNO4bPsbqDvyzdsJuMcXq8vfoX8KdjXdZzWHecln/eKwapXGEV/9KSxa
         YIN1Cc7IRaBX6Qf7yPo0Xx8YGCm9VHhH/VeULNYvomMZxXzHHL1LBkUtPbkVIMCXQqAV
         t+PQv/VHFya+W8Xz5SICzvj026imEX7r9qsuc4wSEr80djibpZyGLBTbKkQH5HMvuIxE
         6O08yws4bxJxy/8J9Spul+c6Aoubi3iXrMXOQU67m2c6jefCDJsfaV60BujT+XTu3/2U
         oqRQ==
X-Gm-Message-State: AOAM5308V9Fu2em6BNx8MdP8Il/ngBpMqetGk2rgDnsMRHSRGZKDOo2M
        IjKnaUik0b9oLyCZ5+NwW76slw==
X-Google-Smtp-Source: ABdhPJx0W2FgEW0j/+jwyjhJtdqORIn5VcGH+JN/kcXeUCPJ/j2EvDaH8U25EpN1vvcPFUZjlCrb7Q==
X-Received: by 2002:a17:902:ab8d:b0:14a:98aa:b87 with SMTP id f13-20020a170902ab8d00b0014a98aa0b87mr22277655plr.100.1643179510089;
        Tue, 25 Jan 2022 22:45:10 -0800 (PST)
Received: from [2620:15c:29:204:6f7a:fc02:d37c:a8b0] ([2620:15c:29:204:6f7a:fc02:d37c:a8b0])
        by smtp.gmail.com with ESMTPSA id j6sm1053571pfu.18.2022.01.25.22.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:45:09 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:45:08 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, will@kernel.org,
        rppt@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v3 4/4] mm/page_table_check: check entries at pmd
 levels
In-Reply-To: <20220126060514.1574935-5-pasha.tatashin@soleen.com>
Message-ID: <61833f93-31b5-206f-b8c7-a2e55091ac@google.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com> <20220126060514.1574935-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Pasha Tatashin wrote:

> syzbot detected a case where the page table counters were not properly
> updated.
> 

Is there a Reported-by tag that syzbot wants us to use to track this?

> syzkaller login:  ------------[ cut here ]------------
> kernel BUG at mm/page_table_check.c:162!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3099 Comm: pasha Not tainted 5.16.0+ #48
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO4
> RIP: 0010:__page_table_check_zero+0x159/0x1a0
> Code: 7d 3a b2 ff 45 39 f5 74 2a e8 43 38 b2 ff 4d 85 e4 01
> RSP: 0018:ffff888010667418 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000
> RDX: ffff88800cea8680 RSI: ffffffff81becaf9 RDI: 0000000003
> RBP: ffff888010667450 R08: 0000000000000001 R09: 0000000000
> R10: ffffffff81becaab R11: 0000000000000001 R12: ffff888008
> R13: 0000000000000001 R14: 0000000000000200 R15: dffffc0000
> FS:  0000000000000000(0000) GS:ffff888035e00000(0000) knlG0
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd875cad00 CR3: 00000000094ce000 CR4: 0000000000
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000
> Call Trace:
>  <TASK>
>  free_pcp_prepare+0x3be/0xaa0
>  free_unref_page+0x1c/0x650
>  ? trace_hardirqs_on+0x6a/0x1d0
>  free_compound_page+0xec/0x130
>  free_transhuge_page+0x1be/0x260
>  __put_compound_page+0x90/0xd0
>  release_pages+0x54c/0x1060
>  ? filemap_remove_folio+0x161/0x210
>  ? lock_downgrade+0x720/0x720
>  ? __put_page+0x150/0x150
>  ? filemap_free_folio+0x164/0x350
>  __pagevec_release+0x7c/0x110
>  shmem_undo_range+0x85e/0x1250
> ...
> 
> The repro involved having a huge page that is split due to uprobe event
> temporarily replacing one of the pages in the huge page. Later the huge
> page was combined again, but the counters were off, as the PTE level
> was not properly updated.
> 
> Make sure that when PMD is cleared and prior to freeing the level the
> PTEs are updated.
> 
> Fixes: df4e817b7108 ("mm: page table check")
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/page_table_check.h | 18 ++++++++++++++++++
>  mm/khugepaged.c                  |  2 ++
>  mm/page_table_check.c            | 21 +++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 38cace1da7b6..e88bbe37727b 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -26,6 +26,8 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>  				pmd_t *pmdp, pmd_t pmd);
>  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>  				pud_t *pudp, pud_t pud);
> +void __page_table_check_pmd_clear_full(struct mm_struct *mm, unsigned long addr,
> +				       pmd_t pmd);
>  
>  static inline void page_table_check_alloc(struct page *page, unsigned int order)
>  {
> @@ -100,6 +102,16 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
>  	__page_table_check_pud_set(mm, addr, pudp, pud);
>  }
>  
> +static inline void page_table_check_pmd_clear_full(struct mm_struct *mm,
> +						   unsigned long addr,
> +						   pmd_t pmd)
> +{
> +	if (static_branch_likely(&page_table_check_disabled))
> +		return;
> +
> +	__page_table_check_pmd_clear_full(mm, addr, pmd);
> +}
> +
>  #else
>  
>  static inline void page_table_check_alloc(struct page *page, unsigned int order)
> @@ -143,5 +155,11 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
>  {
>  }
>  
> +static inline void page_table_check_pmd_clear_full(struct mm_struct *mm,
> +						   unsigned long addr,
> +						   pmd_t pmd)
> +{
> +}
> +
>  #endif /* CONFIG_PAGE_TABLE_CHECK */
>  #endif /* __LINUX_PAGE_TABLE_CHECK_H */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 440112355ffe..eefe3706f6c2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -16,6 +16,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_idle.h>
> +#include <linux/page_table_check.h>
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  
> @@ -1424,6 +1425,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>  
>  	spin_unlock(ptl);
>  	mm_dec_nr_ptes(mm);
> +	page_table_check_pmd_clear_full(mm, addr, pmd);
>  	pte_free(mm, pmd_pgtable(pmd));
>  }

This looks right, I'm wondering if we want to add a 
mmap_assert_write_locked(mm) to collapse_and_free_pmd().

>  
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index c61d7ebe13b1..251f95a808b4 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -247,3 +247,24 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>  	}
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_set);
> +
> +void __page_table_check_pmd_clear_full(struct mm_struct *mm, unsigned long addr,
> +				       pmd_t pmd)
> +{
> +	if (&init_mm == mm)
> +		return;
> +
> +	if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
> +		pte_t *ptep = pte_offset_map(&pmd, addr);
> +		unsigned long i;
> +
> +		pte_unmap(ptep);
> +		for (i = 0; i < PTRS_PER_PTE; i++) {
> +			__page_table_check_pte_clear(mm, addr, *ptep);
> +			addr += PAGE_SIZE;
> +			ptep++;
> +		}
> +	} else {
> +		__page_table_check_pmd_clear(mm, addr, pmd);
> +	}
> +}
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
