Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11229512002
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbiD0RX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbiD0RXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54CA45062
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8269EB825F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E21BC385A9;
        Wed, 27 Apr 2022 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651080033;
        bh=mDxN/hweypMYCBUL2KTZy6C5KMIYEDI13Bz4xMkwNDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AoM1WRvT7cRcSrN0EOxDpCyVFb7ymWjxKqBmTt9nSNf1P4fP+LOxH0x+70x6jYXTU
         +U9ltjHvwvISMNfCQN5WceOEYRLJkxtbyiQ0ZUw8I+C5Wqev+00Ixfw7B8RsV2iStJ
         RTkd7HooRBX1YG9qHsQbx/ToaPrlss2ZOWiy85aY=
Date:   Wed, 27 Apr 2022 10:20:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Liam Howlett <liam.howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [syzbot] WARNING in vma_merge
Message-Id: <20220427102032.5a87283eb64d06c1a6d682fd@linux-foundation.org>
In-Reply-To: <000000000000f28f0005dda29992@google.com>
References: <000000000000a23c8505dda227eb@google.com>
        <000000000000f28f0005dda29992@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 06:15:20 -0700 syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:

Thanks.

userfaultfd_release() appears to have offended vma_merge().

I'm not seeing any changes in that area from Peter, but Liam's
mapletree work changed things around a bit.  Gents, could you please
take a look?


> HEAD commit:    f02ac5c95dfd Add linux-next specific files for 20220427
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=105a33a2f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e9256c70f586da8a
> dashboard link: https://syzkaller.appspot.com/bug?extid=7728e4ab5371cebc9c00
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f76f82f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b42c3cf00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3593 at mm/mmap.c:1072 vma_merge+0x428/0x950 mm/mmap.c:1072

I assume this is

		VM_WARN_ON(area && end > area->vm_end);

But lines change around a lot.  It would be great if the script which
generates these reports could quote the code around the indicated file
and line.  Like:

	next = find_vma(mm, prev ? prev->vm_end : 0);
	area = next;
	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
		next = find_vma(mm, next->vm_end);

	/* verify some invariant that must be enforced by the caller */
	VM_WARN_ON(prev && addr <= prev->vm_start);
-->	VM_WARN_ON(area && end > area->vm_end);
	VM_WARN_ON(addr >= end);

	/*
	 * Can it merge with the predecessor?
	 */
	if (prev && prev->vm_end == addr &&




> Modules linked in:
> CPU: 1 PID: 3593 Comm: syz-executor549 Not tainted 5.18.0-rc4-next-20220427-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:vma_merge+0x428/0x950 mm/mmap.c:1072
> Code: 00 e8 5c 1f c4 ff e8 57 1f c4 ff 45 31 f6 e8 4f 1f c4 ff 4c 89 f0 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 38 1f c4 ff <0f> 0b e9 6c fd ff ff e8 2c 1f c4 ff 48 8d bd 88 00 00 00 48 b8 00
> RSP: 0018:ffffc90002edfd10 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000008102073 RCX: 0000000000000000
> RDX: ffff88801d0a3a80 RSI: ffffffff81b62968 RDI: 0000000000000003
> RBP: ffff88807e550bd0 R08: 0000000021001000 R09: 0000000000000000
> R10: ffffffff81b626ce R11: 0000000000000000 R12: 0000555557211000
> R13: 00005555571ef000 R14: ffff88807e550d80 R15: ffff88807e550d80
> FS:  00005555571ef300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005564400b0df0 CR3: 0000000073d7f000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  mlock_fixup+0x349/0x7f0 mm/mlock.c:420
>  apply_mlockall_flags+0x2be/0x440 mm/mlock.c:691
>  __do_sys_mlockall+0x222/0x4b0 mm/mlock.c:719
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f9cdd5a1f99
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffecfa63c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000097
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9cdd5a1f99
> RDX: 00007f9cdd5a1f99 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f9cdd565f80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9cdd566010
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
