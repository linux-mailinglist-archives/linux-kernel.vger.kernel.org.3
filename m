Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68DE59B915
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiHVGOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiHVGO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:14:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3127173
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+m7ASInd5HyWaBAQHUjqUsOTAxsljCftdMHP0CR28S8=; b=opuILnP/c/7p066ds4lZxvjvlM
        mFtu/WpnLWA+u+wzyUG5GIVqxROzZHBvkD1yc5IREXqCUQeIll2MNLYTEur9a+8yt/3MNK6a1H+TO
        Q4BQPumM1xuxzf2gYCZ5Aanf2h3JY4TbvVCT13EppPNxMKWeojjjpSg+Pd+wTmwSgfMPWOhm4FI6j
        mA5wP4dDWk2BgkXCxIL5Lu6FdQ8Bsi47iGUoRI5JiMpHkO/gtxWon7Ir9EGwUULvEkx3eCKJGPorT
        r7DPINYoEHvEXY7EHZ3+I79FQ3YFMeIag2uYzcoRqDPg58q3M6Hy0lbHllg116XZ9Md2ZX3QEiQqQ
        dGqvDo6w==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0he-005L5Y-Po; Mon, 22 Aug 2022 06:14:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] devres: remove devm_ioremap_np
Date:   Mon, 22 Aug 2022 08:14:24 +0200
Message-Id: <20220822061424.151819-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_np has never been used anywhere since it was added in early
2021, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/driver-api/driver-model/devres.rst |  1 -
 include/linux/io.h                               |  2 --
 lib/devres.c                                     | 15 ---------------
 3 files changed, 18 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 55272942e721a..2af6c9c09e596 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -310,7 +310,6 @@ IOMAP
   devm_ioremap()
   devm_ioremap_uc()
   devm_ioremap_wc()
-  devm_ioremap_np()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
diff --git a/include/linux/io.h b/include/linux/io.h
index 5fc800390fe42..308f4f0cfb932 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -59,8 +59,6 @@ void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
-void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
-				   resource_size_t size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index 55eb07e80cbb3..6baf43902eadb 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -103,21 +103,6 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(devm_ioremap_wc);
 
-/**
- * devm_ioremap_np - Managed ioremap_np()
- * @dev: Generic device to remap IO address for
- * @offset: Resource address to map
- * @size: Size of map
- *
- * Managed ioremap_np().  Map is automatically unmapped on driver detach.
- */
-void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
-			      resource_size_t size)
-{
-	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NP);
-}
-EXPORT_SYMBOL(devm_ioremap_np);
-
 /**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
-- 
2.30.2

