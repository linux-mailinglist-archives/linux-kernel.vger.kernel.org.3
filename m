Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68B58FC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiHKMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiHKMnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:43:25 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB38982E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:43:24 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u5-20020a6b4905000000b00681e48dbd92so9660840iob.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=N4jbo9jFiiTWtuh64UuCXIlcP86sRdsnQIPlROsB+us=;
        b=TKtEYD9Cwm4L98qpP+HMLQRDE6Eghx7ugEEcw61MUb6hu/vFueZg5ktl010W1zzUjm
         xP2NMNVRtpnkRFnEcu389Yvh+uVFKIyt3EjmCQ/0T351uyKIeyiaqU0SdpReLU1OdQaC
         DLm9KM1cIjJRI6FSUrRb0IwwEm112iWsW49A5m2Jjb1yWB/Ap4o1qmgoItklKBCuzVwu
         ej0mkStOCt/oI6DP6o9IuvWeYTMwzgcLtY0T8WvGxVpeOfcy+606MCCneON/dsqFYPtw
         k/0tr3OhMhmzcmb/UiqMXYKv2kDMfxpPkoPCi9xhWbKKAV0eQmsYfBsStrZ0YyGgb65S
         D3XQ==
X-Gm-Message-State: ACgBeo2fsWIe7NB1KoZLMgUK/Yawm8WyUYxMoLetaVMPuwmj7GWgFv2V
        UYQi6QTGONAqEJba+YjNspDheOOkLl3reVzBFSVPfyTImkZg
X-Google-Smtp-Source: AA6agR7h/5EcbcHx98azEJNc5+fbmcmEz27gcVSe61f94SUPHSgDsaZ9H+tm5dDBzNUjwrJus9VbAPAJQX05G/QFg2ZgN63os+tK
MIME-Version: 1.0
X-Received: by 2002:a92:b106:0:b0:2dc:eebb:e6f6 with SMTP id
 t6-20020a92b106000000b002dceebbe6f6mr14820842ilh.54.1660221803579; Thu, 11
 Aug 2022 05:43:23 -0700 (PDT)
Date:   Thu, 11 Aug 2022 05:43:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9cfcf05e5f68213@google.com>
Subject: [syzbot] linux-next boot error: KASAN: out-of-bounds Read in rcu_cblist_dequeue
From:   syzbot <syzbot+4f473a64b5132e9560d1@syzkaller.appspotmail.com>
To:     Henry.Wang@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        longpeng2@huawei.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    40d43a7507e1 Add linux-next specific files for 20220811
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170595fd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5ae8cfa8d7075d1
dashboard link: https://syzkaller.appspot.com/bug?extid=4f473a64b5132e9560d1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f473a64b5132e9560d1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in rcu_cblist_dequeue+0xa4/0xe0 kernel/rcu/rcu_segcblist.c:75
Read of size 8 at addr ffffc90004f08000 by task ksoftirqd/1/21

CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.19.0-next-20220811-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x59/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 rcu_cblist_dequeue+0xa4/0xe0 kernel/rcu/rcu_segcblist.c:75
 rcu_do_batch kernel/rcu/tree.c:2234 [inline]
 rcu_core+0x735/0x1890 kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90004f08000, ffffc90004f11000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2675

The buggy address belongs to the physical page:
page:ffffea00007ed940 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fb65
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 11, tgid 11 (kworker/u4:1), ts 8261677515, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2cd0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5507
 __alloc_pages_bulk+0x9fc/0x15a0 mm/page_alloc.c:5455
 alloc_pages_bulk_array_mempolicy+0x1b3/0x360 mm/mempolicy.c:2365
 vm_area_alloc_pages mm/vmalloc.c:2930 [inline]
 __vmalloc_area_node mm/vmalloc.c:3026 [inline]
 __vmalloc_node_range+0x576/0x13a0 mm/vmalloc.c:3196
 alloc_thread_stack_node kernel/fork.c:312 [inline]
 dup_task_struct kernel/fork.c:977 [inline]
 copy_process+0x13cd/0x7120 kernel/fork.c:2088
 kernel_clone+0xe7/0xab0 kernel/fork.c:2675
 user_mode_thread+0xad/0xe0 kernel/fork.c:2744
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc90004f07f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004f07f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90004f08000: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffffc90004f08080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004f08100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
