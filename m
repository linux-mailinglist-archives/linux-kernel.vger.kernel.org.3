Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD6D581CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiG0A21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG0A2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:28:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2B3AB20
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9921B818CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6F8C433C1;
        Wed, 27 Jul 2022 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658881698;
        bh=HmcWhABLJ63PalyIIq06ebp1W9f38FOzAhRM1xaQi1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nvh9AD1Noqr+ONuRh0xKOpGC1se4Pl9kEoFKf3hd6xKUxkg/olle7vGPo0RLvgeVM
         WwWYKq9mYJNWZFGjFWtGxH/KkGGG4qfXFCX3DF1kDTGxnXYZA2vw9+SeOJSVsmil9h
         ALgE3BIiLxIaDOwBITOhU3xlOXkLM4xZSQFaf4PALZyNcdKpOVoTKpYHLq9MKW3Xzv
         ZWhJQxAty+5ZaUM9nD8xJuUfR1ouDNgw9TDDbnvW2ywU0HlK3SIV/vwjFcbt7JE8ki
         /7VW5nPGwdYOuHtfmhmIb2tcVq8gnHhR/aW5fOuJrjvxUH2VOGyYbXDV9f5okfEGiR
         9oh/uvmPmZcAQ==
Date:   Tue, 26 Jul 2022 17:28:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Message-ID: <YuCGoB3Ackadj5up@dev-arch.thelio-3990X>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
 <20220720021727.17018-9-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720021727.17018-9-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, Jul 20, 2022 at 02:17:45AM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Start tracking the VMAs with the new maple tree structure in parallel with
> the rb_tree.  Add debug and trace events for maple tree operations and
> duplicate the rb_tree that is created on forks into the maple tree.
> 
> The maple tree is added to the mm_struct including the mm_init struct,
> added support in required mm/mmap functions, added tracking in kernel/fork
> for process forking, and used to find the unmapped_area and checked
> against what the rbtree finds.
> 
> This also moves the mmap_lock() in exit_mmap() since the oom reaper call
> does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> 
> When splitting a vma fails due to allocations of the maple tree nodes,
> the error path in __split_vma() calls new->vm_ops->close(new).  The page
> accounting for hugetlb is actually in the close() operation,  so it
> accounts for the removal of 1/2 of the VMA which was not adjusted.  This
> results in a negative exit value.  To avoid the negative charge, set
> vm_start = vm_end and vm_pgoff = 0.
> 
> There is also a potential accounting issue in special mappings from
> insert_vm_struct() failing to allocate, so reverse the charge there in
> the failure scenario.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-10-Liam.Howlett@oracle.com
> Link: https://lkml.kernel.org/r/20220621204632.3370049-9-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Apologies if this has been reported already, I tried searching the
mailing lists but I did not really find anything.

I bisected my arm64 test system failing to boot to this change as commit
fdfbd22f37db ("mm: start tracking VMAs with maple tree") in
next-20220726 (bisect log at the end).

