Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2D46FF7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhLJLM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:12:58 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:55052 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhLJLM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:12:56 -0500
Received: by mail-io1-f70.google.com with SMTP id s8-20020a056602168800b005e96bba1363so9876718iow.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gqdU1EgFGZkc339x7q8A9k6Bq0i7pwZzSKKJa4jr1dw=;
        b=tPnIUjfrXu8YsjYSvFs2JY0cHmIIERHPZ2Rr+d8pXMw0HOGttzTVJXf+skF50aG6Pr
         XFT/0c0vBZopXN4JOb6BgGjho/T6J6SasQBt5Q7/Qa6AZ8ncv4MrEuh4La/5bXjgqSXV
         l7oLUn0k+Xjyrzuw+R77ug8daPnllwjaVRh6o/HtczbrE0I1Amdo28yan23pcfYphpGy
         7TwboCnE2wt8N7ZWow3VCfzmQA+53nHu6/GyIxZmKrKK5hYSZK4B/OP97v6XLUCtDzgL
         nBpdzH/A+hP8I0tBJkiJwkl6fzLlW3W08j1ncR0Y+QNabaJpZY8paymbTErZthYNryN+
         A8BQ==
X-Gm-Message-State: AOAM5326mLL8uyRx8o89zNjwy1UhVvcqM8y6f5Vexe3AFF2Enhzl0rdT
        HGi8vqr974ZItcJv9kpfWwT0SYnYVsqQqYh0PWpg+TEc98uS
X-Google-Smtp-Source: ABdhPJwhlM84liMJpLw6yIGRfayySxy92ZNaslUcGLlyMvKK/DqntSfBuBYu/qHH2hXsJrCftONcCcCkepINVKNql0203IGV1A6Q
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1311:: with SMTP id r17mr16060279jad.69.1639134561854;
 Fri, 10 Dec 2021 03:09:21 -0800 (PST)
Date:   Fri, 10 Dec 2021 03:09:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c679505d2c8c1d4@google.com>
Subject: [syzbot] general protection fault in inet_csk_accept
From:   syzbot <syzbot+e4d843bb96a9431e6331@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166f73adb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=e4d843bb96a9431e6331
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16280ae5b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1000fdc5b00000

The issue was bisected to:

commit 7f700334be9aeb91d5d86ef9ad2d901b9b453e9b
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Mar 29 18:39:51 2021 +0000

    ip6_gre: proper dev_{hold|put} in ndo_[un]init methods

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117fe575b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=137fe575b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=157fe575b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4d843bb96a9431e6331@syzkaller.appspotmail.com
Fixes: 7f700334be9a ("ip6_gre: proper dev_{hold|put} in ndo_[un]init methods")

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 6550 Comm: syz-executor122 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xd7d/0x54a0 kernel/locking/lockdep.c:4897
Code: 0f 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 69 cc 0f 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 f3 2f 00 00 48 81 3b 20 75 17 8f 0f 84 52 f3 ff
RSP: 0018:ffffc90001f2f818 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 000000000000000a R12: 0000000000000000
R13: ffff88801b98d700 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f177cd3d700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f177cd1b268 CR3: 000000001dd55000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 finish_wait+0xc0/0x270 kernel/sched/wait.c:400
 inet_csk_wait_for_connect net/ipv4/inet_connection_sock.c:464 [inline]
 inet_csk_accept+0x7de/0x9d0 net/ipv4/inet_connection_sock.c:497
 mptcp_accept+0xe5/0x500 net/mptcp/protocol.c:2865
 inet_accept+0xe4/0x7b0 net/ipv4/af_inet.c:739
 mptcp_stream_accept+0x2e7/0x10e0 net/mptcp/protocol.c:3345
 do_accept+0x382/0x510 net/socket.c:1773
 __sys_accept4_file+0x7e/0xe0 net/socket.c:1816
 __sys_accept4+0xb0/0x100 net/socket.c:1846
 __do_sys_accept net/socket.c:1864 [inline]
 __se_sys_accept net/socket.c:1861 [inline]
 __x64_sys_accept+0x71/0xb0 net/socket.c:1861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f177cd8b8e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f177cd3d308 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 00007f177ce13408 RCX: 00007f177cd8b8e9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f177ce13400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f177ce1340c
R13: 00007f177cde1004 R14: 6d705f706374706d R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 77ed64e4985d56c9 ]---
RIP: 0010:__lock_acquire+0xd7d/0x54a0 kernel/locking/lockdep.c:4897
Code: 0f 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 69 cc 0f 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 f3 2f 00 00 48 81 3b 20 75 17 8f 0f 84 52 f3 ff
RSP: 0018:ffffc90001f2f818 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 000000000000000a R12: 0000000000000000
R13: ffff88801b98d700 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f177cd3d700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f177cd1b268 CR3: 000000001dd55000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	0f 0e                	femms
   2:	41 be 01 00 00 00    	mov    $0x1,%r14d
   8:	0f 86 c8 00 00 00    	jbe    0xd6
   e:	89 05 69 cc 0f 0e    	mov    %eax,0xe0fcc69(%rip)        # 0xe0fcc7d
  14:	e9 bd 00 00 00       	jmpq   0xd6
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 f3 2f 00 00    	jne    0x3027
  34:	48 81 3b 20 75 17 8f 	cmpq   $0xffffffff8f177520,(%rbx)
  3b:	0f                   	.byte 0xf
  3c:	84 52 f3             	test   %dl,-0xd(%rdx)
  3f:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
