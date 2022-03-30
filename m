Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC34EC867
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiC3PkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348295AbiC3PkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:40:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF16BDEB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q19so17898316pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h81o0zrOo3MmiqLhXNQs++uBdbtx9emPgi7EUEIWoeg=;
        b=JXogY18B9Li/QyeeQ4h7enOzye+7Wr8M0oHfdOsyIxsicMR+wphDN2S28Ok7Vv8mdR
         eL333WRR6cAOAplCN9S83Sr/2pct5HkiQuApm024TGDeF3zdy8gDMgcbfc1C4EWTGo+T
         CTLxjMbvCmzR069ibJLzijcoTpRYGVpzxPsRdVmJoP5NfbwjQNyJuFizCykL4QX3yARm
         0RFDiHzSa8dfgySYTeGQ56ULbR4LK+K0YRzlfqicbWDG0uk832apkSH7eRbg3+x2l9mB
         I9TRDPNd6KyLjydqjWKxWy+paxKkoOpVdsmEEcnwesmyFej03cLc66wlWa+RVW1qDRdE
         Fzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h81o0zrOo3MmiqLhXNQs++uBdbtx9emPgi7EUEIWoeg=;
        b=ox421O6cTxsS9l5aZlQ88G4LR1elBaAgUaxxchhrosLfale8D3Vxk3GSAI5TUGAt4n
         Qt03Q4nmaZimZ2mpf5ihOxGp2RV3WcBFfBlPKhZb0zMd9dlgdsU/s6eWKfBAwM5gXPZY
         d2I48FnjZ0EEP4gxRQR05LT66MPofBBqok7Igl4iNOBCAcpcHaBNvRlo0V8IyhoqGijd
         f2tF1KNsVntmfAU9le2D3COYxH42xMoI4aJIIEQl6bVoaPpgXOPVZkuWrnmeLNrVpGDo
         iwbT1nVzSKcQKt1DKsOeIbtgxRA/3aXKLMMA7TdD5MJRBsmud7MlRfLloliCMBcNcTnm
         pn/Q==
X-Gm-Message-State: AOAM533STjNYgAciEiDQ7PsDadNwyLeMA9FtOmvfIT26ed5/sEjhGddF
        ocpUIb+J2ZHagP/L+bhAMTMpgQ==
X-Google-Smtp-Source: ABdhPJw76LGvWldqRycLoo/x5V2Cwand9sJPfGmDuBBYpLXujydBQNXxINbnTmeUG6iu8MQAG80cQg==
X-Received: by 2002:a63:520c:0:b0:382:2953:a338 with SMTP id g12-20020a63520c000000b003822953a338mr6618861pgb.610.1648654706651;
        Wed, 30 Mar 2022 08:38:26 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm6686039pjp.9.2022.03.30.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:38:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
Date:   Wed, 30 Mar 2022 23:37:42 +0800
Message-Id: <20220330153745.20465-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220330153745.20465-1-songmuchun@bytedance.com>
References: <20220330153745.20465-1-songmuchun@bytedance.com>
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

If the size of "struct page" is not the power of two and this
feature is enabled, then the vmemmap pages of HugeTLB will be
corrupted after remapping (panic is about to happen in theory).
But this only exists when !CONFIG_MEMCG && !CONFIG_SLUB on
x86_64.  However, it is not a conventional configuration nowadays.
So it is not a real word issue, just the result of a code review.
But we have to prevent anyone from configuring that combined
configuration.  In order to avoid many checks like "is_power_of_2
(sizeof(struct page))" through mm/hugetlb_vmemmap.c.  Introduce
STRUCT_PAGE_SIZE_IS_POWER_OF_2 to detect if the size of struct
page is power of 2 and make this feature depends on this new
macro.  Then we could prevent anyone do any unexpected
configuration.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Kbuild                     | 15 ++++++++++++++-
 include/linux/mm_types.h   |  2 ++
 include/linux/page-flags.h |  3 ++-
 mm/hugetlb_vmemmap.c       |  8 ++------
 mm/hugetlb_vmemmap.h       |  4 ++--
 mm/struct_page_size.c      | 20 ++++++++++++++++++++
 6 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 mm/struct_page_size.c

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..7f90ba21dd51 100644
--- a/Kbuild
+++ b/Kbuild
@@ -24,6 +24,19 @@ $(timeconst-file): kernel/time/timeconst.bc FORCE
 	$(call filechk,gentimeconst)
 
 #####
+# Generate struct_page_size.h.
+
+struct_page_size-file := include/generated/struct_page_size.h
+
+always-y += $(struct_page_size-file)
+targets += mm/struct_page_size.s
+
+mm/struct_page_size.s: $(timeconst-file) $(bounds-file)
+
+$(struct_page_size-file): mm/struct_page_size.s FORCE
+	$(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
+
+#####
 # Generate asm-offsets.h
 
 offsets-file := include/generated/asm-offsets.h
@@ -31,7 +44,7 @@ offsets-file := include/generated/asm-offsets.h
 always-y += $(offsets-file)
 targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 
-arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
+arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file) $(struct_page_size-file)
 
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..5fbff44a4310 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -223,6 +223,7 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+#ifndef __GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -844,5 +845,6 @@ enum fault_flag {
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 };
+#endif /* !__GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H */
 
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fc4f294cc8d7..15fcdff0e7ee 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -12,6 +12,7 @@
 #ifndef __GENERATING_BOUNDS_H
 #include <linux/mm_types.h>
 #include <generated/bounds.h>
+#include <generated/struct_page_size.h>
 #endif /* !__GENERATING_BOUNDS_H */
 
 /*
@@ -190,7 +191,7 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#if defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP) && defined(STRUCT_PAGE_SIZE_IS_POWER_OF_2)
 DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
 			 hugetlb_free_vmemmap_enabled_key);
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 791626983c2e..951cf83010c7 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -178,6 +178,7 @@
 
 #include "hugetlb_vmemmap.h"
 
+#ifdef STRUCT_PAGE_SIZE_IS_POWER_OF_2
 /*
  * There are a lot of struct page structures associated with each HugeTLB page.
  * For tail pages, the value of compound_head is the same. So we can reuse first
@@ -194,12 +195,6 @@ EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
-	/* We cannot optimize if a "struct page" crosses page boundaries. */
-	if (!is_power_of_2(sizeof(struct page))) {
-		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
-		return 0;
-	}
-
 	if (!buf)
 		return -EINVAL;
 
@@ -302,3 +297,4 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
 		h->name);
 }
+#endif /* STRUCT_PAGE_SIZE_IS_POWER_OF_2 */
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..b137fd8b6ba4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,7 +10,7 @@
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#if defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP) && defined(STRUCT_PAGE_SIZE_IS_POWER_OF_2)
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_init(struct hstate *h);
@@ -41,5 +41,5 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
 }
-#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP && STRUCT_PAGE_SIZE_IS_POWER_OF_2 */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
diff --git a/mm/struct_page_size.c b/mm/struct_page_size.c
new file mode 100644
index 000000000000..6fc29c1227a0
--- /dev/null
+++ b/mm/struct_page_size.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generate definitions needed by the preprocessor.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#define __GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H
+/* Include headers that define the enum constants of interest */
+#include <linux/mm_types.h>
+#include <linux/kbuild.h>
+#include <linux/log2.h>
+
+int main(void)
+{
+	if (is_power_of_2(sizeof(struct page)))
+		DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, is_power_of_2(sizeof(struct page)));
+
+	return 0;
+}
-- 
2.11.0

