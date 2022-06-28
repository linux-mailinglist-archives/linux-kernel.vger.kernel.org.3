Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6F55E2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbiF1JYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbiF1JYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB522BCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h192so11654957pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GadOaB9//lTjsftcfvLcU7ls1fHJ0eHs1kLHSyAzf48=;
        b=uIFwED43iTWw2M0vHEtBVjPF4wMne05WSqqCpyGzzgJLiqgFVBC/FT3uZs1BH9nB5S
         kGPj5F2xAffSLbTN2oXrNvLXriMHlfrgsaPFtIMaE4Ijx+PtwYPFp4BocQwa83WBLKPp
         f3NB8knmejgYe9/DZmjhsykYjXKjvnZP3IztFkPQYBe+H0EYJagTFTo3umMnRLQLhEDA
         4fmKWjUQQ9ngNa/3AOmAwok+bglel39uGX2XC/z8S+QcvVUqQHHZH9gGYhU2qrEW6RZM
         CjltfcgaPlT26E83vT0NpmSuUDzm4yZKIybjVhj2dCTGTOn3HWxHFPt6L5iKjj6JRlxR
         /0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GadOaB9//lTjsftcfvLcU7ls1fHJ0eHs1kLHSyAzf48=;
        b=CGR9yOrZmMX5a3cylZrbpAKqfp78bHD5fgY3IuiQn2VABn6jRf9fW8Xbn/Wg/f9F4i
         FgDhfiTpuq3Sd6NOiBoxSEMgTH7oFZkKbXtf8IUxKbQxtWdQuo1wSu+N4957MZSOf/ch
         loYjmf1hch6Qj2TLwzB1tvCbn8dPxfFRy+bNU+H8xyfbR5TVKNtQnjEUvyPZzKwRpTgI
         jA1WXuZJEpR3ykZNpdQOQ8Va3+Tvsuzb8bXOUo9gHAZf6tJQ73LO6XYTGIfNoSbDDc+P
         owMgAayGLU7lgbJLHYfr2rxv6J2ZeeoqPBRZ0JzAvq8+0Dtla/h3O8zoVrAgdeI6DjxZ
         j93g==
X-Gm-Message-State: AJIora9FZl8Ug8+bc/26SHxYNARkQXhnkEawD7u+4qAJWfBvpjTN1zFl
        TIUBVPOcknXN3Ds+XGFJkSF3Fg==
X-Google-Smtp-Source: AGRyM1t6Ppx0XVD1JhEmnFdJgiMDcffWiFZvh9iTr4GrrpCCd/kYZfZVd3D5Pitcc4s9IFx/XV7BaQ==
X-Received: by 2002:a63:904b:0:b0:40d:1d01:39aa with SMTP id a72-20020a63904b000000b0040d1d0139aamr16508254pge.68.1656408241430;
        Tue, 28 Jun 2022 02:24:01 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:24:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/8] mm: hugetlb_vmemmap: introduce the name HVO
Date:   Tue, 28 Jun 2022 17:22:30 +0800
Message-Id: <20220628092235.91270-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220628092235.91270-1-songmuchun@bytedance.com>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
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

It it inconvenient to mention the feature of optimizing vmemmap pages associated
with HugeTLB pages when communicating with others since there is no specific or
abbreviated name for it when it is first introduced.  Let us give it a name HVO
(HugeTLB Vmemmap Optimization) from now.

This commit also updates the document about "hugetlb_free_vmemmap" by the way
discussed in thread [1].

Link: https://lore.kernel.org/all/21aae898-d54d-cc4b-a11f-1bb7fddcfffa@redhat.com/ [1]
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
 Documentation/admin-guide/mm/hugetlbpage.rst    |  4 ++--
 Documentation/admin-guide/mm/memory-hotplug.rst |  4 ++--
 Documentation/admin-guide/sysctl/vm.rst         |  3 +--
 Documentation/vm/vmemmap_dedup.rst              |  2 ++
 fs/Kconfig                                      | 12 +++++-------
 include/linux/page-flags.h                      |  3 +--
 mm/hugetlb_vmemmap.c                            |  8 ++++----
 mm/hugetlb_vmemmap.h                            |  4 ++--
 9 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 578eb9ef1089..1e30e826041d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1725,12 +1725,13 @@
 	hugetlb_free_vmemmap=
 			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
+			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
 			Allows heavy hugetlb users to free up some more
 			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
-			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }
+			Format: { on | off (default) }
 
