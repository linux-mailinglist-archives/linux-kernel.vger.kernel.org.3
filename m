Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81CD59306D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiHOODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbiHOODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:03:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278EE22B33;
        Mon, 15 Aug 2022 07:03:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j1so9212612wrw.1;
        Mon, 15 Aug 2022 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=rIdWbjR9iLmxg37mQgZsn8HHDJIa0JukTHBKfDW93LY=;
        b=CQEb8uN3B4XRu7icbTUFdJ5apRfuBFIPrVHkWz29MXhsGhigT6OR+2OfAKsmq+j/gT
         TdeufqfOGKgM5U92+9qztXhMe5q7y+Z7cGqV25u0F8igHusuTkISHRt8hurSc2VVdm9k
         bO7Hdx0VGuVmWIixPT4Hjxs6g5uSWpybChb11RTYOBbaWy00oPnXEja5Ump/rSuBeYLq
         f3hS8b6V3ai1E1lDBYXdPmyhyNdNXXhRvdyrwQL+L1AAzvLiyNPrCn6VvEZwGCQeUSth
         1X45eqdzkinHRAdic1OJsE4Jy8wDvPJP2yRO2Fvv8Afoe2rggHWu5zociO/riZyNSjK2
         cw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=rIdWbjR9iLmxg37mQgZsn8HHDJIa0JukTHBKfDW93LY=;
        b=FsFAzowH4b/Z04LGwJ1S2ndPj7OINmsZaXCavIMrrwuyk2WfAiIjnc4oXk2uDQh8yt
         VIO8AF1gGaaEk/1dDe/b/rsAJmtWREJDIKUO+X89hqACNIu7OB8N/IoCbVUQt72isUKc
         gkJPkre3hyob6BHyqnapL7derS2dz3tvVRbX8SC7yJbAgDCyMUMWXNwxwlpAKtFdwpCM
         E2ca8W7MAYguWiAKlxzivC/2mQFEW0Yr1Gf6OIb45FU6YS/HR5oybXjFi4iQgWJGEjvu
         B6BMwnqzXzTYuSpE8aRxCBVj3FATaZMaMHSyFGti0JV8LCAJT30nfRmh/m6iddE2YF9r
         Pk3A==
X-Gm-Message-State: ACgBeo2UMttoj6IMdDmDPBKMtILAtUdYO0z7iZafooiStB4p/hO5se0E
        XfM5vmAnP4l9zTtEvMtZeZSlwq6toh1K1CDByMoBopKvqg66TQ==
X-Google-Smtp-Source: AA6agR6z3l14DTUSTKWCpdfFqiQu5me6hGc/3oks8kOBjX1zYFH1mMlu9Zx9Fz9Dk91JfONS0sbJqXr9SXvMyRS0sJ4=
X-Received: by 2002:adf:f74f:0:b0:21e:f321:2700 with SMTP id
 z15-20020adff74f000000b0021ef3212700mr8455037wrp.639.1660572211142; Mon, 15
 Aug 2022 07:03:31 -0700 (PDT)
MIME-Version: 1.0
From:   Jiacheng Xu <578001344xu@gmail.com>
Date:   Mon, 15 Aug 2022 22:03:21 +0800
Message-ID: <CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com>
Subject: KASAN: use-after-free in nilfs_mdt_destroy
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using modified Syzkaller to fuzz the latest Linux kernel, the
following crash
was triggered. The flaw in the fs module can lead to UAF read or DoS.
We would appreciate a CVE ID if this is a security issue.

HEAD commit: 3d7cb6b04c3f Linux-5.19
git tree: upstream
console output:https://drive.google.com/file/d/1PoH9PUdMilsrKtq1oGHu_shM3dggNFAB/view?usp=sharing
kernel config: https://drive.google.com/file/d/1wgIUDwP5ho29AM-K7HhysSTfWFpfXYkG/view?usp=sharing
syz repro: https://drive.google.com/file/d/19N1Xh8TVoSUr_2J8j-bWXktL21SvRx_9/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1R1rYseY7JBDCSfLAP4pjSCoMVgkr7l5b/view?usp=sharing

Description:
In alloc_inode, inode_init_always could return -NOMEM if
security_inode_alloc fails. In its error handling, i_callback and
nilfs_free_inode will be called. However, because inode->i_private is
not initialized due to the failure of security_inode_alloc, the function
nilfs_is_metadata_file_inode can return true and nilfs_mdt_destroy will
be executed to lead to GPF bug.

Someone found the similar problem:
https://groups.google.com/g/syzkaller-bugs/c/z2WroC3_BSw.

Patch:
Fix this bug by moving the assignment of inode->i_private before
security_inode_alloc.
An ad-hoc patch is proposed:
https://patchwork.kernel.org/project/linux-fsdevel/patch/20211011030956.2459172-1-mudongliangabcd@gmail.com/

We have tested the patch under the same configuration and it proves to work.

