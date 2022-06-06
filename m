Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2F53E61F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiFFMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiFFMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:09:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4D2314C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654517369; x=1686053369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfERSy5MjyQR2r6Hb/MsJx4ZFcEy3ApknClDSObpEz0=;
  b=Qpg5APmj3UfgUdr+NWPA3mvTYusOqDoO8mLR9c3HWjv+dpRrlOMKrI9p
   uEf512CGmMpdPQQflqUjJ7l3jKxzQ9Bl8kTCoSXU2MkS+KwtfhJ1s7Z8X
   GbMjLb1TdfFx98/tW6grRHi+i+qpW/KY3/AJgWjaAcM4mxQZs5UyZRN5T
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 05:09:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 05:09:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 05:09:28 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 05:09:27 -0700
Date:   Mon, 6 Jun 2022 08:09:24 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Message-ID: <Yp3udPy0vuDK8khc@qian>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-13-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220504011345.662299-13-Liam.Howlett@oracle.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:13:53AM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
> do_mas_align_munmap().
> 
> do_munmap() is a wrapper to create a maple state for any callers that have
> not been converted to the maple tree.
> 
> do_mas_munmap() takes a maple state to mumap a range.  This is just a
> small function which checks for error conditions and aligns the end of the
> range.
> 
> do_mas_align_munmap() uses the aligned range to mumap a range.
> do_mas_align_munmap() starts with the first VMA in the range, then finds
> the last VMA in the range.  Both start and end are split if necessary.
> Then the VMAs are removed from the linked list and the mm mlock count is
> updated at the same time.  Followed by a single tree operation of
> overwriting the area in with a NULL.  Finally, the detached list is
> unmapped and freed.
> 
> By reorganizing the munmap calls as outlined, it is now possible to avoid
> extra work of aligning pre-aligned callers which are known to be safe,
> avoid extra VMA lookups or tree walks for modifications.
> 
> detach_vmas_to_be_unmapped() is no longer used, so drop this code.
> 
> vm_brk_flags() can just call the do_mas_munmap() as it checks for
> intersecting VMAs directly.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
...
> +/*
> + * do_mas_align_munmap() - munmap the aligned region from @start to @end.
> + * @mas: The maple_state, ideally set up to alter the correct tree location.
> + * @vma: The starting vm_area_struct
> + * @mm: The mm_struct
> + * @start: The aligned start address to munmap.
> + * @end: The aligned end address to munmap.
> + * @uf: The userfaultfd list_head
> + * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
> + *
> + * If @downgrade is true, check return code for potential release of the lock.
> + */
> +static int
> +do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> +		    struct mm_struct *mm, unsigned long start,
> +		    unsigned long end, struct list_head *uf, bool downgrade)
> +{
> +	struct vm_area_struct *prev, *last;
> +	int error = -ENOMEM;
> +	/* we have start < vma->vm_end  */
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(mas, vma, GFP_KERNEL))
>  		return -ENOMEM;
> -	prev = vma->vm_prev;
> -	/* we have start < vma->vm_end  */
>  
> +	mas->last = end - 1;
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
>  	 *
...
> +/*
> + * do_mas_munmap() - munmap a given range.
> + * @mas: The maple state
> + * @mm: The mm_struct
> + * @start: The start address to munmap
> + * @len: The length of the range to munmap
> + * @uf: The userfaultfd list_head
> + * @downgrade: set to true if the user wants to attempt to write_downgrade the
> + * mmap_sem
> + *
> + * This function takes a @mas that is either pointing to the previous VMA or set
> + * to MA_START and sets it up to remove the mapping(s).  The @len will be
> + * aligned and any arch_unmap work will be preformed.
> + *
> + * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
> + */
> +int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
> +		  unsigned long start, size_t len, struct list_head *uf,
> +		  bool downgrade)
> +{
> +	unsigned long end;
> +	struct vm_area_struct *vma;
> +
> +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> +		return -EINVAL;
> +
> +	end = start + PAGE_ALIGN(len);
> +	if (end == start)
> +		return -EINVAL;
> +
> +	 /* arch_unmap() might do unmaps itself.  */
> +	arch_unmap(mm, start, end);
> +
> +	/* Find the first overlapping VMA */
> +	vma = mas_find(mas, end - 1);
> +	if (!vma)
> +		return 0;
> +
> +	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
> +}
> +
...
> @@ -2845,11 +2908,12 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
>  	int ret;
>  	struct mm_struct *mm = current->mm;
>  	LIST_HEAD(uf);
> +	MA_STATE(mas, &mm->mm_mt, start, start);
>  
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>  
> -	ret = __do_munmap(mm, start, len, &uf, downgrade);
> +	ret = do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
>  	/*
>  	 * Returning 1 indicates mmap_lock is downgraded.
>  	 * But 1 is not legal return value of vm_munmap() and munmap(), reset

Running a syscall fuzzer for a while could trigger those.

 WARNING: CPU: 95 PID: 1329067 at mm/slub.c:3643 kmem_cache_free_bulk
 CPU: 95 PID: 1329067 Comm: trinity-c32 Not tainted 5.18.0-next-20220603 #137
 pstate: 10400009 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : kmem_cache_free_bulk
 lr : mt_destroy_walk
 sp : ffff80005ed66bf0
 x29: ffff80005ed66bf0 x28: ffff401d6c82f050 x27: 0000000000000000
 x26: dfff800000000000 x25: 0000000000000003 x24: 1ffffa97cc5fb120
 x23: ffffd4be62fd8760 x22: ffff401d6c82f050 x21: 0000000000000003
 x20: 0000000000000000 x19: ffff401d6c82f000 x18: ffffd4be66407d1c
 x17: ffff40297ac21f0c x16: 1fffe8016136146b x15: 1fffe806c7d1ad38
 x14: 1fffe8016136145e x13: 0000000000000004 x12: ffff70000bdacd8d
 x11: 1ffff0000bdacd8c x10: ffff70000bdacd8c x9 : ffffd4be60d633c4
 x8 : ffff80005ed66c63 x7 : 0000000000000001 x6 : 0000000000000003
 x5 : ffff80005ed66c60 x4 : 0000000000000000 x3 : ffff400b09b09a80
 x2 : ffff401d6c82f050 x1 : 0000000000000000 x0 : ffff07ff80014a80
 Call trace:
  kmem_cache_free_bulk
  mt_destroy_walk
  mas_wmb_replace
  mas_spanning_rebalance.isra.0
  mas_wr_spanning_store.isra.0
  mas_wr_store_entry.isra.0
  mas_store_prealloc
  do_mas_align_munmap.constprop.0
  do_mas_munmap
  __vm_munmap
  __arm64_sys_munmap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 irq event stamp: 665580
 hardirqs last  enabled at (665579):  kasan_quarantine_put
 hardirqs last disabled at (665580):  el1_dbg
 softirqs last  enabled at (664048):  __do_softirq
 softirqs last disabled at (663831):  __irq_exit_rcu


 BUG: KASAN: double-free or invalid-free in kmem_cache_free_bulk

 CPU: 95 PID: 1329067 Comm: trinity-c32 Tainted: G        W         5.18.0-next-20220603 #137
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  print_report
  kasan_report_invalid_free
  ____kasan_slab_free
  __kasan_slab_free
  slab_free_freelist_hook
  kmem_cache_free_bulk
  mas_destroy
  mas_store_prealloc
  do_mas_align_munmap.constprop.0
  do_mas_munmap
  __vm_munmap
  __arm64_sys_munmap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Allocated by task 1329067:
  kasan_save_stack
  __kasan_slab_alloc
  slab_post_alloc_hook
  kmem_cache_alloc_bulk
  mas_alloc_nodes
  mas_preallocate
  __vma_adjust
  vma_merge
  mprotect_fixup
  do_mprotect_pkey.constprop.0
  __arm64_sys_mprotect
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Freed by task 1329067:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  ____kasan_slab_free
  __kasan_slab_free
  slab_free_freelist_hook
  kmem_cache_free
  mt_destroy_walk
  mas_wmb_replace
  mas_spanning_rebalance.isra.0
  mas_wr_spanning_store.isra.0
  mas_wr_store_entry.isra.0
  mas_store_prealloc
  do_mas_align_munmap.constprop.0
  do_mas_munmap
  __vm_munmap
  __arm64_sys_munmap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 The buggy address belongs to the object at ffff401d6c82f000
                which belongs to the cache maple_node of size 256
 The buggy address is located 0 bytes inside of
                256-byte region [ffff401d6c82f000, ffff401d6c82f100)

 The buggy address belongs to the physical page:
 page:fffffd0075b20a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x401dec828
 head:fffffd0075b20a00 order:3 compound_mapcount:0 compound_pincount:0
 flags: 0x1bfffc0000010200(slab|head|node=1|zone=2|lastcpupid=0xffff)
 raw: 1bfffc0000010200 fffffd00065b2a08 fffffd0006474408 ffff07ff80014a80
 raw: 0000000000000000 00000000002a002a 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected
 page_owner tracks the page as allocated
 page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 185514, tgid 185514 (trinity-c15), ts 9791681605400, free_ts 9785882037080
  post_alloc_hook
  get_page_from_freelist
  __alloc_pages
  alloc_pages
  allocate_slab
  new_slab
  ___slab_alloc
  __slab_alloc.constprop.0
  kmem_cache_alloc
  mas_alloc_nodes
  mas_preallocate
  __vma_adjust
  vma_merge
  mlock_fixup
  apply_mlockall_flags
  __arm64_sys_munlockall
 page last free stack trace:
  free_pcp_prepare
  free_unref_page
  __free_pages
  __free_slab
  discard_slab
  __slab_free
  ___cache_free
  qlist_free_all
  kasan_quarantine_reduce
  __kasan_slab_alloc
  __kmalloc_node
  kvmalloc_node
  __slab_free
  ___cache_free
  qlist_free_all
  kasan_quarantine_reduce
  __kasan_slab_alloc
  __kmalloc_node
  kvmalloc_node
  proc_sys_call_handler
  proc_sys_read
  new_sync_read
  vfs_read

 Memory state around the buggy address:
  ffff401d6c82ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff401d6c82ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff401d6c82f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff401d6c82f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff401d6c82f100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
