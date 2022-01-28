Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF8949FA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349078AbiA1NUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348731AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB1C061753
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=48igdK4XD2qyyw4H7eAGAtmCU5dM/sdUsGGChgdX+mc=;
 b=Mhjb3jaW8n5cT4q9t7IwQYixbkD0AoAJ+xw9LX+B1BKrkYOiNMDcF1BsuBXLDnxS9YJi9
 RhVexvhKEcXF04/AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=48igdK4XD2qyyw4H7eAGAtmCU5dM/sdUsGGChgdX+mc=;
 b=5s8QcT/Pe0E6zMe8gQOZSoZuokKcmnSQyMMr7nyXpESmSSSMVXIWQd1aYnbbC9YGDNAj8
 aUl/zfdnGrEFhEn3N4PAhTN8iMevYWBb6Z1psZnu98HvYz2v3h6snm6FOsHBDKTsSbVPAxm
 1lziHA61mdd2LDX8yvJ7QZwvQ6OgO+zeNo/C8AlUMoVxDsdhJZjPnx+2rDjkAk7vhHok6LF
 7NWRmtIwOS/7e6XRDdV9Y8L3MDQlu9fqXoQiprHms0xKtY2BwwUSFE6Z6qN/B5SEhwxcv6F
 mWwDUtp8fbL7RoWGeghYSQm1a2HibCixrOU4/RQ3B+3ErxvL/xVd5daVs3vA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 3AA38160AC8;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 1F74A20459; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 30/35] mm: create new include/linux/vm_event.h header file
Date:   Fri, 28 Jan 2022 05:10:01 -0800
Message-Id: <20220128131006.67712-31-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split off the definitions necessary to update event counters from vmstat.h
into a new vm_event.h file.

The rationale is to allow header files included from mm.h to update
counter events. vmstat.h can not be included from such header files,
because it refers to page_pgdat() which is only defined later down
in mm.h, and thus results in compile errors. vm_event.h does not refer
to page_pgdat() and thus does not result in such errors.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/vm_event.h | 105 +++++++++++++++++++++++++++++++++++++++
 include/linux/vmstat.h   |  95 +----------------------------------
 2 files changed, 106 insertions(+), 94 deletions(-)
 create mode 100644 include/linux/vm_event.h

diff --git a/include/linux/vm_event.h b/include/linux/vm_event.h
new file mode 100644
index 000000000000..b3ae108a3841
--- /dev/null
+++ b/include/linux/vm_event.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VM_EVENT_H
+#define _LINUX_VM_EVENT_H
+
+#include <linux/types.h>
+#include <linux/percpu.h>
+#include <linux/mmzone.h>
+#include <linux/vm_event_item.h>
+#include <linux/atomic.h>
+
+#ifdef CONFIG_VM_EVENT_COUNTERS
+/*
+ * Light weight per cpu counter implementation.
+ *
+ * Counters should only be incremented and no critical kernel component
+ * should rely on the counter values.
+ *
+ * Counters are handled completely inline. On many platforms the code
+ * generated will simply be the increment of a global address.
+ */
+
+struct vm_event_state {
+	unsigned long event[NR_VM_EVENT_ITEMS];
+};
+
+DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
+
+/*
+ * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
+ * local_irq_disable overhead.
+ */
+static inline void __count_vm_event(enum vm_event_item item)
+{
+	raw_cpu_inc(vm_event_states.event[item]);
+}
+
+static inline void count_vm_event(enum vm_event_item item)
+{
+	this_cpu_inc(vm_event_states.event[item]);
+}
+
+static inline void __count_vm_events(enum vm_event_item item, long delta)
+{
+	raw_cpu_add(vm_event_states.event[item], delta);
+}
+
+static inline void count_vm_events(enum vm_event_item item, long delta)
+{
+	this_cpu_add(vm_event_states.event[item], delta);
+}
+
+extern void all_vm_events(unsigned long *);
+
+extern void vm_events_fold_cpu(int cpu);
+
+#else
+
+/* Disable counters */
+static inline void count_vm_event(enum vm_event_item item)
+{
+}
+static inline void count_vm_events(enum vm_event_item item, long delta)
+{
+}
+static inline void __count_vm_event(enum vm_event_item item)
+{
+}
+static inline void __count_vm_events(enum vm_event_item item, long delta)
+{
+}
+static inline void all_vm_events(unsigned long *ret)
+{
+}
+static inline void vm_events_fold_cpu(int cpu)
+{
+}
+
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+
+#ifdef CONFIG_NUMA_BALANCING
+#define count_vm_numa_event(x)     count_vm_event(x)
+#define count_vm_numa_events(x, y) count_vm_events(x, y)
+#else
+#define count_vm_numa_event(x) do {} while (0)
+#define count_vm_numa_events(x, y) do { (void)(y); } while (0)
+#endif /* CONFIG_NUMA_BALANCING */
+
+#ifdef CONFIG_DEBUG_TLBFLUSH
+#define count_vm_tlb_event(x)	   count_vm_event(x)
+#define count_vm_tlb_events(x, y)  count_vm_events(x, y)
+#else
+#define count_vm_tlb_event(x)     do {} while (0)
+#define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
+#endif
+
+#ifdef CONFIG_DEBUG_VM_VMACACHE
+#define count_vm_vmacache_event(x) count_vm_event(x)
+#else
+#define count_vm_vmacache_event(x) do {} while (0)
+#endif
+
+#define __count_zid_vm_events(item, zid, delta) \
+	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
+
+#endif /* _LINUX_VM_EVENT_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..7c3c892ce89a 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -6,6 +6,7 @@
 #include <linux/percpu.h>
 #include <linux/mmzone.h>
 #include <linux/vm_event_item.h>
