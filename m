Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C25A091B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiHYGsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiHYGrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:47:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B070BA0611
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:47:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v14so1118434ejf.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QC7+lTB8CYjJ8qP7QXHCezGR565iBisGsJnf8ENWV5k=;
        b=Qnfw0DrQibQa4hawUYilpeQDYvZJuvkVWvJpHFRJSCSeL5XJ0IvnXVdiz73C8G+Am/
         akblccok2ppfkAca08ptLEqfHw3px2LqIhRen0PE28RMqRUZ10wQy0sht040oZjHMV/3
         SuVtxn+9i7LSuwlC1nNy/1iObR805oJ+MJcYKSvlSjwt7k04+lsl106k5nQKRYpDMTEz
         X8Uhlp1ofZSKEeLGWGqPAjJvBB4fmcPO3M5ytmTLPUkTUEvSM41WBam8axvHZS1a8YqY
         fEdm4KGhlArw2yzwpTYSPH1+4Y3Sr4eioD5W4rICKk6h9siP5IP7zDneDHw+YhYyGJTZ
         prXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QC7+lTB8CYjJ8qP7QXHCezGR565iBisGsJnf8ENWV5k=;
        b=bpde7fjgCA1e5Ic3mJSWT8eNXz4h0mKqq7+0rjid00BlHa1rkxNwmLAW/17AHBVbaa
         zshGfnQ+XlxoZqDl0Zvmx0C7bb+TXAQcHh2dFrnBO9kh7ADXlma4vPkhB6QhHZx4xdcq
         LYJA7NbqdXu6k7MofFrCqYp2adBN+grPGKe3QLcrdLDQw/VfCBmFl4BshkRdhfWuqgOo
         DfWV2cd0/YHTE6hxNbOLGOAouBgyWUrKXx1TXRLMqmDrgPy7/YXg+h/ydQYCvcGKnGXA
         YUlv4hxtjOUEqPRWuLoyz7Awh5LwyqDNweSZH/1WTcN1yOIETQjv89Q0XAPFN1W/PTSM
         VV0Q==
X-Gm-Message-State: ACgBeo0kcSQhbY3WD+yl+DpjSLCLQfnjixHo7vEnsxnf9YVg265qVnFI
        WFdi20QZ3tgWCmEEdpSd0WsxXg==
X-Google-Smtp-Source: AA6agR7Lvqd8XFW8p4kZ7wnCxdcwCOj2Dlxbk7sGMmdOP77SeN/pAqxwgEb22kPrxaSK/ltW44vf2g==
X-Received: by 2002:a17:907:3e9b:b0:73d:8ccd:2bb1 with SMTP id hs27-20020a1709073e9b00b0073d8ccd2bb1mr1475204ejc.568.1661410069937;
        Wed, 24 Aug 2022 23:47:49 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b0073100dfa7b0sm2063564ejz.8.2022.08.24.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:47:49 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     hch@infradead.org, axboe@kernel.dk, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme-rdma: Fix error check for ib_dma_map_sg
Date:   Thu, 25 Aug 2022 08:47:46 +0200
Message-Id: <20220825064747.22521-2-jinpu.wang@ionos.com>
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

ib_dma_map_sg return 0 on error.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 711023071960 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..d70bccbcba3e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1551,7 +1551,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
 			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	if (unlikely(!*count)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
@@ -1574,7 +1574,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
 					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		if (unlikely(!*pi_count)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
-- 
2.34.1

