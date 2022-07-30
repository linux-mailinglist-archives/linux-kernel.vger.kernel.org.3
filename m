Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF195585C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiG3WoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiG3WoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 18:44:10 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE46E13DDD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 15:44:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j5-20020a056e02218500b002de1cf2347bso2709628ila.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 15:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=oGc3LPdRy5D9mTSTjGnQ//wXyiFJkozbSvaR8CnukbQ=;
        b=VTGl5LIiSMtogTJxEIqzHIBmFcsWcvDW3SAeIVGZh7Vlsrre63mOsQwN8dJPt36OO6
         9x9CZRf7/wsvRwJCuXBPm6SzRGqRHs/ggFSzquwVoIMEGdIw9/pXapZ3yKHfv+XqneWd
         4wAH2v8OgvU5Ei//vvap4AE0agiA3Q+nqmHIpmbuMaEKmSVN4Oie9KJ16Xb436n6pCQO
         ERJRqM2lF1eEfjhdTw1hEHvc6VtobEax9fCVjOpcxeaiBCBABtRS7laEnx9zQQS6dbOG
         u+PtvuVXo8XXqrA/dSVCGnEOCGIZ0rLS7eFV93FqbAk3o0HYpYB4bZWMI9j5Ew2OnWPD
         9EBQ==
X-Gm-Message-State: AJIora9/XEoh8x8+FefywQZ1Yso3LNe5aINSrqFASgQ9OvPHbaySPCt0
        3rOPymQ1c0EJOxrisRO2B9hX4bE9N6AibDoGYqvcisZ4yGKj
X-Google-Smtp-Source: AGRyM1t639cF4GNcUt52k22JazOks65xBQZdLspxUzDmtuxgC5EPGPFmZ35Aygj4yuw5+/3O72XPaCcyfoxjyI+xZ0UXbx+h8xFu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:2dd:ad9e:1ec2 with SMTP id
 r12-20020a056e0219cc00b002ddad9e1ec2mr3613666ill.236.1659221048324; Sat, 30
 Jul 2022 15:44:08 -0700 (PDT)
