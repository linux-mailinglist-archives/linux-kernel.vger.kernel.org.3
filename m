Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A449585B04
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiG3P3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiG3P3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:29:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CED712A94
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:29:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso2358514ioe.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=II+Aa/tU0GJSM8qD5KZ+GpXL4CeKTzOKGQZwx/nkqGY=;
        b=ZNDunAb1KdYd6+yTfLEbIYzH7/MuKU5tqFX7oL6K/NceKxlHC+Usd/YnjnN5lWcZWT
         1XV0vVjyTnn+xNeqjFuRsf0t8nYNIuBTC1PTO49SoFPfVlQqsNtHXD19RauMRxNPm9tr
         A3sg/XTjiM+wEy9ViXLi3N9aXhUqvDtZ6QDTJIU5f7bQGQtwofq/dfW+H0+Bp6GArgyd
         R0TYPHPG4HMYgsBleAz6Klik+mApWluM61SDyRezb8pzd0acU4dBzpk7ONOhh5huhBNF
         AbwydGevC1rwwHtoInuW791yPGfD2QhuTaoVa47J53ocuY6K0EWP1WM7yi9ODDrUSYEt
         J4Lg==
X-Gm-Message-State: AJIora8eYmbMzMs6TyOH6OcvrvDLPhmeRlasf54hT+EkfCXfQ7s1dPgG
        9UbhWsRqQO/uR45yikcHNJZB6rbWlkP9NxWMSR29jErnEpox
X-Google-Smtp-Source: AGRyM1s8ndPR8qqa4U2xwRx/BQpTxBSZCbUk57W9WpeKxaEDkds+nZFfQ2MhYl/9K9uJapd7KjgdlA4Jf9JYCmcLMzGLRhsRkzYA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:138f:b0:341:4711:4c2c with SMTP id
 w15-20020a056638138f00b0034147114c2cmr3243200jad.178.1659194947694; Sat, 30
 Jul 2022 08:29:07 -0700 (PDT)
Date:   Sat, 30 Jul 2022 08:29:07 -0700
In-Reply-To: <20220730114424.1197-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007877f605e5076d0c@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __hrtimer_run_queues

------------[ cut here ]------------
hrtimer hog tick_sched_timer ran longer than 2 ticks
WARNING: CPU: 0 PID: 5792 at kernel/time/hrtimer.c:1690 __run_hrtimer kernel/time/hrtimer.c:1690 [inline]
WARNING: CPU: 0 PID: 5792 at kernel/time/hrtimer.c:1690 __hrtimer_run_queues+0xbf5/0x1230 kernel/time/hrtimer.c:1757
Modules linked in:
CPU: 0 PID: 5792 Comm: udevd Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1690 [inline]
RIP: 0010:__hrtimer_run_queues+0xbf5/0x1230 kernel/time/hrtimer.c:1757
Code: 10 00 0f 0b e9 70 f6 ff ff bd 01 00 00 00 e8 b2 44 10 00 48 8b 34 24 48 c7 c7 a0 cd 8d 89 c6 05 0b 9e f2 0b 01 e8 75 c9 82 07 <0f> 0b e8 94 44 10 00 31 ff 89 ee e8 cb 4a 10 00 40 84 ed 0f 84 00
RSP: 0018:ffffc90000007e20 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888017c79c40 RSI: ffffffff815d8865 RDI: fffff52000000fb6
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d269e R11: 0000000000000000 R12: ffff8880b9c26d60
R13: ffff8880b9c26488 R14: ffff8880b9c26440 R15: ffff8880b9c263c0
FS:  00007f5a1a630840(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000051e370 CR3: 00000000182e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1819
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:197
Code: fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 65 8b 05 59 33 8c 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 00 f0 01 00 a9
RSP: 0018:ffffc900016cf858 EFLAGS: 00000246
RAX: 0000000080000000 RBX: 0000000000000007 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888017c79c40 RDI: 0000000000000003
RBP: ffff8880190b8e00 R08: 0000000000000000 R09: 0000000000000007
R10: ffffffff839f55d7 R11: 0000000000000010 R12: 0000000000000002
R13: 000000000000024d R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_domain_quota_is_ok+0x31a/0x550 security/tomoyo/util.c:1092
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x2f0/0x400 security/tomoyo/file.c:838
 security_inode_getattr+0xcf/0x140 security/security.c:1332
 vfs_getattr fs/stat.c:139 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat+0x96/0x120 fs/stat.c:394
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5a1a7871da
Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 0b 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 69 fc 0c 00 f7
RSP: 002b:00007ffc16494b38 EFLAGS: 00000202 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 0000000000006180 RCX: 00007f5a1a7871da
RDX: 00007ffc16494b68 RSI: 000055fa80fa7ba0 RDI: 00000000ffffff9c
RBP: 000055fa80fc4060 R08: 0000000000000000 R09: 000055fa80fb2640
R10: 0000000000000100 R11: 0000000000000202 R12: 000055fa80fa7ba0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000006180
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
   5:	ba 08 00 00 00       	mov    $0x8,%edx
   a:	4d 8b 03             	mov    (%r11),%r8
   d:	48 0f bd ca          	bsr    %rdx,%rcx
  11:	49 8b 45 00          	mov    0x0(%r13),%rax
  15:	48 63 c9             	movslq %ecx,%rcx
  18:	e9 64 ff ff ff       	jmpq   0xffffff81
  1d:	0f 1f 00             	nopl   (%rax)
  20:	65 8b 05 59 33 8c 7e 	mov    %gs:0x7e8c3359(%rip),%eax        # 0x7e8c3380
* 27:	89 c1                	mov    %eax,%ecx <-- trapping instruction
  29:	48 8b 34 24          	mov    (%rsp),%rsi
  2d:	81 e1 00 01 00 00    	and    $0x100,%ecx
  33:	65 48 8b 14 25 00 f0 	mov    %gs:0x1f000,%rdx
  3a:	01 00
  3c:	a9                   	.byte 0xa9


Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d81282080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1756f322080000

