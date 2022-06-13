Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382D6547FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiFMGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiFMGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:47:37 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C611151
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:47:26 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s189-20020a6b2cc6000000b00669add3c306so2183363ios.21
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=H900RnRQx9SNLesxaLHwkfzFlgaP9mV0xRwQtd1BOOo=;
        b=F8MbTDWFSqdf+MFLR2toYSr6Dqal83hw8LQbi2IzVdckDx1MFXveWgY+QzTANW0xso
         8hirF5H6RaLDG1S/Msp5VifOvR2nEdXfItbeRITEW2sMXi6F8iKMxQRicbsCFIhiONA8
         pGdrHQ27qUS7fjE0bj6vWq3pLkmg1J+38A9RvDnTJ68y+M6Z2g6EUwIQ/LzQc2Q12/9w
         GZVQ2A1f2OsxaQ6utZjhTbkooFiTWMZ5mHPSrBsO2B/+06iHWO3BrHXXm7dX1s8HagMW
         W4NtaZFmfkIsi7jT7DynbR5IF8P8emsYjpzOirCwfxYhzwb/s8TpXG8UqTkguEWR8K8T
         W7DA==
X-Gm-Message-State: AOAM5300rMYbaZfhcnhM92Fj0F0/tnrQsfzjJnuQywjdmfr2cFdQVL03
        2nm5eCu3gDNhl1SgznVZ7UZOaWAj3ghRYvf2U/aVCB3a778D
X-Google-Smtp-Source: ABdhPJwaxGwpZ0AOKZKkKNBlaJ1Hv2ZZ0b7REnUXwS2C2krIZujQL9+DfC80DLBkMg9iwS6zfvJ16p1uigg5l1pVWmD6gRbsOlJr
MIME-Version: 1.0
X-Received: by 2002:a6b:2b42:0:b0:669:ba8d:faa4 with SMTP id
 r63-20020a6b2b42000000b00669ba8dfaa4mr8349074ior.190.1655102846383; Sun, 12
 Jun 2022 23:47:26 -0700 (PDT)
Date:   Sun, 12 Jun 2022 23:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039bfb905e14ea9d0@google.com>
Subject: [syzbot] kernel BUG in mcopy_continue
From:   syzbot <syzbot+3f1e5c1dea3a2e66ea9a@syzkaller.appspotmail.com>
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

HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a777f7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=3f1e5c1dea3a2e66ea9a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f1e5c1dea3a2e66ea9a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/userfaultfd.c:642!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 14685 Comm: syz-executor.4 Not tainted 5.19.0-rc1-next-20220610-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__mcopy_atomic mm/userfaultfd.c:642 [inline]
RIP: 0010:mcopy_continue+0x80f/0x1360 mm/userfaultfd.c:699
Code: a8 ff 49 83 fd fe 0f 85 bd fd ff ff e8 ba ca a8 ff 0f 1f 44 00 00 e8 b0 ca a8 ff e8 ab ca a8 ff 48 8b 7c 24 20 e8 51 76 8b ff <0f> 0b e8 9a ca a8 ff 0f 0b e8 93 ca a8 ff 4d 89 ee 31 ff 41 81 e6
RSP: 0018:ffffc900058f7b70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880226dee58 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801a0b4228
RBP: 0000000020531000 R08: 0000000000000001 R09: ffff88801a0b422f
R10: ffffed1003416845 R11: 0000000000000001 R12: 0000000000000000
R13: fffffffffffffffe R14: 00000000fffffffe R15: ffff88801a0b4140
FS:  00007f91409ee700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c522000 CR3: 000000001d578000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 userfaultfd_continue fs/userfaultfd.c:1893 [inline]
 userfaultfd_ioctl+0x1818/0x41f0 fs/userfaultfd.c:2017
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f913f889109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f91409ee168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f913f99c030 RCX: 00007f913f889109
RDX: 0000000020000040 RSI: 00000000c020aa07 RDI: 0000000000000004
RBP: 00007f913f8e30ad R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcb29c401f R14: 00007f91409ee300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__mcopy_atomic mm/userfaultfd.c:642 [inline]
RIP: 0010:mcopy_continue+0x80f/0x1360 mm/userfaultfd.c:699
Code: a8 ff 49 83 fd fe 0f 85 bd fd ff ff e8 ba ca a8 ff 0f 1f 44 00 00 e8 b0 ca a8 ff e8 ab ca a8 ff 48 8b 7c 24 20 e8 51 76 8b ff <0f> 0b e8 9a ca a8 ff 0f 0b e8 93 ca a8 ff 4d 89 ee 31 ff 41 81 e6
RSP: 0018:ffffc900058f7b70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880226dee58 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801a0b4228
RBP: 0000000020531000 R08: 0000000000000001 R09: ffff88801a0b422f
R10: ffffed1003416845 R11: 0000000000000001 R12: 0000000000000000
R13: fffffffffffffffe R14: 00000000fffffffe R15: ffff88801a0b4140
FS:  00007f91409ee700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91409cd718 CR3: 000000001d578000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
