Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E775A4808B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhL1LKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:10:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:52861 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhL1LKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:10:06 -0500
Received: by mail-io1-f69.google.com with SMTP id k12-20020a0566022a4c00b005ebe737d989so7986437iov.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JqI0B5z7CbQsl0vWIdhJmDHFtjL+iTSIPaZY9OyI7hg=;
        b=kodILBmjDH9OJkrhccZn0+wiHXZgLoLhH1dL9kXkwHdFzp60rDdgTUYngzRptWtejj
         HiR2DhW80GUUzzqHzh13Oy1Z/oCAN8kfDidldLsZPQTcdJBZZtjjOtvIb+0lmI6Na8P9
         DNOYr3vcSvQWgmXDaRI5xU3VBhsgEtMfrMl9y9mlFmxCBCjw4TvjA9vsAetAdaISfZOe
         JF87+ohFr7tI3MXlW19WAOdbk9HFvxnnL1MiEeNte6Qof2V6KXpQELM1rxKFeoupBIDE
         MeV90kzfpbdaThMkgjCpp4S2XgzWNn+Q8L8BGzdYbB8taiFzWkA0azx7HBvfd5n98Lhk
         3ZNw==
X-Gm-Message-State: AOAM533oC4NBLaMAvi+wcicyRMCPfQUFOJcBTNe5AflP2GCeT6k0y0dk
        syOsXjw7gAFvz/qk5x+adLKeDPnZYYlcvNDfbLa+dlxjA6nl
X-Google-Smtp-Source: ABdhPJxnl+P/DjVvnxaJeg8m0DEocNyS94SbqAjAh7WblX5GSOzwuIgBN9YjbymhwGTi5IZts/zZB0La3bxR7WIoLgoG1+v93TiJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:: with SMTP id i2mr6753813ilm.95.1640689805979;
 Tue, 28 Dec 2021 03:10:05 -0800 (PST)
Date:   Tue, 28 Dec 2021 03:10:05 -0800
In-Reply-To: <f1164c41-c262-0413-dd2f-cded7510b8b6@wanadoo.fr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012758405d432dd36@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in alauda_check_media
From:   syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, glider@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in scsi_mode_sense

