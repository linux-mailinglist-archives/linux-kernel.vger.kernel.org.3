Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F84E8EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiC1HXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiC1HXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:23:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CBF1706A;
        Mon, 28 Mar 2022 00:21:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g22so4698112edz.2;
        Mon, 28 Mar 2022 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9u93oacVo0WHHkBTfuXklapfqlel1OBBUvggiuQ4ZE=;
        b=TGOTnXKUAHCIU+stD2wybSqfdtfoxvgH3A2+xJNSodC0jc+8BvRxwtj5M9TwCuSfFD
         h7Gxsh+qK4FuccKgFkv7RWxygNtbFB3uc+JtkkbbfkEDkBHbLQYcJ1cmVQYpf0ukDtM9
         ykbYu8ztxRjnG+3kus2DH+R/trvdJvbkrxwjTmHiZZP0PEL7Ps17OCIojazwAZ/I2muQ
         XYLmXu2Vvetq3BTgc7Tu+zCJXqFwbfZHD0hqzrCIdQOwc6tb9M5YFVVZTpgRr/xykg+X
         zVslnUaM6ujpCVDEor4QgazueP+anJGjRvo3rcAIQn/PuvMnGUNlj7jaVldAhCn+f+oQ
         P9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9u93oacVo0WHHkBTfuXklapfqlel1OBBUvggiuQ4ZE=;
        b=rYb41kVWvJs9NkSbkFVisnu7yxHfvWOhNyXcpa5/5MjVUXGdzl7uQ5MknynSgZM+z9
         JDwq+yeL2WbCfBi3xOGGlXbXlwzsL92McERu1hbomDs7nilbuYvFqF3kkm9f5aUF8ILC
         IkL9VQ3xoHNFMwaj7DEjfFo701HWVUNgwbFmQfnlhKp3sBr2LYaXDOw52HL/EHjKliz2
         rjupnYvesqE4NjOcjML8i/D/sj5NdnNJBGYhvMXHN7UyPSy0WQt1qNv+xtSjHgt7z1NC
         svbxkz2dCpHvTrPOC/eJLehNmQksm/qzW/H8V4OMYHlqbjBvuIQLfqHf8vlvPrKMTnKQ
         rmsQ==
X-Gm-Message-State: AOAM533Fz8QfyQBb2UI+Ebe61Y/64sxVN6CEW17WpCtXGY9fWrfZJXje
        4FGGj/En0osvNUl3s2WQzD8=
X-Google-Smtp-Source: ABdhPJwp0NDJizEMGzCurWCE3EkvJVdpD/qGorSycoQ524nmUamymlU4x2gOmtdnw2N6IIC4XLpTSQ==
X-Received: by 2002:a05:6402:84b:b0:419:105:f516 with SMTP id b11-20020a056402084b00b004190105f516mr14735753edz.3.1648452108484;
        Mon, 28 Mar 2022 00:21:48 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id gn33-20020a1709070d2100b006dfcce8be86sm5595208ejc.225.2022.03.28.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 00:21:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
Subject: Re: [syzbot] memory leak in blk_mq_init_tags
Date:   Mon, 28 Mar 2022 09:21:38 +0200
Message-ID: <12985729.uLZWGnKmhe@leap>
In-Reply-To: <000000000000c341cc05db38c1b0@google.com>
References: <000000000000c341cc05db38c1b0@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2823658.e9J7NaK4W3"
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

--nextPart2823658.e9J7NaK4W3
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
I think that, if device_add_disk() fails, the code should jump to the 
"out_free_index" label. 

Let's try if my argument is correct...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fabio

--nextPart2823658.e9J7NaK4W3
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..cd310eb406bb 100644
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

--nextPart2823658.e9J7NaK4W3--



