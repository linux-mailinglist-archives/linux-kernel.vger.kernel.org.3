Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF15120AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiD0QSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbiD0QPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:15:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C7D5D679
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651075899; x=1682611899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6mndbonHJKPJNKSGuQfPTaJ/YX+zR8rzbWGPWV6w4vE=;
  b=SY6FyymoUBP4XBCIPrnGbaBD6Ce1UKYxwRxRFyDI8jDBun99J9YP6RxO
   6PDnTe/iSV8Z3+ed3ImagTswVuGgaTNrUt+18m7OGpYtgGkOt9Wr1gXh7
   Km9e5atzUKo3vqlKdXHMk3OFl0925u+je3qtmLpS6xmfRgfs2H9KEm/4m
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 09:10:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 09:10:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 09:10:40 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 09:10:39 -0700
Date:   Wed, 27 Apr 2022 12:10:33 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yu Zhao" <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-ID: <20220427161033.GA1935@qian>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:06:19PM +0000, Liam Howlett wrote:
> Andrew,
> 
> Please replace the patches in your mglru-maple branch with this set.  It should
> be a drop in replacement for my patch range with the fixes into these
> patches.  Adding the preallocation to work around the fs-reclaim LOCKDEP
> issue caused enough changes to the patches to warrant a respin.
> 
> The last patch on the branch is still needed to fix vmscan after mglru
> is applied.  ee4b1fc24f30 "mm/vmscan: Use VMA_ITERATOR in
> get_next_vma()"
> 
> 
> Here is the pretty cover letter you requested last time.
> 
> ------------------------------------
> 
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
> 
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to pull
> in the previous and next VMA during many tree alterations.
> 
> This patch set is based on v5.18-rc2
> 
> git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220426
> 
> v8 changes:
>  - Added preallocations before any potential edits to the tree when holding the
> i_mmap_lock to avoid fs-reclaim issues on extreme memory pressure.
>  - Fixed issue in mempolicy mas_for_each() loop.
>  - Moved static definitions inside ifdef for DEBUG_MAPLE
>  - Fixed compile warnings reported by build bots
>  - Moved mas_dfs_preorder() to testing code
>  - Changed __vma_adjust() to record the highest vma in case 6 instead of
> finding it twice.
>  - Fixed locking issue in exit_mmap()
>  - Fixed up from/s-o-b ordering

