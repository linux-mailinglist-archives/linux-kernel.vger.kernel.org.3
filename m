Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2FA5273E8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiENUSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiENUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 16:18:28 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573411A09
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:18:26 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ay38-20020a5d9da6000000b0065adc1f932bso7351938iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SlqYaScAHL+BXeFb8+78VzRrEWZWHNhIDc0JRNroU6k=;
        b=Jxd8jEbjnLtNUNYcxBIxHi7mdwoOebCsZy+Uk3IKY9wnmaRHCFXt2oRnAqAysBLsJC
         1woqs2+mn0NO+Rn1GrahtKvgpQ4tKOuAabeSULcI2g1N/aDjfvcwfgFf7G6Zi/XTvVk3
         ySSCvPQP1SJlCCeq8GpRom0UyXCGMC4EVSGaEHhTYJ7xJZ7CUsxx6ITMDipDxUStEE26
         fUFqCK0/ZeYLCLvVp4lY6++sCwVxo/o9x+H7Gb7/SrnTlOf1qKApnwmIcX8wlTQDh/iZ
         R35LVDuXmrZPeAotklveyXuzCT7kcoVdhEgGhsfUmBOsdNjZgz9r11Nk6PAU16xWVP77
         yC7w==
X-Gm-Message-State: AOAM531zISq6jnagAG0v46NmuZb0yfoskAjviWIVQne9dX8XJpLbFiyd
        cMxJxVjqb3tvtr02Y78tRh9nAG/xeT/fr27pIyM6mI/jTkpX
X-Google-Smtp-Source: ABdhPJxveewxAlZ8yHCHhDCvV2y5AQ6QZL37DucftXHfDBJERj5ltPSWWOLLHo82rwOobFynbSGuaxUvgUSmYAnfx3ioljgsa7yX
MIME-Version: 1.0
X-Received: by 2002:a92:3f0a:0:b0:2cf:7745:d38 with SMTP id
 m10-20020a923f0a000000b002cf77450d38mr5387965ila.289.1652559506295; Sat, 14
 May 2022 13:18:26 -0700 (PDT)
Date:   Sat, 14 May 2022 13:18:26 -0700
In-Reply-To: <0000000000007f31db05de0638f0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057d2f405defe7e00@google.com>
Subject: Re: [syzbot] general protection fault in vma_interval_tree_remove
From:   syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11da21b9f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=ee1fdd8dcc770a3a169a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142757f1f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cf0966f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3612 Comm: syz-executor255 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
RIP: 0010:__rb_erase_color+0x159/0xdb0 lib/rbtree.c:413
Code: 89 ed 48 89 c5 e9 f5 fe ff ff 4c 8d 45 10 4c 89 c0 48 c1 e8 03 80 3c 18 00 0f 85 3a 08 00 00 4c 8b 65 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 0f 85 6a 08 00 00 49 8b 04 24 49 8d 7c 24 08 48 89 f9
RSP: 0018:ffffc90002e877a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffed100e8d3aed RSI: ffff88807469d768 RDI: ffff8880202132b0
RBP: ffff8880202132b0 R08: ffff8880202132c0 R09: ffff88807469d75f
R10: ffffffff81b02518 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88807469d768 R15: ffffffff81b01300
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe92002ff8 CR3: 00000000764a0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rb_erase_augmented include/linux/rbtree_augmented.h:305 [inline]
 rb_erase_augmented_cached include/linux/rbtree_augmented.h:314 [inline]
 vma_interval_tree_remove+0x694/0xed0 mm/interval_tree.c:23
 __remove_shared_vm_struct mm/mmap.c:160 [inline]
 unlink_file_vma+0xbd/0x110 mm/mmap.c:175
 free_pgtables+0x255/0x420 mm/memory.c:440
 exit_mmap+0x1ff/0x740 mm/mmap.c:3219
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa18/0x2a00 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2542/0x2600 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
 exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1543
 asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f1771dc98cf
Code: Unable to access opcode bytes at RIP 0x7f1771dc98a5.
RSP: 002b:00007ffe920035a0 EFLAGS: 00010206
RAX: 0000000000000001 RBX: 00007f1771e78138 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 00007f1771e78138 RDI: 000000000000000b
RBP: 000000000000000b R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000008011 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000001 R14: 00000000000c3ec0 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
RIP: 0010:__rb_erase_color+0x159/0xdb0 lib/rbtree.c:413
Code: 89 ed 48 89 c5 e9 f5 fe ff ff 4c 8d 45 10 4c 89 c0 48 c1 e8 03 80 3c 18 00 0f 85 3a 08 00 00 4c 8b 65 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 0f 85 6a 08 00 00 49 8b 04 24 49 8d 7c 24 08 48 89 f9
RSP: 0018:ffffc90002e877a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffed100e8d3aed RSI: ffff88807469d768 RDI: ffff8880202132b0
RBP: ffff8880202132b0 R08: ffff8880202132c0 R09: ffff88807469d75f
R10: ffffffff81b02518 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88807469d768 R15: ffffffff81b01300
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000c3ec8 CR3: 0000000023516000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 ed                	mov    %ebp,%ebp
   2:	48 89 c5             	mov    %rax,%rbp
   5:	e9 f5 fe ff ff       	jmpq   0xfffffeff
   a:	4c 8d 45 10          	lea    0x10(%rbp),%r8
   e:	4c 89 c0             	mov    %r8,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  19:	0f 85 3a 08 00 00    	jne    0x859
  1f:	4c 8b 65 10          	mov    0x10(%rbp),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	0f 85 6a 08 00 00    	jne    0x89e
  34:	49 8b 04 24          	mov    (%r12),%rax
  38:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  3d:	48 89 f9             	mov    %rdi,%rcx