Environment:
Ubuntu 20.04 on Linux 5.4.0
QEMU 4.2.1:
qemu-system-x86_64 \
  -m 2G \
  -smp 2 \
  -kernel /home/workdir/bzImage \
  -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
  -drive file=/home/workdir/stretch.img,format=raw \
  -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
  -net nic,model=e1000 \
  -enable-kvm \
  -nographic \
  -pidfile vm.pid \
  2>&1 | tee vm.log

If you fix this issue, please add the following tag to the commit:
Credits to Jiacheng Xu<578001344xu@gmail.com>,  Mudong Liang
<mudongliangabcd@gmail.com>

==================================================================
BUG: KASAN: use-after-free in nilfs_mdt_destroy+0x6f/0x80 fs/nilfs2/mdt.c:496
Read of size 8 at addr ffff88810b512098 by task syz-executor/10947

CPU: 2 PID: 10947 Comm: syz-executor Not tainted 5.19.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:

__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:313 [inline]
print_report.cold+0xe5/0x659 mm/kasan/report.c:429
kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
nilfs_mdt_destroy+0x6f/0x80 fs/nilfs2/mdt.c:496
nilfs_free_inode+0x3e/0x60 fs/nilfs2/super.c:168
i_callback+0x3f/0x70 fs/inode.c:249
alloc_inode+0x13e/0x1e0 fs/inode.c:274
iget5_locked fs/inode.c:1238 [inline]
iget5_locked+0x57/0xd0 fs/inode.c:1231
nilfs_iget_locked+0xa0/0xd0 fs/nilfs2/inode.c:588
nilfs_iget+0x7a/0x830 fs/nilfs2/inode.c:597
nilfs_lookup fs/nilfs2/namei.c:63 [inline]
nilfs_lookup+0xfd/0x130 fs/nilfs2/namei.c:54
__lookup_slow+0x255/0x490 fs/namei.c:1701
lookup_slow fs/namei.c:1718 [inline]
walk_component+0x40f/0x6a0 fs/namei.c:2014
lookup_last fs/namei.c:2469 [inline]
path_lookupat.isra.0+0x190/0x580 fs/namei.c:2493
filename_lookup+0x1ca/0x410 fs/namei.c:2522
user_path_at_empty+0x42/0x60 fs/namei.c:2895
user_path_at include/linux/namei.h:57 [inline]
do_fchownat+0xe1/0x1e0 fs/open.c:729
__do_sys_fchownat fs/open.c:750 [inline]
__se_sys_fchownat fs/open.c:747 [inline]
__x64_sys_fchownat+0xba/0x150 fs/open.c:747
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f65d1695dfd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 3d 01
f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f65d28b9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f65d17bc0a0 RCX: 00007f65d1695dfd
RDX: 0000000000000000 RSI: 0000000020002a40 RDI: 0000000000000006
RBP: 00007f65d28b9c90 R08: 0000000000001000 R09: 0000000000000000
R10: 000000000000ee00 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffc5baafa3f R14: 00007ffc5baafbe0 R15: 00007f65d28b9dc0


Allocated by task 10920:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:436 [inline]
____kasan_kmalloc mm/kasan/common.c:515 [inline]
____kasan_kmalloc mm/kasan/common.c:474 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
kasan_kmalloc include/linux/kasan.h:234 [inline]
__kmalloc+0x1c9/0x4c0 mm/slub.c:4446
kmalloc include/linux/slab.h:605 [inline]
kzalloc include/linux/slab.h:733 [inline]
nilfs_mdt_init+0x2c/0x1e0 fs/nilfs2/mdt.c:450
nilfs_cpfile_read+0x11b/0x1f0 fs/nilfs2/cpfile.c:997
nilfs_load_super_root fs/nilfs2/the_nilfs.c:125 [inline]
load_nilfs+0x531/0x13b0 fs/nilfs2/the_nilfs.c:269
nilfs_fill_super fs/nilfs2/super.c:1059 [inline]
nilfs_mount+0xaf5/0x1030 fs/nilfs2/super.c:1317
legacy_get_tree+0x105/0x220 fs/fs_context.c:610
vfs_get_tree+0x89/0x2f0 fs/super.c:1497
do_new_mount fs/namespace.c:3040 [inline]
path_mount+0x1228/0x1cb0 fs/namespace.c:3370
do_mount+0xf3/0x110 fs/namespace.c:3383
__do_sys_mount fs/namespace.c:3591 [inline]
__se_sys_mount fs/namespace.c:3568 [inline]
__x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 34:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:366 [inline]
____kasan_slab_free mm/kasan/common.c:328 [inline]
__kasan_slab_free+0x11d/0x190 mm/kasan/common.c:374
kasan_slab_free include/linux/kasan.h:200 [inline]
slab_free_hook mm/slub.c:1754 [inline]
slab_free_freelist_hook mm/slub.c:1780 [inline]
slab_free mm/slub.c:3536 [inline]
kfree+0xec/0x4b0 mm/slub.c:4584
nilfs_free_inode+0x3e/0x60 fs/nilfs2/super.c:168
i_callback+0x3f/0x70 fs/inode.c:249
rcu_do_batch kernel/rcu/tree.c:2578 [inline]
rcu_core+0x772/0x1710 kernel/rcu/tree.c:2838
__do_softirq+0x1d7/0x93b kernel/softirq.c:571

