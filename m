Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A562F5957FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiHPKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiHPKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:20:28 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2F65656
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:40:24 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i4-20020a056e0212c400b002e5c72b3bd7so2963397ilm.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Dwh0gS8jFs64hNlsf+lze9dSVRbAm8u7yK5LBD0pdLg=;
        b=z/K4yMb54VzlNG1MbQLf3QIHeCqypbUXDKSmZAMKJPe+LjNcjfKC/kpDrKN6tNolYO
         QCk0SLQBXGV4ZTW70e6T53wXcFiZszWDZPuk1sBu/jmnACOdvomTCuGL3qF/gmFWQOuP
         sBNb0CKpHeIDKXg0W0Vgxx8N3kv14TJGZgfZcN1p4cHtQQyzqcDzN3XZYV4qK/qxT4Mz
         NnALJKhzAXlE4+3GsajWQM3mFNGAeMKB5qaNpFwrlhCWMIMPdPaconkqGI4Q1ceTbDF+
         4F2jeKJYZ1F98I+L1dCyqVj0noUICes8l9JzcDnbtUegLPhdQslduo1v/n8wMBKLdHb0
         wp/Q==
X-Gm-Message-State: ACgBeo3q+6ceRR4gmRQ0/qlB4zhdh64w4bCNlc4TzTEeNKoRJawkUgfE
        0wXcBzC/d25QXk6Eq1CEyUDjG2z4p9IzVNjqsCmpYWcmCOdI
X-Google-Smtp-Source: AA6agR5JuP2uqd8wNlSCkhc1kduZjGIqEpA1RqxELHnxLkd+IhD9MVUPeRbpXgTi1daetG2qSY6uOlsAAjkVx9Zb6Lkaj+8Y/c/v
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:2e5:d3dc:3d28 with SMTP id
 q6-20020a92ca46000000b002e5d3dc3d28mr3090095ilo.238.1660639224209; Tue, 16
 Aug 2022 01:40:24 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f266f05e657b373@google.com>
Subject: [syzbot] upstream boot error: general protection fault in timerqueue_del
From:   syzbot <syzbot+621d4ae5dc548c7ac3f6@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    4a9350597aff Merge tag 'sound-fix-6.0-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1249c047080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4757943c2b26daff
dashboard link: https://syzkaller.appspot.com/bug?extid=621d4ae5dc548c7ac3f6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+621d4ae5dc548c7ac3f6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffdffe0000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x00000fff00000000-0x00000fff00000007]
CPU: 0 PID: 1108 Comm: kworker/u4:3 Not tainted 5.19.0-syzkaller-14090-g4a9350597aff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:timerqueue_del+0x26/0xf0 lib/timerqueue.c:55
Code: 0f 1f 40 00 55 41 57 41 56 41 55 41 54 53 49 89 f5 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 21 3a 20 fd 4d 89 ec 49 c1 ec 03 <41> 80 3c 2c 00 74 08 4c 89 ef e8 cb d8 73 fd 49 8b 5d 00 48 89 df
RSP: 0000:ffffc90004ebfc30 EFLAGS: 00010006

RAX: ffffffff846958af RBX: 00000fff00000000 RCX: ffff888020858000
RDX: 0000000000000000 RSI: 00000fff00000000 RDI: ffff8880207744d8
RBP: dffffc0000000000 R08: dffffc0000000000 R09: fffff520009d7f84
R10: fffff520009d7f85 R11: 1ffff920009d7f84 R12: 000001ffe0000000
R13: 00000fff00000000 R14: ffff8880207744d8 R15: ffff8880207744d8
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cleanup_timerqueue kernel/time/posix-cpu-timers.c:519 [inline]
 cleanup_timers kernel/time/posix-cpu-timers.c:534 [inline]
 posix_cpu_timers_exit_group+0x7b/0x200 kernel/time/posix-cpu-timers.c:550
 __exit_signal kernel/exit.c:109 [inline]
 release_task+0x5b8/0x1890 kernel/exit.c:203
 exit_notify kernel/exit.c:708 [inline]
 do_exit+0x16ac/0x20a0 kernel/exit.c:815
 call_usermodehelper_exec_async+0x3a1/0x3b0 kernel/umh.c:125
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:timerqueue_del+0x26/0xf0 lib/timerqueue.c:55
Code: 0f 1f 40 00 55 41 57 41 56 41 55 41 54 53 49 89 f5 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 21 3a 20 fd 4d 89 ec 49 c1 ec 03 <41> 80 3c 2c 00 74 08 4c 89 ef e8 cb d8 73 fd 49 8b 5d 00 48 89 df
RSP: 0000:ffffc90004ebfc30 EFLAGS: 00010006

RAX: ffffffff846958af RBX: 00000fff00000000 RCX: ffff888020858000
RDX: 0000000000000000 RSI: 00000fff00000000 RDI: ffff8880207744d8
RBP: dffffc0000000000 R08: dffffc0000000000 R09: fffff520009d7f84
R10: fffff520009d7f85 R11: 1ffff920009d7f84 R12: 000001ffe0000000
R13: 00000fff00000000 R14: ffff8880207744d8 R15: ffff8880207744d8
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 1f 40 00          	nopl   0x0(%rax)
   4:	55                   	push   %rbp
   5:	41 57                	push   %r15
   7:	41 56                	push   %r14
   9:	41 55                	push   %r13
   b:	41 54                	push   %r12
   d:	53                   	push   %rbx
   e:	49 89 f5             	mov    %rsi,%r13
  11:	49 89 fe             	mov    %rdi,%r14
  14:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  1b:	fc ff df
  1e:	e8 21 3a 20 fd       	callq  0xfd203a44
  23:	4d 89 ec             	mov    %r13,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	41 80 3c 2c 00       	cmpb   $0x0,(%r12,%rbp,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 cb d8 73 fd       	callq  0xfd73d904
  39:	49 8b 5d 00          	mov    0x0(%r13),%rbx
  3d:	48 89 df             	mov    %rbx,%rdi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