Running some syscall fuzzer would trigger a crash.

 BUG: KASAN: use-after-free in mas_find
 ma_dead_node at lib/maple_tree.c:532
 (inlined by) mas_next_entry at lib/maple_tree.c:4637
 (inlined by) mas_find at lib/maple_tree.c:5869
 Read of size 8 at addr ffff88811c5e9c00 by task trinity-c0/1351

 CPU: 5 PID: 1351 Comm: trinity-c0 Not tainted 5.18.0-rc4-next-20220427 #3
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-5.fc35 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl
  print_address_description.constprop.0.cold
  print_report.cold
  kasan_report
  mas_find
  apply_mlockall_flags
  __do_sys_munlockall
  do_syscall_64
  entry_SYSCALL_64_after_hwframe
 RIP: 0033:0x7f3105611a3d
 Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 738
 RSP: 002b:00007ffeefae7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000098
 RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3105611a3d
 RDX: 00000000ffff0000 RSI: ffffffffffffafff RDI: 0000009357075a39
 RBP: 00007f3103f94000 R08: 00000000fffffff7 R09: 000000000000006b
 R10: fffffffffffffffd R11: 0000000000000246 R12: 0000000000000098
 R13: 00007f31054f06c0 R14: 00007f3103f94058 R15: 00007f3103f94000
  </TASK>

 Allocated by task 1351:
  kasan_save_stack
  __kasan_slab_alloc
  kmem_cache_alloc_bulk
  mas_alloc_nodes
  mas_preallocate
  __vma_adjust
  __split_vma
  do_mas_align_munmap.constprop.0
  __vm_munmap
  __x64_sys_munmap
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

 Freed by task 1351:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  ____kasan_slab_free
  slab_free_freelist_hook
  kmem_cache_free_bulk.part.0
  mas_destroy
  mas_store_prealloc
  __vma_adjust
  vma_merge
  mlock_fixup
  apply_mlockall_flags
  __do_sys_munlockall
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

 The buggy address belongs to the object at ffff88811c5e9c00
  which belongs to the cache maple_node of size 256
 The buggy address is located 0 bytes inside of
  256-byte region [ffff88811c5e9c00, ffff88811c5e9d00)

 The buggy address belongs to the physical page:
 page:ffffea0004717a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c5e8
 head:ffffea0004717a00 order:2 compound_mapcount:0 compound_pincount:0
 flags: 0x200000000010200(slab|head|node=0|zone=2)
 raw: 0200000000010200 ffffea0004f8da08 ffffea0004676a08 ffff888100050940
 raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88811c5e9b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88811c5e9b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff88811c5e9c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff88811c5e9c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88811c5e9d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================
 Disabling lock debugging due to kernel taint
 general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
 KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
 CPU: 5 PID: 1351 Comm: trinity-c0 Tainted: G    B             5.18.0-rc4-next-20220427 #3
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-5.fc35 04/01/2014
 RIP: 0010:mas_ascend
 Code: cb 18 41 89 d3 48 83 cb 04 41 83 f3 01 40 84 ed 40 0f 95 c7 41 20 fb 74 26 83 ee 01 48 63 f6 48 8d 14 f1 48 89 d6 48 c1 ee 03 <42> 80 3c 3e 00 0f 854
 RSP: 0018:ffffc9000279fc78 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff888106dc3504 RCX: 0000000000000000
 RDX: 0000000000000008 RSI: 0000000000000001 RDI: ffff88811d42e201
 RBP: 0000000000000002 R08: 0000000000000000 R09: ffff88810f723300
 R10: ffffffffffffffff R11: 0000000000000001 R12: ffffc9000279fe78
 R13: 0000000000000000 R14: ffff888106dc3500 R15: dffffc0000000000
 FS:  00007f31054f0740(0000) GS:ffff8882d2e80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f3104db847c CR3: 0000000127e80002 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  mas_next_node
  mas_find
  apply_mlockall_flags
  __do_sys_munlockall
  do_syscall_64
  entry_SYSCALL_64_after_hwframe
 RIP: 0033:0x7f3105611a3d
 Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 738
 RSP: 002b:00007ffeefae7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000098
 RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3105611a3d
 RDX: 00000000ffff0000 RSI: ffffffffffffafff RDI: 0000009357075a39
 RBP: 00007f3103f94000 R08: 00000000fffffff7 R09: 000000000000006b
 R10: fffffffffffffffd R11: 0000000000000246 R12: 0000000000000098
 R13: 00007f31054f06c0 R14: 00007f3103f94058 R15: 00007f3103f94000
  </TASK>
 Modules linked in:
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:mas_ascend
 Code: cb 18 41 89 d3 48 83 cb 04 41 83 f3 01 40 84 ed 40 0f 95 c7 41 20 fb 74 26 83 ee 01 48 63 f6 48 8d 14 f1 48 89 d6 48 c1 ee 03 <42> 80 3c 3e 00 0f 854
 RSP: 0018:ffffc9000279fc78 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff888106dc3504 RCX: 0000000000000000
 RDX: 0000000000000008 RSI: 0000000000000001 RDI: ffff88811d42e201
 RBP: 0000000000000002 R08: 0000000000000000 R09: ffff88810f723300
 R10: ffffffffffffffff R11: 0000000000000001 R12: ffffc9000279fe78
 R13: 0000000000000000 R14: ffff888106dc3500 R15: dffffc0000000000
 FS:  00007f31054f0740(0000) GS:ffff8882d2e80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f3104db847c CR3: 0000000127e80002 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Kernel panic - not syncing: Fatal exception
 Kernel Offset: 0x15400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
