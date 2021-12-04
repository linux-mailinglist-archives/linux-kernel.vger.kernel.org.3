Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8114683E1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384575AbhLDJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:57:48 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35692 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384604AbhLDJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:57:43 -0500
Received: by mail-io1-f69.google.com with SMTP id x11-20020a0566022c4b00b005e702603028so4474733iov.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6BRacZEyRxHIlxqM1e6e2FDlog/Bi3Tc4ToxnAE9B0k=;
        b=CKgr1eDlD1I0lJpsw075RFyXt6wRbOLldGyMnP4ITSj6ITB4VcNnCuWKg6CY3N6LjL
         QepMJUzjoBs4HI+SMyxUxsijcaCNDB2QIzJfB9zU4D8TEpTBpLNo/vE36957TnQZ9gVy
         dBRBxEef74nTACEuJ4M3dNSV85YaAhxCWRE9nIkDGCRxkjiKIaOxjYC5F6uTl7FhGHCC
         DfzEMMomyPezRPw3zcGcGo9y9142+CWoboP/c+Va/iEKUwGa0THZrlVNKPBiSAhL1QxV
         LsVgIm+SYOVGo1zozdNDH1Q+npqa4uCMhFG9Uu9jLhv8JrQaZ3f/Oksv6GSmmQmlC4i8
         GZ5A==
X-Gm-Message-State: AOAM531HEm55uKnofwgU0n+0lZugnkZcqKWzu0/lO/DX8GbzvQmTCUi5
        WCWLpYc1R9JZXAtpU8zCV0VMQAxeBfG9vw4ee5G9mB6YEsOF
X-Google-Smtp-Source: ABdhPJxy225ujbxOgiVYY383gQxMBC7YzeQDVWfjE9PAI2gtRB/9YTxe4uS9uKXLFWPDZV8fDfAAfpWOUit2s3ZM8/PEFq2EmazO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b01:: with SMTP id i1mr20369909ilv.94.1638611657660;
 Sat, 04 Dec 2021 01:54:17 -0800 (PST)
Date:   Sat, 04 Dec 2021 01:54:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c79f2605d24f0151@google.com>
Subject: [syzbot] general protection fault in gfs2_evict_inode
From:   syzbot <syzbot+f77e2d1dc867b6accaf9@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d4439a1189f9 Merge tag 'hsi-for-5.16' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fae7cab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f2760850058fbfb
dashboard link: https://syzkaller.appspot.com/bug?extid=f77e2d1dc867b6accaf9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f77e2d1dc867b6accaf9@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f4836721000 R15: 0000000020047a20
 </TASK>
gfs2: fsid=syz:syz.0: can't read journal index: -5
general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 1 PID: 25372 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:evict_linked_inode fs/gfs2/super.c:1331 [inline]
RIP: 0010:gfs2_evict_inode+0xbe2/0x2070 fs/gfs2/super.c:1386
Code: 03 80 3c 02 00 0f 85 d0 13 00 00 48 8b 9d 00 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb 8c 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8
RSP: 0018:ffffc90009bb77c8 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000b53c000
RDX: 0000000000000011 RSI: ffffffff836c5f71 RDI: 000000000000008c
RBP: ffff88803ae28000 R08: 0000000000000000 R09: ffff88807115fb43
R10: ffffffff83666100 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807115fcb8 R14: ffff8880959e5cd8 R15: ffff8880959e5828
FS:  00007f4836721700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fb011f000 CR3: 0000000022ee7000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:588
 iput_final fs/inode.c:1664 [inline]
 iput.part.0+0x539/0x850 fs/inode.c:1690
 iput+0x58/0x70 fs/inode.c:1680
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:376
 __dentry_kill+0x3c0/0x640 fs/dcache.c:582
 dentry_kill fs/dcache.c:708 [inline]
 dput+0x738/0xbc0 fs/dcache.c:888
 gfs2_fill_super+0x2048/0x28a0 fs/gfs2/ops_fstype.c:1296
 get_tree_bdev+0x440/0x760 fs/super.c:1293
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1327
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f48391ad01a
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4836720fa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f48391ad01a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4836721000
RBP: 00007f4836721040 R08: 00007f4836721040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f4836721000 R15: 0000000020047a20
 </TASK>
Modules linked in:
---[ end trace 68c9d12f167f0520 ]---
RIP: 0010:evict_linked_inode fs/gfs2/super.c:1331 [inline]
RIP: 0010:gfs2_evict_inode+0xbe2/0x2070 fs/gfs2/super.c:1386
Code: 03 80 3c 02 00 0f 85 d0 13 00 00 48 8b 9d 00 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb 8c 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8
RSP: 0018:ffffc90009bb77c8 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000b53c000
RDX: 0000000000000011 RSI: ffffffff836c5f71 RDI: 000000000000008c
RBP: ffff88803ae28000 R08: 0000000000000000 R09: ffff88807115fb43
R10: ffffffff83666100 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807115fcb8 R14: ffff8880959e5cd8 R15: ffff8880959e5828
FS:  00007f4836721700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fb011f000 CR3: 0000000022ee7000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
----------------
Code disassembly (best guess):
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 d0                	test   %edx,%eax
   8:	13 00                	adc    (%rax),%eax
   a:	00 48 8b             	add    %cl,-0x75(%rax)
   d:	9d                   	popfq
   e:	00 09                	add    %cl,(%rcx)
  10:	00 00                	add    %al,(%rax)
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 8d bb 8c 00 00 00 	lea    0x8c(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 09                	jl     0x44
  3b:	84 d2                	test   %dl,%dl
  3d:	74 05                	je     0x44
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
