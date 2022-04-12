Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C94FDF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348717AbiDLMQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354617AbiDLMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:14:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06CD85BC9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s137so14228058pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOkU/RARB4HzUE+K871kdn+JSt0MwPZIDE1q0TKS/DQ=;
        b=OKnLJ4QCbkZSQSjqhcW5b0CZeXAOfSeBDKKAKfyreFoxa6pTgaQWKP0BesaFcmYzgF
         I/UYTZWev+8+PIKP2qq2wamq0V90RFdhK0z1JnJFHDgPJradlTJ7uBV1C1jV4EB/ht2m
         dKhhpsJ5c7o10KdScpnuFUpfFbGEa1sHsBQumLrPcVpJMirCCADQu6N/wFYxQYtNJRyq
         Jm5SEyUC7WD93CubrUlN/yY+ukPhZ12oig0i20MKS5RDTacSHxVldY+zULCDcqdmMXZ5
         wzAWxYt77fWGOyd0gg3SXBmQLJzpsuZPrPoHo40qFZqB7X/3gT+gVrqsop8m3CrRNwwb
         0zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOkU/RARB4HzUE+K871kdn+JSt0MwPZIDE1q0TKS/DQ=;
        b=rEKYGzr/9uVX25J8QtOtvcaPW7R0Cew5JOHANi7RqNI5kKwg4GC204kEQwIB2bT/8U
         yv7wikdIMvdjSQPy38q6aR9T+6Om/OliazYUiNkLepEikb6BFweKZI3QCimmvsFDrvMx
         UELKTdeFY3dreVi5NMCwPl9n24HfQ4+Am39JtThgYa4fNV5t6NIx7CrUlAJ+yLonozOg
         0vn0wiMKqCOa8bN2oK2qTmQsU48mzcxbWsMLZYad/8GJgW/41E6Yn5E3vRxFsV39Nyll
         u5VRkiVpH27rB8UvZ84kReAuUCNazJtl+tioS7CW56cCJGazhtzvA7Lu9yYmmlVEHZ7i
         HvfQ==
X-Gm-Message-State: AOAM531QZlP8zb9As3YYBVhZcgTobiJHZKudVY1wDJm3UEGYPKgA2DTE
        IVKsXGDSOWvs+uR7BEmtdiqlAw==
X-Google-Smtp-Source: ABdhPJwTtrUS2x+SQP3CaQv+UzJaK+MYHoLSMznZiPSDVhpNPWgS+Ftk27GJKqldQa/Z8kINzEsRCQ==
X-Received: by 2002:a63:195f:0:b0:399:1f0e:a21d with SMTP id 31-20020a63195f000000b003991f0ea21dmr29964914pgz.393.1649762121328;
        Tue, 12 Apr 2022 04:15:21 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id l25-20020a635719000000b0039da6cdf82dsm402507pgb.83.2022.04.12.04.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:15:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl
Date:   Tue, 12 Apr 2022 19:14:34 +0800
Message-Id: <20220412111434.96498-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220412111434.96498-1-songmuchun@bytedance.com>
References: <20220412111434.96498-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
reboot the server to enable or disable the feature of optimizing vmemmap
pages associated with HugeTLB pages.  However, rebooting usually takes a
long time.  So add a sysctl to enable or disable the feature at runtime
without rebooting.

Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages
from buddy allocator will be optimized (7 pages per 2MB HugeTLB page and
4095 pages per 1GB HugeTLB page), whereas already allocated HugeTLB pages
will not be optimized.  When those optimized HugeTLB pages are freed from
the HugeTLB pool to the buddy allocator, the vmemmap pages representing
that range needs to be remapped again and the vmemmap pages discarded
earlier need to be rellocated again.  If your use case is that HugeTLB
pages are allocated 'on the fly' instead of being pulled from the HugeTLB
pool, you should weigh the benefits of memory savings against the more
overhead of allocation or freeing HugeTLB pages between the HugeTLB pool
and the buddy allocator.  Another behavior to note is that if the system
is under heavy memory pressure, it could prevent the user from freeing
HugeTLB pages from the HugeTLB pool to the buddy allocator since the
allocation of vmemmap pages could be failed, you have to retry later if
your system encounter this situation.

Once disabled, the vmemmap pages of subsequent allocation of HugeTLB
pages from buddy allocator will not be optimized, whereas already
optimized HugeTLB pages will not be affected.  If you want to make sure
there is no optimized HugeTLB pages, you can set "nr_hugepages" to 0
first and then disable this.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 27 ++++++++++
 include/linux/memory_hotplug.h          |  9 ++++
 mm/hugetlb_vmemmap.c                    | 90 +++++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.h                    |  4 +-
 mm/memory_hotplug.c                     |  7 +--
 5 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 747e325ebcd0..5c804ada85c5 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -562,6 +562,33 @@ Change the minimum size of the hugepage pool.
 See Documentation/admin-guide/mm/hugetlbpage.rst
 
 
