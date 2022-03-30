Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377C4EBA90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiC3GHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiC3GHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:07:13 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97164E3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:05:28 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso13834481iox.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YNuSM1PODEqalFJzLcSrx4eph4vu+0fT2E5lHOEHHKs=;
        b=x0BtaK62nt1vW5s2iTTloSR5A2Y+VV8cbV7ERIR4LOXhwthQSH0hGcSHIbqm6a/HA2
         M0GnfuvEwac3EglmpKnzkSMW83OEXmYbaBalKq97i6H//fADnsJH0TR6JSbbKLdWKHnQ
         weJaCiBUXBV+RcAsOnPD0t+iX2k2fqSL1EAb9W7+JGwBa+QQVSZC3S5P9CnTYgLskbFF
         dJSRmZO9VvcSvpOdN51JVmWBIrNCJABdUwiHRc+FgbYs4/l6v1g7xZXCdT1vlYGGlI6c
         zRyFTJFkRhMoUPzfGOhJuV53BBH1tUh1cHq4XINJJ00aa8MliQhiGguhx1OVDE2R08YN
         Lmyg==
X-Gm-Message-State: AOAM531u2N7JFhCfr0nZUi7SBqJXXecw2xqbgSei3rZ0r6bwz7PlYhVJ
        kv0BagWnJ35+UYr2fznZuZXpurDasV3RwvnNH5ZLfPlTJGUD
X-Google-Smtp-Source: ABdhPJzt0zHtkNQii4VHDjAfMFoU62RMGTBtiJadxSDQuZfnX59pes6MD6Jly8A5SYrNGYvXadElHYh7rMdbiYjW3J9uOJewUpTJ
MIME-Version: 1.0
X-Received: by 2002:a02:950c:0:b0:323:918d:a98f with SMTP id
 y12-20020a02950c000000b00323918da98fmr1865702jah.190.1648620327317; Tue, 29
 Mar 2022 23:05:27 -0700 (PDT)
Date:   Tue, 29 Mar 2022 23:05:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fab48d05db6954a8@google.com>
Subject: [syzbot] kernel BUG in ntfs_may_write_mft_record
From:   syzbot <syzbot+29ca808a657244d4cd0e@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    34af78c4e616 Merge tag 'iommu-updates-v5.18' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b483fb700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6190c85675271e4a
dashboard link: https://syzkaller.appspot.com/bug?extid=29ca808a657244d4cd0e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29ca808a657244d4cd0e@syzkaller.appspotmail.com

ntfs: (device loop4): ntfs_read_locked_inode(): Failed with error code -5.  Marking corrupt inode 0xb as bad.  Run chkdsk.
ntfs: (device loop4): load_system_files(): Failed to load $Extend.
ntfs: (device loop4): ntfs_fill_super(): Failed to load system files.
------------[ cut here ]------------
kernel BUG at fs/ntfs/mft.c:952!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6627 Comm: syz-executor.4 Tainted: G        W         5.17.0-syzkaller-09727-g34af78c4e616 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ntfs_may_write_mft_record+0x282/0x6d0 fs/ntfs/mft.c:952
Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 47 77 da fe 4c 89 ff e8 4f 2f 3b ff 49 39 c7 49 89 c4 0f 84 bf fe ff ff e8 2e 77 da fe <0f> 0b e8 27 77 da fe 4c 89 f0 48 ba 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc900030bf1d8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000bdf3000
RDX: 0000000000040000 RSI: ffffffff829e9ac2 RDI: 0000000000000001
RBP: 1ffff92000617e3f R08: 0000000000000000 R09: ffff88802c4283ab
R10: ffffed1005885075 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900030bf3b8 R14: ffff88802e298000 R15: ffff88802c428320
FS:  00007fcc6d589700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00581b270 CR3: 0000000019ffa000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ntfs_write_mst_block+0x1273/0x34c0 fs/ntfs/aops.c:1123
 ntfs_writepage+0x1cea/0x4d70 fs/ntfs/aops.c:1408
 __writepage+0x60/0x180 mm/page-writeback.c:2308
 write_cache_pages+0x79f/0x1a50 mm/page-writeback.c:2243
 generic_writepages mm/page-writeback.c:2334 [inline]
 generic_writepages mm/page-writeback.c:2323 [inline]
 do_writepages+0x2b4/0x690 mm/page-writeback.c:2354
 __writeback_single_inode+0x126/0x10d0 fs/fs-writeback.c:1581
 writeback_single_inode+0x2a5/0x460 fs/fs-writeback.c:1702
 write_inode_now+0x15c/0x1d0 fs/fs-writeback.c:2697
 iput_final fs/inode.c:1731 [inline]
 iput.part.0+0x460/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 ntfs_fill_super+0x322e/0x9080 fs/ntfs/super.c:3003
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3590 [inline]
 __se_sys_mount fs/namespace.c:3567 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3567
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcc6c48a57a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcc6d588f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fcc6c48a57a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fcc6d588fe0
RBP: 00007fcc6d589020 R08: 00007fcc6d589020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fcc6d588fe0 R15: 000000002007dc00
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_may_write_mft_record+0x282/0x6d0 fs/ntfs/mft.c:952
Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 47 77 da fe 4c 89 ff e8 4f 2f 3b ff 49 39 c7 49 89 c4 0f 84 bf fe ff ff e8 2e 77 da fe <0f> 0b e8 27 77 da fe 4c 89 f0 48 ba 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc900030bf1d8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000bdf3000
RDX: 0000000000040000 RSI: ffffffff829e9ac2 RDI: 0000000000000001
RBP: 1ffff92000617e3f R08: 0000000000000000 R09: ffff88802c4283ab
R10: ffffed1005885075 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900030bf3b8 R14: ffff88802e298000 R15: ffff88802c428320
FS:  00007fcc6d589700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10cf5bbfc0 CR3: 0000000019ffa000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