Last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
kvfree_call_rcu+0x74/0xab0 kernel/rcu/tree.c:3647
drop_sysctl_table+0x2e7/0x3b0 fs/proc/proc_sysctl.c:1716
unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1754
mpls_dev_sysctl_unregister+0x80/0xc0 net/mpls/af_mpls.c:1441
mpls_dev_notify+0x403/0x740 net/mpls/af_mpls.c:1653
notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1930
call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
call_netdevice_notifiers net/core/dev.c:1997 [inline]
unregister_netdevice_many+0x926/0x1570 net/core/dev.c:10843
ip6gre_exit_batch_net+0x49d/0x770 net/ipv6/ip6_gre.c:1633
ops_exit_list.isra.0+0x11b/0x170 net/core/net_namespace.c:167
cleanup_net+0x511/0xa90 net/core/net_namespace.c:594
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88810b512000
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 152 bytes inside of
256-byte region [ffff88810b512000, ffff88810b512100)

The buggy address belongs to the physical page:
page:ffffea00042d4480 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff88810b513200 pfn:0x10b512
head:ffffea00042d4480 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000010200 ffffea0004498480 dead000000000006 ffff888011842b40
raw: ffff88810b513200 000000008010000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 9499, tgid 9497 (syz-executor), ts 146526186398, free_ts
143184644757
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2449 [inline]
prep_new_page+0x297/0x330 mm/page_alloc.c:2456
get_page_from_freelist+0x215f/0x3c50 mm/page_alloc.c:4202
__alloc_pages+0x321/0x710 mm/page_alloc.c:5430
alloc_pages+0x119/0x250 mm/mempolicy.c:2272
alloc_slab_page mm/slub.c:1824 [inline]
allocate_slab mm/slub.c:1969 [inline]
new_slab+0x2a9/0x3f0 mm/slub.c:2029
___slab_alloc+0xd5a/0x1140 mm/slub.c:3031
__slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
slab_alloc_node mm/slub.c:3209 [inline]
slab_alloc mm/slub.c:3251 [inline]
__kmalloc+0x3a9/0x4c0 mm/slub.c:4442
kmalloc include/linux/slab.h:605 [inline]
kzalloc include/linux/slab.h:733 [inline]
new_dir fs/proc/proc_sysctl.c:978 [inline]
get_subdir fs/proc/proc_sysctl.c:1022 [inline]
__register_sysctl_table+0x8a1/0xfc0 fs/proc/proc_sysctl.c:1373
mpls_dev_sysctl_register+0x1b7/0x2d0 net/mpls/af_mpls.c:1421
mpls_add_dev net/mpls/af_mpls.c:1472 [inline]
mpls_dev_notify+0x217/0x740 net/mpls/af_mpls.c:1612
notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1930
call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
call_netdevice_notifiers net/core/dev.c:1997 [inline]
register_netdevice+0xeda/0x12d0 net/core/dev.c:10084
register_netdev+0x2d/0x50 net/core/dev.c:10177
ip6gre_init_net+0x3cd/0x630 net/ipv6/ip6_gre.c:1611
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1371 [inline]
free_pcp_prepare+0x51f/0xd00 mm/page_alloc.c:1421
free_unref_page_prepare mm/page_alloc.c:3343 [inline]
free_unref_page+0x19/0x5b0 mm/page_alloc.c:3438
do_slab_free mm/slub.c:3524 [inline]
___cache_free+0x12c/0x140 mm/slub.c:3543
qlink_free mm/kasan/quarantine.c:168 [inline]
qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
kasan_quarantine_reduce+0x13d/0x180 mm/kasan/quarantine.c:294
__kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
kasan_slab_alloc include/linux/kasan.h:224 [inline]
slab_post_alloc_hook+0x4d/0x4f0 mm/slab.h:750
slab_alloc_node mm/slub.c:3243 [inline]
slab_alloc mm/slub.c:3251 [inline]
__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
kmem_cache_alloc+0x1be/0x460 mm/slub.c:3268
getname_flags fs/namei.c:139 [inline]
getname_flags+0xd2/0x5b0 fs/namei.c:129
vfs_fstatat+0x73/0xb0 fs/stat.c:254
vfs_lstat include/linux/fs.h:3144 [inline]
__do_sys_newlstat+0x8b/0x110 fs/stat.c:411
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
ffff88810b511f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88810b512000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810b512080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88810b512100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88810b512180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Best Regards,
Jiacheng
