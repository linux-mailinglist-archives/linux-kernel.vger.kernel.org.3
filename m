Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394774877C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiAGMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:50:30 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48869 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347382AbiAGMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:50:20 -0500
Received: by mail-io1-f69.google.com with SMTP id i12-20020a056602134c00b0060211f8b5b7so3807291iov.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 04:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+OH30RJykWQK1mq+kRReOZroe/Z4LtMcBR3nlNtusOA=;
        b=NIP0bDsPworI/543L1iggtD2+/DgCB5sLW+diqm8D14p2i9xx0Ysh3/FAfWaeDV9MV
         OIL75JVtpwyvaFwVVAZEOCP1NHtvzU6PazOHS3voejoWQqB3OZAXQIOnLTOSJU0h/QZl
         mw6uTA78z2tK/3IPM0CVUYJ7m5rW58bgQsuKeHITmG3A9lBWCXLw0cqmnOYXS1CjoG1z
         ZH6/rO4Y/+JgDqphfnfZ9KoQGeqG7yDjE5Ua6iQ9BE8XHhT3KKqxp1XvwR0dxAD3gs7d
         RArbRyzqvPGc12aTKhFnzuwQRcPtQO93EPhrimcCHgqlaQyhP1exQktI25FBSLwlC/kw
         UB6Q==
X-Gm-Message-State: AOAM533NQsu8UAirqqcW7D5IwWs2jNLdYp6Q1JT8X2MzUYgcQDrFMRbv
        t3Xn3b8/o5cZuMcoz3vU4nLxkJtN8W31VstZLKlExbVLA7/P
X-Google-Smtp-Source: ABdhPJyepLMsI1PrEIR3ZlhJKqTTlvGfane7G6i3GD3tWhuWhaqTlYok5xlbyEFPR/38JTQ9DX16l+OGDlni2dMoBbw/BuMZx3Ec
MIME-Version: 1.0
X-Received: by 2002:a92:d34d:: with SMTP id a13mr3850552ilh.266.1641559819934;
 Fri, 07 Jan 2022 04:50:19 -0800 (PST)
Date:   Fri, 07 Jan 2022 04:50:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1e24805d4fd6d50@google.com>
Subject: [syzbot] KMSAN: uninit-value in p9pdu_vwritef
From:   syzbot <syzbot+99f920ef970b8c366bfe@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        glider@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10501807b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=99f920ef970b8c366bfe
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99f920ef970b8c366bfe@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in check_copy_size include/linux/thread_info.h:216 [inline]
BUG: KMSAN: uninit-value in copy_from_iter include/linux/uio.h:161 [inline]
BUG: KMSAN: uninit-value in copy_from_iter_full include/linux/uio.h:170 [inline]
BUG: KMSAN: uninit-value in pdu_write_u net/9p/protocol.c:68 [inline]
BUG: KMSAN: uninit-value in p9pdu_vwritef+0x458f/0x5100 net/9p/protocol.c:439
 check_copy_size include/linux/thread_info.h:216 [inline]
 copy_from_iter include/linux/uio.h:161 [inline]
 copy_from_iter_full include/linux/uio.h:170 [inline]
 pdu_write_u net/9p/protocol.c:68 [inline]
 p9pdu_vwritef+0x458f/0x5100 net/9p/protocol.c:439
 p9_client_prepare_req+0xe64/0x16d0 net/9p/client.c:703
 p9_client_rpc+0x28b/0x1460 net/9p/client.c:734
 p9_client_write+0x722/0xfa0 net/9p/client.c:1662
 v9fs_fid_xattr_set+0x3a6/0x520 fs/9p/xattr.c:130
 v9fs_xattr_set fs/9p/xattr.c:100 [inline]
 v9fs_xattr_handler_set+0x1b4/0x220 fs/9p/xattr.c:159
 __vfs_setxattr+0x910/0x960 fs/xattr.c:180
 __vfs_setxattr_noperm+0x382/0xe80 fs/xattr.c:214
 __vfs_setxattr_locked+0x629/0x690 fs/xattr.c:275
 vfs_setxattr+0x440/0x7b0 fs/xattr.c:301
 setxattr+0x42e/0x7c0 fs/xattr.c:575
 path_setxattr+0x2f4/0x520 fs/xattr.c:595
 __do_sys_setxattr fs/xattr.c:611 [inline]
 __se_sys_setxattr fs/xattr.c:607 [inline]
 __ia32_sys_setxattr+0x15b/0x1c0 fs/xattr.c:607
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc_trace+0xaca/0x1140 mm/slub.c:3276
 kmalloc include/linux/slab.h:590 [inline]
 p9_fid_create+0x7d/0x470 net/9p/client.c:892
 p9_client_walk+0x15f/0xe50 net/9p/client.c:1175
 clone_fid fs/9p/fid.h:21 [inline]
 v9fs_fid_xattr_set+0x244/0x520 fs/9p/xattr.c:118
 v9fs_xattr_set fs/9p/xattr.c:100 [inline]
 v9fs_xattr_handler_set+0x1b4/0x220 fs/9p/xattr.c:159
 __vfs_setxattr+0x910/0x960 fs/xattr.c:180
 __vfs_setxattr_noperm+0x382/0xe80 fs/xattr.c:214
 __vfs_setxattr_locked+0x629/0x690 fs/xattr.c:275
 vfs_setxattr+0x440/0x7b0 fs/xattr.c:301
 setxattr+0x42e/0x7c0 fs/xattr.c:575
 path_setxattr+0x2f4/0x520 fs/xattr.c:595
 __do_sys_setxattr fs/xattr.c:611 [inline]
 __se_sys_setxattr fs/xattr.c:607 [inline]
 __ia32_sys_setxattr+0x15b/0x1c0 fs/xattr.c:607
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

CPU: 0 PID: 22907 Comm: syz-executor.4 Tainted: G S                5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
