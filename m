Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154F15243F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbiELEM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbiELEMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:12:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176491EEE1B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:12:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j14so3761319plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5zSO5rWiQoP1czo3d6Du3Pta/+ji0+lhk14MVp0Qfg=;
        b=mXVVWgq0C0STaIAhI3bBlCiz+kf9iUg74k3v33XOvO7TizHYmQwr8ctTD+qOZRrRL+
         w8OoTi4zebm7wDkTuSkvvuuaIw7jaVpTnjB9GP9+AM4WPFc/sWEuyYW5JQGbJBhzRZ6Q
         VXUyt2/7Ksvb8oHMVcfD++p7nw2wTsrS1GG6zd5F3xMCVj7Dhi1Kel8suBCs0xanK9oT
         Syo43WGjkBmLCAc3sEpR/i3PBfAwUPFpUSGyX94lKopauDrCjSTJlhLn1xmnMlv2Rs9c
         d67eLlQUjlm4gPSM/25pEUV57sa+clbHkh/0HzQfZQTd3XqVu4JAtycFXpRUYvkPg6TV
         C/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5zSO5rWiQoP1czo3d6Du3Pta/+ji0+lhk14MVp0Qfg=;
        b=BS3wQqQILKmpYnqR1S/WRqUH8XXjwPKkSecsMgYNouLoqW5jdDm7i376O8LCYqa+uK
         DGHlAfUOxfI32r2zAbjVmPItKv3VtAMMiC9oz5bOVYqFJkbXPs6+47HZEz7XtAmxtsEL
         2RGiap3L+06nOcfQPSv3pyDiFXL896ayUE+zyjJ5YlKES+aKCR4SVG+ltIvEE0AJ7kY+
         qbtumsT5qcHmFhdJY/CMjkFcSEG/t8OeGPnE5Y6NvhHbEbiNl7CMbja5IYgoOxBb9vwq
         fWarnkRQzWhjUcPj6x6DXsAOminMEpjvna7dmZuRwtg6E/LRNPZL8RC+D/oHb0Y2v2b/
         OhCg==
X-Gm-Message-State: AOAM532B0CrotFgJxnJYAdEXAKw1pX2Z+b77ZKDY3ikqGYwd8DMxXCDK
        yaiyrzINDtxQxuEZ3ylXB1gHIA==
X-Google-Smtp-Source: ABdhPJyKSX+nHiVHCffZgZnFyD/PDiaiBsbtOIE58g3HNfODQ8Mr3gQo4tFOhzpJ9l88j/6aEs/Quw==
X-Received: by 2002:a17:90a:930b:b0:1bf:ac1f:6585 with SMTP id p11-20020a17090a930b00b001bfac1f6585mr8655896pjo.88.1652328751875;
        Wed, 11 May 2022 21:12:31 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902edcd00b0015e8d4eb2dcsm2695161plk.294.2022.05.11.21.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:12:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v11 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl
Date:   Thu, 12 May 2022 12:11:42 +0800
Message-Id: <20220512041142.39501-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220512041142.39501-1-songmuchun@bytedance.com>
References: <20220512041142.39501-1-songmuchun@bytedance.com>
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

We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
reboot the server to enable or disable the feature of optimizing vmemmap
pages associated with HugeTLB pages.  However, rebooting usually takes a
long time.  So add a sysctl to enable or disable the feature at runtime
without rebooting.  Why we need this?  There are 3 use cases.

1) The feature of minimizing overhead of struct page associated with each
HugeTLB is disabled by default without passing "hugetlb_free_vmemmap=on"
to the boot cmdline. When we (ByteDance) deliver the servers to the
users who want to enable this feature, they have to configure the grub
(change boot cmdline) and reboot the servers, whereas rebooting usually
takes a long time (we have thousands of servers).  It's a very bad
experience for the users.  So we need a approach to enable this feature
after rebooting. This is a use case in our practical environment.

