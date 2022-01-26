Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E873A49C630
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiAZJVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiAZJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:21:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:21:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so46865760ybp.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=llHbn1bCthF6Z52ZLAXsC7nxbrzb3NZCqXe+nafQFPI=;
        b=YJarqyabni/dIxOZIIiuXNkf7B/nbShnT5gY+P+KdkJK/Ekvtb9L+9Ps3N09OqLi6N
         6oLEwUJ4RQvI/LrknnY/YhTFLfKGDQoBZPdr7nB2PokX5yLAGtzS7IpPqPSJvwwefHtx
         8a5vBngTOLzCuaXe3QRU0vqiTx2mXFU5SafhIyOzmfBza+2BOFUbZ8WJYZ85DmP5PL9D
         Xf/vZMwwRnEkzK1lqF7ClbTZEVgchSYSgBL23OQVwsmucOvEeVMYqis2vDc+Qtc6nnjI
         6bwjYTiLxj+5JQ1TGz31W7mgcDN4hxpK0f2HqsX5teKZ44u3TQtjeS49vvUKW16egfDK
         SGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=llHbn1bCthF6Z52ZLAXsC7nxbrzb3NZCqXe+nafQFPI=;
        b=MSBAhoo59+Ib4HHIv+ssblNYoOVt+/Jpvaif/WFaPNtaciiZy3YyW84ETdBAWozbqh
         VWg7dQCTUHBa0scxwssU2mHvK5JDwytOldec6B4acCmgvERAIc9KrooVKGUAlJ30TZ35
         nAgUrC2bLDtkw/0wv7VA6vnF85jibdd4yCjeaavkDF5uFXHBdhPGVdQng/f6RCQRYpcn
         a59a/gsgQEbJw3DGCTtvonSgpmlj8UGn6S4HvVi+OxUqvkcNJ136nDESiIPt5KbAzB27
         EPW0n5KSdnVmFNYZusmrFOIiH3dpx4QTbRVd9Z5WPmPZXqXAZRuV75sgKXovGZeo52k6
         rOxQ==
X-Gm-Message-State: AOAM530oVR/t1UKpiAk/6GO3+WM9Ts2CYNyfxkKDhkvmiSLYeCfodj9Q
        OyPSYllN4YOm7QToDxKewXQz9+cz8ToXXS1FY5Brg82/etfpjqiGU28P2wWcc0/ouGt4FNmOcZy
        nqM8C7AhS0W97AnigKtM+mvvP8r174Cq/0C64fqb19YcF7GXmseBnIpMgL71fwQVrvls=
X-Google-Smtp-Source: ABdhPJy5cIj9gJub06TRdlfStLRikThiyANu4V65E/fRxgKo173xbsOf+6RQbuMp5juKe6s2C2lhmawYvw==
X-Received: from decot.svl.corp.google.com ([2620:15c:2c5:11:bb79:635d:80b2:3c02])
 (user=decot job=sendgmr) by 2002:a25:6152:: with SMTP id v79mr32538034ybb.685.1643188898430;
 Wed, 26 Jan 2022 01:21:38 -0800 (PST)
Date:   Wed, 26 Jan 2022 01:21:34 -0800
Message-Id: <20220126092134.579618-1-decot+git@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH RFC v2 1/1] mtd_blkdevs: avoid soft lockups with some mtd/spi devices
From:   David Decotigny <decot+git@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        David Decotigny <ddecotig@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Decotigny <ddecotig@google.com>

With some spi devices, the heavy cpu usage due to polling the spi
registers may lead to netdev timeouts, RCU complaints, etc. This can
be acute in the absence of CONFIG_PREEMPT. This patch allows to give
enough breathing room to avoid those false positives.

Example splat on 5.10.92:
[  828.399306] rcu: INFO: rcu_sched self-detected stall on CPU
...
[  828.419245] Task dump for CPU 1:
[  828.422465] task:kworker/1:1H    state:R  running task on cpu   1   stack:    0 pid:   76 ppid:     2 flags:0x0000002a
[  828.433132] Workqueue: kblockd blk_mq_run_work_fn
[  828.437820] Call trace:
...
[  828.512267]  spi_mem_exec_op+0x4d0/0xde0
[  828.516184]  spi_mem_dirmap_read+0x180/0x39c
[  828.520443]  spi_nor_read_data+0x428/0x7e8
[  828.524523]  spi_nor_read+0x154/0x214
[  828.528172]  mtd_read_oob+0x440/0x714
[  828.531815]  mtd_read+0xac/0x120
[  828.535030]  mtdblock_readsect+0x178/0x230
[  828.539102]  mtd_blktrans_work+0x9fc/0xf28
[  828.543177]  mtd_queue_rq+0x1ac/0x2e4
[  828.546827]  blk_mq_dispatch_rq_list+0x2cc/0xa44
[  828.551419]  blk_mq_do_dispatch_sched+0xb0/0x7cc
[  828.556010]  __blk_mq_sched_dispatch_requests+0x350/0x494
[  828.561372]  blk_mq_sched_dispatch_requests+0xac/0xe4
[  828.566387]  __blk_mq_run_hw_queue+0x130/0x254
[  828.570806]  blk_mq_run_work_fn+0x50/0x60
[  828.574814]  process_one_work+0x578/0xf1c
[  828.578814]  worker_thread+0x5dc/0xea0
[  828.582547]  kthread+0x270/0x2d4
[  828.585765]  ret_from_fork+0x10/0x30


Signed-off-by: David Decotigny <ddecotig@google.com>
---
 drivers/mtd/mtd_blkdevs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 243f28a3206b4..64d2b093f114b 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -158,6 +158,7 @@ static void mtd_blktrans_work(struct mtd_blktrans_dev *dev)
 		}
 
 		background_done = 0;
+		cond_resched();
 		spin_lock_irq(&dev->queue_lock);
 	}
 }
-- 
2.35.0.rc0.227.g00780c9af4-goog

