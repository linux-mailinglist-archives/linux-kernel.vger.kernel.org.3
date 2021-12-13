Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0F472BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhLMMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhLMMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:07:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C61C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47D77CE0E29
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198F9C34602;
        Mon, 13 Dec 2021 12:07:48 +0000 (UTC)
Date:   Mon, 13 Dec 2021 13:07:45 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jack@suse.cz, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in minix_statfs
Message-ID: <20211213120745.2kzg4sazidh45cje@wittgenstein>
References: <0000000000005902e205d301dd7e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000005902e205d301dd7e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:17:25PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b8a98b6bf66a Merge tag 'pci-v5.16-fixes-2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1342c069b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
> dashboard link: https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e8a551b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176da9b9b00000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e8a7bdb00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1418a7bdb00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1018a7bdb00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com

This looks like minix isn't verifying the image it has been passed
sufficiently. Specifically, the reproducer might encode an invalid block
size but it's hard to make sense of all the raw addresses in the
reproducer. isofs has

	/* RDE: convert log zone size to bit shift */
	switch (sbi->s_log_zone_size) {
	case  512: sbi->s_log_zone_size =  9; break;
	case 1024: sbi->s_log_zone_size = 10; break;
	case 2048: sbi->s_log_zone_size = 11; break;

	default:
		goto out_bad_zone_size;
	}

minix has nothing so I'd expect it to be possible to pass

50000000000000000

as log zone size and minix would just use it causing the issue in
minix_statfs() you're seeing.

While that could be fixed I wonder if we shouldn't just mark minixfs as
broken. But I seriously have no clue who is using this fs for what.

> 
> loop0: detected capacity change from 0 to 272
> ================================================================================
> UBSAN: shift-out-of-bounds in fs/minix/inode.c:380:57
> shift exponent 65510 is too large for 64-bit type 'long unsigned int'
> CPU: 0 PID: 3601 Comm: syz-executor657 Not tainted 5.16.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:330
>  minix_statfs.cold+0x17/0x1c fs/minix/inode.c:380
>  statfs_by_dentry+0x133/0x210 fs/statfs.c:66
>  vfs_statfs fs/statfs.c:90 [inline]
>  fd_statfs+0x66/0x100 fs/statfs.c:120
>  __do_sys_fstatfs+0x7a/0xf0 fs/statfs.c:216
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f33e4f00e09
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeedacabd8 EFLAGS: 00000246 ORIG_RAX: 000000000000008a
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f33e4f00e09
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 00007f33e4ec06a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffeedacaa90 R11: 0000000000000246 R12: 00007f33e4ec0730
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ================================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
