Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1524787EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhLQJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:40:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:40858 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234441AbhLQJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:40:35 -0500
X-UUID: 020b9ac459d449dc900c6f6b79a1619c-20211217
X-UUID: 020b9ac459d449dc900c6f6b79a1619c-20211217
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <guangming.cao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2014456999; Fri, 17 Dec 2021 17:40:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Dec 2021 17:40:29 +0800
Received: from mszswglt01.gcn.mediatek.inc (10.16.20.20) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 17 Dec 2021 17:40:28 +0800
From:   <guangming.cao@mediatek.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Laura Abbott" <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "John Stultz" <john.stultz@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA-BUF HEAPS FRAMEWORK" <linux-media@vger.kernel.org>,
        "open list:DMA-BUF HEAPS FRAMEWORK" <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA-BUF HEAPS FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
CC:     <wsd_upstream@mediatek.com>, Bo Song <bo.song@mediatek.com>,
        Libo Kang <libo.kang@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>,
        mingyuan ma <mingyuan.ma@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Guangming <Guangming.Cao@mediatek.com>
Subject: [PATCH] dma-buf: dma-heap: Add a size limitation for allocation
Date:   Fri, 17 Dec 2021 17:41:04 +0800
Message-ID: <20211217094104.24977-1-guangming.cao@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangming <Guangming.Cao@mediatek.com>

Currently, there is no size check for allocation.

If the alloc size is larger than DRAM, it will cause OOM issue.
Besides, if it runs on a process that won't be killed by OOM flow, it will
cause a kernel exception finally,  and we couldn't find the correct
memory usage by dma-buf dump api such as "dma_buf_debug_show" since the
allocation is still on going and the corresponding dmabuf is not exported.

However, it sounds not simple enough to adding a count to count how many
pages has been allocated before allocating done.
So adding a size limitation here to prevent this case.

Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
---
 drivers/dma-buf/dma-heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 56bf5ad01ad5..8b75998a106c 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -107,6 +107,9 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
 		return -EINVAL;
 
+	if (heap_allocation->len / PAGE_SIZE > totalram_pages() / 2)
+		return -EINVAL;
+
 	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
 				   heap_allocation->fd_flags,
 				   heap_allocation->heap_flags);
-- 
2.17.1

