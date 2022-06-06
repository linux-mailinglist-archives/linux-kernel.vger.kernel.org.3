Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249353E654
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiFFPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbiFFPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:42:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048903668B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:42:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t2so12408107pld.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adzl7J4UR1Qp4R8eggnQmmMOkmLDFtelBezSB34Z/mg=;
        b=v+QpT4munOuJrG3ZeTIMHBfcLLEo/iJ4NRKzvu1SAnFere/qBZ7e7sHJ3BM2xs8Mwh
         wIyGWXGAMK9BCX9kVmPRWxb+3owRG7t+oTPx64bMv+CR6cEr6OYsk59Iwh2wUPMa4fF6
         584f3NvYZxLlPZ8ZWIJQPvlB0GCweQkNySXdVSM584JUTVoAe9Qf97+9zM+a3LZAZYeT
         7vCp0f6vbjtIeQOsJ/Aosk/TQjJZRbLuRxUQ4/XcZBJ2BfqCP6f2w2LLleQoXD/hsnDo
         M/3Al5hGO1eNKco8fkebegsSqsG+l+AjF4h3Rt3jbJqrl9dggLoJKKRfzHTwlt9MyW2E
         hiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adzl7J4UR1Qp4R8eggnQmmMOkmLDFtelBezSB34Z/mg=;
        b=XcnaLjJA9ymKgBK9/4/IobVtiwEf+dNi8luvBXZSVgpyScJxqr6izzHiyYPbskgoyG
         JC0/aSjs8fg73xFNnMjwHICq/epdgW7qwadPqvThZAG08Ye90ZuH+en8FcB7h8sS3I1F
         FXvSHIE7I9KCQnPcXnMtKkc9HkuooOezwdYE0NrD31p2PVbwh8o6u8SZcbuPP6tLsuD1
         G7eJ9ExFlWDdMcXlzxSwG1f/gxYdL7UhKF77pdSBLySdHCEqbRxT76g6q5UDamWumPsV
         UAyc6yj2SVpHV1+AkmMtQFak/907ThIh5Z1rKFBSMmOH+eI6GCEmto7OT5zCUT3HoRcc
         skqQ==
X-Gm-Message-State: AOAM5306rn2rKDrg4I0wlebH7F4Rmdo8lqEDmq6f2NLb84kpoi6ANwB0
        M8xIYDsFIH5raPXRvZjphrwV2A==
X-Google-Smtp-Source: ABdhPJw3QVyuVPd2L5VPyRHngIgyOPotA5dIeezuj14vpJxAS+QPxzvnRd85Ha5L27wJ9CuUu8Gtfg==
X-Received: by 2002:a17:90b:1b05:b0:1e2:a053:2fad with SMTP id nu5-20020a17090b1b0500b001e2a0532fadmr51584255pjb.209.1654530170527;
        Mon, 06 Jun 2022 08:42:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b00163f5028fd6sm10651952plk.5.2022.06.06.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:42:49 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, mhocko@kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct} items in memory.stat of cgroup v2
Date:   Mon,  6 Jun 2022 23:40:28 +0800
Message-Id: <20220606154028.55030-1-zhengqi.arch@bytedance.com>
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
{pgscan,pgsteal}_direct of memcg event here, but now only the
sum of the two is displayed in memory.stat of cgroup v2.

In order to obtain more accurate information during monitoring
and debugging, and to align with the display in /proc/vmstat,
it better to display {pgscan,pgsteal}_kswapd and
{pgscan,pgsteal}_direct separately.

Also, for forward compatibility, we still display pgscan and
pgsteal items so that it won't break existing applications.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog in v2 -> v3:
 - add comment for memcg_vm_event_stat (suggested by Michal)
 - collect Acked-bys

Changelog in v1 -> v2:
 - keep pgscan and pgsteal items for forward compatibility, thanks to Shakeel
 - update commit log
 - collect Acked-bys

 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++
 mm/memcontrol.c                         | 55 ++++++++++++-------------
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 176298f2f4de..b2b55e7360d8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1445,9 +1445,21 @@ PAGE_SIZE multiple when read back.
 	  pgscan (npn)
 		Amount of scanned pages (in an inactive LRU list)
 
+	  pgscan_kswapd (npn)
+		Amount of scanned pages by kswapd (in an inactive LRU list)
+
+	  pgscan_direct (npn)
+		Amount of scanned pages directly  (in an inactive LRU list)
+
 	  pgsteal (npn)
 		Amount of reclaimed pages
 
+	  pgsteal_kswapd (npn)
+		Amount of reclaimed pages by kswapd
+
+	  pgsteal_direct (npn)
+		Amount of reclaimed pages directly
+
 	  pgactivate (npn)
 		Amount of pages moved to the active LRU list
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d3fe0a0c75a..27cebaa53472 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1460,6 +1460,29 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
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
@@ -1495,41 +1518,17 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	}
 
 	/* Accumulated memory events */
-
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
-		       memcg_events(memcg, PGFAULT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
-		       memcg_events(memcg, PGMAJFAULT));
-	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
-		       memcg_events(memcg, PGREFILL));
 	seq_buf_printf(&s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
 		       memcg_events(memcg, PGSCAN_DIRECT));
 	seq_buf_printf(&s, "pgsteal %lu\n",
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
 		       memcg_events(memcg, PGSTEAL_DIRECT));
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

