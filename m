Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4464F09FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354924AbiDCNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDCNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:40:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC160101
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:38:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id b15-20020a05660214cf00b00648a910b964so4714841iow.19
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 06:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jRiN7vFWUg7EVsgEtKjNWgX5el9xUaFmICxGrQuUQ7o=;
        b=Q027bsqy4mwABeC9fO0LbBH1GvTnsg0nrxVpZM1qogtsOQiupTQzvG3EewUUjTC7i8
         Srvsq425cu6ynqmFT4+XtI9sns+Bg4CPaCvN0tcdZHv3NRcs5w+pHZTfg5k+hwupcxJZ
         45FQrDpij8CtbZJaNOiMhUg57d+Tvc9odQhEm4MnTKE/EEqBJ2U3b8iWXssYb9vqkR7d
         +K+GdjTnA5UYVUjCZTf/55CzwxQjWSk1oWKxx9kszLddPCzuOQ2r4T50r8zTjM8QbIiC
         JLsEZy5blTK8N3Etuq5BnsaYhj/v52ndu1ODObuI8KJ4tHZ5M6X8MOHpzPem5hS5mcHs
         Crrg==
X-Gm-Message-State: AOAM5329zJb3NIoRUKiPF20yhdKw6DOzYeigYD20Cb6ofRHrRi8EZ32D
        M1gQDmpO2mjODcjF7ieX8+rwu9nHsTwEWc5J1P+rWenz/hAt
X-Google-Smtp-Source: ABdhPJwgecakUOLPyO/0zjZDahmyr2pj4SH1iIdZaG7UUZhi+5HDGMeRoqqCxJ4L0khIqKSnOn/DMiy4UGoN8qekscRX9SjfxB49
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2512:b0:323:e54d:711 with SMTP id
 v18-20020a056638251200b00323e54d0711mr877337jat.132.1648993102235; Sun, 03
 Apr 2022 06:38:22 -0700 (PDT)
Date:   Sun, 03 Apr 2022 06:38:22 -0700
In-Reply-To: <000000000000c341cc05db38c1b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000188c9705dbc020de@google.com>
Subject: Re: [syzbot] memory leak in blk_mq_init_tags
From:   syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dan.carpenter@oracle.com, fmdefrancesco@gmail.com,
        haowenchao@huawei.com, hch@infradead.org, jejb@linux.ibm.com,
        linfeilong@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
        wubo40@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    be2d3ecedd99 Merge tag 'perf-tools-for-v5.18-2022-04-02' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c30c5f700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58ae7615fea18863
