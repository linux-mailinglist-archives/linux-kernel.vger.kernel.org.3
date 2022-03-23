Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F268A4E529E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiCWM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbiCWM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:58:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7D7C7A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:57:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c11so1035569pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8U++b74ADZPjIiOkZZbim39PJyVay6HYO7+jpHyJ7BU=;
        b=fuvlOqlnx4uwam7PbWcvOe9tU8gNtjEOl+4ijCOT65bO9wP7Hl7SprBh6d1rQVhw3t
         7XW8w8EomUGuwR04Iik6xJW8mJUKc/FISyN3Tlfxr4qxfANF/Ar1WO9NW7oI1PXVWXKM
         Z3uOIqqJRTxopgmzOVGCHLh48mVCZwsMx+8MxQJV5b8ywKU/uUY34MsDjePT98oshcrM
         lg+vV1H4wiCBvksP8h9SWYwWpi7nCgJn2cjEAPOnXdMRCDSRaIILcVKQz0wYvy46EKtS
         hNpvq2cHKJIGg85cYYd9u10qBt0aURe1Oh/c/Co/ouAxxzcDZFqay0SvL5oBOxsCVHu0
         a12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8U++b74ADZPjIiOkZZbim39PJyVay6HYO7+jpHyJ7BU=;
        b=tJTxYAZeEpFtq5wwG0ArdWTB+IQWpVPRcerrbQt2km1rKeUeNteqy/2mr/lF+VkumR
         Z3pQVwvvVv7T0GaZrQfV8vOfg4r3gI4xFkzeUmhv8kzsNHL0pNUj0ob4w4BasHgPXsLB
         9VaWCpns1bX+Km3Sbr/K+3JQuUbFO5+2LtdSsTOOaP0DxPE0BZTVUOMU11V4mDaK2vl5
         aRhdLJFETGfyMnEJDuF1ccbYgHkJK5VcnrbLm0Sdqeu6Zcoq6QLtE17zhHbj8+stoY9P
         +nhXPDRcb/w3sT/I9ej8uHlXmAqxqcGPWAVQ1W/68NgMnWx2bH5AZMXxH8VlkVTkGy3V
         Zsdg==
X-Gm-Message-State: AOAM531ssUiWOkY5D9pLocNFQnc1Feu78N3xhsv7Rsv1wAd4fF6/kpNw
        QIV6KIzMuA1OiMw/mirCZuF2mw==
X-Google-Smtp-Source: ABdhPJxME2zOZXrnFN9UyKcNEF/huqi8q5lIdipbwtt+diUrlSh84HhmazStaDoumJy/UyhW5GLunw==
X-Received: by 2002:a62:6101:0:b0:4fa:7ff4:b543 with SMTP id v1-20020a626101000000b004fa7ff4b543mr22479202pfb.75.1648040240170;
        Wed, 23 Mar 2022 05:57:20 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm15716517pgd.27.2022.03.23.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:57:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
Date:   Wed, 23 Mar 2022 20:55:20 +0800
Message-Id: <20220323125523.79254-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220323125523.79254-1-songmuchun@bytedance.com>
References: <20220323125523.79254-1-songmuchun@bytedance.com>
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
config.  Then we could prevent anyone do any unexpected
configuration.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Kbuild                           | 14 ++++++++++++++
 fs/Kconfig                       |  1 +
 include/linux/mm_types.h         |  2 ++
 mm/Kconfig                       |  3 +++
 mm/hugetlb_vmemmap.c             |  6 ------
 mm/struct_page_size.c            | 19 +++++++++++++++++++
 scripts/check_struct_page_po2.sh |  9 +++++++++
 7 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 mm/struct_page_size.c
 create mode 100755 scripts/check_struct_page_po2.sh

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..21415c3b2728 100644
--- a/Kbuild
+++ b/Kbuild
@@ -37,6 +37,20 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
 #####
+# Generate struct_page_size.h.
+
+struct_page_size-file := include/generated/struct_page_size.h
+
+always-y := $(struct_page_size-file)
+targets := mm/struct_page_size.s
+
+mm/struct_page_size.s: $(timeconst-file) $(bounds-file)
+
+$(struct_page_size-file): mm/struct_page_size.s FORCE
+	$(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
+	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
+
+#####
 # Check for missing system calls
 
 always-y += missing-syscalls
diff --git a/fs/Kconfig b/fs/Kconfig
index 7f2455e8e18a..856d2e9f5aef 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -249,6 +249,7 @@ config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on X86_64
 	depends on SPARSEMEM_VMEMMAP
+	depends on STRUCT_PAGE_SIZE_IS_POWER_OF_2
 
 config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
 	bool "Default freeing vmemmap pages of HugeTLB to on"
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
diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..9314bd34f49e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -2,6 +2,9 @@
 
 menu "Memory Management options"
 
+config STRUCT_PAGE_SIZE_IS_POWER_OF_2
+	def_bool $(success,test "$(shell, $(srctree)/scripts/check_struct_page_po2.sh)" = 1)
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 791626983c2e..33ecb77c2b2a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -194,12 +194,6 @@ EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
 
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
 
diff --git a/mm/struct_page_size.c b/mm/struct_page_size.c
new file mode 100644
index 000000000000..5749609aa1b3
--- /dev/null
+++ b/mm/struct_page_size.c
@@ -0,0 +1,19 @@
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
+	DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, is_power_of_2(sizeof(struct page)));
+
+	return 0;
+}
diff --git a/scripts/check_struct_page_po2.sh b/scripts/check_struct_page_po2.sh
new file mode 100755
index 000000000000..1764ef9a4f1d
--- /dev/null
+++ b/scripts/check_struct_page_po2.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if the size of "struct page" is power of 2
+
+file="include/generated/struct_page_size.h"
+if [ -f "$file" ]; then
+	grep STRUCT_PAGE_SIZE_IS_POWER_OF_2 "$file" | cut -d' ' -f3
+fi
-- 
2.11.0