[    4.295886] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
[    4.306595] Mem abort info:
[    4.309381]   ESR = 0x0000000096000044
[    4.313118]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.318422]   SET = 0, FnV = 0
[    4.321464]   EA = 0, S1PTW = 0
[    4.324592]   FSC = 0x04: level 0 translation fault
[    4.329461] Data abort info:
[    4.332329]   ISV = 0, ISS = 0x00000044
[    4.336152]   CM = 0, WnR = 1
[    4.339110] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a9712000
[    4.345539] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    4.352321] Internal error: Oops: 96000044 [#1] SMP
[    4.357188] Modules linked in:
[    4.360232] CPU: 6 PID: 264 Comm: dracut-rootfs-g Not tainted 5.19.0-rc4-00288-gfdfbd22f37db #1
[    4.368918] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
[    4.376994] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.383943] pc : mas_split.isra.0+0x50c/0x784
[    4.388295] lr : mas_split.isra.0+0x204/0x784
[    4.392640] sp : ffff8000094a3510
[    4.395942] x29: ffff8000094a3510 x28: ffff08dd66c0c000 x27: ffff8000094a3610
[    4.403067] x26: ffff8000094a35d0 x25: ffff8000094a3578 x24: ffffd823cb5448b8
[    4.410192] x23: ffff8000094a3650 x22: ffff8000094a3690 x21: ffff8000094a3738
[    4.417316] x20: 0000000000000002 x19: ffff8000094a3af0 x18: 0000000000000002
[    4.424441] x17: 0000000000000000 x16: ffff08dd66c45450 x15: 0000000000000000
[    4.431565] x14: ffff08dd66c459c8 x13: ffff8000094a3748 x12: 0000000000000001
[    4.438689] x11: ffff8000094a3610 x10: 0000000000000003 x9 : ffff08dd66c47300
[    4.445813] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000000000006
[    4.452937] x5 : ffff08dd68a44409 x4 : 0000000000000001 x3 : ffff8000094a35d0
[    4.460061] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000094a3738
[    4.467186] Call trace:
[    4.469620]  mas_split.isra.0+0x50c/0x784
[    4.473618]  mas_commit_b_node.isra.0+0x1e0/0x274
[    4.478311]  mas_wr_modify+0x10c/0x28c
[    4.482048]  mas_wr_store_entry.isra.0+0x10c/0x4a0
[    4.486827]  mas_store+0x48/0x110
[    4.490131]  dup_mmap+0x268/0x514
[    4.493436]  dup_mm+0x68/0xfc
[    4.496391]  copy_process+0x864/0x10b4
[    4.500129]  kernel_clone+0x88/0x494
[    4.503692]  __do_sys_clone+0x60/0x80
[    4.507342]  __arm64_sys_clone+0x2c/0x40
[    4.511254]  invoke_syscall+0x78/0x100
[    4.514991]  el0_svc_common.constprop.0+0x4c/0xf4
[    4.519683]  do_el0_svc+0x38/0x4c
[    4.522985]  el0_svc+0x34/0x100
[    4.526115]  el0t_64_sync_handler+0x11c/0x150
[    4.530460]  el0t_64_sync+0x190/0x194
[    4.534112] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
[    4.540193] ---[ end trace 0000000000000000 ]---

I was also able to reproduce the same crash in a Fedora virtual machine
using QEMU with Fedora's rawhide configuration [1]:

[    5.913992] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
[    5.914510] Mem abort info:
[    5.914581]   ESR = 0x0000000096000044
[    5.914705]   EC = 0x25: DABT (current EL), IL = 32 bits
[    5.914858]   SET = 0, FnV = 0
[    5.914951]   EA = 0, S1PTW = 0
[    5.915065]   FSC = 0x04: level 0 translation fault
[    5.915215] Data abort info:
[    5.915321]   ISV = 0, ISS = 0x00000044
[    5.915465]   CM = 0, WnR = 1
[    5.915624] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103051000
[    5.915799] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    5.916196] Internal error: Oops: 96000044 [#1] SMP
[    5.916504] Modules linked in:
[    5.916771] CPU: 2 PID: 202 Comm: dracut-rootfs-g Not tainted 5.19.0-rc4+ #1
[    5.917003] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    5.917339] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.917584] pc : mas_split.isra.0+0x50c/0x784
[    5.917794] lr : mas_split.isra.0+0x204/0x784
[    5.917949] sp : ffff8000086334a0
[    5.918038] x29: ffff8000086334a0 x28: ffff5b65c095a258 x27: ffff8000086335a0
[    5.918289] x26: ffff800008633560 x25: ffff800008633508 x24: ffffdb30c80d9778
[    5.918844] x23: ffff8000086335e0 x22: ffff800008633620 x21: ffff8000086336c8
[    5.919277] x20: 0000000000000002 x19: ffff800008633a80 x18: 0000000000000002
[    5.919533] x17: 0000000000000000 x16: ffff5b65c095a4b0 x15: 0000000000000000
[    5.919747] x14: ffff5b65c095a898 x13: ffff8000086336d8 x12: 0000000000000001
[    5.919971] x11: ffff8000086335a0 x10: 0000000000000003 x9 : ffff5b66f42e2a00
[    5.920214] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000000000006
[    5.920493] x5 : ffff5b65c3077309 x4 : 0000000000000001 x3 : ffff800008633560
[    5.920739] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000086336c8
[    5.921051] Call trace:
[    5.921152]  mas_split.isra.0+0x50c/0x784
[    5.921303]  mas_commit_b_node.isra.0+0x1e0/0x274
[    5.921459]  mas_wr_modify+0x10c/0x28c
[    5.921565]  mas_wr_store_entry.isra.0+0x10c/0x4a0
[    5.921725]  mas_store+0x48/0x110
[    5.921864]  dup_mmap+0x268/0x514
[    5.921993]  dup_mm+0x68/0xfc
[    5.922074]  copy_process+0x864/0x10b4
[    5.922213]  kernel_clone+0x88/0x494
[    5.922315]  __do_sys_clone+0x60/0x80
[    5.922444]  __arm64_sys_clone+0x2c/0x40
[    5.922576]  invoke_syscall+0x78/0x100
[    5.922686]  el0_svc_common.constprop.0+0x4c/0xf4
[    5.922847]  do_el0_svc+0x38/0x4c
[    5.922947]  el0_svc+0x34/0x100
[    5.923056]  el0t_64_sync_handler+0x11c/0x150
[    5.923179]  el0t_64_sync+0x190/0x194
[    5.923365] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
[    5.923833] ---[ end trace 0000000000000000 ]---

