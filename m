Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025953FFB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbiFGNLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbiFGNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:11:28 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F559C9668
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:11:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n12-20020a92260c000000b002d3c9fc68d6so13732130ile.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XAKO5qpk7J+kwSRDT6npDhGhmijZheg+BQOHTjsuy34=;
        b=OBV/VMW5D/5gNCiDW/J2UcdBw2HTCQ0TGxkyiY9tCWpYLfgMNwIMST362Vdu3C66Ym
         YGo3fprzzrlFzDrKVcG63Uesa5R+pRwWkBfvXy4mCy0g/dAervmTu0OTCrlSISgKHECe
         997pa5uBsoCfAUmvButv3WV1OYd4xTSUZZ959UisVuY+GuVfpcTz0Jvlzltbr0oc1R8K
         Bf6fKQSQEBMgqIXDX76YDgU0BQwLYKxw7S1LadhpbygngI5Ns0G76JQo1puKYC5ohw0C
         ZpMT9t7L/HmK9r9gZ+PgZqw4o7Oln0gyCV5Rn4+2TV98qHB/et9kEtgDyobEPGAjLgHX
         Jghw==
X-Gm-Message-State: AOAM532Q0XCQCBDRpY4meVomTCpGpdX81/dO4/jSkL71Pg65ZWrt3+xD
        FZL15i2A6Ym3qdhnBvnVuBSPebXWfBBnQlkYPv0RJTzosYDs
X-Google-Smtp-Source: ABdhPJyY3QF7FASR9tS85FEoZq/uHm+ZOOmtNNNj7oclsAdKWtxs3NCFlK8U/PMLZNn0sLu3qlmw/+wd4HBDIeoqlFXplGKBjV6/
MIME-Version: 1.0
X-Received: by 2002:a92:c94e:0:b0:2d3:be50:3e2f with SMTP id
 i14-20020a92c94e000000b002d3be503e2fmr16806930ilq.143.1654607482698; Tue, 07
 Jun 2022 06:11:22 -0700 (PDT)
Date:   Tue, 07 Jun 2022 06:11:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fc46005e0db5390@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Write in check_move_unevictable_pages
From:   syzbot <syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com>
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

HEAD commit:    73d0e32571a0 Add linux-next specific files for 20220607
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12191700080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=448ee2b64e828049
dashboard link: https://syzkaller.appspot.com/bug?extid=8847ae8c7bc46bc9c10e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com

==================================================================
==================================================================
BUG: KASAN: stack-out-of-bounds in folio_batch_add include/linux/pagevec.h:130 [inline]
BUG: KASAN: stack-out-of-bounds in check_move_unevictable_pages+0x3f6/0x440 mm/vmscan.c:4857
Write of size 8 at addr ffffc9000ce5fbd8 by task syz-executor.0/17282

CPU: 0 PID: 17282 Comm: syz-executor.0 Not tainted 5.19.0-rc1-next-20220607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 folio_batch_add include/linux/pagevec.h:130 [inline]
 check_move_unevictable_pages+0x3f6/0x440 mm/vmscan.c:4857
 drm_gem_check_release_pagevec drivers/gpu/drm/drm_gem.c:511 [inline]
 drm_gem_put_pages+0x341/0x3f0 drivers/gpu/drm/drm_gem.c:642
 drm_gem_shmem_put_pages_locked+0x13e/0x230 drivers/gpu/drm/drm_gem_shmem_helper.c:237
 drm_gem_shmem_put_pages drivers/gpu/drm/drm_gem_shmem_helper.c:252 [inline]
 drm_gem_shmem_vm_close+0x45/0x70 drivers/gpu/drm/drm_gem_shmem_helper.c:588
 remove_vma+0x81/0x130 mm/mmap.c:187
 exit_mmap+0x2a1/0x750 mm/mmap.c:3215
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa18/0x2a00 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2542/0x2600 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f832a289109
Code: Unable to access opcode bytes at RIP 0x7f832a2890df.
RSP: 002b:00007f832b461218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f832a39bf68 RCX: 00007f832a289109
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f832a39bf68
RBP: 00007f832a39bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f832a39bf6c
R13: 00007ffc361fd38f R14: 00007f832b461300 R15: 0000000000022000
 </TASK>

The buggy address belongs to stack of task syz-executor.0/17282
 and is located at offset 16 in frame:
 do_exit+0x0/0x2a00 kernel/exit.c:423

This frame has 1 object:
 [32, 48) 'dead'

The buggy address belongs to the virtual mapping at
 [ffffc9000ce58000, ffffc9000ce61000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2648

The buggy address belongs to the physical page:
page:ffffea00007de500 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f794
memcg:ffff888076335e82
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888076335e82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 17263, tgid 17263 (syz-executor.0), ts 1021283919880, free_ts 1021173517931
 prep_new_page mm/page_alloc.c:2460 [inline]
 get_page_from_freelist+0xa64/0x3d10 mm/page_alloc.c:4279
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5503
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
 vm_area_alloc_pages mm/vmalloc.c:2926 [inline]
 __vmalloc_area_node mm/vmalloc.c:2994 [inline]
 __vmalloc_node_range+0x735/0x13b0 mm/vmalloc.c:3164
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct kernel/fork.c:971 [inline]
 copy_process+0x1568/0x7010 kernel/fork.c:2064
 kernel_clone+0xe7/0xab0 kernel/fork.c:2648
 __do_sys_clone+0xba/0x100 kernel/fork.c:2782
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1375 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1425
 free_unref_page_prepare mm/page_alloc.c:3311 [inline]
 free_unref_page+0x19/0x7b0 mm/page_alloc.c:3426
 __vunmap+0x86b/0xd50 mm/vmalloc.c:2664
 __vfree+0x3c/0xd0 mm/vmalloc.c:2712
 vfree+0x5a/0x90 mm/vmalloc.c:2743
 kvfree+0x2e/0x50 mm/util.c:621
 kvm_destroy_dirty_bitmap arch/x86/kvm/../../../virt/kvm/kvm_main.c:912 [inline]
 kvm_free_memslot arch/x86/kvm/../../../virt/kvm/kvm_main.c:919 [inline]
 kvm_free_memslots.part.0+0xd5/0x1a0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:942
 kvm_free_memslots arch/x86/kvm/../../../virt/kvm/kvm_main.c:938 [inline]
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1264 [inline]
 kvm_put_kvm+0x83e/0xb70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1294
 kvm_vcpu_release+0x4d/0x70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3713
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffffc9000ce5fa80: 00 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00
 ffffc9000ce5fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000ce5fb80: 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f3
                                                    ^
 ffffc9000ce5fc00: f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000ce5fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