-			[oO][Nn]/Y/y/1: enable the feature
-			[oO][Ff]/N/n/0: disable the feature
+			on: enable HVO
+			off: disable HVO
 
 			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
 			the default is on.
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index a90330d0a837..8e2727dc18d4 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -164,8 +164,8 @@ default_hugepagesz
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
 hugetlb_free_vmemmap
-	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
-	unused vmemmap pages associated with each HugeTLB page.
+	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HugeTLB
+	Vmemmap Optimization (HVO).
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 0f56ecd8ac05..a3c9e8ad8fa0 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -653,8 +653,8 @@ block might fail:
 - Concurrent activity that operates on the same physical memory area, such as
   allocating gigantic pages, can result in temporary offlining failures.
 
-- Out of memory when dissolving huge pages, especially when freeing unused
-  vmemmap pages associated with each hugetlb page is enabled.
+- Out of memory when dissolving huge pages, especially when HugeTLB Vmemmap
+  Optimization (HVO) is enabled.
 
   Offlining code may be able to migrate huge page contents, but may not be able
   to dissolve the source huge page because it fails allocating (unmovable) pages
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e3a952d1fd35..f15099eaaf36 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -569,8 +569,7 @@ This knob is not available when the size of 'struct page' (a structure defined
 in include/linux/mm_types.h) is not power of two (an unusual system config could
 result in this).
 
-Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
-associated with each HugeTLB page.
+Enable (set to 1) or disable (set to 0) HugeTLB Vmemmap Optimization (HVO).
 
 Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
 buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
diff --git a/Documentation/vm/vmemmap_dedup.rst b/Documentation/vm/vmemmap_dedup.rst
index c9c495f62d12..7d7a161aa364 100644
--- a/Documentation/vm/vmemmap_dedup.rst
+++ b/Documentation/vm/vmemmap_dedup.rst
@@ -7,6 +7,8 @@ A vmemmap diet for HugeTLB and Device DAX
 HugeTLB
 =======
 
+This section is to explain how HugeTLB Vmemmap Optimization (HVO) works.
+
 The struct page structures (page structs) are used to describe a physical
 page frame. By default, there is a one-to-one mapping from a page frame to
 it's corresponding page struct.
diff --git a/fs/Kconfig b/fs/Kconfig
index 5976eb33535f..a547307c1ae8 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -247,8 +247,7 @@ config HUGETLB_PAGE
 
 #
 # Select this config option from the architecture Kconfig, if it is preferred
-# to enable the feature of minimizing overhead of struct page associated with
-# each HugeTLB page.
+# to enable the feature of HugeTLB Vmemmap Optimization (HVO).
 #
 config ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	bool
@@ -259,14 +258,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
 
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
-	bool "Default optimizing vmemmap pages of HugeTLB to on"
+	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
 	default n
 	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  When using HUGETLB_PAGE_OPTIMIZE_VMEMMAP, the optimizing unused vmemmap
-	  pages associated with each HugeTLB page is default off. Say Y here
-	  to enable optimizing vmemmap pages of HugeTLB by default. It can then
-	  be disabled on the command line via hugetlb_free_vmemmap=off.
+	  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
+	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
+	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
 
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b44cc24d7496..78ed46ae6ee5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -208,8 +208,7 @@ enum pageflags {
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
 /*
- * If the feature of optimizing vmemmap pages associated with each HugeTLB
- * page is enabled, the head vmemmap page frame is reused and all of the tail
+ * If HVO is enabled, the head vmemmap page frame is reused and all of the tail
  * vmemmap addresses map to the head vmemmap page frame (furture details can
  * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
  * words, there are more than one page struct with PG_head associated with each
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0c2f15a35d62..7161f86a43a6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Optimize vmemmap pages associated with HugeTLB
+ * HugeTLB Vmemmap Optimization (HVO)
  *
- * Copyright (c) 2020, Bytedance. All rights reserved.
+ * Copyright (c) 2020, ByteDance. All rights reserved.
  *
  *     Author: Muchun Song <songmuchun@bytedance.com>
  *
@@ -156,8 +156,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 
 	/*
 	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
-	 * page structs that can be used when CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP,
-	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 * page structs that can be used when HVO is enabled, add a BUILD_BUG_ON
+	 * to catch invalid usage of the tail page structs.
 	 */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 109b0a53b6fe..ba66fadad9fc 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Optimize vmemmap pages associated with HugeTLB
+ * HugeTLB Vmemmap Optimization (HVO)
  *
- * Copyright (c) 2020, Bytedance. All rights reserved.
+ * Copyright (c) 2020, ByteDance. All rights reserved.
  *
  *     Author: Muchun Song <songmuchun@bytedance.com>
  */
-- 
2.11.0

