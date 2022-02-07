Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3B4ABF67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448742AbiBGNMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386354AbiBGNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:01:49 -0500
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 05:01:48 PST
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD585C043188;
        Mon,  7 Feb 2022 05:01:48 -0800 (PST)
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 11/12] iio: buffer-dmaengine: Add support for cyclic buffers
Date:   Mon,  7 Feb 2022 13:01:39 +0000
Message-Id: <20220207130140.81891-1-paul@crapouillou.net>
In-Reply-To: <20220207125933.81634-1-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the IIO_BUFFER_DMABUF_CYCLIC flag to support cyclic buffers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c      |  1 +
 .../iio/buffer/industrialio-buffer-dmaengine.c    | 15 ++++++++++++---
 include/linux/iio/buffer-dma.h                    |  3 +++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index b9c3b01c5ea0..6185af2f33f0 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -901,6 +901,7 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 	}
 
 	dma_block->bytes_used = iio_dmabuf->bytes_used ?: dma_block->size;
+	dma_block->cyclic = iio_dmabuf->flags & IIO_BUFFER_DMABUF_CYCLIC;
 
 	switch (dma_block->state) {
 	case IIO_BLOCK_STATE_QUEUED:
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 57a8b2e4ba3c..952e2160a11e 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -81,9 +81,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (!block->bytes_used || block->bytes_used > max_size)
 		return -EINVAL;
 
-	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, dma_dir,
-		DMA_PREP_INTERRUPT);
+	if (block->cyclic) {
+		desc = dmaengine_prep_dma_cyclic(dmaengine_buffer->chan,
+						 block->phys_addr,
+						 block->size,
+						 block->bytes_used,
+						 dma_dir, 0);
+	} else {
+		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
+						   block->phys_addr,
+						   block->bytes_used, dma_dir,
+						   DMA_PREP_INTERRUPT);
+	}
 	if (!desc)
 		return -ENOMEM;
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 5bd687132355..3a5d9169e573 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -40,6 +40,7 @@ enum iio_block_state {
  * @phys_addr: Physical address of the blocks memory
  * @queue: Parent DMA buffer queue
  * @state: Current state of the block
+ * @cyclic: True if this is a cyclic buffer
  * @fileio: True if this buffer is used for fileio mode
  * @dmabuf: Underlying DMABUF object
  */
@@ -63,6 +64,8 @@ struct iio_dma_buffer_block {
 	 */
 	enum iio_block_state state;
 
+	bool cyclic;
+
 	bool fileio;
 	struct dma_buf *dmabuf;
 };
-- 
2.34.1

