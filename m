Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7988B53D968
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiFEDge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 23:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbiFEDga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 23:36:30 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A84EDC0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 20:36:28 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so8605245ila.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 20:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O0hHvpPXjzNSI41xuD+u1RxvgncqxSb0ybRrE+Lv3a8=;
        b=xqVfiftawVo9FT0EbzGd8oZcz3DBPUWtaddSdWQSNtyHsG05FjKUW031nipgzG93Vc
         ZgDtckSbBep1O5g37z9wn1CVlrzO/KagS6d+jHGrVgnX4xXRVGyLFR8ErtmwlCsKDvWK
         dwp+D7HE0Pn7zDvbBpDGQlO6JAGkk5piSgXat2XuMrO1VW5UrnCoP/NhwgTxYmsEsysc
         5VEGAJMckUHeRLxhv6GrjVIlHHTh2bMa7QCeYyQLSPDmkaVldLokn2mEHeq1b8YM9xVy
         xl7BtmDn1fN45QOPPbQbv8UlxtuIxtzqa1Y692YGBOG1t4DV4oNvUwhCHMk5/MJ3yh4U
         LJlQ==
X-Gm-Message-State: AOAM533xgQUKJ7/ZWM0FDYKmDUhaWgrPvRima1rndWugve/Av4od8cHF
        Y4Ef3yhc1v2WtBJmbCRibI4h2ypn6eOXAYvXQpfEmxCT45oG
X-Google-Smtp-Source: ABdhPJwJ8xkWWOr8F38mpMhfhaiQH++ADjaC07uSiLe6bEqGKfqIuXplEQBS3BMQWW9sStKEUpj6mZEAsZb2+kerg9C+VAK091n6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a07:b0:330:3524:f707 with SMTP id
 cd7-20020a0566381a0700b003303524f707mr10228392jab.180.1654400187586; Sat, 04
 Jun 2022 20:36:27 -0700 (PDT)
Date:   Sat, 04 Jun 2022 20:36:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f5d7105e0ab0f71@google.com>
Subject: [syzbot] memory leak in usb_set_configuration (3)
From:   syzbot <syzbot+77b432d57c4791183ed4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1057eb7bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df438bbebec7a6d7
dashboard link: https://syzkaller.appspot.com/bug?extid=77b432d57c4791183ed4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125611a3f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c737bf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77b432d57c4791183ed4@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 20.640s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 20.620s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 20.620s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 21.680s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 21.660s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 21.660s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 23.680s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 23.660s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 23.660s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 24.710s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 24.690s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 24.690s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 25.760s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 25.740s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 25.740s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 25.800s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 25.780s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 25.780s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

BUG: memory leak
unreferenced object 0xffff88810d7e2800 (size 1024):
  comm "kworker/0:0", pid 6, jiffies 4294972491 (age 25.840s)
  hex dump (first 32 bytes):
    c8 db 01 0d 81 88 ff ff c8 db 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff888101996800 (size 1024):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 25.820s)
  hex dump (first 32 bytes):
    c8 d3 01 0d 81 88 ff ff c8 d3 01 0d 81 88 ff ff  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82d6dc08>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82d6dc08>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff82d6dc08>] usb_set_configuration+0x168/0xb80 drivers/usb/core/message.c:1998
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566
    [<ffffffff82d63118>] hub_port_connect drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82d63118>] hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
    [<ffffffff82d63118>] port_event drivers/usb/core/hub.c:5665 [inline]
    [<ffffffff82d63118>] hub_event+0x1668/0x21d0 drivers/usb/core/hub.c:5747
    [<ffffffff8127112f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff81271a59>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8127b695>] kthread+0x125/0x160 kernel/kthread.c:376

BUG: memory leak
unreferenced object 0xffff88810a261ce0 (size 32):
  comm "kworker/0:5", pid 3712, jiffies 4294972493 (age 25.820s)
  hex dump (first 32 bytes):
    33 2d 31 3a 30 2e 30 00 00 00 00 00 00 00 00 00  3-1:0.0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82396ccc>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82396da8>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8248d99b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82767123>] dev_set_name+0x63/0x90 drivers/base/core.c:3190
    [<ffffffff82d6e1e3>] usb_set_configuration+0x743/0xb80 drivers/usb/core/message.c:2105
    [<ffffffff82d7ed8c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d7062c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82771687>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff82771687>] really_probe.part.0+0xe7/0x340 drivers/base/dd.c:621
    [<ffffffff827719ec>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff827719ec>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:754
    [<ffffffff82771aea>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:784
    [<ffffffff82772306>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8276e7d7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82771ed2>] __device_attach+0x122/0x260 drivers/base/dd.c:972
    [<ffffffff82770446>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8276c82b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3402
    [<ffffffff8449f7f3>] usb_new_device.cold+0x10f/0x58e drivers/usb/core/hub.c:2566

executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
