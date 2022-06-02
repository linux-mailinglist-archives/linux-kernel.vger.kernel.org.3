Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E253B473
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiFBHjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFBHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:39:24 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B270BCB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:39:20 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so2851872ile.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ugWO2J8z3ApQ+9nb1qMgkSpwdpensnpPaJmpZB3pJIA=;
        b=ombx30aiVYO78G+nQXopVO9zlnt6q9aL7fCDttJNIMMoVU15zFG3CEPdyKTj8CbZC4
         Dg77hPzuISbF43SA1GC8dMVLIrBTvfdt88xdPoFcryUl4bvSIyILl8gZDopB95GogIRx
         cqbX1vgAuoDHIuHfyZZFakM0PnK7xdVRtBdfOZFIRCtE/n6x9Mh+Mk2SHqbIJM5QIdT6
         wTiO1b5SZEWc5wECAVeUBfO0Xl4dqsgLVWHICqphnuULb0NcjujlWipfTEPZQZ/hiyL5
         008L9mp4heyEM/v9FnRXZvw+oBMcVWHI6ciYX0fQvfedmlQGgkb95KLX2RxMOn3WfQOY
         rIDA==
X-Gm-Message-State: AOAM5314XFGxhI1lI7z/eRhaPFjBW/0uOwA7DeT5yMs+PcT7+61QUs4E
        +R1/lrhxFeHs+qc72UMSnaLDnxMGe3LgX+t0mQM+iUnau4+Q
X-Google-Smtp-Source: ABdhPJw+g0PGsCATc0WV2dGJ800hW6TRf2YceUxcMmNyvcTrq3c335IDeIBs3/zcYpQYXG0JsPjFjB3o9KFZgS5IkB2oXS40xc3g
MIME-Version: 1.0
X-Received: by 2002:a02:c612:0:b0:32e:aa7e:5b59 with SMTP id
 i18-20020a02c612000000b0032eaa7e5b59mr2252484jan.0.1654155559337; Thu, 02 Jun
 2022 00:39:19 -0700 (PDT)
Date:   Thu, 02 Jun 2022 00:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008488e005e0721af2@google.com>
Subject: [syzbot] linux-next boot error: INFO: task hung in
 add_early_randomness (2)
From:   syzbot <syzbot+4bff2788f64e121fefcf@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2e776ccffa84 Add linux-next specific files for 20220602
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14226a35f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5266d49aa5c20076
dashboard link: https://syzkaller.appspot.com/bug?extid=4bff2788f64e121fefcf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bff2788f64e121fefcf@syzkaller.appspotmail.com

INFO: task swapper/0:1 blocked for more than 143 seconds.
      Not tainted 5.18.0-next-20220602-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:swapper/0       state:D stack:23832 pid:    1 ppid:     0 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa06/0x4b40 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
 hwrng_register+0x399/0x510 drivers/char/hw_random/core.c:599
 virtrng_scan+0x37/0x90 drivers/char/hw_random/virtio-rng.c:205
 virtio_dev_probe+0x639/0x910 drivers/virtio/virtio.c:313
 call_driver_probe drivers/base/dd.c:562 [inline]
 really_probe+0x23e/0xb90 drivers/base/dd.c:641
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:774
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:804
 __driver_attach+0x22d/0x550 drivers/base/dd.c:1173
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x422/0x640 drivers/base/bus.c:618
 bus_add_driver+0x422/0x640 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:240
 do_one_initcall+0x103/0x660 init/main.c:1300
 do_initcall_level init/main.c:1375 [inline]
 do_initcalls init/main.c:1391 [inline]
 do_basic_setup init/main.c:1410 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1617
 kernel_init+0x1a/0x1d0 init/main.c:1506
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
2 locks held by swapper/0/1:
 #0: ffff88801b377170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #0: ffff88801b377170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1064 [inline]
 #0: ffff88801b377170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x222/0x550 drivers/base/dd.c:1172
 #1: ffffffff8c841068 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
2 locks held by kworker/u4:0/8:
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900000d7da8 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
2 locks held by pr/ttyS0/16:
1 lock held by khungtaskd/28:
 #0: ffffffff8bd86aa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
1 lock held by hwrng/755:
 #0: ffffffff8c841068 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
