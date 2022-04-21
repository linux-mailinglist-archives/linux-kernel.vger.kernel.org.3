Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7761509A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386577AbiDUIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiDUIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:20:10 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A83889
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:17:21 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso2808581ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yerC/94J0Sug/4iuxPVAUmoYEq2mrdNBYNdMxDbu4vg=;
        b=rYgVUf0apHFVK/rMnQK22eV123nsVcxlFkstc8oFaYDexuEzjlJEd0OOeEtvF1lyiE
         iKJ3Doh3t7MjHC9xxLSf+eO9CrN2ZeRHt/PWCnfnIXOhyX0g2Txz3PEEbXJfnGxZGpw7
         wpUZMf/0M9+wT46BZkx/ZFuJJyBMCQN76MOkdK0lUtWAXwUKGIzZpKWkqhcrZbarhig/
         n41UMqHJW6De766VFfTTRM/hsw06X36mW/mOS5C10eOVuQ64gHhL/0JTIvQ9MpB36LQ9
         vtlDxA4YHOVXwxdr5f8GqfIBBZIDKwfCETMC346BAbns/uvtLxliSY0AV8ri4OpRukDs
         83Uw==
X-Gm-Message-State: AOAM533TJqs6tnGdhsqkNRyRQlr06II+n/ePZSxUS0joiFp8HkpmPF0K
        6zvdZXRct/+QTLndA5wweg3jZ+KjmdmknwLI5VfiWS8N5bKv
X-Google-Smtp-Source: ABdhPJx0GYuV0M80kNgZm862teSLlR5qJ9bTDszSuYR7ZntsB+C0uXZDxDOxRpdnVm7zmeVEluSzg/uSWQY68AqHnQM693LqApze
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3714:b0:328:8647:3457 with SMTP id
 k20-20020a056638371400b0032886473457mr8950345jav.299.1650529040220; Thu, 21
 Apr 2022 01:17:20 -0700 (PDT)
Date:   Thu, 21 Apr 2022 01:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022487405dd25bd0d@google.com>
Subject: [syzbot] general protection fault in ntfs_update_mftmirr
From:   syzbot <syzbot+c95173762127ad76a824@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b253435746d9 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11588ba2f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cdc9619f45633df
dashboard link: https://syzkaller.appspot.com/bug?extid=c95173762127ad76a824
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175b13c0f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1502f854f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c95173762127ad76a824@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
ntfs3: Unknown parameter 'iochvrset'
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 3589 Comm: syz-executor210 Not tainted 5.18.0-rc3-syzkaller-00016-gb253435746d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ntfs_update_mftmirr+0x51/0x6a0 fs/ntfs3/fsntfs.c:834
Code: 48 c1 e8 03 80 3c 18 00 74 08 4c 89 f7 e8 47 d4 13 ff 49 8b 06 48 89 44 24 18 48 8d 68 18 48 89 e8 48 c1 e8 03 48 89 44 24 40 <80> 3c 18 00 74 08 48 89 ef e8 21 d4 13 ff 48 89 6c 24 10 48 8b 45
RSP: 0018:ffffc90002dffc70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffff888025543a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807e250000
RBP: 0000000000000018 R08: dffffc0000000000 R09: ffff88807e250290
R10: ffffed100fc4a055 R11: 1ffff1100fc4a052 R12: ffff888079a4dc00
R13: dffffc0000000000 R14: ffff88807e250000 R15: dffffc0000000000
FS:  0000555556d79300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffc47539c0 CR3: 000000001cabf000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 put_ntfs+0x1ed/0x2a0 fs/ntfs3/super.c:463
 ntfs_fs_free+0x6a/0xe0 fs/ntfs3/super.c:1363
 put_fs_context+0x119/0x7a0 fs/fs_context.c:469
 do_new_mount+0x2b4/0xad0 fs/namespace.c:3044
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc64612025a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5eefed68 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd5eefedc0 RCX: 00007fc64612025a
RDX: 0000000020001480 RSI: 00000000200014c0 RDI: 00007ffd5eefed80
RBP: 00007ffd5eefed80 R08: 00007ffd5eefedc0 R09: 0000000800000015
R10: 0000000000000008 R11: 0000000000000286 R12: 0000000000000008
R13: 0000000020002a00 R14: 0000000000000004 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_update_mftmirr+0x51/0x6a0 fs/ntfs3/fsntfs.c:834
Code: 48 c1 e8 03 80 3c 18 00 74 08 4c 89 f7 e8 47 d4 13 ff 49 8b 06 48 89 44 24 18 48 8d 68 18 48 89 e8 48 c1 e8 03 48 89 44 24 40 <80> 3c 18 00 74 08 48 89 ef e8 21 d4 13 ff 48 89 6c 24 10 48 8b 45
RSP: 0018:ffffc90002dffc70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffff888025543a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807e250000
RBP: 0000000000000018 R08: dffffc0000000000 R09: ffff88807e250290
R10: ffffed100fc4a055 R11: 1ffff1100fc4a052 R12: ffff888079a4dc00
R13: dffffc0000000000 R14: ffff88807e250000 R15: dffffc0000000000
FS:  0000555556d79300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffc47539c0 CR3: 000000001cabf000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   8:	74 08                	je     0x12
   a:	4c 89 f7             	mov    %r14,%rdi
   d:	e8 47 d4 13 ff       	callq  0xff13d459
  12:	49 8b 06             	mov    (%r14),%rax
  15:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  1a:	48 8d 68 18          	lea    0x18(%rax),%rbp
  1e:	48 89 e8             	mov    %rbp,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 21 d4 13 ff       	callq  0xff13d459
  38:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
