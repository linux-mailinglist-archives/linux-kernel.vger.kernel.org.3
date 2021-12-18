Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B13479A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhLRLRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:17:33 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48790 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhLRLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:17:32 -0500
Received: by mail-io1-f69.google.com with SMTP id g23-20020a6be617000000b005e245747fb4so3270115ioh.15
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 03:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nn4S/hdNFMK38bUgCV7tKgCyvOkQdqxyUF/70R2vv0Q=;
        b=d2Vu2TA7ERlnUgZAIy2++XKWaEzbGSMt6nI03Mt3A2H9TqmYGdGqNGbTv49+wQD4CS
         nTKzDIHVnMRZARNPv9Q66c4wabLGafKrq/Uo8frWkGto6mz2jxm7m6UO3DleJQE6PI1a
         qKZfPhU1GPHz0HnxhpIG6Az5Wbh2pg4tl/KTL0K4o4R6boNm3nIIqg0m4IlKn+o2PeU3
         4jKU7y2WSFCmskt514uwaMY/tKcRM9R5VzmWXReqgjTHcrBIXvUFthubujxGttcN99zp
         ntKhfehyERqROTb05tPzZjsdoAHI5COrnlL5l1zUlAVfYhBxe7c/hsdcg26ivnfPbTh4
         Fz/Q==
X-Gm-Message-State: AOAM533QYOJxA32uEQisB55fL/J4sPBYczUTNPBbfexEl3d8ETvDyZJp
        5wgqSdaGWpC/2MTloBR8Os6/XhXAE9wzKMWOtIvMHq5U1glY
X-Google-Smtp-Source: ABdhPJxnkN/hhHZkSsIS1SQmfGm2nhYF4CMP2ghHGJyTCB0WN0FHzuNlp6PaYckqafM0YFGSvmQTqvXkzsi6Mr0EOXg0k52Cwjl+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:: with SMTP id k9mr3680193ilu.200.1639826252255;
 Sat, 18 Dec 2021 03:17:32 -0800 (PST)
Date:   Sat, 18 Dec 2021 03:17:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004255b405d369cd72@google.com>
Subject: [syzbot] KMSAN: uninit-value in snd_rawmidi_ioctl
From:   syzbot <syzbot+88412ee8811832b00dbe@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org, coding@diwic.se,
        colin.king@intel.com, glider@google.com, joe@perches.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8b936c96768e kmsan: core: remove the accidentally committe..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11791d89b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=88412ee8811832b00dbe
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a7abf9b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172410b9b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88412ee8811832b00dbe@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in snd_rawmidi_ioctl+0xf1e/0x1330 sound/core/rawmidi.c:887
 snd_rawmidi_ioctl+0xf1e/0x1330 sound/core/rawmidi.c:887
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0x2df/0x4a0 fs/ioctl.c:860
 __x64_sys_ioctl+0xd8/0x110 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc_trace+0xaca/0x1140 mm/slub.c:3276
 kmalloc include/linux/slab.h:590 [inline]
 snd_rawmidi_open+0x70d/0x1390 sound/core/rawmidi.c:445
 snd_open+0x702/0x890 sound/core/sound.c:169
 chrdev_open+0xbc9/0xd80 fs/char_dev.c:414
 do_dentry_open+0x1128/0x1bf0 fs/open.c:822
 vfs_open+0xaf/0xe0 fs/open.c:957
 do_open fs/namei.c:3426 [inline]
 path_openat+0x52f1/0x5dd0 fs/namei.c:3559
 do_filp_open+0x306/0x760 fs/namei.c:3586
 do_sys_openat2+0x263/0x8f0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_openat fs/open.c:1244 [inline]
 __se_sys_openat fs/open.c:1239 [inline]
 __x64_sys_openat+0x35f/0x3c0 fs/open.c:1239
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 1 PID: 6368 Comm: syz-executor467 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
