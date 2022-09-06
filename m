Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEA5AE3FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiIFJSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiIFJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:17:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67F42AF0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:17:35 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i14-20020a5d934e000000b006892db5bcd4so6347916ioo.22
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=o5vt6n5uzHRV2inRdRYFbMurcSeLU1gt/8WKOwM5t0c=;
        b=kn40XcVg1iibkKEb6Fp+VIbBE3182Gu2YcqBP6NZkuG2uXxiRgAyK7/a0P6EDBjQnV
         3hcrEwxcg75Km5eH8tTNSWOYEl24Y7i61jYuekgmK2FZgXat4WNE/T4QayJpjDnNlMKn
         ODAVufxH+1qMV6zwUhuRPIfZUeE0Hq+hWppUjs/Qmq3jGpQoNkI5d4SqaTKmvPzCrhYW
         8pU0o7GYh8k2ES+t+JvWbRkvAD3W50XPdwgyxrudnCmnVSCNMD7y3OiDu7+2wkovFKdU
         2SByuv4WaAISNX+OYa8rVNhUSM9xx8jNnbOVkI2yJyqpfx7Iofhe5S29wvZluDP4vBte
         8ilQ==
X-Gm-Message-State: ACgBeo1p9W3qgI3KoEPiwugBDMSmqltKAFMmSeTMI+KV2JC2UWTvGgNR
        8FMqVhf2ed11RxtXi7ynZ6ZTtWzcwpLhAxpeIlza+aPL621a
X-Google-Smtp-Source: AA6agR6YZSrwStnQboormTshqosM2hBUjQBPLaGZ9yO7a4dmXOD3SWEn448ese0D8eC7FB/8TA3Mao728LwF3vRc3E+8yDmDZRay
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:2ee:bf22:630f with SMTP id
 q14-20020a92ca4e000000b002eebf22630fmr9639140ilo.287.1662455854696; Tue, 06
 Sep 2022 02:17:34 -0700 (PDT)
Date:   Tue, 06 Sep 2022 02:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac8efa05e7feaa1f@google.com>
Subject: [syzbot] WARNING in erofs_iget
From:   syzbot <syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    42cf58c272ee Merge tag 'tty-6.0-rc4' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16fd661b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=892a57667b7af6cf
dashboard link: https://syzkaller.appspot.com/bug?extid=f966c13b1b4fc0403b19
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fea393080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1501b0c5080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0cddb4889822/disk-42cf58c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86b24f0bd2f9/vmlinux-42cf58c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4
Dev loop0: unable to read RDB block 4
 loop0: unable to read partition table
loop0: partition table beyond EOD, truncated
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3611 at mm/page_alloc.c:5491 __alloc_pages+0x39e/0x510 mm/page_alloc.c:5491
Modules linked in:
CPU: 0 PID: 3611 Comm: syz-executor339 Not tainted 6.0.0-rc3-syzkaller-00328-g42cf58c272ee #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:__alloc_pages+0x39e/0x510 mm/page_alloc.c:5491
Code: ff ff 00 0f 84 33 fe ff ff 80 ce 01 e9 2b fe ff ff 83 fe 0a 0f 86 3e fd ff ff 80 3d 28 9c 0b 0c 00 75 09 c6 05 1f 9c 0b 0c 01 <0f> 0b 45 31 f6 e9 8d fe ff ff 65 ff 05 a1 76 44 7e 48 c7 c0 a0 21
RSP: 0018:ffffc9000396f8c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff9200072df19 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000034 RDI: 0000000000000000
RBP: 0000000000040cc0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000055 R12: 0000000000000034
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffff9200072df57
FS:  0000555556730300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffde3e9b000 CR3: 00000000732b1000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 kmalloc_order+0x34/0xf0 mm/slab_common.c:930
 kmalloc_order_trace+0x13/0x120 mm/slab_common.c:946
 kmalloc include/linux/slab.h:605 [inline]
 erofs_fill_symlink fs/erofs/inode.c:222 [inline]
 erofs_fill_inode fs/erofs/inode.c:273 [inline]
 erofs_iget+0x187c/0x26f0 fs/erofs/inode.c:351
 erofs_fc_fill_super+0x114b/0x21b0 fs/erofs/super.c:755
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fee22a3317a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde3e9a378 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffde3e9a3d0 RCX: 00007fee22a3317a
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007ffde3e9a390
RBP: 00007ffde3e9a390 R08: 00007ffde3e9a3d0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000230
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
