Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34B561A71
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiF3MhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiF3MhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:37:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC33AA5A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:37:18 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LYd9v112wz9smf;
        Thu, 30 Jun 2022 20:36:35 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 20:37:16 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 20:37:16 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <mathieu.poirier@linaro.org>, <mark-pk.tsai@mediatek.com>
CC:     <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] dma-mapping: Fix build error unused-value
Date:   Thu, 30 Jun 2022 20:35:28 +0800
Message-ID: <20220630123528.251181-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DMA_DECLARE_COHERENT is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- will be failed, like this:

drivers/remoteproc/remoteproc_core.c: In function ‘rproc_rvdev_release’:
./include/linux/dma-map-ops.h:182:42: error: statement with no effect [-Werror=unused-value]
 #define dma_release_coherent_memory(dev) (0)
                                          ^
drivers/remoteproc/remoteproc_core.c:464:2: note: in expansion of macro ‘dma_release_coherent_memory’
  dma_release_coherent_memory(dev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The return type of function dma_release_coherent_memory in CONFIG_DMA_DECLARE_COHERENT area is void, so in !CONFIG_DMA_DECLARE_COHERENT area it should neither return any value nor be defined as zero.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e61c451476e6("dma-mapping: Add dma_release_coherent_memory to DMA API")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 include/linux/dma-map-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 53db9655efe9..bfffe494356a 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -179,10 +179,10 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 	return -ENOSYS;
 }
 
-#define dma_release_coherent_memory(dev) (0)
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+static inline void dma_release_coherent_memory(struct device *dev) { }
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
-- 
2.17.1

