Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936B585419
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiG2RC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiG2RCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:02:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DE5C36F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB056B828AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 17:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C4C433D6;
        Fri, 29 Jul 2022 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659114169;
        bh=Tl2w6ezhxqEfZ08m6toyzyegvx3ZoQ+ZmZAV+r9RujI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIdFiTLRE5h7QakI+nEDT4oVRYMO3LxHW5w1mPeaZbyQu/dgN+3Em4ZXLFxH0YxCt
         sUHvDfK7Cp8T/jYcvQVGO4hHXR29k3LURgdo5uR8djw9sb4tT5vRIcxiWZxIIfK0sG
         qCO0YvKPmioc+BfxNjpbeuTq8IAFmOjSKjwQQuhom8YUmD786PJe0V1VDcbv3AaW4J
         M1a6RT8afnqdnvU4c9LziuU9ubgQCiYjbehB7ibVfhRKMSvcvHiyaeX01ToHTlYUzb
         5plZBoI46I3xs4nGD2G3EDfI44K6c/0M51j8BHcfB8K2NRmPEqIzW1Vi8LOrvgwmFr
         8LMTl45lCU9UA==
Date:   Fri, 29 Jul 2022 10:02:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Message-ID: <YuQStyjaHfPeZ/6I@dev-arch.thelio-3990X>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
 <20220720021727.17018-9-Liam.Howlett@oracle.com>
 <YuCGoB3Ackadj5up@dev-arch.thelio-3990X>
 <20220728003401.7fmppx5kbfqmzyjb@revolver>
 <20220729154135.zz6use7o25dz4uhm@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729154135.zz6use7o25dz4uhm@revolver>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 03:41:44PM +0000, Liam Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220727 20:34]:
