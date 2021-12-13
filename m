Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42877472193
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhLMHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:17:29 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:48907 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhLMHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:17:26 -0500
Received: by mail-io1-f71.google.com with SMTP id g23-20020a6be617000000b005e245747fb4so14559051ioh.15
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bWjIbtRzJIZ5b9CQz1lfE5idRoHZe5RLnYbqs3Bckk8=;
        b=dwx3EDDGPn6UZ4+gQ7byaE/KhnDVmSi/BKnTwEk6NfUC2IyJxl1stxu7/AKgrKB+Rx
         b0Tkosa64SfG1PfNEEcqe+Q+EsWhTat3EaC6EAcnZxzryj85G5ylkHJUKJsS8qPYiUtw
         K6QrFDe4aa33Bu+zdCe3bBeP0Hw2h77ZJRxYVBdnchVc9/Oab0a9f9a25dnYiqT0Nwn4
         011TV9Vl+OeUnyIBbpaOIrY8Ylv2eCN7jm6vVokJDuBOZNCg55jxeLZCs1V8tehiSW56
         HIDZtTA94rDaeIxjN7lpWmGFbFKXNaScwtmZ/vMGreI5QsJtX+7R9bVbriLyWWlEMUTm
         pncQ==
X-Gm-Message-State: AOAM533HFQHuY9ecD/pnWaf5ZRJNReS5RfVAHUXuQqSkkhiDcaeH2S4s
        frcl4xQwZNaIb2GHSJVMwVw/sebRQgIpDeK8SA45hnbWKfYT
X-Google-Smtp-Source: ABdhPJxbLopa8WKkTPgJjZQd0Ia44Bzg6N5iMdoYQ+B8f4iitExonHK4mlIl4W8YVQA4ANsYtdTPLzsy7GUD2N8K/S8qEP0OcHMD
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr31554610iow.35.1639379845577;
 Sun, 12 Dec 2021 23:17:25 -0800 (PST)
Date:   Sun, 12 Dec 2021 23:17:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005902e205d301dd7e@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in minix_statfs
From:   syzbot <syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        gregkh@linuxfoundation.org, jack@suse.cz,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b8a98b6bf66a Merge tag 'pci-v5.16-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1342c069b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e8a551b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176da9b9b00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e8a7bdb00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1418a7bdb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1018a7bdb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 272
================================================================================
UBSAN: shift-out-of-bounds in fs/minix/inode.c:380:57
shift exponent 65510 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 3601 Comm: syz-executor657 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:330
 minix_statfs.cold+0x17/0x1c fs/minix/inode.c:380
 statfs_by_dentry+0x133/0x210 fs/statfs.c:66
 vfs_statfs fs/statfs.c:90 [inline]
 fd_statfs+0x66/0x100 fs/statfs.c:120
 __do_sys_fstatfs+0x7a/0xf0 fs/statfs.c:216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f33e4f00e09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeedacabd8 EFLAGS: 00000246 ORIG_RAX: 000000000000008a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f33e4f00e09
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f33e4ec06a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffeedacaa90 R11: 0000000000000246 R12: 00007f33e4ec0730
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
