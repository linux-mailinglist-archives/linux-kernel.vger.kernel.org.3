Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7753D559EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiFXQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiFXQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:52:11 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B05D11F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:52:10 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u25-20020a6b4919000000b006729aaa1b68so1594632iob.21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7laY+YapTNxHLhjPKoixAYq3rvzY3OY5G730WimWRKo=;
        b=Ci9QB3FMlPQcdKDY7cbOK+an7KXLlM5lMB4BevZ80Cy/aopHIG5YVKTzLrzaPjvLBc
         u3Kv2qK1TgaueGT/g/IbXHBK7TPe7bOpV/6qhlw4IlPdvUK3SdIKeEP2F9lQi5+fAOcv
         LMuzTvG+6m3zukgDSNTiPrqymUKrdCe9fYYUGnhi0W7fCNFQT+iVW6arp6J8tLQCkM7n
         iHSANhu20s7NqARiV0E0ZGq/ZHFjCrpe+R53TUZhl7pAUU/iNMsFH0to/w3/SYaAUcmJ
         rqOjIUPg0LnGBpad3SIUfGfQiVPOmhzShCYbC/BxT8eJrYXBA1BKrcP9RaxqHYQVTMr1
         z3tw==
X-Gm-Message-State: AJIora+97NX5IqzeNEON9AxJEYO6CBuixttd0TCVlLQ/e4FDb/HT0kKJ
        OBpzof1sl1r7o/GwKANjbq/64QZSWIzqXSPyfnfVM2HTMTnp
X-Google-Smtp-Source: AGRyM1tUozuZyqhd9mZ4jM0w9vBsJgTJlUfa4IBZoGbq2M/w9BAL2SO/6v2moL2S1ash0uaWppknaHUGsxDTDPNzRt9/JUXkXMke
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:2d1:e622:3f0a with SMTP id
 t7-20020a056e02160700b002d1e6223f0amr8823789ilu.287.1656089529920; Fri, 24
 Jun 2022 09:52:09 -0700 (PDT)
Date:   Fri, 24 Jun 2022 09:52:09 -0700
In-Reply-To: <20220624124418.684-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025b68905e23464c2@google.com>
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
Read of size 8 at addr ffff88807c16c738 by task syz-executor.0/4086

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
RIP: 0033:0x7f974fe89109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97510d9168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f974ff9bf60 RCX: 00007f974fe89109
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f974fee305d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcf73272af R14: 00007f97510d9300 R15: 0000000000022000
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
 tun_chr_open+0x7b/0x540 drivers/net/tun.c:3415
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
 __tun_detach+0xdb7/0x13e0 drivers/net/tun.c:681
 tun_detach drivers/net/tun.c:693 [inline]
 tun_chr_close+0x15c/0x180 drivers/net/tun.c:3451
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88807c16c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1848 bytes inside of
 4096-byte region [ffff88807c16c000, ffff88807c16d000)

The buggy address belongs to the physical page:
page:ffffea0001f05a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c168
head:ffffea0001f05a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001f08a00 dead000000000003 ffff888011842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 3727, tgid 3727 (dhcpcd-run-hook), ts 52036499638, free_ts 52020109867
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
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:320 [inline]
 tomoyo_file_open+0x9d/0xc0 security/tomoyo/tomoyo.c:315
 security_file_open+0x45/0xb0 security/security.c:1645
 do_dentry_open+0x349/0x11f0 fs/open.c:835
 do_open fs/namei.c:3520 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3653
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3438
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 kmem_cache_alloc_node+0x255/0x3f0 mm/slub.c:3264
 __alloc_skb+0x215/0x340 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1426 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1191 [inline]
 netlink_sendmsg+0x9a2/0xe10 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x21a/0x320 net/socket.c:2119
 __do_sys_sendto net/socket.c:2131 [inline]
 __se_sys_sendto net/socket.c:2127 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2127
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88807c16c600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c16c680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c16c700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88807c16c780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c16c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         b4a028c4 ipv4: ping: fix bind address validity check
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=106d80c0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70e1a4d352a3c6ae
dashboard link: https://syzkaller.appspot.com/bug?extid=b75c138e9286ac742647
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f803f8080000

