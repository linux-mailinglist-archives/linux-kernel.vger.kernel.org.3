Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD31A47894B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhLQK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:57:19 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56126 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhLQK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:57:18 -0500
Received: by mail-il1-f200.google.com with SMTP id p1-20020a92d281000000b002b2050d9ae3so1154540ilp.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 02:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=H5tRVXFHL86e/X8LIqsE9mwoZI33iC6l1zVxHsxiwUM=;
        b=vKyt0EXkcf8/1hrUHqZwyoMASfb0zjgUgrx2ShhFbDjQHKHlAYaB7WlXnLUfiQuFPv
         kFgW5Bi3//cHOOAyq2b7QO6QUVFvIP9+BTIm4lPccThBscZ4hpqrszldzF3M5N104tYC
         0MmgvA8c32n9PZ2Ub1D6mfjeMbcSbEMNplDDHQI3yzK3leWa5nDnTYastg4Szevknjyo
         n7GubzQlm5SFBoLoKk1cV7MxyiPd58cDXMMdKNxxhqU4Ix5WX+mbY3lLQG6J04BDOqSA
         8FV7b9JSS39M5sJ/WjVs2vrtbCNn7Ju0MOuEOS88z+Lufj1NgALE+n9z5A4HHLGEglK7
         2a9g==
X-Gm-Message-State: AOAM530O/9o83WqwJG4mjv+niOpZ+1DSPnhKVb8xGJ1kgnjy9lmGCTdo
        x9EdF+15a3KcGi/HOmgVGfZYhM2wLb867j+US2jzTW9Jf5ap
X-Google-Smtp-Source: ABdhPJz8NtBXkmSZ7nw4A6WWligqbzkIes2Bt9wzljvVlTsQHtWDtFgTXKW177mUUvsc3wkk6X2qhGcbwL4YAnrHADv8BXpaClUz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1648:: with SMTP id a8mr1329401jat.92.1639738638312;
 Fri, 17 Dec 2021 02:57:18 -0800 (PST)
Date:   Fri, 17 Dec 2021 02:57:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fa9e405d35567b3@google.com>
Subject: [syzbot] kmsan boot error: KMSAN: uninit-value in genius_detect
From:   syzbot <syzbot+ea4fcd3ec1e6f90262bb@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, glider@google.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b0a8b5053e8b kmsan: core: add dependency on DEBUG_KERNEL
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10a5adcdb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46a956fc7a887c60
dashboard link: https://syzkaller.appspot.com/bug?extid=ea4fcd3ec1e6f90262bb
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea4fcd3ec1e6f90262bb@syzkaller.appspotmail.com

input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
=====================================================
BUG: KMSAN: uninit-value in genius_detect+0x4ec/0x6f0 drivers/input/mouse/psmouse-base.c:568
 genius_detect+0x4ec/0x6f0 drivers/input/mouse/psmouse-base.c:568
 psmouse_do_detect drivers/input/mouse/psmouse-base.c:1046 [inline]
 psmouse_try_protocol drivers/input/mouse/psmouse-base.c:1060 [inline]
 psmouse_extensions+0x1964/0x1b60 drivers/input/mouse/psmouse-base.c:1216
 psmouse_switch_protocol+0x184/0xbb0 drivers/input/mouse/psmouse-base.c:1579
 psmouse_connect+0x14cc/0x2260 drivers/input/mouse/psmouse-base.c:1669
 serio_connect_driver drivers/input/serio/serio.c:47 [inline]
 serio_driver_probe+0xc7/0x130 drivers/input/serio/serio.c:778
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __driver_attach+0x6a6/0x1350 drivers/base/dd.c:1140
 bus_for_each_dev+0x20e/0x340 drivers/base/bus.c:301
 driver_attach+0x89/0xb0 drivers/base/dd.c:1157
 serio_attach_driver drivers/input/serio/serio.c:807 [inline]
 serio_handle_event+0x11fb/0x2760 drivers/input/serio/serio.c:227
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 __ps2_command+0x23fe/0x25b0 drivers/input/serio/libps2.c:299
 ps2_command+0x124/0x210 drivers/input/serio/libps2.c:332
 genius_detect+0x2f9/0x6f0 drivers/input/mouse/psmouse-base.c:564
 psmouse_do_detect drivers/input/mouse/psmouse-base.c:1046 [inline]
 psmouse_try_protocol drivers/input/mouse/psmouse-base.c:1060 [inline]
 psmouse_extensions+0x1964/0x1b60 drivers/input/mouse/psmouse-base.c:1216
 psmouse_switch_protocol+0x184/0xbb0 drivers/input/mouse/psmouse-base.c:1579
 psmouse_connect+0x14cc/0x2260 drivers/input/mouse/psmouse-base.c:1669
 serio_connect_driver drivers/input/serio/serio.c:47 [inline]
 serio_driver_probe+0xc7/0x130 drivers/input/serio/serio.c:778
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __driver_attach+0x6a6/0x1350 drivers/base/dd.c:1140
 bus_for_each_dev+0x20e/0x340 drivers/base/bus.c:301
 driver_attach+0x89/0xb0 drivers/base/dd.c:1157
 serio_attach_driver drivers/input/serio/serio.c:807 [inline]
 serio_handle_event+0x11fb/0x2760 drivers/input/serio/serio.c:227
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 __ps2_command+0xa33/0x25b0 drivers/input/serio/libps2.c:253
 ps2_command+0x124/0x210 drivers/input/serio/libps2.c:332
 genius_detect+0x2f9/0x6f0 drivers/input/mouse/psmouse-base.c:564
 psmouse_do_detect drivers/input/mouse/psmouse-base.c:1046 [inline]
 psmouse_try_protocol drivers/input/mouse/psmouse-base.c:1060 [inline]
 psmouse_extensions+0x1964/0x1b60 drivers/input/mouse/psmouse-base.c:1216
 psmouse_switch_protocol+0x184/0xbb0 drivers/input/mouse/psmouse-base.c:1579
 psmouse_connect+0x14cc/0x2260 drivers/input/mouse/psmouse-base.c:1669
 serio_connect_driver drivers/input/serio/serio.c:47 [inline]
 serio_driver_probe+0xc7/0x130 drivers/input/serio/serio.c:778
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __driver_attach+0x6a6/0x1350 drivers/base/dd.c:1140
 bus_for_each_dev+0x20e/0x340 drivers/base/bus.c:301
 driver_attach+0x89/0xb0 drivers/base/dd.c:1157
 serio_attach_driver drivers/input/serio/serio.c:807 [inline]
 serio_handle_event+0x11fb/0x2760 drivers/input/serio/serio.c:227
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Local variable param created at:
 genius_detect+0x6b/0x6f0 drivers/input/mouse/psmouse-base.c:548
 psmouse_do_detect drivers/input/mouse/psmouse-base.c:1046 [inline]
 psmouse_try_protocol drivers/input/mouse/psmouse-base.c:1060 [inline]
 psmouse_extensions+0x1964/0x1b60 drivers/input/mouse/psmouse-base.c:1216

CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_long serio_handle_event
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
