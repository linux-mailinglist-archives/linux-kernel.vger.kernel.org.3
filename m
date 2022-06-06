Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407453E00D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbiFFD1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiFFD1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:27:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFCD2185
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:27:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e9so1230101pju.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 20:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulBH6/BTt3WNPNCt0z9LchHo392CcWeM5+G1jE1HOp4=;
        b=UD5JdPKVucPkOtgxqYeGhvO3gS1GYRX1pzCl1MtDs8vFxGF/M+bCSMq9P+8Rrc+GKH
         /hMufmc+Xgx6TK692DFHfs3G2cgjA3fHTGWoyt6p2S8TVDwHijaEBq67iBnL53Ka3sOo
         LwIO9slZotJ1+8eLsbeEIaHYwldJd/SnH7mjfH1VyvjMbVgWpNGzw7zlCZqNl/9Vis8D
         TOkNpY3hxKaW0GlLlWT/Hztlrs5aWIZ2xXiXmK3tPbb2MJIqXv+uFhGUqz5Vo4rCU1qs
         LsUXxiHs6wsbVVYI6VXH/UxoZpzJYPKRjYyaCDcuRx2lcc1m/JCsDrH/0DRjbWfIFwI3
         33QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulBH6/BTt3WNPNCt0z9LchHo392CcWeM5+G1jE1HOp4=;
        b=yrrpk/N/mmZ4vNiGQ+PIJgvdDXFw/IRE5vpPVHg6F7OJXo3WMs97TdBcGDw3K5uS2R
         2dOzozpgidGsmzBJ35i8CJnNT+PllsELWLXyy4KNtKY25syAkpkBe7E8BuXAkAM4jFZQ
         c7QAVUXuax79yH7MTv/qQ6cirTiTPN99lx9qMp7+8dJM/lSoAm5ROyJcyNUwVKlq3vmK
         Miu//lnIu/LK7LJvDNZoYVbf+a5ndmTIP2h7Dv7V5cRiIkfhhx97iUu3KmJLu57SP8l3
         d+sNCAAF8V9ZuoofeBPMkXdwp6LjMHcqbK71WcdsAu5myw/S70xCAyZ34ILHvWYM0/sD
         9bLA==
X-Gm-Message-State: AOAM531LdzvkT6N3J8rzThhl7l/G4GwdRg4MuI7VSWCrZr3/oMd87PfS
        DYnAM+mwToFMPFTk+vmzBpw=
X-Google-Smtp-Source: ABdhPJzVskcIi20zCrVOIlSgNYLmQ/f+7kORX4l7EGeXTqtGYhu1eSSZhqa6cvI91F+wMp7mfYZdkg==
X-Received: by 2002:a17:902:f605:b0:14f:5d75:4fb0 with SMTP id n5-20020a170902f60500b0014f5d754fb0mr22006966plg.101.1654486035960;
        Sun, 05 Jun 2022 20:27:15 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0015e8d4eb2aesm9372225plg.248.2022.06.05.20.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 20:27:15 -0700 (PDT)
From:   Huanpeng Xin <xinhuanpeng9@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xinhuanpeng <xinhuanpeng@xiaomi.com>
Subject: [PATCH] mm: add a new emergency page migratetype.
Date:   Mon,  6 Jun 2022 11:27:09 +0800
Message-Id: <20220606032709.11800-1-xinhuanpeng9@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xinhuanpeng <xinhuanpeng@xiaomi.com>

add a new page migratetype reserved for
non-costly non-NOWARN page allocation failure.

Signed-off-by: xinhuanpeng <xinhuanpeng@xiaomi.com>
---
 include/linux/gfp.h    |   4 ++
 include/linux/mmzone.h |  16 ++++++
 init/main.c            |   3 ++
 mm/Kconfig             |  11 +++++
 mm/page_alloc.c        | 107 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 2d2ccae933c2..fcc758a34e11 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -716,4 +716,8 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 extern void init_cma_reserved_pageblock(struct page *page);
 #endif
 
