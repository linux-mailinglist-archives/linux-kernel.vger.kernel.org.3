Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64F758C406
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiHHHeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiHHHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:34:46 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5206414
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:34:45 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a17-20020a056e0208b100b002dc52b51d98so6098777ilt.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 00:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=1KSPAlXtPmymix4KowSu/UDGd78cL7X7kSaL8eGFivM=;
        b=FfIixxrYXilcVl3K2oLelcYWtk6Lsj+zbcS9A+fii0+wT/Nvbxe6o2X3UzHglFp7Gm
         fHrzAyTYxcqfwrvaGzKR9M1Q+LdtDGgn9DQm8jf22xHXjtsaSzrW/Ww1WghUdnZ0Bzrs
         djyl0/rRy/FPNhR+m6tjGdCYFyUfoe+VqusBP+VW/PyZKpPZM3MbeSJGw4uH4I1z3ap+
         Yq+g8rc7nCp1btobKSWy59IL9LR7lO2sVOngGdDqS4sO2kSlU5sqnrH1k2vGExKYwK7L
         QFx/M58HPF4uSKm6KcvbafW22FNsp4+rXhCJ4JDMbGNMhCeOTfBKOd+BF61hL+urxtHd
         Zh+g==
X-Gm-Message-State: ACgBeo0fIIBHb5b1QLDGc06Ii623ENyRZpeGhZtMggm+qGyj3sR/Mixf
        3+Yj4bkNWSnh/sgUaZS/KX80xecVe9MdU7BCjl/O8fN0HRvR
X-Google-Smtp-Source: AA6agR4EcFeUkTP2RZBQNzpnw0Bxec4qJTXk3mOW0YmzH1CcY5lQDYxk+/TTUeu5dYsMs1OX41cL/gXaut1FEVCPFV6moehRfVVn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15ca:b0:66d:9f5:4535 with SMTP id
 f10-20020a05660215ca00b0066d09f54535mr6920077iow.66.1659944084817; Mon, 08
 Aug 2022 00:34:44 -0700 (PDT)
Date:   Mon, 08 Aug 2022 00:34:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085cb1705e5b5d9f6@google.com>
Subject: [syzbot] WARNING in find_vma
From:   syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
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

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e83871080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=a7b60a176ec13cafb793
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 6818 at include/linux/mmap_lock.h:155 mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
WARNING: CPU: 0 PID: 6818 at include/linux/mmap_lock.h:155 find_vma+0xf8/0x270 mm/mmap.c:2255
Modules linked in:
CPU: 1 PID: 6818 Comm: syz-executor.4 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
RIP: 0010:find_vma+0xf8/0x270 mm/mmap.c:2255
Code: 49 8d bc 24 28 01 00 00 be ff ff ff ff e8 40 2e c8 07 31 ff 89 c3 89 c6 e8 85 e2 c4 ff 85 db 0f 85 61 ff ff ff e8 b8 e5 c4 ff <0f> 0b e9 55 ff ff ff e8 ac e5 c4 ff 4c 89 e7 e8 54 38 fb ff 0f 0b
RSP: 0018:ffffc9000cac7530 EFLAGS: 00010216
RAX: 0000000000001fcd RBX: 0000000000000000 RCX: ffffc90003991000
RDX: 0000000000040000 RSI: ffffffff81b72058 RDI: 0000000000000005
RBP: 0000000020ffc000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888020bb6900
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000006
FS:  00007f8a9c5d8700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002019c000 CR3: 000000001de0c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_lookup include/linux/mm.h:2743 [inline]
 binder_alloc_get_vma drivers/android/binder_alloc.c:340 [inline]
 binder_alloc_new_buf_locked drivers/android/binder_alloc.c:405 [inline]
 binder_alloc_new_buf+0xd6/0x18b0 drivers/android/binder_alloc.c:590
 binder_transaction+0x242e/0x9a80 drivers/android/binder.c:3187
 binder_thread_write+0x8a9/0x3220 drivers/android/binder.c:3963
 binder_ioctl_write_read drivers/android/binder.c:5024 [inline]
 binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8a9b489279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a9c5d8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8a9b59bf80 RCX: 00007f8a9b489279
RDX: 0000000020000680 RSI: 00000000c0306201 RDI: 0000000000000004
RBP: 00007f8a9b4e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffde1b812ff R14: 00007f8a9c5d8300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
