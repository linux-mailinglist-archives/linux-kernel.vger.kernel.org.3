Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877C7590A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiHLCqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiHLCqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:46:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72979F0FB;
        Thu, 11 Aug 2022 19:46:20 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M3nzY4bPgzlW8Q;
        Fri, 12 Aug 2022 10:43:21 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 10:46:17 +0800
Subject: Re: [syzbot] possible deadlock in ext4_bmap
To:     syzbot <syzbot+9543479984ae9e576000@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tytso@mit.edu>
References: <000000000000967c2805e5b5d4ed@google.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <cad2edc1-57dd-1d79-0f2f-966e6fb31d5b@huawei.com>
Date:   Fri, 12 Aug 2022 10:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <000000000000967c2805e5b5d4ed@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inode_lock(inode) in vfs_fileattr_set() is a regular file inode and 
inode_lock_shared(inode) in ext4_bmap() is a journal inode.

So this might be a false positive deadlock warning.

Thanks,
Jason

On 2022/8/8 15:33, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177eb001080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=9543479984ae9e576000
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9543479984ae9e576000@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.19.0-next-20220808-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.3/15950 is trying to acquire lock:
> ffff88801b348400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:771 [inline]
> ffff88801b348400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
> 
> but task is already holding lock:
> ffff88814bede3f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x487/0xc00 fs/jbd2/journal.c:2472
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
>         __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>         mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
>         __jbd2_log_wait_for_space+0x234/0x460 fs/jbd2/checkpoint.c:110
>         add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
>         start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
>         jbd2__journal_start+0x38c/0x910 fs/jbd2/transaction.c:520
>         __ext4_journal_start_sb+0x3a3/0x490 fs/ext4/ext4_jbd2.c:105
>         __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
>         ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5963
>         __mark_inode_dirty+0x48b/0x1040 fs/fs-writeback.c:2381
>         mark_inode_dirty include/linux/fs.h:2467 [inline]
>         generic_write_end+0x350/0x440 fs/buffer.c:2199
>         ext4_da_write_end+0x16e/0x9a0 fs/ext4/inode.c:3089
>         generic_perform_write+0x306/0x560 mm/filemap.c:3749
>         ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:270
>         ext4_file_write_iter+0x44a/0x1660 fs/ext4/file.c:679
>         call_write_iter include/linux/fs.h:2192 [inline]
>         do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:729
>         do_iter_write+0x182/0x700 fs/read_write.c:855
>         vfs_iter_write+0x70/0xa0 fs/read_write.c:896
>         iter_file_splice_write+0x741/0xc90 fs/splice.c:686
>         do_splice_from fs/splice.c:764 [inline]
>         direct_splice_actor+0x110/0x180 fs/splice.c:931
>         splice_direct_to_actor+0x331/0x8a0 fs/splice.c:886
>         do_splice_direct+0x1a7/0x270 fs/splice.c:974
>         do_sendfile+0xb19/0x1270 fs/read_write.c:1249
>         __do_sys_sendfile64 fs/read_write.c:1311 [inline]
>         __se_sys_sendfile64 fs/read_write.c:1303 [inline]
>         __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1303
>         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>         do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
>         check_prev_add kernel/locking/lockdep.c:3095 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>         validate_chain kernel/locking/lockdep.c:3829 [inline]
>         __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
>         lock_acquire kernel/locking/lockdep.c:5666 [inline]
>         lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>         down_read+0x98/0x450 kernel/locking/rwsem.c:1499
>         inode_lock_shared include/linux/fs.h:771 [inline]
>         ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
>         bmap+0xaa/0x120 fs/inode.c:1799
>         jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
>         __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
>         jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
>         ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
>         __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
>         vfs_ioctl fs/ioctl.c:51 [inline]
>         __do_sys_ioctl fs/ioctl.c:870 [inline]
>         __se_sys_ioctl fs/ioctl.c:856 [inline]
>         __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>         do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&journal->j_checkpoint_mutex);
>                                 lock(&sb->s_type->i_mutex_key#8);
>                                 lock(&journal->j_checkpoint_mutex);
>    lock(&sb->s_type->i_mutex_key#8);
> 
>   *** DEADLOCK ***
> 
> 2 locks held by syz-executor.3/15950:
>   #0: ffff88814bede170 (&journal->j_barrier){+.+.}-{3:3}, at: jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
>   #1: ffff88814bede3f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x487/0xc00 fs/jbd2/journal.c:2472
> 
> stack backtrace:
> CPU: 1 PID: 15950 Comm: syz-executor.3 Not tainted 5.19.0-next-20220808-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
>   check_prev_add kernel/locking/lockdep.c:3095 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>   validate_chain kernel/locking/lockdep.c:3829 [inline]
>   __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
>   lock_acquire kernel/locking/lockdep.c:5666 [inline]
>   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>   down_read+0x98/0x450 kernel/locking/rwsem.c:1499
>   inode_lock_shared include/linux/fs.h:771 [inline]
>   ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
>   bmap+0xaa/0x120 fs/inode.c:1799
>   jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
>   __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
>   jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
>   ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
>   __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7feb4e689279
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007feb4f798168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007feb4e79bf80 RCX: 00007feb4e689279
> RDX: 0000000020000000 RSI: 000000004004662b RDI: 0000000000000005
> RBP: 00007feb4e6e3189 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc38bb538f R14: 00007feb4f798300 R15: 0000000000022000
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> .
> 
