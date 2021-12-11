Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450344711A6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhLKFSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:18:00 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49735 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhLKFR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:17:59 -0500
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso1337150iov.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 21:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Q80U4B8plOEfp5j933bsuFW088HBWQw+hDfRUFRW33c=;
        b=EQiZG7+GrkPFFhDxCQcQn+OBgCstRb00kCJTqxoiS1BrKIhDSg0DqDrTNsULNY6NLY
         vTzfrWFyMINeEw/xhm/ZvktpB1Ej1uJPYjbcZdqAHPfHxL0rXsO9czFOZBRf+m8Fuvmd
         RHwHNINfkXMG5tCMQlmV+rlcAjz7M1u+5ezgNIxNeGUSXsUB6Pog3ytT/vSSeIxZruw9
         U+cjJuo6pl8CumACuWUnOG7jt7xxOwj8O4iwYILReqdl8BbHpw/0V8dY+Mg5PoKT+P3N
         USv5jfozdka/I1qdXfooNFRdsTRamDFd3B8f8h17y5ocZztaiekZWStKn+ys2UJfpjm4
         Xakw==
X-Gm-Message-State: AOAM532qN4iZ0zeFxi0U30Id33wb51UfwddxQtzwULpAc5xUkxxiklHn
        0T+g99wW4tXUMJO5r7yK35EMyeR87M0CJgm3fbST8DTpciTL
X-Google-Smtp-Source: ABdhPJx52AENo9wDz7rzSH+eqiT/vH+X/TrXEqnQ8klF1g30IwIwbZElh+J+6rsNuiWB1bPMr/KWLgYdGGmMeFdBaaNqqfOpr8FN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:: with SMTP id u11mr21544334ilv.225.1639199663351;
 Fri, 10 Dec 2021 21:14:23 -0800 (PST)
Date:   Fri, 10 Dec 2021 21:14:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a66ecf05d2d7e9dc@google.com>
Subject: [syzbot] WARNING in dvb_media_device_free
From:   syzbot <syzbot+353b9bb3bcc881d85a46@syzkaller.appspotmail.com>
To:     laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d598c3c46ea6 Merge 5.16-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=114b5f3db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6df5f09a0b9c823
dashboard link: https://syzkaller.appspot.com/bug?extid=353b9bb3bcc881d85a46
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+353b9bb3bcc881d85a46@syzkaller.appspotmail.com

dvb-usb: could not initialize remote control.
dvb-usb: PCTV 2002e SE successfully initialized and connected.
usb 2-1: USB disconnect, device number 3
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 4005 at kernel/locking/mutex.c:586 __mutex_lock_common kernel/locking/mutex.c:586 [inline]
WARNING: CPU: 1 PID: 4005 at kernel/locking/mutex.c:586 __mutex_lock+0x9ec/0x12f0 kernel/locking/mutex.c:740
Modules linked in:
CPU: 1 PID: 4005 Comm: kworker/1:3 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:586 [inline]
RIP: 0010:__mutex_lock+0x9ec/0x12f0 kernel/locking/mutex.c:740
Code: 08 84 d2 0f 85 19 08 00 00 8b 05 67 e0 e6 02 85 c0 0f 85 27 f7 ff ff 48 c7 c6 20 80 27 86 48 c7 c7 a0 7e 27 86 e8 8e 27 d2 ff <0f> 0b e9 0d f7 ff ff 48 8b 44 24 40 48 8d b8 60 08 00 00 48 89 f8
RSP: 0018:ffffc9000126f3f0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812bb188 RDI: fffff5200024de70
RBP: ffff88811c882a54 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff812b4f2e R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000280 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563096d39f98 CR3: 000000012cc6f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 media_device_unregister_entity+0x41/0x70 drivers/media/mc/mc-device.c:688
 dvb_media_device_free+0x1d5/0x680 drivers/media/dvb-core/dvbdev.c:226
 dvb_remove_device.part.0+0x9c/0x260 drivers/media/dvb-core/dvbdev.c:568
 dvb_remove_device drivers/media/dvb-core/dvbdev.c:561 [inline]
 dvb_unregister_device+0x1b/0x60 drivers/media/dvb-core/dvbdev.c:590
 dvb_dmxdev_release+0x1c9/0x630 drivers/media/dvb-core/dmxdev.c:1460
 dvb_usb_adapter_dvb_exit+0x93/0x230 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:224
 dvb_usb_adapter_exit drivers/media/usb/dvb-usb/dvb-usb-init.c:126 [inline]
 dvb_usb_exit drivers/media/usb/dvb-usb/dvb-usb-init.c:141 [inline]
 dvb_usb_device_exit+0x20a/0x510 drivers/media/usb/dvb-usb/dvb-usb-init.c:336
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x40b/0x500 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
