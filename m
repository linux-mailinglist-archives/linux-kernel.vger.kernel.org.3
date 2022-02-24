Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE94C38DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiBXWkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiBXWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:40:48 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D62036CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:40:18 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id f9-20020a5ec709000000b00640c72b204eso2564052iop.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8Zh3sOhU6fOzqR7hpmIplwNHGdnKUf8vJ5NprxHVyM8=;
        b=arZgx2bwLns1Ewr8E0zxGKIFLMHSqy/Q4zjtf1lc7gMthPw/TTapwk9HKQ7PoPbq2e
         3Xxm9H6CeXo8Vc6n/JB0qzLy8gbBl2eIRNgbZ8/cTFE+3oIvBFHoR6pbEYknHIZ26XJC
         KjYmHUzf7qwYDz/OO8RJWD3BQt9q9LrD1hlkJiqPFxefTcCCJWAzYDjo5dH5yOkpH+Ef
         Nyf8t6E5R1vIoWoM0jNNgK62vKjfh3tdiOu1pka3qd3B75ENSqP3JqdCncrX8rU3WZtE
         iu4+eraisLfwffYBji8D6H2E8IC5wEWqSdIJFOY+nKvf12Q4ZiWLksIWUuKtiC2FI/nE
         tPLA==
X-Gm-Message-State: AOAM532c51jCJ/3lAEpaypNE47qsj+Uf9ynfqA2K2/ZqtjCLFogfBhpo
        KOtpHEzmx/rpJVw5in7Zj3wfjuqU94Ld83s4haRvBMP+k4fT
X-Google-Smtp-Source: ABdhPJx5uaPerUDlzu6f+Yb7dkVPhZ6cg/hvYB2Gp0wJlvJxg1lc0wtQgaqyMoGBwXhkdViGgzidxlDmqAsHmiIjeh/FbpQnj1nM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:2c2:92fe:9688 with SMTP id
 n9-20020a056e02148900b002c292fe9688mr3729978ilk.177.1645742417833; Thu, 24
 Feb 2022 14:40:17 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:40:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034f53905d8cb4470@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in minix_count_free_blocks
From:   syzbot <syzbot+2f142b57f2af27974fda@syzkaller.appspotmail.com>
To:     aeb@cwi.nl, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    23d04328444a Merge tag 'for-5.17/parisc-4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1275258e700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15187fc11a461d83
dashboard link: https://syzkaller.appspot.com/bug?extid=2f142b57f2af27974fda
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134ea112700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1038b52e700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132d548e700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ad548e700000
console output: https://syzkaller.appspot.com/x/log.txt?x=172d548e700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f142b57f2af27974fda@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 24
MINIX-fs: mounting unchecked file system, running fsck is recommended
================================================================================
UBSAN: shift-out-of-bounds in fs/minix/bitmap.c:103:3
shift exponent 34 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 3594 Comm: syz-executor300 Not tainted 5.17.0-rc5-syzkaller-00021-g23d04328444a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:330
 minix_count_free_blocks.cold+0x16/0x1b fs/minix/bitmap.c:103
 minix_statfs+0x22a/0x490 fs/minix/inode.c:381
 statfs_by_dentry+0x133/0x210 fs/statfs.c:66
 vfs_statfs fs/statfs.c:90 [inline]
 user_statfs+0xa9/0x160 fs/statfs.c:105
 __do_sys_statfs+0x7a/0xf0 fs/statfs.c:195
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff02930fdd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6c051938 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007ff02930fdd9
RDX: 00007ff0292ce3a3 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007ff0292cf670 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffe6c051800 R11: 0000000000000246 R12: 00007ff0292cf700
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