> > * Nathan Chancellor <nathan@kernel.org> [220726 20:28]:
> > > Hi Liam,
> > > 
> > > On Wed, Jul 20, 2022 at 02:17:45AM +0000, Liam Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > > 
> > > > Start tracking the VMAs with the new maple tree structure in parallel with
> > > > the rb_tree.  Add debug and trace events for maple tree operations and
> > > > duplicate the rb_tree that is created on forks into the maple tree.
> > > > 
> > > > The maple tree is added to the mm_struct including the mm_init struct,
> > > > added support in required mm/mmap functions, added tracking in kernel/fork
> > > > for process forking, and used to find the unmapped_area and checked
> > > > against what the rbtree finds.
> > > > 
> > > > This also moves the mmap_lock() in exit_mmap() since the oom reaper call
> > > > does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> > > > 
> > > > When splitting a vma fails due to allocations of the maple tree nodes,
> > > > the error path in __split_vma() calls new->vm_ops->close(new).  The page
> > > > accounting for hugetlb is actually in the close() operation,  so it
> > > > accounts for the removal of 1/2 of the VMA which was not adjusted.  This
> > > > results in a negative exit value.  To avoid the negative charge, set
> > > > vm_start = vm_end and vm_pgoff = 0.
> > > > 
> > > > There is also a potential accounting issue in special mappings from
> > > > insert_vm_struct() failing to allocate, so reverse the charge there in
> > > > the failure scenario.
> > > > 
> > > > Link: https://lkml.kernel.org/r/20220504010716.661115-10-Liam.Howlett@oracle.com
> > > > Link: https://lkml.kernel.org/r/20220621204632.3370049-9-Liam.Howlett@oracle.com
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: David Howells <dhowells@redhat.com>
> > > > Cc: SeongJae Park <sj@kernel.org>
> > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > Apologies if this has been reported already, I tried searching the
> > > mailing lists but I did not really find anything.
> > > 
> > > I bisected my arm64 test system failing to boot to this change as commit
> > > fdfbd22f37db ("mm: start tracking VMAs with maple tree") in
> > > next-20220726 (bisect log at the end).
> > > 
> > > [    4.295886] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
> > > [    4.306595] Mem abort info:
> > > [    4.309381]   ESR = 0x0000000096000044
> > > [    4.313118]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [    4.318422]   SET = 0, FnV = 0
> > > [    4.321464]   EA = 0, S1PTW = 0
> > > [    4.324592]   FSC = 0x04: level 0 translation fault
> > > [    4.329461] Data abort info:
> > > [    4.332329]   ISV = 0, ISS = 0x00000044
> > > [    4.336152]   CM = 0, WnR = 1
> > > [    4.339110] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a9712000
> > > [    4.345539] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> > > [    4.352321] Internal error: Oops: 96000044 [#1] SMP
> > > [    4.357188] Modules linked in:
> > > [    4.360232] CPU: 6 PID: 264 Comm: dracut-rootfs-g Not tainted 5.19.0-rc4-00288-gfdfbd22f37db #1
> > > [    4.368918] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
> > > [    4.376994] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    4.383943] pc : mas_split.isra.0+0x50c/0x784
> > > [    4.388295] lr : mas_split.isra.0+0x204/0x784
> > > [    4.392640] sp : ffff8000094a3510
> > > [    4.395942] x29: ffff8000094a3510 x28: ffff08dd66c0c000 x27: ffff8000094a3610
> > > [    4.403067] x26: ffff8000094a35d0 x25: ffff8000094a3578 x24: ffffd823cb5448b8
> > > [    4.410192] x23: ffff8000094a3650 x22: ffff8000094a3690 x21: ffff8000094a3738
> > > [    4.417316] x20: 0000000000000002 x19: ffff8000094a3af0 x18: 0000000000000002
> > > [    4.424441] x17: 0000000000000000 x16: ffff08dd66c45450 x15: 0000000000000000
> > > [    4.431565] x14: ffff08dd66c459c8 x13: ffff8000094a3748 x12: 0000000000000001
> > > [    4.438689] x11: ffff8000094a3610 x10: 0000000000000003 x9 : ffff08dd66c47300
> > > [    4.445813] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000000000006
> > > [    4.452937] x5 : ffff08dd68a44409 x4 : 0000000000000001 x3 : ffff8000094a35d0
> > > [    4.460061] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000094a3738
> > > [    4.467186] Call trace:
> > > [    4.469620]  mas_split.isra.0+0x50c/0x784
> > > [    4.473618]  mas_commit_b_node.isra.0+0x1e0/0x274
> > > [    4.478311]  mas_wr_modify+0x10c/0x28c
> > > [    4.482048]  mas_wr_store_entry.isra.0+0x10c/0x4a0
> > > [    4.486827]  mas_store+0x48/0x110
> > > [    4.490131]  dup_mmap+0x268/0x514
> > > [    4.493436]  dup_mm+0x68/0xfc
> > > [    4.496391]  copy_process+0x864/0x10b4
> > > [    4.500129]  kernel_clone+0x88/0x494
> > > [    4.503692]  __do_sys_clone+0x60/0x80
> > > [    4.507342]  __arm64_sys_clone+0x2c/0x40
> > > [    4.511254]  invoke_syscall+0x78/0x100
> > > [    4.514991]  el0_svc_common.constprop.0+0x4c/0xf4
> > > [    4.519683]  do_el0_svc+0x38/0x4c
> > > [    4.522985]  el0_svc+0x34/0x100
> > > [    4.526115]  el0t_64_sync_handler+0x11c/0x150
> > > [    4.530460]  el0t_64_sync+0x190/0x194
> > > [    4.534112] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
> > > [    4.540193] ---[ end trace 0000000000000000 ]---
> > > 
> > > I was also able to reproduce the same crash in a Fedora virtual machine
> > > using QEMU with Fedora's rawhide configuration [1]:
> > > 
> > > [    5.913992] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
> > > [    5.914510] Mem abort info:
> > > [    5.914581]   ESR = 0x0000000096000044
> > > [    5.914705]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [    5.914858]   SET = 0, FnV = 0
> > > [    5.914951]   EA = 0, S1PTW = 0
> > > [    5.915065]   FSC = 0x04: level 0 translation fault
> > > [    5.915215] Data abort info:
> > > [    5.915321]   ISV = 0, ISS = 0x00000044
> > > [    5.915465]   CM = 0, WnR = 1
> > > [    5.915624] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103051000
> > > [    5.915799] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> > > [    5.916196] Internal error: Oops: 96000044 [#1] SMP
> > > [    5.916504] Modules linked in:
> > > [    5.916771] CPU: 2 PID: 202 Comm: dracut-rootfs-g Not tainted 5.19.0-rc4+ #1
> > > [    5.917003] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> > > [    5.917339] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    5.917584] pc : mas_split.isra.0+0x50c/0x784
> > > [    5.917794] lr : mas_split.isra.0+0x204/0x784
> > > [    5.917949] sp : ffff8000086334a0
> > > [    5.918038] x29: ffff8000086334a0 x28: ffff5b65c095a258 x27: ffff8000086335a0
> > > [    5.918289] x26: ffff800008633560 x25: ffff800008633508 x24: ffffdb30c80d9778
> > > [    5.918844] x23: ffff8000086335e0 x22: ffff800008633620 x21: ffff8000086336c8
> > > [    5.919277] x20: 0000000000000002 x19: ffff800008633a80 x18: 0000000000000002
> > > [    5.919533] x17: 0000000000000000 x16: ffff5b65c095a4b0 x15: 0000000000000000
> > > [    5.919747] x14: ffff5b65c095a898 x13: ffff8000086336d8 x12: 0000000000000001
> > > [    5.919971] x11: ffff8000086335a0 x10: 0000000000000003 x9 : ffff5b66f42e2a00
> > > [    5.920214] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000000000006
> > > [    5.920493] x5 : ffff5b65c3077309 x4 : 0000000000000001 x3 : ffff800008633560
> > > [    5.920739] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000086336c8
> > > [    5.921051] Call trace:
> > > [    5.921152]  mas_split.isra.0+0x50c/0x784
> > > [    5.921303]  mas_commit_b_node.isra.0+0x1e0/0x274
> > > [    5.921459]  mas_wr_modify+0x10c/0x28c
> > > [    5.921565]  mas_wr_store_entry.isra.0+0x10c/0x4a0
> > > [    5.921725]  mas_store+0x48/0x110
> > > [    5.921864]  dup_mmap+0x268/0x514
> > > [    5.921993]  dup_mm+0x68/0xfc
> > > [    5.922074]  copy_process+0x864/0x10b4
> > > [    5.922213]  kernel_clone+0x88/0x494
> > > [    5.922315]  __do_sys_clone+0x60/0x80
> > > [    5.922444]  __arm64_sys_clone+0x2c/0x40
> > > [    5.922576]  invoke_syscall+0x78/0x100
> > > [    5.922686]  el0_svc_common.constprop.0+0x4c/0xf4
> > > [    5.922847]  do_el0_svc+0x38/0x4c
> > > [    5.922947]  el0_svc+0x34/0x100
> > > [    5.923056]  el0t_64_sync_handler+0x11c/0x150
> > > [    5.923179]  el0t_64_sync+0x190/0x194
> > > [    5.923365] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
> > > [    5.923833] ---[ end trace 0000000000000000 ]---
> > > 
> > > If there is any additional information I can provide or patches I can
> > > test, please let me know!
> > > 
> > 
> > Hello Nathan,
> > 
> > Thanks for testing this and your report.  You are the first and only
> > report of this failure so I very much appreciate it.
> > 
> > I run a number of tests on arm64 so I will have to try your kernel
> > config.  Thanks for including the link.
> 
> Nathan,
> 
> I am having a hard time reproducing this bug.  I had to modify the
> config you pointed me towards with the addition of virtio block device
> support.  I tried the next tag you had the issue with along with my most
> recent patches and neither produced the crash.  Although I was not able
> to reproduce the crash, I suspect it was to do with insufficient number
> of allocated nodes at fork time.  I've been running stress-ng with fork
> & clone in qemu but so far no luck reproducing it.

