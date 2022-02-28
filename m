Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E04C63AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiB1HM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiB1HMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:12:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C34674C0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:11:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i1so9926649plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8ft55r/VTfoT4ZinxhB51u9HRB18drBxk6cMGVkRIc=;
        b=QPUd6SMtlL0lgH1f6RussrMAtI4S+e2NVZ4z1/cLuYCljBgasiYx6HN63o1FJmT3mB
         EyERA9+htOPxv14o3q8QvwJsmjpHWrbsY4D9/F3IqZQVtTdSQjgOHYIoizN+awrObS+b
         o2mqmQMWwaP9vT80WgYs90x14FldeS7DT225M0TViqTER9xsB49CZ19VLK0rtgs7bYAO
         880eTRkSqRu/r7E1L3noMD1KcmGHufV9nWspTVwy6deuZwsaBvPqkRSSCBZhRkjKyLnq
         QSWEj7WLbh8fbWTAI0GZPeBUprgYQt0jZeV+T307CtT3eVTyVwzCq9i4XXeVZ3jIhskr
         BeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8ft55r/VTfoT4ZinxhB51u9HRB18drBxk6cMGVkRIc=;
        b=7syiWjEBU2i3UYpOuIvmqormJ3O7ZY7NJyp8+lg2bbw219yH8+Hm9FVASNVVzGRWi5
         YvMFvoU+M400Q4/JCnIFAjX/AlobvKlCvwx0aAddeodbNplpM807WP/4RcTD7E59Rcyg
         VHcaHdAunPU4ZEd+dr8t7Cc7fSCA6z0c+EAUeSTPBauZxa5vLP98DVlXaY3ISc9vIfHu
         zIDKb2/BLdzCkwrJ/br8nPe4/nYSqvA1WeA3n5dmhPFcuXb8U9mk3bknqMAMREWWII0A
         1XfJq1KukDIMH58QKbg1rlAfGmmuNixB8Xro+rtgYXpdc3wUn/x+0IL81aRnz2CEaFOy
         dPwA==
X-Gm-Message-State: AOAM531b5DDYkZta1RhhMcNTNKmuvSAmE9Igef7VZ2KRxfDjkA+W8td2
        MNL2ghfIv/sduvDUXvU75RSpTg==
X-Google-Smtp-Source: ABdhPJy8a01fRIV4nGG4Fscsyj42sS294OeFwsAc/3btG49ySTvEgsDMP+HVgRNeNNfgTB6q6/T4XA==
X-Received: by 2002:a17:90a:5995:b0:1bc:be7f:f5a1 with SMTP id l21-20020a17090a599500b001bcbe7ff5a1mr15573946pji.84.1646032300573;
        Sun, 27 Feb 2022 23:11:40 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm16240390pjs.7.2022.02.27.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:11:40 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Date:   Mon, 28 Feb 2022 15:10:22 +0800
Message-Id: <20220228071022.26143-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228071022.26143-1-songmuchun@bytedance.com>
References: <20220228071022.26143-1-songmuchun@bytedance.com>
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

We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
server to enable the feature of freeing vmemmap pages of HugeTLB
pages. Rebooting usually taske a long time. Add a sysctl to enable
the feature at runtime and do not need to reboot.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
 include/linux/hugetlb.h                 |  5 +++++
 include/linux/memory_hotplug.h          |  1 +
 kernel/sysctl.c                         | 11 +++++++++++
 mm/hugetlb_vmemmap.c                    | 23 +++++++++++++++++------
 mm/hugetlb_vmemmap.h                    |  4 +++-
 mm/memory_hotplug.c                     |  2 +-
 7 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f4804ce37c58..01f18e6cc227 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -561,6 +561,19 @@ Change the minimum size of the hugepage pool.
 See Documentation/admin-guide/mm/hugetlbpage.rst
 
 
+hugetlb_free_vmemmap
+====================
+
+A toggle value indicating if vmemmap pages are allowed to be optimized.
+If it is off (0), then it can be set true (1).  Once true, the vmemmap
+pages associated with each HugeTLB page will be optimized, and the toggle
+cannot be set back to false.  It only optimizes the subsequent allocation
+of HugeTLB pages from buddy system, while already allocated HugeTLB pages
+will not be optimized.
+
+See Documentation/admin-guide/mm/hugetlbpage.rst
+
+
 nr_hugepages_mempolicy
 ======================
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53c1b6082a4c..cc4ab21892f5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1080,6 +1080,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+int hugetlb_vmemmap_sysctl_handler(struct ctl_table *table, int write,
+				   void *buffer, size_t *length, loff_t *ppos);
+#endif
+
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
 {
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e0b2209ab71c..b30f9fdaed73 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -349,6 +349,7 @@ extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
 extern bool mhp_supports_memmap_on_memory(unsigned long size);
+extern bool memmap_on_memory;
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ab3e9c937268..77f039849b2a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2223,6 +2223,17 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= hugetlb_sysctl_handler,
 	},
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	{
+		.procname	= "hugetlb_free_vmemmap",
+		.data		= &hugetlb_free_vmemmap_enabled_key.key,
+		.maxlen		= sizeof(hugetlb_free_vmemmap_enabled_key.key),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= hugetlb_vmemmap_sysctl_handler,
+		.extra1		= SYSCTL_ONE,
+	},
+#endif
 #ifdef CONFIG_NUMA
 	{
 		.procname       = "nr_hugepages_mempolicy",
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 836d1117f08b..3167021055d6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
+#include <linux/memory_hotplug.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -118,17 +119,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_free_vmemmap_enabled())
-		return;
-
-	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON) &&
-	    !is_power_of_2(sizeof(struct page))) {
+	if (!is_power_of_2(sizeof(struct page))) {
 		/*
 		 * The hugetlb_free_vmemmap_enabled_key can be enabled when
 		 * CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON. It should
 		 * be disabled if "struct page" crosses page boundaries.
 		 */
-		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
+		if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON))
+			static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
 		return;
 	}
 
@@ -147,3 +145,16 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
 		h->name);
 }
+
+int hugetlb_vmemmap_sysctl_handler(struct ctl_table *table, int write,
+				   void *buffer, size_t *length, loff_t *ppos)
+{
+	/*
+	 * The vmemmap pages cannot be optimized if a "struct page" crosses page
+	 * boundaries or memory_hotplug.memmap_on_memory is enabled.
+	 */
+	if (write && (!is_power_of_2(sizeof(struct page)) || memmap_on_memory))
+		return -EPERM;
+
+	return proc_do_static_key(table, write, buffer, length, ppos);
+}
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
index c226a337c1ef..b5cc5abde05a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -46,7 +46,7 @@
 /*
  * memory_hotplug.memmap_on_memory parameter
  */
-static bool memmap_on_memory __ro_after_init;
+bool memmap_on_memory __ro_after_init;
 #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
 module_param(memmap_on_memory, bool, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
-- 
2.11.0

