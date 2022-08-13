Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF63591A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiHMNMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiHMNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:12:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0E26127
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:12:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z9-20020a056e02088900b002e35dba878cso2279585ils.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=VIlo//r0LJftEwzdeLRuWCYomg8j7vgvKsC6IKHpAPs=;
        b=nMaQwfIzGV1L8DLjSHSi/yOmDmgLqe5YobGiY1f7aYAl/yDJMQNczGA2PM6etrqliF
         s1GSmxm1iVr3q1Ba/wJ3IfCmA5K+URrb9cUTduZBABQ7CP9BJcG88msfaHFnALn4dkd9
         UkpkDgn6kHOFRhqkrCmIUaW3Jm76D5zbPDpUIuvrCONPK4NZ+TS2Zfn4lvtQtVT+O3wc
         8pdK6/BwmkQyVU6BfizpyRtyV983cNyp41oJsfcBSJzvW+gkB4yKK6yqn0MQFxRp3UVu
         SloT5uV7UZgVvsOD224NKoa0uP6tthCmTDo/Mog6796Od0BkIrPl8q9UZt8j8ChrXVBB
         GVDQ==
X-Gm-Message-State: ACgBeo0/TC2x85yACWT+uWMxkcSTRlcJIeZaMlgl+0yFfANRdRtlDQSB
        5cwHBjFZ0SbH0WuOHL+xvifauQXdubats8y8a2e9qhxubyXQ
X-Google-Smtp-Source: AA6agR6GtsT0p+RwHDKPWmadUL9DyCtPMX2vz5jGfIJxRCI8OcAOWnrErc+Bq1037n79jugGpsig7UHwubgUmXa9oHCw5dopUhhw
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1843:b0:67d:d75:e503 with SMTP id
 d3-20020a056602184300b0067d0d75e503mr3510203ioi.36.1660396345016; Sat, 13 Aug
 2022 06:12:25 -0700 (PDT)
Date:   Sat, 13 Aug 2022 06:12:25 -0700
In-Reply-To: <00000000000063154a05e382eae9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054c88505e61f265b@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 bitfill_aligned (3)
From:   syzbot <syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        javierm@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=179c3aa5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20bc0b329895d963
dashboard link: https://syzkaller.appspot.com/bug?extid=a168dbeaaa7778273c1b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e0ef4b080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a1183d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffc900043a1000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 12000067 P4D 12000067 PUD 121c9067 PMD 14733a067 PTE 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3633 Comm: syz-executor339 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:memset64 arch/x86/include/asm/string_64.h:49 [inline]
RIP: 0010:memset_l include/linux/string.h:128 [inline]
RIP: 0010:bitfill_aligned+0x1ad/0x270 drivers/video/fbdev/core/sysfillrect.c:53
Code: 08 49 31 ef eb 66 e8 52 38 03 fd 45 89 e6 4c 8b 64 24 10 44 89 f0 31 d2 f7 f3 89 c3 48 8b 6c 24 08 48 89 e8 4c 89 e7 48 89 d9 <f3> 48 ab 31 ff 44 89 ee e8 46 3c 03 fd 4d 85 ed 74 5f 4d 8d 24 dc
RSP: 0018:ffffc90003a6f7e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000ffc RCX: 00000000000001fc
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900043a1000
RBP: 0000000000000000 R08: ffffffff848659ae R09: 0000000000000040
R10: 0000000000000002 R11: ffff888021ffd880 R12: ffffc9000439a000
R13: 0000000000000000 R14: 000000000003ff00 R15: ffffffffffffffff
FS:  0000555556df7300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900043a1000 CR3: 0000000072ba0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sys_fillrect+0x5ce/0x7f0 drivers/video/fbdev/core/sysfillrect.c:281
 drm_fb_helper_sys_fillrect drivers/gpu/drm/drm_fb_helper.c:807 [inline]
 drm_fbdev_fb_fillrect+0x163/0x300 drivers/gpu/drm/drm_fb_helper.c:2322
 bit_clear_margins+0x3f1/0x6e0 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins drivers/video/fbdev/core/fbcon.c:1306 [inline]
 fbcon_do_set_font+0xd7c/0x1330 drivers/video/fbdev/core/fbcon.c:2431
 fbcon_set_font+0xc29/0xf70 drivers/video/fbdev/core/fbcon.c:2519
 con_font_set drivers/tty/vt/vt.c:4666 [inline]
 con_font_op+0xbe8/0x1070 drivers/tty/vt/vt.c:4710
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x172e/0x1d00 drivers/tty/vt/vt_ioctl.c:752
 tty_ioctl+0x874/0xc60 drivers/tty/tty_io.c:2778
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efe5924e239
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffba970648 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007efe5924e239
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000004
RBP: 00007fffba970660 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00007fffba97065c R14: 00007fffba970680 R15: 00007fffba970670
 </TASK>
Modules linked in:
CR2: ffffc900043a1000
---[ end trace 0000000000000000 ]---
RIP: 0010:memset64 arch/x86/include/asm/string_64.h:49 [inline]
RIP: 0010:memset_l include/linux/string.h:128 [inline]
RIP: 0010:bitfill_aligned+0x1ad/0x270 drivers/video/fbdev/core/sysfillrect.c:53
Code: 08 49 31 ef eb 66 e8 52 38 03 fd 45 89 e6 4c 8b 64 24 10 44 89 f0 31 d2 f7 f3 89 c3 48 8b 6c 24 08 48 89 e8 4c 89 e7 48 89 d9 <f3> 48 ab 31 ff 44 89 ee e8 46 3c 03 fd 4d 85 ed 74 5f 4d 8d 24 dc
RSP: 0018:ffffc90003a6f7e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000ffc RCX: 00000000000001fc
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900043a1000
RBP: 0000000000000000 R08: ffffffff848659ae R09: 0000000000000040
R10: 0000000000000002 R11: ffff888021ffd880 R12: ffffc9000439a000
R13: 0000000000000000 R14: 000000000003ff00 R15: ffffffffffffffff
FS:  0000555556df7300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900043a1000 CR3: 0000000072ba0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 49 31             	or     %cl,0x31(%rcx)
   3:	ef                   	out    %eax,(%dx)
   4:	eb 66                	jmp    0x6c
   6:	e8 52 38 03 fd       	callq  0xfd03385d
   b:	45 89 e6             	mov    %r12d,%r14d
   e:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
  13:	44 89 f0             	mov    %r14d,%eax
  16:	31 d2                	xor    %edx,%edx
  18:	f7 f3                	div    %ebx
  1a:	89 c3                	mov    %eax,%ebx
  1c:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
  21:	48 89 e8             	mov    %rbp,%rax
  24:	4c 89 e7             	mov    %r12,%rdi
  27:	48 89 d9             	mov    %rbx,%rcx
* 2a:	f3 48 ab             	rep stos %rax,%es:(%rdi) <-- trapping instruction
  2d:	31 ff                	xor    %edi,%edi
  2f:	44 89 ee             	mov    %r13d,%esi
  32:	e8 46 3c 03 fd       	callq  0xfd033c7d
  37:	4d 85 ed             	test   %r13,%r13
  3a:	74 5f                	je     0x9b
  3c:	4d 8d 24 dc          	lea    (%r12,%rbx,8),%r12

