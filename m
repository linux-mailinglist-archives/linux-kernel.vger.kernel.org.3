Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6459B23B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiHUGO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHUGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:14:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B13201A2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:14:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d4-20020a056e02214400b002df95f624a4so6147922ilv.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=eV2jx31Jf/FUCEOtEwL3jkzCecCxlxTQkyDn/NcBZ4E=;
        b=WDX2tJATdqb2RMxxE0FCgXm5aiOV3cr6iEEp28aUjSfcLCUdODnDi35H58Qc0S8BZX
         SkWFv7Muo14jJiAIC/GKz+DfLZ6vusvofJVSp9Ox7UoAFKD5KiUvizNMvfBGunq1yQ7h
         uDCccziCS2I0ZJqEbszSVwZ41hf8rWB/YgY3L9O9Qlui6UcIIUtuk5AUP+xbEiySE+45
         Yr4FEBtEOF5t/1LwjY8sODvk4D9C6WjPPc8hvx2ObHzeI7WsRePSAUDEOmutHIbpETRL
         wi5g+tfA3W4cCJiz7CaZMWUL4ldZ8/3XHALDdrUTUwEmqHTVe0+FgkLvz99ZzzDmKNq2
         tKfw==
X-Gm-Message-State: ACgBeo3IElMh8k8nBtvAGyVYhvJLgeX3V1bp0ja1pjNqcS3/uZNnrIat
        gTYBahM/EcwvfA2aaWtPzjWSfO3sJ9KRZvoq2izoMXs6LMUY
X-Google-Smtp-Source: AA6agR4n1vxDBlDIVXl2kq/W2IunDdEzgnnFA5ml8c2iICy746iKR27U6HDvybqXZAckDmd7aGCVm7+rgm5udNW4yRL+l3FYrTTi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a7:b0:346:dbd8:d4eb with SMTP id
 t39-20020a05663834a700b00346dbd8d4ebmr6788760jal.57.1661062464956; Sat, 20
 Aug 2022 23:14:24 -0700 (PDT)
Date:   Sat, 20 Aug 2022 23:14:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c73fd05e6ba3e0b@google.com>
Subject: [syzbot] general protection fault in vma_is_shmem
From:   syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    95d10484d66e Add linux-next specific files for 20220817
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15133023080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=681bbbb80445ead3c040
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1100a92d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123d1867080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 1 PID: 3607 Comm: syz-executor359 Not tainted 6.0.0-rc1-next-20220817-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:vma_is_shmem+0x21/0x40 mm/shmem.c:254
Code: 73 02 e9 20 fc ff ff 66 90 53 48 89 fb e8 07 2c cf ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 10 48 81 bb 90 00 00 00 20 8f f7 89 5b 0f 94 c0 c3
RSP: 0018:ffffc900037cfb68 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000012 RSI: ffffffff81ace949 RDI: 0000000000000090
RBP: ffff888071b00720 R08: 0000000000000006 R09: 00000000000000e4
R10: 0000000000008001 R11: 0000000000000000 R12: 00000000000000e4
R13: ffff888071b00000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555556ab5300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3c8f13260 CR3: 00000000718f5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 io_pin_pages+0x25f/0x430 io_uring/rsrc.c:1207
 io_sqe_buffer_register+0x14e/0x13b0 io_uring/rsrc.c:1254
 io_sqe_buffers_register.cold+0x351/0x445 io_uring/rsrc.c:1346
 __io_uring_register io_uring/io_uring.c:3711 [inline]
 __do_sys_io_uring_register+0x96d/0x1110 io_uring/io_uring.c:3878
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f548fcdfbb9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc644b88f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f548fcdfbb9
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f548fca3d60 R08: 0000000010000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f548fca3df0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_is_shmem+0x21/0x40 mm/shmem.c:254
Code: 73 02 e9 20 fc ff ff 66 90 53 48 89 fb e8 07 2c cf ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 10 48 81 bb 90 00 00 00 20 8f f7 89 5b 0f 94 c0 c3
RSP: 0018:ffffc900037cfb68 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000012 RSI: ffffffff81ace949 RDI: 0000000000000090
RBP: ffff888071b00720 R08: 0000000000000006 R09: 00000000000000e4
R10: 0000000000008001 R11: 0000000000000000 R12: 00000000000000e4
R13: ffff888071b00000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555556ab5300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3c8f13260 CR3: 00000000718f5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	73 02                	jae    0x4
   2:	e9 20 fc ff ff       	jmpq   0xfffffc27
   7:	66 90                	xchg   %ax,%ax
   9:	53                   	push   %rbx
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	e8 07 2c cf ff       	callq  0xffcf2c19
  12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 10                	jne    0x40
  30:	48 81 bb 90 00 00 00 	cmpq   $0xffffffff89f78f20,0x90(%rbx)
  37:	20 8f f7 89
  3b:	5b                   	pop    %rbx
  3c:	0f 94 c0             	sete   %al
  3f:	c3                   	retq


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
