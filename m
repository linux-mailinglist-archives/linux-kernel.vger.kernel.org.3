Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24E4876AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiAGLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:42:19 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44769 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiAGLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:42:19 -0500
Received: by mail-io1-f71.google.com with SMTP id i188-20020a6b3bc5000000b00601decb6241so3708328ioa.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lYKlEcw01fVK7S/jqknBFqHoDSjpGc+i3GSfHBVKYks=;
        b=tR+zpGDZaO08o4Gep/V+nQ3uPlEFBpgRDa85Y6gHolA2QuPzTuVDz+gT1DyffNDnkD
         5Mzj3zA5kKnp+e97uktoBWs1K3lWNeIXz6uCzVNLmqBevSV5RBXy7W2t7gJzrKIKZPDR
         VfO2fy8bS3Qn5TLIHpEN3Lig/M3KasL/PW4rD4NLYyoWnp5a9EThOfucOF7b7994PZrQ
         VtoOv3M+ctk4pBmilJPVk/cHd+tNLRytT+rrbD5S4b7iflgc1kzHa8bTtLqLCSLuMNdd
         jKZwKt3QRYiLiyocyRlLyJFD4aLNK9b11/lmv1UevnYJwMtQYwQV7xyk/DdNCj5q4wFH
         SAHQ==
X-Gm-Message-State: AOAM530TdXbcj5t4B4I/TeHcY6CEgRP5V/tho3anKatBM3MbtLgxERcQ
        bYmENrMR2wG51YAifY+OYocYy14XdfrmC74lmSPpwzCQRVzP
X-Google-Smtp-Source: ABdhPJwsEUp94YoyDbHeW9R1EJElMujWVZU0VU3OXVBBo3fu145Ym2vLsAebhxJ1Fz7Zb/Fya4qCoB7WRjDujMx1aFitEKDnqlM8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:506:: with SMTP id i6mr31380804jar.229.1641555738522;
 Fri, 07 Jan 2022 03:42:18 -0800 (PST)
Date:   Fri, 07 Jan 2022 03:42:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac7b2e05d4fc7a88@google.com>
Subject: [syzbot] KMSAN: uninit-value in from_kgid
From:   syzbot <syzbot+13e44cec8bcb2396a0a3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        cxfcosmos@gmail.com, ebiederm@xmission.com, glider@google.com,
        legion@kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10071b99b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=13e44cec8bcb2396a0a3
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13e44cec8bcb2396a0a3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in map_id_up_base kernel/user_namespace.c:335 [inline]
BUG: KMSAN: uninit-value in map_id_up kernel/user_namespace.c:365 [inline]
BUG: KMSAN: uninit-value in from_kgid+0x52e/0xbe0 kernel/user_namespace.c:481
 map_id_up_base kernel/user_namespace.c:335 [inline]
 map_id_up kernel/user_namespace.c:365 [inline]
 from_kgid+0x52e/0xbe0 kernel/user_namespace.c:481
 p9pdu_vwritef+0x18d0/0x5100 net/9p/protocol.c:405
 p9pdu_writef+0x240/0x290 net/9p/protocol.c:539
 p9pdu_vwritef+0x21ed/0x5100 net/9p/protocol.c:490
 p9_client_prepare_req+0xe64/0x16d0 net/9p/client.c:703
 p9_client_rpc+0x28b/0x1460 net/9p/client.c:734
 p9_client_setattr+0x113/0x2c0 net/9p/client.c:1894
 v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:588
 notify_change+0x1fde/0x2180 fs/attr.c:410
 chown_common+0x832/0xc70 fs/open.c:678
 do_fchownat+0x2df/0x4e0 fs/open.c:709
 ksys_lchown include/linux/syscalls.h:1335 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0x200/0x250 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 v9fs_vfs_setattr_dotl+0x5a9/0xd70 fs/9p/vfs_inode_dotl.c:566
 notify_change+0x1fde/0x2180 fs/attr.c:410
 chown_common+0x832/0xc70 fs/open.c:678
 do_fchownat+0x2df/0x4e0 fs/open.c:709
 ksys_lchown include/linux/syscalls.h:1335 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0x200/0x250 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable newattrs created at:
 chown_common+0x120/0xc70 fs/open.c:647
 do_fchownat+0x2df/0x4e0 fs/open.c:709

CPU: 0 PID: 31712 Comm: syz-executor.3 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
