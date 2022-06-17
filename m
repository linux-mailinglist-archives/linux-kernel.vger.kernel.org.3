Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F205E5500F8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiFQXxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiFQXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CB2252B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F49561DD9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA55C3411B;
        Fri, 17 Jun 2022 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655509978;
        bh=38NvZHDn60vRMd49ZIcaM3UlD3xicv2XgemZTeKzlzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DR9/1jgQG9f7/nSQ0N1IZnElWl9pJQueUPT3XPzhp7NZ4JO+1Aga9lj4XiIa3m9mV
         miEPhO47LkTd/aqlFWo3kexCj6geHI7Y7DwqPClebJA9FgiEMPiaR1uL8IfZXgFpEw
         coLwL+Frt2+yv+dUpX9U4/OjibXgTPFcYV8PtOUk=
Date:   Fri, 17 Jun 2022 16:52:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in hugepage_vma_check
Message-Id: <20220617165256.b5b9b257b30bc1dbb21fc8c6@linux-foundation.org>
In-Reply-To: <0000000000003189f305e19f5d3e@google.com>
References: <0000000000003189f305e19f5d3e@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 00:04:23 -0700 syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c6d7e3b385f1 Add linux-next specific files for 20220616
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10d9fb1bf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d495405e4a98620
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d875b4d2e2b60bae9b4
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> BUG: KASAN: null-ptr-deref in hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
> Read of size 8 at addr 00000000000005a8 by task syz-executor.5/21978

vma->vm_mm is NULL in show_smap->hugepage_vma_check().

Perhaps m_start() should be checking the mm after taking
mmap_read_lock() instead of before?

Matthew, you mucked with it last ;) Can you please take a look?

> CPU: 0 PID: 21978 Comm: syz-executor.5 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
>  hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
>  show_smap+0x1c6/0x470 fs/proc/task_mmu.c:866
>  traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
>  traverse fs/seq_file.c:101 [inline]
>  seq_read_iter+0x90f/0x1280 fs/seq_file.c:195
>  seq_read+0x337/0x4b0 fs/seq_file.c:162
>  do_loop_readv_writev fs/read_write.c:763 [inline]
>  do_loop_readv_writev fs/read_write.c:750 [inline]
>  do_iter_read+0x4f8/0x750 fs/read_write.c:805
>  vfs_readv+0xe5/0x150 fs/read_write.c:923
>  do_preadv fs/read_write.c:1015 [inline]
>  __do_sys_preadv fs/read_write.c:1065 [inline]
>  __se_sys_preadv fs/read_write.c:1060 [inline]
>  __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1060
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f5c1d889109
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5c1ea69168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 00007f5c1d99bf60 RCX: 00007f5c1d889109
> RDX: 0000000000000001 RSI: 00000000200006c0 RDI: 0000000000000005
> RBP: 00007f5c1d8e305d R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000fffffffe R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd8514b43f R14: 00007f5c1ea69300 R15: 0000000000022000
>  </TASK>
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
