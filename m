Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79994547F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiFMGft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiFMGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903FBCBE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x138so4892318pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+OKPYQ5REAoye/wSsuy111hflzgcPbPLQAUS9w4vzY=;
        b=UYN43vXERJXZ9csVHQZAu3w+v7BI/PQ0oeR4+TZu85yj6WdN/18M7tPeNA86JQv0e9
         SgArwTPIRb2QOuLEAdNysGtz7p4ElisPmsr3carhhenLFpoFRcylbY/nbwXXKm2HtLRF
         Wol3JvHDVcHMeKhemIgfBhErkg6/Jo7+PB+1RDjJb7PRfjKx2EldoY8ueWHgFrIyaC5f
         4irSNHL3qy7UKj3th4VmZDa8vJ4HYoc01II29r3nFIT7jgbCEGQXpmHxkYZbk+1TRwJR
         cY4zcduFoLB93qL6h4m9LTBxkNG2//NyIft3/u5IYhYM0QwOCiIswLcEdxAe2XGt3SIx
         f1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+OKPYQ5REAoye/wSsuy111hflzgcPbPLQAUS9w4vzY=;
        b=ySkdpTCVPRrjGMHobMxWvz0FLeb7bLHWikbNbCBvY8kNrbBnwQkyqiwERB0NLXBN5Z
         /axTo8f10a5EtsMNc7JmtMulmFQziF5fswXnOrqqfJPDcsNpIJ2fWPUuzKnmbl/q0TB+
         ONPp8x7tUDNByKubz7MlPyoE4r8kT4tj319duvVugexaW/NggMYPjTx9wwg4b3i/iPfO
         XbBp9MD2kaQZ6b5oWL8zz25RcY//OBa1qDPD5Vm2AO87lzKmwY06HlFDwqpBPPcZW+zV
         l0IjWuYDXIjF6mJMAPhplJIBUj073pyt8AP4TxYfDN7ApmqQuWZ0FRMd024A4eC6eMtB
         nX0g==
X-Gm-Message-State: AOAM532sgvif2nPd1EzM3cV80twk/Bv5A3E2QCggyzsKFnokGbKuAUs3
        0tl3A8u2ZsH1NFu4trIE5+BJjQ==
X-Google-Smtp-Source: ABdhPJxz7UwWsexBbVriPZbR0Xz+JC+GNqKyElGl7birTSFGxX0z0EQ/fFZlYKwK8LYDlaLorQU6Ug==
X-Received: by 2002:a63:cc09:0:b0:3fb:aae7:4964 with SMTP id x9-20020a63cc09000000b003fbaae74964mr49566503pgf.118.1655102139008;
        Sun, 12 Jun 2022 23:35:39 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
Date:   Mon, 13 Jun 2022 14:35:09 +0800
Message-Id: <20220613063512.17540-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220613063512.17540-1-songmuchun@bytedance.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
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
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +--
 Documentation/admin-guide/sysctl/vm.rst         |  3 +--
 fs/Kconfig                                      | 13 ++++++-------
 mm/hugetlb_vmemmap.c                            |  8 ++++----
 mm/hugetlb_vmemmap.h                            |  4 ++--
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 391b43fee93e..7539553b3fb0 100644
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
index a90330d0a837..64e0d5c512e7 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -164,8 +164,7 @@ default_hugepagesz
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
 hugetlb_free_vmemmap
-	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
-	unused vmemmap pages associated with each HugeTLB page.
+	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HVO.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index d7374a1e8ac9..c9f35db973f0 100644
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
diff --git a/fs/Kconfig b/fs/Kconfig
index 5976eb33535f..2f9fd840cb66 100644
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
@@ -259,14 +258,14 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
 
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
-	bool "Default optimizing vmemmap pages of HugeTLB to on"
+	bool "Default HugeTLB Vmemmap Optimization (HVO) to on"
 	default n
 	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  When using HUGETLB_PAGE_OPTIMIZE_VMEMMAP, the optimizing unused vmemmap
-	  pages associated with each HugeTLB page is default off. Say Y here
-	  to enable optimizing vmemmap pages of HugeTLB by default. It can then
-	  be disabled on the command line via hugetlb_free_vmemmap=off.
+	  When using HUGETLB_PAGE_OPTIMIZE_VMEMMAP, the HugeTLB Vmemmap
+	  Optimization (HVO) is off by default. Say Y here to enable HVO
+	  by default. It can then be disabled on the command line via
+	  hugetlb_free_vmemmap=off or sysctl.
 
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 132dc83f0130..c10540993577 100644
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
@@ -120,8 +120,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 
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

