Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DBE58D023
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbiHHWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiHHWcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:32:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5619282
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47946CE117E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F61FC433C1;
        Mon,  8 Aug 2022 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659997965;
        bh=tT2nHk8kie8KrVXBrb9W4wk2Eht/0qrzqXMKsz1P64U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hArJTpZvNAkIDG5YEDcYvXpCW3ecJsIPoOtJ3nCsDaWCogROdd1rVILS6BcD66VEN
         23RdCmeMDLvVn89BYx7Y0guSWphgFtMg4S4t1M5HIDeys1/aLBCnLGHhL72ddvKpDQ
         sdjOmLXvQIVKw429FVW/GsYKKr1SBT2Fgxybp7EY=
Date:   Mon, 8 Aug 2022 15:32:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: Re: [syzbot] WARNING in find_vma
Message-Id: <20220808153243.6a80c73ce4f14c50efef086f@linux-foundation.org>
In-Reply-To: <0000000000007cda2705e5bfe389@google.com>
References: <00000000000085cb1705e5b5d9f6@google.com>
        <0000000000007cda2705e5bfe389@google.com>
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

(cc people from the thread "Binder regression caused by commit a43cfc87caaf")

On Mon, 08 Aug 2022 12:33:21 -0700 syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14807dfa080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7b60a176ec13cafb793
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12999232080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15452c12080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
> 
> binder: 7796:7797 ioctl c0306201 20001480 returned -14
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 7797 at include/linux/mmap_lock.h:155 mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
> WARNING: CPU: 1 PID: 7797 at include/linux/mmap_lock.h:155 find_vma+0xf8/0x270 mm/mmap.c:2255
> Modules linked in:
> CPU: 1 PID: 7797 Comm: syz-executor269 Not tainted 5.19.0-next-20220808-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
> RIP: 0010:find_vma+0xf8/0x270 mm/mmap.c:2255
> Code: 49 8d bc 24 28 01 00 00 be ff ff ff ff e8 40 2e c8 07 31 ff 89 c3 89 c6 e8 85 e2 c4 ff 85 db 0f 85 61 ff ff ff e8 b8 e5 c4 ff <0f> 0b e9 55 ff ff ff e8 ac e5 c4 ff 4c 89 e7 e8 54 38 fb ff 0f 0b
> RSP: 0018:ffffc9000cee7530 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88807c278000 RSI: ffffffff81b72058 RDI: 0000000000000005
> RBP: 0000000020ffc000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807dda3100
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f5fdf1fb700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000007d391000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vma_lookup include/linux/mm.h:2743 [inline]
>  binder_alloc_get_vma drivers/android/binder_alloc.c:340 [inline]
>  binder_alloc_new_buf_locked drivers/android/binder_alloc.c:405 [inline]
>  binder_alloc_new_buf+0xd6/0x18b0 drivers/android/binder_alloc.c:590
>  binder_transaction+0x242e/0x9a80 drivers/android/binder.c:3187
>  binder_thread_write+0x8a9/0x3220 drivers/android/binder.c:3963
>  binder_ioctl_write_read drivers/android/binder.c:5024 [inline]
>  binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f5fdf24ae19
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5fdf1fb318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f5fdf2d34e8 RCX: 00007f5fdf24ae19
> RDX: 0000000020000680 RSI: 00000000c0306201 RDI: 0000000000000003
> RBP: 00007f5fdf2d34e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5fdf2a02c0
> R13: 00007ffc598955af R14: 00007f5fdf1fb400 R15: 0000000000022000
>  </TASK>