2) Some use cases are that HugeTLB pages are allocated 'on the fly'
instead of being pulled from the HugeTLB pool, those workloads would be
affected with this feature enabled.  Those workloads could be identified
by the characteristics of they never explicitly allocating huge pages
with 'nr_hugepages' but only set 'nr_overcommit_hugepages' and then let
the pages be allocated from the buddy allocator at fault time.  We can
confirm it is a real use case from the commit 099730d67417.  For those
workloads, the page fault time could be ~2x slower than before. We
suspect those users want to disable this feature if the system has enabled
this before and they don't think the memory savings benefit is enough to
make up for the performance drop.

3) If the workload which wants vmemmap pages to be optimized and the
workload which wants to set 'nr_overcommit_hugepages' and does not want
the extera overhead at fault time when the overcommitted pages be
allocated from the buddy allocator are deployed in the same server.
The user could enable this feature and set 'nr_hugepages' and
'nr_overcommit_hugepages', then disable the feature.  In this case,
the overcommited HugeTLB pages will not encounter the extra overhead
at fault time.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 39 ++++++++++++++
 include/linux/memory_hotplug.h          |  9 ++++
 mm/hugetlb_vmemmap.c                    | 93 +++++++++++++++++++++++++++++----
 mm/memory_hotplug.c                     |  7 +--
 4 files changed, 133 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 747e325ebcd0..5c9aa171a0d3 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -562,6 +562,45 @@ Change the minimum size of the hugepage pool.
 See Documentation/admin-guide/mm/hugetlbpage.rst
 
 
+hugetlb_optimize_vmemmap
+========================
+
+This knob is not available when memory_hotplug.memmap_on_memory (kernel parameter)
+is configured or the size of 'struct page' (a structure defined in
+include/linux/mm_types.h) is not power of two (an unusual system config could
+result in this).
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
+again.  If your use case is that HugeTLB pages are allocated 'on the fly' (e.g.
+never explicitly allocating HugeTLB pages with 'nr_hugepages' but only set
+'nr_overcommit_hugepages', those overcommitted HugeTLB pages are allocated 'on
+the fly') instead of being pulled from the HugeTLB pool, you should weigh the
+benefits of memory savings against the more overhead (~2x slower than before)
+of allocation or freeing HugeTLB pages between the HugeTLB pool and the buddy
+allocator.  Another behavior to note is that if the system is under heavy memory
+pressure, it could prevent the user from freeing HugeTLB pages from the HugeTLB
+pool to the buddy allocator since the allocation of vmemmap pages could be
+failed, you have to retry later if your system encounter this situation.
+
+Once disabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
+buddy allocator will not be optimized meaning the extra overhead at allocation
+time from buddy allocator disappears, whereas already optimized HugeTLB pages
+will not be affected.  If you want to make sure there are no optimized HugeTLB
+pages, you can set "nr_hugepages" to 0 first and then disable this.  Note that
+writing 0 to nr_hugepages will make any "in use" HugeTLB pages become surplus
+pages.  So, those surplus pages are still optimized until they are no longer
+in use.  You would need to wait for those surplus pages to be released before
+there are no optimized pages in the system.
+
+
 nr_hugepages_mempolicy
 ======================
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 029fb7e26504..917112661b5c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
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
index cc4ec752ec16..fcd9f7872064 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -10,6 +10,7 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
+#include <linux/memory_hotplug.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -22,21 +23,40 @@
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
+	WRITE_ONCE(vmemmap_optimize_mode, to);
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
@@ -69,8 +89,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
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
@@ -84,6 +106,11 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 	if (!vmemmap_pages)
 		return;
 
+	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+		return;
+
+	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+
 	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
 	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
 	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
@@ -93,7 +120,9 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
-	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+	if (vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+		static_branch_dec(&hugetlb_optimize_vmemmap_key);
+	else
 		SetHPageVmemmapOptimized(head);
 }
 
@@ -110,9 +139,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_optimize_vmemmap_enabled())
-		return;
-
 	if (!is_power_of_2(sizeof(struct page))) {
 		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
 		static_branch_disable(&hugetlb_optimize_vmemmap_key);
@@ -134,3 +160,52 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
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
+	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
+	 * crosses page boundaries, the vmemmap pages cannot be optimized.
+	 */
+	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
+		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+
+	return 0;
+}
+late_initcall(hugetlb_vmemmap_sysctls_init);
+#endif /* CONFIG_PROC_SYSCTL */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a6101ae402f9..c72070cdd055 100644
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

