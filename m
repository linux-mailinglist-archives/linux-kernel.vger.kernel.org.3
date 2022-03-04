Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073774CCCE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiCDFS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiCDFSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB5C53B5A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEH//nu79wWwuy8WPoBNLdXG3sMM2ihkgiTBywoRJ9c=;
        b=cV05+NNa8PXnC9SW1AzR1aK38Nsc9NtSmYT5y2Obro3mNUWlw1fM4UwylDhFySz3H51ahn
        zESElxBRI+43jdAG/fO7Fv83fLqn6vIqevooAHfwVtdz+yoxV8565A7lF3TTLbG0FSne08
        ghG2CSK86RCCSjifuZMWTZv7203lbKY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-bvto9wAGO0Gb2k0AdEg_dw-1; Fri, 04 Mar 2022 00:17:55 -0500
X-MC-Unique: bvto9wAGO0Gb2k0AdEg_dw-1
Received: by mail-pj1-f70.google.com with SMTP id m9-20020a17090ade0900b001bedf2d1d4cso6200173pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEH//nu79wWwuy8WPoBNLdXG3sMM2ihkgiTBywoRJ9c=;
        b=XEqoABSY31sj45CgVnIo0H1AniK+TL1yYBahK5szwfBnLarCHSsMivwQ2Tk7E0YGE+
         YiByLRSUzsjH2cQhHfGVwWCVrHRjighRpS7/5Bg/Eekg8A/3pLD4/TRXZpJjShLSp6ZV
         N/y1V2wpJNrd0uYtmZvs9JL7mWSA9MsDnyPTzXBWYNeJNxltAXjfdRHwWwYCq0j7qhMt
         JfgTJFYUdPPNzI45TpDN/qjk13UnK9lojVanedUyxpWAX5Qz8j7mOruty3jQ9fO66kZE
         HVbMCdhltR3p8ssS2LJkvrKjiYqPxbZB5lVaPUUQS2ibcnsBSYoD4A8G3ol1VGR2vgt/
         llwg==
X-Gm-Message-State: AOAM5333EKEi9WB1aEGCZQmr9BLvGV6Xxl9LB8kUWmv/g0Aew6SGXtCP
        yAFcf+RP9CWpvgJoscLfrngRTgiEo8AOUIWwt6/mtkyYD4oQrdXwJwOWXPEKo5/UEuKOHb396VH
        XNiFVFxaNtuZ3iLUvJqXCIbZ4
X-Received: by 2002:a17:90a:5d93:b0:1bc:4f9c:8eed with SMTP id t19-20020a17090a5d9300b001bc4f9c8eedmr8907317pji.180.1646371074788;
        Thu, 03 Mar 2022 21:17:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXiEiEBTk5qw5SPMWSMqnxEw34BDQjWY2sS9WIU+2vrSP3R9/ofOCk8lF82RBcX9U1hDyWIw==
X-Received: by 2002:a17:90a:5d93:b0:1bc:4f9c:8eed with SMTP id t19-20020a17090a5d9300b001bc4f9c8eedmr8907294pji.180.1646371074503;
        Thu, 03 Mar 2022 21:17:54 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.17.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:17:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 04/23] mm/uffd: PTE_MARKER_UFFD_WP
Date:   Fri,  4 Mar 2022 13:16:49 +0800
Message-Id: <20220304051708.86193-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the 1st user of pte marker: the uffd-wp marker.

When the pte marker is installed with the uffd-wp bit set, it means this pte
was wr-protected by uffd.

We will use this special pte to arm the ptes that got either unmapped or
swapped out for a file-backed region that was previously wr-protected.  This
special pte could trigger a page fault just like swap entries.

This idea is greatly inspired by Hugh and Andrea in the discussion, which is
referenced in the links below.

Some helpers are introduced to detect whether a swap pte is uffd wr-protected.
After the pte marker introduced, one swap pte can be wr-protected in two forms:
either it is a normal swap pte and it has _PAGE_SWP_UFFD_WP set, or it's a pte
marker that has PTE_MARKER_UFFD_WP set.

Link: https://lore.kernel.org/lkml/20201126222359.8120-1-peterx@redhat.com/
Link: https://lore.kernel.org/lkml/20201130230603.46187-1-peterx@redhat.com/
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h       |  3 ++-
 include/linux/userfaultfd_k.h | 43 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  9 ++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 5103d2a4ae38..2cec3ef355a7 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -249,7 +249,8 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
 
 typedef unsigned long pte_marker;
 
-#define  PTE_MARKER_MASK     (0)
+#define  PTE_MARKER_UFFD_WP  BIT(0)
+#define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
 
 #ifdef CONFIG_PTE_MARKER
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 33cea484d1ad..bd09c3c89b59 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -15,6 +15,8 @@
 
 #include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <asm-generic/pgtable_uffd.h>
 
 /* The set of all possible UFFD-related VM flags. */
@@ -236,4 +238,45 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 
 #endif /* CONFIG_USERFAULTFD */
 
+static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
+{
+	return is_pte_marker_entry(entry) &&
+	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+}
+
+static inline bool pte_marker_uffd_wp(pte_t pte)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	swp_entry_t entry;
+
+	if (!is_swap_pte(pte))
+		return false;
+
+	entry = pte_to_swp_entry(pte);
+
+	return pte_marker_entry_uffd_wp(entry);
+#else
+	return false;
+#endif
+}
+
+/*
+ * Returns true if this is a swap pte and was uffd-wp wr-protected in either
+ * forms (pte marker or a normal swap pte), false otherwise.
+ */
+static inline bool pte_swp_uffd_wp_any(pte_t pte)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	if (!is_swap_pte(pte))
+		return false;
+
+	if (pte_swp_uffd_wp(pte))
+		return true;
+
+	if (pte_marker_uffd_wp(pte))
+		return true;
+#endif
+	return false;
+}
+
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 25bcbb89f8e5..a80ea8721885 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -907,6 +907,15 @@ config PTE_MARKER
 	help
 	  Allows to create marker PTEs for file-backed memory.
 
+config PTE_MARKER_UFFD_WP
+	bool "Marker PTEs support for userfaultfd write protection"
+	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
+
+	help
+	  Allows to create marker PTEs for userfaultfd write protection
+	  purposes.  It is required to enable userfaultfd write protection on
+	  file-backed memory types like shmem and hugetlbfs.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.32.0

