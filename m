Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664B4531FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiEXAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEXARi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:17:38 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF7A0D29
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:17:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so9069356iov.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ib/wnmiCE4UrP+PxplezNKep0P0zos65On51qeE2Ixk=;
        b=zFFf29S2nY3BRMUvQBnubgqZAznQYMWYJ5yhlz5+efkY0o6HjZm27ODwykTolETt08
         jyKTu/xqztMgxlwHSgQQPzRK7GQsgIVK3sC/yzZYNkBdVj2sBN7WP939vvOwT1NV0b6x
         P6K0AiuFj6ZJ1DBMx2gyuT5SixYiwMbkFHlDW5ISXbDqe+1w3IovxxT/6ZYacCZfMx7d
         DwFKxcnSsqQuF10CnE0I0UGjdMvj9PWBbCGCTUmYEjkCWzIcSNoYDY7MgnUdRIAOEOBF
         94U1FRk8fuFgCzGSzds1c0NXEJCfNQ92RMmcQNipq3cvZ4dfZoymJjUsc8YSEgAT/xbN
         4IbQ==
X-Gm-Message-State: AOAM531+sy+d9wHpq8C307XyVDVdHsUo+F58HYY3Vu9g+dLybCysueDW
        LAzIh9+mLBfptfaWZpp3dqSXAz8d8CL/FLC0xUXbqWFak0OL
X-Google-Smtp-Source: ABdhPJxzML7BkMvXkFicQjwEclQXlI5deOFK0DZz/OyRF/kTkCK8hKElqSZUX0gqMs8w3VjglLxhzaEZm49JXix+zN/tqpwitNra
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379c:b0:32e:d7a6:b715 with SMTP id
 w28-20020a056638379c00b0032ed7a6b715mr2583100jal.102.1653351441160; Mon, 23
 May 2022 17:17:21 -0700 (PDT)
Date:   Mon, 23 May 2022 17:17:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056e02f05dfb6e11a@google.com>
Subject: [syzbot] KASAN: use-after-free Write in udf_close_lvid
From:   syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alden.tondettar@gmail.com,
        hch@infradead.org, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4b0986a3613c Linux 5.18
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125ba355f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1350d397b63b3036
dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1732a04df00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15189639f00000

The issue was bisected to:

commit 781d2a9a2fc7d0be53a072794dc03ef6de770f3d
Author: Jan Kara <jack@suse.cz>
Date:   Mon May 3 09:39:03 2021 +0000

    udf: Check LVID earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14deecd3f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16deecd3f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12deecd3f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com
Fixes: 781d2a9a2fc7 ("udf: Check LVID earlier")

UDF-fs: error (device loop0): udf_fill_super: Error in udf_iget, block=96, partition=0
==================================================================
BUG: KASAN: use-after-free in udf_close_lvid+0x68a/0x980 fs/udf/super.c:2072
Write of size 1 at addr ffff8880839e0190 by task syz-executor234/3615

CPU: 1 PID: 3615 Comm: syz-executor234 Not tainted 5.18.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 udf_close_lvid+0x68a/0x980 fs/udf/super.c:2072
 udf_fill_super+0xde8/0x1b20 fs/udf/super.c:2309
 mount_bdev+0x26c/0x3a0 fs/super.c:1367
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1497
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fd64e59b08a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd64e546168 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd64e5461c0 RCX: 00007fd64e59b08a
RDX: 0000000020000000 RSI: 0000000020000700 RDI: 00007fd64e546180
RBP: 000000000000000e R08: 00007fd64e5461c0 R09: 00007fd64e5466b8
R10: 0000000000000810 R11: 0000000000000286 R12: 00007fd64e546180
R13: 0000000020000350 R14: 0000000000000003 R15: 0000000000000004
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00020e7800 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x839e0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00020e7808 ffffea00020e7808 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff8880839e0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880839e0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880839e0180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff8880839e0200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880839e0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
