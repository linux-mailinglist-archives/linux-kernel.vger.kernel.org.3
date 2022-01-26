Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0F49C728
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiAZKL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiAZKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:11:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94741C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:11:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c7-20020a25a2c7000000b00613e4dbaf97so43235355ybn.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3ao5SEtR1nv4TevYgqWzJAQJIpCFZnovOjTeqxptCiI=;
        b=nKL1RLKrnPjz1hKxYNDPT4GEvheUHYDOMS4Ahn8hJr/RRulI2CLOl4pQHpxk9QJbuV
         pz9Wtp/FOvzRMoSp/gToPLGg8/HMaV2EwtALymbQtn+pSfknLohXS1rMMHqof84eLR6I
         47dlK5Cqhgf0MxMtAgMyPc5XV4R9ubV7JI4LVK1+xCK9lNMX6FBK+BC7sP43ARSvl4Os
         cvDCrwvm2XHB/rkRNsvCh/xvCe1Xr0bg7nTyIcXU65u6iLeKH0b86u9kMge2VMkd6tPf
         lVmbeer4PtbjbY4qYDa3TvHjw71uSHDh96d3W4Iq5sKqKFeI2dRe8c8qjh5s+WPQSdAu
         Op3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3ao5SEtR1nv4TevYgqWzJAQJIpCFZnovOjTeqxptCiI=;
        b=BiBv1vvn47EhiF3XjoLros28UzTJz5dQ3KqfO/d3Q6imRpqIuyALj3FMPFTAbA+IbG
         ysYDG1RG07dBEw2qHNrosEZwz/xAd1whN3IWPZhUBgcKyY5+xTt3tRSxHiY9Fa++cavT
         nHdPh9gOd3M5g1Z72DtnexVT3l2D/SRFQty/xwM2pB5ls8ZgFtERJZ3b+cdcbSL/38x8
         vf/dlqFQDYM8HrdkEQGqsKCH/vP8WAWhrEtiuEILticfN8OauaZJPxpIOdL938EkQcBZ
         nkmjItjsgE0tcO5D7aMmrl4Zorln0UNMrrauUaJs3DzlvAxbOhhTd/iU4ndbQ507SxD8
         tX5A==
X-Gm-Message-State: AOAM532guXCDEkV236a88hv9Evh+0LVdTBv2640sDgQAoEejHSpbNG+k
        YRuhRyepKzGQsWGu3LNzC3mUi6uOoKcl0GNgX/98xkhjl7kSKO5AzT2yuId7nyld2tepK969iot
        pJHnfP1n2GqdqVMSup1GHiozdVza5fxoDB6/6QGI9YceIMF0YJpUMFmA2aC3Z3qn7EYw=
X-Google-Smtp-Source: ABdhPJx/OhZsWBnrnLmzhxFoSP4v+P1+pbJI5xfhrlpcyaNLSw3ysYxS8h2sCo6IFHReSSR/gpDE5pToEw==
X-Received: from decot.svl.corp.google.com ([2620:15c:2c5:11:bb79:635d:80b2:3c02])
 (user=decot job=sendgmr) by 2002:a81:db08:0:b0:2ca:287c:6c28 with SMTP id
 00721157ae682-2ca287c6e78mr6888267b3.205.1643191884223; Wed, 26 Jan 2022
 02:11:24 -0800 (PST)
Date:   Wed, 26 Jan 2022 02:11:20 -0800
Message-Id: <20220126101120.676021-1-decot+git@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH RFC v3 1/1] mtd_blkdevs: avoid soft lockups with some mtd/spi devices
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
enough breathing room to avoid those incorrectly detected netdev
timeouts for example.

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