Sorry about that :( That is odd since my VM appears to be using virtio
block devices?

$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
zram0  252:0    0  7.7G  0 disk [SWAP]
vda    253:0    0   50G  0 disk
├─vda1 253:1    0  600M  0 part /boot/efi
├─vda2 253:2    0    1G  0 part /boot
└─vda3 253:3    0 48.4G  0 part /

> Can you decode the line number of mas_split.isra.0+0x50c/0x784 ?

Sure thing! Here is the entire stacktrace passed through
scripts/decode_stacktrace.sh, this was done at commit fdfbd22f37db ("mm:
start tracking VMAs with maple tree"):

[    7.473069] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    7.473377] Mem abort info:
[    7.473460]   ESR = 0x0000000096000044
[    7.473595]   EC = 0x25: DABT (current EL), IL = 32 bits
[    7.473765]   SET = 0, FnV = 0
[    7.473867]   EA = 0, S1PTW = 0
[    7.473963]   FSC = 0x04: level 0 translation fault
[    7.474238] Data abort info:
[    7.474394]   ISV = 0, ISS = 0x00000044
[    7.474574]   CM = 0, WnR = 1
[    7.474737] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000234857000
[    7.474895] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    7.475717] Internal error: Oops: 96000044 [#1] SMP
[    7.476094] Modules linked in:
[    7.476450] CPU: 0 PID: 206 Comm: dracut-rootfs-g Not tainted 5.19.0-rc4+ #1
[    7.476788] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    7.477085] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.477379] pc : mas_split.isra.0 (lib/maple_tree.c:3303 lib/maple_tree.c:3512) 
[    7.477941] lr : mas_split.isra.0 (lib/maple_tree.c:3543) 
[    7.478136] sp : ffff8000089ab420
[    7.478269] x29: ffff8000089ab420 x28: ffff0001f4868c80 x27: ffff8000089ab520
[    7.478620] x26: ffff8000089ab4e0 x25: ffff8000089ab488 x24: ffffd28653819778
[    7.478884] x23: ffff8000089ab560 x22: ffff8000089ab5a0 x21: ffff8000089ab648
[    7.479122] x20: 0000000000000002 x19: ffff8000089aba00 x18: 0000000000000002
[    7.479354] x17: 0000000000000000 x16: ffff0001f485a258 x15: 0000000000000000
[    7.479662] x14: ffff0001f485aed8 x13: ffff8000089ab658 x12: 0000000000000001
[    7.479926] x11: ffff8000089ab520 x10: 0000000000000003 x9 : ffff0001f4bb5d00
[    7.480240] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000000000006
[    7.480638] x5 : ffff0001f4a7e789 x4 : 0000000000000001 x3 : ffff8000089ab4e0
[    7.480911] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000089ab648
[    7.481254] Call trace:
[    7.481364] mas_split.isra.0 (lib/maple_tree.c:3303 lib/maple_tree.c:3512) 
[    7.481580] mas_commit_b_node.isra.0 (lib/maple_tree.c:3618) 
[    7.481734] mas_wr_modify (lib/maple_tree.c:4356) 
[    7.481886] mas_wr_store_entry.isra.0 (lib/maple_tree.c:4396) 
[    7.482096] mas_store (lib/maple_tree.c:5651) 
[    7.482265] dup_mmap (kernel/fork.c:707) 
[    7.482410] dup_mm (kernel/fork.c:1539) 
[    7.482554] copy_process (kernel/fork.c:1591 kernel/fork.c:2254) 
[    7.482718] kernel_clone (kernel/fork.c:2669) 
[    7.482878] __do_sys_clone (kernel/fork.c:2804) 
[    7.483072] __arm64_sys_clone (kernel/fork.c:2771) 
[    7.483201] invoke_syscall (./arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:57) 
[    7.483361] el0_svc_common.constprop.0 (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/syscall.c:150) 
[    7.483518] do_el0_svc (arch/arm64/kernel/syscall.c:207) 
[    7.483651] el0_svc (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:142 arch/arm64/kernel/entry-common.c:625) 
[    7.483767] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:643) 
[    7.483918] el0t_64_sync (arch/arm64/kernel/entry.S:581) 
[ 7.484294] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
All code
========
   0:	f9000125 	.word	0xf9000125
   4:	f9400e65 	.word	0xf9400e65
   8:	9278dca5 	.word	0x9278dca5
   c:	f94000a5 	.word	0xf94000a5
  10:*	f9000045 	.word	0xf9000045		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	f9000045 	.word	0xf9000045
[    7.484865] ---[ end trace 0000000000000000 ]---

> Could you test git tag howlett/maple/20220728 from
> http://git.infradead.org/users/jedix/linux-maple.git and see if this
> issue still triggers?

That tag appears to be okay, so this bug was one you already fixed that
manifested in a different way?

Cheers,
Nathan
