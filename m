Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272EE5A091D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiHYGsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiHYGr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:47:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3BA0276
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:47:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so24818937edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WJ7GBNHN6AoVv9ZeH0urLLa0hH2huW2RwMDCHhQJQUs=;
        b=d6bUCj/UvDMnRfnKyskgkByJo1qmZAo616iARuRQkWWCLeIP4Z9rfvc3DCBpbZsHlP
         KTxjAxUjNKC0ca6HElPoVtJtqBqYS8+W795nbrRnRSgRys8RpXduYkix1MZcnu6/HioI
         ocG6YqnD1sOrtdVpTp+mhQXlLHNtQHjayJXjAde8V2kn2GdvtFjivTfNgjaG0kLdRUaH
         wx0G+FeDpnQLnjj4/YOMxiUMRhzAEL3tpaPXcoRwd5ZoXwAZ9E9qCDfWaZlGBjwmit3B
         gcCR9kyatFVXcMPA7VQQ61iyOWutwdAvxJgbVLSU6lJ0l9kmlAqQlc3SLcMBTlRMHLOX
         PpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WJ7GBNHN6AoVv9ZeH0urLLa0hH2huW2RwMDCHhQJQUs=;
        b=JPrVujAE6WbTrA8znLsGp3VcdAgO4siI7flXjPbHpvL0B98UTUpemwpJYnC6dWEOhj
         wzyfpQE6Cyb98oq2XOXZGAPlCTlcFg7+MvfU9bxEVTJ/ALxjsWl/M8oNsmyp9rwEq7cY
         SA4oFI2HzM8rpj1WYnzOtdPMuSfqNYerbHWh0MX6xpvUSGgCXGxY+nemq7B3ITojNLLz
         kkSVo9nRsdQfQHgRrKEev7lpnXHWbgC2fjPS/PXckesrRVcH6Ton4vrR3J785Y8XnJ9G
         G+M/lwIsh2mMnC/JFwwVCy+nI+W2T6LKMDkcWLMf+rRdok9CZw3E1OUvwmaItrhopgqg
         D2Og==
X-Gm-Message-State: ACgBeo1zrW+1GiBq2vuGJbPo9Aln6wrN5p1U2CuxEk/em81AXa4vT5kZ
        /2wIMX3I6LrU5kFZ9lnv3+ca5Q==
X-Google-Smtp-Source: AA6agR47CytgekKsTgSt+j2KQwkdMlmF15xtMtjBIFjJrYQS67CvpLZ+4Bs7+CZRQ9qANAJv7tB9KQ==
X-Received: by 2002:a05:6402:26d6:b0:447:391:5d32 with SMTP id x22-20020a05640226d600b0044703915d32mr1913796edd.424.1661410070906;
        Wed, 24 Aug 2022 23:47:50 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b0073100dfa7b0sm2063564ejz.8.2022.08.24.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:47:50 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     hch@infradead.org, axboe@kernel.dk, linux-nvme@lists.infradead.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme-fc: Fix the error check for dma_map_sg
Date:   Thu, 25 Aug 2022 08:47:47 +0200
Message-Id: <20220825064747.22521-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825064747.22521-1-jinpu.wang@ionos.com>
References: <20220825064747.22521-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, add missing check.

Cc: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: e399441de911 ("nvme-fabrics: Add host support for FC transport")

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/target/fc.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..95050f2e0a06 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2616,7 +2616,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 	WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
 	freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
 				op->nents, rq_dma_dir(rq));
-	if (unlikely(freq->sg_cnt <= 0)) {
+	if (unlikely(!freq->sg_cnt)) {
 		sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
 		freq->sg_cnt = 0;
 		return -EFAULT;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ab2627e17bb9..3749ca28860b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2089,6 +2089,11 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
 				/* note: write from initiator perspective */
+	if (!fod->data_sg_cnt) {
+		sgl_free(fod->data_sg);
+		fod->data_sg = NULL;
+		goto out;
+	}
 	fod->next_sg = fod->data_sg;
 
 	return 0;
-- 
2.34.1

