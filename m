Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F74DD7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiCRKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiCRKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:10:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4CD1FAA0E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso10039999pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbeJa8HYrLQ+Ows7xcLj2fADMbIualKHQUd1u73fRK4=;
        b=IBx1YI1c0P58TKd4LXPU+bCDVhZPQWPKOBH8TT0csj+PyWrDJQrYAyBYgMwHEPjrcb
         wmy9+gVNWxEp39W3uO4PYLgQBReZ6xhSjqamTwHjE8IUr8OxExNQWD6skl3k1D7uXPwa
         CXNyHXn6+I4xx/Fh4th29hxpIOVHXqTzKv7KPuaTlHZClJxgWLbMBp3UslqycmVcKsH8
         T1SDiwH9cZKSuw7ZxxMXl4P/u+7DCCYXu/UuCOzKcmZ/UtLX2FdWt7WKmQ1M+RcRiFDM
         J90y/AKOKdeCXvB1aUXBPEWN7PUWy4LYI61p9E5XxL8zOe5f06Yxr3z2/0SXpu0jkB+g
         G7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbeJa8HYrLQ+Ows7xcLj2fADMbIualKHQUd1u73fRK4=;
        b=Q3dn7pMMG+hZPAWE+/5Y+YOGopDF3NyIGZrCSDlSDwe4iqrwHl1fQr2PQKbDEa5DS3
         IcWGuf7JiX7pgPo3/v6xPuboH6SZCI945/TyWZyu3Roijp/Bqa8J2dGDCT9t8pR5MBMh
         L9CW0cqF5fQmBNNuGrUo8N54CL57PhNYH0ipMBj69Pz00n4sxPuSS1mCS0wZzXtVlLao
         srK19EjHRScvXChfz8YYgx0lmkYZVqdjWElPHT/c2X2yCZUyV/pWDBHGd2LBiSfcjIfv
         6a6x3SqVx2JtSqdP+vvVVim1r32S++rfFx97iWaU5KH3Dq2TxQmFqkTmM8v++Y3pVYWh
         MK0g==
X-Gm-Message-State: AOAM5316WMdhgP5z9lQlHDtczu0HDN2TmEw1SFYiyMRDSBvVeze//yye
        0oKOB42MI1tJlVaBcVEvmx4Uyg==
X-Google-Smtp-Source: ABdhPJyqEhYFHSuQKBWKtSkVNuChtkgjO57/sD0zSO+cpSCWurcOy+Dpdf0HXl5Vc/xUxorWEKVjgA==
X-Received: by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id mi10-20020a17090b4b4a00b001bf083d6805mr21360599pjb.174.1647598154783;
        Fri, 18 Mar 2022 03:09:14 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004fa042e8216sm9541252pfj.2.2022.03.18.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:09:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
Date:   Fri, 18 Mar 2022 18:07:17 +0800
Message-Id: <20220318100720.14524-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318100720.14524-1-songmuchun@bytedance.com>
References: <20220318100720.14524-1-songmuchun@bytedance.com>
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
---
 Kbuild                           | 12 ++++++++++++
 fs/Kconfig                       |  2 +-
 include/linux/mm_types.h         |  2 ++
 mm/Kconfig                       |  3 +++
 mm/hugetlb_vmemmap.c             |  6 ------
 mm/struct_page_size.c            | 19 +++++++++++++++++++
 scripts/check_struct_page_po2.sh | 11 +++++++++++
 7 files changed, 48 insertions(+), 7 deletions(-)
 create mode 100644 mm/struct_page_size.c
 create mode 100755 scripts/check_struct_page_po2.sh

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..6bb97d348d62 100644
--- a/Kbuild
+++ b/Kbuild
@@ -14,6 +14,18 @@ $(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
 #####
+# Generate struct_page_size.h. Must follows bounds.h.
+
+struct_page_size-file := include/generated/struct_page_size.h
+
+always-y := $(struct_page_size-file)
+targets := mm/struct_page_size.s
+
+$(struct_page_size-file): mm/struct_page_size.s FORCE
+	$(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
+	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
+
+#####
 # Generate timeconst.h
 
 timeconst-file := include/generated/timeconst.h
diff --git a/fs/Kconfig b/fs/Kconfig
index 7f2455e8e18a..b8b722f7f773 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -248,7 +248,7 @@ config HUGETLB_PAGE
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on X86_64
-	depends on SPARSEMEM_VMEMMAP
+	depends on SPARSEMEM_VMEMMAP && STRUCT_PAGE_SIZE_IS_POWER_OF_2
 
 config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
 	bool "Default freeing vmemmap pages of HugeTLB to on"
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..b4defcea6534 100644
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
+#endif /* __GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H */
 
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
index 000000000000..9547ad3aca05
--- /dev/null
+++ b/scripts/check_struct_page_po2.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if the size of "struct page" is power of 2
+
+file="include/generated/struct_page_size.h"
+if [ ! -f "$file" ]; then
+	exit 1
+fi
+
+grep STRUCT_PAGE_SIZE_IS_POWER_OF_2 "$file" | cut -d' ' -f3
-- 
2.11.0

