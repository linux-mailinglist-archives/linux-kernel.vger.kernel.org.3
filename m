Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114DF47FBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhL0Jwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:52:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33490 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229734AbhL0Jwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:52:31 -0500
X-UUID: 53ceb6ad87f34912abfaa703bb702963-20211227
X-UUID: 53ceb6ad87f34912abfaa703bb702963-20211227
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <guangming.cao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1006601904; Mon, 27 Dec 2021 17:52:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 27 Dec 2021 17:52:27 +0800
Received: from mszswglt01.gcn.mediatek.inc (10.16.20.20) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 27 Dec 2021 17:52:27 +0800
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
CC:     Bo Song <bo.song@mediatek.com>, Libo Kang <libo.kang@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>,
        mingyuan ma <mingyuan.ma@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, Guangming <Guangming.Cao@mediatek.com>
Subject: [PATCH v2] dma-buf: dma-heap: Add a size check for allocation
Date:   Mon, 27 Dec 2021 17:51:02 +0800
Message-ID: <20211227095102.6054-1-guangming.cao@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217094104.24977-1-guangming.cao@mediatek.com>
References: <20211217094104.24977-1-guangming.cao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangming <Guangming.Cao@mediatek.com>

Add a size check for allcation since the allocation size is
always less than the total DRAM size.

Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
---
v2: 1. update size limitation as total_dram page size.
    2. update commit message
---
 drivers/dma-buf/dma-heap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 56bf5ad01ad5..e39d2be98d69 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -55,6 +55,8 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
 	struct dma_buf *dmabuf;
 	int fd;
 
+	if (len / PAGE_SIZE > totalram_pages())
+		return -EINVAL;
 	/*
 	 * Allocations from all heaps have to begin
 	 * and end on page boundaries.
-- 
2.17.1

