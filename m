Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD8477221
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhLPMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhLPMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:47:28 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA34C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:47:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 133so22975259pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZO8o/6nmS/AB/Y+FEyoU4o2a64gHGdYUJrc5cfoUJU=;
        b=dBRurJQMHLxHKQn3s0wzrbMfegHpQInZ2Y2X5coN5rmjuFdfjw+F+EO0X8XzIVHPq1
         0oyGpb6qJvTUzNx6Blu62Qn80wHaUeVXX2fQ9koDZdIxzxal1jqgUAMmrTp4FpBB8+lC
         HhhFQaRsiZg5RCI98t3POHEYuCZbrNI5RR9NZ/nvsrg2aRXWCHosp4cK/v4yHYbDKqE2
         BfNWaGBaDFFq5B70PfMTfdd5+4G/VFByvxJ3fYviHpo+1mK8OhP253zIp2GQLsFd9K7K
         5xf/lQzf1ztcRwn4ubgDIaUrppkUhsDvHEZAw457QCc86ssUcU9B/9K8ZGBiuX8qXe50
         2zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZO8o/6nmS/AB/Y+FEyoU4o2a64gHGdYUJrc5cfoUJU=;
        b=5IQ2Y1q98YH8FxbeiUomB35ndgUB8pGd2NZT1iqXv6L9bK2fd+s3R9taBpSx/TgjUt
         1cefQEU7zoLoKNpVMd93LoC9CEnowuxBdh11iH20Gg/yBfZ/VyAiF9mbokZX1SM8YAtk
         M3WdTLXnuZPYFyKl3u9yAQLeyG+fC5RyhXlWsUmYiMIW+/rui/f2CfjFQWtcZ80s3qlt
         SQqEjx65X6aoxeH7Spdgudv5nw/Y/FK88aPJZkVNOKEnHmTXlYwp3p7b/I/JfeueOJJI
         hcazClPgjsVdy44zxeQMJ1Chn6zdUAmGmBt1wkeTSTOXEmc3f+02xvNPryKKFXqWdI1h
         oVwg==
X-Gm-Message-State: AOAM531pFb+Bh9WK6t0vG0NChwzoxL01JiJS+Fx7s2OBPlcSZE/iIS1R
        GQXUwAQUREXeYpl6ygYP3aTFRA==
X-Google-Smtp-Source: ABdhPJzRLr96USwclRnMtuYoyYf51O2soUQ74CnMn6MZx9+rbSLOwQR2RSEL+P11/DED3hWVzwyh2Q==
X-Received: by 2002:a63:4e5f:: with SMTP id o31mr12052991pgl.384.1639658848300;
        Thu, 16 Dec 2021 04:47:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id h5sm6154309pfi.46.2021.12.16.04.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 04:47:27 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/2] mm: reimplement si_mem_available()
Date:   Thu, 16 Dec 2021 20:46:55 +0800
Message-Id: <20211216124655.32247-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement si_mem_available() by reusing si_mem_available_node().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_alloc.c | 45 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 31f5e3e335cf..0982372c8e49 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5782,46 +5782,15 @@ long si_mem_available_node(struct sysinfo *val, int nid)
 
 long si_mem_available(void)
 {
-	long available;
-	unsigned long pagecache;
-	unsigned long wmark_low = 0;
-	unsigned long pages[NR_LRU_LISTS];
-	unsigned long reclaimable;
-	struct zone *zone;
-	int lru;
-
-	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
-		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
-
-	for_each_zone(zone)
-		wmark_low += low_wmark_pages(zone);
-
-	/*
-	 * Estimate the amount of memory available for userspace allocations,
-	 * without causing swapping.
-	 */
-	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
-
-	/*
-	 * Not all the page cache can be freed, otherwise the system will
-	 * start swapping. Assume at least half of the page cache, or the
-	 * low watermark worth of cache, needs to stay.
-	 */
-	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
-	pagecache -= min(pagecache / 2, wmark_low);
-	available += pagecache;
+	long available = 0;
+	struct sysinfo i;
+	int nid;
 
-	/*
-	 * Part of the reclaimable slab and other kernel memory consists of
-	 * items that are in use, and cannot be freed. Cap this estimate at the
-	 * low watermark.
-	 */
-	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
-		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
-	available += reclaimable - min(reclaimable / 2, wmark_low);
+	for_each_online_node(nid) {
+		si_meminfo_node(&i, nid);
+		available += si_mem_available_node(&i, nid);
+	}
 
-	if (available < 0)
-		available = 0;
 	return available;
 }
 EXPORT_SYMBOL_GPL(si_mem_available);
-- 
2.11.0

