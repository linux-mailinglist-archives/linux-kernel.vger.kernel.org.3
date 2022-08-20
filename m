Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95C59AA16
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiHTAb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiHTAbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075EDAA1C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660955505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chLY++uUFkS8hC5VhV7WNTHSImYmuTtP4WBhSWyRYLQ=;
        b=Jp9ZL2Z77n4nupTzL7/tX+rW0OMyaV1K3kPKZf6Dj9iSPhnvdsfayUqyD//KdU9xuue2oF
        edPZjgY4RCkj0m9B4MqkyzzxhKnwNhCjRKwkuRyACsqswWpp/OUpP+/cgZ8q8IC4aEhkDd
        4LmoE0P4O0fBXUYhyptS8huCkIs+/m0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-6TqZY1enNd6QHQ2ZnS6eDg-1; Fri, 19 Aug 2022 20:31:42 -0400
X-MC-Unique: 6TqZY1enNd6QHQ2ZnS6eDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F07D3185A794;
        Sat, 20 Aug 2022 00:31:41 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BED74010D2A;
        Sat, 20 Aug 2022 00:31:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 02/11] mm: ioremap: fixup the physical address and page prot
Date:   Sat, 20 Aug 2022 08:31:16 +0800
Message-Id: <20220820003125.353570-3-bhe@redhat.com>
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

On some architectures, the physical address need be fixed up before
doing mapping, e.g, parisc. And on architectures, e.g arc, the
parameter 'prot' passed into ioremap_prot() need be adjusted too.

In oder to convert them to take GENERIC_IOREMAP method, we need wrap
the address fixing up code and page prot adjusting code into arch_ioremap()
and pass the new address and 'prot' out for ioremap_prot() handling.

This is a preparation patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/io.h | 3 ++-
 arch/arm64/mm/ioremap.c     | 5 +++--
 include/asm-generic/io.h    | 4 ++--
 mm/ioremap.c                | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index dd7e1c2dc86c..6a5578ddbbf6 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -139,7 +139,8 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
-void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
 #define arch_ioremap arch_ioremap
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index b0f4cea86f0e..ef75ffef4dbc 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,9 +3,10 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	unsigned long last_addr, offset;
+	unsigned long last_addr, offset, phys_addr = *paddr;
 
 	offset = phys_addr & (~PAGE_MASK);
 	phys_addr -= offset;
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7b6bfb62ef80..fb9bda2be8ed 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1059,8 +1059,8 @@ static inline void iounmap(volatile void __iomem *addr)
  */
 #ifndef arch_ioremap
 #define arch_ioremap arch_ioremap
-static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size,
-				   unsigned long prot)
+static inline void __iomem *arch_ioremap(phys_addr_t *paddr, size_t size,
+				   unsigned long *prot_val)
 {
 	return NULL;
 }
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 99fde69becc7..7914b5cf5b78 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -19,7 +19,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	struct vm_struct *area;
 	void __iomem *ioaddr;
 
-	ioaddr = arch_ioremap(phys_addr, size, prot);
+	ioaddr = arch_ioremap(&phys_addr, size, &prot);
 	if (IS_ERR(ioaddr))
 		return NULL;
 	else if (ioaddr)
-- 
2.34.1

