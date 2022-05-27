Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6453677C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354570AbiE0T3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352321AbiE0T3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:29:09 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0122C134E15
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:29:09 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id z22-20020a5e8616000000b0066576918849so3305323ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UCrw1QMFwLAhYuX2Uv+8YQyJf1duR3SnGXpKA/U5Zjg=;
        b=qk6HgDi+HgQdS1cOZ8oDwcw+7Ra8UkKpByZG8te+SGg4XbdfVRtqHrfckkl5OnAnCj
         lkdNqfwiTDd/mVhtp1ssud3wmp729QEV6iCY5dfo5IQKJvEda8LDIB7e1bADujQcB4Yw
         xGocdosXGL7Evv0OazobCzs4FvZYlBdQ4a8pq1mvlfMrKUQ9cdFg/vB+YZkJNn0ycY+9
         uZBLvtA57DeAALubAQwoZEiJQY+nPg9J6yq36h2vhpLFEzvlrPfbXZnMJ30T7x74qqOO
         ws4Hf1gnUkrEQ6ArPLuVB+1DzK8/Jg5fnn9wJOX+YeTl/DwWektB5y7dURBItOXqa5OH
         Wzcg==
X-Gm-Message-State: AOAM5327Dtyf/U93QG89uM94Ray0n4/0o1SNH+IgYSnYusNdmBaPYE5/
        gIWmO7qVgz3xnmCAHroaHRQPp0hKCqc7UPGgbjZ5chb+Tz5P
X-Google-Smtp-Source: ABdhPJwoyL010UZOYGHoGKtxYLY31QslNEbp40waj9wMW06hNZxvmVRgdGXFt4EIOb+Z4cj6FyAMZzFjL14srmIJ8GMIeOCiwQ/Y
MIME-Version: 1.0
X-Received: by 2002:a05:6602:447:b0:665:9141:7e with SMTP id
 e7-20020a056602044700b006659141007emr5754889iov.60.1653679748407; Fri, 27 May
 2022 12:29:08 -0700 (PDT)
Date:   Fri, 27 May 2022 12:29:08 -0700
In-Reply-To: <YpEi/sbT/R/0yKzo@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9e65705e003513a@google.com>
Subject: Re: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in sysfs_create_file_ns

really_probe: driver_sysfs_add(gadget.0) failed
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
Modules linked in:
CPU: 0 PID: 2361 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
Code: e9 03 80 3c 01 00 75 7f 8b 4c 24 38 4d 89 e9 48 89 ee 48 8b 7b 30 44 8b 44 24 48 e8 e9 fa ff ff 41 89 c5 eb 0d e8 cf 7c 9d ff <0f> 0b 41 bd ea ff ff ff e8 c2 7c 9d ff 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc900028ffca0 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff88810efd6600 RCX: 0000000000000000
RDX: ffff888117a68000 RSI: ffffffff81a6f891 RDI: ffff88810efd6600
RBP: ffffffff88041fc0 R08: 0000000000000000 R09: ffff88810095ba13
R10: ffffed102012b742 R11: 0000000000000001 R12: 1ffff9200051ff95
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88810efd6630
FS:  00007f830048d700(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f830048d718 CR3: 000000010cb4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sysfs_create_file include/linux/sysfs.h:607 [inline]
 driver_create_file+0x48/0x70 drivers/base/driver.c:107
 bus_add_driver+0x309/0x630 drivers/base/bus.c:624
 driver_register+0x220/0x3a0 drivers/base/driver.c:171
 usb_gadget_register_driver_owner+0xfb/0x1e0 drivers/usb/gadget/udc/core.c:1558
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
 raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f83005590e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f830048d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f830066c100 RCX: 00007f83005590e9
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 00007f83005b308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc1dbfbf0f R14: 00007f830048d300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=154282bdf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17eec23df00000

