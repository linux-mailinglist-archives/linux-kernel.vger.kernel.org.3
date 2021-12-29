Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AF480E23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhL2AQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:16:30 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:48003 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhL2AQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:16:28 -0500
Received: by mail-io1-f70.google.com with SMTP id o11-20020a0566022e0b00b005e95edf792dso8867778iow.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lqz7vT/3ujQBY+NVm64C3545EA/17vbBUwHvP7ZwolM=;
        b=0U0DgetX9rb9CSjui1S7afieVh36B3X9GgK8S4u3K4x5eYj6+w+qA68ZvDr7iIp7qx
         TFHR95t2OUWgn40mcPAU8QCeuOuTVWbyAEDx9VyjTyLFHgHYTrHcJpvts1ZltgxWSMLS
         4ohm/GHkZhDUnhpnP+agCxOKdOsfJBbXqNxLa52PH0rowfTC4K/KJhGhT7NgxsP8KcEZ
         Uu+ekpFRiJ08hAnEYaiVzt6mLc+wEiGS3+UK+wyVrwppnhyQ9tvIrA7aqLNuSl0AJ5SC
         +Q5gxueQqqa+VNa1JagJTziqI6ZzJWPO0of3jQ9WZnRB/xb2ZBl41o9c6lGC8vQni0ZK
         JOww==
X-Gm-Message-State: AOAM531aw7rU1XK/i+UwncXx5fwcsi0C1dyeJxc0pWTCFndQVJEpFdbd
        +5J2wXuQandeGt2tG2slUd2qwzF0ISsZ+yM3NO83n8/2Gfeh
X-Google-Smtp-Source: ABdhPJwkX2lmSsIIds9qzijz9OHYZTfS6XWYBCLnLSYG1XzznL/fLyA2cTJyXkAyDnLDn3ynXcCUtFAvGor6GaXjwl1oDW6CK2R0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:: with SMTP id e3mr9192915ilu.72.1640736988110;
 Tue, 28 Dec 2021 16:16:28 -0800 (PST)
Date:   Tue, 28 Dec 2021 16:16:28 -0800
In-Reply-To: <000000000000b1c43105c3a38257@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058a5c505d43dd91c@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in corrupted (2)
From:   syzbot <syzbot+a437546ec71b04dfb5ac@syzkaller.appspotmail.com>
To:     hdanton@sina.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, miaoqinglang@huawei.com,
        qiang.zhang@windriver.com, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ea586a076e8a Add linux-next specific files for 20211224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12bb71a5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9c4e3dde2c568fb
dashboard link: https://syzkaller.appspot.com/bug?extid=a437546ec71b04dfb5ac
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1246b50db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c902db00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a437546ec71b04dfb5ac@syzkaller.appspotmail.com

magicmouse 0003:05AC:0265.0001: hidraw0: USB HID v0.00 Device [HID 05ac:0265] on usb-dummy_hcd.0-1/input0
magicmouse 0003:05AC:0265.0001: magicmouse input not registered
magicmouse: probe of 0003:05AC:0265.0001 failed with error -12
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: magicmouse_battery_timer_tick+0x0/0x360 include/linux/device.h:693
WARNING: CPU: 1 PID: 25 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 5.16.0-rc6-next-20211224-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 80 c1 05 8a 4c 89 ee 48 c7 c7 80 b5 05 8a e8 1e 28 25 05 <0f> 0b 83 05 35 9d a6 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90000dfeb10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880157d3a80 RSI: ffffffff815f4208 RDI: fffff520001bfd54
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815edf6e R11: 0000000000000000 R12: ffffffff89adf420
R13: ffffffff8a05bbc0 R14: ffffffff81666980 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff4e854bf0 CR3: 000000000b88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

