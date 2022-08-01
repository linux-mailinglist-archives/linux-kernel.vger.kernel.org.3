Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728F586D10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiHAOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiHAOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F48737185
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqh7FeHFMtI+kW+10TKPDeJZiXYb/xwqaqaRSxDfiUM=;
        b=Fxm9l+AfcZt8TkceQGTA2H0Cl889bslKnFcQS/mbZrAmzpp4PQR1mTevjXCMJoDRV9U9Y+
        /KOUSyfYAjgJXjBg45T0fsep8lihyghlx015jW+5exCbJe7BmNU5+b89kwwMu/7HzNEzf0
        +Xnow6FkqeBMFoZ150RsY0N8UPbDzAU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-j3vyREzDPkeg7ERZPn0gvA-1; Mon, 01 Aug 2022 10:40:42 -0400
X-MC-Unique: j3vyREzDPkeg7ERZPn0gvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40404382ECC6;
        Mon,  1 Aug 2022 14:40:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6C6C141510F;
        Mon,  1 Aug 2022 14:40:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 01/11] mm/ioremap: change the return value of io[re|un]map_allowed
Date:   Mon,  1 Aug 2022 22:40:19 +0800
Message-Id: <20220801144029.57829-2-bhe@redhat.com>
In-Reply-To: <20220801144029.57829-1-bhe@redhat.com>
References: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some architectures, there are arch specifici io address mapping
handling when calling ioremap() or ioremap_prot(), e.g, arc, ia64,
openrisc, s390, sh.

In oder to convert them to take GENERIC_IOREMAP method, we need change
the return value of ioremap_allowed() and iounmap_allowed() as below.

===
 ioremap_allowed() return a bool,
   - IS_ERR means return an error
   - NULL means continue to remap
   - a non-NULL, non-IS_ERR pointer is returned directly
 iounmap_allowed() return a bool,
   - 0 means continue to vunmap
   - error code means skip vunmap and return directly

This is taken from Kefeng's below old patch. Christoph suggested the
return value because he foresaw the doablity of converting to take
GENERIC_IOREMAP on more architectures.
 - [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
 - https://lore.kernel.org/all/20220519082552.117736-5-wangkefeng.wang@huawei.com/T/#u

This is preparation for later patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/io.h |  2 +-
 arch/arm64/mm/ioremap.c     |  9 +++++----
 include/asm-generic/io.h    | 17 +++++++++--------
 mm/ioremap.c                | 10 +++++++---
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 87dd42d74afe..9c56a077b687 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -164,7 +164,7 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
+void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
 #define ioremap_allowed ioremap_allowed
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index c5af103d4ad4..49467c781283 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,19 +3,20 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
+void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
 {
 	unsigned long last_addr = phys_addr + size - 1;
+	int ret = -EINVAL;
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
-		return false;
+		return IOMEM_ERR_PTR(ret);
 
 	/* Don't allow RAM to be mapped. */
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
-		return false;
+		return IOMEM_ERR_PTR(ret);
 
-	return true;
+	return NULL;
 }
 
 /*
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 72974cb81343..d72eb310fb3c 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -967,26 +967,27 @@ static inline void iounmap(volatile void __iomem *addr)
 /*
  * Arch code can implement the following two hooks when using GENERIC_IOREMAP
  * ioremap_allowed() return a bool,
- *   - true means continue to remap
- *   - false means skip remap and return directly
+ *   - IS_ERR means return an error
+ *   - NULL means continue to remap
+ *   - a non-NULL, non-IS_ERR pointer is returned directly
  * iounmap_allowed() return a bool,
- *   - true means continue to vunmap
- *   - false means skip vunmap and return directly
+ *   - 0 means continue to vunmap
+ *   - error code means skip vunmap and return directly
  */
 #ifndef ioremap_allowed
 #define ioremap_allowed ioremap_allowed
-static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
+static inline void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size,
 				   unsigned long prot)
 {
-	return true;
+	return NULL;
 }
 #endif
 
 #ifndef iounmap_allowed
 #define iounmap_allowed iounmap_allowed
-static inline bool iounmap_allowed(void *addr)
+static inline int iounmap_allowed(void *addr)
 {
-	return true;
+	return 0;
 }
 #endif
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 8652426282cc..b16ee9debea2 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -17,6 +17,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
 	struct vm_struct *area;
+	void __iomem *base;
 
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
@@ -28,8 +29,11 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	if (!ioremap_allowed(phys_addr, size, prot))
+	base = ioremap_allowed(phys_addr, size, prot);
+	if (IS_ERR(base))
 		return NULL;
+	else if (base)
+		return base;
 
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
@@ -50,9 +54,9 @@ EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(volatile void __iomem *addr)
 {
-	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
+	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
 
-	if (!iounmap_allowed(vaddr))
+	if (iounmap_allowed(vaddr))
 		return;
 
 	if (is_vmalloc_addr(vaddr))
-- 
2.34.1

