Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7E527414
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiENUuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 16:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiENUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 16:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE91AD9D
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91DADB80AFF
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 20:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE857C34100;
        Sat, 14 May 2022 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652561411;
        bh=3Z/rTobIeLH4LMnJLML1Ms4B6DcwGzom/VDhIgvJ+Uk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zp0IdwjOjA/j+IA523oZMCITQ9lknvscKCHA+eMRd32jNAkuaJeTN0Rk8PFxVirGA
         Vk2gFlKnUUNknnC8ZWyPogSigwojWnpt81slINYuyp4b9jNjcTWW+SLcOSORAQLJvT
         wkAP4cQw8gtgck0bI2MsmAWtn8EKqB1o/KmOINGA=
Date:   Sat, 14 May 2022 13:50:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Liam Howlett <liam.howlett@oracle.com>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [syzbot] general protection fault in vma_interval_tree_remove
Message-Id: <20220514135010.2528f75eb053a7b38d80584b@linux-foundation.org>
In-Reply-To: <00000000000057d2f405defe7e00@google.com>
References: <0000000000007f31db05de0638f0@google.com>
        <00000000000057d2f405defe7e00@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 13:18:26 -0700 syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11da21b9f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
> dashboard link: https://syzkaller.appspot.com/bug?extid=ee1fdd8dcc770a3a169a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142757f1f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cf0966f00000

Thanks.

So it was there on April 28 and it's there now.  Liam, do you think
anything in the mapletree changes could have perturbed the interval
tree handling?


> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 3612 Comm: syz-executor255 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
> RIP: 0010:__rb_erase_color+0x159/0xdb0 lib/rbtree.c:413
> Code: 89 ed 48 89 c5 e9 f5 fe ff ff 4c 8d 45 10 4c 89 c0 48 c1 e8 03 80 3c 18 00 0f 85 3a 08 00 00 4c 8b 65 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 0f 85 6a 08 00 00 49 8b 04 24 49 8d 7c 24 08 48 89 f9
> RSP: 0018:ffffc90002e877a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: ffffed100e8d3aed RSI: ffff88807469d768 RDI: ffff8880202132b0
> RBP: ffff8880202132b0 R08: ffff8880202132c0 R09: ffff88807469d75f
> R10: ffffffff81b02518 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff88807469d768 R15: ffffffff81b01300
> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe92002ff8 CR3: 00000000764a0000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  rb_erase_augmented include/linux/rbtree_augmented.h:305 [inline]
>  rb_erase_augmented_cached include/linux/rbtree_augmented.h:314 [inline]
>  vma_interval_tree_remove+0x694/0xed0 mm/interval_tree.c:23
>  __remove_shared_vm_struct mm/mmap.c:160 [inline]
>  unlink_file_vma+0xbd/0x110 mm/mmap.c:175
>  free_pgtables+0x255/0x420 mm/memory.c:440
>  exit_mmap+0x1ff/0x740 mm/mmap.c:3219
>  __mmput+0x128/0x4c0 kernel/fork.c:1180
>  mmput+0x5c/0x70 kernel/fork.c:1201
>  exit_mm kernel/exit.c:510 [inline]
>  do_exit+0xa18/0x2a00 kernel/exit.c:782
>  do_group_exit+0xd2/0x2f0 kernel/exit.c:925
>  get_signal+0x2542/0x2600 kernel/signal.c:2857
>  arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
>  exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
>  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
>  irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
>  exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1543
>  asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7f1771dc98cf
> Code: Unable to access opcode bytes at RIP 0x7f1771dc98a5.
> RSP: 002b:00007ffe920035a0 EFLAGS: 00010206
> RAX: 0000000000000001 RBX: 00007f1771e78138 RCX: 0000000000000001
> RDX: 0000000000000001 RSI: 00007f1771e78138 RDI: 000000000000000b
> RBP: 000000000000000b R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000008011 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000001 R14: 00000000000c3ec0 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
> RIP: 0010:__rb_erase_color+0x159/0xdb0 lib/rbtree.c:413
> Code: 89 ed 48 89 c5 e9 f5 fe ff ff 4c 8d 45 10 4c 89 c0 48 c1 e8 03 80 3c 18 00 0f 85 3a 08 00 00 4c 8b 65 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 0f 85 6a 08 00 00 49 8b 04 24 49 8d 7c 24 08 48 89 f9
> RSP: 0018:ffffc90002e877a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: ffffed100e8d3aed RSI: ffff88807469d768 RDI: ffff8880202132b0
> RBP: ffff8880202132b0 R08: ffff8880202132c0 R09: ffff88807469d75f
> R10: ffffffff81b02518 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff88807469d768 R15: ffffffff81b01300
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000c3ec8 CR3: 0000000023516000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	89 ed                	mov    %ebp,%ebp
>    2:	48 89 c5             	mov    %rax,%rbp
>    5:	e9 f5 fe ff ff       	jmpq   0xfffffeff
>    a:	4c 8d 45 10          	lea    0x10(%rbp),%r8
>    e:	4c 89 c0             	mov    %r8,%rax
>   11:	48 c1 e8 03          	shr    $0x3,%rax
>   15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
>   19:	0f 85 3a 08 00 00    	jne    0x859
>   1f:	4c 8b 65 10          	mov    0x10(%rbp),%r12
>   23:	4c 89 e0             	mov    %r12,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
>   2e:	0f 85 6a 08 00 00    	jne    0x89e
>   34:	49 8b 04 24          	mov    (%r12),%rax
>   38:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
>   3d:	48 89 f9             	mov    %rdi,%rcx
> 
