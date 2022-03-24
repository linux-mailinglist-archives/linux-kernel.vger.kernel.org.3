Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4394E6A63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbiCXVrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiCXVrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:47:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879DB7C40
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IaWr/LxjCfKOIZ8ZHq2MXOE8AwSiAG1JklxaGKURUtM=; b=Gt0d/FBG9O0deg5U+6rax9fSnL
        QznTMym1IfIzhdLzVEsfKJ1XVKGk+H5bR4s0q78UzuATV6jSSyHxN7J2ruDEqPlBG7v/OPn04FWcp
        oUujW4eJs9rPX/KBckbY7FwdabZqpypmJZG9ctyLASnK2E40rmGvVj5FgSdHWLmIbHetGi9osR5gb
        z4BsyjUaBHDbN2uHP66wHxY0C+flqhsynpJagmoESF6pOIa1215eeU0n9el7nA5w67lDvo2vDSLUC
        TqYGHZejgsU/1AaLymySW8vP/zKx9EVOQ9kru+3J6jym/BgiACG2O+JToepI0DeRcLiVKyWkmQQ/i
        vaG1dUDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXVGs-00DmVR-Gx; Thu, 24 Mar 2022 21:45:30 +0000
Date:   Thu, 24 Mar 2022 21:45:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+0d2b0bf32ca5cfd09f2e@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in xas_create_range
Message-ID: <YjzmejKYCKY7Twbi@casper.infradead.org>
References: <00000000000061fc5805dab9a5ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000061fc5805dab9a5ef@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:29:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=146069d9700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=70f75a89c7a0e6bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d2b0bf32ca5cfd09f2e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

I do!  Thanks for the report; I thought deeply about what the problem
might be and wrote a test that produces this problem:

$ ./xarray
linux/../../../../include/linux/xarray.h:1208:9: runtime error: member access within null pointer of type 'const struct xa_node'
AddressSanitizer:DEADLYSIGNAL
=================================================================
==2288654==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000008 (pc 0x5636348abdcb bp 0x000000000000 sp 0x7ffd64c7a570 T0)
==2288654==The signal is caused by a READ memory access.
==2288654==Hint: address points to the zero page.
    #0 0x5636348abdcb in xa_parent_locked linux/../../../../include/linux/xarray.h:1208
    #1 0x5636348abdcb in xas_create_range ../../../lib/xarray.c:725
    #2 0x5636348b40d1 in check_create_range_5 ../../../lib/test_xarray.c:1474
    #3 0x5636348d49da in check_create_range ../../../lib/test_xarray.c:1510
    #4 0x5636348d7dc9 in xarray_checks ../../../lib/test_xarray.c:1808

I'll fix it.  It's a race condition to reproduce it (khugepaged vs ...
actually, I'm not sure what it's racing against, but the other thing
also creates a THP before khugepaged gets the lock).  There's no way
to write a reliable reproducer in userspace, but trivial to write the
test-case once you know what's happening.

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0d2b0bf32ca5cfd09f2e@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 32 Comm: khugepaged Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:xa_parent_locked include/linux/xarray.h:1207 [inline]
> RIP: 0010:xas_create_range+0x2d9/0x6e0 lib/xarray.c:725
> Code: 89 ee 49 83 ed 40 49 c1 ee 03 4c 89 6d 08 4c 8d 6d 12 4d 01 e6 e9 93 00 00 00 e8 d2 0f 72 fd 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 fb 02 00 00 48 8b 04 24 4c 8b 7b 08 80 38 00
> RSP: 0018:ffffc90001097a48 EFLAGS: 00010002
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8880139de240 RSI: ffffffff8405e5be RDI: 0000000000000008
> RBP: ffffc90001097bb0 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff8405e679 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffffc90001097bc2 R14: fffff52000212f76 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe25571c98 CR3: 0000000079206000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  collapse_file+0x2d3/0x3c40 mm/khugepaged.c:1678
>  khugepaged_scan_file mm/khugepaged.c:2073 [inline]
>  khugepaged_scan_mm_slot mm/khugepaged.c:2168 [inline]
>  khugepaged_do_scan mm/khugepaged.c:2252 [inline]
>  khugepaged+0x53c7/0x6c00 mm/khugepaged.c:2297
>  kthread+0x2e9/0x3a0 kernel/kthread.c:377
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:xa_parent_locked include/linux/xarray.h:1207 [inline]
> RIP: 0010:xas_create_range+0x2d9/0x6e0 lib/xarray.c:725
> Code: 89 ee 49 83 ed 40 49 c1 ee 03 4c 89 6d 08 4c 8d 6d 12 4d 01 e6 e9 93 00 00 00 e8 d2 0f 72 fd 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 fb 02 00 00 48 8b 04 24 4c 8b 7b 08 80 38 00
> RSP: 0018:ffffc90001097a48 EFLAGS: 00010002
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8880139de240 RSI: ffffffff8405e5be RDI: 0000000000000008
> RBP: ffffc90001097bb0 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff8405e679 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffffc90001097bc2 R14: fffff52000212f76 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe25571c98 CR3: 0000000079206000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	89 ee                	mov    %ebp,%esi
>    2:	49 83 ed 40          	sub    $0x40,%r13
>    6:	49 c1 ee 03          	shr    $0x3,%r14
>    a:	4c 89 6d 08          	mov    %r13,0x8(%rbp)
>    e:	4c 8d 6d 12          	lea    0x12(%rbp),%r13
>   12:	4d 01 e6             	add    %r12,%r14
>   15:	e9 93 00 00 00       	jmpq   0xad
>   1a:	e8 d2 0f 72 fd       	callq  0xfd720ff1
>   1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
>   2f:	0f 85 fb 02 00 00    	jne    0x330
>   35:	48 8b 04 24          	mov    (%rsp),%rax
>   39:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
>   3d:	80 38 00             	cmpb   $0x0,(%rax)
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
