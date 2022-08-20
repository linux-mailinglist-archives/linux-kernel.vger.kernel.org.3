Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CB59AA1F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbiHTAcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbiHTAcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611DDDABC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660955523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaolBDp29uFoy9EJOCmc+prflA1CqUFRD61xKQq994g=;
        b=JKyWbh8xCFKJhGbBTL7fBTrUkThtcMdzrZ04CAQ5nbNoDFXSUHgJxr+JEeB8VgmsxMEiTM
        DiUqTXNYNqlb+sRUx47NNW5E9dt9QHAPU1yTbFut3FCGVpiG2LmFa3EvSlbYGNaMZmZBML
        csNHVUDoMLSxXCs9z8UugjaKl4x67MI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-y1mA8qUWOsm_-jR1x5dxEQ-1; Fri, 19 Aug 2022 20:31:58 -0400
X-MC-Unique: y1mA8qUWOsm_-jR1x5dxEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7EB73C025D0;
        Sat, 20 Aug 2022 00:31:57 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96CC440D2827;
        Sat, 20 Aug 2022 00:31:52 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date:   Sat, 20 Aug 2022 08:31:19 +0800
Message-Id: <20220820003125.353570-6-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-1-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

