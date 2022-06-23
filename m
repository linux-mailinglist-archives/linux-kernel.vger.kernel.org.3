Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960BA557E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiFWOsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiFWOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:48:09 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435132559D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:48:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id w7-20020a056e021c8700b002d3bc8e95cbso13105170ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uinq6G6C0J3E1rT5kcG3fwVQ52O0T/aDKHJIlbQ9G7g=;
        b=lhZKmf9CSNSQxchgzlWqm+fKPyS5o+IGcKBedsHgR8ln5uyy8qHqYfxkiLy+Goka3A
         WVtHdKfR1Yj8PDIR5O69IJNJ3MyQY6GTlaAlGjZ7KZr2XAEj+91EY7OcUQ6Lk6nJVtyI
         nNY3AUfvWX2hf4HOWIIsbSF9yGDXfu3MSXFH12fHd495syarWhvhPpH1Sg0br+FJH7wC
         ANqFXjwPM0fApV1LFp1JWn3lhRTbe7oP3jmfUYnfhvZ2lX+BqkzK4b1I/wp/n1I0U7Sq
         KpY5ZRj32U1lUxtBUyWzVLkZl2FDTlJrO/mFrJToV0vPG3hs/G5lTsnZfmXx4olKU6D6
         GE9g==
X-Gm-Message-State: AJIora9LxeJXdbnogXBjXt4fg1tJjLz7Li9E0jIvm4sGK9i9gs/Y8va6
        6kibEcuW49OP+f0F6aInCdr894Yv/3FUKolojkGVZrXg1jdd
X-Google-Smtp-Source: AGRyM1uRaPhsm/vL/HLo+fqe/jiGJeOXquugf9kZkCSWjknoLnF8shonICxKHCDbdHxTux1j+ALQwbLwOJICMvdj5arn+7jyh0lQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13d0:b0:2d9:4396:66ff with SMTP id
 v16-20020a056e0213d000b002d9439666ffmr5034615ilj.224.1655995687646; Thu, 23
 Jun 2022 07:48:07 -0700 (PDT)
Date:   Thu, 23 Jun 2022 07:48:07 -0700
In-Reply-To: <20220623122120.622-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b63c1a05e21e8a40@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in free_netdev (3)
From:   syzbot <syzbot+b75c138e9286ac742647@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in free_netdev

netlink: 20 bytes leftover after parsing attributes in process `syz-executor.0'.
==================================================================
BUG: KASAN: use-after-free in free_netdev+0x58c/0x620 net/core/dev.c:10704
Read of size 8 at addr ffff88807ad6e738 by task syz-executor.0/4086

CPU: 0 PID: 4086 Comm: syz-executor.0 Not tainted 5.19.0-rc2-syzkaller-00103-gb4a028c4d031-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 free_netdev+0x58c/0x620 net/core/dev.c:10704
 netdev_run_todo+0xb48/0x10f0 net/core/dev.c:10356
 rtnl_unlock net/core/rtnetlink.c:147 [inline]
 rtnetlink_rcv_msg+0x447/0xc90 net/core/rtnetlink.c:6090
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
 __sys_sendmsg net/socket.c:2575 [inline]
 __do_sys_sendmsg net/socket.c:2584 [inline]
 __se_sys_sendmsg net/socket.c:2582 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f8631e89109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8632f3a168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8631f9bf60 RCX: 00007f8631e89109
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f8631ee305d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd4e730bf R14: 00007f8632f3a300 R15: 0000000000022000
 </TASK>

Allocated by task 4086:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:605 [inline]
 sk_prot_alloc+0x110/0x290 net/core/sock.c:1975
 sk_alloc+0x36/0x770 net/core/sock.c:2028
 tun_chr_open+0x7b/0x540 drivers/net/tun.c:3407
 misc_open+0x376/0x4a0 drivers/char/misc.c:143
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4a1/0x11f0 fs/open.c:848
 do_open fs/namei.c:3520 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3653
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 4087:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kfree+0xd6/0x4d0 mm/slub.c:4555
 sk_prot_free net/core/sock.c:2011 [inline]
 __sk_destruct+0x5e5/0x710 net/core/sock.c:2097
 sk_destruct net/core/sock.c:2112 [inline]
 __sk_free+0x1a4/0x4a0 net/core/sock.c:2123
 sk_free+0x78/0xa0 net/core/sock.c:2134
 sock_put include/net/sock.h:1927 [inline]
 __tun_detach+0xd59/0x1380 drivers/net/tun.c:679
 tun_detach drivers/net/tun.c:691 [inline]
 tun_chr_close+0x15c/0x180 drivers/net/tun.c:3443
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88807ad6e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1848 bytes inside of
 4096-byte region [ffff88807ad6e000, ffff88807ad6f000)

The buggy address belongs to the physical page:
page:ffffea0001eb5a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ad68
head:ffffea0001eb5a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4060, tgid 4060 (udevd), ts 68932381682, free_ts 68907621477
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x1290/0x3b70 mm/page_alloc.c:4198
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5426
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmalloc+0x318/0x350 mm/slub.c:4413
 kmalloc include/linux/slab.h:605 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x264/0x6b0 security/tomoyo/file.c:922
 tomoyo_path_rename+0xfe/0x1b0 security/tomoyo/tomoyo.c:287
 security_path_rename+0x11d/0x220 security/security.c:1201
 do_renameat2+0x472/0xc80 fs/namei.c:4857
 __do_sys_rename fs/namei.c:4916 [inline]
 __se_sys_rename fs/namei.c:4914 [inline]
 __x64_sys_rename+0x7d/0xa0 fs/namei.c:4914
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3438
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2521
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9a/0xe0 include/linux/audit.h:323
 vfs_fstatat+0x73/0xb0 fs/stat.c:254
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88807ad6e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ad6e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807ad6e700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88807ad6e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ad6e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         b4a028c4 ipv4: ping: fix bind address validity check
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ea32c4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70e1a4d352a3c6ae
dashboard link: https://syzkaller.appspot.com/bug?extid=b75c138e9286ac742647
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1354033ff00000

