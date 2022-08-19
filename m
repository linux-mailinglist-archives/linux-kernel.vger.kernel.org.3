Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D042599517
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbiHSGJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbiHSGIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7B356C5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w19so6977160ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5dgh0mRNVGiAT981rc+BiMLlWYrkrNgUD8IdfprQkqA=;
        b=W5WMmy+an0THIibSKrr3bcWg4gjuYgGgd72fP/ALycZ+7+Pa0SfJykH8cr7EcbmFhQ
         azhFHI6OBwkWgPK6ZpMfr9Om11xd/5LqmEKxVhg6en5ryfV3ZPV0QgnB/7UKMtO/gzan
         Z//ONWSeVL4TaZpjD7YmjJpps5VFk3z3CfxYVx6wMJO+M1Zh3Z8STOFwIoBCOpMHiSjD
         zkZxUsCZuHqQ59thjGYOvNcdcAZ2nY00mRORym3v7Fjb2NKri7WM4bq1wuFPX9Tcg/3l
         EkQaSVW96Onm/Rz+9wbCm9GDcPL9ONsaT1bt5Ymm4kl/5J+miqTeNDeNblYHym9NerAd
         ghVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5dgh0mRNVGiAT981rc+BiMLlWYrkrNgUD8IdfprQkqA=;
        b=QM42p8ziDQdn3TUFCAs1aWb4xu0PhHcHXo+7ySATAk5CSVwGhAampnOB50FQLqoDxk
         xfPULX3jHZ+CXPcyo11oIzsdk8eqN2VGU6DqLfPs9A4tnvCB7ref+Rmv5/uveoiw6kqb
         vXAah3Fykq8SEMjWjQdZpWbfqL+q4fViqHzS5DEJbUdTgicTN/dx8Gw184AbNe2rUnuV
         Rf2NS/tVeTR2hBcnFAqY6MCZryC6u2zVTGEGhGYqt2HAQES9nSUOHqN3/DzkPYvRo0l0
         d7ZuCi93rs2Jf3rptPl12vDj54rTbwWQGPChby485XQIyy3foBSWS91aTUibAyS7N1nX
         LjeQ==
X-Gm-Message-State: ACgBeo1vQo2TpBYzbLuMidVX0reSTFgxJ0lT+c3sx+rbywj5slRkntB6
        ir0g940ZlhTJcIX/5omoL5vu4f7ROeHmv3JO
X-Google-Smtp-Source: AA6agR4w+Ar1X7e4t7akiH3do+1BZFgD+ksEGLVKvjAc15jlYgFPvVhkpqkmoIXMBHOiP6bq4bnzGQ==
X-Received: by 2002:a17:906:730c:b0:730:da74:3453 with SMTP id di12-20020a170906730c00b00730da743453mr3837859ejc.270.1660889306078;
        Thu, 18 Aug 2022 23:08:26 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [PATCH v1 15/19] nvme-fc: Fix the error check for dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:57 +0200
Message-Id: <20220819060801.10443-16-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

