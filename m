Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C24536894
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354773AbiE0Vg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351170AbiE0Vgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:36:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CA1FA1ADA7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:36:52 -0700 (PDT)
Received: (qmail 112415 invoked by uid 1000); 27 May 2022 17:36:51 -0400
Date:   Fri, 27 May 2022 17:36:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
Cc:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in driver_unregister
Message-ID: <YpFEc5zeFK0AXa2q@rowland.harvard.edu>
References: <YpEi/sbT/R/0yKzo@rowland.harvard.edu>
 <000000000000f9e65705e003513a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f9e65705e003513a@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:29:08PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in sysfs_create_file_ns
> 
> really_probe: driver_sysfs_add(gadget.0) failed
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
> Modules linked in:
> CPU: 0 PID: 2361 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
> Code: e9 03 80 3c 01 00 75 7f 8b 4c 24 38 4d 89 e9 48 89 ee 48 8b 7b 30 44 8b 44 24 48 e8 e9 fa ff ff 41 89 c5 eb 0d e8 cf 7c 9d ff <0f> 0b 41 bd ea ff ff ff e8 c2 7c 9d ff 48 b8 00 00 00 00 00 fc ff
> RSP: 0018:ffffc900028ffca0 EFLAGS: 00010293

Here's some extra detail, taken from the console log:

[   98.336685][ T2361] really_probe: driver_sysfs_add(gadget.0) failed
[   98.336836][ T2360] sysfs: cannot create duplicate filename '/bus/gadget/drivers/dummy_udc'
[   98.343498][ T2361] ------------[ cut here ]------------
[   98.352154][ T2360] CPU: 1 PID: 2360 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
[   98.357802][ T2361] WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0

Simultaneous splats from two different threads trying to add drivers with 
the same name suggests there might be a concurrency bug in the sysfs 
filesystem.  This sort of thing should be an error but it shouldn't bring 
the kernel to its knees.

Greg, do you know anyone who could take a look at this?  I don't know much 
about sysfs.

Alan Stern

> 
> RAX: 0000000000000000 RBX: ffff88810efd6600 RCX: 0000000000000000
> RDX: ffff888117a68000 RSI: ffffffff81a6f891 RDI: ffff88810efd6600
> RBP: ffffffff88041fc0 R08: 0000000000000000 R09: ffff88810095ba13
> R10: ffffed102012b742 R11: 0000000000000001 R12: 1ffff9200051ff95
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88810efd6630
> FS:  00007f830048d700(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f830048d718 CR3: 000000010cb4c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  sysfs_create_file include/linux/sysfs.h:607 [inline]
>  driver_create_file+0x48/0x70 drivers/base/driver.c:107
>  bus_add_driver+0x309/0x630 drivers/base/bus.c:624
>  driver_register+0x220/0x3a0 drivers/base/driver.c:171
>  usb_gadget_register_driver_owner+0xfb/0x1e0 drivers/usb/gadget/udc/core.c:1558
>  raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>  raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f83005590e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f830048d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f830066c100 RCX: 00007f83005590e9
> RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
> RBP: 00007f83005b308d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc1dbfbf0f R14: 00007f830048d300 R15: 0000000000022000
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=154282bdf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17eec23df00000
> 
