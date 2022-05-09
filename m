Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274FA51F4D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiEIGkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiEIGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:33:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20918A6BF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:29:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x88so714718pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vUx5XYnNUQ4SpbVJ4KR5YqsE/7i6GdjQvDrH5RKigc=;
        b=TC82INHLWZrU49CJ9vAbOyzbFZYnVPtZhj4HVMh0/PQ11kYlduRnmVkgVpkkAmIUnW
         pp840rF3esS1AZXEMuittuqcKYnRssv1NCAHX+11MQu2rVZIYkFqwWTuqOqgiwjCNnBB
         gdieRlCPhZ+IRj3xCyGAW1f3VK5ARJswXCwe76rmm0+I4sLIkCfkOQfdIDsxEfT4U7Dk
         hACf8ULMirNyXDDJb1zw8YIoWhcmMXEMNjJxn3cd3XDd3M7dlOUFpz3jpcz1xnuXtzcA
         kiAErI82e+jpbRnHXUxTgoNhziz8XhCLewLt0JtkWY8bFQn2IRNUTQr9/ZbaaK4lnTKd
         +a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vUx5XYnNUQ4SpbVJ4KR5YqsE/7i6GdjQvDrH5RKigc=;
        b=JAV0CVg5JYEsRJZzV+wpsMgLZRKjnFQVcQ2nS2Tp6i06Lu2urq2vpPonfA5uJE8CP4
         0wAmNam/hoTgRNkP6cGFl6oe7B9CcMAuOSaeHPnzbfm2Bh8TULoL9iL0V1RCBu5Xo9gt
         7YcX7B8hhBr82QwRsYRXv7hRrUW1/qYCzQFan0YbOJW/0RoYId7MGeDRQ6rdzjVkZ+C3
         2wU476H61uXxHQGQPG7FgQWjDGCvTq4y1prALzLxcMtvM37th7SMxP9tL/t98KSOcvyq
         oz51NjR7bXeWjRuBj0UzeCeEJf4xMuAf/M3lCnbQSBuoXzW8SPNTE7BOm8toQWWXpRZ+
         xz6Q==
X-Gm-Message-State: AOAM5311c+2qFK/bVO1ZXP+cDHrLSbwoVyGkpnyxm/Pt+kxHyOIy0iEr
        AVGIjv9Oia6fjhJx9w/H1C5/0w==
X-Google-Smtp-Source: ABdhPJysbt69R8xvl2WHk4ESD/nLQCAsz2esg98Qalvazq3o1Jn35yLaPmDEGrRWUUQboLjeHbYzwg==
X-Received: by 2002:a17:903:1210:b0:15e:8373:d4b8 with SMTP id l16-20020a170903121000b0015e8373d4b8mr14867375plh.11.1652077779569;
        Sun, 08 May 2022 23:29:39 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ba9100b0015e8d4eb2c2sm6162001pls.268.2022.05.08.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:29:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v10 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl
Date:   Mon,  9 May 2022 14:27:03 +0800
Message-Id: <20220509062703.64249-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220509062703.64249-1-songmuchun@bytedance.com>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
 Documentation/admin-guide/sysctl/vm.rst | 39 ++++++++++++++
 include/linux/memory_hotplug.h          |  9 ++++
 mm/hugetlb.c                            |  3 ++
 mm/hugetlb_vmemmap.c                    | 93 +++++++++++++++++++++++++++++----
 mm/memory_hotplug.c                     |  7 +--
 5 files changed, 136 insertions(+), 15 deletions(-)

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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8605d7eb7f5c..86158eb9da70 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1617,6 +1617,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline void flush_free_hpage_work(struct hstate *h)
 {
+	if (!hugetlb_optimize_vmemmap_enabled())
+		return;
+
 	if (hugetlb_optimize_vmemmap_pages(h))
 		flush_work(&free_hpage_work);
 }
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

