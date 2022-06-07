Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7829953F683
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiFGGsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiFGGsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:48:33 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4F5F266
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:48:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c18so6648648pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rQcgJEIGUGpgYsyIUqNWgUUdRjuukG04jLIMCKTH0c=;
        b=XjNKoGV/J5xgunGis7NKTl26cgaF1gPJiMcDe2wAHuB+5jBc+Wv5J1V3q4dMa0pA5d
         vIvKx7KSgO37V9jholbn0XLMu99EPRQjDyzY0bDh9u0EPxXNecTXXhbz8fQ4XazLP2fY
         vwC76VgZASe4ILfogy5xcSyHuZMd72HaHqRw9OUqde6sNMP6O/WkiANQo3jBxk/0vy40
         glVGYCqPey9kapi7Jf1DDgON2fJNaR/XfYu1HOTujEKaxM5hZV0WPsiDn0w1xWrOaE0M
         gMMq6ser1OhJwPyy+eu5bmtSg4zYQFw6x1F5DkJtjMsfv2Dkg+r0Xjdeyk742t22bTf0
         ZQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rQcgJEIGUGpgYsyIUqNWgUUdRjuukG04jLIMCKTH0c=;
        b=r7WMenaCLX2yEhMmzCaNGNur5OxMc0K2UIKFsCXIXND3TWfXL3pVHmgF/KA7vkB+L1
         kikSBUjxjX5S9mQxhIR8LFzJm0zFVNbI6LIp03SPKiS6OoCytDNILUU0c6/kpyk2l0yD
         /M2iq/aFlKvFKV0aqrk8R1R1gC02vudyjVFyryM8H9b0aNHlooQYCYSBib0oBBY7MZpQ
         Rb3m+L38xjR1qk8naMGsn1/B8gpVYfSJtzoCL17wRhM/al9Wdab0wgnj9Mgh+ns0zKFV
         7hvONA4gMmWZFBpC1vOK1D5B+eZWHbSNRmUS6HI7eCuM7nUiTliFj02QQcEsaxHA0EX1
         WAyA==
X-Gm-Message-State: AOAM5321c3ewsd5fCNGsk2qjyZBAtURaL+jInDWpuaIleZD3Hj42MBqX
        wtzjPDKRG8EV1j5CiWQyxy5/zA==
X-Google-Smtp-Source: ABdhPJyRyQQmSA0kSCvirbNa7Mtz2TU5HtXIN+UxJA2W7gLSPU3k2Q9MT59vsB1FIPJvD/fep8rSXQ==
X-Received: by 2002:a05:6a00:139f:b0:51b:e21f:b72 with SMTP id t31-20020a056a00139f00b0051be21f0b72mr20999766pfg.75.1654584508075;
        Mon, 06 Jun 2022 23:48:28 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902d65400b00163cc9d6a04sm11742806plh.299.2022.06.06.23.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:48:27 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, mhocko@kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct} items in memory.stat of cgroup v2
Date:   Tue,  7 Jun 2022 14:48:03 +0800
Message-Id: <20220607064803.79363-1-zhengqi.arch@bytedance.com>
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
Changelog in v3 -> v4:
 - fix the doc, thanks to Johannes

Changelog in v2 -> v3:
 - add comment for memcg_vm_event_stat (suggested by Michal)
 - collect Acked-bys

Changelog in v1 -> v2:
 - keep pgscan and pgsteal items for forward compatibility, thanks to Shakeel
 - update commit log
 - collect Acked-bys

 Documentation/admin-guide/cgroup-v2.rst | 24 ++++++++---
 mm/memcontrol.c                         | 55 ++++++++++++-------------
 2 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 176298f2f4de..ad9ba3ec90a5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1433,6 +1433,24 @@ PAGE_SIZE multiple when read back.
 	  workingset_nodereclaim
 		Number of times a shadow node has been reclaimed
 
+	  pgscan (npn)
+		Amount of scanned pages (in an inactive LRU list)
+
+	  pgsteal (npn)
+		Amount of reclaimed pages
+
+	  pgscan_kswapd (npn)
+		Amount of scanned pages by kswapd (in an inactive LRU list)
+
+	  pgscan_direct (npn)
+		Amount of scanned pages directly  (in an inactive LRU list)
+
+	  pgsteal_kswapd (npn)
+		Amount of reclaimed pages by kswapd
+
+	  pgsteal_direct (npn)
+		Amount of reclaimed pages directly
+
 	  pgfault (npn)
 		Total number of page faults incurred
 
@@ -1442,12 +1460,6 @@ PAGE_SIZE multiple when read back.
 	  pgrefill (npn)
 		Amount of scanned pages (in an active LRU list)
 
-	  pgscan (npn)
-		Amount of scanned pages (in an inactive LRU list)
-
-	  pgsteal (npn)
-		Amount of reclaimed pages
-
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

