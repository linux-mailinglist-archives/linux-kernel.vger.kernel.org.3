Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EBD4F5E06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiDFM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiDFM0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:26:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC1322EC118;
        Wed,  6 Apr 2022 01:12:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64D3F23A;
        Wed,  6 Apr 2022 01:12:17 -0700 (PDT)
Received: from e122247.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81F0B3F718;
        Wed,  6 Apr 2022 01:12:15 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] crypto: ccree: use fine grained DMA mapping dir
Date:   Wed,  6 Apr 2022 11:11:39 +0300
Message-Id: <20220406081139.1963615-3-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406081139.1963615-1-gilad@benyossef.com>
References: <20220406081139.1963615-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a fine grained specification of DMA mapping directions
in certain cases, allowing both a more optimized operation
as well as shushing out a harmless, though persky
dma-debug warning.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>

---
 drivers/crypto/ccree/cc_buffer_mgr.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 11e0278c8631..6140e4927322 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *dev, void *ctx,
 			      req_ctx->mlli_params.mlli_dma_addr);
 	}
 
-	dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
-	dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
-
 	if (src != dst) {
-		dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_DEVICE);
+		dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FROM_DEVICE);
 		dev_dbg(dev, "Unmapped req->dst=%pK\n", sg_virt(dst));
+		dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
+	} else {
+		dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
+		dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
 	}
 }
 
@@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 	u32 dummy = 0;
 	int rc = 0;
 	u32 mapped_nents = 0;
+	int src_direction = (src != dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
 
 	req_ctx->dma_buf_type = CC_DMA_BUF_DLLI;
 	mlli_params->curr_pool = NULL;
@@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 	}
 
 	/* Map the src SGL */
-	rc = cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_nents,
+	rc = cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in_nents,
 		       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
 	if (rc)
 		goto cipher_exit;
@@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 		}
 	} else {
 		/* Map the dst sg */
-		rc = cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
+		rc = cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
 			       &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
 			       &dummy, &mapped_nents);
 		if (rc)
@@ -456,6 +459,7 @@ void cc_unmap_aead_request(struct device *dev, struct aead_request *req)
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
 	unsigned int hw_iv_size = areq_ctx->hw_iv_size;
 	struct cc_drvdata *drvdata = dev_get_drvdata(dev);
+	int src_direction = (req->src != req->dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
 
 	if (areq_ctx->mac_buf_dma_addr) {
 		dma_unmap_single(dev, areq_ctx->mac_buf_dma_addr,
@@ -514,13 +518,11 @@ void cc_unmap_aead_request(struct device *dev, struct aead_request *req)
 		sg_virt(req->src), areq_ctx->src.nents, areq_ctx->assoc.nents,
 		areq_ctx->assoclen, req->cryptlen);
 
-	dma_unmap_sg(dev, req->src, areq_ctx->src.mapped_nents,
-		     DMA_BIDIRECTIONAL);
+	dma_unmap_sg(dev, req->src, areq_ctx->src.mapped_nents, src_direction);
 	if (req->src != req->dst) {
 		dev_dbg(dev, "Unmapping dst sgl: req->dst=%pK\n",
 			sg_virt(req->dst));
-		dma_unmap_sg(dev, req->dst, areq_ctx->dst.mapped_nents,
-			     DMA_BIDIRECTIONAL);
+		dma_unmap_sg(dev, req->dst, areq_ctx->dst.mapped_nents, DMA_FROM_DEVICE);
 	}
 	if (drvdata->coherent &&
 	    areq_ctx->gen_ctx.op_type == DRV_CRYPTO_DIRECTION_DECRYPT &&
@@ -843,7 +845,7 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 		else
 			size_for_map -= authsize;
 
-		rc = cc_map_sg(dev, req->dst, size_for_map, DMA_BIDIRECTIONAL,
+		rc = cc_map_sg(dev, req->dst, size_for_map, DMA_FROM_DEVICE,
 			       &areq_ctx->dst.mapped_nents,
 			       LLI_MAX_NUM_OF_DATA_ENTRIES, &dst_last_bytes,
 			       &dst_mapped_nents);
@@ -1056,7 +1058,8 @@ int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 		size_to_map += authsize;
 	}
 
-	rc = cc_map_sg(dev, req->src, size_to_map, DMA_BIDIRECTIONAL,
+	rc = cc_map_sg(dev, req->src, size_to_map,
+		       (req->src != req->dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL),
 		       &areq_ctx->src.mapped_nents,
 		       (LLI_MAX_NUM_OF_ASSOC_DATA_ENTRIES +
 			LLI_MAX_NUM_OF_DATA_ENTRIES),
-- 
2.25.1