If there is any additional information I can provide or patches I can
test, please let me know!

Cheers,
Nathan

[1]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config

# bad: [058affafc65a74cf54499fb578b66ad0b18f939b] Add linux-next specific files for 20220726
# good: [e0dccc3b76fb35bb257b4118367a883073d7390e] Linux 5.19-rc8
git bisect start '058affafc65a74cf54499fb578b66ad0b18f939b' 'e0dccc3b76fb35bb257b4118367a883073d7390e'
# good: [e9173a7b08211b52862d61e7cdc8899fc5e6a44d] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect good e9173a7b08211b52862d61e7cdc8899fc5e6a44d
# good: [45dfa9ecc6a971ab9217e41c1e2ea3ee98fd0f70] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect good 45dfa9ecc6a971ab9217e41c1e2ea3ee98fd0f70
# good: [1991de2cb33a921c5a422e749eaba9067b9e8a29] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good 1991de2cb33a921c5a422e749eaba9067b9e8a29
# good: [21a47601220fc0b93b7ab254381b2a3ef1f6d3fe] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git
git bisect good 21a47601220fc0b93b7ab254381b2a3ef1f6d3fe
# bad: [2a210fe818f13dfe3342eb117a4bfeb36aad8215] mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA
git bisect bad 2a210fe818f13dfe3342eb117a4bfeb36aad8215
# good: [43957b5d11037a651d162f65c682ec3c76777fc8] mm/mmap: define DECLARE_VM_GET_PAGE_PROT
git bisect good 43957b5d11037a651d162f65c682ec3c76777fc8
# good: [e3e449def7ea1d17e890408ea01013592e65298b] radix tree test suite: add pr_err define
git bisect good e3e449def7ea1d17e890408ea01013592e65298b
# bad: [c1870dd3ebf1f8a1337f10f2b2ef97e0c1d7e03a] ipc/shm: use VMA iterator instead of linked list
git bisect bad c1870dd3ebf1f8a1337f10f2b2ef97e0c1d7e03a
# bad: [5f9f7cac1a89ff1c7d111dfc7edbcb1b0987000a] mm: use maple tree operations for find_vma_intersection()
git bisect bad 5f9f7cac1a89ff1c7d111dfc7edbcb1b0987000a
# bad: [3b6a687016b08feb5c1b8d9fb78b31dcb314674d] mm/mmap: use maple tree for unmapped_area{_topdown}
git bisect bad 3b6a687016b08feb5c1b8d9fb78b31dcb314674d
# good: [264f03ef6aaca0d56e1c6efed11c93680b8156ac] lib/test_maple_tree: add testing for maple tree
git bisect good 264f03ef6aaca0d56e1c6efed11c93680b8156ac
# bad: [bea49723f45480acf67f46f6fd76bc5cde941e5d] mmap: use the VMA iterator in count_vma_pages_range()
git bisect bad bea49723f45480acf67f46f6fd76bc5cde941e5d
# bad: [423dbb83d4e1b9e894a2309a0035284eb20d9f2b] mm: add VMA iterator
git bisect bad 423dbb83d4e1b9e894a2309a0035284eb20d9f2b
# bad: [fdfbd22f37db37d2db32411d7f48c57bc810366b] mm: start tracking VMAs with maple tree
git bisect bad fdfbd22f37db37d2db32411d7f48c57bc810366b
# first bad commit: [fdfbd22f37db37d2db32411d7f48c57bc810366b] mm: start tracking VMAs with maple tree
