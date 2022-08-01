Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FC586D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiHAOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiHAOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FA003C8EA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxopdcFQVMy5FY+0KKOo/rz2PC4Nm+RMZNyohtkWr+0=;
        b=IL//n9NmRS9v15e1pkuox96ULDTfv2BkSUK/flZJ9XzxKc6mAbFmgvANBCD/B7biAyMVum
        8uYV2CrOP0AiXjnYa339oBE5efWM3mk8TrZQjulrwfHQ0ljzZoCSaTK7FqIZLOzMNKLIsl
        8hC/LsapVndPqGumfRFqu8dm0aOjvZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-LeGhaKzCMLSYNGV72SviRQ-1; Mon, 01 Aug 2022 10:40:47 -0400
X-MC-Unique: LeGhaKzCMLSYNGV72SviRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C2C618E6C4B;
        Mon,  1 Aug 2022 14:40:46 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED2B51415116;
        Mon,  1 Aug 2022 14:40:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 02/11] mm: ioremap: fixup the physical address
Date:   Mon,  1 Aug 2022 22:40:20 +0800
Message-Id: <20220801144029.57829-3-bhe@redhat.com>
In-Reply-To: <20220801144029.57829-1-bhe@redhat.com>
References: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some architectures, the io address will be fixed up before doing
mapping, e.g, parisc, mips.

In oder to convert them to take GENERIC_IOREMAP method, we need wrap
the address fixing up code into ioremap_allowed() and pass the new
address out for ioremap_prot() handling.

This is a preparation patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/io.h |  3 ++-
 arch/arm64/mm/ioremap.c     | 10 ++++++++--
 include/asm-generic/io.h    |  6 +++---
 mm/ioremap.c                | 19 ++++++++++---------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 9c56a077b687..7f0c5f60d946 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -164,7 +164,8 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
-void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
 #define ioremap_allowed ioremap_allowed
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 49467c781283..b9febcf0f5f4 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,11 +3,17 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	unsigned long last_addr = phys_addr + size - 1;
+	unsigned long last_addr, offset, phys_addr = *paddr;
 	int ret = -EINVAL;
 
+	offset = phys_addr & (~PAGE_MASK);
+	phys_addr -= offset;
+	size = PAGE_ALIGN(size + offset);
+	last_addr = phys_addr + size - 1;
+
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
 		return IOMEM_ERR_PTR(ret);
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d72eb310fb3c..0b5cd3cef99d 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -976,8 +976,8 @@ static inline void iounmap(volatile void __iomem *addr)
  */
 #ifndef ioremap_allowed
 #define ioremap_allowed ioremap_allowed
-static inline void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size,
-				   unsigned long prot)
+static inline void __iomem *ioremap_allowed(phys_addr_t *paddr, size_t size,
+				   unsigned long *prot_val)
 {
 	return NULL;
 }
@@ -991,7 +991,7 @@ static inline int iounmap_allowed(void *addr)
 }
 #endif
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
 			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index b16ee9debea2..01439882112e 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,13 +11,20 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
 			   unsigned long prot)
 {
 	unsigned long offset, vaddr;
-	phys_addr_t last_addr;
+	phys_addr_t last_addr, phys_addr = paddr;
 	struct vm_struct *area;
 	void __iomem *base;
+	unsigned long prot_val = prot;
+
+	base = ioremap_allowed(&phys_addr, size, &prot_val);
+	if (IS_ERR(base))
+		return NULL;
+	else if (base)
+		return base;
 
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
@@ -29,12 +36,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	base = ioremap_allowed(phys_addr, size, prot);
-	if (IS_ERR(base))
-		return NULL;
-	else if (base)
-		return base;
-
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
 	if (!area)
@@ -43,7 +44,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	area->phys_addr = phys_addr;
 
 	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
-			       __pgprot(prot))) {
+			       __pgprot(prot_val))) {
 		free_vm_area(area);
 		return NULL;
 	}
-- 
2.34.1

