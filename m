Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90051477220
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhLPMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhLPMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:47:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:47:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w24so6665753ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfj7Kw86wjF8KFyGsU//Y0rYlbxDXy3uM86gSdDXCRc=;
        b=z4AuqZxeVcb6wpYtFUqTMzD8/Affkzes9JAYGT/nT5HhTPYyc/O4sFAlblyYyNFaST
         oM/8NTASwc8c9EVWRK1RJEgwMorXCMOkDewYomMT9Nev/URBm0UafCIt0/HJ/noHPcCb
         HBTnfPD47dS9KAnjpGmuC8yf9TtChIqNnPeBfAtR6xzC3QXfkQl5Fic4lk0iXWQoSZ2r
         M525FXywCEUTO/gxIA1UvXgyQr0QLEE+GQ4Mr7jlbZhEgRRM2KkkPbVaDIuH7fE+fwa+
         6A8SHHDKOq/cKCb9q1Qkfqr0qQeC4iqGhcosz/L97XQwjhNeg2ZkcPL/0zxChfuK3Pu8
         +fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfj7Kw86wjF8KFyGsU//Y0rYlbxDXy3uM86gSdDXCRc=;
        b=yBbemYOgRFp4NqsZjLDyvGaME66hd7Xjg+jUr7MDyWOT3rAAW34XcIgy9DZC3TW1uM
         CUoLAJDOHRPRPkeZ6HQpjov8HZ6isgJw+uaW/d3W2dwCkEg0jujyu15moPo3gYm9a/Ed
         /YyPxsivd5LNDhyQnC/lAt+HA5A8DegzxermeOelyjjg2DKm/+yNdEvGSuBYDFFq50Og
         0xecdkPZJEFZfEWU7nQddevnkj3kwtxBGYUBJ4IDoK7fwkFzkH+HSrf/seg8+kSzphsB
         C4osjBeHIlbOiIAYBXS0efKzyz432R/coLSzgBSe19woJwtA+7N0nn8TM1/K6GOnx5Ch
         9l+g==
X-Gm-Message-State: AOAM532qyXTG+kgNs2xfv6RXzokdT/5NvAKFh1rTgmQDDZtKn6y5xX6b
        82WCBvOXUs1Yo+SdIoqDBChFR5AoNcoM/g==
X-Google-Smtp-Source: ABdhPJwN2cf7IIDD1vBgv5C1ViFvLyzDyqrB2+lCRC37Bx2UckD74xWpFwTQXIULPGSp8+h4CxVK+w==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr5973230pjq.20.1639658841369;
        Thu, 16 Dec 2021 04:47:21 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id h5sm6154309pfi.46.2021.12.16.04.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 04:47:21 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/2] mm: add MemAvailable to per-node meminfo
Date:   Thu, 16 Dec 2021 20:46:54 +0800
Message-Id: <20211216124655.32247-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In /proc/meminfo, we can show the sum of all the available memory
as "MemAvailable". Add the same counter also to per-node meminfo
under /sys.

With this counter, some processes that bind nodes can make some
decisions by reading the "MemAvailable" of the corresponding nodes
directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/base/node.c    |  4 ++++
 include/linux/mm.h     |  1 +
 include/linux/mmzone.h |  5 +++++
 mm/page_alloc.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 87acc47e8951..deb2a7965ae4 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -375,8 +375,10 @@ static ssize_t node_read_meminfo(struct device *dev,
 	struct sysinfo i;
 	unsigned long sreclaimable, sunreclaimable;
 	unsigned long swapcached = 0;
+	long available;
 
 	si_meminfo_node(&i, nid);
+	available = si_mem_available_node(&i, nid);
 	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
 	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
 #ifdef CONFIG_SWAP
@@ -386,6 +388,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			    "Node %d MemTotal:       %8lu kB\n"
 			    "Node %d MemFree:        %8lu kB\n"
 			    "Node %d MemUsed:        %8lu kB\n"
+			    "Node %d MemAvailable:   %8lu kB\n"
 			    "Node %d SwapCached:     %8lu kB\n"
 			    "Node %d Active:         %8lu kB\n"
 			    "Node %d Inactive:       %8lu kB\n"
@@ -398,6 +401,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			    nid, K(i.totalram),
 			    nid, K(i.freeram),
 			    nid, K(i.totalram - i.freeram),
+			    nid, K(available),
 			    nid, K(swapcached),
 			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
 				   node_page_state(pgdat, NR_ACTIVE_FILE)),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1d4f731a8e18..34a5f5df388b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2532,6 +2532,7 @@ extern void mem_init(void);
 extern void __init mmap_init(void);
 extern void show_mem(unsigned int flags, nodemask_t *nodemask);
 extern long si_mem_available(void);
+extern long si_mem_available_node(struct sysinfo *val, int nid);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 #ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 936dc0b6c226..321c12f6272f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1132,6 +1132,11 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+#define for_each_pgdat_zone(pgdat, zone)				\
+	for (zone = (pgdat)->node_zones;				\
+	     zone < (pgdat)->node_zones + MAX_NR_ZONES - 1 && zone;	\
+	     zone++)
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index edfd6c81af82..31f5e3e335cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5731,6 +5731,55 @@ static inline void show_node(struct zone *zone)
 		printk("Node %d ", zone_to_nid(zone));
 }
 
+/**
+ * si_mem_available_node - helper to calculate the size of available memory
+ *			   of the given node
+ * @val: pointer to struct sysinfo
+ * @nid: the node id
+ */
+long si_mem_available_node(struct sysinfo *val, int nid)
+{
+	long available;
+	unsigned long pagecache;
+	unsigned long reclaimable;
+	unsigned long wmark_low = 0;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	struct zone *zone;
+
+	for_each_pgdat_zone(pgdat, zone)
+		wmark_low += low_wmark_pages(zone);
+
+	/*
+	 * Estimate the amount of memory available for userspace allocations,
+	 * without causing swapping.
+	 */
+	available = val->freeram - pgdat->totalreserve_pages;
+
+	/*
+	 * Not all the page cache can be freed, otherwise the system will
+	 * start swapping. Assume at least half of the page cache, or the
+	 * low watermark worth of cache, needs to stay.
+	 */
+	pagecache = node_page_state(pgdat, NR_ACTIVE_FILE) +
+		    node_page_state(pgdat, NR_INACTIVE_FILE);
+	pagecache -= min(pagecache / 2, wmark_low);
+	available += pagecache;
+
+	/*
+	 * Part of the reclaimable slab and other kernel memory consists of
+	 * items that are in use, and cannot be freed. Cap this estimate at the
+	 * low watermark.
+	 */
+	reclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) +
+		      node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE);
+	reclaimable -= min(reclaimable / 2, wmark_low);
+	available += reclaimable;
+
+	if (available < 0)
+		available = 0;
+	return available;
+}
+
 long si_mem_available(void)
 {
 	long available;
-- 
2.11.0

