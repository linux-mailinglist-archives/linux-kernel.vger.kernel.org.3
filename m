Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70DA4EDF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiCaQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiCaQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:45:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C4209A67;
        Thu, 31 Mar 2022 09:44:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9437C68AFE; Thu, 31 Mar 2022 18:43:58 +0200 (CEST)
Date:   Thu, 31 Mar 2022 18:43:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+e08de3db8be67b2a01b0@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in bio_free
Message-ID: <20220331164358.GA30565@lst.de>
References: <0000000000006cc9ec05db8658be@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006cc9ec05db8658be@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,GB_FAKE_RF_SHORT,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test git://git.infradead.org/users/hch/misc.git squashfs-fix

On Thu, Mar 31, 2022 at 09:42:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fdcbcd1348f4 Add linux-next specific files for 20220331
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c815bb700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=366ab475940a4177
> dashboard link: https://syzkaller.appspot.com/bug?extid=e08de3db8be67b2a01b0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131015d7700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14807cf7700000
> 
> The issue was bisected to:
> 
> commit 57c47b42f4545b5f8fa288f190c0d68f96bc477f
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Mar 8 06:15:50 2022 +0000
> 
>     block: turn bio_kmalloc into a simple kmalloc wrapper
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1567f79b700000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1767f79b700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1367f79b700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e08de3db8be67b2a01b0@syzkaller.appspotmail.com
> Fixes: 57c47b42f454 ("block: turn bio_kmalloc into a simple kmalloc wrapper")
> 
> loop0: detected capacity change from 0 to 8
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3587 at block/bio.c:229 bio_free+0xe8/0x120 block/bio.c:229
> Modules linked in:
> CPU: 1 PID: 3587 Comm: syz-executor393 Not tainted 5.17.0-next-20220331-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:bio_free+0xe8/0x120 block/bio.c:229
> Code: fa 48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03 7e 20 8b 45 08 48 83 c4 08 48 29 c3 48 89 df 5b 5d e9 fd be cb fd e8 a8 af a3 fd <0f> 0b e9 51 ff ff ff 48 89 34 24 e8 e8 57 ef fd 48 8b 34 24 eb d1
> RSP: 0018:ffffc900038efac0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8880241c7f00 RCX: 0000000000000000
> RDX: ffff888019410000 RSI: ffffffff83d57848 RDI: ffff8880241c7f80
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff83d57915 R11: 0000000000000000 R12: 0000000000000060
> R13: 0000000000000060 R14: 0000000000001000 R15: 0000000000000060
> FS:  0000555556045300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc4e7ecd20 CR3: 000000007554f000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bio_put+0x20e/0x3b0 block/bio.c:754
>  squashfs_read_data+0x2ce/0xed0 fs/squashfs/block.c:221
>  squashfs_read_table+0x184/0x1f0 fs/squashfs/cache.c:432
>  squashfs_fill_super+0x337/0x2690 fs/squashfs/super.c:184
>  get_tree_bdev+0x440/0x760 fs/super.c:1292
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1320/0x1fa0 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f5ae6a070da
> Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe7a847f68 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffe7a847fc0 RCX: 00007f5ae6a070da
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe7a847f80
> RBP: 00007ffe7a847f80 R08: 00007ffe7a847fc0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000218
> R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000001
>  </TASK>
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
---end quoted text---
