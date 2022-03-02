Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F144C9F73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiCBIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiCBIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:39:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DE58811
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:38:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a5so1279444pfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FsguA/yBosoWVXOBb/NOWtMqUfetLJMnNLuw820odF8=;
        b=aoo/dmpx/Y3ySAakcLWA1JW/gsNtfCZsFCp7C9m9iPc/FMnmQ5SHJYSFN4vnU/+xhl
         GX8jo5gIoywnNFv8qbAzJPx4v1w9ge2Fv0/hAigO6k5OVdT0qutEtXtRk4K9EdHEMSRi
         6Isz27oMi4I6u/onl+n345h1XkIFKARGlkXjzRyvyPTTxs7pyyBo8f+YCebRUgiQjOeG
         zYX/2zCZgHwcgM31YNTvSXCEcemDhgeygmYYaFSjQOsLechWkyWmNINL6YxeXJI/LDLO
         QxJYX7xQjChx8lf9G5HruPNL+o2GhaI3EmXgiev/8nO4SaNF57632fNeYaq0baUoD/Pf
         lhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FsguA/yBosoWVXOBb/NOWtMqUfetLJMnNLuw820odF8=;
        b=JlVlshDAPPYEFt7kLJhqhTz8xRO5IsO9Co2GdsRrKptToSamHel5+GmZXF5CYpg3uP
         3+3K6jEQv69fGgw8f+bZocwTg62EAAxh+w6kPeWkmAAm+7z/H1o4rMdzioSlpm6McP07
         wtqmMs5NnulfX/bH6S6AP5wZb88Y8wiULJqZn2zTUd1+9zcBVwkxbxG6GdC9wWEtOL1f
         lgupH1KdHmXhiWITEmxsTYY0RrXaVAfnujCUCpSO0X5guRxKnxsf3GdXA7hU6nlYPoqL
         GsruadNoGxNRB9Cg5eeoo+NDTXN9SWt488qGx1etJFR4w0nrot1OHSaeYEQIBPbEJklP
         xeGw==
X-Gm-Message-State: AOAM531oImgDqP1yj4m7iQSxMMpKnipb5r9+9bAzuYjQE5Q1c44saSUY
        u6XBO3w53csfIVQOhxt3+3yxew==
X-Google-Smtp-Source: ABdhPJzzyoMiaWMi1HQFsB5f52pvjW1fFVtWj8+EB7226uejAhqYNfoWYUPN+0gKyHoYqQxixEsFqg==
X-Received: by 2002:a63:134a:0:b0:378:9ef8:950a with SMTP id 10-20020a63134a000000b003789ef8950amr12445378pgt.548.1646210312444;
        Wed, 02 Mar 2022 00:38:32 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm18705141pfl.24.2022.03.02.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:38:32 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Date:   Wed,  2 Mar 2022 16:37:58 +0800
Message-Id: <20220302083758.32528-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302083758.32528-1-songmuchun@bytedance.com>
References: <20220302083758.32528-1-songmuchun@bytedance.com>
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
 Documentation/admin-guide/sysctl/vm.rst | 13 ++++++++++
 include/linux/memory_hotplug.h          |  9 +++++++
 mm/hugetlb_vmemmap.c                    | 42 ++++++++++++++++++++++++++++-----
 mm/hugetlb_vmemmap.h                    |  4 +++-
 mm/memory_hotplug.c                     |  5 ++++
 5 files changed, 66 insertions(+), 7 deletions(-)

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
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e0b2209ab71c..20d7edf62a6a 100644
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
index 836d1117f08b..3bcc8f25bd50 100644
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
 
@@ -147,3 +145,35 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
 		h->name);
 }
+
+static struct ctl_table hugetlb_vmemmap_sysctls[] = {
+	{
+		.procname	= "hugetlb_free_vmemmap",
+		.data		= &hugetlb_free_vmemmap_enabled_key.key,
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_do_static_key,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static __init int hugetlb_vmemmap_sysctls_init(void)
+{
+	/*
+	 * The vmemmap pages cannot be optimized if
+	 * "memory_hotplug.memmap_on_memory" is enabled unless
+	 * "hugetlb_free_vmemmap" is enabled as well since
+	 * "hugetlb_free_vmemmap" takes precedence over
+	 * "memory_hotplug.memmap_on_memory".
+	 */
+	if (mhp_memmap_on_memory() && !hugetlb_free_vmemmap_enabled())
+		return 0;
+
+	if (is_power_of_2(sizeof(struct page)))
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
index c226a337c1ef..c2115e566abc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -50,6 +50,11 @@ static bool memmap_on_memory __ro_after_init;
 #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
 module_param(memmap_on_memory, bool, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
+
+bool mhp_memmap_on_memory(void)
+{
+	return memmap_on_memory;
+}
 #endif
 
 enum {
-- 
2.11.0

