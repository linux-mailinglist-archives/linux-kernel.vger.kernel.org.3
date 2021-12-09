Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77F46E272
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhLIGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:31:01 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:51817 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhLIGbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:31:00 -0500
Received: by mail-il1-f197.google.com with SMTP id l2-20020a056e021aa200b002a281027bb8so6178982ilv.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hORsw0wcyUsob7oHOIH8vdI9JNU4w7VFX8v/cBNC/a0=;
        b=rDwS3owLMswOGn5/Iw0E4dFDZ0Op0AJndgmnvycO1wJuBiDsmmqPRxuRy2Gvs1CWWE
         72J5cp+JNRWAWkrDk3UFZU2vTMtRIebV9wm5U9WZqxI+ioC99rmLL4xQE5uo8096P5OX
         LDZZ6ZUK1JPffZMWbBaygbdAUC2Be3+/EEpX339NZ22giL82U/PAd/kEjmyWfe7yA5Kq
         ssK15Oq9hYkIm83BTe4Bp/l8YCHpQyR3RvXqRStgcXgNs+lYzVP4TqcxXV22gVy/Z7CR
         nXaSs4Gv40yNKSteka9XLVKKyvNtVI5uPaO3fZyeBbNOOLee7V/XDhA1vptxwoph0Q86
         Jf9Q==
X-Gm-Message-State: AOAM531QDpZsnDNUa+Yrr9iM2ak/EY8Ek1/UCWl+hp67v4yLWPkodVc5
        ySU6vnv1qAz7rP9aTx87tZVnsOxYTFXuFdDVYnKFxsLccVXJ
X-Google-Smtp-Source: ABdhPJzOxkBAyOBhxJJ+sAPO4vXOZwfI528CrCPLFAW3pBRsDxSxmYa1omlKwOCNaM9v7icjTZeGCPI1FGn2fnwkSSW4K4St1i4U
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150d:: with SMTP id b13mr6217998jat.101.1639031247133;
 Wed, 08 Dec 2021 22:27:27 -0800 (PST)
Date:   Wed, 08 Dec 2021 22:27:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042e11e05d2b0b39b@google.com>
Subject: [syzbot] INFO: task hung in r871xu_dev_remove
From:   syzbot <syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d598c3c46ea6 Merge 5.16-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14cf0e55b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6df5f09a0b9c823
dashboard link: https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com

INFO: task kworker/0:6:4133 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:6     state:D stack:21848 pid: 4133 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0x931/0x2320 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 unregister_netdev+0xe/0x20 net/core/dev.c:11138
 r871xu_dev_remove+0x24f/0x2c0 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x40b/0x500 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:0/5:
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000005fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88810cd40220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88810cd40220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff888130eb0220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888130eb0220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff888112be81a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff888112be81a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
1 lock held by khungtaskd/25:
 #0: ffffffff87891640 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
6 locks held by kworker/1:2/69:
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900009a7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88810ce9e220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88810ce9e220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff888117a52220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888117a52220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff888117a511a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff888117a511a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
6 locks held by kworker/0:2/704:
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90001f37db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88810cdbe220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88810cdbe220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff888139190220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888139190220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88811292d1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88811292d1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_register_hw+0x1b52/0x3ed0 net/mac80211/main.c:1245
3 locks held by kworker/0:3/1129:
 #0: ffff88810deff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810deff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88810deff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88810deff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88810deff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88810deff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90002c27db0 ((addr_chk_work).work){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0xa/0x20 net/ipv6/addrconf.c:4595
2 locks held by dhcpcd/1205:
 #0: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x1b3/0x1ca0 net/ipv4/devinet.c:1068
 #1: ffff888104fa4de0 (&padapter->mutex_start){+.+.}-{3:3}, at: netdev_open+0x2e/0x6c0 drivers/staging/rtl8712/os_intfs.c:375
2 locks held by getty/1229:
 #0: ffff88810e389098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc900000432e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
3 locks held by udevd/3986:
 #0: ffff88810beedc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
 #0: ffff88810beedc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
 #1: ffff88811696ebd0 (kn->active#49){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
 #1: ffff88811696ebd0 (kn->active#49){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
 #2: ffff888139190220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:765 [inline]
 #2: ffff888139190220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
6 locks held by kworker/1:3/3999:
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90001737db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88810cdd6220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88810cdd6220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff888103bf7220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888103bf7220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff8881151001a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff8881151001a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
6 locks held by kworker/1:4/4010:
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900019c7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88810bab6220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88810bab6220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff88810a4ae220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88810a4ae220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88811d57b1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88811d57b1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
3 locks held by udevd/4012:
 #0: ffff8881158fb488 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
 #0: ffff8881158fb488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
 #1: ffff88813a213cb8 (kn->active#49){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
 #1: ffff88813a213cb8 (kn->active#49){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
 #2: ffff88810a4ae220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:765 [inline]
 #2: ffff88810a4ae220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
3 locks held by udevd/4015:
 #0: ffff8881392a2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
 #0: ffff8881392a2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
 #1: ffff8881051cc748 (kn->active#49){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
 #1: ffff8881051cc748 (kn->active#49){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
 #2: ffff888103bf7220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:765 [inline]
 #2: ffff888103bf7220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
6 locks held by kworker/0:6/4133:
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888107da7938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900028cfdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88810cdba220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88810cdba220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff88811a725220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88811a725220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff88810b5171a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88810b5171a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff88810b5171a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff88810b5171a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
 #5: ffffffff8886a7a8 (rtnl_mutex){+.+.}-{3:3}, at: unregister_netdev+0xe/0x20 net/core/dev.c:11138
