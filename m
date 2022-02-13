Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1354B3A67
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 09:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiBMI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 03:59:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiBMI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 03:59:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D5E5BD22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 00:59:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u12so8176557plf.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoLnLmwWYp7QfBYAWK5b5Cp51pkHIzFUCltaNPl/5dE=;
        b=hf4PcF0NQZ8Lhyj/tv/u/wA2GcYd+VmlZBbsITtwSqYK+1i4VeqtlddkXPKleJL3zZ
         H4l9eSwFvA0c9f+YCI1s0UXpuXmnay5K/6gPYfpiY6Ag64kz2AEdQ48c9QhAV5eq8T7W
         Db3QZ5l11BF1kQXPQPePpyubeI6/32ImD+wO9yvWXhiSuDzJ462Z4kXCh3PDKvPTOAJN
         suoIMxjkkJ+85fuAujCaga0KAxp84jayWRcJMM/7vS+nFeQA3WKJhaseecvSBEycHzVW
         yONdVoOpvC1lZcN8CSuk7U1XAL59WBvJlIQvoADPpjgOkvDJBc8w1rO5AzQaXR8aOW2e
         oUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoLnLmwWYp7QfBYAWK5b5Cp51pkHIzFUCltaNPl/5dE=;
        b=sDMkX0QVSZMyu+F+mCMlcFs72bPcVI+mwu/pFjIsr6SUY4YiZbWamzuVkvn5XvRmeJ
         9wdaFB9qnDKg9QJ9xhrZjaWFKDEfh3YdfoO7gkAsNDqjrrAx8TdTEpIeCqKPRdd8w33D
         9g+73jmUQNBKDBiczzd8RCBtgMtR4eWdy0qBuHese37/5g9J6b/EcoeU8lBJkFk7QChz
         FpF5dVUXcmAQiAKq2haSRo7o1WQgKJLoq6jjm6oF6XIzWoB8nsyBxO4G547whRY95Dlu
         bzj79+wnnXQj8vYWtYMBU2MP9OVIcaxei+0Y+N+Ea6vRScVqMJEgSQf/oUg4p5C2kvdy
         keqw==
X-Gm-Message-State: AOAM530aXWJiLjKCpUqUhoM9NOLAbt5UWYDp2IbU25+ID5aFunXPhPM1
        f9ijWaN3KEpMAoCBDPIHnoL0+g==
X-Google-Smtp-Source: ABdhPJxoIe3hHd7C5egzt9G7zsVILbK+R7nakrHw9ghuIRfoYfZHIR1GxOCJYwtrn9vVBuzi32GL8A==
X-Received: by 2002:a17:902:7489:: with SMTP id h9mr8987928pll.8.1644742753779;
        Sun, 13 Feb 2022 00:59:13 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e62:a940:a829:bd2c:4db4:c6fa])
        by smtp.gmail.com with ESMTPSA id w11sm32593143pfu.50.2022.02.13.00.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 00:59:13 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk, boris@bur.io
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-cgroup: set blkg iostat after percpu stat aggregation
Date:   Sun, 13 Feb 2022 16:59:02 +0800
Message-Id: <20220213085902.88884-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't need to do blkg_iostat_set for top blkg iostat on each CPU,
so move it after percpu stat aggregation.

Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup
io.stat")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-cgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 650f7e27989f..87a1c0c3fa40 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -857,11 +857,11 @@ static void blkcg_fill_root_iostats(void)
 			blk_queue_root_blkg(bdev_get_queue(bdev));
 		struct blkg_iostat tmp;
 		int cpu;
+		unsigned long flags;
 
 		memset(&tmp, 0, sizeof(tmp));
 		for_each_possible_cpu(cpu) {
 			struct disk_stats *cpu_dkstats;
-			unsigned long flags;
 
 			cpu_dkstats = per_cpu_ptr(bdev->bd_stats, cpu);
 			tmp.ios[BLKG_IOSTAT_READ] +=
@@ -877,11 +877,11 @@ static void blkcg_fill_root_iostats(void)
 				cpu_dkstats->sectors[STAT_WRITE] << 9;
 			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
-
-			flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
-			blkg_iostat_set(&blkg->iostat.cur, &tmp);
-			u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 		}
+
+		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+		blkg_iostat_set(&blkg->iostat.cur, &tmp);
+		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 	}
 }
 
-- 
2.20.1

