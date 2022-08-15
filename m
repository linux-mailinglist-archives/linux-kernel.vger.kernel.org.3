Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2C593461
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiHOSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiHOSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:00:31 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F712AF7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:00:29 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id t7-20020a6b6407000000b00684ed320f97so4590904iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=YtpToKU6S1mKGIEzRazqNUn2SfKuWWw22c6k+Sd9uC8=;
        b=483UxfeH/GDS+sotpqkbpm+HLXBCj23uB7VSS135uFD+QlFVF02hCQFXmzO4cvH4QX
         tGQQuQvI0oYwmxoFHvgy4sF4anVwwDzt00mkmsBEo8BZ+YRrDuc+gKHW/bM+H7Xhb8xi
         /q+SJYes6/NSBRKNNAr+0KJ1eZQ8BxJlh17lHAJumRnKrXb8RGJ/MxZ5aCM9+Y7ZEki8
         1K4Lad4+Pi/Crb3o8/JvgfsXLgNXU3PSNhtTiLjdoaWZytNCG/HZBenWIrHu9qd4psEf
         UNdYThfiON8L6mQRjnPKxbXH/H5xXcCS5rcdDwNSWrQD72R3aSfCz4T5bCicNJ1zD0pm
         MSIA==
X-Gm-Message-State: ACgBeo2UL8ZeiIWoK/I9Uuh2ApTbzVtPH3QhO/wQdsD10txpucfh8zAz
        s5GP34Fx8f+MrRVH5wJcDSiAGu2ugumq2P8LlYg/gDCd4ZK0
X-Google-Smtp-Source: AA6agR5b5dvdXe+ts8VwAH39aK0wM/YeVETAMtlg4elQ1w9J0nE1HEPe7wn8bPz1g65HG3B4p1jRLBxlN/cu+MoI9CYP+Vhyp1yA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c25:b0:2df:21fd:5a6b with SMTP id
 m5-20020a056e021c2500b002df21fd5a6bmr7622010ilh.128.1660586429350; Mon, 15
 Aug 2022 11:00:29 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:00:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d898a05e64b68bd@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in copy_namespaces
From:   syzbot <syzbot+2984d1b7aef6b51353f0@syzkaller.appspotmail.com>
To:     avagin@gmail.com, brauner@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tkhai@ya.ru,
        vasily.averin@linux.dev
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1168343d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6bcb425ba129b87
dashboard link: https://syzkaller.appspot.com/bug?extid=2984d1b7aef6b51353f0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2984d1b7aef6b51353f0@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000013
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 5.19.0-syzkaller-14374-g5d6a0f4da927 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events_unbound call_usermodehelper_exec_work
RIP: 0010:copy_namespaces+0xe8/0x480 kernel/nsproxy.c:154
Code: 0e 5f 2b 00 45 85 ed 0f 84 d4 01 00 00 e8 40 62 2b 00 49 8d bf 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 42 03 00 00 4d 8b bf 98 00 00 00 e8 32 ab 15 00
RSP: 0000:ffffc90000107900 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: ffff888020118000 RCX: 0000000000000000
RDX: 1fffe00000000013 RSI: ffffffff8150a4b0 RDI: ffff000000000098
RBP: ffff000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000808100
R13: 0000000000000001 R14: ffff8880201188a0 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000013 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_process+0x305c/0x7090 kernel/fork.c:2259
 kernel_clone+0xe7/0xab0 kernel/fork.c:2673
 user_mode_thread+0xad/0xe0 kernel/fork.c:2742
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000013
---[ end trace 0000000000000000 ]---
RIP: 0010:copy_namespaces+0xe8/0x480 kernel/nsproxy.c:154
Code: 0e 5f 2b 00 45 85 ed 0f 84 d4 01 00 00 e8 40 62 2b 00 49 8d bf 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 42 03 00 00 4d 8b bf 98 00 00 00 e8 32 ab 15 00
RSP: 0000:ffffc90000107900 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: ffff888020118000 RCX: 0000000000000000
RDX: 1fffe00000000013 RSI: ffffffff8150a4b0 RDI: ffff000000000098
RBP: ffff000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000808100
R13: 0000000000000001 R14: ffff8880201188a0 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000013 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	5f                   	pop    %rdi
   1:	2b 00                	sub    (%rax),%eax
   3:	45 85 ed             	test   %r13d,%r13d
   6:	0f 84 d4 01 00 00    	je     0x1e0
   c:	e8 40 62 2b 00       	callq  0x2b6251
  11:	49 8d bf 98 00 00 00 	lea    0x98(%r15),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 42 03 00 00    	jne    0x375
  33:	4d 8b bf 98 00 00 00 	mov    0x98(%r15),%r15
  3a:	e8 32 ab 15 00       	callq  0x15ab71


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
