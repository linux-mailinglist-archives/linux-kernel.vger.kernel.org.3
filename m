Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B7464C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhLALCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhLALCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:02:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D370C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:59:20 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s37so13512332pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=PWWyFFsXpRHL6hxAvW+NFHh+TToRHVZ/QnnfoR4yX7Y=;
        b=G3g/vip680CBXv7uoowdy92Zk/ZRXIxOKbusZfJlY0Lr0H6uoOuoFNSzRsGEbW3Qyb
         Ob3ghc317EoCUFP6ja+KR+BnlX+BR8w5/DocPHiG7FcSJ3Xr3+7yTqqyky6wpqaXkESV
         eF1xleAl0DY+cwttLG1wk2dXBUWeTprLjJEi81YefIeuX8EHeZQl0WDYzy1KxexIWh0h
         Ie2pDd0UUL4LKSMN5bHKLz50JMCrcnrWQzaz0+vXIhEk6G3fWbGf7CfG4G7vMP9zAoRo
         nN9YCmxzDf00Mpe2tbp9OUMbpSVS5g0QmC3DYoBjAgYnrJkO7Bw1sh5Yvnf5WOMN5D8D
         3XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=PWWyFFsXpRHL6hxAvW+NFHh+TToRHVZ/QnnfoR4yX7Y=;
        b=C3s7tq8ehs2fxgGY5MYaDez3pNc9z4vTfMH7sU7F0N27bxD3hAnMxZsqmzFBjH0eeC
         XDFP08ta0OcjB6BDfLWvcJQKtYEGvBzgFXIjCTh1tIZgo9AlVXTAzmPdsqdpOs4mnfkN
         N7DhRH1to9GPwHy0XyQTWh1jk3BzGFoYScCUW7tBdMs78NsM7xzC1TFnLjTzvdvrqsKG
         93nl/ZrgnYbfz7bTCRmBm0kr60HGGXxVZheDjKdNZ0dMMrfxcg8CwerbzGwLRg4Kzn8W
         ZGY6wrGt5kye4DqMjJ/LaTIwQMJiyDoj+zFbLLQ8Y5V9c9jx3JsidzNkYHU5YMPL5Q09
         cg+g==
X-Gm-Message-State: AOAM530gVSE04wkSqfeLFkcB/LbNTeSDgY0m7r1+gNwxRCcoQf++9y1E
        IOwgp/fg4/k7WESOaa0eULk=
X-Google-Smtp-Source: ABdhPJycByYgRyQPvyF+HqSlbW4PQRf4zj4GyW40yHsyBwAa9hkBJnozSSKe1uJ6Yl7lJZEzRWns7g==
X-Received: by 2002:a63:5416:: with SMTP id i22mr4158240pgb.382.1638356359631;
        Wed, 01 Dec 2021 02:59:19 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i185sm23871074pfg.80.2021.12.01.02.59.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:59:19 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: count zram read/write into PSI_IO_WAIT
Date:   Wed,  1 Dec 2021 18:59:01 +0800
Message-Id: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Have zram reading/writing be counted in PSI_IO_WAIT.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/block/zram/zram_drv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf275..b0e4766 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -34,6 +34,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/psi.h>
 
 #include "zram_drv.h"
 
@@ -1246,7 +1247,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 				zram_get_element(zram, index),
 				bio, partial_io);
 	}
-
+#ifdef CONFIG_PSI
+	psi_task_change(current, 0, TSK_IOWAIT);
+#endif
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
 		unsigned long value;
@@ -1257,6 +1260,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		zram_fill_page(mem, PAGE_SIZE, value);
 		kunmap_atomic(mem);
 		zram_slot_unlock(zram, index);
+#ifdef CONFIG_PSI
+		psi_task_change(current, TSK_IOWAIT, 0);
+#endif
 		return 0;
 	}
 
@@ -1284,6 +1290,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	if (WARN_ON(ret))
 		pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
 
+#ifdef CONFIG_PSI
+	psi_task_change(current, TSK_IOWAIT, 0);
+#endif
 	return ret;
 }
 
@@ -1471,7 +1480,13 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		vec.bv_offset = 0;
 	}
 
+#ifdef CONFIG_PSI
+	psi_task_change(current, 0, TSK_IOWAIT);
+#endif
 	ret = __zram_bvec_write(zram, &vec, index, bio);
+#ifdef CONFIG_PSI
+	psi_task_change(current, TSK_IOWAIT, 0);
+#endif
 out:
 	if (is_partial_io(bvec))
 		__free_page(page);
@@ -1607,7 +1622,6 @@ static blk_qc_t zram_submit_bio(struct bio *bio)
 		atomic64_inc(&zram->stats.invalid_io);
 		goto error;
 	}
-
 	__zram_make_request(zram, bio);
 	return BLK_QC_T_NONE;
 
-- 
1.9.1

