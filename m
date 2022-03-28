Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF64E8F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiC1H6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiC1H6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:58:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66570BC0C;
        Mon, 28 Mar 2022 00:56:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so19093575wrb.8;
        Mon, 28 Mar 2022 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f01AivIh3360B2nN17yejxzdu9EUFim3tIK6GOyJrZ8=;
        b=Dkv4wrZ0WqODJ1zDaWrQ+FIxvgfnD5/7FIedSToNvNomN6cnP4ZBkYozU+RIMOniFV
         zf7h6JLxr4/dSBll9Fatzx9Lk40kb2NRFVRZmnmnuJwoiSx8G+F53g6hIvlDGCbUc3dA
         UV3vGTdKJRI/WgNlf2/FJ5XSjY88UBw2WR3635HAOghW2ZOAU5TdZyNArVeLNzvH8dks
         tjoCJjXqxJbP15V+xn+XBe8HHbywqDg6Nrm8L8KN6N7KhvWsCZYV6RH80hut6AzwefIC
         Qi0t5P9UBKz57q/u52+9xwT0PujcgkykuYdNf/9H2eH+GsrVWkrwUrX1SKPZDAQX/QvJ
         piEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f01AivIh3360B2nN17yejxzdu9EUFim3tIK6GOyJrZ8=;
        b=4WYXOnrw/lCdAXOyBC/zhp7F4Cr6nMVesol2T9ywyB9CVleNf650K7OwGsC5HrSTFL
         V0hSMKGaJHKzFn2E1qEucmfCLxJZ+N3ir/Dhpmq4s4ZuevDF0yIh312n5dzTjd8+SB0k
         +6xZ29oG2nI5S7aZRwNSDaIj2ovqmAtENG070DETvCM4Eu4AKbmWV6EuN9R4rpTzTD00
         T9X6joBn4BENBklV1jAcaStAHocF70fOtvleEZ0Y7TbO8oAJkf6RM30mhQyFxgFADrCN
         MhTS+VHNtuY2J7XKzaH88J6x6/yQSqUg5PHJs1Ils5RQlSESjARRvkfYYQ9HbIwlty5c
         TdpA==
X-Gm-Message-State: AOAM530dhoClijD1Aeey0E/3hZDt3/i2gCdTm1tHCkCscKfM4IJ4KlYT
        te+FM0Yqli0qHddaILdlrrU=
X-Google-Smtp-Source: ABdhPJwg+8ds16kiUqxuMSs1A0jj2OGNiDOtrO17DOllsKT5o7CJkUi6HYBngg/jtg5wNf1E6VpqBA==
X-Received: by 2002:a05:6000:381:b0:205:bf77:79f1 with SMTP id u1-20020a056000038100b00205bf7779f1mr6592500wrf.659.1648454178688;
        Mon, 28 Mar 2022 00:56:18 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm12578791wmp.44.2022.03.28.00.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 00:56:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
