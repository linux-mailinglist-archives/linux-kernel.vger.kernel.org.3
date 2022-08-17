Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873C5596DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiHQLwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQLwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:52:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9176772
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:52:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i12-20020a056e021d0c00b002df2d676974so8799024ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=nQ+uyxur6fHF5hQ9cHlpJvJr/Oe8/aw8K6tIMjnh1Wc=;
        b=rqD15xywB9WeaceRhRyUXi5kgtMvBOEL9LxOmBvFqjIHFcViZVVZyzlAvBH9KnHgvy
         Gq2mgLtM/6i6UA/m4/fW+3Y2mlCm5GfF0VQ0pSX/zXDM6xdoT6aWL+RznjK2mMYV4WBB
         uUK1tonTEGSVM+0Trx1siaHONeVzUAYrJwJAaoJr+Xtx8eCI/7azjY/JCO8ZECydCiex
         Q8XBSrBoy6qVYBvsICYD5JfbmTZnVS0J/DVp8o/tGBd3m2dXgC0hEiK2c7RGuw6w7R0A
         DR0qOmHHxUINodm59cBPexlnQIpY9skw3ESPy/sd/7XhFCxIoLH3JG67U/B3UFMk5hSv
         jbDw==
X-Gm-Message-State: ACgBeo1v3poK5sgTb1laXkUMRRvSaAq5zsSk3izPwYGRRDERGrI1Nrpg
        qxoS8yfOLgz/e2qrVfBnlQ5akvIt+oSTMiuF2nGqa819ir9m
X-Google-Smtp-Source: AA6agR4PsuT7U+xo3MTcwoGXDPmvHYlDwpTJhQL0SupSoVMxKm3U3Fm2qky33QXqeHv+49hCpLuW3E0a1COBZ6ih5BXiUwOEBWMV
MIME-Version: 1.0
X-Received: by 2002:a02:ad0d:0:b0:343:517b:eb41 with SMTP id
 s13-20020a02ad0d000000b00343517beb41mr11464531jan.152.1660737128519; Wed, 17
 Aug 2022 04:52:08 -0700 (PDT)
Date:   Wed, 17 Aug 2022 04:52:08 -0700
In-Reply-To: <20220817111459.1148-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c5f6f05e66e7e0d@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in blocking_notifier_chain_unregister
From:   syzbot <syzbot+2fd9312f3ff65d22d06f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in kvm_arch_hardware_enable

BUG: unable to handle page fault for address: ffffc9000484a330
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11800067 
P4D 11800067 
PUD 119c9067 
PMD 1e9bb067 
PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4090 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:29 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:28 [inline]
RIP: 0010:kvm_arch_hardware_enable+0x2ab/0x840 arch/x86/kvm/x86.c:11847
Code: 48 89 e8 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 0f b6 14 08 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ed 04 00 00 <41> 8b 95 30 13 00 00 4d 8d b5 40 12 00 00 b9 08 00 00 00 4c 89 fe
RSP: 0018:ffffc9000507fb48 EFLAGS: 00010082

RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81120fe0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc9000484a330
RBP: ffffc9000484a330 R08: 0000000000000000 R09: 0000000000000003
R10: fffff52000909466 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90004849000 R14: 0023001000000000 R15: ffffc9000507fba0
FS:  00007f45b38a9700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000484a330 CR3: 000000007a237000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hardware_enable_nolock+0xa7/0x140 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5007
 smp_call_function_many_cond+0x10e2/0x1430 kernel/smp.c:979
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1154
 on_each_cpu include/linux/smp.h:71 [inline]
 hardware_enable_all arch/x86/kvm/../../../virt/kvm/kvm_main.c:5069 [inline]
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1202 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4910 [inline]
 kvm_dev_ioctl+0x131b/0x1ce0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4957
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f45b2689279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f45b38a9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f45b279bf80 RCX: 00007f45b2689279
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00007f45b38a91d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fff8cb22fbf R14: 00007f45b38a9300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: ffffc9000484a330
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:29 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:28 [inline]
RIP: 0010:kvm_arch_hardware_enable+0x2ab/0x840 arch/x86/kvm/x86.c:11847
Code: 48 89 e8 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 0f b6 14 08 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ed 04 00 00 <41> 8b 95 30 13 00 00 4d 8d b5 40 12 00 00 b9 08 00 00 00 4c 89 fe
RSP: 0018:ffffc9000507fb48 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81120fe0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc9000484a330
RBP: ffffc9000484a330 R08: 0000000000000000 R09: 0000000000000003
R10: fffff52000909466 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90004849000 R14: 0023001000000000 R15: ffffc9000507fba0
FS:  00007f45b38a9700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000484a330 CR3: 000000007a237000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 e8             	mov    %rbp,%rax
   3:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
   a:	fc ff df
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
  15:	48 89 e8             	mov    %rbp,%rax
  18:	83 e0 07             	and    $0x7,%eax
  1b:	83 c0 03             	add    $0x3,%eax
  1e:	38 d0                	cmp    %dl,%al
  20:	7c 08                	jl     0x2a
  22:	84 d2                	test   %dl,%dl
  24:	0f 85 ed 04 00 00    	jne    0x517
* 2a:	41 8b 95 30 13 00 00 	mov    0x1330(%r13),%edx <-- trapping instruction
  31:	4d 8d b5 40 12 00 00 	lea    0x1240(%r13),%r14
  38:	b9 08 00 00 00       	mov    $0x8,%ecx
  3d:	4c 89 fe             	mov    %r15,%rsi


Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16cb627b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=2fd9312f3ff65d22d06f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f8bd97080000

