Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD97B59588F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiHPKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiHPKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:36:31 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F35122DBB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:36:24 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id z30-20020a05660217de00b00688bd42dc1dso408653iox.15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/TvWfojdg9EbJcM9R4DzjHXxk7wBLSZkN23d1l8mhpM=;
        b=rfA0xS8Bwto2WwaSlygkTaVBlcLxWSQuQsNY4ATqQiF2fhfUEt2HXu0zpgLMuQ0MoN
         DcLsS3bw+TB+AgtRuuJDYeJ5Lu580+a3eQYzF/4wYg+J+HAliPbP7DIFyil/p5F/QdNw
         nGLvtJfHsQJt+ozYabHG1SaPIF6DncPUFclaBN383F7rAQHmnXP4ABXuXbStUchrxmHd
         ADlOHlVf5obvVTFFrYkW0TlgLQUbS6vugTjIow43O6R8I9TlOJWm6/kyuyHG+an4xM3T
         1W1ykC1LUdfVjMeEf8svNrh4L3o6c6Gi2zI7E1ehAwcvypJ9d9LNWV6II+VuS2xp5GXd
         0t7A==
X-Gm-Message-State: ACgBeo0F8PTiHZDyLUqDAWnkFFCw3Rp3xUaPwoTQNQEoJx+WMmKth0xP
        nFEX5jQEfxGYFopWU3l0or5lReE4IjLYpcWZm2xbA72LVCe7
X-Google-Smtp-Source: AA6agR6qHad8EMda4pdSgrU8WKZFd4mpY7XdCpIDbMZDRON+uB6opHgTVle7nt7pGWjdYJQVsKFpePM1excI1f3QfRGQPbSoRKcK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b83:b0:2e5:b254:69e5 with SMTP id
 h3-20020a056e021b8300b002e5b25469e5mr4366807ili.292.1660638984171; Tue, 16
 Aug 2022 01:36:24 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:36:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0770c05e657a49b@google.com>
Subject: [syzbot] upstream boot error: general protection fault in rcu_core
From:   syzbot <syzbot+855b67e6ad52c740948a@syzkaller.appspotmail.com>
To:     Henry.Wang@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, longpeng2@huawei.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5d6a0f4da927 Merge tag 'for-linus-6.0-rc1b-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc4467080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f83c035536d7b2e3
dashboard link: https://syzkaller.appspot.com/bug?extid=855b67e6ad52c740948a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+855b67e6ad52c740948a@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff000000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000000000-0xfff8200000000007]
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.19.0-syzkaller-14374-g5d6a0f4da927 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:rcu_do_batch kernel/rcu/tree.c:2245 [inline]
RIP: 0010:rcu_core+0xa5e/0x1710 kernel/rcu/tree.c:2505
Code: 22 69 00 4d 8b 3c 24 48 b8 00 00 00 00 00 fc ff df 80 3c 03 00 74 08 4c 89 e7 e8 6d 22 69 00 49 c7 46 08 00 00 00 00 4c 89 f7 <41> ff d7 48 c7 c7 60 08 d2 8c e8 e3 0c 00 00 65 8b 05 64 5f 8e 7e
RSP: 0000:ffffc900001b7aa0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff11004137a06 RCX: ffff888012eb27f0
RDX: dffffc0000000000 RSI: ffffffff8aad87c0 RDI: ffff8880209bd028
RBP: ffffc900001b7cb0 R08: dffffc0000000000 R09: fffffbfff1ff3a0c
R10: fffffbfff1ff3a0c R11: 1ffffffff1ff3a0b R12: ffff8880209bd030
R13: ffff888012eb1d80 R14: ffff8880209bd028 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_softirq+0x382/0x793 kernel/softirq.c:571
 run_ksoftirqd+0xc1/0x120 kernel/softirq.c:934
 smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
vkms_vblank_simulate: vblank timer overrun
---[ end trace 0000000000000000 ]---
RIP: 0010:rcu_do_batch kernel/rcu/tree.c:2245 [inline]
RIP: 0010:rcu_core+0xa5e/0x1710 kernel/rcu/tree.c:2505
Code: 22 69 00 4d 8b 3c 24 48 b8 00 00 00 00 00 fc ff df 80 3c 03 00 74 08 4c 89 e7 e8 6d 22 69 00 49 c7 46 08 00 00 00 00 4c 89 f7 <41> ff d7 48 c7 c7 60 08 d2 8c e8 e3 0c 00 00 65 8b 05 64 5f 8e 7e
RSP: 0000:ffffc900001b7aa0 EFLAGS: 00010246

RAX: dffffc0000000000 RBX: 1ffff11004137a06 RCX: ffff888012eb27f0
RDX: dffffc0000000000 RSI: ffffffff8aad87c0 RDI: ffff8880209bd028
RBP: ffffc900001b7cb0 R08: dffffc0000000000 R09: fffffbfff1ff3a0c
R10: fffffbfff1ff3a0c R11: 1ffffffff1ff3a0b R12: ffff8880209bd030
R13: ffff888012eb1d80 R14: ffff8880209bd028 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	22 69 00             	and    0x0(%rcx),%ch
   3:	4d 8b 3c 24          	mov    (%r12),%r15
   7:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   e:	fc ff df
  11:	80 3c 03 00          	cmpb   $0x0,(%rbx,%rax,1)
  15:	74 08                	je     0x1f
  17:	4c 89 e7             	mov    %r12,%rdi
  1a:	e8 6d 22 69 00       	callq  0x69228c
  1f:	49 c7 46 08 00 00 00 	movq   $0x0,0x8(%r14)
  26:	00
  27:	4c 89 f7             	mov    %r14,%rdi
* 2a:	41 ff d7             	callq  *%r15 <-- trapping instruction
  2d:	48 c7 c7 60 08 d2 8c 	mov    $0xffffffff8cd20860,%rdi
  34:	e8 e3 0c 00 00       	callq  0xd1c
  39:	65 8b 05 64 5f 8e 7e 	mov    %gs:0x7e8e5f64(%rip),%eax        # 0x7e8e5fa4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