dashboard link: https://syzkaller.appspot.com/bug?extid=f08c77040fa163a75a46
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aff7e7700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1195476b700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810dbc1240 (size 192):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 17.570s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    02 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff822c3f2b>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff822c3f2b>] kzalloc_node include/linux/slab.h:725 [inline]
    [<ffffffff822c3f2b>] blk_mq_init_tags+0x4b/0xc0 block/blk-mq-tag.c:578
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826fc6bf>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:927
    [<ffffffff8127ce74>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b28f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff8126bbb9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436

BUG: memory leak
unreferenced object 0xffff888109d6da00 (size 128):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 17.570s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814a70de>] kmalloc_node include/linux/slab.h:604 [inline]
    [<ffffffff814a70de>] kvmalloc_node+0x3e/0x130 mm/util.c:580
    [<ffffffff8240fbee>] kvzalloc_node include/linux/slab.h:735 [inline]
    [<ffffffff8240fbee>] sbitmap_init_node+0xde/0x2d0 lib/sbitmap.c:113
    [<ffffffff8241045c>] sbitmap_queue_init_node+0x3c/0x1f0 lib/sbitmap.c:428
    [<ffffffff822c3e47>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c3e47>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c3f68>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427

BUG: memory leak
unreferenced object 0xffff88810c0e1600 (size 512):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 17.570s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 16 0e 0c 81 88 ff ff 10 16 0e 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff82410528>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff82410528>] kzalloc_node include/linux/slab.h:725 [inline]
    [<ffffffff82410528>] sbitmap_queue_init_node+0x108/0x1f0 lib/sbitmap.c:438
    [<ffffffff822c3e47>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c3e47>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c3f68>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826fc6bf>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:927
    [<ffffffff8127ce74>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127

BUG: memory leak
unreferenced object 0xffff88810dbc1240 (size 192):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 20.380s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    02 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff822c3f2b>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff822c3f2b>] kzalloc_node include/linux/slab.h:725 [inline]
    [<ffffffff822c3f2b>] blk_mq_init_tags+0x4b/0xc0 block/blk-mq-tag.c:578
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826fc6bf>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:927
    [<ffffffff8127ce74>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b28f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff8126bbb9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436

BUG: memory leak
unreferenced object 0xffff888109d6da00 (size 128):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 20.380s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814a70de>] kmalloc_node include/linux/slab.h:604 [inline]
    [<ffffffff814a70de>] kvmalloc_node+0x3e/0x130 mm/util.c:580
    [<ffffffff8240fbee>] kvzalloc_node include/linux/slab.h:735 [inline]
    [<ffffffff8240fbee>] sbitmap_init_node+0xde/0x2d0 lib/sbitmap.c:113
    [<ffffffff8241045c>] sbitmap_queue_init_node+0x3c/0x1f0 lib/sbitmap.c:428
    [<ffffffff822c3e47>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c3e47>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c3f68>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427

BUG: memory leak
unreferenced object 0xffff88810c0e1600 (size 512):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 20.380s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 16 0e 0c 81 88 ff ff 10 16 0e 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff82410528>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff82410528>] kzalloc_node include/linux/slab.h:725 [inline]
    [<ffffffff82410528>] sbitmap_queue_init_node+0x108/0x1f0 lib/sbitmap.c:438
    [<ffffffff822c3e47>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c3e47>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c3f68>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826fc6bf>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:927
    [<ffffffff8127ce74>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127

BUG: memory leak
unreferenced object 0xffff88810dbc1240 (size 192):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 21.330s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    02 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff822c3f2b>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff822c3f2b>] kzalloc_node include/linux/slab.h:725 [inline]
    [<ffffffff822c3f2b>] blk_mq_init_tags+0x4b/0xc0 block/blk-mq-tag.c:578
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826fc6bf>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:927
    [<ffffffff8127ce74>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b28f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2289
    [<ffffffff8126bbb9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436

BUG: memory leak
unreferenced object 0xffff888109d6da00 (size 128):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 21.330s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814a70de>] kmalloc_node include/linux/slab.h:604 [inline]
    [<ffffffff814a70de>] kvmalloc_node+0x3e/0x130 mm/util.c:580
    [<ffffffff8240fbee>] kvzalloc_node include/linux/slab.h:735 [inline]
    [<ffffffff8240fbee>] sbitmap_init_node+0xde/0x2d0 lib/sbitmap.c:113
    [<ffffffff8241045c>] sbitmap_queue_init_node+0x3c/0x1f0 lib/sbitmap.c:428
    [<ffffffff822c3e47>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c3e47>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c3f68>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427

BUG: memory leak
unreferenced object 0xffff88810c0e1600 (size 512):
  comm "kworker/u4:2", pid 53, jiffies 4294997418 (age 21.330s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 16 0e 0c 81 88 ff ff 10 16 0e 0c 81 88 ff ff  ................
  backtrace:
    [<ffffffff82410528>] kmalloc_node include/linux/slab.h:599 [inline]
    [<ffffffff82410528>] kzalloc_node include/linux/slab.h:725 [inline]
    [<ffffffff82410528>] sbitmap_queue_init_node+0x108/0x1f0 lib/sbitmap.c:438
    [<ffffffff822c3e47>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c3e47>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c3f68>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822ba7ba>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3168
    [<ffffffff822bf686>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3619
    [<ffffffff822c6f37>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c6f37>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff822a2f69>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822cabad>] device_add_disk+0x4d/0x520 block/genhd.c:425
    [<ffffffff82833357>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3475
    [<ffffffff826fce97>] call_driver_probe drivers/base/dd.c:541 [inline]
    [<ffffffff826fce97>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:620
    [<ffffffff826fd1cc>] really_probe drivers/base/dd.c:582 [inline]
    [<ffffffff826fd1cc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826fd2ca>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff826fdb36>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff826fa037>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826fc6bf>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:927
    [<ffffffff8127ce74>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
executing program
executing program
executing program
executing program
executing program
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory

