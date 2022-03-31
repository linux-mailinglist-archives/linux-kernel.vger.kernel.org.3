Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0594EDF23
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiCaQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiCaQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:55:20 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5AF22508
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:53:32 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id u15-20020a92da8f000000b002c863d2f21dso150446iln.15
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=myjq5HqZ3VwB7lPsf5VdNVpLvoGDwrCfTsCnmkMn8pE=;
        b=edJVdhOSI9SldD66iToE2MPxnDSkKPWUuEzevOxpN7SHSCWQsZQFpwYJ5wSB8Snowa
         N5txpn11rarOPQ4YUKKtQtcXPBcXv1p+oyy2ej7TYE0b9tpTVlYDJAgbmSZAX9Q5+rnb
         B+NFjQRgTnKfZAV5wNPtGUD4z1HqV/sbhoZisXW0i25gz2eZPUUvg+rJ/1FDy6fbi7Oo
         Gxle4mxOrq5QflH/KaOU8n5dYz8quhytKod4M10IlAx1lzRn28p8aRGAbuXEwxUWUJNT
         dFwgDgBUXhWT1TPAcW8DypCjii+PtrRuybRcXHE0/FPicoSRw/B1HQLSO4nXp6UN+wMs
         bhqg==
X-Gm-Message-State: AOAM532U/CJ0wU9DJLaicrTuRj0BN9LHKb10ccaMhIFxquANtdi2437y
        F9ydAaUOZ2NQWpLDeuIKkM4Wbtljkdg2x+mRe/ljih/BwZyC
X-Google-Smtp-Source: ABdhPJxTphHr8NeWygZmoTfNcMBe4+wyK+Y7TPvFzrDsAn6+uTqT3atD/2qfcOmLuk5HnRLBJHqi9xiLA1T1lGqQQ4DVH2oBNwez
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:2c8:a1a:ab98 with SMTP id
 n13-20020a056e02148d00b002c80a1aab98mr14365455ilk.194.1648745611950; Thu, 31
 Mar 2022 09:53:31 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:53:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008681f305db868044@google.com>
Subject: [syzbot] general protection fault in bio_free
From:   syzbot <syzbot+51175d2754e4b4c04d6d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    fdcbcd1348f4 Add linux-next specific files for 20220331
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1583bdb9700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=366ab475940a4177
dashboard link: https://syzkaller.appspot.com/bug?extid=51175d2754e4b4c04d6d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51175d2754e4b4c04d6d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 3906 Comm: syz-executor.2 Not tainted 5.17.0-next-20220331-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:bio_free+0xc3/0x120 block/bio.c:233
Code: 6e 48 8b 73 78 48 8d bd d0 00 00 00 e8 46 fe ff ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc ff df 48 8d 75 18 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 04 3c 03 7e 20 8b 45 08 48 83 c4 08 48 29 c3
RSP: 0018:ffffc9000528fac0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88807c8c5c00 RCX: ffffc9000c212000
RDX: 0000000000000001 RSI: 0000000000000018 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83d576a5 R11: 0000000000000004 R12: 0000000000000060
R13: 0000000000000060 R14: 0000000000001000 R15: 0000000000000060
FS:  00007f068de1f700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555631d848 CR3: 0000000077fb2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bio_put+0x20e/0x3b0 block/bio.c:754
 squashfs_read_data+0x2ce/0xed0 fs/squashfs/block.c:221
 squashfs_read_table+0x184/0x1f0 fs/squashfs/cache.c:432
 squashfs_fill_super+0x337/0x2690 fs/squashfs/super.c:184
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f068cc8a57a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f068de1ef88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f068cc8a57a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f068de1efe0
RBP: 00007f068de1f020 R08: 00007f068de1f020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f068de1efe0 R15: 0000000020000140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bio_free+0xc3/0x120 block/bio.c:233
Code: 6e 48 8b 73 78 48 8d bd d0 00 00 00 e8 46 fe ff ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc ff df 48 8d 75 18 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 04 3c 03 7e 20 8b 45 08 48 83 c4 08 48 29 c3
RSP: 0018:ffffc9000528fac0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88807c8c5c00 RCX: ffffc9000c212000
RDX: 0000000000000001 RSI: 0000000000000018 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83d576a5 R11: 0000000000000004 R12: 0000000000000060
R13: 0000000000000060 R14: 0000000000001000 R15: 0000000000000060
FS:  00007f068de1f700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557421b87a30 CR3: 0000000077fb2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	6e                   	outsb  %ds:(%rsi),(%dx)
   1:	48 8b 73 78          	mov    0x78(%rbx),%rsi
   5:	48 8d bd d0 00 00 00 	lea    0xd0(%rbp),%rdi
   c:	e8 46 fe ff ff       	callq  0xfffffe57
  11:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 75 18          	lea    0x18(%rbp),%rsi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 04                	je     0x36
  32:	3c 03                	cmp    $0x3,%al
  34:	7e 20                	jle    0x56
  36:	8b 45 08             	mov    0x8(%rbp),%eax
  39:	48 83 c4 08          	add    $0x8,%rsp
  3d:	48 29 c3             	sub    %rax,%rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
