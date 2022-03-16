Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC94DB835
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357782AbiCPSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356103AbiCPSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:52:41 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EDE6BDE0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:51:26 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x6-20020a923006000000b002bea39c3974so1757593ile.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9BInTHTUyv8pUWV/QT2xDw1J7W1pxyFN1eHiSsUR3wc=;
        b=LXWOixdlaILDbJL98qyYaBK6t0MNbC2KwfFKL4dqTlejN0TGTh3Ks3xRiLgm4fon/g
         VZYR2c8lf7Uyf6jv0EJi58Mjw8IxWcDOCjBhJIx2rqSEl6JXuA1c4xtfNCXeoRD8sqM0
         Vc0eiEMyAk8m9DtsaKldHicTeZfuEOJ4/du4kNZBSTq0O//sTxL78LbtSd+ohv6fDf/j
         OwZ1wvqh1GcwlKetoSiN9OOCJIrb9BQ6B/e8Ej/gk2G7Fi36I4YXzDxPa80e/vZqJ0Qk
         1dr/FAwo7W7uGDM0pkK2r48KfLdzH8ib5F42O7RCuYFCe0ykJbw7DzTeiVFIGUrqSqlO
         V4jg==
X-Gm-Message-State: AOAM530tHMp7RdDDTbD2wJeo7uulWYqT7jCECRGHBumk6c9TIkf1/W2Q
        lRh+u6IKc2GwG6poet7/wzeg697fXRhU1Acv+wWEQcfFIvkb
X-Google-Smtp-Source: ABdhPJyv4vim6IFuInxOD5F0o+3aHFZSEZV+cefh9fq0DAjbQkPDdG5PfV0FoRsFAPQjY52EGpPyAENTGBUKioFGrADJ4oxvaDsj
MIME-Version: 1.0
X-Received: by 2002:a5e:8d15:0:b0:645:c856:e84a with SMTP id
 m21-20020a5e8d15000000b00645c856e84amr665007ioj.84.1647456685501; Wed, 16 Mar
 2022 11:51:25 -0700 (PDT)
Date:   Wed, 16 Mar 2022 11:51:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085b1b305da5a66f3@google.com>
Subject: [syzbot] WARNING: kmalloc bug in snd_pcm_plugin_alloc (2)
From:   syzbot <syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        torvalds@linux-foundation.org, w@1wt.eu
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

Hello,

syzbot found the following issue on:

HEAD commit:    68453767131a ARM: Spectre-BHB: provide empty stub for non-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ddd329700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=72732c532ac1454eeee9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13636d79700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128fcd03700000

The issue was bisected to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134eb7d1700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ceb7d1700000
console output: https://syzkaller.appspot.com/x/log.txt?x=174eb7d1700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3761 at mm/util.c:591 kvmalloc_node+0x121/0x130 mm/util.c:591
Modules linked in:
CPU: 0 PID: 3761 Comm: syz-executor165 Not tainted 5.17.0-rc7-syzkaller-00227-g68453767131a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvmalloc_node+0x121/0x130 mm/util.c:591
Code: eb 8e 45 31 e4 e9 49 ff ff ff e8 fa 91 d0 ff 41 81 e5 00 20 00 00 31 ff 44 89 ee e8 69 95 d0 ff 45 85 ed 75 dd e8 df 91 d0 ff <0f> 0b e9 22 ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 c6
RSP: 0018:ffffc9000282fb38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801c2d4d00 RCX: 0000000000000000
RDX: ffff88806c235700 RSI: ffffffff81a82e51 RDI: 0000000000000003
RBP: 00000000c0c0c100 R08: 0000000000000000 R09: 00000000ffffffff
R10: ffffffff81a82e47 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff88801c2d4d14
FS:  00007f4196580700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffee56e9938 CR3: 000000006d5c7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvmalloc include/linux/slab.h:731 [inline]
 kvzalloc include/linux/slab.h:739 [inline]
 snd_pcm_plugin_alloc+0x570/0x770 sound/core/oss/pcm_plugin.c:71
 snd_pcm_plug_alloc+0x20d/0x310 sound/core/oss/pcm_plugin.c:118
 snd_pcm_oss_change_params_locked+0x19db/0x3bf0 sound/core/oss/pcm_oss.c:1041
 snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1104 [inline]
 snd_pcm_oss_get_active_substream+0x164/0x1c0 sound/core/oss/pcm_oss.c:1121
 snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1778 [inline]
 snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1770 [inline]
 snd_pcm_oss_ioctl+0x144f/0x3430 sound/core/oss/pcm_oss.c:2632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f41965cf1f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f41965802f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f41966584a8 RCX: 00007f41965cf1f9
RDX: 0000000020000140 RSI: 00000000c0045002 RDI: 0000000000000003
RBP: 00007f41966584a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f41966584ac
R13: 00007f4196625088 R14: 7364612f7665642f R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
