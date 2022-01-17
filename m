Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82C84903AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiAQIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:23:35 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:57228 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiAQIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:23:30 -0500
Received: by mail-io1-f71.google.com with SMTP id d125-20020a6bb483000000b006051f7a8573so9135527iof.23
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uZJSHqBvwk4+oJQ55PV/wyfLAsTJswiu5ctLzWqJ9Og=;
        b=g+Vii23SbDQIU6UED1ep1ZK+zgAM0HAjb4rK02at3xKhO6aKNYtPJUuQEYA9IuFPOO
         9apsY3505YQGTtiApDNRB198/lWn2qppCncD+WWLLvmS2RK2JiyTtN/jog/mm7Boc0/j
         /XpenUdWvvSBS1JDMWUw0uLHcwOlIYhFlP/BKMdLoYYfAlqFv8UyCmFeWt/seWLJJQwu
         RA6qOywXWYRlPTt1Q3jm00rCbHrIhL19/2mDaAT5TPbLm5Lot2oJyNUDaCfoY7PGfaFL
         jWCj4bWgQS770WYHoYK7lr1jIFGyw2Sd8PaIkAAN40lgeA6PN2EtR6mnqaHBOec96BcZ
         /LtA==
X-Gm-Message-State: AOAM5334TGKkJSLtcAhe19VQz4v6TEpSz4QLagYL/6v1zvpaljbMmDdb
        IlJJeheZekchLxOb/PsE4dKqdFL9rtxELFdLV9WD+vJDLIMR
X-Google-Smtp-Source: ABdhPJw4L4zQGQgdLImcjmr88iboT1xngJsxp4eXNWe83BYhnBxGFZYoKlUPKj357OHOBJRi/7PmObsQQMHe/yO6a+12o8F2lthX
MIME-Version: 1.0
X-Received: by 2002:a02:cea9:: with SMTP id z9mr9349545jaq.302.1642407810171;
 Mon, 17 Jan 2022 00:23:30 -0800 (PST)
Date:   Mon, 17 Jan 2022 00:23:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a08ae05d5c2de52@google.com>
Subject: [syzbot] general protection fault in gfs2_dump_glock
From:   syzbot <syzbot+c6fd14145e2f62ca0784@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6f38be8f2ccd Merge tag 'docs-5.17' of git://git.lwn.net/li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16707bbfb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b584f9cb7739d39
dashboard link: https://syzkaller.appspot.com/bug?extid=c6fd14145e2f62ca0784
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6fd14145e2f62ca0784@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: fatal: filesystem consistency error
  RG = 20
  function = compute_bitstructs, file = fs/gfs2/rgrp.c, line = 828
general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 2 PID: 6932 Comm: syz-executor.0 Not tainted 5.16.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:gfs2_dump_glock+0xaa/0x1b00 fs/gfs2/glock.c:2392
Code: f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a8 02 00 00 31 c0 e8 a4 58 10 fe 49 8d bf 90 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 0c 18 00 00 49 8b 87 90 00 00 00 49 8d 7f 10 48
RSP: 0018:ffffc900040c7178 EFLAGS: 00010206
RAX: 0000000000000012 RBX: 0000000000000001 RCX: ffffc9000ba89000
RDX: 0000000000040000 RSI: ffffffff83666e0c RDI: 0000000000000090
RBP: dffffc0000000000 R08: 0000000000000086 R09: 0000000000000000
R10: ffffffff815db79e R11: 0000000000000000 R12: ffffffff89f76b60
R13: ffffffff89f75ec0 R14: 000000000000033c R15: 0000000000000000
FS:  00007f524eebd700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555569e5708 CR3: 000000004a185000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_consist_rgrpd_i+0x134/0x1b0 fs/gfs2/util.c:479
 compute_bitstructs fs/gfs2/rgrp.c:828 [inline]
 read_rindex_entry+0xe8c/0x12f0 fs/gfs2/rgrp.c:925
 gfs2_ri_update+0x73/0x570 fs/gfs2/rgrp.c:999
 gfs2_rindex_update+0x41c/0x4a0 fs/gfs2/rgrp.c:1049
 init_inodes+0x1ed6/0x2720 fs/gfs2/ops_fstype.c:914
 gfs2_fill_super+0x1b49/0x28a0 fs/gfs2/ops_fstype.c:1244
 get_tree_bdev+0x440/0x760 fs/super.c:1295
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1327
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f52505493ea
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f524eebcf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f52505493ea
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f524eebcfe0
RBP: 00007f524eebd020 R08: 00007f524eebd020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f524eebcfe0 R15: 00000000200001c0
 </TASK>
Modules linked in:
---[ end trace 9fee23b764ba8831 ]---
RIP: 0010:gfs2_dump_glock+0xaa/0x1b00 fs/gfs2/glock.c:2392
Code: f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a8 02 00 00 31 c0 e8 a4 58 10 fe 49 8d bf 90 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 0c 18 00 00 49 8b 87 90 00 00 00 49 8d 7f 10 48
RSP: 0018:ffffc900040c7178 EFLAGS: 00010206
RAX: 0000000000000012 RBX: 0000000000000001 RCX: ffffc9000ba89000
RDX: 0000000000040000 RSI: ffffffff83666e0c RDI: 0000000000000090
RBP: dffffc0000000000 R08: 0000000000000086 R09: 0000000000000000
R10: ffffffff815db79e R11: 0000000000000000 R12: ffffffff89f76b60
R13: ffffffff89f75ec0 R14: 000000000000033c R15: 0000000000000000
FS:  00007f524eebd700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555569e5708 CR3: 000000004a185000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f3 f3 f3 f3 65 48 8b 	repz repz repz repz mov %gs:0x28,%rax
   7:	04 25 28 00 00 00
   d:	48 89 84 24 a8 02 00 	mov    %rax,0x2a8(%rsp)
  14:	00
  15:	31 c0                	xor    %eax,%eax
  17:	e8 a4 58 10 fe       	callq  0xfe1058c0
  1c:	49 8d bf 90 00 00 00 	lea    0x90(%r15),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	0f 85 0c 18 00 00    	jne    0x1840
  34:	49 8b 87 90 00 00 00 	mov    0x90(%r15),%rax
  3b:	49 8d 7f 10          	lea    0x10(%r15),%rdi
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
