Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAED47C396
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhLUQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:15:22 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:47043 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhLUQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:15:21 -0500
Received: by mail-io1-f69.google.com with SMTP id z21-20020a5e8615000000b005e22e531c8aso9353821ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=A8wMevjFd0djCmseUEIvR4sB+YkRCnIY+1LrESZiOJw=;
        b=ss33QP2DfEhEWaO4BeTVRAW7m7rJird+4YMPpX27A3uiNXwXZkjkoQKpnAFp2mlDIE
         SfZ/TRMJd9kfmpe4gt39HFV327QpSu2jhj8s8xs7jq5imvWmEcHsjuOV/vGg6+u2Fvow
         m/drvymOogodrfsV/iYE8jeXo+eu6IUchU7kujW4bDaOtykFE6ZGWO0+nej0F9skMZEZ
         6xEbdeHE9hGBnKmL1xh+Hk8xb8EgGcItATbby9aPstICwJ9ERq16hsXEE7iMBBfhgSZP
         D2B8aSgfwOkSd3dvejvaMLFO5JZRgaopMRa2pOnklEiPdxAVD/9+RPlhhCkZetlP7PwT
         Ce5w==
X-Gm-Message-State: AOAM533e2ipO63IaKFmMHl4ERP6EzOjVJSh1k33wNEBRVKe4CYbi9nI+
        i5iPvfOyiTk9LOi+5DVtB9/WWfPiSX3zSYrNI0zVHJYaftQU
X-Google-Smtp-Source: ABdhPJz0uRLgxr+O+IjSP+NQZakmnxPJwXoMPb1TV1b+qcqlMvM8RlnqhcBAYl5u9Nu0OAGbnt6gHtMgkD+oILrMklRvLCuMDM8a
MIME-Version: 1.0
X-Received: by 2002:a05:6638:304e:: with SMTP id u14mr2274772jak.283.1640103320808;
 Tue, 21 Dec 2021 08:15:20 -0800 (PST)
Date:   Tue, 21 Dec 2021 08:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4f30d05d3aa4f09@google.com>
Subject: [syzbot] general protection fault in reweight_entity
From:   syzbot <syzbot+8d9571494fc49db5aca1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        david@redhat.com, ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, pcc@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6441998e2e37 Merge tag 'audit-pr-20211216' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1305d47eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=8d9571494fc49db5aca1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a88443b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e5179db00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d9571494fc49db5aca1@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
CPU: 1 PID: 18467 Comm: syz-executor672 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:dequeue_load_avg kernel/sched/fair.c:3033 [inline]
RIP: 0010:dequeue_load_avg kernel/sched/fair.c:3033 [inline] kernel/sched/fair.c:3052
RIP: 0010:reweight_entity+0x152/0x430 kernel/sched/fair.c:3052 kernel/sched/fair.c:3052
Code: 03 80 3c 11 00 0f 85 ba 02 00 00 48 8d bd a0 00 00 00 4c 8b ab e0 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 6a 02 00 00 48 8b 95 a0 00 00 00 4c 29 ea 0f 82
RSP: 0018:ffffc9000b6c7d68 EFLAGS: 00010006
RAX: 0000000000003c00 RBX: ffff888020bcba80 RCX: 0000000000000014
RDX: dffffc0000000000 RSI: ffff888020bcba80 RDI: 00000000000000a0
RBP: 0000000000000000 R08: ffff888020bcbe0c R09: ffff88801f2e8000
R10: ffff888020bcbc90 R11: ffff888020bcba70 R12: ffff888020bcbab8
R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880b9c3a7d8
FS:  00007feccbab3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd630085f8 CR3: 0000000074a55000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reweight_task+0x94/0x160 kernel/sched/fair.c:3077 kernel/sched/fair.c:3077
 set_load_weight kernel/sched/core.c:1225 [inline]
 set_load_weight kernel/sched/core.c:1225 [inline] kernel/sched/core.c:6882
 set_user_nice.part.0+0x837/0x1120 kernel/sched/core.c:6882 kernel/sched/core.c:6882
 set_one_prio+0x241/0x340 kernel/sys.c:198 kernel/sys.c:198
 __do_sys_setpriority+0x309/0xab0 kernel/sys.c:239 kernel/sys.c:239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7feccbb01819
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feccbab3318 EFLAGS: 00000246 ORIG_RAX: 000000000000008d
RAX: ffffffffffffffda RBX: 00007feccbb893e8 RCX: 00007feccbb01819
RDX: 0000000000008f82 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007feccbb893e0 R08: 00007feccbab3700 R09: 0000000000000000
R10: 00007feccbab3700 R11: 0000000000000246 R12: 00007feccbb893ec
R13: 00007ffd6300859f R14: 00007feccbab3400 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace ef3b708bbc5cad7f ]---
RIP: 0010:dequeue_load_avg kernel/sched/fair.c:3033 [inline]
RIP: 0010:dequeue_load_avg kernel/sched/fair.c:3033 [inline] kernel/sched/fair.c:3052
RIP: 0010:reweight_entity+0x152/0x430 kernel/sched/fair.c:3052 kernel/sched/fair.c:3052
Code: 03 80 3c 11 00 0f 85 ba 02 00 00 48 8d bd a0 00 00 00 4c 8b ab e0 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 6a 02 00 00 48 8b 95 a0 00 00 00 4c 29 ea 0f 82
RSP: 0018:ffffc9000b6c7d68 EFLAGS: 00010006
RAX: 0000000000003c00 RBX: ffff888020bcba80 RCX: 0000000000000014
RDX: dffffc0000000000 RSI: ffff888020bcba80 RDI: 00000000000000a0
RBP: 0000000000000000 R08: ffff888020bcbe0c R09: ffff88801f2e8000
R10: ffff888020bcbc90 R11: ffff888020bcba70 R12: ffff888020bcbab8
R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880b9c3a7d8
FS:  00007feccbab3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd630085f8 CR3: 0000000074a55000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 80 3c 11 00 0f    	add    0xf00113c(%rax),%eax
   6:	85 ba 02 00 00 48    	test   %edi,0x48000002(%rdx)
   c:	8d bd a0 00 00 00    	lea    0xa0(%rbp),%edi
  12:	4c 8b ab e0 00 00 00 	mov    0xe0(%rbx),%r13
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 6a 02 00 00    	jne    0x29e
  34:	48 8b 95 a0 00 00 00 	mov    0xa0(%rbp),%rdx
  3b:	4c 29 ea             	sub    %r13,%rdx
  3e:	0f                   	.byte 0xf
  3f:	82                   	.byte 0x82
----------------
Code disassembly (best guess):
   0:	03 80 3c 11 00 0f    	add    0xf00113c(%rax),%eax
   6:	85 ba 02 00 00 48    	test   %edi,0x48000002(%rdx)
   c:	8d bd a0 00 00 00    	lea    0xa0(%rbp),%edi
  12:	4c 8b ab e0 00 00 00 	mov    0xe0(%rbx),%r13
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 6a 02 00 00    	jne    0x29e
  34:	48 8b 95 a0 00 00 00 	mov    0xa0(%rbp),%rdx
  3b:	4c 29 ea             	sub    %r13,%rdx
  3e:	0f                   	.byte 0xf
  3f:	82                   	.byte 0x82


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
