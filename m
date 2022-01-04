Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6A483D30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiADHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:49:22 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:48065 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiADHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:49:21 -0500
Received: by mail-il1-f197.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so19206146ila.14
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 23:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cIeQD4nWOsk9ZU/GO0il6CI6coPyhjR4bpryagwuNCc=;
        b=m1TCTk2jHjNgNQ1RD2juqs4xi6LjFSyLAQm2EAHOTJLLawaDUSGbnhgdIgJeIw1CSG
         aQaP+7WYcAVSRdFM97puHZNA9H5oKegRmtlOL+T9BkTe71zvWjuXoPAtQSQ2ePPSovYg
         1tHPmGcKKA6vGWIBB7cNfholZDshMT/P6kQGPh3q1xJPq6CbyG7rbF8utnnxWVNWEOHj
         p9aVQta9+pAJ2Yay/Zky46agGeJOZ+NjCnwdrGuC8oJHjjY7iolb2Mrm4kTzi6WmkNtj
         +NuExZPP34coZyrg1/gjQFgAH43SXjWnSbxOPoo1mLTw0X6iJVbTbx5MOAqrfSaG6DcS
         534w==
X-Gm-Message-State: AOAM531AEg4m4TSadHjKOjPuKcrimejXqEcttQSQosDeYv2L9S04ALZ3
        WzwGiEi+PNMiuWAqhhYZ0W3hyN+Cu24pZ2FuXjGOCxE/LljN
X-Google-Smtp-Source: ABdhPJySqL73f40fak1i65k+vVUKFAg3DJVeD0UB2LdynOEKwuy0onVzABf/KizB8ZvCS1kkeggCJzfo22AuZVqWInTpBT8Zfg82
MIME-Version: 1.0
X-Received: by 2002:a6b:d30d:: with SMTP id s13mr21736083iob.76.1641282560940;
 Mon, 03 Jan 2022 23:49:20 -0800 (PST)
Date:   Mon, 03 Jan 2022 23:49:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000560cc05d4bce058@google.com>
Subject: [syzbot] general protection fault in hidraw_release
From:   syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ea586a076e8a Add linux-next specific files for 20211224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=124161edb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9c4e3dde2c568fb
dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 PID: 9653 Comm: syz-executor.3 Not tainted 5.16.0-rc6-next-20211224-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xd7a/0x5470 kernel/locking/lockdep.c:4897
Code: 13 0e 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 ac c8 13 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 9f 2e 00 00 49 81 3e 60 94 1b 8f 0f 84 52 f3 ff
RSP: 0018:ffffc90005647bc8 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 1ffff92000ac8fa4 RCX: 1ffff92000ac8f8b
RDX: 0000000000000011 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff1b2663a R11: 0000000000000001 R12: 0000000000000000
R13: ffff888045f657c0 R14: 0000000000000088 R15: 0000000000000000
FS:  0000555555772400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ef2e000 CR3: 00000000131f3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 hidraw_release+0xca/0x370 drivers/hid/hidraw.c:352
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcce3b0fadb
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fff23159320 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007fcce3b0fadb
RDX: 0000000000000000 RSI: 00007fcce2cd5760 RDI: 0000000000000004
RBP: 00007fcce3c71960 R08: 0000000000000000 R09: 00000000355938f3
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000011a408
R13: 00007fff23159420 R14: 00007fcce3c70100 R15: 0000000000000032
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd7a/0x5470 kernel/locking/lockdep.c:4897
Code: 13 0e 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 ac c8 13 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 9f 2e 00 00 49 81 3e 60 94 1b 8f 0f 84 52 f3 ff
RSP: 0018:ffffc90005647bc8 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 1ffff92000ac8fa4 RCX: 1ffff92000ac8f8b
RDX: 0000000000000011 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff1b2663a R11: 0000000000000001 R12: 0000000000000000
R13: ffff888045f657c0 R14: 0000000000000088 R15: 0000000000000000
FS:  0000555555772400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ef2e000 CR3: 00000000131f3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	13 0e                	adc    (%rsi),%ecx
   2:	41 bf 01 00 00 00    	mov    $0x1,%r15d
   8:	0f 86 c8 00 00 00    	jbe    0xd6
   e:	89 05 ac c8 13 0e    	mov    %eax,0xe13c8ac(%rip)        # 0xe13c8c0
  14:	e9 bd 00 00 00       	jmpq   0xd6
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 f2             	mov    %r14,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 9f 2e 00 00    	jne    0x2ed3
  34:	49 81 3e 60 94 1b 8f 	cmpq   $0xffffffff8f1b9460,(%r14)
  3b:	0f                   	.byte 0xf
  3c:	84 52 f3             	test   %dl,-0xd(%rdx)
  3f:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
