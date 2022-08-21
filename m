Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7D59B14D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiHUCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHUCY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 22:24:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D37C17E12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 19:24:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d4-20020a056e02214400b002df95f624a4so5868259ilv.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 19:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ZkQ+tSj3l+CUm/s178yfy5BsSHK6Pg43cAFHqzCNADQ=;
        b=1vDW+9a8WoO8gmpUQ2mytvXZGYqjPhdOb76QNyAf607dW4c7rNFXJ4+o1s188BY/ss
         tcrK7oBepE2CLca1RqD3ZVDs6MzXqS7loGPiJqnBWWuB3C6qBXYWON9kXdV1VX8dM4Cf
         VyKy+kwiXdkCzAFg8STF0+rNMIeFPC7vSOWVfz7hJsBW3jRxqC7cbrxu8bP/pS0eWSue
         LXBZ235LIRTpnqiiw4xBvoS51ECHljAWEg1FYAv8WOrhR4csa39mkHwLMaYqoC/hiiws
         H6U60jc+ZsLEwI09XOcl4EFh81jX4anDC7OarLVF4AmwYVzYpfpSmkBRdnTxhTYA7LBR
         tlgw==
X-Gm-Message-State: ACgBeo07jaAktTSNKFLyLgM/sTU/nWSQxL63eVtE/8eSfM7LNVFFza+I
        OiyfH9es3nicTaTrq8TMDAaEISNbQdgX8J+Y5O+mG/bHWpnC
X-Google-Smtp-Source: AA6agR5GjmwpuXyQRzHMt/TkRuKNUQ7AAiP+0iog5hVaeAW5wLIuaWDAQoIKQtD87oNcOWoPevDncIZHUlrgXy1jTH6su86XOxcK
MIME-Version: 1.0
X-Received: by 2002:a6b:3ec2:0:b0:67c:6baf:a51f with SMTP id
 l185-20020a6b3ec2000000b0067c6bafa51fmr6363033ioa.160.1661048664532; Sat, 20
 Aug 2022 19:24:24 -0700 (PDT)
Date:   Sat, 20 Aug 2022 19:24:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009aaff105e6b70769@google.com>
Subject: [syzbot] upstream boot error: kernel panic: corrupted stack end in call_usermodehelper_exec_async
From:   syzbot <syzbot+af5fc6463cba536a92cb@syzkaller.appspotmail.com>
To:     brauner@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14a080cb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=af5fc6463cba536a92cb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af5fc6463cba536a92cb@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 1098 Comm: kworker/u4:4 Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2c8/0x627 kernel/panic.c:274
 schedule_debug kernel/sched/core.c:5737 [inline]
 __schedule+0x52a8/0x52b0 kernel/sched/core.c:6388
 do_task_dead+0xd1/0x100 kernel/sched/core.c:6512
 do_exit+0x18be/0x29b0 kernel/exit.c:847
 call_usermodehelper_exec_async+0x418/0x580 kernel/umh.c:125
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
general protection fault, maybe for address 0x80000002: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1098 Comm: kworker/u4:4 Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:delay_tsc+0x9b/0xb0 arch/x86/lib/delay.c:97
Code: e8 54 d4 db fc eb b4 48 29 dd 49 01 ed eb 93 bf 01 00 00 00 e8 e6 19 2e fd 65 8b 05 af ce dd 7b 85 c0 74 07 5b 5d 41 5c 41 5d <c3> e8 29 d4 db fc 5b 5d 41 5c 41 5d c3 0f 1f 84 00 00 00 00 00 48
RSP: 0000:ffffc90004e8fbe8 EFLAGS: 00010082
RAX: 0000000080000002 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000004 RSI: 0000000000000003 RDI: 0000000000000001
RBP: ffff000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000044 R11: 6e69746f6f626552 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000043 R15: 0000000000000043
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:delay_tsc+0x9b/0xb0 arch/x86/lib/delay.c:97
Code: e8 54 d4 db fc eb b4 48 29 dd 49 01 ed eb 93 bf 01 00 00 00 e8 e6 19 2e fd 65 8b 05 af ce dd 7b 85 c0 74 07 5b 5d 41 5c 41 5d <c3> e8 29 d4 db fc 5b 5d 41 5c 41 5d c3 0f 1f 84 00 00 00 00 00 48
RSP: 0000:ffffc90004e8fbe8 EFLAGS: 00010082
RAX: 0000000080000002 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000004 RSI: 0000000000000003 RDI: 0000000000000001
RBP: ffff000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000044 R11: 6e69746f6f626552 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000043 R15: 0000000000000043
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 54 d4 db fc       	callq  0xfcdbd459
   5:	eb b4                	jmp    0xffffffbb
   7:	48 29 dd             	sub    %rbx,%rbp
   a:	49 01 ed             	add    %rbp,%r13
   d:	eb 93                	jmp    0xffffffa2
   f:	bf 01 00 00 00       	mov    $0x1,%edi
  14:	e8 e6 19 2e fd       	callq  0xfd2e19ff
  19:	65 8b 05 af ce dd 7b 	mov    %gs:0x7bddceaf(%rip),%eax        # 0x7bddcecf
  20:	85 c0                	test   %eax,%eax
  22:	74 07                	je     0x2b
  24:	5b                   	pop    %rbx
  25:	5d                   	pop    %rbp
  26:	41 5c                	pop    %r12
  28:	41 5d                	pop    %r13
* 2a:	c3                   	retq <-- trapping instruction
  2b:	e8 29 d4 db fc       	callq  0xfcdbd459
  30:	5b                   	pop    %rbx
  31:	5d                   	pop    %rbp
  32:	41 5c                	pop    %r12
  34:	41 5d                	pop    %r13
  36:	c3                   	retq
  37:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  3e:	00
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
