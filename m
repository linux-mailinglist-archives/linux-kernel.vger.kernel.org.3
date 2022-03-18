Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DEE4DD7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiCRKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiCRKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:10:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A521FB509
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n2so6620476plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxPYjtXpfBf0hnIpFUPE7iclhmNThzJGoUWla3RxJ4c=;
        b=hnKOFrBbu1/7WR02NgOeXBxwK+ROyYs3aHbIACeEBqNgtvcSUTgVCZdgWSyBYMFr0j
         2rkzhGzTEm14AdWbacYdTQuP44qjRRhC/JtEo0KxsptigAIRK9wk2LURhB7HgZ35C8hF
         gh9xVWWxACVAPBwe/X4CSSppNgAMu3sBBiaW/YQCY5hv3nACsN7bY3s2j89D0+xOA3iB
         X5Iw/6hTXg6ze/45TjYkBkD4xuLSmGGmwgfuLIEpBC5RXdrjyh3sVsExtq+CKEeyscTU
         unBaXqEKnH/e/CHO85C+Tty0bgpI3KiA/aTqckNxOFDuirGq6GCfTXWmFJIoD7jdnAGc
         iilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxPYjtXpfBf0hnIpFUPE7iclhmNThzJGoUWla3RxJ4c=;
        b=dniRsZjT0kAd/9LPoP91kr8WcE6RM6TVNaRL0q5RzJIuY33dxjIKSNcUiX7zFKkaxE
         8z5/o7RBdSfHgheIGKFxPg9y2NkADD6vHz72RJc9L/3ad00KZ28V48pDMuFi6ZBEuXOX
         77pA8y0NP9BBKqXmJ6JEVaLWUgx37F9gh3WiyUoqmD9OE7ByxTcpAwI11IyqV1er+BCU
         rGOxO2NiDKg1d1mQUERHqwkCGsWNpzSByE45PQsgW0kPSBjuQYiM7kqFDOhqCCrcjisv
         5Kdb3Qj0439OGSPWO0lRlvP9gCPjT/XqTZgP4nOz4Z2dvC4JlfwmN/Ekp4XU5VuWP2Bv
         USXQ==
X-Gm-Message-State: AOAM532clMb4+Fe+sBJ35AwFbci8dy1zdBrSHtcQkzZd29xvdpoVO2xD
        go+f4pENrT05tx7iBvtMwgirbg==
X-Google-Smtp-Source: ABdhPJz4cmjJa5gjbYkzAbeXtq6exBZgu6Q7fEKo5yUsm6W7EX0gl+E4lNHOJtVyPSInwrZiBFRgDw==
X-Received: by 2002:a17:90b:4f4b:b0:1bf:bd24:263f with SMTP id pj11-20020a17090b4f4b00b001bfbd24263fmr10417342pjb.228.1647598170645;
        Fri, 18 Mar 2022 03:09:30 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004fa042e8216sm9541252pfj.2.2022.03.18.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:09:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 4/4] mm: hugetlb_vmemmap: add hugetlb_free_vmemmap sysctl
Date:   Fri, 18 Mar 2022 18:07:20 +0800
Message-Id: <20220318100720.14524-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318100720.14524-1-songmuchun@bytedance.com>
References: <20220318100720.14524-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
server to enable the feature of freeing vmemmap pages of HugeTLB
pages.  Rebooting usually takes a long time.  Add a sysctl to enable
or disable the feature at runtime without rebooting.

Disabling requires there is no any optimized HugeTLB page in the
system.  If you fail to disable it, you can set "nr_hugepages" to 0
and then retry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/sysctl/vm.rst |  14 +++++
 include/linux/memory_hotplug.h          |   9 +++
 mm/hugetlb_vmemmap.c                    | 101 +++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.h                    |   4 +-
 mm/memory_hotplug.c                     |   7 +--
 5 files changed, 108 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f4804ce37c58..9e0e153ed935 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -561,6 +561,20 @@ Change the minimum size of the hugepage pool.
 See Documentation/admin-guide/mm/hugetlbpage.rst
 
 
