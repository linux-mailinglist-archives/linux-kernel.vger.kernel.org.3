Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE84E2663
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347371AbiCUMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347375AbiCUMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:30:48 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91F193D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:29:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id f7-20020a056602088700b00645ebbe277cso10348766ioz.22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vTIFyeipy8299JkenkQsMEvbWMjLrEKUJ698m5s7Ixw=;
        b=bkSkF8ELEP6qSUUzMuotBxbp+smeI+XwuEJRlilIJbCOTXYgHSSgyBHUIvGA+QNSAM
         MDF0/sImAlkVRHpiuZTktvUCVrqylM4GGfx+yyzLFPMnIByAW8w4LFK6o6oFHhARGfHl
         XDIAwTAXnb0pkHAkGCx8HFXJr/9OvCzzSzQAPl/iFbbKI28THaLnGhnnFmYHxVe0lZAB
         3zvP1pm+Dbqfq3ImDAVjm90bkHhGjoBVGQFNxMAL6ivvVf55z7x/AVyKlvfycpgvJ4Ob
         H4YspGtSzN/yXQRmiNyslk4MoRLAwV3N+WdnP80XB8HTAWU82/wQaFGDaFSctB7G8HSJ
         4mMQ==
X-Gm-Message-State: AOAM531iAuZPHST6K3zzezXLPPy2IUWzHEgaB87vjeGN2mFUIPcxY39J
        xktGqIF/z3tUd5oo7Xcq3N8bCpph8dfoD53LBozukgeun98O
X-Google-Smtp-Source: ABdhPJyGQV1nWFvBdGlKSd84uZl6qmLxq1XjoadsQJ+1l/3/66y5d06sC3b9hxCmUvDU9u0BQLZsJhHyvSZoVX+UTqWiQp03pXhc
MIME-Version: 1.0
X-Received: by 2002:a02:cb0e:0:b0:321:34d7:a47f with SMTP id
 j14-20020a02cb0e000000b0032134d7a47fmr3718864jap.50.1647865762019; Mon, 21
 Mar 2022 05:29:22 -0700 (PDT)
Date:   Mon, 21 Mar 2022 05:29:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061fc5805dab9a5ef@google.com>
Subject: [syzbot] general protection fault in xas_create_range
From:   syzbot <syzbot+0d2b0bf32ca5cfd09f2e@syzkaller.appspotmail.com>
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

HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146069d9700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f75a89c7a0e6bc
dashboard link: https://syzkaller.appspot.com/bug?extid=0d2b0bf32ca5cfd09f2e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d2b0bf32ca5cfd09f2e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 32 Comm: khugepaged Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:xa_parent_locked include/linux/xarray.h:1207 [inline]
RIP: 0010:xas_create_range+0x2d9/0x6e0 lib/xarray.c:725
Code: 89 ee 49 83 ed 40 49 c1 ee 03 4c 89 6d 08 4c 8d 6d 12 4d 01 e6 e9 93 00 00 00 e8 d2 0f 72 fd 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 fb 02 00 00 48 8b 04 24 4c 8b 7b 08 80 38 00
RSP: 0018:ffffc90001097a48 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880139de240 RSI: ffffffff8405e5be RDI: 0000000000000008
RBP: ffffc90001097bb0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8405e679 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90001097bc2 R14: fffff52000212f76 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe25571c98 CR3: 0000000079206000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 collapse_file+0x2d3/0x3c40 mm/khugepaged.c:1678
 khugepaged_scan_file mm/khugepaged.c:2073 [inline]
 khugepaged_scan_mm_slot mm/khugepaged.c:2168 [inline]
 khugepaged_do_scan mm/khugepaged.c:2252 [inline]
 khugepaged+0x53c7/0x6c00 mm/khugepaged.c:2297
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:xa_parent_locked include/linux/xarray.h:1207 [inline]
RIP: 0010:xas_create_range+0x2d9/0x6e0 lib/xarray.c:725
Code: 89 ee 49 83 ed 40 49 c1 ee 03 4c 89 6d 08 4c 8d 6d 12 4d 01 e6 e9 93 00 00 00 e8 d2 0f 72 fd 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 fb 02 00 00 48 8b 04 24 4c 8b 7b 08 80 38 00
RSP: 0018:ffffc90001097a48 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880139de240 RSI: ffffffff8405e5be RDI: 0000000000000008
RBP: ffffc90001097bb0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8405e679 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90001097bc2 R14: fffff52000212f76 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe25571c98 CR3: 0000000079206000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 ee                	mov    %ebp,%esi
   2:	49 83 ed 40          	sub    $0x40,%r13
   6:	49 c1 ee 03          	shr    $0x3,%r14
   a:	4c 89 6d 08          	mov    %r13,0x8(%rbp)
   e:	4c 8d 6d 12          	lea    0x12(%rbp),%r13
  12:	4d 01 e6             	add    %r12,%r14
  15:	e9 93 00 00 00       	jmpq   0xad
  1a:	e8 d2 0f 72 fd       	callq  0xfd720ff1
  1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 fb 02 00 00    	jne    0x330
  35:	48 8b 04 24          	mov    (%rsp),%rax
  39:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
  3d:	80 38 00             	cmpb   $0x0,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
