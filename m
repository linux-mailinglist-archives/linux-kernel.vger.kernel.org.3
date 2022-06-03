Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8E53C5B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiFCHGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiFCHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:06:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA06E35DE8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:06:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so6266881plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e82fukpYye7S2pSV2P+x4ME/8iEwBLqlJ1dF4LHKRB0=;
        b=ry5NcCTXMOqj1FGTaEXhK+FobbrIVEyQmzz/PgWWOHG+peC2R1eWm4saAAl0ArXz56
         7kqucbKX48iDB/rFpfZPlkZduVuAXQ1QWhrpK9qfw+6f/xvm6RV4FRaxl9jK5uxD1lAw
         DbEqejaeKCPP5MKuCY1wBpCRa95O/EO4aTBT1SDvFNgyqB3BFZBd+0EA1OXZ7N+6Z0Af
         sjz4XWY++3WN2hEqhBehtW0dKbDwTnPN1t8R1sFb/cKTEEuoU+ls60QysmRkU80dkG1T
         AX8y6mdwYugEGK5GBYhv/yaT5R8CIqnxRr3AynW1g97mVZnDkSxaQfil2YumvXykmYQU
         uxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e82fukpYye7S2pSV2P+x4ME/8iEwBLqlJ1dF4LHKRB0=;
        b=6hiZaPW3wFc8ZG9POrQUAl5csPTw3FtqW2vqWfTxltOD8+BSTBznNLE3qCZDtsHUzc
         Wzs7Yb+LMjQsrsKtH8e/8mNKs9EHZ/tRa9HeafJznFv5Js+o3LGqQzY8Jx8wFkSyN+dr
         Z2BaBhug7aVPCxU0p4DzDbi38RglwXS8eN4Gn72kz+S7s1ckoEfHFqrMsqrZFjcEMQRi
         8vIiOMW3FIGqL/lVQHppcxHzFSQ/YnDDiFtTn8hQxMSH3s6MluzRCZVFrDrwNl64xxzc
         KSOzL3nCsxKp8JxUANJYxHS/OVKbFCewjAPpCq6fR9PNlkdDZ1mvN74wFx8/MrVgybtH
         qVIg==
X-Gm-Message-State: AOAM530GL+eNhl6cyW+hT8gAIG5DStYIxJXo628qdizS1sQ2v+xg68PF
        ljZSmezvQk2jlngPszsKFCkYmA==
X-Google-Smtp-Source: ABdhPJzgJuki2NLhaHmK8hlAK3grRo/oCn5wI6acSYyw+d//NXha49HtiC09VSEmU6CA03CNN6HfMw==
X-Received: by 2002:a17:90b:4acd:b0:1e3:4dab:a14c with SMTP id mh13-20020a17090b4acd00b001e34daba14cmr9409659pjb.5.1654239962996;
        Fri, 03 Jun 2022 00:06:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id ij4-20020a170902ab4400b0016632179ec8sm3822472plb.219.2022.06.03.00.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:06:02 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     mhocko@kernel.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: memcontrol: separate {pgscan,pgsteal}_{kswapd,direct} items in memory.stat of cgroup v2
Date:   Fri,  3 Jun 2022 15:04:23 +0800
Message-Id: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are already statistics of {pgscan,pgsteal}_kswapd and
{pgscan,pgsteal}_direct of memcg event here, but now the sum
of the two is displayed in memory.stat of cgroup v2.

In order to obtain more accurate information during monitoring
and debugging, and to align with the display in /proc/vmstat,
it better to display {pgscan,pgsteal}_kswapd and
{pgscan,pgsteal}_direct separately.

Moreover, after this modification, all memcg events can be
printed with a combination of vm_event_name() and memcg_events().
This allows us to create an array to traverse and print, which
reduces redundant seq_buf_printf() codes.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 14 ++++--
 mm/memcontrol.c                         | 61 +++++++++++--------------
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 176298f2f4de..0b9ca7e7df34 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1442,11 +1442,17 @@ PAGE_SIZE multiple when read back.
 	  pgrefill (npn)
 		Amount of scanned pages (in an active LRU list)
 
-	  pgscan (npn)
-		Amount of scanned pages (in an inactive LRU list)
+	  pgscan_kswapd (npn)
+		Amount of scanned pages by kswapd (in an inactive LRU list)
 
-	  pgsteal (npn)
-		Amount of reclaimed pages
+	  pgscan_direct (npn)
+		Amount of scanned pages directly  (in an inactive LRU list)
+
+	  pgsteal_kswapd (npn)
+		Amount of reclaimed pages by kswapd
+
+	  pgsteal_direct (npn)
+		Amount of reclaimed pages directly
 
 	  pgactivate (npn)
 		Amount of pages moved to the active LRU list
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d3fe0a0c75a..4093062c5c9b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1460,6 +1460,28 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
+static const unsigned int memcg_vm_event_stat[] = {
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+#endif
+};
+
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
@@ -1495,41 +1517,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	}
 
 	/* Accumulated memory events */
-
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
-		       memcg_events(memcg, PGFAULT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
-		       memcg_events(memcg, PGMAJFAULT));
-	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
-		       memcg_events(memcg, PGREFILL));
-	seq_buf_printf(&s, "pgscan %lu\n",
-		       memcg_events(memcg, PGSCAN_KSWAPD) +
-		       memcg_events(memcg, PGSCAN_DIRECT));
-	seq_buf_printf(&s, "pgsteal %lu\n",
-		       memcg_events(memcg, PGSTEAL_KSWAPD) +
-		       memcg_events(memcg, PGSTEAL_DIRECT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
-		       memcg_events(memcg, PGACTIVATE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
-		       memcg_events(memcg, PGDEACTIVATE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
-		       memcg_events(memcg, PGLAZYFREE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
-		       memcg_events(memcg, PGLAZYFREED));
-
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPIN),
-		       memcg_events(memcg, ZSWPIN));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPOUT),
-		       memcg_events(memcg, ZSWPOUT));
-#endif
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
-		       memcg_events(memcg, THP_FAULT_ALLOC));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
-		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++)
+		seq_buf_printf(&s, "%s %lu\n",
+			       vm_event_name(memcg_vm_event_stat[i]),
+			       memcg_events(memcg, memcg_vm_event_stat[i]));
 
 	/* The above should easily fit into one page */
 	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
-- 
2.20.1

