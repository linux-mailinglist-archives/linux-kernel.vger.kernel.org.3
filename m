Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96682526849
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382980AbiEMR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiEMR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:26:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF3A55213
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 714CDB83060
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0871C34100;
        Fri, 13 May 2022 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652462779;
        bh=LEzmtAgjsTTe61c4osagJaZMJYSveHV0AKf0/QCSHB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=evHJ1KAzE8tCCjh4/BMOkxuTHduH0DHubbfA+ORD0t3FMLazl/06xUe+sQXTCZjb0
         sMnW1mm/KXgKi27VUPgQdElYmZ9SF9gqQltH7CbFUUOZpLro18CXSfbwsLNNJqxMjb
         GzIujTzu71pvq9LchiONdzE34OCTpcgsPuAhZxPA=
Date:   Fri, 13 May 2022 10:26:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-Id: <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
In-Reply-To: <00000000000077377c05dee75f63@google.com>
References: <000000000000ef451a05dee0f2b1@google.com>
        <00000000000077377c05dee75f63@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 09:43:24 -0700 syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:

Thanks.

> HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=174ae715f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
> dashboard link: https://syzkaller.appspot.com/bug?extid=acf65ca584991f3cc447
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11531766f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce5a9ef00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3611 at mm/hugetlb.c:6250 follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250

The try_grab_folio() added by 822951d84684d ("mm/hugetlb: Use
try_grab_folio() instead of try_grab_compound_head()").  That commit
has been there over a month so I guess it's something else.  Does
someone have the time to bisect?

> Modules linked in:
> CPU: 1 PID: 3611 Comm: syz-executor603 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
> Code: 89 44 24 70 e8 2b 1d b7 ff 48 8b 44 24 70 48 85 c0 0f 84 f1 07 00 00 e8 88 1a b7 ff 48 83 ed 01 e9 09 fb ff ff e8 7a 1a b7 ff <0f> 0b 48 8b 7c 24 30 bb f4 ff ff ff e8 69 74 b8 07 4c 8b a4 24 b8
> RSP: 0018:ffffc90002f6f7e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88801bdd4e00 RCX: 0000000000000000
> RDX: ffff88801e4e3a80 RSI: ffffffff81c38f76 RDI: 0000000000000003
> RBP: ffffea0001fe8680 R08: 0000000000000000 R09: 0000000000000003
> R10: ffffffff81b128fb R11: 0000000000000008 R12: 000000000000001a
> R13: ffff88801bdd4e00 R14: ffff88801bdd5600 R15: 0000000000000019
> FS:  0000555556ad2300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000458 CR3: 000000001e850000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __get_user_pages+0x27a/0xfa0 mm/gup.c:1146
>  __get_user_pages_locked mm/gup.c:1365 [inline]
>  __gup_longterm_locked+0x1d5/0xfe0 mm/gup.c:1985
>  pin_user_pages+0x8e/0xe0 mm/gup.c:3118
>  io_sqe_buffer_register+0x254/0x1710 fs/io_uring.c:10537
>  io_sqe_buffers_register.cold+0x28e/0x443 fs/io_uring.c:10664
>  __io_uring_register fs/io_uring.c:12682 [inline]
>  __do_sys_io_uring_register+0xd21/0x1930 fs/io_uring.c:12816
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f5f42760cc9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffc3407aa8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f5f42760cc9
> RDX: 0000000020000380 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f5f42724e70 R08: 0000000010000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5f42724f00
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