sd 2:0:0:0: [sdd] 0 512-byte logical blocks: (0 B/0 B)
sd 2:0:0:0: [sdd] 0-byte physical blocks
=====================================================
BUG: KMSAN: uninit-value in scsi_mode_sense+0x1046/0x16d0 drivers/scsi/scsi_lib.c:2200
 scsi_mode_sense+0x1046/0x16d0 drivers/scsi/scsi_lib.c:2200
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in set_disk_ro+0x2ab/0x310 block/genhd.c:1413
 set_disk_ro+0x2ab/0x310 block/genhd.c:1413
 sd_read_write_protect_flag drivers/scsi/sd.c:2712 [inline]
 sd_revalidate_disk+0x5697/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 scsi_mode_sense+0x1656/0x16d0
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:638 [inline]
BUG: KMSAN: uninit-value in string+0x4ec/0x6f0 lib/vsprintf.c:720
 string_nocheck lib/vsprintf.c:638 [inline]
 string+0x4ec/0x6f0 lib/vsprintf.c:720
 vsnprintf+0x2222/0x3650 lib/vsprintf.c:2805
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2714 [inline]
 sd_revalidate_disk+0x597c/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 sd_read_write_protect_flag drivers/scsi/sd.c:2711 [inline]
 sd_revalidate_disk+0x5b19/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 scsi_mode_sense+0x1656/0x16d0
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:638 [inline]
BUG: KMSAN: uninit-value in string+0x4ec/0x6f0 lib/vsprintf.c:720
 string_nocheck lib/vsprintf.c:638 [inline]
 string+0x4ec/0x6f0 lib/vsprintf.c:720
 vsnprintf+0x2222/0x3650 lib/vsprintf.c:2805
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2714 [inline]
 sd_revalidate_disk+0x597c/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 sd_read_write_protect_flag drivers/scsi/sd.c:2711 [inline]
 sd_revalidate_disk+0x5b19/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 scsi_mode_sense+0x1656/0x16d0
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:638 [inline]
BUG: KMSAN: uninit-value in string+0x4ec/0x6f0 lib/vsprintf.c:720
 string_nocheck lib/vsprintf.c:638 [inline]
 string+0x4ec/0x6f0 lib/vsprintf.c:720
 vsnprintf+0x2222/0x3650 lib/vsprintf.c:2805
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2714 [inline]
 sd_revalidate_disk+0x597c/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 sd_read_write_protect_flag drivers/scsi/sd.c:2711 [inline]
 sd_revalidate_disk+0x5b19/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 scsi_mode_sense+0x1656/0x16d0
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:638 [inline]
BUG: KMSAN: uninit-value in string+0x4ec/0x6f0 lib/vsprintf.c:720
 string_nocheck lib/vsprintf.c:638 [inline]
 string+0x4ec/0x6f0 lib/vsprintf.c:720
 vsnprintf+0x2222/0x3650 lib/vsprintf.c:2805
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2714 [inline]
 sd_revalidate_disk+0x597c/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 sd_read_write_protect_flag drivers/scsi/sd.c:2711 [inline]
 sd_revalidate_disk+0x5b19/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 scsi_mode_sense+0x1656/0x16d0
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
sd 2:0:0:0: [sdd] Write Protect is off
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x962/0xa40 lib/vsprintf.c:1182
 hex_string+0x962/0xa40 lib/vsprintf.c:1182
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x962/0xa40 lib/vsprintf.c:1182
 hex_string+0x962/0xa40 lib/vsprintf.c:1182
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x962/0xa40 lib/vsprintf.c:1182
 hex_string+0x962/0xa40 lib/vsprintf.c:1182
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 hex_string+0x92b/0xa40 lib/vsprintf.c:1179
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in hex_string+0x962/0xa40 lib/vsprintf.c:1182
 hex_string+0x962/0xa40 lib/vsprintf.c:1182
 pointer+0x3ae/0x2060 lib/vsprintf.c:2407
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2809
 vscnprintf+0xbe/0x1c0 lib/vsprintf.c:2908
 sdev_prefix_printk+0x4b9/0x5a0 drivers/scsi/scsi_logging.c:73
 sd_read_write_protect_flag drivers/scsi/sd.c:2716 [inline]
 sd_revalidate_disk+0x5afc/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 memcpy_from_page include/linux/highmem.h:346 [inline]
 memcpy_from_bvec include/linux/bvec.h:207 [inline]
 bio_copy_kern_endio_read+0x4a3/0x620 block/blk-map.c:403
 bio_endio+0xa7f/0xac0 block/bio.c:1491
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x1129/0x22d0 block/blk-mq.c:742
 blk_mq_end_request block/blk-mq.c:821 [inline]
 blk_mq_dispatch_rq_list+0x16f8/0x3f50 block/blk-mq.c:1685
 __blk_mq_sched_dispatch_requests+0x58b/0x8d0 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x1b9/0x380 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0x201/0x350 block/blk-mq.c:1785
 __blk_mq_delay_run_hw_queue+0x21d/0x970 block/blk-mq.c:1862
 blk_mq_run_hw_queue+0x57c/0x7b0 block/blk-mq.c:1915
 blk_mq_sched_insert_request+0x3b8/0x790 block/blk-mq-sched.c:477
 blk_execute_rq_nowait block/blk-exec.c:62 [inline]
 blk_execute_rq+0x406/0x7c0 block/blk-exec.c:102
 __scsi_execute+0x84d/0xe30 drivers/scsi/scsi_lib.c:244
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x813/0x1400 block/blk-map.c:640
 __scsi_execute+0x4bd/0xe30 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 scsi_mode_sense+0x737/0x16d0 drivers/scsi/scsi_lib.c:2163
 sd_revalidate_disk+0x5206/0xdfd0 drivers/scsi/sd.c:3328
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

CPU: 0 PID: 51 Comm: kworker/u4:2 Tainted: G    B             5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
=====================================================
=====================================================
BUG: KMSAN: uninit-value in scsi_mode_sense+0x1046/0x16d0 drivers/scsi/scsi_lib.c:2200
 scsi_mode_sense+0x1046/0x16d0 drivers/scsi/scsi_lib.c:2200
 sd_do_mode_sense drivers/scsi/sd.c:2657 [inline]
 sd_read_cache_type drivers/scsi/sd.c:2765 [inline]
 sd_revalidate_disk+0x6225/0xdfd0 drivers/scsi/sd.c:3329
 sd_probe+0x10a7/0x1970 drivers/scsi/sd.c:3567
 really_probe+0x67d/0x1510 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:751
 driver_probe_device drivers/base/dd.c:781 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:898
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach_async_helper+0x314/0x3e0 drivers/base/dd.c:927
 async_run_entry_fn+0xd2/0x630 kernel/async.c:127
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthre

Tested on:

commit:         81c325bb kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1736b3dbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3911d4873b88c8
dashboard link: https://syzkaller.appspot.com/bug?extid=e7d46eb426883fb97efd
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1436c22db00000