+#ifdef CONFIG_EMERGENCY_MEMORY
+extern void emergency_mm_init(void);
+#endif
+
 #endif /* __LINUX_GFP_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..5d3962d7cdaf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -60,6 +60,13 @@ enum migratetype {
 #endif
 #ifdef CONFIG_MEMORY_ISOLATION
 	MIGRATE_ISOLATE,	/* can't allocate from here */
+#endif
+#ifdef CONFIG_EMERGENCY_MEMORY
+	/*
+	 * MIGRATE_EMERGENCY migration type is designed to save
+	 * non-costly non-NOWARN page allocation failure.
+	 */
+	MIGRATE_EMERGENCY,
 #endif
 	MIGRATE_TYPES
 };
@@ -413,6 +420,11 @@ struct per_cpu_nodestat {
 
 #endif /* !__GENERATING_BOUNDS.H */
 
+#ifdef CONFIG_EMERGENCY_MEMORY
+/* The maximum number of pages in MIGRATE_EMERGENCY migration type */
+#define MAX_MANAGED_EMERGENCY 2048
+#endif
+
 enum zone_type {
 	/*
 	 * ZONE_DMA and ZONE_DMA32 are used when there are peripherals not able
@@ -517,6 +529,10 @@ struct zone {
 
 	unsigned long nr_reserved_highatomic;
 
+#ifdef CONFIG_EMERGENCY_MEMORY
+	/* The actual number of pages in MIGRATE_EMERGENCY migration type */
+	unsigned long nr_reserved_emergency;
+#endif
 	/*
 	 * We don't know if the memory that we're going to allocate will be
 	 * freeable or/and it will be released eventually, so to avoid totally
diff --git a/init/main.c b/init/main.c
index 02eb533018f6..7ff2e7761198 100644
--- a/init/main.c
+++ b/init/main.c
@@ -852,6 +852,9 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+#ifdef CONFIG_EMERGENCY_MEMORY
+	emergency_mm_init();
+#endif
 }
 
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..a13559cf13cf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1132,4 +1132,15 @@ config PTE_MARKER_UFFD_WP
 
 source "mm/damon/Kconfig"
 
+config EMERGENCY_MEMORY
+	bool "Enable emergency memory"
+	default n
+	help
+
+	 Add a new emergency page migratetype.
+
+	 This enables the migration type MIGRATE_EMERGENCY,which reserves
+	 a small amount of memory for non-costly non-NOWARN page allocation
+	 failure.
+
 endmenu
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..a149fb7fc2f8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -324,6 +324,9 @@ const char * const migratetype_names[MIGRATE_TYPES] = {
 #ifdef CONFIG_CMA
 	"CMA",
 #endif
+#ifdef CONFIG_EMERGENCY_MEMORY
+	"Emergency",
+#endif
 #ifdef CONFIG_MEMORY_ISOLATION
 	"Isolate",
 #endif
@@ -2908,6 +2911,43 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	return false;
 }
 
+#ifdef CONFIG_EMERGENCY_MEMORY
+/* Initialization of the migration type MIGRATE_EMERGENCY */
+void __init emergency_mm_init(void)
+{
+	/*
+	 * If  pageblock_order < MAX_ORDER - 1 ,then allocating a few pageblocks may
+	 * cause the buddy system to merge two pageblocks of different migration types,
+	 * for example, MIGRATE_EMERGENCY and MIGRATE_MOVABLE.
+	 */
+	if (pageblock_order == MAX_ORDER - 1) {
+		int nid = 0;
+
+		pr_info("start to setup MIGRATE_EMERGENCY reserved memory.");
+		for_each_online_node(nid) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+			struct zone *zone = &pgdat->node_zones[ZONE_NORMAL];
+
+			while (zone->nr_reserved_emergency < MAX_MANAGED_EMERGENCY) {
+				struct page *page = alloc_pages(___GFP_MOVABLE, pageblock_order);
+
+				if (page == NULL) {
+					pr_warn("node id %d MIGRATE_EMERGENCY reserved pages failed, reserved %d pages.",
+						nid, zone->nr_reserved_emergency);
+					break;
+				}
+				set_pageblock_migratetype(page, MIGRATE_EMERGENCY);
+				__free_pages(page, pageblock_order);
+				zone->nr_reserved_emergency += pageblock_nr_pages;
+			}
+			pr_info("node id %d MIGRATE_EMERGENCY reserved %d pages.",
+				nid, zone->nr_reserved_emergency);
+
+		}
+	}
+}
+#endif
+
 /*
  * Try finding a free buddy page on the fallback list and put it on the free
  * list of requested migratetype, possibly along with other pages from the same
@@ -3861,6 +3901,14 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 	long unusable_free = (1 << order) - 1;
 
+#ifdef CONFIG_EMERGENCY_MEMORY
+	/*
+	 * If the migration type MIGRATE_EMERGENCY enable,then subtract
+	 * reserved pages.
+	 */
+	 unusable_free -= z->nr_reserved_emergency;
+#endif
+
 	/*
 	 * If the caller does not have rights to ALLOC_HARDER then subtract
 	 * the high-atomic reserves. This will over-estimate the size of the
@@ -4073,6 +4121,50 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
 	return alloc_flags;
 }
 
+#ifdef CONFIG_EMERGENCY_MEMORY
+/*
+ * get_emergency_page_from_freelist allocates pages in reserved memory
+ * in the migration type MIGRATE_EMERGENCY.
+ */
+static struct page *get_emergency_page_from_freelist(gfp_t gfp_mask, unsigned int order,
+			int alloc_flags, const struct alloc_context *ac, int migratetype)
+{
+	struct page *page = NULL;
+
+	if (ac->high_zoneidx >= ZONE_NORMAL) {
+		struct zoneref *z = ac->preferred_zoneref;
+		struct pglist_data *pgdat = NODE_DATA(zonelist_node_idx(z));
+		struct zone *zone = &pgdat->node_zones[ZONE_NORMAL];
+		unsigned long flags;
+
+		if (cpusets_enabled() &&
+			(alloc_flags & ALLOC_CPUSET) &&
+			!__cpuset_zone_allowed(zone, gfp_mask))
+			return NULL;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		do {
+			page = __rmqueue_smallest(zone, order, migratetype);
+		} while (page && check_new_pages(page, order));
+
+		spin_unlock(&zone->lock);
+
+		if (page) {
+			__mod_zone_freepage_state(zone, -(1 << order),
+						  get_pcppage_migratetype(page));
+
+			__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
+			zone_statistics(z->zone, zone);
+			prep_new_page(page, order, gfp_mask, alloc_flags);
+		}
+		local_irq_restore(flags);
+	}
+
+	return page;
+
+}
+#endif
+
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
  * a page.
@@ -5169,6 +5261,18 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 	}
 fail:
+#ifdef CONFIG_EMERGENCY_MEMORY
+	if (!(gfp_mask & __GFP_NOWARN) && !costly_order) {
+		/*
+		 * If this allocation belongs to non-costly non-NOWARN page allocation,
+		 * then uses the reserved memory in the migration type MIGRATE_EMERGENCY.
+		 */
+		page = get_emergency_page_from_freelist(gfp_mask, order, alloc_flags, ac,
+			 MIGRATE_EMERGENCY);
+		if (page)
+			goto got_pg;
+	}
+#endif
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
@@ -5905,6 +6009,9 @@ static void show_migration_types(unsigned char type)
 #ifdef CONFIG_CMA
 		[MIGRATE_CMA]		= 'C',
 #endif
+#ifdef CONFIG_EMERGENCY_MEMORY
+		[MIGRATE_EMERGENCY]  = 'G',
+#endif
 #ifdef CONFIG_MEMORY_ISOLATION
 		[MIGRATE_ISOLATE]	= 'I',
 #endif
-- 
2.36.1

