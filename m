Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6558BA7D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiHGJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiHGJve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:51:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B18DEA1
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 02:51:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y13so11769415ejp.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 02:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=t+nFNhIsAk2FHUTBJl3PK3l//DsrDW9/vvZGidpWC9A=;
        b=hk0Qn7d2uOyIgAo3G+8tM7L15JPxp8nA83qpg+wnYvwaKWv7E019I+cUbvnRyhnKBr
         TOMN1wx4esWSntaqMQq/DhGIWnItwTFdyvATi2syVFdH2z5qmxYjpqOMCwdILzQPfDXL
         RJCFokkZTL/UeaTYnrKL7v1cRCmEPNUUjkE5xCsyE5kgZ/LliI+1yRVpKcf5AARInqXE
         W3hfGggCH94g911Hq3BPhz+tv3qjapIUbIB1cNZnHLYG4XrruSXi+LzVLXOqmuKn7e3l
         MI0kLNuYBll3rjXG886dSDLMZvu7c6gFRNoGvVrlaGxLeJmaMJuC+JN2E4lANew9IfTf
         ++8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=t+nFNhIsAk2FHUTBJl3PK3l//DsrDW9/vvZGidpWC9A=;
        b=uAwyn1ZibldzkrNzCv6jMtYDjSk3UD3nlDKEIc3hd/rgxV9cDYbclNa6f9IdskR29p
         DSE74h2hRKohb0wnh+9zI3fMinPz0arw9DRQGFY2FbzleNF96a0+bR2J6N+Ye526tsQb
         5D/bS8SRRieD7DfpixCnBM0fnLOYoNnajHwwWESP1KIYheC+5i7zCHk/WBDwGJxa7ykf
         jFsLIQvLJUjKO1cnNwPabAa4lKeNbNeVfQnz3VRAep1GHS049ZmwndVVE8zwrPZkLzVQ
         9t8cpHCdV9ZkmQGTew5xqzXjetzWOYzhp2XIFTvGzqvzX6nFZTmevfVTfVT/f00Hbqzu
         d05w==
X-Gm-Message-State: ACgBeo0gmiJK4AjkkaCkujQFpSfekeYG+Rew/UPsT5EVcLOPwF+7/TX9
        2z34rrSqF0PNlX9Gi3H7cFZ6XQyRV0kzJIWp5Is=
X-Google-Smtp-Source: AA6agR7/EEIyMOP8/4/UpzsSBhIx15A7ZLil+O5X2K+Gx1NtYgfLcxTTR6WCwQ0w6KOMYzGzjUZZWRQnMLPjxYdgo9E=
X-Received: by 2002:a17:906:d555:b0:730:d5c7:8b65 with SMTP id
 cr21-20020a170906d55500b00730d5c78b65mr10441860ejc.235.1659865891448; Sun, 07
 Aug 2022 02:51:31 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 7 Aug 2022 17:50:56 +0800
Message-ID: <CAO4mrfcuEtSQFj0MEEagWz7bYiYtg9+iCb_j4QstXc9217YZnw@mail.gmail.com>
Subject: general protection fault in put_page
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 31f4f5b495a6 Linux 5.4-rc7
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1rjxlk2_QNsl6CcOwElvUSq5Yhcafb6Il/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1MFN7c56voPBkd7LzgO0mGZ_oOQNHyK-w/view?usp=sharing
kernel config: https://drive.google.com/file/d/1sFjtE830MyLBJYZzwZ9sJRsKdf5EzUTV/view?usp=sharing

