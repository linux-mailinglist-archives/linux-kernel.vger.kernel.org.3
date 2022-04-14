Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB54501C71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbiDNUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbiDNUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:16:36 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE04ECB2A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:14:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x1-20020a056e020f0100b002c98fce9c13so3649788ilj.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9oXQAUnhx7469SB4tZMYYQtuLvdIjOD6O528K4DaHYs=;
        b=kZ5QdhrHdr38fHA3l/81GkKgUe+Kr4PrGT3kyPV4mL0sEgdpYy27RsvG6kCvozrCyl
         bKVg1tEPXkf2tBQ43WPb3WkvuOO9BMeu6o0zZabfYJj1YpAvMIDLOV0GO9s2k8QtONf7
         0BWbMKeL7ijznzch5DLKqmf+BFZowyUryGv5HixS2UxPJQzRiDTtWjRzvolF4pQ4o4Vb
         BkMBl1KF+e+fuTqCHrSqWpQTvpXRT4OB/zTFlPuazrbjen3AG5V85NUl9rMNXesz4Xde
         WM0DkSz2FPuMlYWourkAWB4MjEg01xymsCSdRTNUDJW+jYLdpsOsatNxhuX1cSDCbW9x
         DChg==
X-Gm-Message-State: AOAM530sOEPjM+/+WBzRUG+zFQXrqZoCvAIS7Kt6QZBYLNexHyMxFcud
        ACnxB41nRda0R1Uwaw4UYlz00bLr4uyEnXYe3rH6RUdOYuwh
X-Google-Smtp-Source: ABdhPJwlb5P2/2hiwQRdLiILcPL4YyP2mUq9frDldFC2S8TzmEMjpAf2Flnm71vUizxE+9llEW7rEj7gs9jFPf9LlKnDU17ktFCi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c85:b0:2cb:d249:5892 with SMTP id
 w5-20020a056e021c8500b002cbd2495892mr1713670ill.142.1649967247951; Thu, 14
 Apr 2022 13:14:07 -0700 (PDT)
Date:   Thu, 14 Apr 2022 13:14:07 -0700
In-Reply-To: <88a47762-fac7-6158-1730-344bb2905fc9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b48bc305dca2efcd@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
From:   syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in pvr2_hdw_create

pvrusb2: Hardware description: OnAir USB2 Hybrid USB tuner
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3607 at kernel/workqueue.c:3066 __flush_work+0x926/0xb10 kernel/workqueue.c:3066
Modules linked in:
CPU: 1 PID: 3607 Comm: kworker/1:4 Not tainted 5.18.0-rc2-syzkaller-00187-g115acbb56978-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0x926/0xb10 kernel/workqueue.c:3066
Code: ff 41 89 c4 89 8d 88 fe ff ff e8 d5 2b 77 00 48 0f ba 2b 03 e9 6a fa ff ff e8 c6 8f 2b 00 0f 0b e9 5a fc ff ff e8 ba 8f 2b 00 <0f> 0b 45 31 f6 e9 4b fc ff ff e8 eb 28 77 00 e9 3a fb ff ff e8 a1
RSP: 0018:ffffc90003d1ee00 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff88806e4040d0 RCX: 0000000000000000
RDX: ffff88801e1eba00 RSI: ffffffff814d8be6 RDI: 0000000000000003
RBP: ffffc90003d1ef98 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff814d8365 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88806e405678 R14: 0000000000000001 R15: ffff88806e4040e8
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd4ad80638 CR3: 000000002067b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pvr2_hdw_create+0x11da/0x2630 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2612
 pvr2_context_create+0x1ae/0x280 drivers/media/usb/pvrusb2/pvrusb2-context.c:222
 pvr_probe+0x21/0xc0 drivers/media/usb/pvrusb2/pvrusb2-main.c:62
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5665 [inline]
 hub_event+0x25c6/0x4680 drivers/usb/core/hub.c:5747
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


Tested on:

commit:         115acbb5 Merge tag 's390-5.18-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef7197700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=1a247e36149ffd709a9b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14838637700000

