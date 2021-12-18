Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798FD479A82
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhLRLH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:07:27 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:56190 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhLRLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:07:26 -0500
Received: by mail-io1-f72.google.com with SMTP id y74-20020a6bc84d000000b005e700290338so3241856iof.22
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 03:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jj8s44uYX7evjsp1QT1NRjYGi4K6rKvghFsgqkyMv8Y=;
        b=ZCl7wElbIJkor6l6bSj/6BdsoBslvgRE2WtpF4p1McPWl/1QwHnDMXUpwOUQATRTZ5
         aen1KBTNLFRrrQMVi5M727L6jQfQLp7DPTZZNuqH5y88f9aChcSCW+uW+pO8FqA3RlsC
         wjJUZYc5/IFnCA/UcY7Qi4rWB8FrkQaamRf38ATPxibELJ4spZbAGsCloWTmDraa26NC
         8TK613hJWr28NsP5QtuM6IYwmGvgv92mTWeliLm/MTA0RN0CoJu7flH3UDUUXw1unkxL
         emh6lkNKWWVtrSooQ+iGDZbsjAOxxQLDbM/Xd6RtrBkHtJdC0X5t0u27MbPmsw0hXJb6
         7s4g==
X-Gm-Message-State: AOAM5310rAaiY2Ai2JAvATzCiG1Xkz3eY72U2vNcNdygZWrAchaCBVmO
        pEYGbpGJa3uT1RaXEC06f7elEiysukFENGGQaSCoWjh2s4f+
X-Google-Smtp-Source: ABdhPJy+ma5yqJ118njLi7NzQw/CeFV5yOda75oKu6Rp6EVxoWnQHSFvjX4OVYzdF3nyEXxojHeNcYLOtIfzAexamB5OwdeXib0n
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:: with SMTP id u13mr3819528ill.236.1639825646096;
 Sat, 18 Dec 2021 03:07:26 -0800 (PST)
Date:   Sat, 18 Dec 2021 03:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021160205d369a962@google.com>
Subject: [syzbot] KMSAN: uninit-value in asix_mdio_read (2)
From:   syzbot <syzbot+f44badb06036334e867a@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, davem@davemloft.net, glider@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux@rempel-privat.de,
        netdev@vger.kernel.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b0a8b5053e8b kmsan: core: add dependency on DEBUG_KERNEL
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4d133b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46a956fc7a887c60
dashboard link: https://syzkaller.appspot.com/bug?extid=f44badb06036334e867a
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149fddcbb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17baef25b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f44badb06036334e867a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in asix_check_host_enable drivers/net/usb/asix_common.c:82 [inline]
BUG: KMSAN: uninit-value in asix_check_host_enable drivers/net/usb/asix_common.c:82 [inline] drivers/net/usb/asix_common.c:497
BUG: KMSAN: uninit-value in asix_mdio_read+0x3c1/0xb00 drivers/net/usb/asix_common.c:497 drivers/net/usb/asix_common.c:497
 asix_check_host_enable drivers/net/usb/asix_common.c:82 [inline]
 asix_check_host_enable drivers/net/usb/asix_common.c:82 [inline] drivers/net/usb/asix_common.c:497
 asix_mdio_read+0x3c1/0xb00 drivers/net/usb/asix_common.c:497 drivers/net/usb/asix_common.c:497
 asix_mdio_bus_read+0xba/0xe0 drivers/net/usb/asix_common.c:556 drivers/net/usb/asix_common.c:556
 __mdiobus_read+0xbf/0x4f0 drivers/net/phy/mdio_bus.c:755 drivers/net/phy/mdio_bus.c:755
 mdiobus_read+0xaa/0xf0 drivers/net/phy/mdio_bus.c:862 drivers/net/phy/mdio_bus.c:862
 get_phy_c22_id drivers/net/phy/phy_device.c:813 [inline]
 get_phy_c22_id drivers/net/phy/phy_device.c:813 [inline] drivers/net/phy/phy_device.c:890
 get_phy_device+0x218/0x8b0 drivers/net/phy/phy_device.c:890 drivers/net/phy/phy_device.c:890
 mdiobus_scan+0x1c7/0x940
 __mdiobus_register+0xe16/0x1200 drivers/net/phy/mdio_bus.c:583 drivers/net/phy/mdio_bus.c:583
 __devm_mdiobus_register+0x18f/0x2f0 drivers/net/phy/mdio_devres.c:87 drivers/net/phy/mdio_devres.c:87
 ax88772_init_mdio drivers/net/usb/asix_devices.c:676 [inline]
 ax88772_init_mdio drivers/net/usb/asix_devices.c:676 [inline] drivers/net/usb/asix_devices.c:786
 ax88772_bind+0x10b1/0x1770 drivers/net/usb/asix_devices.c:786 drivers/net/usb/asix_devices.c:786
 usbnet_probe+0x1284/0x4140 drivers/net/usb/usbnet.c:1747 drivers/net/usb/usbnet.c:1747
 usb_probe_interface+0xf19/0x1600 drivers/usb/core/driver.c:396 drivers/usb/core/driver.c:396
 really_probe+0x67d/0x1510 drivers/base/dd.c:596 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 driver_probe_device drivers/base/dd.c:781 [inline] drivers/base/dd.c:898
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:969 drivers/base/dd.c:969
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1016 drivers/base/dd.c:1016
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487 drivers/base/bus.c:487
 device_add+0x1d3e/0x2400 drivers/base/core.c:3394 drivers/base/core.c:3394
 usb_set_configuration+0x37e9/0x3ed0 drivers/usb/core/message.c:2170 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0x13c/0x300 drivers/usb/core/generic.c:238 drivers/usb/core/generic.c:238
 usb_probe_device+0x309/0x570 drivers/usb/core/driver.c:293 drivers/usb/core/driver.c:293
 really_probe+0x67d/0x1510 drivers/base/dd.c:596 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 driver_probe_device drivers/base/dd.c:781 [inline] drivers/base/dd.c:898
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:969 drivers/base/dd.c:969
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1016 drivers/base/dd.c:1016
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487 drivers/base/bus.c:487
 device_add+0x1d3e/0x2400 drivers/base/core.c:3394 drivers/base/core.c:3394
 usb_new_device+0x1b8e/0x2950 drivers/usb/core/hub.c:2563 drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_port_connect drivers/usb/core/hub.c:5353 [inline] drivers/usb/core/hub.c:5725
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline] drivers/usb/core/hub.c:5725
 port_event drivers/usb/core/hub.c:5643 [inline] drivers/usb/core/hub.c:5725
 hub_event+0x5ad2/0x8910 drivers/usb/core/hub.c:5725 drivers/usb/core/hub.c:5725
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 process_scheduled_works kernel/workqueue.c:2361 [inline] kernel/workqueue.c:2447
 worker_thread+0x1735/0x21f0 kernel/workqueue.c:2447 kernel/workqueue.c:2447
 kthread+0x721/0x850 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Local variable smsr.i created at:
 asix_mdio_read+0xbc/0xb00 drivers/net/usb/asix_common.c:497 drivers/net/usb/asix_common.c:497
 asix_mdio_bus_read+0xba/0xe0 drivers/net/usb/asix_common.c:556 drivers/net/usb/asix_common.c:556

CPU: 0 PID: 3145 Comm: kworker/0:3 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event

=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
