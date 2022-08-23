Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D089959E7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiHWQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245033AbiHWQjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:39:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD35A83D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:39:36 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27NEcu7x028058;
        Tue, 23 Aug 2022 09:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661265536;
        bh=SrhwDfFmCKDHUwaKLYHtQUV86zVweQBvySv+nYqBj6g=;
        h=From:To:CC:Subject:Date;
        b=kAjpgjcE4BAbFQTEA17ZsjxBOspxBjetf+L66QoUUGj43WxBpFahfFcC0zP/lJqkk
         fAHm3t02e4s9JM6FGqmsdd5L6SsMD77Zbp2EL5JJK1kfACF1G8zowNzd24AyFV6Msg
         CX2STekgHcGfDXltAu41uibxpDoAi4kYXsCEPnso=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27NEcuWN014059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Aug 2022 09:38:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 23
 Aug 2022 09:38:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 23 Aug 2022 09:38:56 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27NEctxN038712;
        Tue, 23 Aug 2022 09:38:55 -0500
From:   Andrew Davis <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2] dma-buf: cma_heap: Check for device max segment size when attaching
Date:   Tue, 23 Aug 2022 09:38:55 -0500
Message-ID: <20220823143855.12065-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is usually not such a limitation (and when there is it is
often only because the driver forgot to change the super small default),
it is still correct here to break scatterlist element into chunks of
dma_max_mapping_size().

This might cause some issues for users with misbehaving drivers. If
bisecting has landed you on this commit, make sure your drivers both set
dma_set_max_seg_size() and are checking for contiguousness correctly.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Fixed mixed declarations and code warning

 drivers/dma-buf/heaps/cma_heap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 28fb04eccdd0..a927b248c045 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -52,16 +52,18 @@ static int cma_heap_attach(struct dma_buf *dmabuf,
 {
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
+	size_t max_segment;
 	int ret;
 
 	a = kzalloc(sizeof(*a), GFP_KERNEL);
 	if (!a)
 		return -ENOMEM;
 
-	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
-					buffer->pagecount, 0,
-					buffer->pagecount << PAGE_SHIFT,
-					GFP_KERNEL);
+	max_segment = dma_get_max_seg_size(attachment->dev);
+	ret = sg_alloc_table_from_pages_segment(&a->table, buffer->pages,
+						buffer->pagecount, 0,
+						buffer->pagecount << PAGE_SHIFT,
+						max_segment, GFP_KERNEL);
 	if (ret) {
 		kfree(a);
 		return ret;
-- 
2.36.1

