Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3394F1048
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377798AbiDDHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377792AbiDDHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:49:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9053B028
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:47:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so476621plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLdrPfzfFhe0FD0vYILkdtb9G4w8CHIGtiLey2rvfw8=;
        b=78DXuMTunFMf5V2vrc40rzu6yjpZRWkp0Ts1Za48QZbHqzxa78WeDuvLe47XTZYvNX
         KCRWou8zyu4lG8i0WMA4x00bsrnBpxpuVvsh6C/94GisJnUTPkHV0pVncSsThaiVab2J
         bMWY32eHZtnklZaKysstLy0UnE0EZeNPZnqA7zOZXzr0eKt+8662KHpmyloNVo9DoLzv
         Y1rSSVnjJ7V1sPZIp4N3i9dVJBw2iNKE05vsWQOJ7Gyd7Y/87GqoPMoEGwm47RhuHPGH
         Ltom9FCpbey3Y57RMvVif1zH7MF08RG/ViEPTmUwhnzJhsBOI1y9X/JGzPDZHyryKwqP
         MbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLdrPfzfFhe0FD0vYILkdtb9G4w8CHIGtiLey2rvfw8=;
        b=EECcm7JKQqeLe2NDDUktYEdga1rYP6yL0uWkUJ5cIQmsMmnQO6tKcOvCrmkhbxw4Ze
         G5ieg2OTdc/4/jRvFPRsCsQLnh19PA8VBONuBh7fDtDijtPnGX4ZxeCV360gbu9XjyvI
         F/h6HUgK+xy0K5ZNILSxEQZTXNi+a8ANFd57UfhzVXvfOneqK4elWti2aNRtvmyuG0gh
         +VxysWh7BnenaexL9UpB37DhpEKYdWHPcjI/CqcV1Imj4WCTKqOMhK9FgIvccSu5Nm7g
         nA8f9zqHS1Gja9g4IB7xs+AK/9uFa1QYswa/4XmOqO6I+DO6vc7PfpW5XtlM8bk+7DCO
         9ZOA==
X-Gm-Message-State: AOAM532kEwGJSk7uKclcHwXqdb1hK90PoL/DVQ7lAYcjWozGvRUPmHd8
        77N+UUKKC7uKgJ++zt4gZxbCjw==
X-Google-Smtp-Source: ABdhPJyXQqHUSwFeKwVmfqRrJa7how2ljLBKmlg1Oa5U6X04bi8XhqkZsPdPuCRM5vf1hNRH9R0JVA==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr21867931plo.166.1649058444200;
        Mon, 04 Apr 2022 00:47:24 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm9376579pgc.64.2022.04.04.00.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:47:23 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/3] mm: hugetlb_vmemmap: cleanup hugetlb_free_vmemmap_enabled*
Date:   Mon,  4 Apr 2022 15:46:51 +0800
Message-Id: <20220404074652.68024-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220404074652.68024-1-songmuchun@bytedance.com>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
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

The word of "free" is not expressive enough to express the feature of optimizing
vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
In this patch , cheanup the static key and hugetlb_free_vmemmap_enabled() to make
code more expressive.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/flush.c      |  2 +-
 include/linux/page-flags.h | 12 ++++++------
 mm/hugetlb_vmemmap.c       | 10 +++++-----
 mm/memory_hotplug.c        |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 1efd01e10cba..d19a13234a81 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -85,7 +85,7 @@ void flush_dcache_page(struct page *page)
 	 * set since the head vmemmap page frame is reused (more details can
 	 * refer to the comments above page_fixed_fake_head()).
 	 */
-	if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
+	if (hugetlb_optimize_vmemmap_enabled() && PageHuge(page))
 		page = compound_head(page);
 
 	if (test_bit(PG_dcache_clean, &page->flags))
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9f488668a1d7..557d15ef3dc0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -201,16 +201,16 @@ enum pageflags {
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
-			 hugetlb_free_vmemmap_enabled_key);
+			 hugetlb_optimize_vmemmap_key);
 
-static __always_inline bool hugetlb_free_vmemmap_enabled(void)
+static __always_inline bool hugetlb_optimize_vmemmap_enabled(void)
 {
 	return static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
-				   &hugetlb_free_vmemmap_enabled_key);
+				   &hugetlb_optimize_vmemmap_key);
 }
 
 /*
- * If the feature of freeing some vmemmap pages associated with each HugeTLB
+ * If the feature of optimizing vmemmap pages associated with each HugeTLB
  * page is enabled, the head vmemmap page frame is reused and all of the tail
  * vmemmap addresses map to the head vmemmap page frame (furture details can
  * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
@@ -227,7 +227,7 @@ static __always_inline bool hugetlb_free_vmemmap_enabled(void)
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!hugetlb_free_vmemmap_enabled())
+	if (!hugetlb_optimize_vmemmap_enabled())
 		return page;
 
 	/*
@@ -256,7 +256,7 @@ static inline const struct page *page_fixed_fake_head(const struct page *page)
 	return page;
 }
 
-static inline bool hugetlb_free_vmemmap_enabled(void)
+static inline bool hugetlb_optimize_vmemmap_enabled(void)
 {
 	return false;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 91b79b9d9e25..f25294973398 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -189,8 +189,8 @@
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
-			hugetlb_free_vmemmap_enabled_key);
-EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
+			hugetlb_optimize_vmemmap_key);
+EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
 static int __init hugetlb_vmemmap_early_param(char *buf)
 {
@@ -204,9 +204,9 @@ static int __init hugetlb_vmemmap_early_param(char *buf)
 		return -EINVAL;
 
 	if (!strcmp(buf, "on"))
-		static_branch_enable(&hugetlb_free_vmemmap_enabled_key);
+		static_branch_enable(&hugetlb_optimize_vmemmap_key);
 	else if (!strcmp(buf, "off"))
-		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
+		static_branch_disable(&hugetlb_optimize_vmemmap_key);
 	else
 		return -EINVAL;
 
@@ -282,7 +282,7 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_free_vmemmap_enabled())
+	if (!hugetlb_optimize_vmemmap_enabled())
 		return;
 
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3fb4196094d9..74430f88853d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1273,7 +1273,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       populate a single PMD.
 	 */
 	return memmap_on_memory &&
-	       !hugetlb_free_vmemmap_enabled() &&
+	       !hugetlb_optimize_vmemmap_enabled() &&
 	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-- 
2.11.0

