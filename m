Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D784D6D18
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 07:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiCLG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 01:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCLG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:59:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8B4B848
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 22:58:22 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q19so9287051pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 22:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IWEKdPyVvolpnOSuxir86XbGUS+YtCt+QShkTKy2vI=;
        b=3cIBfacJ4Ngt0vxOsAI3eGekmsLwkkcuxIySQrBeDF2CVcEbrd0g+mhjcK88bmQS3u
         VpWCY7trcpLvHv3RD433T4Tq4AWklAAK3jLPfp5ZpkEW7peB5UkygzNNgtFyHE/xBAL0
         0ykEX1LD4lJ2Sojxv2emy/u0xWCE7TvfdLMYEzfuuVYudddlHYcTMdO+Iqh2HB++H38R
         MoOgEq2kdc8QOk0miUFI7OqrEaFW5t7C2gJ2eCf8fPBLlffNIXT5WZ9w1BmADAV3ouf6
         8QH+5ZkWtcwXmg9px/e18owU8aBhKYBcK8B6x0eGJOL6l5RdClgkFoNWMUFrI3JBqdss
         ey3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IWEKdPyVvolpnOSuxir86XbGUS+YtCt+QShkTKy2vI=;
        b=OPV/mF+c41AbmWYug+fPSTnL28MAypuhQs6yZUJSLYVaFi2efswLHWyKMslKDMYfRi
         pEqlD8hY61kl0w/RIOoImpzKVkNpbDZLIJeliXl20oNFfhvWjO+DAUB0W6JyDGjkEciE
         EvDLi5g1btkotF8aRUdNdjIJW1Njgx71/Ndt3TbKAHESF69eZ4AteypBIWOGZ+SErool
         Qdrkpb7yeGsAPJyPfyE2Tkdk3cnWLmll7qJ666bBoWpUfn9J/u5MN1WI44yN9r87MMDK
         i4Y4mu/O3V/HmTXQU2fa9hk57Y6XJWuSlkkP0hcqDDJLcw7ilHnEbIOtjx3ZifHF7eGD
         vHkQ==
X-Gm-Message-State: AOAM531bC5RxPx2RSvaOv7PpZM0eJdjIVEBoa6/WqIoOMM3FxT6Nl3iE
        XqXos0QlE722yxbVN2L5fNNZvA==
X-Google-Smtp-Source: ABdhPJw9NxbTKMqYmhV3GYkJeL1pcfmqyQ7KmwdtjC1OFhPRsbzMEqY/gk8HNh38I8mzagvZa3OYLg==
X-Received: by 2002:aa7:918f:0:b0:4cc:3c00:b2dd with SMTP id x15-20020aa7918f000000b004cc3c00b2ddmr14117555pfa.77.1647068302047;
        Fri, 11 Mar 2022 22:58:22 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm11915419pjb.5.2022.03.11.22.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 22:58:21 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC] mm: hugetlb_vmemmap: introduce HAS_STRUCT_PAGE_SIZE_POWER_OF_2
Date:   Sat, 12 Mar 2022 14:56:54 +0800
Message-Id: <20220312065654.44543-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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
HAS_STRUCT_PAGE_SIZE_POWER_OF_2 to detect if the size of struct
page is power of 2 and make this feature depends on this new
config.  Then we could prevent anyone do any unexpected
configuration.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---

Thanks Luis for proposing this idea.  The initial implementation is as
follows.  I found it could work properly at the first time after creating
.config.  Then, if we use "make menuconfig" to disable CONFIG_MEMCG and
CONFIG_SLOB meaning the size of "struct page" becomes not power of 2,
whereas HAS_STRUCT_PAGE_SIZE_POWER_OF_2 will not be changed to "n"
accordingly.  I don't know how to make HAS_STRUCT_PAGE_SIZE_POWER_OF_2
realize the potential change of the size of "struct page" since I am not
familiar with the Kconfig and how to detect this dependency.  If you have
any suggestions, comments are really welcome.

 Kbuild                           | 11 +++++++++++
 fs/Kconfig                       |  5 ++++-
 include/linux/mm_types.h         |  2 ++
 mm/hugetlb_vmemmap.c             |  6 ------
 mm/struct_page_size.c            | 19 +++++++++++++++++++
 scripts/check_struct_page_po2.sh | 16 ++++++++++++++++
 6 files changed, 52 insertions(+), 7 deletions(-)
 create mode 100644 mm/struct_page_size.c
 create mode 100755 scripts/check_struct_page_po2.sh

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..7885e1211135 100644
--- a/Kbuild
+++ b/Kbuild
@@ -14,6 +14,17 @@ $(bounds-file): kernel/bounds.s FORCE
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
+
+#####
 # Generate timeconst.h
 
 timeconst-file := include/generated/timeconst.h
diff --git a/fs/Kconfig b/fs/Kconfig
index 7f2455e8e18a..d663f600c608 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,10 +245,13 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HAS_STRUCT_PAGE_SIZE_POWER_OF_2
+	def_bool $(success,test "$(shell, $(srctree)/scripts/check_struct_page_po2.sh)" = y)
+
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on X86_64
-	depends on SPARSEMEM_VMEMMAP
+	depends on SPARSEMEM_VMEMMAP && HAS_STRUCT_PAGE_SIZE_POWER_OF_2
 
 config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
 	bool "Default freeing vmemmap pages of HugeTLB to on"
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 11dc4586464d..5da7dfa26596 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -224,6 +224,7 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+#ifndef __GENERATING_STRUCT_PAGE_SIZE_H
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -849,5 +850,6 @@ enum fault_flag {
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 };
+#endif /* !__GENERATING_STRUCT_PAGE_SIZE_H */
 
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b3118dba0518..d9e6b8b0af30 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -28,12 +28,6 @@ EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
 
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
index 000000000000..6022a95ffc8a
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
+#define __GENERATING_STRUCT_PAGE_SIZE_H
+/* Include headers that define the enum constants of interest */
+#include <linux/kbuild.h>
+#include <linux/log2.h>
+#include <linux/mm_types.h>
+
+int main(void)
+{
+	DEFINE(STRUCT_PAGE_SIZE_POWER_OF_2, is_power_of_2(sizeof(struct page)));
+
+	return 0;
+}
diff --git a/scripts/check_struct_page_po2.sh b/scripts/check_struct_page_po2.sh
new file mode 100755
index 000000000000..cf54c6b16cd2
--- /dev/null
+++ b/scripts/check_struct_page_po2.sh
@@ -0,0 +1,16 @@
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
+struct_page_po2=$(grep STRUCT_PAGE_SIZE_POWER_OF_2 "$file" | cut -d' ' -f3)
+if [ "$struct_page_po2" = "1" ]; then
+	echo y
+else
+	echo n
+fi
-- 
2.11.0

