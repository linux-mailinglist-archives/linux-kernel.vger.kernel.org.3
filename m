Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5CE516F46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiEBMJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiEBMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:09:52 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76213D2A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:06:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id j4-20020a92c204000000b002caad37af3fso7069754ilo.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 05:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oeRvHAY7DuWM+jFTn8eavTdlO6S9pp+ZLgkiUkQfQDM=;
        b=I9w9GZiSyLzaIV1tL1WmhLCvpPvlfeicqMsO6QF0bUldmqJEX0+iLGzYiBxWrhPYZW
         8jy8fm9yH0IZi449FeF8W6HrSX2RecSQbyWu2rpUFHqSclQFCflDJpf1HGa6VEJOIAuX
         Kjn8anUOR44cOxm6XG3mwvK67jcbZklaWHql/J17HzkEyzhlWgQ4SjwwtKCDWkQacL9W
         W9Vthr683sjclyajd2Xx7OQCUh5ai5LASTNldpJSaJ0Fm+6p3GD1Q8g6kd4ULsBB4K0V
         WjRS3Vago+1PTmzrlAPTgpMD2waLi+d7MbSMvSuxzCkHV+mYcQ9HIEC39rXOeXeYhZ20
         wZGg==
X-Gm-Message-State: AOAM530O6mS/2RELsOfkQg9yzvyXnt1rL0rGR9ktM/1BqEzcMD+Bfc9J
        GpStCEp498Ec/7duv2+a/pl02XnmNTcUGrp/ag5pdvOTOXMo
X-Google-Smtp-Source: ABdhPJwr7jcFq7L29JlK2/QBm/OHeN6Ztj7HKKNpoca889T778HD3nh9ibg3iV1nGB5UqzSKOMNqPN2wzpn4h1hAdfrclrDR0S9T
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3291:b0:32a:8493:fad1 with SMTP id
 f17-20020a056638329100b0032a8493fad1mr4470087jav.19.1651493182581; Mon, 02
 May 2022 05:06:22 -0700 (PDT)
Date:   Mon, 02 May 2022 05:06:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f31db05de0638f0@google.com>
Subject: [syzbot] general protection fault in vma_interval_tree_remove
From:   syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>
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

HEAD commit:    bdc61aad77fa Add linux-next specific files for 20220428
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1196c4bcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87767e89da13a759
dashboard link: https://syzkaller.appspot.com/bug?extid=ee1fdd8dcc770a3a169a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com

RBP: 0000000020000000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000008011 R11: 0000000000000206 R12: 0000000020000800
R13: 0000000020000000 R14: 00000000200007c0 R15: 0000000020000000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 32272 Comm: syz-executor.4 Not tainted 5.18.0-rc4-next-20220428-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:165 [inline]
RIP: 0010:____rb_erase_color lib/rbtree.c:359 [inline]
RIP: 0010:__rb_erase_color+0x2fd/0xdb0 lib/rbtree.c:413
Code: 00 4d 89 ec 4d 8b 6d 10 e9 ac fd ff ff 4c 89 60 10 eb be 4c 89 e9 48 89 e8 4c 89 6d 10 48 c1 e9 03 49 89 6c 24 08 48 83 c8 01 <80> 3c 19 00 0f 85 1d 08 00 00 49 89 45 00 48 89 e8 48 c1 e8 03 80
RSP: 0018:ffffc900149ffa48 EFLAGS: 00010286
RAX: ffff88801f3fbb21 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffed1002fe1617 RSI: ffff888017f0b0b8 RDI: ffff8880790928a0
RBP: ffff88801f3fbb20 R08: ffff88801f3fbb30 R09: ffff888017f0b0af
R10: ffffffff81b01168 R11: 0000000000000001 R12: ffff888079092898
R13: 0000000000000000 R14: ffff888017f0b0b8 R15: ffffffff81afff50
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001da88000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rb_erase_augmented include/linux/rbtree_augmented.h:305 [inline]
 rb_erase_augmented_cached include/linux/rbtree_augmented.h:314 [inline]
 vma_interval_tree_remove+0x694/0xed0 mm/interval_tree.c:23
 __remove_shared_vm_struct mm/mmap.c:160 [inline]
 unlink_file_vma+0xbd/0x110 mm/mmap.c:175
 free_pgtables+0x255/0x420 mm/memory.c:440
 exit_mmap+0x1ff/0x740 mm/mmap.c:3148
 __mmput+0xe4/0x460 kernel/fork.c:1175
 mmput+0x5c/0x70 kernel/fork.c:1197
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa18/0x2a00 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f858fe890e9
Code: Unable to access opcode bytes at RIP 0x7f858fe890bf.
RSP: 002b:00007f85910bbaf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f858fe890e9
RDX: 00007f858fe89132 RSI: 0000000000000000 RDI: 000000000000000b
RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000020000800
R13: 0000000020000000 R14: 00000000200007c0 R15: 0000000020000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:165 [inline]
RIP: 0010:____rb_erase_color lib/rbtree.c:359 [inline]
RIP: 0010:__rb_erase_color+0x2fd/0xdb0 lib/rbtree.c:413
Code: 00 4d 89 ec 4d 8b 6d 10 e9 ac fd ff ff 4c 89 60 10 eb be 4c 89 e9 48 89 e8 4c 89 6d 10 48 c1 e9 03 49 89 6c 24 08 48 83 c8 01 <80> 3c 19 00 0f 85 1d 08 00 00 49 89 45 00 48 89 e8 48 c1 e8 03 80
RSP: 0018:ffffc900149ffa48 EFLAGS: 00010286
RAX: ffff88801f3fbb21 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffed1002fe1617 RSI: ffff888017f0b0b8 RDI: ffff8880790928a0
RBP: ffff88801f3fbb20 R08: ffff88801f3fbb30 R09: ffff888017f0b0af
R10: ffffffff81b01168 R11: 0000000000000001 R12: ffff888079092898
R13: 0000000000000000 R14: ffff888017f0b0b8 R15: ffffffff81afff50
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001da88000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 4d 89             	add    %cl,-0x77(%rbp)
   3:	ec                   	in     (%dx),%al
   4:	4d 8b 6d 10          	mov    0x10(%r13),%r13
   8:	e9 ac fd ff ff       	jmpq   0xfffffdb9
   d:	4c 89 60 10          	mov    %r12,0x10(%rax)
  11:	eb be                	jmp    0xffffffd1
  13:	4c 89 e9             	mov    %r13,%rcx
  16:	48 89 e8             	mov    %rbp,%rax
  19:	4c 89 6d 10          	mov    %r13,0x10(%rbp)
  1d:	48 c1 e9 03          	shr    $0x3,%rcx
  21:	49 89 6c 24 08       	mov    %rbp,0x8(%r12)
  26:	48 83 c8 01          	or     $0x1,%rax
* 2a:	80 3c 19 00          	cmpb   $0x0,(%rcx,%rbx,1) <-- trapping instruction
  2e:	0f 85 1d 08 00 00    	jne    0x851
  34:	49 89 45 00          	mov    %rax,0x0(%r13)
  38:	48 89 e8             	mov    %rbp,%rax
  3b:	48 c1 e8 03          	shr    $0x3,%rax
  3f:	80                   	.byte 0x80


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
