Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0569A4E90B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiC1JFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiC1JFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:05:01 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3552E16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:03:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id q137-20020a6b8e8f000000b006495204b061so9961528iod.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1BEYGgw9VLCjR2OvZTUoVmRSlR553OWUYaMPhi+y6Hc=;
        b=NkOd19q/ze8jBNMnpx4YNPjDlWRqPFqVQ8DM2YNCo+BNZbk5TixIlICqLidatDSBvW
         rYOeVddMS1lXSPA/A7zUxg4ZVhElHQZ0EO70EnqrynU0f5XKdRz7A1Ht5lZxxrZkBGIG
         MCpG7C8OV/xzqAqRgqhSNJBQeenLJjhkO4CRCFJBWVGOBmwk4ErBqf2FvveK9EWa8yG/
         klg5gVd52tnoGQj5D0v6PYkYtY4wqV9SJj0PvKNGBybG0Hx+avzHM8XBq+XZbWOTpK/p
         r/bemCUpE24FZraPOiJ3WjXbKFHzHNfV1n6+iGpafx2d8YcGSVXBjeK+94EK6k3S/wGO
         EzbQ==
X-Gm-Message-State: AOAM532QcFxpETyysZOrlv1bt/WgS/RjODCq4u0sPhGyK5CbutimLb2B
        Yek2NHhgYvrgO46/F2zrfxeZc/VA6S695/Q50Td7amPpfAg/
X-Google-Smtp-Source: ABdhPJybG4JW2cX3BKjRHqvJcBND+2gWOtlcswy0BQI67/ZhFh4GTrfGHpwJw3X9zPUyPUUZEyS0yte8YTbeuDgoK4bmx/Tu2R7i
MIME-Version: 1.0
X-Received: by 2002:a05:6638:260c:b0:323:6cae:8654 with SMTP id
 m12-20020a056638260c00b003236cae8654mr1522894jat.220.1648458200247; Mon, 28
 Mar 2022 02:03:20 -0700 (PDT)
Date:   Mon, 28 Mar 2022 02:03:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073f09205db439577@google.com>
Subject: [syzbot] kernel BUG in __pagevec_lru_add
From:   syzbot <syzbot+e2771c7f4aa80a94a9d4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1bc191051dca Merge tag 'trace-v5.18' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b9b613700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9ef58c085ccd118
dashboard link: https://syzkaller.appspot.com/bug?extid=e2771c7f4aa80a94a9d4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2771c7f4aa80a94a9d4@syzkaller.appspotmail.com

 __release_gpc arch/x86/kvm/../../../virt/kvm/pfncache.c:121 [inline]
 __release_gpc arch/x86/kvm/../../../virt/kvm/pfncache.c:107 [inline]
 kvm_gfn_to_pfn_cache_unmap+0x2df/0x3a0 arch/x86/kvm/../../../virt/kvm/pfncache.c:296
 kvm_gfn_to_pfn_cache_destroy arch/x86/kvm/../../../virt/kvm/pfncache.c:333 [inline]
 kvm_gfn_to_pfn_cache_destroy+0x199/0x260 arch/x86/kvm/../../../virt/kvm/pfncache.c:326
 kvm_xen_destroy_vm+0x18/0x90 arch/x86/kvm/xen.c:811
 kvm_arch_destroy_vm+0x360/0x470 arch/x86/kvm/x86.c:11774
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1217 [inline]
 kvm_put_kvm+0x4fa/0xb60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1250
 kvm_vm_release+0x3f/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1273
 __fput+0x286/0x9f0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xaff/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:936
 get_signal+0x4b0/0x28c0 kernel/signal.c:2903
------------[ cut here ]------------
kernel BUG at mm/swap.c:1012!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7754 Comm: syz-executor.1 Tainted: G        W         5.17.0-syzkaller-02237-g1bc191051dca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__pagevec_lru_add_fn mm/swap.c:1012 [inline]
RIP: 0010:__pagevec_lru_add+0xead/0x11e0 mm/swap.c:1062
Code: 48 c7 c6 00 0d b6 89 48 89 ef e8 de f1 09 00 0f 0b 45 31 e4 eb b3 e8 62 3e d4 ff 48 c7 c6 80 12 b6 89 48 89 ef e8 c3 f1 09 00 <0f> 0b e8 4c 3e d4 ff 48 89 ef e8 94 71 fe ff be 08 00 00 00 49 89
RSP: 0000:ffffc90008587bc8 EFLAGS: 00010046
RAX: 0000000000040000 RBX: dffffc0000000000 RCX: ffffc9000c3e9000
RDX: 0000000000040000 RSI: ffffffff81a4822d RDI: 0000000000000003
RBP: ffffea0001162680 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff89186e92 R11: 00000000ffffffff R12: 0000000000000010
R13: 0000000000000000 R14: ffff88805ad67000 R15: ffff888021768000
FS:  00007f5c0fffe700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c0fffd0e8 CR3: 0000000057caa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 00000000e08e0077 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_add_lru+0x467/0x6a0 mm/swap.c:469
 lru_cache_add_inactive_or_unevictable+0x192/0x520 mm/swap.c:490
 do_anonymous_page mm/memory.c:3811 [inline]
 handle_pte_fault mm/memory.c:4566 [inline]
 __handle_mm_fault+0x3190/0x4150 mm/memory.c:4704
 handle_mm_fault+0x1c8/0x790 mm/memory.c:4802
 do_user_addr_fault+0x489/0x11c0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1484 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1540
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:0x7f5c1162f1dc
Code: c0 e8 28 66 ff ff b8 ff ff ff ff e9 33 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 54 31 c0 55 48 81 ec 68 10 00 00 <48> 89 7c 24 08 48 8d 3d 38 48 0a 00 48 89 34 24 48 8b 14 24 48 8b
RSP: 002b:00007f5c0fffd0e0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 00007f5c1179c030 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000080
RBP: 00007f5c116e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000000 R12: 0000000000000000
R13: 00007f5c11ccfb1f R14: 00007f5c0fffe300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__pagevec_lru_add_fn mm/swap.c:1012 [inline]
RIP: 0010:__pagevec_lru_add+0xead/0x11e0 mm/swap.c:1062
Code: 48 c7 c6 00 0d b6 89 48 89 ef e8 de f1 09 00 0f 0b 45 31 e4 eb b3 e8 62 3e d4 ff 48 c7 c6 80 12 b6 89 48 89 ef e8 c3 f1 09 00 <0f> 0b e8 4c 3e d4 ff 48 89 ef e8 94 71 fe ff be 08 00 00 00 49 89
RSP: 0000:ffffc90008587bc8 EFLAGS: 00010046
RAX: 0000000000040000 RBX: dffffc0000000000 RCX: ffffc9000c3e9000
RDX: 0000000000040000 RSI: ffffffff81a4822d RDI: 0000000000000003
RBP: ffffea0001162680 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff89186e92 R11: 00000000ffffffff R12: 0000000000000010
R13: 0000000000000000 R14: ffff88805ad67000 R15: ffff888021768000
FS:  00007f5c0fffe700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c0fffd0e8 CR3: 0000000057caa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 00000000e08e0077 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