2 locks held by kworker/0:7/5061:
 #0: ffff888100066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888100066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888100066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888100066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888100066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888100066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900013dfdb0 ((work_completion)(&rew.rew_work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
3 locks held by udevd/6728:
 #0: ffff88810dadfc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
 #0: ffff88810dadfc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
 #1: ffff88810c392bd0 (kn->active#49){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
 #1: ffff88810c392bd0 (kn->active#49){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
 #2: ffff888130eb0220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:765 [inline]
 #2: ffff888130eb0220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
4 locks held by syz-executor.2/13210:
 #0: ffff88810e8ac438 (sb_writers#4){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:729 [inline]
 #0: ffff88810e8ac438 (sb_writers#4){.+.+}-{0:0}, at: do_vfs_ioctl+0xe36/0x15d0 fs/ioctl.c:843
 #1: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #1: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: vfs_fileattr_set+0x148/0xb70 fs/ioctl.c:685
 #2: ffff88810e8aebd0 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ind_migrate+0x237/0x840 fs/ext4/migrate.c:623
 #3: ffffffff87899f68 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
 #3: ffffffff87899f68 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4fa/0x620 kernel/rcu/tree_exp.h:836
3 locks held by syz-executor.2/13211:
 #0: ffff8881112ead70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:994
 #1: ffff88810e8ac438 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x12d/0x250 fs/read_write.c:643
 #2: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #2: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: ext4_dio_write_iter fs/ext4/file.c:510 [inline]
 #2: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: ext4_file_write_iter+0x375/0x19b0 fs/ext4/file.c:679
1 lock held by syz-executor.2/13212:
 #0: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #0: ffff888131765c40 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: process_measurement+0x17c0/0x1920 security/integrity/ima/ima_main.c:241
3 locks held by syz-executor.5/13215:
 #0: ffff88810e8ac438 (sb_writers#4){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:729 [inline]
 #0: ffff88810e8ac438 (sb_writers#4){.+.+}-{0:0}, at: do_vfs_ioctl+0xe36/0x15d0 fs/ioctl.c:843
 #1: ffff88813146ab30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #1: ffff88813146ab30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: vfs_fileattr_set+0x148/0xb70 fs/ioctl.c:685
 #2: ffff88810e8aebd0 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ind_migrate+0x237/0x840 fs/ext4/migrate.c:623
1 lock held by syz-executor.5/13216:
 #0: ffff88813146ab30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #0: ffff88813146ab30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: process_measurement+0x17c0/0x1920 security/integrity/ima/ima_main.c:241
1 lock held by syz-executor.5/13217:
 #0: ffff88813146ab30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #0: ffff88813146ab30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: process_measurement+0x17c0/0x1920 security/integrity/ima/ima_main.c:241

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 25 Comm: khungtaskd Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x40b/0x500 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 1168 Comm: udevd Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:from_kuid_munged+0x0/0x130 kernel/user_namespace.c:436
Code: 00 48 8b 4c 24 58 65 48 2b 0c 25 28 00 00 00 75 10 48 83 c4 60 5b 5d 41 5c c3 e8 9b bf 32 00 eb c2 e8 84 4f 8e 04 0f 1f 40 00 <41> 54 49 89 fc 55 48 bd 00 00 00 00 00 fc ff df 53 48 83 ec 60 48
RSP: 0018:ffffc90000947ca0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90000947e20 RCX: 0000000000000000
RDX: 1ffff92000128fca RSI: 0000000000000000 RDI: ffffffff877562e0
RBP: 1ffff92000128f95 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff817852a1 R11: 0000000000000000 R12: 00007ffe89e9cf50
R13: ffff888110ce5400 R14: 00007f62917bf75a R15: 0000000000000000
FS:  00007f62915d2840(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f333a5b5008 CR3: 000000010d05b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cp_new_stat+0x1ff/0x5b0 fs/stat.c:364
 __do_sys_newfstatat+0x107/0x120 fs/stat.c:415
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f62917291da
Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 0b 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 69 fc 0c 00 f7
RSP: 002b:00007ffe89e9cf48 EFLAGS: 00000206 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00007f62917f6380 RCX: 00007f62917291da
RDX: 00007ffe89e9cf50 RSI: 00007f62917bf75a RDI: 000000000000000c
RBP: 0000559e56448a60 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000206 R12: 0000559e56448a60
R13: 0000000000000000 R14: 00007ffe89e9d528 R15: 0000000000003fff
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 48 8b             	add    %cl,-0x75(%rax)
   3:	4c 24 58             	rex.WR and $0x58,%al
   6:	65 48 2b 0c 25 28 00 	sub    %gs:0x28,%rcx
   d:	00 00
   f:	75 10                	jne    0x21
  11:	48 83 c4 60          	add    $0x60,%rsp
  15:	5b                   	pop    %rbx
  16:	5d                   	pop    %rbp
  17:	41 5c                	pop    %r12
  19:	c3                   	retq
  1a:	e8 9b bf 32 00       	callq  0x32bfba
  1f:	eb c2                	jmp    0xffffffe3
  21:	e8 84 4f 8e 04       	callq  0x48e4faa
  26:	0f 1f 40 00          	nopl   0x0(%rax)
* 2a:	41 54                	push   %r12 <-- trapping instruction
  2c:	49 89 fc             	mov    %rdi,%r12
  2f:	55                   	push   %rbp
  30:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  37:	fc ff df
  3a:	53                   	push   %rbx
  3b:	48 83 ec 60          	sub    $0x60,%rsp
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
