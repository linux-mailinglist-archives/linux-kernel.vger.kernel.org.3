Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0847B8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhLUDET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:04:19 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54111 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLUDER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:04:17 -0500
Received: by mail-io1-f69.google.com with SMTP id a12-20020a056602148c00b005e7052734adso8301711iow.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bPntceHNT95Aah71cxJ2P7hO9EuIXRWFNPHwhOu7JVw=;
        b=SGtQrJ9ZHDC1G+IfbpA48TuUqUD506ukAeDU07LYuKIQqVt3Q3huQaFC6/UtsiX4bx
         IcWgH8i0NRqvtl2CZsgqTfJqKqAynZd3t5RoPffDVfYVvhWExmFV8SRfakjVTZsLSjjF
         auKy1M+rLrAGs+5UPEkH3DTGihjFM6u2x+rcmgbOCKqDtRIffVoBHWf2RfnR0ZbtnFqo
         MBfhiNJwIvs+5HmwEAKw/gZ8ioqlQtm9faeDdhMSDZH1PPCaPhjeJg8/hj8iBgkrd80v
         E3RtWlnUzARQ7EN12aoOqbak2aL+4UuGruEKUahez9jPV+DdiVw557+YJ9DLY7UQbiTb
         XuuQ==
X-Gm-Message-State: AOAM533W6ZYgEU0RGmaj4uJ39V1m56kGqAzz8NFwh9GMGF/D7gptEi1o
        yUut58htRvqDw+OSxleUavZibnrSh9QRdjQAxwDPD6c2DiBO
X-Google-Smtp-Source: ABdhPJzvSPjqAafFCwwsXf55qpKdQLKypYl2Z1FLUmJ4ebvkUWDhxD+C4HTlXIUquvxEbSLbPrY9QTaHrsc+thc48wro0+jDG/8u
MIME-Version: 1.0
X-Received: by 2002:a05:6602:134a:: with SMTP id i10mr633428iov.147.1640055857152;
 Mon, 20 Dec 2021 19:04:17 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:04:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c70eef05d39f42a5@google.com>
Subject: [syzbot] general protection fault in set_task_ioprio
From:   syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    07f8c60fe60f Add linux-next specific files for 20211220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1355d295b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2060504830b9124a
dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12058fcbb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17141adbb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 3602 Comm: syz-executor484 Not tainted 5.16.0-rc5-next-20211220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:set_task_ioprio+0x2de/0x620 block/blk-ioc.c:289 block/blk-ioc.c:289
Code: 4c 8b ab 18 12 00 00 4d 85 ed 0f 84 9b 01 00 00 e8 d7 1e a4 fd 49 8d 7d 0c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 ef
RSP: 0018:ffffc90001b1fe90 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff88801f888000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83d3f779 RDI: 000000000000000c
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffaf957
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801f888948 R15: ffff88801f889218
FS:  0000555556a34300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2155cab01d CR3: 00000000149ed000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_sys_ioprio_set+0x586/0xae0 block/ioprio.c:124 block/ioprio.c:124
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2155c67cf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6f0f50c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000fb
RAX: ffffffffffffffda RBX: 000000000000cbcf RCX: 00007f2155c67cf9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc6f0f5268 R09: 00007ffc6f0f5268
R10: ffffffffffffffff R11: 0000000000000246 R12: 00007ffc6f0f50dc
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_task_ioprio+0x2de/0x620 block/blk-ioc.c:289 block/blk-ioc.c:289
Code: 4c 8b ab 18 12 00 00 4d 85 ed 0f 84 9b 01 00 00 e8 d7 1e a4 fd 49 8d 7d 0c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 ef
RSP: 0018:ffffc90001b1fe90 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff88801f888000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83d3f779 RDI: 000000000000000c
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffaf957
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801f888948 R15: ffff88801f889218
FS:  0000555556a34300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2155cab01d CR3: 00000000149ed000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 8b ab 18 12 00 00 	mov    0x1218(%rbx),%r13
   7:	4d 85 ed             	test   %r13,%r13
   a:	0f 84 9b 01 00 00    	je     0x1ab
  10:	e8 d7 1e a4 fd       	callq  0xfda41eec
  15:	49 8d 7d 0c          	lea    0xc(%r13),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 01             	add    $0x1,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 ef                	test   %ebp,%edi
----------------
Code disassembly (best guess):
   0:	4c 8b ab 18 12 00 00 	mov    0x1218(%rbx),%r13
   7:	4d 85 ed             	test   %r13,%r13
   a:	0f 84 9b 01 00 00    	je     0x1ab
  10:	e8 d7 1e a4 fd       	callq  0xfda41eec
  15:	49 8d 7d 0c          	lea    0xc(%r13),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 01             	add    $0x1,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 ef                	test   %ebp,%edi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
