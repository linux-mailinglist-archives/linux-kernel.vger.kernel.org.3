Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5606494A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiATIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:52:09 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50634 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232683AbiATIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:52:06 -0500
X-UUID: c859b7443f714a1ea61a4b436e420731-20220120
X-UUID: c859b7443f714a1ea61a4b436e420731-20220120
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <guangming.cao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 748480370; Thu, 20 Jan 2022 16:52:02 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 20 Jan 2022 16:52:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 20 Jan
 2022 16:52:01 +0800
Received: from mszswglt01.gcn.mediatek.inc (10.16.20.20) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 20 Jan 2022 16:52:00 +0800
From:   <guangming.cao@mediatek.com>
To:     <christian.koenig@amd.com>
CC:     <benjamin.gaignard@linaro.org>, <bo.song@mediatek.com>,
        <caoguangming34@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <guangming.cao@mediatek.com>, <jianjiao.zeng@mediatek.com>,
        <john.stultz@linaro.org>, <labbott@redhat.com>,
        <libo.kang@mediatek.com>, <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lmark@codeaurora.org>,
        <matthias.bgg@gmail.com>, <michael.j.ruhl@intel.com>,
        <mingyuan.ma@mediatek.com>, <sumit.semwal@linaro.org>,
        <wsd_upstream@mediatek.com>, <yf.wang@mediatek.com>,
        Guangming <Guangming.Cao@mediatek.com>
Subject: [PATCH v6] dma-buf: system_heap: Add a size check for allocation
Date:   Thu, 20 Jan 2022 16:52:59 +0800
Message-ID: <20220120085259.98147-1-guangming.cao@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4f2631d3-0845-cae6-6fc0-9c00ce6301ce@amd.com>
References: <4f2631d3-0845-cae6-6fc0-9c00ce6301ce@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangming <Guangming.Cao@mediatek.com>

Add a size check for allocation since the allocation size should be
always less than the total DRAM size on system heap.
Adding this check can prevent comsuming too much time for invalid allocations.

Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
---
 drivers/dma-buf/heaps/system_heap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 23a7e74ef966..b65e597a742f 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -347,6 +347,14 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
+	/*
+	 * Size check. The "len" should be less than totalram since system_heap
+	 * memory is comes from system. Adding check here can prevent comsuming
+	 * too much time for invalid allocations.
+	 */
+	if (PFN_DOWN(len) > totalram_pages())
+		return ERR_PTR(-EINVAL);
+
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
-- 
2.17.1

