Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB14470118
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhLJNDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:03:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:43875 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbhLJNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:03:01 -0500
Received: by mail-il1-f199.google.com with SMTP id j1-20020a056e02154100b002a181a1ce89so10357275ilu.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AeyBw/8ZTXFPGML0AlgWPXixvlMPmLkpLOPCsARNEJM=;
        b=JlPYjSCtN08fZYTgSABHNsfdYTyUKDjepRtHan5YhPLF94cnv558xFocZmJk38QU68
         7ctu9XWahST+HCJpEweDwx6TsVMhaHsTftcah3S2l1R7Aq7IJm9c14h3TGEC3GQ3nY35
         bnXbe88Gp/P707BTWb6C8UE0ExD+EF7jqU/NpeJoL+ED/BkKm+yTQUHuzlPba52WimaY
         9ZqqJJqbEVoNSkorCXf5a4NvMy7Hfwxq+gdgx4j6VOyirrzWGLKRdX3TzuG+2f8J45Sn
         wGmhqGHdFQwUNDQuTu5/BpBwTZEaQV39eo9neIrSmaQXeGmd3D4LLA9E8ow7WiwY3flg
         mscQ==
X-Gm-Message-State: AOAM5322bGnJ1MswamYYXuCcRhWtmol38wzw/yVaCzRORRrSkoTbCsGE
        qzm9z3Wzfms16iMbEz1woJ++fPqZ2DN3Y1+9wvq8KxlVOpqY
X-Google-Smtp-Source: ABdhPJzjwM9fNw7ikMR8I4vjI6FzQ24wGliwodR5iNgJiRzSF+9d2bqSqlqmowRQTP6dNw0z7p5zuQmk5BLgKHr+p8Ey8NSURJNu
MIME-Version: 1.0
X-Received: by 2002:a02:6064:: with SMTP id d36mr17106205jaf.80.1639141165903;
 Fri, 10 Dec 2021 04:59:25 -0800 (PST)
Date:   Fri, 10 Dec 2021 04:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee344d05d2ca4a4b@google.com>
Subject: [syzbot] KMSAN: uninit-value in efuse_one_byte_read (2)
From:   syzbot <syzbot+1b535a057d0360bbcc56@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        glider@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cdfb223e7e63 kmsan: core: define KMSAN_BUG_ON
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11ade575b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=1b535a057d0360bbcc56
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b535a057d0360bbcc56@syzkaller.appspotmail.com

usb 2-1: r8712u: Boot from EFUSE: Autoload OK
=====================================================
BUG: KMSAN: uninit-value in efuse_one_byte_read+0x20f/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:76
 efuse_one_byte_read+0x20f/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:76
 r8712_efuse_pg_packet_read+0x2bb/0xd80 drivers/staging/rtl8712/rtl8712_efuse.c:245
 r871xu_drv_init+0x1b90/0x2e90 drivers/staging/rtl8712/usb_intf.c:440
 usb_probe_interface+0xed9/0x14f0 drivers/usb/core/driver.c:396
 really_probe+0x66e/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2f0/0x410 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:969
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1016
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487
 device_add+0x1d46/0x2400 drivers/base/core.c:3394
 usb_set_configuration+0x389f/0x3ee0 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0x13c/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x309/0x570 drivers/usb/core/driver.c:293
 really_probe+0x66e/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2f0/0x410 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:969
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1016
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487
 device_add+0x1d46/0x2400 drivers/base/core.c:3394
 usb_new_device+0x1b9a/0x2960 drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x595e/0x8910 drivers/usb/core/hub.c:5725
 process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Local variable data created at:
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
 r8712_read8+0xa5/0xd0 drivers/staging/rtl8712/rtl8712_io.c:29

CPU: 1 PID: 20362 Comm: kworker/1:1 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