+hugetlb_optimize_vmemmap
+========================
+
+Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
+associated with each HugeTLB page.
+
+Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
+buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
+per 1GB HugeTLB page), whereas already allocated HugeTLB pages will not be
+optimized.  When those optimized HugeTLB pages are freed from the HugeTLB pool
+to the buddy allocator, the vmemmap pages representing that range needs to be
+remapped again and the vmemmap pages discarded earlier need to be rellocated
+again.  If your use case is that HugeTLB pages are allocated 'on the fly'
+instead of being pulled from the HugeTLB pool, you should weigh the benefits of
+memory savings against the more overhead of allocation or freeing HugeTLB pages
+between the HugeTLB pool and the buddy allocator.  Another behavior to note is
+that if the system is under heavy memory pressure, it could prevent the user
+from freeing HugeTLB pages from the HugeTLB pool to the buddy allocator since
+the allocation of vmemmap pages could be failed, you have to retry later if
+your system encounter this situation.
+
+Once disabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
+buddy allocator will not be optimized, whereas already optimized HugeTLB pages
+will not be affected.  If you want to make sure there is no optimized HugeTLB
+pages, you can set "nr_hugepages" to 0 first and then disable this.
+
+
 nr_hugepages_mempolicy
 ======================
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7ab15d6fb227..93f2cbea0f9b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -348,4 +348,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
 extern bool mhp_supports_memmap_on_memory(unsigned long size);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
+bool mhp_memmap_on_memory(void);
+#else
+static inline bool mhp_memmap_on_memory(void)
+{
+	return false;
+}
+#endif
+
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b6a5cf16f11..94571d63916d 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -176,6 +176,7 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
+#include <linux/memory_hotplug.h>
 #include "hugetlb_vmemmap.h"
 
 #ifdef CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
@@ -189,21 +190,40 @@
 #define RESERVE_VMEMMAP_NR		1U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
+enum vmemmap_optimize_mode {
+	VMEMMAP_OPTIMIZE_OFF,
+	VMEMMAP_OPTIMIZE_ON,
+};
+
 DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
 			hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
+static enum vmemmap_optimize_mode vmemmap_optimize_mode =
+	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
+
+static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
+{
+	if (vmemmap_optimize_mode == to)
+		return;
+
+	if (to == VMEMMAP_OPTIMIZE_OFF)
+		static_branch_dec(&hugetlb_optimize_vmemmap_key);
+	else
+		static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	vmemmap_optimize_mode = to;
+}
+
 static int __init hugetlb_vmemmap_early_param(char *buf)
 {
 	bool enable;
+	enum vmemmap_optimize_mode mode;
 
 	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable)
-		static_branch_enable(&hugetlb_optimize_vmemmap_key);
-	else
-		static_branch_disable(&hugetlb_optimize_vmemmap_key);
+	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
+	vmemmap_optimize_mode_switch(mode);
 
 	return 0;
 }
@@ -236,8 +256,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 	 */
 	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
 				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
-	if (!ret)
+	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
+		static_branch_dec(&hugetlb_optimize_vmemmap_key);
+	}
 
 	return ret;
 }
@@ -251,6 +273,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 	if (!vmemmap_pages)
 		return;
 
+	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+
 	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
 	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
 	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
@@ -260,7 +284,9 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
-	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+	if (vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+		static_branch_dec(&hugetlb_optimize_vmemmap_key);
+	else
 		SetHPageVmemmapOptimized(head);
 }
 
@@ -277,9 +303,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_optimize_vmemmap_enabled())
-		return;
-
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page is not to be freed to buddy allocator, the other tail
@@ -295,4 +318,53 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_info("can optimize %d vmemmap pages for %s\n",
 		h->optimize_vmemmap_pages, h->name);
 }
+
+#ifdef CONFIG_PROC_SYSCTL
+static int hugetlb_optimize_vmemmap_handler(struct ctl_table *table, int write,
+					    void *buffer, size_t *length,
+					    loff_t *ppos)
+{
+	int ret;
+	enum vmemmap_optimize_mode mode;
+	static DEFINE_MUTEX(sysctl_mutex);
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&sysctl_mutex);
+	mode = vmemmap_optimize_mode;
+	table->data = &mode;
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (write && !ret)
+		vmemmap_optimize_mode_switch(mode);
+	mutex_unlock(&sysctl_mutex);
+
+	return ret;
+}
+
+static struct ctl_table hugetlb_vmemmap_sysctls[] = {
+	{
+		.procname	= "hugetlb_optimize_vmemmap",
+		.maxlen		= sizeof(enum vmemmap_optimize_mode),
+		.mode		= 0644,
+		.proc_handler	= hugetlb_optimize_vmemmap_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static __init int hugetlb_vmemmap_sysctls_init(void)
+{
+	/*
+	 * The vmemmap pages cannot be optimized if
+	 * "memory_hotplug.memmap_on_memory" is enabled.
+	 */
+	if (!mhp_memmap_on_memory())
+		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+
+	return 0;
+}
+late_initcall(hugetlb_vmemmap_sysctls_init);
+#endif /* CONFIG_PROC_SYSCTL */
 #endif /* CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP */
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 3afae3ff37fa..63ae2766ffe0 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -21,7 +21,9 @@ void hugetlb_vmemmap_init(struct hstate *h);
  */
 static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
 {
-	return h->optimize_vmemmap_pages;
+	if (hugetlb_optimize_vmemmap_enabled())
+		return h->optimize_vmemmap_pages;
+	return 0;
 }
 #else
 static inline int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f6eab03397d3..af844a01e956 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -63,15 +63,10 @@ static bool memmap_on_memory __ro_after_init;
 module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
 
-static inline bool mhp_memmap_on_memory(void)
+bool mhp_memmap_on_memory(void)
 {
 	return memmap_on_memory;
 }
-#else
-static inline bool mhp_memmap_on_memory(void)
-{
-	return false;
-}
 #endif
 
 enum {
-- 
2.11.0

