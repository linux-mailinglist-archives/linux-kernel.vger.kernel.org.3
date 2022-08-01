Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45F586D16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiHAOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiHAOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5F523DBC7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaolBDp29uFoy9EJOCmc+prflA1CqUFRD61xKQq994g=;
        b=UZqOOTYVYP/yqN4Szf8cG9CuzsgSCOAB4E+RwNQh7ID2nCQ/3eSDM6GAvfrFSX8kVaoDdm
        yr4rzp/D+maD8O7iHkfOo7fVPgWedFdTgT3yOzAw1WIvf/+NPACM74ZE8AKEGtjup24kLC
        4g+8lpsoIta7QSO2Rj2q631DOn+UvoI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-cE1DPRyqM1KTgUoCRiT8Iw-1; Mon, 01 Aug 2022 10:41:07 -0400
X-MC-Unique: cE1DPRyqM1KTgUoCRiT8Iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D51A22932482;
        Mon,  1 Aug 2022 14:41:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56727141510F;
        Mon,  1 Aug 2022 14:41:03 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date:   Mon,  1 Aug 2022 22:40:23 +0800
Message-Id: <20220801144029.57829-6-bhe@redhat.com>
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

With it, the old ioremap() and iounmap() can be perfectly removed
since they are duplicated with the standard functions.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/Kconfig          |  1 +
 arch/hexagon/include/asm/io.h |  9 +++++--
 arch/hexagon/mm/ioremap.c     | 44 -----------------------------------
 3 files changed, 8 insertions(+), 46 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 54eadf265178..17afffde1a7f 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -25,6 +25,7 @@ config HEXAGON
 	select NEED_SG_DMA_LENGTH
 	select NO_IOPORT_MAP
 	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index c33241425a5c..e2d3091ec9d6 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
-#define ioremap_uc(X, Y) ioremap((X), (Y))
+/*
+ * I/O memory mapping functions.
+ */
+#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+		       (__HEXAGON_C_DEV << 6))
+
+#define ioremap_uc(addr, size) ioremap((addr), (size))
 
 
 #define __raw_writel writel
diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
deleted file mode 100644
index 255c5b1ee1a7..000000000000
--- a/arch/hexagon/mm/ioremap.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * I/O remap functions for Hexagon
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#include <linux/io.h>
-#include <linux/vmalloc.h>
-#include <linux/mm.h>
-
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
-{
-	unsigned long last_addr, addr;
-	unsigned long offset = phys_addr & ~PAGE_MASK;
-	struct vm_struct *area;
-
-	pgprot_t prot = __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
-					|(__HEXAGON_C_DEV << 6));
-
-	last_addr = phys_addr + size - 1;
-
-	/*  Wrapping not allowed  */
-	if (!size || (last_addr < phys_addr))
-		return NULL;
-
-	/*  Rounds up to next page size, including whole-page offset */
-	size = PAGE_ALIGN(offset + size);
-
-	area = get_vm_area(size, VM_IOREMAP);
-	addr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
-		vunmap((void *)addr);
-		return NULL;
-	}
-
-	return (void __iomem *) (offset + addr);
-}
-
-void iounmap(const volatile void __iomem *addr)
-{
-	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
-}
-- 
2.34.1

