Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093E4DE9EB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiCSSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSSIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:08:47 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BC3F312
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:07:26 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x6-20020a923006000000b002bea39c3974so6028337ile.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9exNoJ5f+whq9B6CnxQDs+sdj6gKU1kieBgg6wdoz3M=;
        b=CnkwKHejcfDeLm1b83IJd5vk/dC8XREadqS90KG9ax0BO8EAP9yxxc02rdAFq7j4CT
         NLzCntrXrONn+trI2kG8FVfWbZZucbsySTxFbEIpb3Dab49HjyVtKuhnT/R4N5gXGfRd
         u6aeMZjTs0Azghs0MPGb7dYijiJvixNeJ0ALRwj//xtp2GVu3Y2z78+EM4MZNHoPxZ8l
         /bLhECWSyWR+xfgS85PDDMHXEB6HhrQrnHZsEv0tQKvUGGI1dZvco+gqmOCjfjH6icYo
         RqGUkN3rfNpkb1f6fsR9W+uhXi2snU2dPpR2Dsu6aifzsVjkSQlfcd9cAEaB1hxpWAAv
         ZGgg==
X-Gm-Message-State: AOAM5339VsrX15+ibWdHlCXLSS5TShtofZbJvpTw+eSaQ2ks/HP904kw
        lQrrjFaUqQpPQ8EU/hVWDyAprgUEHGmRSX906CwNF9HFMo/D
X-Google-Smtp-Source: ABdhPJxIC+h8PCuEZ9w8B8sorg614KxLkifVlrhRjY/pTRBW7BfYt5kvEm78Lg5SSpQlcDLHynXl8tvUp+0w/orfWaZvAcS0lajV
MIME-Version: 1.0
X-Received: by 2002:a92:3f03:0:b0:2c7:ace3:7edf with SMTP id
 m3-20020a923f03000000b002c7ace37edfmr6914773ila.47.1647713245544; Sat, 19 Mar
 2022 11:07:25 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:07:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1470105da9622aa@google.com>
Subject: [syzbot] divide error in dbNextAG
From:   syzbot <syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    09688c0166e7 Linux 5.17-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163e5015700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f75a89c7a0e6bc
dashboard link: https://syzkaller.appspot.com/bug?extid=46f5c25af73eb8330eb6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132c1d61700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3622 Comm: syz-executor.0 Not tainted 5.17.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:dbNextAG+0xfc/0x5f0 fs/jfs/jfs_dmap.c:602
Code: 48 89 c1 48 89 44 24 08 83 e0 07 48 c1 e9 03 0f b6 0c 11 48 89 c2 83 c2 03 38 ca 7c 08 84 c9 0f 85 ca 03 00 00 44 89 f8 31 d2 <41> f7 75 14 49 89 c7 49 8d 45 20 48 89 c2 48 89 44 24 20 48 b8 00
RSP: 0018:ffffc900028d7a40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88801d782800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801f5c3008
RBP: ffff88801d782800 R08: 0000000000000000 R09: ffffc900028d797f
R10: fffff5200051af2f R11: 0000000000000000 R12: ffff88806dede530
R13: ffff88801f5c3000 R14: ffff88806dedf598 R15: 0000000000000000
FS:  00007f05def99700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f05def99718 CR3: 000000001ef61000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 diAlloc+0xa96/0x1730 fs/jfs/jfs_imap.c:1342
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x1c3/0x3b0 fs/namei.c:3933
 do_mkdirat+0x285/0x300 fs/namei.c:3959
 __do_sys_mkdirat fs/namei.c:3974 [inline]
 __se_sys_mkdirat fs/namei.c:3972 [inline]
 __x64_sys_mkdirat+0x115/0x170 fs/namei.c:3972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f05df845049
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f05def99168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f05df958030 RCX: 00007f05df845049
RDX: 0000000000000020 RSI: 0000000020000300 RDI: 0000000000000005
RBP: 00007f05df89f08d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc16fbfa9f R14: 00007f05def99300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbNextAG+0xfc/0x5f0 fs/jfs/jfs_dmap.c:602
Code: 48 89 c1 48 89 44 24 08 83 e0 07 48 c1 e9 03 0f b6 0c 11 48 89 c2 83 c2 03 38 ca 7c 08 84 c9 0f 85 ca 03 00 00 44 89 f8 31 d2 <41> f7 75 14 49 89 c7 49 8d 45 20 48 89 c2 48 89 44 24 20 48 b8 00
RSP: 0018:ffffc900028d7a40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88801d782800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801f5c3008
RBP: ffff88801d782800 R08: 0000000000000000 R09: ffffc900028d797f
R10: fffff5200051af2f R11: 0000000000000000 R12: ffff88806dede530
R13: ffff88801f5c3000 R14: ffff88806dedf598 R15: 0000000000000000
FS:  00007f05def99700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf01138f8 CR3: 000000001ef61000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 c1             	mov    %rax,%rcx
   3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   8:	83 e0 07             	and    $0x7,%eax
   b:	48 c1 e9 03          	shr    $0x3,%rcx
   f:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
  13:	48 89 c2             	mov    %rax,%rdx
  16:	83 c2 03             	add    $0x3,%edx
  19:	38 ca                	cmp    %cl,%dl
  1b:	7c 08                	jl     0x25
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 85 ca 03 00 00    	jne    0x3ef
  25:	44 89 f8             	mov    %r15d,%eax
  28:	31 d2                	xor    %edx,%edx
* 2a:	41 f7 75 14          	divl   0x14(%r13) <-- trapping instruction
  2e:	49 89 c7             	mov    %rax,%r15
  31:	49 8d 45 20          	lea    0x20(%r13),%rax
  35:	48 89 c2             	mov    %rax,%rdx
  38:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
