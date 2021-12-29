Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0977481670
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhL2Tub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:50:31 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41677 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhL2Tu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:50:29 -0500
Received: by mail-il1-f199.google.com with SMTP id h23-20020a056e021d9700b002b49f2b9bccso13528109ila.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mQPPUyTs3wzefFyQNqxuxvqBAC0ggA8gOrATs3FJDw8=;
        b=ulBuCIBUs28pdHCCNzVIV4p0CnHShT/Nq0jn0JWp7REoWuB2jKTo2Zu0kN0KMvtEhS
         UwlgC8/uW/ajsTmbB2XQm5NfPNxTmBIBaRuc4UjZWnWRGSAQe8IsMUXRDcLusHAzyKZ4
         R4Q/nP6Ix5nUPzNCy/QU/nNGjIfeuBO5TiUqUOnTRuNV9FC//LfmE7COzF2NngpsNxQv
         duoTOIIrOeT+ASK9jNWqR9ezGd9zbGsLgeapts4VQXkNKc12g/RhMsXyQYAw3O1ODuXY
         F28HgOuVON+oE22xm5O1vlrF29MXXcJ8dJbpcXbOpykWEChMD1nRuzeGtX2IfCTJZvdw
         oMLA==
X-Gm-Message-State: AOAM532idLPqa/Tarlc0H/EuJAaSmB9dNt5xeWjLsmDE0Ur39E1HgYcn
        T93Ecm6j81IBFgsXABc5fk+U37LpBZ4bQaNAETvVlNyaqKdM
X-Google-Smtp-Source: ABdhPJwoYyz0jbjZ1ogXr2FeNOSyKYuiFEnpEIP7PN6ODRWZGSckBRIGYWxu9epf3G+jeC8E04OhpuQEi5u9JmXYbs7/Af7BYG5C
MIME-Version: 1.0
X-Received: by 2002:a92:c082:: with SMTP id h2mr12068853ile.168.1640807429382;
 Wed, 29 Dec 2021 11:50:29 -0800 (PST)
Date:   Wed, 29 Dec 2021 11:50:29 -0800
In-Reply-To: <00000000000047624505d0453c58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f927de05d44e3f30@google.com>
Subject: Re: [syzbot] WARNING in kernfs_remove_by_name_ns (3)
From:   syzbot <syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e7c124bd0463 Merge tag 'selinux-pr-20211228' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160bdec3b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ebd4b29568807bc
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f5025db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1009b371b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 4574 at fs/kernfs/dir.c:1536 kernfs_remove_by_name_ns+0x61/0x90 fs/kernfs/dir.c:1535
Modules linked in:

CPU: 1 PID: 4574 Comm: syz-executor510 Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kernfs_remove_by_name_ns+0x61/0x90 fs/kernfs/dir.c:1535
Code: 48 89 c3 e8 e1 5f 7d ff 48 89 df e8 c9 e7 ff ff 31 db eb 29 e8 d0 5f 7d ff 48 c7 c7 00 95 83 8a 4c 89 fe 31 c0 e8 9f 46 47 ff <0f> 0b bb fe ff ff ff eb 16 e8 b1 5f 7d ff bb fe ff ff ff 48 c7 c7
RSP: 0018:ffffc900049779f0 EFLAGS: 00010246

RAX: 50855e28c77b3200 RBX: 0000000000000000 RCX: ffff888077b0d700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff15a67d0 R08: ffffffff816a1042 R09: ffffed10173667b1
R10: ffffed10173667b1 R11: 0000000000000000 R12: ffffffff8d112008
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffffff8ad33ee0
FS:  00007f9f18971700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f1894fec8 CR3: 0000000014b98000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_remove_by_name include/linux/kernfs.h:570 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xf7/0x280 fs/sysfs/group.c:288
 sysfs_remove_groups+0x5b/0xb0 fs/sysfs/group.c:312
 __kobject_del+0x84/0x310 lib/kobject.c:611
 kobject_del+0x41/0x60 lib/kobject.c:643
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:183 [inline]
 blk_mq_sysfs_unregister+0x215/0x300 block/blk-mq-sysfs.c:302
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4196 [inline]
 blk_mq_update_nr_hw_queues+0x607/0x1250 block/blk-mq.c:4241
 nbd_start_device+0x176/0xcb0 drivers/block/nbd.c:1347
 nbd_start_device_ioctl drivers/block/nbd.c:1397 [inline]
 __nbd_ioctl drivers/block/nbd.c:1471 [inline]
 nbd_ioctl+0x30f/0xb80 drivers/block/nbd.c:1511
 blkdev_ioctl+0x3ac/0x790 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9f189c4379
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f189712e8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9f18a484e0 RCX: 00007f9f189c4379
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000006
RBP: 00007f9f18a15194 R08: 0000000000000001 R09: 0000000000000035
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9f18a484ec
R13: 00007f9f189712f0 R14: 00007f9f18a484e8 R15: 0000000000000001
 </TASK>

