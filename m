Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045F2595868
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiHPKdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiHPKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:33:22 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39CB3DF01
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id y4-20020a056e021be400b002e5a1e77e04so4008328ilv.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=JkpVsI0vVPj8RzizLdCZTqU3XDY5DwFa0e5r86U/htQ=;
        b=JIopR43K+IuqkhTWKYtz+hmTrtViVYUbeBJ6G2shtfZcbg7SwrQzKPl+SpWq0sZwkO
         Qbc4LEmWURN1sUQXFosRuWGqo6PA1+LxrZdOabMkhiSmP6fPoRhoQLP7lbLJxImP7jIW
         R7iolR3JBOX85Xc/Fws0Vke4Wzdw+5Zckn8d+c0VqL9+tUBJe/6Jzj3ws+4h/O/fgEQ0
         vHP7A3Gh2fFGFrTwx2OgoYQvJ82/dwUo9XqDjN852+Kd8lO742/K3CQNIGxglU0OCyZ9
         HkhPCwsOk0ynQUHrDxeOETnALQeYlIoaj+qh7LLBwK3a9FCe+JUdeb0EGdlamwToVs4u
         Fuvw==
X-Gm-Message-State: ACgBeo0KIbE+yJEvcTwmv94BERBs8ENmIjE3YmyozmAz3uv7n+xNaGAY
        aCiKGR9L1CCvrs/Bf16M76yPZ/Z2diykEDWPqCksqm4R04Ns
X-Google-Smtp-Source: AA6agR6isTvwzJ/sWPV7XmqsP8+eKsrR8Mzhq+fIa5AjUYwdiQHljXLoYnTmh/IfASdX0dVtV0SeGdpXSiM+K6NTfFLCuOJTyc6R
MIME-Version: 1.0
X-Received: by 2002:a5d:8b8c:0:b0:67b:8779:753b with SMTP id
 p12-20020a5d8b8c000000b0067b8779753bmr8315867iol.57.1660639162828; Tue, 16
 Aug 2022 01:39:22 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066926e05e657af2b@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in get_kobj_path_length
From:   syzbot <syzbot+0c48c24994617c1e1c7a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10814197080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d647c9572405910
dashboard link: https://syzkaller.appspot.com/bug?extid=0c48c24994617c1e1c7a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c48c24994617c1e1c7a@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffff00007c61
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD bc8f067 P4D bc8f067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2973 Comm: udevadm Not tainted 5.19.0-syzkaller-14090-g4a9350597aff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:strlen+0x2c/0x90 lib/string.c:487
Code: 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 <80> 7d 00 00 74 39 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
RSP: 0018:ffffc90003067ad8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88801c063000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff84204670 RDI: ffffffff00007c61
RBP: ffffffff00007c61 R08: 0000000000002000 R09: 0000000000000dc0
R10: 0000000080000000 R11: 000000000008c07c R12: 0000000000000001
R13: dffffc0000000000 R14: 00000000fffffffe R15: ffff8880170c2000
FS:  00007f2a81ab9840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff00007c61 CR3: 000000007c7ce000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __fortify_strlen include/linux/fortify-string.h:141 [inline]
 get_kobj_path_length+0x28/0x90 lib/kobject.c:109
 kobject_get_path+0x1b/0x70 lib/kobject.c:144
 kobject_uevent_env+0x254/0x1640 lib/kobject_uevent.c:529
 kobject_synth_uevent+0x701/0x850 lib/kobject_uevent.c:208
 uevent_store+0x42/0x90 drivers/base/bus.c:581
 drv_attr_store+0x6d/0xa0 drivers/base/bus.c:77
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2192 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2a817259a3
Code: 8b 15 d9 f4 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007fff9a55acc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fff9a55bf41 RCX: 00007f2a817259a3
RDX: 0000000000000003 RSI: 00007fff9a55bf41 RDI: 0000000000000003
RBP: 00005647bb783e80 R08: 0000000000000000 R09: 00007f2a817f5a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007fff9a55acd8 R14: 0000000000000000 R15: 00005647bb1660b4
 </TASK>
Modules linked in:
CR2: ffffffff00007c61
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x2c/0x90 lib/string.c:487
Code: 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 <80> 7d 00 00 74 39 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
RSP: 0018:ffffc90003067ad8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88801c063000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff84204670 RDI: ffffffff00007c61
RBP: ffffffff00007c61 R08: 0000000000002000 R09: 0000000000000dc0
R10: 0000000080000000 R11: 000000000008c07c R12: 0000000000000001
R13: dffffc0000000000 R14: 00000000fffffffe R15: ffff8880170c2000
FS:  00007f2a81ab9840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff00007c61 CR3: 000000007c7ce000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	55                   	push   %rbp
   5:	48 89 fd             	mov    %rdi,%rbp
   8:	48 c1 ea 03          	shr    $0x3,%rdx
   c:	53                   	push   %rbx
   d:	48 83 ec 08          	sub    $0x8,%rsp
  11:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  15:	48 89 fa             	mov    %rdi,%rdx
  18:	83 e2 07             	and    $0x7,%edx
  1b:	38 d0                	cmp    %dl,%al
  1d:	7f 04                	jg     0x23
  1f:	84 c0                	test   %al,%al
  21:	75 48                	jne    0x6b
* 23:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp) <-- trapping instruction
  27:	74 39                	je     0x62
  29:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  30:	fc ff df
  33:	48 89 e8             	mov    %rbp,%rax
  36:	48                   	rex.W
  37:	83                   	.byte 0x83
  38:	c0                   	.byte 0xc0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
