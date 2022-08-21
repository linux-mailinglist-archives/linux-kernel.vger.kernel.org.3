Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9980659B131
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 03:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiHUBE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 21:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiHUBEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 21:04:39 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9F140ED
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 18:04:25 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso5800579ilk.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 18:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=c+ysmxoPi5wLTW8ulkljidwSbpOY/TRUbnPZN/sjKuQ=;
        b=llYl7dEfsqAZEHLu9XnA4mN6idzmIOBBAL+bxPoltTwMI4rw4m9p9uFqus2RosCVs4
         mQ1ORbENMNpDqfh601F5rCeqVSlvmvMofFvPS24kfeTsTMQIaNGvFMmn7XWQ7STXOmqH
         pAnoC0bONlsJWoX+EalWg5TI9IGgzlrCPEcvpzAINc3H2hj7W+TpgHHsMowhh5fmCvQT
         eO1YroGUNrDWS8Rq0J5TCR6NnpGD9LjGRsRsojGxBJbgvvAtURtwtjwMDgYbgl4dDdOU
         Zzasg6qhY16ihR15czkEMFMFLFpO9BzRDaWoTrAYzuQaEvJzgeZQY240bnV488JTiWIW
         jYBw==
X-Gm-Message-State: ACgBeo0Bi31ZX/7AtPrDqGz+GVYN0nf0vRbnarMvJdc579psUghePNOZ
        2zo07zDevy5GyoUalB0XKeda9lC6rb+TnxGJraulig9nXSe2
X-Google-Smtp-Source: AA6agR5pV9wew+rVsP+QRsT6GcNoMxauAbIF6Qgc0I4IDunu6jDIBV/K0BBAUDEH8qW6uP9JL+kdjqt/WEOUSie/SFGMC/rQ4v/k
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:341:de68:602c with SMTP id
 r21-20020a056638301500b00341de68602cmr6412311jak.10.1661043865222; Sat, 20
 Aug 2022 18:04:25 -0700 (PDT)
Date:   Sat, 20 Aug 2022 18:04:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b056305e6b5e93a@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in qlist_free_all
From:   syzbot <syzbot+6927c4059ebce5111574@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    3cc40a443a04 Merge tag 'nios2_fixes_v6.0' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10938a47080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e706e91b2a433db
dashboard link: https://syzkaller.appspot.com/bug?extid=6927c4059ebce5111574
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6927c4059ebce5111574@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000018
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2972 Comm: udevadm Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:qlink_to_cache mm/kasan/quarantine.c:131 [inline]
RIP: 0010:qlist_free_all+0x13b/0x1b0 mm/kasan/quarantine.c:184
Code: ff ff 48 c1 e5 06 48 01 c5 48 8b 45 08 a8 01 75 79 66 90 48 89 ef e8 84 fe ff ff 48 8b 00 f6 c4 02 b8 00 00 00 00 48 0f 44 e8 <4c> 8b 7d 18 e9 39 ff ff ff 48 8b 04 24 48 c7 40 08 00 00 00 00 48
RSP: 0018:ffffc900030afc28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888000006301 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8136e5f4 RDI: ffffea0000000180
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801bde3000 R14: ffff88801bde3000 R15: 0000000000000000
FS:  00007fb5f1aa9840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 000000007cefe000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x97/0xb0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc mm/slab.c:3294 [inline]
 __do_kmalloc mm/slab.c:3684 [inline]
 __kmalloc+0x315/0x4a0 mm/slab.c:3695
 kmalloc include/linux/slab.h:605 [inline]
 kernfs_fop_write_iter+0x231/0x610 fs/kernfs/file.c:331
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb5f17259a3
Code: 8b 15 d9 f4 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007fff80b14e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fff80b16f41 RCX: 00007fb5f17259a3
RDX: 0000000000000003 RSI: 00007fff80b16f41 RDI: 0000000000000003
RBP: 000055910f241e30 R08: 0000000000000000 R09: 00007fb5f17f5a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007fff80b14e58 R14: 0000000000000000 R15: 000055910e4de0b4
 </TASK>
Modules linked in:
CR2: 0000000000000018
---[ end trace 0000000000000000 ]---
RIP: 0010:qlink_to_cache mm/kasan/quarantine.c:131 [inline]
RIP: 0010:qlist_free_all+0x13b/0x1b0 mm/kasan/quarantine.c:184
Code: ff ff 48 c1 e5 06 48 01 c5 48 8b 45 08 a8 01 75 79 66 90 48 89 ef e8 84 fe ff ff 48 8b 00 f6 c4 02 b8 00 00 00 00 48 0f 44 e8 <4c> 8b 7d 18 e9 39 ff ff ff 48 8b 04 24 48 c7 40 08 00 00 00 00 48
RSP: 0018:ffffc900030afc28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888000006301 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8136e5f4 RDI: ffffea0000000180
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801bde3000 R14: ffff88801bde3000 R15: 0000000000000000
FS:  00007fb5f1aa9840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 000000007cefe000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	ff 48 c1             	decl   -0x3f(%rax)
   3:	e5 06                	in     $0x6,%eax
   5:	48 01 c5             	add    %rax,%rbp
   8:	48 8b 45 08          	mov    0x8(%rbp),%rax
   c:	a8 01                	test   $0x1,%al
   e:	75 79                	jne    0x89
  10:	66 90                	xchg   %ax,%ax
  12:	48 89 ef             	mov    %rbp,%rdi
  15:	e8 84 fe ff ff       	callq  0xfffffe9e
  1a:	48 8b 00             	mov    (%rax),%rax
  1d:	f6 c4 02             	test   $0x2,%ah
  20:	b8 00 00 00 00       	mov    $0x0,%eax
  25:	48 0f 44 e8          	cmove  %rax,%rbp
* 29:	4c 8b 7d 18          	mov    0x18(%rbp),%r15 <-- trapping instruction
  2d:	e9 39 ff ff ff       	jmpq   0xffffff6b
  32:	48 8b 04 24          	mov    (%rsp),%rax
  36:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  3d:	00
  3e:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
