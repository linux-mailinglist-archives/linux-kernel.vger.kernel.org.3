Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08C3462DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhK3HtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:49:19 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48424 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhK3HtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:49:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jkchen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyqxeXk_1638258356;
Received: from localhost(mailfrom:jkchen@linux.alibaba.com fp:SMTPD_---0UyqxeXk_1638258356)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Nov 2021 15:45:57 +0800
From:   Jay Chen <jkchen@linux.alibaba.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     zhangliguang@linux.alibaba.com
Subject: [RFC PATCH] provide per numa cma with an initial default size
Date:   Tue, 30 Nov 2021 15:45:56 +0800
Message-Id: <20211130074556.11091-1-jkchen@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  In the actual production environment, when we open
cma and per numa cma, if we do not increase the per
numa size configuration in cmdline, we find that our
performance has dropped by 20%.
  Through analysis, we found that the default size of
per numa is 0, which causes the driver to allocate
memory from cma, which affects performance. Therefore,
we think we need to provide a default size.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..3bef8bf371d9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -99,7 +99,7 @@ early_param("cma", early_cma);
 #ifdef CONFIG_DMA_PERNUMA_CMA
 
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
-static phys_addr_t pernuma_size_bytes __initdata;
+static phys_addr_t pernuma_size_bytes __initdata = size_bytes;
 
 static int __init early_cma_pernuma(char *p)
 {
-- 
2.27.0

