Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5235058F5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiHKCUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiHKCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:20:30 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87262B26A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:20:28 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id t7-20020a6b6407000000b00684ed320f97so5082308iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=FRcqXcm04Kybe4wMNMlEndxwmeCXHP6BNbwcOvk5VT8=;
        b=he3nlvrCeujTBOBnrzRyuj1ZU95BIGSvhOYfo9RrMG3lGnTpjucz7Vma/DpR7BkGIc
         xDnavVOmjnben7XUDde5bKHkfTalA73oUq+H4WWBtU7sfeUVt528ZHtXR08ATAbzrFMl
         /xhiYC4GTb3hQoaOyPmn/yxNYwE4TNf0wHMT1FuKOk0mwVg8huaRRBKc8n4EGD3yKHWl
         CrScRH1akdu3Vdmvw4rzNGsn1r5mkdDbJ1CnA3t9XbJvx9TWYbMBKIRXQF9t4l22yuSP
         IN1zFVfNccLwO9GxKQSqlA+j4ZipquCr4ZuStQ0TEQi5c4K3mGy0cujm9T73IjtpYTBi
         gS+Q==
X-Gm-Message-State: ACgBeo1jcddc85JfiowWayDY+r6BP91PmWLdYtdKhxF6DfsqLdcc3vKj
        ZKG6++doTal8RPKyeZFx106+gS2r99Mry3SZC/vFhFO+SV9+
X-Google-Smtp-Source: AA6agR5wx/dIc16+Izba6GK/VHZlbf/SOvg1d4j0B1EBQ5U61ChDckzUAkjF3HnvX5JAEttJT8QbZuE+WYosdPWeh6ZHO4AHgWGg
MIME-Version: 1.0
X-Received: by 2002:a92:9506:0:b0:2e0:ed70:ea7d with SMTP id
 y6-20020a929506000000b002e0ed70ea7dmr8456781ilh.207.1660184428020; Wed, 10
 Aug 2022 19:20:28 -0700 (PDT)
Date:   Wed, 10 Aug 2022 19:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001809aa05e5edcf23@google.com>
Subject: [syzbot] memory leak in airspy_probe
From:   syzbot <syzbot+bb25f85e5aa482864dc0@syzkaller.appspotmail.com>
To:     crope@iki.fi, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    20cf903a0c40 Merge tag 'for-6.0/dm-changes-2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fbfa46080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3121e03e34975
dashboard link: https://syzkaller.appspot.com/bug?extid=bb25f85e5aa482864dc0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cb43fa080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165877f2080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb25f85e5aa482864dc0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810afb7300 (size 128):
  comm "kworker/0:1", pid 44, jiffies 4294946315 (age 14.410s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8316980e>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff8316980e>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff8316980e>] airspy_probe+0x8e/0x200 drivers/media/usb/airspy/airspy.c:981
    [<ffffffff82d83457>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff8277ff2d>] call_driver_probe drivers/base/dd.c:530 [inline]
    [<ffffffff8277ff2d>] really_probe+0x12d/0x390 drivers/base/dd.c:609
    [<ffffffff8278024f>] __driver_probe_device+0xbf/0x140 drivers/base/dd.c:748
    [<ffffffff827802fa>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:778
    [<ffffffff82780c46>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:901
    [<ffffffff8277d127>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff827806d2>] __device_attach+0x102/0x2d0 drivers/base/dd.c:973
    [<ffffffff8277ed96>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8277b152>] device_add+0x642/0xe60 drivers/base/core.c:3517
    [<ffffffff82d80892>] usb_set_configuration+0x8f2/0xb80 drivers/usb/core/message.c:2170
    [<ffffffff82d9121c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d82b2c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff8277ff2d>] call_driver_probe drivers/base/dd.c:530 [inline]
    [<ffffffff8277ff2d>] really_probe+0x12d/0x390 drivers/base/dd.c:609
    [<ffffffff8278024f>] __driver_probe_device+0xbf/0x140 drivers/base/dd.c:748
    [<ffffffff827802fa>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:778



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
