Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535E492E25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbiARTHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:07:32 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:40704 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245012AbiARTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:07:26 -0500
Received: by mail-il1-f200.google.com with SMTP id k2-20020a056e02156200b002b6978faaceso60149ilu.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CLITfLGKNy0WpV8lGPNGoAM0iZjzgggDewCmlPMOS8w=;
        b=jJbuzJbz8ki55bmHxE+QA3rj623HXXndnefoTvikIRz1y7zjghxt6eVMICQsrlH/ej
         wKGBBJz4e6T3I87D2bL7rCWESskBpWgFNSz0VtCSSjGaJ/G0qc157D3hasK85wzXYHc9
         nGmJjb8z8s7vO9dRK6m4A3x+YSumqd+x6mt34IlhUEx3r3VHHhO6Ax0E4GPPoipt8hx1
         Zf+8iv/qAkAAaGZnjzI2G8lUyGkLpSeZoovsbesC0hat4N0QSASYP+GrcT04KnflLNTW
         DCL9h961PlBinwzvj2tvz7hAkdI72Ne7vGbMQ1rz1ut5Jke8Nopwn6pV2viZ8xoz4wZ3
         sUpQ==
X-Gm-Message-State: AOAM530DyvHKrKEeR72vwD8ZO3AQuOR0KFjoR/WPfUF0a+GVcQKjPkFO
        wEsDSqQox9VmEVW5rjopw6Bk7Bdj3SJEZz7/Oa3Xejk5MJ5r
X-Google-Smtp-Source: ABdhPJxFQf0G6osEr4fRO4G7PmfdZYLvllUJMV73YDlSUzPckqzzoc2aXDQL9eH7y5cIASu/lVZt2CdU1fHm+tqX3k3DNqeDULM5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4b:: with SMTP id d11mr7393110ilg.253.1642532845880;
 Tue, 18 Jan 2022 11:07:25 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:07:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf8aff05d5dffa62@google.com>
Subject: [syzbot] KMSAN: kernel-infoleak in v4l2_compat_put_array_args
From:   syzbot <syzbot+ff18193ff05f3f87f226@syzkaller.appspotmail.com>
To:     arnd@arndb.de, glider@google.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fa3879a274df Input: libps2: mark data received in __ps2_co..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=128abbdfb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=ff18193ff05f3f87f226
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff18193ff05f3f87f226@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:209 [inline]
 v4l2_compat_put_array_args+0x155a/0x1670 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1152
 video_usercopy+0x2332/0x2870 drivers/media/v4l2-core/v4l2-ioctl.c:3340
 video_ioctl2+0x9f/0xb0 drivers/media/v4l2-core/v4l2-ioctl.c:3370
 v4l2_ioctl+0x263/0x290 drivers/media/v4l2-core/v4l2-dev.c:364
 v4l2_compat_ioctl32+0x384/0x410 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1251
 __do_compat_sys_ioctl fs/ioctl.c:972 [inline]
 __se_compat_sys_ioctl+0x876/0x1150 fs/ioctl.c:914
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:914
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 __kmalloc_node+0xe03/0x14f0 mm/slub.c:4485
 kmalloc_node include/linux/slab.h:613 [inline]
 kvmalloc_node+0x228/0x450 mm/util.c:587
 kvmalloc include/linux/slab.h:741 [inline]
 video_usercopy+0x1660/0x2870 drivers/media/v4l2-core/v4l2-ioctl.c:3304
 video_ioctl2+0x9f/0xb0 drivers/media/v4l2-core/v4l2-ioctl.c:3370
 v4l2_ioctl+0x263/0x290 drivers/media/v4l2-core/v4l2-dev.c:364
 v4l2_compat_ioctl32+0x384/0x410 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1251
 __do_compat_sys_ioctl fs/ioctl.c:972 [inline]
 __se_compat_sys_ioctl+0x876/0x1150 fs/ioctl.c:914
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:914
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Bytes 0-7 of 16 are uninitialized
Memory access of size 16 starts at ffff88808d250578
Data copied to user address 0000000020000214

CPU: 0 PID: 12831 Comm: syz-executor.1 Tainted: G S                5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
