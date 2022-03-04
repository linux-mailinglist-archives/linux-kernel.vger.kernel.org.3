Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3A4CCB8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiCDCJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiCDCJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:09:01 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6339CD5ED
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:08:14 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id k5-20020a926f05000000b002be190db91cso4638156ilc.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 18:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=95VbFDJzsKv3uvAn9miln9nUKSkzEGV+a/6w24y3yBg=;
        b=3w2QUe31u1RqZrGDIo/8siThbjzcjvw/L3HB3c4IGHSGcCWsdvTcbs3l27lgyXurr4
         /u113sWUb7iDpwrCsmcPrNeRaav9GDMjL410/BlQfENr5o2E9M3G55yXNPiNXS8Aswn7
         iVYz9MvkkRFb4y9HSW1gbZ3PI7Uq6JIbUrc2YqB1oPRdu/pfIjblpkGVG+KQA75y4NDx
         yHZzEDK3GCxDh5imYItT2Qz84fud7QpVPAi797iwx4bQhOLSLyl2jtMsif4VhKCV1HjE
         hx+nDBRBvLvlsLmJdE9rkDigUKTZ+X+88Jejs7G4dNuZOrJMNXYKqyeU+e9RIYQO3OMn
         kZZw==
X-Gm-Message-State: AOAM532wMXjxOuoM/6uBsMQfK/TP2aXrAwdgH+h98xfH83RB2TMrRgcn
        xJD1Gx14t4xB3th8Y9TXm7D172A9Q5idndclQ1CKXTlLDXwq
X-Google-Smtp-Source: ABdhPJwStG6MQqrcD0Qmu92G322j6VJ0DZlfyNXTwb5g8I2IyTqQ/6CShOxFfqPWLCh5UcWypnYIBfEJz3cisKlT3SYfRUyiF3Pz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a7:b0:30f:5f87:1fb3 with SMTP id
 t39-20020a05663834a700b0030f5f871fb3mr32351845jal.219.1646359694199; Thu, 03
 Mar 2022 18:08:14 -0800 (PST)
Date:   Thu, 03 Mar 2022 18:08:14 -0800
In-Reply-To: <20220304014317.2373-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bece8f05d95afc28@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in btrfs_scan_one_device (2)
From:   syzbot <syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, dsterba@suse.com, hdanton@sina.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in invalidate_bdev

general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 4000 Comm: syz-executor143 Not tainted 5.17.0-rc5-syzkaller-00306-g2293be58d6a1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:invalidate_bdev+0x1f/0xd0 block/bdev.c:83
Code: fe 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 fb e8 46 02 b2 fd 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90000e07840 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff83c5df9a RDI: 0000000000000030
RBP: ffff888026948000 R08: 0000000000000000 R09: ffffffff8b814683
R10: fffffbfff17028d0 R11: 0000000000000001 R12: ffff88802b5095c0
R13: 0000000000000001 R14: 0000000000000001 R15: ffff88801fb54000
FS:  00007fc526ad8700(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005614541cd000 CR3: 0000000022cb3000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 open_ctree+0xacf/0x4817 fs/btrfs/disk-io.c:3389
 btrfs_fill_super fs/btrfs/super.c:1358 [inline]
 btrfs_mount_root.cold+0x15/0x1a2 fs/btrfs/super.c:1726
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 fc_mount fs/namespace.c:1030 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1060
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1047
 btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1788
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3024 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3354
 do_mount fs/namespace.c:3367 [inline]
 __do_sys_mount fs/namespace.c:3575 [inline]
 __se_sys_mount fs/namespace.c:3552 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3552
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc526b2c2a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc526ad82f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc526bb13e0 RCX: 00007fc526b2c2a9
RDX: 0000000020000140 RSI: 0000000020000100 RDI: 0000000020000080
RBP: 0030656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007fc526b7d478
R13: 00007fc526b7d1f0 R14: 00007fc526b7d0a8 R15: 00007fc526bb13e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:invalidate_bdev+0x1f/0xd0 block/bdev.c:83
Code: fe 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 fb e8 46 02 b2 fd 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90000e07840 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff83c5df9a RDI: 0000000000000030
RBP: ffff888026948000 R08: 0000000000000000 R09: ffffffff8b814683
R10: fffffbfff17028d0 R11: 0000000000000001 R12: ffff88802b5095c0
R13: 0000000000000001 R14: 0000000000000001 R15: ffff88801fb54000
FS:  00007fc526ad8700(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005614541cd000 CR3: 0000000022cb3000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   7:	00 00 00
   a:	55                   	push   %rbp
   b:	53                   	push   %rbx
   c:	48 89 fb             	mov    %rdi,%rbx
   f:	e8 46 02 b2 fd       	callq  0xfdb2025a
  14:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 93 00 00 00    	jne    0xc6
  33:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3a:	fc ff df
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b


Tested on:

commit:         2293be58 Merge tag 'trace-v5.17-rc4' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13d047e1700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28851401b410e5
dashboard link: https://syzkaller.appspot.com/bug?extid=82650a4e0ed38f218363
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133011f1700000

