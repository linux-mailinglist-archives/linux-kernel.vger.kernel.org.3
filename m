Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502F458F60B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiHKCzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHKCzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D68566104
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Jzyo+iYNgVUkHsSusX0d5oO/AbbInRuXxWwwfsFl1po=; b=ZqxVPXAEAP/xp/3NjgEuHOtLun
        zvmhs7xH4BdT4AkW0Bav+iJj02F7JGZAwBLvPG15NSkduXYK4U/WuhFRASPFxdNPu14ldNi1MS2qq
        QrFpUSzoB3vvqgZYMdvnEEWH8lbbG/M7B26Sq6gj+5HYfroc0DIgSR6K4BHFKbSBuXvBFLQwbEuHz
        LuaCinGXUt00HmckdUJvJa9upNaCMl06yyCq8ZYlJNE2XfJK1fhRtYju8eUHN0PmIkxSylBYas6HP
        WaQJF9sHCyJf7t+hykbC6H671oXeiz7NR5Qhfvjtn6T1yL4Gdp+urbmb5UvoyZQG0PF496lff/46Y
        gFM99onA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLyMA-0000ID-VO; Thu, 11 Aug 2022 02:55:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] ARC: align iounmap() argument with other architectures
Date:   Wed, 10 Aug 2022 19:55:30 -0700
Message-Id: <20220811025530.2484-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'volatile' to iounmap()'s argument to prevent build warnings.
This make it the same as other major architectures.

Example (one of many):
drivers/scsi/aacraid/nark.c: In function 'aac_nark_ioremap':
drivers/scsi/aacraid/nark.c:36:28: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
   36 |                 iounmap(dev->base);
In file included from ../include/linux/io.h:13,
                 from ../include/linux/irq.h:20,
                 from ../include/asm-generic/hardirq.h:17,
                 from ./arch/arc/include/generated/asm/hardirq.h:1,
                 from ../include/linux/hardirq.h:11,
                 from ../include/linux/interrupt.h:11,
                 from ../include/linux/pci.h:38,
                 from ../drivers/scsi/aacraid/nark.c:18:
arch/arc/include/asm/io.h:35:41: note: expected 'const void *' but argument is of type 'volatile void *'
   35 | extern void iounmap(const void __iomem *addr);

Fixes: 1162b0701b14 ("ARC: I/O and DMA Mappings")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/io.h |    2 +-
 arch/arc/mm/ioremap.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -32,7 +32,7 @@ static inline void ioport_unmap(void __i
 {
 }
 
-extern void iounmap(const void __iomem *addr);
+extern void iounmap(const volatile void __iomem *addr);
 
 /*
  * io{read,write}{16,32}be() macros
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -94,7 +94,7 @@ void __iomem *ioremap_prot(phys_addr_t p
 EXPORT_SYMBOL(ioremap_prot);
 
 
-void iounmap(const void __iomem *addr)
+void iounmap(const volatile void __iomem *addr)
 {
 	/* weird double cast to handle phys_addr_t > 32 bits */
 	if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