Date:   Sat, 30 Jul 2022 15:44:08 -0700
In-Reply-To: <20220730223316.1270-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030797505e50d81f9@google.com>
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
hrtimer hog advance_sched ran longer than 4 ticks
WARNING: CPU: 0 PID: 5822 at kernel/time/hrtimer.c:1690 __run_hrtimer kernel/time/hrtimer.c:1690 [inline]
WARNING: CPU: 0 PID: 5822 at kernel/time/hrtimer.c:1690 __hrtimer_run_queues+0xa93/0xff0 kernel/time/hrtimer.c:1754
Modules linked in:
CPU: 0 PID: 5822 Comm: syz-executor.0 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1690 [inline]
RIP: 0010:__hrtimer_run_queues+0xa93/0xff0 kernel/time/hrtimer.c:1754
Code: 00 0f 0b e9 cd f7 ff ff bd 01 00 00 00 e8 d5 43 10 00 48 8b 74 24 08 48 c7 c7 a0 cd 8d 89 c6 05 2c 9f f2 0b 01 e8 d7 ba 82 07 <0f> 0b e8 b6 43 10 00 31 ff 89 ee e8 ed 49 10 00 40 84 ed 0f 84 5e
RSP: 0018:ffffc90000007e30 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888026cad4c0 RSI: ffffffff815d8865 RDI: fffff52000000fb8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d269e R11: 0000000000000000 R12: ffff88802c47a340
R13: 0000000000000003 R14: ffff8880b9c265c0 R15: ffff8880b9c263c0
FS:  0000000001684400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc94018bf8 CR3: 000000002a6ff000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1816
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x8/0x70 kernel/kcov.c:285
Code: 44 30 e0 03 00 00 00 48 89 7c 30 e8 48 89 4c 30 f0 4c 89 54 d8 20 48 89 10 5b c3 0f 1f 80 00 00 00 00 41 89 f8 bf 03 00 00 00 <4c> 8b 14 24 89 f1 65 48 8b 34 25 00 f0 01 00 e8 54 f0 ff ff 84 c0
RSP: 0018:ffffc9000186f600 EFLAGS: 00000282
RAX: 1ffff11004f4e000 RBX: 00000000f23f97db RCX: 0000000000000000
RDX: ffff888026cad4c0 RSI: 0000000000000002 RDI: 0000000000000003
RBP: ffff888027a70008 R08: 0000000000000000 R09: 0000000075a57e01
R10: ffffffff8141eec8 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888027a70000 R14: 0000000000000000 R15: dffffc0000000000
 crc32c_intel_le_hw arch/x86/crypto/crc32c-intel_glue.c:65 [inline]
 crc32c_pcl_intel_update+0xe0/0x320 arch/x86/crypto/crc32c-intel_glue.c:165
 crypto_shash_update+0xc4/0x120 crypto/shash.c:131
 ext4_chksum fs/ext4/ext4.h:2388 [inline]
 ext4_group_desc_csum+0x30d/0x9c0 fs/ext4/super.c:2804
 ext4_group_desc_csum_set+0xc7/0x2a0 fs/ext4/super.c:2850
 ext4_free_blocks+0xb44/0x1ef0 fs/ext4/mballoc.c:5995
 ext4_remove_blocks fs/ext4/extents.c:2502 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2668 [inline]
 ext4_ext_remove_space+0x2247/0x4590 fs/ext4/extents.c:2916
 ext4_ext_truncate+0x205/0x260 fs/ext4/extents.c:4377
 ext4_truncate+0xecc/0x1440 fs/ext4/inode.c:4262
 ext4_evict_inode+0xa71/0x1950 fs/ext4/inode.c:288
 evict+0x2ed/0x6b0 fs/inode.c:584
 iput_final fs/inode.c:1660 [inline]
 iput.part.0+0x539/0x850 fs/inode.c:1686
 iput+0x58/0x70 fs/inode.c:1676
 dentry_unlink_inode+0x2b1/0x3d0 fs/dcache.c:376
 d_delete fs/dcache.c:2505 [inline]
 d_delete+0x16b/0x1c0 fs/dcache.c:2494
 vfs_rmdir.part.0+0x37b/0x430 fs/namei.c:3919
 vfs_rmdir fs/namei.c:3891 [inline]
 do_rmdir+0x3d6/0x480 fs/namei.c:3968
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f47
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc94019338 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000465f47
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc9401a4d0
RBP: 00007ffc94019400 R08: 0000000000000000 R09: 00007ffc940191d0
R10: 00000000016858c3 R11: 0000000000000207 R12: 00000000004bee70
R13: 00007ffc9401a4d0 R14: 0000000001685810 R15: 00007ffc9401a510
----------------
Code disassembly (best guess):
   0:	44 30 e0             	xor    %r12b,%al
   3:	03 00                	add    (%rax),%eax
   5:	00 00                	add    %al,(%rax)
   7:	48 89 7c 30 e8       	mov    %rdi,-0x18(%rax,%rsi,1)
   c:	48 89 4c 30 f0       	mov    %rcx,-0x10(%rax,%rsi,1)
  11:	4c 89 54 d8 20       	mov    %r10,0x20(%rax,%rbx,8)
  16:	48 89 10             	mov    %rdx,(%rax)
  19:	5b                   	pop    %rbx
  1a:	c3                   	retq
  1b:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  22:	41 89 f8             	mov    %edi,%r8d
  25:	bf 03 00 00 00       	mov    $0x3,%edi
* 2a:	4c 8b 14 24          	mov    (%rsp),%r10 <-- trapping instruction
  2e:	89 f1                	mov    %esi,%ecx
  30:	65 48 8b 34 25 00 f0 	mov    %gs:0x1f000,%rsi
  37:	01 00
  39:	e8 54 f0 ff ff       	callq  0xfffff092
  3e:	84 c0                	test   %al,%al


Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=175bd5e2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d54ed2080000

