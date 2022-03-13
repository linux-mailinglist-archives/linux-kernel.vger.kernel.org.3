Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EFE4D72D0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiCMFgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCMFgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:36:35 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212F624BF9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:35:26 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id y7-20020a056e02128700b002c62013aaa6so7186863ilq.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j3QVeTqDupds0I2GmAX2joYrfRgvBoY7gI4v066BCts=;
        b=TZcwuxJunLvQcajMincIvFrcsnnI7JCusl7GFSxckedwH2EpFDgSNx4OQkLv4CdFO+
         7gtbIU0UJAr+TiWLxPKWs/tixwoN1SjzAohjQ1naLqFDZx05JN3KPYaEo7pghEhkYQ8W
         NkWwkElzGzKcG3zcEEQUM8iWXGRfgE/8LVvgiHiPXYyyU8nw7h9CDgO2YNfgQHLmvDSa
         ZR6dPkqUFSjwixdZz+hItQ8kHRHLUL0LkdkW1Do5VvNQ796qnlq971a3RM9LD9ol5eWQ
         YNnm3vqZBQxrgYRGIW+Z11TkHQKbSYHHWGumzn0VETf8RB8txhdgxeFzkA/gnh04rrsL
         gzMQ==
X-Gm-Message-State: AOAM5300unaWK8BsCBk/VPz2/FVuPz1xDVrjkhGBy6ATKnqZkKbKVFSK
        CrxgtOaaMvyaeV9/7iCmP+fpz6lYqzSspzegEdHEtlw4DniV
X-Google-Smtp-Source: ABdhPJzyQkwRsmmFLCuJXHTJ0EzTiQU7r8wIsUdsQXOFYLMLVUzVeJrDYZvNf14ZOqXsOAQumj5EQ0RhXT6EkBXWJUxCqjUbADh+
MIME-Version: 1.0
X-Received: by 2002:a5d:8552:0:b0:63d:8cae:b2ca with SMTP id
 b18-20020a5d8552000000b0063d8caeb2camr14515240ios.81.1647149725464; Sat, 12
 Mar 2022 21:35:25 -0800 (PST)
Date:   Sat, 12 Mar 2022 21:35:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000473c1a05da12ee25@google.com>
Subject: [syzbot] general protection fault in __pm_runtime_resume (2)
From:   syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    92f90cc9fe0e Merge tag 'fuse-fixes-5.17-rc8' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118cd3be700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b64e79700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1652811a700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000072: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000390-0x0000000000000397]
CPU: 0 PID: 46 Comm: kworker/u5:0 Not tainted 5.17.0-rc7-syzkaller-00060-g92f90cc9fe0e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_cmd_work
RIP: 0010:__pm_runtime_resume+0x45/0x170 drivers/base/power/runtime.c:1126
Code: 44 89 ee e8 2d af 02 fd 45 85 ed 75 4e e8 a3 ab 02 fd 48 8d bd 91 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 03 01 00 00
RSP: 0018:ffffc9000116fc28 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888022f8d000 RCX: 0000000000000000
RDX: 0000000000000072 RSI: ffffffff8476148d RDI: 0000000000000391
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffc4a0f
R10: ffffffff84761483 R11: 000000000000000a R12: 0000000000000004
R13: 0000000000000000 R14: ffff888022f8d190 R15: ffff888022f8d128
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc3fad2418 CR3: 000000007f4c3000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 pm_runtime_get_sync include/linux/pm_runtime.h:420 [inline]
 h5_enqueue+0x175/0x390 drivers/bluetooth/hci_h5.c:632
 hci_uart_send_frame+0x1ee/0x6b0 drivers/bluetooth/hci_ldisc.c:286
 hci_send_frame+0x1c0/0x370 net/bluetooth/hci_core.c:2942
 hci_cmd_work+0x204/0x3c0 net/bluetooth/hci_core.c:3861
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__pm_runtime_resume+0x45/0x170 drivers/base/power/runtime.c:1126
Code: 44 89 ee e8 2d af 02 fd 45 85 ed 75 4e e8 a3 ab 02 fd 48 8d bd 91 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 03 01 00 00
RSP: 0018:ffffc9000116fc28 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888022f8d000 RCX: 0000000000000000
RDX: 0000000000000072 RSI: ffffffff8476148d RDI: 0000000000000391
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffc4a0f
R10: ffffffff84761483 R11: 000000000000000a R12: 0000000000000004
R13: 0000000000000000 R14: ffff888022f8d190 R15: ffff888022f8d128
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f989adfd718 CR3: 000000007683c000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	44 89 ee             	mov    %r13d,%esi
   3:	e8 2d af 02 fd       	callq  0xfd02af35
   8:	45 85 ed             	test   %r13d,%r13d
   b:	75 4e                	jne    0x5b
   d:	e8 a3 ab 02 fd       	callq  0xfd02abb5
  12:	48 8d bd 91 03 00 00 	lea    0x391(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 03 01 00 00    	jne    0x143


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
