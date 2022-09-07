Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417F85B0DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIGUSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIGUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:18:29 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 13:18:26 PDT
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A2ABA2227
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:18:25 -0700 (PDT)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id 979351403C9; Wed,  7 Sep 2022 22:09:06 +0200 (CEST)
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] kernfs: fix use-after-free in __kernfs_remove
Date:   Wed,  7 Sep 2022 22:08:11 +0200
Message-Id: <20220907200811.654034-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concurrent calls to __kernfs_remove can race on the removal
of the root node: The race occurs if the root node(kn) is freed
during kernfs_drain. The child node(pos) is explicitly protected
with an additional ref count. Do the same for the root node.

Found by syzkaller with the following reproducer:

syz_mount_image$ext4(0x0, &(0x7f0000000100)='./file0\x00', 0x100000, 0x0, 0x0, 0x0, 0x0)
r0 = openat(0xffffffffffffff9c, &(0x7f0000000080)='/proc/self/exe\x00', 0x0, 0x0)
close(r0)
pipe2(&(0x7f0000000140)={0xffffffffffffffff, <r1=>0xffffffffffffffff}, 0x800)
mount$9p_fd(0x0, &(0x7f0000000040)='./file0\x00', &(0x7f00000000c0), 0x408, &(0x7f0000000280)={'trans=fd,', {'rfdno', 0x3d, r0}, 0x2c, {'wfdno', 0x3d, r1}, 0x2c, {[{@cache_loose}, {@mmap}, {@loose}, {@loose}, {@mmap}], [{@mask={'mask', 0x3d, '^MAY_EXEC'}}, {@fsmagic={'fsmagic', 0x3d, 0x10001}}, {@dont_hash}]}})

Sample report:

==================================================================
BUG: KASAN: use-after-free in kernfs_type include/linux/kernfs.h:335 [inline]
BUG: KASAN: use-after-free in kernfs_leftmost_descendant fs/kernfs/dir.c:1261 [inline]
BUG: KASAN: use-after-free in __kernfs_remove.part.0+0x843/0x960 fs/kernfs/dir.c:1369
Read of size 2 at addr ffff8880088807f0 by task syz-executor.2/857

CPU: 0 PID: 857 Comm: syz-executor.2 Not tainted 6.0.0-rc3-00363-g7726d4c3e60b #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x6e/0x91 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x5e/0x5e5 mm/kasan/report.c:433
 kasan_report+0xa3/0x130 mm/kasan/report.c:495
 kernfs_type include/linux/kernfs.h:335 [inline]
 kernfs_leftmost_descendant fs/kernfs/dir.c:1261 [inline]
 __kernfs_remove.part.0+0x843/0x960 fs/kernfs/dir.c:1369
 __kernfs_remove fs/kernfs/dir.c:1356 [inline]
 kernfs_remove_by_name_ns+0x108/0x190 fs/kernfs/dir.c:1589
 sysfs_slab_add+0x133/0x1e0 mm/slub.c:5943
 __kmem_cache_create+0x3e0/0x550 mm/slub.c:4899
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x167/0x2a0 mm/slab_common.c:335
 p9_client_create+0xd4d/0x1190 net/9p/client.c:993
 v9fs_session_init+0x1e6/0x13c0 fs/9p/v9fs.c:408
 v9fs_mount+0xb9/0xbd0 fs/9p/vfs_super.c:126
 legacy_get_tree+0xf1/0x200 fs/fs_context.c:610
 vfs_get_tree+0x85/0x2e0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x675/0x1d00 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f725f983aed
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f725f0f7028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f725faa3f80 RCX: 00007f725f983aed
RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007f725f9f419c R08: 0000000020000280 R09: 0000000000000000
R10: 0000000000000408 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000006 R14: 00007f725faa3f80 R15: 00007f725f0d7000
 </TASK>

Allocated by task 855:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0xbf/0x200 mm/slub.c:3268
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __kernfs_new_node+0xd4/0x680 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1010
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x24a/0x8d0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x101/0x160 lib/kobject.c:441
 sysfs_slab_add+0x156/0x1e0 mm/slub.c:5954
 __kmem_cache_create+0x3e0/0x550 mm/slub.c:4899
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x167/0x2a0 mm/slab_common.c:335
 p9_client_create+0xd4d/0x1190 net/9p/client.c:993
 v9fs_session_init+0x1e6/0x13c0 fs/9p/v9fs.c:408
 v9fs_mount+0xb9/0xbd0 fs/9p/vfs_super.c:126
 legacy_get_tree+0xf1/0x200 fs/fs_context.c:610
 vfs_get_tree+0x85/0x2e0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x675/0x1d00 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 857:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free mm/kasan/common.c:329 [inline]
 __kasan_slab_free+0x108/0x190 mm/kasan/common.c:375
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3534 [inline]
 kmem_cache_free+0x9c/0x340 mm/slub.c:3551
 kernfs_put.part.0+0x2b2/0x520 fs/kernfs/dir.c:547
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:521
 __kernfs_remove.part.0+0x72d/0x960 fs/kernfs/dir.c:1407
 __kernfs_remove fs/kernfs/dir.c:1356 [inline]
 kernfs_remove_by_name_ns+0x108/0x190 fs/kernfs/dir.c:1589
 sysfs_slab_add+0x133/0x1e0 mm/slub.c:5943
 __kmem_cache_create+0x3e0/0x550 mm/slub.c:4899
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x167/0x2a0 mm/slab_common.c:335
 p9_client_create+0xd4d/0x1190 net/9p/client.c:993
 v9fs_session_init+0x1e6/0x13c0 fs/9p/v9fs.c:408
 v9fs_mount+0xb9/0xbd0 fs/9p/vfs_super.c:126
 legacy_get_tree+0xf1/0x200 fs/fs_context.c:610
 vfs_get_tree+0x85/0x2e0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x675/0x1d00 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888008880780
 which belongs to the cache kernfs_node_cache of size 128
The buggy address is located 112 bytes inside of
 128-byte region [ffff888008880780, ffff888008880800)

The buggy address belongs to the physical page:
page:00000000732833f8 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8880
flags: 0x100000000000200(slab|node=0|zone=1)
raw: 0100000000000200 0000000000000000 dead000000000122 ffff888001147280
raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888008880680: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888008880700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888008880780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888008880800: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888008880880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 fs/kernfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1cc88ba6de90..66ccf8480592 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1365,6 +1365,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 
 	/* deactivate and unlink the subtree node-by-node */
+	kernfs_get(kn);
 	do {
 		pos = kernfs_leftmost_descendant(kn);
 
@@ -1406,6 +1407,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 		kernfs_put(pos);
 	} while (pos != kn);
+	kernfs_put(kn);
 }
 
 /**
-- 
2.34.1

