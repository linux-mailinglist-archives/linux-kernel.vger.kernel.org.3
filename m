Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED50B59B635
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiHUUAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHUUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:00:32 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1848C193DE
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:00:31 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id w6-20020a056e02190600b002e74e05fdc2so7127779ilu.21
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=IgWUTkVD6oDrPjhnDopu5A3rN80gzl2jAUVz0qwuJp0=;
        b=O9A/BGjB9X82eG03v+/udbIVCgdXs+xqtIrB2Urwlb2jmwacgtDC831vnku1mLpZtH
         l7WtDuSscIjfrzMFu0/V8Onb3Q8cfoeymSZxh75yfOF12aIDdLhhOtIdhTS/7eS4V7BC
         RdVxo1ysKgY/Ibi0XsCXhIOVNdSXi4JhH1atauTA0auw2E6tt+6apcULrnAgihowAuQ+
         DMIdsdVqZXJTRh5nKfE/DYlRVxiyz7LstTJxu4f3Kd5U5bafHKRQ1PsOQ2sjKPenAgLb
         JvoJlyIMLrAQo1hpejxUVi08l4nh1TPrmVaFInuKOaP1HzWmkla4S2Uc0Q1xRx99h706
         5NYw==
X-Gm-Message-State: ACgBeo3L+Y7XivGR4ieLcd/Map07+VznvoAPhk/vieeIqa/u6KOTdLLN
        JuJcf/4ObKF2OANvKjaDl9PbM4YYnNmk3iqH0Q6O9iskN6KT
X-Google-Smtp-Source: AA6agR5qmAL+GqOoGBG+IBLlxGMzbYOKfWee523dM5cckCyB1ptHkh3/grLRXj630PCaFzoslR/KDCXxLOei0Mh/UjQG2AT2fi7P
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1cf:b0:5e9:74e7:6b01 with SMTP id
 w15-20020a05660201cf00b005e974e76b01mr6831690iot.127.1661112030480; Sun, 21
 Aug 2022 13:00:30 -0700 (PDT)
Date:   Sun, 21 Aug 2022 13:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000824e3805e6c5c875@google.com>
Subject: [syzbot] usb-testing boot error: KASAN: out-of-bounds Read in __schedule
From:   syzbot <syzbot+dc34dd8e1a7a138b88ac@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10c0a92d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=dc34dd8e1a7a138b88ac
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc34dd8e1a7a138b88ac@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in schedule_debug kernel/sched/core.c:5736 [inline]
BUG: KASAN: out-of-bounds in __schedule+0x2114/0x26f0 kernel/sched/core.c:6388
Read of size 8 at addr ffffc900015f8000 by task kworker/u4:1/237

CPU: 1 PID: 237 Comm: kworker/u4:1 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x59/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 schedule_debug kernel/sched/core.c:5736 [inline]
 __schedule+0x2114/0x26f0 kernel/sched/core.c:6388
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6663
 __cond_resched+0x13/0x20 kernel/sched/core.c:8299
 might_resched include/linux/kernel.h:110 [inline]
 might_alloc include/linux/sched/mm.h:274 [inline]
 slab_pre_alloc_hook mm/slab.h:700 [inline]
 slab_alloc_node mm/slub.c:3157 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x2fe/0x4a0 mm/slub.c:3268
 prepare_kernel_cred+0x27/0x890 kernel/cred.c:717
 call_usermodehelper_exec_async+0x10e/0x580 kernel/umh.c:91
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

The buggy address belongs to stack of task kworker/u4:1/237

The buggy address belongs to the virtual mapping at
 [ffffc900015f8000, ffffc90001601000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2673

The buggy address belongs to the physical page:
page:ffffea0004396940 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10e5a5
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 26, tgid 26 (kworker/u4:1), ts 6964925972, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x11cc/0x2a20 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 __alloc_pages_bulk+0x9a1/0x1400 mm/page_alloc.c:5463
 alloc_pages_bulk_array_mempolicy+0x1b3/0x360 mm/mempolicy.c:2365
 vm_area_alloc_pages mm/vmalloc.c:2930 [inline]
 __vmalloc_area_node mm/vmalloc.c:3026 [inline]
 __vmalloc_node_range+0x576/0x13a0 mm/vmalloc.c:3196
 alloc_thread_stack_node kernel/fork.c:312 [inline]
 dup_task_struct kernel/fork.c:977 [inline]
 copy_process+0x13c0/0x6de0 kernel/fork.c:2087
 kernel_clone+0xe7/0xab0 kernel/fork.c:2673
 user_mode_thread+0xad/0xe0 kernel/fork.c:2742
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc900015f7f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900015f7f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc900015f8000: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffffc900015f8080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900015f8100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
