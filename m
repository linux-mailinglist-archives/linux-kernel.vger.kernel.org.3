Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187C4A83B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350477AbiBCMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:18:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:56210 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiBCMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:18:08 -0500
Received: by mail-il1-f198.google.com with SMTP id q3-20020a056e02106300b002bb2b842046so1480303ilj.22
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 04:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=z9YXlmKzEQbptaH41dlyQLFGxbVy4nUjzAu3/5IAtUI=;
        b=FJrG+a3b3UWURrvBRVnzA4+Wh30gWFlP4pk8+N/fkkGyH842wX4+8lbwa1/79fYr/k
         1bqlKYbU5lcwqYWt8kwshYfCsO0iAwUk0iwvpnYrim3ljxOWq4fXn6F1oxt3LehGpffh
         QkkVQHmELQJycd5r5BpvxhT+8EZDbK0Kn1Y7I/WWEx4NSq4WKEuJBIB1eU7U7kLraw23
         oCb2Hrt/rBuWJKD+kTbKSSHGhEmUVxZmab52hchmqMMDuDQcs9OqFpBPY+U1Zy56Ts3f
         wkt5ScgMYcsOIGf1K4gBbnVF0TJB0OY8nLXtvt1keevsS+qRs5DkVYplAUtLmVpWHlHL
         zm3g==
X-Gm-Message-State: AOAM530ZY7U3/N607Zyu2D25kmSdEcmMSyL7b0BdxrqGMP/56lsrxwP6
        pp9Ky2efGBn33RDy8gpZINZgUVwrQh1hjKSuynFyYyDNHaqV
X-Google-Smtp-Source: ABdhPJwB+1ut/EJO1prf+1yTAenTEE/+nBOc+Jq3SM9l3CzELZePWLK51Gdm73fwZQK08OE4XcGvpIespLcz2Axn8Sn/puXUBCE4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c84:: with SMTP id w4mr20034352ill.223.1643890687568;
 Thu, 03 Feb 2022 04:18:07 -0800 (PST)
Date:   Thu, 03 Feb 2022 04:18:07 -0800
In-Reply-To: <20220203102217.2229-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b73a605d71c201b@google.com>
Subject: Re: [syzbot] general protection fault in hidraw_release
From:   syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, dvyukov@google.com,
        hdanton@sina.com, jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in drop_ref

------------[ cut here ]------------
kernel BUG at drivers/hid/hidraw.c:335!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5036 Comm: syz-executor223 Not tainted 5.17.0-rc2-syzkaller-00039-g9f7fb8de5d9b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:drop_ref+0x375/0x3e0 drivers/hid/hidraw.c:335
Code: fb e9 a9 fd ff ff 48 89 ef 89 74 24 04 e8 43 61 04 fb 8b 74 24 04 e9 64 fd ff ff e8 a5 61 04 fb e9 13 fd ff ff e8 8b 1f bd fa <0f> 0b 48 89 df e8 31 61 04 fb e9 5a fe ff ff 48 89 de 48 c7 c7 a0
RSP: 0018:ffffc90005da7ac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801deef9b0 RCX: 0000000000000000
RDX: ffff888072660000 RSI: ffffffff86bb4ef5 RDI: ffffffff90869f60
RBP: ffff88801deef900 R08: 0000000000000000 R09: ffffffff8ffbda7f
R10: ffffffff86bb4cd2 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801deef908 R14: ffff88807f1e98e0 R15: ffff88807f1e8000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f229e36a600 CR3: 0000000079b38000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hidraw_disconnect+0x48/0x60 drivers/hid/hidraw.c:600
 hid_disconnect+0x130/0x1a0 drivers/hid/hid-core.c:2036
 hid_hw_stop drivers/hid/hid-core.c:2079 [inline]
 hid_device_remove+0x15d/0x200 drivers/hid/hid-core.c:2411
 __device_release_driver+0x3bd/0x700 drivers/base/dd.c:1204
 device_release_driver_internal drivers/base/dd.c:1237 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1260
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd50 drivers/base/core.c:3592
 hid_remove_device drivers/hid/hid-core.c:2578 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2597
 uhid_dev_destroy drivers/hid/uhid.c:587 [inline]
 uhid_char_release+0xed/0x210 drivers/hid/uhid.c:663
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __ia32_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ee8549
Code: Unable to access opcode bytes at RIP 0xf7ee851f.
RSP: 002b:00000000ff8aaf4c EFLAGS: 00000292 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000f7f94fa0 RSI: 00000000f7f953b8 RDI: 00000000f7f953b8
RBP: 00000000f7f95928 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drop_ref+0x375/0x3e0 drivers/hid/hidraw.c:335
Code: fb e9 a9 fd ff ff 48 89 ef 89 74 24 04 e8 43 61 04 fb 8b 74 24 04 e9 64 fd ff ff e8 a5 61 04 fb e9 13 fd ff ff e8 8b 1f bd fa <0f> 0b 48 89 df e8 31 61 04 fb e9 5a fe ff ff 48 89 de 48 c7 c7 a0
RSP: 0018:ffffc90005da7ac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801deef9b0 RCX: 0000000000000000
RDX: ffff888072660000 RSI: ffffffff86bb4ef5 RDI: ffffffff90869f60
RBP: ffff88801deef900 R08: 0000000000000000 R09: ffffffff8ffbda7f
R10: ffffffff86bb4cd2 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801deef908 R14: ffff88807f1e98e0 R15: ffff88807f1e8000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f64971d1018 CR3: 000000007f5e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         9f7fb8de Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=15e029cc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12571934700000

