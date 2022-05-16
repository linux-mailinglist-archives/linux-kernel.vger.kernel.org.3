Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B156752843B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiEPMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEPMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:33:11 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFAE338A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:33:10 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id o4-20020a0566022e0400b0065ab2047d69so10261921iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5BYMCoAB/5szpDrlyiQ2Li9OsLrtpYStWLdNCbW72xo=;
        b=irMbDuGV0d+hJ2QKbeHfiPUh8vpq92SFzG7YnZ7XfhUQ60l9N9kJzzVREivN1SYU3F
         SraDpzOETbmZdeZMlRZMEE/L6VU/2vRXIkDvbm8soZCiS+X/2KJjKFnZJvFjS7+lM7R8
         /VOaIpWSHxiz7wc9raoNrghOiPVVh3NQGudIKXmof4omPu/X5ZF4YElxJI3/MJR5Laov
         TA31piGuBSo5+lxshNmT5GG25cCuy2jDUrXkXYwSNfnQY9oCDU3wbU7ZfzPcRQ3RxhUB
         9Er/1kc4zBkQErx+nclL9QPiaCGUo2zsufXgGduT0WPmhBRbTs6wxMhqaFNQXNPFAsM9
         tzIA==
X-Gm-Message-State: AOAM5326kVN4vHVlclSlPehmG1lkxVstiySIfoFYBjQn4UwrVVOS77Pr
        dZbm5NcfgPWbXznf2Sjp+NQfM1AwYtRIuDR9e6AFyj080nUf
X-Google-Smtp-Source: ABdhPJxHMuGRFQa1Ta1QRcKbpEdo0tjuA+VhNTubF6AhnHPCYwbTLSUyL2nmpHHspaW96cJ1GBhffzPk80dzndKdOkTaWEPrWsPT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:2d1:1d0c:2e28 with SMTP id
 j11-20020a056e02218b00b002d11d0c2e28mr2676431ila.216.1652704389743; Mon, 16
 May 2022 05:33:09 -0700 (PDT)
Date:   Mon, 16 May 2022 05:33:09 -0700
In-Reply-To: <20220516122225.1986-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011ca6a05df203aea@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in percpu_ref_switch_to_atomic_rcu

------------[ cut here ]------------
percpu ref (css_release) <= 0 (-4294967295) after switching to atomic
WARNING: CPU: 1 PID: 4059 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x46c/0x560 lib/percpu-refcount.c:196
Modules linked in:
CPU: 1 PID: 4059 Comm: syz-executor.3 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x46c/0x560 lib/percpu-refcount.c:196
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 c0 00 00 00 49 8b 77 e8 4c 89 e2 48 c7 c7 60 e3 26 8a e8 bc a7 31 05 <0f> 0b e9 34 ff ff ff 48 89 c6 48 c7 c7 80 39 69 8c 48 89 44 24 08
RSP: 0018:ffffc900001e0e20 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801d1bbb00 RSI: ffffffff81601ae8 RDI: fffff5200003c1b6
RBP: ffff88802009bf00 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815fc4be R11: 0000000000000000 R12: ffffffff00000001
R13: dffffc0000000000 R14: 0000607f46080068 R15: ffff88802009bf20
FS:  0000555556ed0400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f729536db58 CR3: 000000006f54c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 ba 60 ed f7 48 89 ef e8 02 e0 ed f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 23 ff e0 f7 65 8b 05 2c 24 92 76 85 c0 74 0a 5b 5d c3 e8 b0 3d
RSP: 0018:ffffc9000331f668 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1b71ef9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8be8f980 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f8988 R11: 0000000000000000 R12: 0000000000000000
R13: 0000607f4607e000 R14: ffff8881457e8448 R15: ffff8881457e8471
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 free_percpu mm/percpu.c:2305 [inline]
 free_percpu+0x7eb/0x10c0 mm/percpu.c:2261
 xt_percpu_counter_free+0x96/0xc0 net/netfilter/x_tables.c:1950
 cleanup_entry+0x24f/0x300 net/ipv4/netfilter/ip_tables.c:656
 __do_replace+0x628/0x870 net/ipv4/netfilter/ip_tables.c:1085
 do_replace net/ipv4/netfilter/ip_tables.c:1140 [inline]
 do_ipt_set_ctl+0x901/0xb80 net/ipv4/netfilter/ip_tables.c:1630
 nf_setsockopt+0x83/0xe0 net/netfilter/nf_sockopt.c:101
 ip_setsockopt+0x3c3/0x3ab0 net/ipv4/ip_sockglue.c:1444
 tcp_setsockopt+0x136/0x2520 net/ipv4/tcp.c:3696
 __sys_setsockopt+0x2db/0x6a0 net/socket.c:2180
 __do_sys_setsockopt net/socket.c:2191 [inline]
 __se_sys_setsockopt net/socket.c:2188 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2188
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f729528a73a
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdea7f0d38 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f729528a73a
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffdea7f0d60 R08: 0000000000000408 R09: fefefefeff646b66
R10: 00007f729536db00 R11: 0000000000000202 R12: 00007ffdea7f0dc0
R13: 0000000000000003 R14: 00007ffdea7f0d5c R15: 00007f729536daa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	ba 60 ed f7 48       	mov    $0x48f7ed60,%edx
   9:	89 ef                	mov    %ebp,%edi
   b:	e8 02 e0 ed f7       	callq  0xf7ede012
  10:	81 e3 00 02 00 00    	and    $0x200,%ebx
  16:	75 25                	jne    0x3d
  18:	9c                   	pushfq
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 23 ff e0 f7       	callq  0xf7e0ff52 <-- trapping instruction
  2f:	65 8b 05 2c 24 92 76 	mov    %gs:0x7692242c(%rip),%eax        # 0x76922462
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	b0 3d                	mov    $0x3d,%al


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1626d569f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1266a479f00000

