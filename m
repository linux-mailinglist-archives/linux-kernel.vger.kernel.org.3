Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9E59AA1D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiHTAby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiHTAbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8DD9D6D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660955501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+slbqjopuKAQI4tVcBnBFhXSd2aSoBtTrQroT8A2GE=;
        b=Y2aOK5EgacAynI7XTof9SrsM5GOCs5O5qyPs2WBWEB6/iOKY+mShJUe6wR3Oyr+eQNfd2p
        TTs6DN2n5HPipMZ4cK8X/BcXrbWfzetmTFFyT86xPg/MAcALbKQYoXuo/GrTD5zsnRg4uW
        yJY1cV4UATScvr84VumOdL+ApdcLQHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-ZNHLqxdzO0uoYpWgRzA5MA-1; Fri, 19 Aug 2022 20:31:37 -0400
X-MC-Unique: ZNHLqxdzO0uoYpWgRzA5MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65230185A794;
        Sat, 20 Aug 2022 00:31:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6651040D2827;
        Sat, 20 Aug 2022 00:31:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 01/11] mm/ioremap: change the return value of io[re|un]map_allowed and rename
Date:   Sat, 20 Aug 2022 08:31:15 +0800
Message-Id: <20220820003125.353570-2-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-1-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some architectures, there are ARCH specifici io address mapping
handling when calling ioremap() or ioremap_prot(), e.g, arc, ia64,
openrisc, s390, sh.

In oder to convert them to take GENERIC_IOREMAP method, we need change
the return value of hook ioremap_allowed() and iounmap_allowed().
Meanwhile, rename them to arch_ioremap() and arch_iounmap() to reflect
their current behaviour.

===
 arch_ioremap() return a bool,
   - IS_ERR means return an error
   - NULL means continue to remap
   - a non-NULL, non-IS_ERR pointer is returned directly
 arch_iounmap() return a bool,
   - 0 means continue to vunmap
   - error code means skip vunmap and return directly

This is taken from Kefeng's below old patch. Christoph suggested the
return value because he foresaw the doablity of converting to take
GENERIC_IOREMAP on more architectures.
 - [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
 - https://lore.kernel.org/all/20220519082552.117736-5-wangkefeng.wang@huawei.com/T/#u

While at it, the invocation of arch_ioremap() need be moved to the
beginning of ioremap_prot() because architectures like sh, openrisc,
ia64, need do the ARCH specific io address mapping on the original
physical address. And in the later patch, the address fix up code
in arch_ioremap() also need be done on the original addre on some
architectures.

This is preparation for later patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/io.h |  4 ++--
 arch/arm64/mm/ioremap.c     | 15 ++++++++++-----
 include/asm-generic/io.h    | 29 +++++++++++++++--------------
 mm/ioremap.c                | 12 ++++++++----
 4 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 877495a0fd0c..dd7e1c2dc86c 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -139,8 +139,8 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
-#define ioremap_allowed ioremap_allowed
+void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
+#define arch_ioremap arch_ioremap
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index c5af103d4ad4..b0f4cea86f0e 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,19 +3,24 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
+void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
 {
-	unsigned long last_addr = phys_addr + size - 1;
+	unsigned long last_addr, offset;
+
+	offset = phys_addr & (~PAGE_MASK);
+	phys_addr -= offset;
+	size = PAGE_ALIGN(size + offset);
+	last_addr = phys_addr + size - 1;
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
-		return false;
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	/* Don't allow RAM to be mapped. */
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
-		return false;
+		return IOMEM_ERR_PTR(-EINVAL);
 
-	return true;
+	return NULL;
 }
 
 /*
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a68f8fbf423b..7b6bfb62ef80 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1049,27 +1049,28 @@ static inline void iounmap(volatile void __iomem *addr)
 
 /*
  * Arch code can implement the following two hooks when using GENERIC_IOREMAP
- * ioremap_allowed() return a bool,
- *   - true means continue to remap
- *   - false means skip remap and return directly
- * iounmap_allowed() return a bool,
- *   - true means continue to vunmap
- *   - false means skip vunmap and return directly
+ * arch_ioremap() return a bool,
+ *   - IS_ERR means return an error
+ *   - NULL means continue to remap
+ *   - a non-NULL, non-IS_ERR pointer is returned directly
+ * arch_iounmap() return a bool,
+ *   - 0 means continue to vunmap
+ *   - error code means skip vunmap and return directly
  */
-#ifndef ioremap_allowed
-#define ioremap_allowed ioremap_allowed
-static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
+#ifndef arch_ioremap
+#define arch_ioremap arch_ioremap
+static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size,
 				   unsigned long prot)
 {
-	return true;
+	return NULL;
 }
 #endif
 
-#ifndef iounmap_allowed
-#define iounmap_allowed iounmap_allowed
-static inline bool iounmap_allowed(void *addr)
+#ifndef arch_iounmap
+#define arch_iounmap arch_iounmap
+static inline int arch_iounmap(void __iomem *addr)
 {
-	return true;
+	return 0;
 }
 #endif
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 8652426282cc..99fde69becc7 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -17,6 +17,13 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
 	struct vm_struct *area;
+	void __iomem *ioaddr;
+
+	ioaddr = arch_ioremap(phys_addr, size, prot);
+	if (IS_ERR(ioaddr))
+		return NULL;
+	else if (ioaddr)
+		return ioaddr;
 
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
@@ -28,9 +35,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, prot))
-		return NULL;
-
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
 	if (!area)
@@ -52,7 +56,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
 
-	if (!iounmap_allowed(vaddr))
+	if (arch_iounmap((void __iomem *)addr))
 		return;
 
 	if (is_vmalloc_addr(vaddr))
-- 
2.34.1

