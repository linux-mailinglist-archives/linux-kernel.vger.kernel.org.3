Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96E5234F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiEKODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbiEKODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:03:16 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313032981F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:03:15 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id o4-20020a0566022e0400b0065ab2047d69so1217351iow.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=taLXVGC6Oux+ZFmVP/qtKr/wZGuWEjBb+w6RGPWn9+Q=;
        b=kamVOL9o7a8wk/GeW4c7kdRyAp2DXd++cto/coIvqTxhqn9uQAex6nsMy5oe+dm6Vv
         cKj7gVBdBk6a/aYGsudwWm0DyjM70RRE6QuWzxDf2fDjZ7KN2RIgRrgH5rprfhrDBE+I
         NDTfzFzJSEUcnt/fLquyPaLVZrDHd5KWeW5ORp8DWjcXroCSGnjhyClFvMUeqiAdhxIt
         8K9XCtkf2+u/qGuzxDmhg6Un8o15zsLavBFVKwKDUOfaxY2ykvFl5xuNhSUxJa3iYI+2
         FZo4AbwarXmP/4O03etbMF2cJvO+BwShtW1eL2uEWFkJBiGuxcD3xXwzu2xSv4p92mQT
         pOTA==
X-Gm-Message-State: AOAM530q3IZB8xhbiXPsBSfBHz0T7rBjmrjHNuQ1UpGnkTvvGETGdcM4
        cK9F3XjvO7oFoArmupZQ9JZyVNcJ4xVFUZUR6BYMLBnROkJK
X-Google-Smtp-Source: ABdhPJzJPvpfqE0NWqXtUlcYoBF/NewGpTtJi7fNfdog/WDZcsbLiz1Rrx90ICbCJXMcK1qZT9o3z7GXKrtVIjrmRhTrWxiiUXvH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a27:b0:2cf:91e3:362f with SMTP id
 g7-20020a056e021a2700b002cf91e3362fmr9077995ile.124.1652277794269; Wed, 11
 May 2022 07:03:14 -0700 (PDT)
Date:   Wed, 11 May 2022 07:03:14 -0700
In-Reply-To: <20220511135117.5993-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff747805debce6c6@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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
WARNING: ODEBUG bug in __init_work

------------[ cut here ]------------
ODEBUG: init active (active state 0) object type: work_struct hint: css_killed_work_fn+0x0/0x5e0 kernel/cgroup/cgroup.c:3947
WARNING: CPU: 1 PID: 4107 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 4107 Comm: syz-executor.3 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 40 40 27 8a 4c 89 ee 48 c7 c7 40 34 27 8a e8 7a cc 2c 05 <0f> 0b 83 05 25 a2 bd 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc900001e0cb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88807348bb00 RSI: ffffffff81601ae8 RDI: fffff5200003c189
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815fc4be R11: 0000000000000000 R12: ffffffff89cb9000
R13: ffffffff8a2739c0 R14: ffffffff814c80d0 R15: ffffffff90840968
FS:  0000555555872400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22b216c058 CR3: 000000006b894000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __debug_object_init+0x524/0xd10 lib/debugobjects.c:593
 __init_work+0x48/0x50 kernel/workqueue.c:523
 css_release+0x1a/0x110 kernel/cgroup/cgroup.c:5213
 percpu_ref_put_many.constprop.0+0x22b/0x260 include/linux/percpu-refcount.h:335
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
RIP: 0010:__syscall_enter_from_user_work kernel/entry/common.c:89 [inline]
RIP: 0010:syscall_enter_from_user_mode+0x2b/0x70 kernel/entry/common.c:110
Code: 54 49 89 f4 55 48 89 fd 48 8b 7c 24 10 e8 ed f5 ff ff eb 27 eb 2b e8 04 35 12 f8 e8 7f 31 12 f8 fb 65 48 8b 04 25 00 70 02 00 <48> 8b 70 08 40 f6 c6 3f 75 19 4c 89 e0 5d 41 5c c3 eb 1b 0f 0b eb
RSP: 0018:ffffc9000352ff28 EFLAGS: 00000206
RAX: ffff88807348bb00 RBX: 0000000000000000 RCX: 1ffffffff1b71e79
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000352ff58 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f8958 R11: 0000000000000000 R12: 000000000000003d
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 do_syscall_64+0x16/0xb0 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f307ec87587
Code: 89 7c 24 10 48 89 4c 24 18 e8 35 50 02 00 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 10 e8 65 50 02 00 8b 44
RSP: 002b:00007ffcba6fb200 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000018 RCX: 00007f307ec87587
RDX: 0000000040000001 RSI: 00007ffcba6fb28c RDI: 00000000ffffffff
RBP: 00007ffcba6fb28c R08: 0000000000000000 R09: 00007ffcba74f080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 0000000000016531 R14: 0000000000000004 R15: 00007ffcba6fb2f0
 </TASK>
----------------
Code disassembly (best guess):
   0:	54                   	push   %rsp
   1:	49 89 f4             	mov    %rsi,%r12
   4:	55                   	push   %rbp
   5:	48 89 fd             	mov    %rdi,%rbp
   8:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
   d:	e8 ed f5 ff ff       	callq  0xfffff5ff
  12:	eb 27                	jmp    0x3b
  14:	eb 2b                	jmp    0x41
  16:	e8 04 35 12 f8       	callq  0xf812351f
  1b:	e8 7f 31 12 f8       	callq  0xf812319f
  20:	fb                   	sti
  21:	65 48 8b 04 25 00 70 	mov    %gs:0x27000,%rax
  28:	02 00
* 2a:	48 8b 70 08          	mov    0x8(%rax),%rsi <-- trapping instruction
  2e:	40 f6 c6 3f          	test   $0x3f,%sil
  32:	75 19                	jne    0x4d
  34:	4c 89 e0             	mov    %r12,%rax
  37:	5d                   	pop    %rbp
  38:	41 5c                	pop    %r12
  3a:	c3                   	retq
  3b:	eb 1b                	jmp    0x58
  3d:	0f 0b                	ud2
  3f:	eb                   	.byte 0xeb


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1193d43af00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1681e821f00000