+hugetlb_free_vmemmap
+====================
+
+Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap
+pages associated with each HugeTLB page.  Once true, the vmemmap pages of
+subsequent allocation of HugeTLB pages from buddy system will be optimized,
+whereas already allocated HugeTLB pages will not be optimized.  If you fail
+to disable this feature, you can set "nr_hugepages" to 0 and then retry
+since it is only allowed to be disabled after there is no any optimized
+HugeTLB page in the system.
+
+See Documentation/admin-guide/mm/hugetlbpage.rst
+
+
 nr_hugepages_mempolicy
 ======================
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 1ce6f8044f1e..9b015b254e86 100644
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
index 33ecb77c2b2a..f920073d52ba 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -176,6 +176,7 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
+#include <linux/memory_hotplug.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -192,6 +193,10 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
 			hugetlb_free_vmemmap_enabled_key);
 EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
 
+/* How many HugeTLB pages with vmemmap pages optimized. */
+static atomic_long_t optimized_pages = ATOMIC_LONG_INIT(0);
+static DECLARE_RWSEM(sysctl_rwsem);
+
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
 	if (!buf)
@@ -208,11 +213,6 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
 }
 early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
 
-static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
-{
-	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
-}
-
 /*
  * Previously discarded vmemmap pages will be allocated and remapping
  * after this function returns zero.
@@ -221,14 +221,18 @@ int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	int ret;
 	unsigned long vmemmap_addr = (unsigned long)head;
-	unsigned long vmemmap_end, vmemmap_reuse;
+	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
 
 	if (!HPageVmemmapOptimized(head))
 		return 0;
 
-	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
-	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
-	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
+	vmemmap_pages	= free_vmemmap_pages_per_hpage(h);
+	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
+	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
+
+	VM_BUG_ON_PAGE(!vmemmap_pages, head);
+
 	/*
 	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
 	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
@@ -238,8 +242,14 @@ int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 */
 	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
 				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
-	if (!ret)
+	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
+		/*
+		 * Paired with acquire semantic in
+		 * hugetlb_free_vmemmap_handler().
+		 */
+		atomic_long_dec_return_release(&optimized_pages);
+	}
 
 	return ret;
 }
@@ -247,22 +257,28 @@ int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
-	unsigned long vmemmap_end, vmemmap_reuse;
+	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
 
-	if (!free_vmemmap_pages_per_hpage(h))
-		return;
+	down_read(&sysctl_rwsem);
+	vmemmap_pages = free_vmemmap_pages_per_hpage(h);
+	if (!vmemmap_pages)
+		goto out;
 
-	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
-	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
-	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
+	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
+	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_addr, @vmemmap_end)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
-	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse)) {
 		SetHPageVmemmapOptimized(head);
+		atomic_long_inc(&optimized_pages);
+	}
+out:
+	up_read(&sysctl_rwsem);
 }
 
 void __init hugetlb_vmemmap_init(struct hstate *h)
@@ -278,9 +294,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_free_vmemmap_enabled())
-		return;
-
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page is not to be freed to buddy allocator, the other tail
@@ -296,3 +309,51 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
 		h->name);
 }
+
+static int hugetlb_free_vmemmap_handler(struct ctl_table *table, int write,
+					void *buffer, size_t *length,
+					loff_t *ppos)
+{
+	int ret;
+
+	down_write(&sysctl_rwsem);
+	/*
+	 * Cannot be disabled when there is at lease one optimized
+	 * HugeTLB in the system.
+	 *
+	 * The acquire semantic is paired with release semantic in
+	 * alloc_huge_page_vmemmap(). If we saw the @optimized_pages
+	 * with 0, all the operations of vmemmap pages remapping from
+	 * alloc_huge_page_vmemmap() are visible too so that we can
+	 * safely disable static key.
+	 */
+	table->extra1 = atomic_long_read_acquire(&optimized_pages) ?
+			SYSCTL_ONE : SYSCTL_ZERO;
+	ret = proc_do_static_key(table, write, buffer, length, ppos);
+	up_write(&sysctl_rwsem);
+
+	return ret;
+}
+
+static struct ctl_table hugetlb_vmemmap_sysctls[] = {
+	{
+		.procname	= "hugetlb_free_vmemmap",
+		.data		= &hugetlb_free_vmemmap_enabled_key.key,
+		.mode		= 0644,
+		.proc_handler	= hugetlb_free_vmemmap_handler,
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
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..b67a159027f4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -21,7 +21,9 @@ void hugetlb_vmemmap_init(struct hstate *h);
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return h->nr_free_vmemmap_pages;
+	if (hugetlb_free_vmemmap_enabled())
+		return h->nr_free_vmemmap_pages;
+	return 0;
 }
 #else
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index da594b382829..793c04cfe46f 100644
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

