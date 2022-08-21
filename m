Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE759B2C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiHUIcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8511DA4C
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DB07B80BAB
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FFDC433D6;
        Sun, 21 Aug 2022 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661070767;
        bh=EfPHDS1lkY6VuHPW+Gbq8pVnv5XdButGMwTiNp+hni0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kCicym+V+TuxhNFDZNgIYr5qbm6uAN73UufUjC58nmJjs2Gp9y3CFH/yEqzXB/RVS
         o/Gy9r/X3sNP394tReis7yjSNkU0rAdJzi3IxmrJp0hM3tJheSnLzgAAnhtBPCVjo7
         7ZltdGXiaV2Rndapl8bh13Gw63KEbGlOI9TAe3ZM=
Date:   Sun, 21 Aug 2022 01:32:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [syzbot] general protection fault in vma_is_shmem
Message-Id: <20220821013246.a706fa7c2d8cb494efdba02e@linux-foundation.org>
In-Reply-To: <0000000000002c73fd05e6ba3e0b@google.com>
References: <0000000000002c73fd05e6ba3e0b@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 23:14:24 -0700 syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:

Thanks.  Will a bisection search be performed?

> HEAD commit:    95d10484d66e Add linux-next specific files for 20220817
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15133023080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
> dashboard link: https://syzkaller.appspot.com/bug?extid=681bbbb80445ead3c040
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1100a92d080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123d1867080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]

Seems that io_pin_pages->pin_user_pages gave us a null vma* in the
vmas[] array.  We haven't messed with gup.c much this time around -
just one patch from Alistair ("mm/gup.c: simplify and fix
check_and_migrate_movable_pages() return codes").  It does touch this
area, but I can't immediately see how it could newly cause this.


> CPU: 1 PID: 3607 Comm: syz-executor359 Not tainted 6.0.0-rc1-next-20220817-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:vma_is_shmem+0x21/0x40 mm/shmem.c:254
> Code: 73 02 e9 20 fc ff ff 66 90 53 48 89 fb e8 07 2c cf ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 10 48 81 bb 90 00 00 00 20 8f f7 89 5b 0f 94 c0 c3
> RSP: 0018:ffffc900037cfb68 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000012 RSI: ffffffff81ace949 RDI: 0000000000000090
> RBP: ffff888071b00720 R08: 0000000000000006 R09: 00000000000000e4
> R10: 0000000000008001 R11: 0000000000000000 R12: 00000000000000e4
> R13: ffff888071b00000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000555556ab5300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa3c8f13260 CR3: 00000000718f5000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  io_pin_pages+0x25f/0x430 io_uring/rsrc.c:1207
>  io_sqe_buffer_register+0x14e/0x13b0 io_uring/rsrc.c:1254
>  io_sqe_buffers_register.cold+0x351/0x445 io_uring/rsrc.c:1346
>  __io_uring_register io_uring/io_uring.c:3711 [inline]
>  __do_sys_io_uring_register+0x96d/0x1110 io_uring/io_uring.c:3878
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f548fcdfbb9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc644b88f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f548fcdfbb9
> RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f548fca3d60 R08: 0000000010000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f548fca3df0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:vma_is_shmem+0x21/0x40 mm/shmem.c:254
> Code: 73 02 e9 20 fc ff ff 66 90 53 48 89 fb e8 07 2c cf ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 10 48 81 bb 90 00 00 00 20 8f f7 89 5b 0f 94 c0 c3
> RSP: 0018:ffffc900037cfb68 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000012 RSI: ffffffff81ace949 RDI: 0000000000000090
> RBP: ffff888071b00720 R08: 0000000000000006 R09: 00000000000000e4
> R10: 0000000000008001 R11: 0000000000000000 R12: 00000000000000e4
> R13: ffff888071b00000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000555556ab5300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa3c8f13260 CR3: 00000000718f5000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	73 02                	jae    0x4
>    2:	e9 20 fc ff ff       	jmpq   0xfffffc27
>    7:	66 90                	xchg   %ax,%ax
>    9:	53                   	push   %rbx
>    a:	48 89 fb             	mov    %rdi,%rbx
>    d:	e8 07 2c cf ff       	callq  0xffcf2c19
>   12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:	75 10                	jne    0x40
>   30:	48 81 bb 90 00 00 00 	cmpq   $0xffffffff89f78f20,0x90(%rbx)
>   37:	20 8f f7 89
>   3b:	5b                   	pop    %rbx
>   3c:	0f 94 c0             	sete   %al
>   3f:	c3                   	retq
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
