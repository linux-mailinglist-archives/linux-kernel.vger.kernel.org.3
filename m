Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB28253B543
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiFBIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:41:10 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9156329DC2F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:41:09 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y2-20020a056602164200b00668dc549adbso2347415iow.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=czCqk9qBl2APDAjgM2wBXOWz78t9clk3Sjv1fN9UvmY=;
        b=D0FhICAm2nkzLBggedBo8fHOWYoLrhEKO7ukkElAakNtUgGKrxul+Pcg2fk//S5gcF
         H2g/aXYs22hJrEAEuhDZcrkxohtIMm5D6XAwYdqIO3i+/1FVTKyBFaUpbNzBQvvkEAsG
         +ivz4D3Yd2WgJi+DfoyNDi2OpJJD5QFlU1GCCanghesmjxbcXQ0J4Asve9AekpVDsE69
         cXPmo3YdnGTWYd2BnZsXxlrKKD73nDLQ715nOqaSrglQaFOzDsZOzss0+59aE0Eab4jc
         yLm5jZwHeuoy7I0Rmj05AVnzVx5B7P+Hd5tnDkM04EpfANegMf2C+5y0QwJ7NeY9MfPf
         Yx6Q==
X-Gm-Message-State: AOAM530RFiVodUr6Y2VRywbzXhm/VturUKpQRzOAChESoYupfCaCmjpG
        CZuClQoEETgWTRbYy1nB8STpOCpl3qQslT8yLNnKZ1GHVRCV
X-Google-Smtp-Source: ABdhPJyuObZv8KeNZt69HXn0kK+mTnwyi0bKXx0U1uqp0M5YHafGolWEPtkOa8i5cOcXUITyCwNk1XW9kOWdNYaix3aPVli7czbn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:552:b0:2d1:db28:5434 with SMTP id
 i18-20020a056e02055200b002d1db285434mr2539039ils.115.1654159268970; Thu, 02
 Jun 2022 01:41:08 -0700 (PDT)
Date:   Thu, 02 Jun 2022 01:41:08 -0700
In-Reply-To: <20220602082142.4955-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a108df05e072f7ba@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_power_on
From:   syzbot <syzbot+8d7b9ced2a99394b0a50@syzkaller.appspotmail.com>
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
KASAN: use-after-free Read in hci_cmd_timeout

==================================================================
BUG: KASAN: use-after-free in hci_cmd_timeout+0x68/0x1e0 net/bluetooth/hci_core.c:1473
Read of size 8 at addr ffff88801a28d358 by task kworker/1:7/4369

CPU: 1 PID: 4369 Comm: kworker/1:7 Not tainted 5.18.0-syzkaller-10643-g9d004b2f4fea-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events hci_cmd_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 hci_cmd_timeout+0x68/0x1e0 net/bluetooth/hci_core.c:1473
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 3611:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0xb2/0xe0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x199/0x2f0 mm/slub.c:3239
 skb_clone+0x1aa/0x370 net/core/skbuff.c:1515
 hci_cmd_work+0xbc/0x360 net/bluetooth/hci_core.c:3854
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Freed by task 4083:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free+0xc7/0x270 mm/slub.c:3524
 kfree_skb include/linux/skbuff.h:1375 [inline]
 hci_dev_open_sync+0x107e/0x1340 net/bluetooth/hci_sync.c:4052
 hci_dev_do_open net/bluetooth/hci_core.c:482 [inline]
 hci_power_on+0x180/0x650 net/bluetooth/hci_core.c:963
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff88801a28d280
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 216 bytes inside of
 240-byte region [ffff88801a28d280, ffff88801a28d370)

The buggy address belongs to the physical page:
page:ffffea000068a340 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1a28d
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000682640 dead000000000005 ffff888140a57500
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 51, tgid 51 (kworker/u4:2), ts 58236376345, free_ts 58226454515
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4198
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5426
 alloc_slab_page+0x70/0xf0 mm/slub.c:1797
 allocate_slab+0x5e/0x520 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x41e/0xcd0 mm/slub.c:3002
 __slab_alloc mm/slub.c:3089 [inline]
 slab_alloc_node mm/slub.c:3180 [inline]
 kmem_cache_alloc_node+0x287/0x340 mm/slub.c:3264
 __alloc_skb+0xd5/0x660 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1426 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 inet6_netconf_notify_devconf+0xf8/0x1b0 net/ipv6/addrconf.c:581
 __addrconf_sysctl_unregister net/ipv6/addrconf.c:7112 [inline]
 addrconf_sysctl_unregister net/ipv6/addrconf.c:7136 [inline]
 addrconf_ifdown+0x18a2/0x1bc0 net/ipv6/addrconf.c:3903
 addrconf_notify+0x403/0xf80
 notifier_call_chain kernel/notifier.c:84 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:392
 call_netdevice_notifiers_info net/core/dev.c:1943 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1981 [inline]
 call_netdevice_notifiers net/core/dev.c:1995 [inline]
 unregister_netdevice_many+0xeee/0x1950 net/core/dev.c:10834
 default_device_exit_batch+0x660/0x6d0 net/core/dev.c:11328
 ops_exit_list net/core/net_namespace.c:167 [inline]
 cleanup_net+0x80c/0xc50 net/core/net_namespace.c:594
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x7d/0x390 mm/page_alloc.c:3438
 mm_free_pgd kernel/fork.c:737 [inline]
 __mmdrop+0xae/0x3f0 kernel/fork.c:788
 mmdrop include/linux/sched/mm.h:50 [inline]
 mmdrop_sched include/linux/sched/mm.h:78 [inline]
 finish_task_switch+0x221/0x610 kernel/sched/core.c:5021
 context_switch kernel/sched/core.c:5119 [inline]
 __schedule+0x95f/0xec0 kernel/sched/core.c:6431
 schedule+0xeb/0x1b0 kernel/sched/core.c:6503
 do_wait+0x7a4/0x9d0 kernel/exit.c:1537
 kernel_wait4+0x29c/0x3e0 kernel/exit.c:1681
 __do_sys_wait4 kernel/exit.c:1709 [inline]
 __se_sys_wait4 kernel/exit.c:1705 [inline]
 __x64_sys_wait4+0x130/0x1e0 kernel/exit.c:1705
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88801a28d200: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff88801a28d280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801a28d300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                    ^
 ffff88801a28d380: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88801a28d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         9d004b2f Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b24b8ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c367f7c347f1679
dashboard link: https://syzkaller.appspot.com/bug?extid=8d7b9ced2a99394b0a50
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b72613f00000