Subject: Re: [syzbot] memory leak in blk_mq_init_tags
Date:   Mon, 28 Mar 2022 09:56:14 +0200
Message-ID: <7364962.EvYhyI6sBW@leap>
In-Reply-To: <000000000000c341cc05db38c1b0@google.com>
References: <000000000000c341cc05db38c1b0@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3660900.kQq0lBPeGt"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart3660900.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On domenica 27 marzo 2022 22:08:18 CEST syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6b1f86f8e9c7 Merge tag 'folio-5.18b' of git://git.infradea..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b41dcb700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c6e80763d853259b
> dashboard link: https://syzkaller.appspot.com/bug?extid=f08c77040fa163a75a46
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1564ecb3700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888118503c00 (size 192):
>   comm "kworker/u4:2", pid 52, jiffies 4294961137 (age 11.420s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     02 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff822c042b>] kmalloc_node include/linux/slab.h:602 [inline]
>     [<ffffffff822c042b>] kzalloc_node include/linux/slab.h:728 [inline]
>     [<ffffffff822c042b>] blk_mq_init_tags+0x4b/0xc0 block/blk-mq-tag.c:578
>     [<ffffffff822b6caa>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3169
>     [<ffffffff822bbb86>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3620
>     [<ffffffff822c3437>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
>     [<ffffffff822c3437>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
>     [<ffffffff8229e6f9>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
>     [<ffffffff822c7085>] device_add_disk+0x25/0x510 block/genhd.c:421
>     [<ffffffff82846437>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3551
>     [<ffffffff8270c477>] call_driver_probe drivers/base/dd.c:517 [inline]
>     [<ffffffff8270c477>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
>     [<ffffffff8270c81c>] really_probe drivers/base/dd.c:558 [inline]
>     [<ffffffff8270c81c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
>     [<ffffffff8270c91a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
>     [<ffffffff8270d186>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
>     [<ffffffff827093e7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
>     [<ffffffff8270b9ef>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:931
>     [<ffffffff8127cf94>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
>     [<ffffffff8126b3ef>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
>     [<ffffffff8126bd19>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
> 
> BUG: memory leak
> unreferenced object 0xffff888117fee680 (size 128):
>   comm "kworker/u4:2", pid 52, jiffies 4294961137 (age 11.420s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8240b6be>] kmalloc_array_node include/linux/slab.h:679 [inline]
>     [<ffffffff8240b6be>] kcalloc_node include/linux/slab.h:684 [inline]
>     [<ffffffff8240b6be>] sbitmap_init_node+0xde/0x2d0 lib/sbitmap.c:113
>     [<ffffffff8240b8ec>] sbitmap_queue_init_node+0x3c/0x1f0 lib/sbitmap.c:428
>     [<ffffffff822c0347>] bt_alloc block/blk-mq-tag.c:543 [inline]
>     [<ffffffff822c0347>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
>     [<ffffffff822c0468>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
>     [<ffffffff822b6caa>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3169
>     [<ffffffff822bbb86>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3620
>     [<ffffffff822c3437>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
>     [<ffffffff822c3437>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
>     [<ffffffff8229e6f9>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
>     [<ffffffff822c7085>] device_add_disk+0x25/0x510 block/genhd.c:421
>     [<ffffffff82846437>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3551
>     [<ffffffff8270c477>] call_driver_probe drivers/base/dd.c:517 [inline]
>     [<ffffffff8270c477>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
>     [<ffffffff8270c81c>] really_probe drivers/base/dd.c:558 [inline]
>     [<ffffffff8270c81c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
>     [<ffffffff8270c91a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
>     [<ffffffff8270d186>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
>     [<ffffffff827093e7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
>     [<ffffffff8270b9ef>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:931
> 
> BUG: memory leak
> unreferenced object 0xffff888116df4c00 (size 512):
>   comm "kworker/u4:2", pid 52, jiffies 4294961137 (age 11.420s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     10 4c df 16 81 88 ff ff 10 4c df 16 81 88 ff ff  .L.......L......
>   backtrace:
>     [<ffffffff8240b9b8>] kmalloc_node include/linux/slab.h:602 [inline]
>     [<ffffffff8240b9b8>] kzalloc_node include/linux/slab.h:728 [inline]
>     [<ffffffff8240b9b8>] sbitmap_queue_init_node+0x108/0x1f0 lib/sbitmap.c:438
>     [<ffffffff822c0377>] bt_alloc block/blk-mq-tag.c:543 [inline]
>     [<ffffffff822c0377>] blk_mq_init_bitmaps+0x87/0xf0 block/blk-mq-tag.c:557
>     [<ffffffff822c0468>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
>     [<ffffffff822b6caa>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3169
>     [<ffffffff822bbb86>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3620
>     [<ffffffff822c3437>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
>     [<ffffffff822c3437>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
>     [<ffffffff8229e6f9>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
>     [<ffffffff822c7085>] device_add_disk+0x25/0x510 block/genhd.c:421
>     [<ffffffff82846437>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3551
>     [<ffffffff8270c477>] call_driver_probe drivers/base/dd.c:517 [inline]
>     [<ffffffff8270c477>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
>     [<ffffffff8270c81c>] really_probe drivers/base/dd.c:558 [inline]
>     [<ffffffff8270c81c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
>     [<ffffffff8270c91a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
>     [<ffffffff8270d186>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
>     [<ffffffff827093e7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
>     [<ffffffff8270b9ef>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:931
>     [<ffffffff8127cf94>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
> 
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c341cc05db38c1b0%40google.com.
> 
Oh, now I see that both the failures of device_add() or device_add_disk() 
should make the code to jump to the "out_free_index" label. 
Even if my first change was tested and didn't trigger any issue, I'd like 
to try again with both changes too.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fabio M. De Francesco

--nextPart3660900.kQq0lBPeGt
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..61fcf653ef5a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3434,7 +3434,7 @@ static int sd_probe(struct device *dev)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
-		goto out;
+		goto out_free_index;
 	}
 
 	dev_set_drvdata(dev, sdkp);
@@ -3475,7 +3475,7 @@ static int sd_probe(struct device *dev)
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
 		put_device(&sdkp->disk_dev);
-		goto out;
+		goto out_free_index;
 	}
 
 	if (sdkp->capacity)

--nextPart3660900.kQq0lBPeGt--