However, we tried to use syz-prog2c to convert the Syzlang reproducer
to C format. But the crash wasn't reproduced by the C program. Please
use syz-execprog to execute the Syzlang reproducer directly on kernel
to reproduce the bug.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 16421 Comm: syz-executor Not tainted 5.4.0-rc7+ #28
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:put_page+0x25/0x1e0
Code: 00 00 00 00 00 55 41 57 41 56 41 54 53 49 89 fe 49 bc 00 00 00
00 00 fc ff df e8 96 b0 18 fd 49 8d 7e 08 48 89 f8 48 c1 e8 03 <42> 80
3c 20 00 74 05 e8 3f 9a 53 fd 49 8b 6e 08 89 eb 83 e3 01 31
RSP: 0018:ffff888090927b60 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 1ffff1100bfc9c58 RCX: 0000000000040000
RDX: ffffc90001b01000 RSI: 0000000000005d4e RDI: 0000000000000008
RBP: 00000000fffffff2 R08: ffffffff84567149 R09: ffffed1014392357
R10: ffffed1014392357 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88805fe4ea00 R14: 0000000000000000 R15: ffff88805fe4e2c0
FS:  00007f3188c14700(0000) GS:ffff888064000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f318b71c930 CR3: 000000010b399000 CR4: 0000000000742ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 qp_host_get_user_memory+0x29f/0x540
 qp_broker_alloc+0x13aa/0x2850
 vmci_qp_broker_alloc+0x46/0x60
 vmci_host_unlocked_ioctl+0x1460/0x3080
 do_vfs_ioctl+0x7d2/0x18a0
 __x64_sys_ioctl+0xd9/0x120
 do_syscall_64+0xda/0x200
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f318b6aba3d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3188c13c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f318b7d20a0 RCX: 00007f318b6aba3d
RDX: 0000000020000100 RSI: 00000000000007a8 RDI: 0000000000000003
RBP: 00007f318b724d80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f318b7d20a0
R13: 00007ffd7552eb3f R14: 00007ffd7552ece0 R15: 00007f3188c13dc0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace bb9c6e0f73b79e40 ]---
RIP: 0010:put_page+0x25/0x1e0
Code: 00 00 00 00 00 55 41 57 41 56 41 54 53 49 89 fe 49 bc 00 00 00
00 00 fc ff df e8 96 b0 18 fd 49 8d 7e 08 48 89 f8 48 c1 e8 03 <42> 80
3c 20 00 74 05 e8 3f 9a 53 fd 49 8b 6e 08 89 eb 83 e3 01 31
RSP: 0018:ffff888090927b60 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 1ffff1100bfc9c58 RCX: 0000000000040000
RDX: ffffc90001b01000 RSI: 0000000000005d4e RDI: 0000000000000008
RBP: 00000000fffffff2 R08: ffffffff84567149 R09: ffffed1014392357
R10: ffffed1014392357 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88805fe4ea00 R14: 0000000000000000 R15: ffff88805fe4e2c0
FS:  00007f3188c14700(0000) GS:ffff888064000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f434ae59000 CR3: 000000010b399000 CR4: 0000000000742ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: 00 00                add    %al,(%rax)
   2: 00 00                add    %al,(%rax)
   4: 00 55 41              add    %dl,0x41(%rbp)
   7: 57                    push   %rdi
   8: 41 56                push   %r14
   a: 41 54                push   %r12
   c: 53                    push   %rbx
   d: 49 89 fe              mov    %rdi,%r14
  10: 49 bc 00 00 00 00 00 movabs $0xdffffc0000000000,%r12
  17: fc ff df
  1a: e8 96 b0 18 fd        callq  0xfd18b0b5
  1f: 49 8d 7e 08          lea    0x8(%r14),%rdi
  23: 48 89 f8              mov    %rdi,%rax
  26: 48 c1 e8 03          shr    $0x3,%rax
* 2a: 42 80 3c 20 00        cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f: 74 05                je     0x36
  31: e8 3f 9a 53 fd        callq  0xfd539a75
  36: 49 8b 6e 08          mov    0x8(%r14),%rbp
  3a: 89 eb                mov    %ebp,%ebx
  3c: 83 e3 01              and    $0x1,%ebx
  3f: 31                    .byte 0x31

Best,
Wei