+#include <linux/vm_event.h>
 #include <linux/atomic.h>
 #include <linux/static_key.h>
 #include <linux/mmdebug.h>
@@ -40,100 +41,6 @@ enum writeback_stat_item {
 	NR_VM_WRITEBACK_STAT_ITEMS,
 };
 
-#ifdef CONFIG_VM_EVENT_COUNTERS
-/*
- * Light weight per cpu counter implementation.
- *
- * Counters should only be incremented and no critical kernel component
- * should rely on the counter values.
- *
- * Counters are handled completely inline. On many platforms the code
- * generated will simply be the increment of a global address.
- */
-
-struct vm_event_state {
-	unsigned long event[NR_VM_EVENT_ITEMS];
-};
-
-DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
-
-/*
- * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
- * local_irq_disable overhead.
- */
-static inline void __count_vm_event(enum vm_event_item item)
-{
-	raw_cpu_inc(vm_event_states.event[item]);
-}
-
-static inline void count_vm_event(enum vm_event_item item)
-{
-	this_cpu_inc(vm_event_states.event[item]);
-}
-
-static inline void __count_vm_events(enum vm_event_item item, long delta)
-{
-	raw_cpu_add(vm_event_states.event[item], delta);
-}
-
-static inline void count_vm_events(enum vm_event_item item, long delta)
-{
-	this_cpu_add(vm_event_states.event[item], delta);
-}
-
-extern void all_vm_events(unsigned long *);
-
-extern void vm_events_fold_cpu(int cpu);
-
-#else
-
-/* Disable counters */
-static inline void count_vm_event(enum vm_event_item item)
-{
-}
-static inline void count_vm_events(enum vm_event_item item, long delta)
-{
-}
-static inline void __count_vm_event(enum vm_event_item item)
-{
-}
-static inline void __count_vm_events(enum vm_event_item item, long delta)
-{
-}
-static inline void all_vm_events(unsigned long *ret)
-{
-}
-static inline void vm_events_fold_cpu(int cpu)
-{
-}
-
-#endif /* CONFIG_VM_EVENT_COUNTERS */
-
-#ifdef CONFIG_NUMA_BALANCING
-#define count_vm_numa_event(x)     count_vm_event(x)
-#define count_vm_numa_events(x, y) count_vm_events(x, y)
-#else
-#define count_vm_numa_event(x) do {} while (0)
-#define count_vm_numa_events(x, y) do { (void)(y); } while (0)
-#endif /* CONFIG_NUMA_BALANCING */
-
-#ifdef CONFIG_DEBUG_TLBFLUSH
-#define count_vm_tlb_event(x)	   count_vm_event(x)
-#define count_vm_tlb_events(x, y)  count_vm_events(x, y)
-#else
-#define count_vm_tlb_event(x)     do {} while (0)
-#define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
-#endif
-
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
-#define __count_zid_vm_events(item, zid, delta) \
-	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
-
 /*
  * Zone and node-based page accounting with per cpu differentials.
  */
-- 
2.20.1

