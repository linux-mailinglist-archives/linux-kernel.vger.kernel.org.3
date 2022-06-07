Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CED53FFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiFGNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiFGNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:10:22 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44642C9656
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:10:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so7994454iov.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nYWFZ8w0Jl92QuggtvfT6Awz+hN36EiX9KpzWdgEn5Y=;
        b=bD14THZnS9zQP7AohiGOSzC291JqkL9mP0uVbGI6GV+yXuMKW2q2cDAy6nqHpX9onG
         yDOH0/ea//8shx6Tmac2Y8AJhca0OD842q0+tgan3gjNF44nuwz9jGp49bvjiGzs+Zb1
         Tb800yt0Y4Cxv1+t6wufs+YvKDY60Jcg/VjSRWXCBZGJb652Cu3XtfsaRT8YIN52MNG8
         /d6tIxpA9GkRV90xlwWTDFMP6RRrt/F3ZmvAX5fJIY01lWGvXO3DHW9TN96I/Rcm2DCB
         m4w3jBmQf7eYMX/XGbC4cslz6QyzpO8yg1Cbq+JMmyNuhemPz/0uiFJZ2daS4dZT6E3Z
         jaAA==
X-Gm-Message-State: AOAM530P8t4T4TUztFEGgB99FVX2Aya2E+maA7McFnleJJ46K+1bli+S
        dZ4feXFl18+AQ+DwfBnmUmoe3pDz8iXDu4d9kN6Zn6vG9F7c
X-Google-Smtp-Source: ABdhPJyljPBtJz9uvd97Veq+IsFUgI8EG9FccA9YORpsazUlJakLRTlurUj4GshoayjJ9xk8aEw+zTYPocsHcmjqLyh7/axKkx/L
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:2d3:82bb:4dae with SMTP id
 g3-20020a056e021a2300b002d382bb4daemr16906322ile.62.1654607420630; Tue, 07
 Jun 2022 06:10:20 -0700 (PDT)
Date:   Tue, 07 Jun 2022 06:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cadf305e0db4f7a@google.com>
Subject: [syzbot] general protection fault in check_move_unevictable_folios
From:   syzbot <syzbot+702b6f0c8b2f96a79c42@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=126e5107f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=448ee2b64e828049
dashboard link: https://syzkaller.appspot.com/bug?extid=702b6f0c8b2f96a79c42
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+702b6f0c8b2f96a79c42@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5475 Comm: syz-executor.4 Not tainted 5.19.0-rc1-next-20220607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:PagePoisoned include/linux/page-flags.h:323 [inline]
RIP: 0010:PageHead include/linux/page-flags.h:794 [inline]
RIP: 0010:compound_nr include/linux/mm.h:948 [inline]
RIP: 0010:folio_nr_pages include/linux/mm.h:1678 [inline]
RIP: 0010:check_move_unevictable_folios+0xb4/0x1590 mm/vmscan.c:4881
Code: e8 31 2f d2 ff 48 89 e8 48 c1 e8 03 42 80 3c 30 00 0f 85 5d 11 00 00 48 8b 0c 24 48 63 c3 4c 8b 7c c1 08 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 32 11 00 00 4d 8b 27 48 c7 c7 ff ff ff ff 4c
RSP: 0018:ffffc90002dcf608 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90002dcf6e8
RDX: ffff88802592ba80 RSI: ffffffff81a842ef RDI: 0000000000000001
RBP: ffffc90002dcf6f0 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000000da R11: 0000000000000001 R12: dffffc0000000000
R13: ffffc90002dcf8b0 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed26000 CR3: 000000007c154000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_move_unevictable_pages+0x1e6/0x440 mm/vmscan.c:4859
 drm_gem_check_release_pagevec drivers/gpu/drm/drm_gem.c:511 [inline]
 drm_gem_put_pages+0x29f/0x3f0 drivers/gpu/drm/drm_gem.c:639
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
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:PagePoisoned include/linux/page-flags.h:323 [inline]
RIP: 0010:PageHead include/linux/page-flags.h:794 [inline]
RIP: 0010:compound_nr include/linux/mm.h:948 [inline]
RIP: 0010:folio_nr_pages include/linux/mm.h:1678 [inline]
RIP: 0010:check_move_unevictable_folios+0xb4/0x1590 mm/vmscan.c:4881
Code: e8 31 2f d2 ff 48 89 e8 48 c1 e8 03 42 80 3c 30 00 0f 85 5d 11 00 00 48 8b 0c 24 48 63 c3 4c 8b 7c c1 08 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 32 11 00 00 4d 8b 27 48 c7 c7 ff ff ff ff 4c
RSP: 0018:ffffc90002dcf608 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90002dcf6e8
RDX: ffff88802592ba80 RSI: ffffffff81a842ef RDI: 0000000000000001
RBP: ffffc90002dcf6f0 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000000da R11: 0000000000000001 R12: dffffc0000000000
R13: ffffc90002dcf8b0 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f358fb6b998 CR3: 0000000043f98000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 31 2f d2 ff       	callq  0xffd22f36
   5:	48 89 e8             	mov    %rbp,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  11:	0f 85 5d 11 00 00    	jne    0x1174
  17:	48 8b 0c 24          	mov    (%rsp),%rcx
  1b:	48 63 c3             	movslq %ebx,%rax
  1e:	4c 8b 7c c1 08       	mov    0x8(%rcx,%rax,8),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 32 11 00 00    	jne    0x1167
  35:	4d 8b 27             	mov    (%r15),%r12
  38:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  3f:	4c                   	rex.WR


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
