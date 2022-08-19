Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C362D599513
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbiHSGIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344745AbiHSGIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A084C6536
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i14so6976699ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8hlJvz8Cg/RSrujn6eg6W9O1c50l+s7v5Bap/Ro2DSs=;
        b=QpTQj96OHSBiF7tI4jxZPrwsWxnv4EMkhARwtlJprTIv0jkFZqhlyuPYYGl9KsPENl
         V2MRG7o8n1+53/ashGW+rbaOAwckPTDDZDNRLjDq7/V7AYlSfCrPfInQ9W6vxdbNp/wF
         ZRFqu6lJtWWZ75FOnCHvpGQtfg3P657Qk/k00u8/4fg2escTuXxi4US8QHzEhCkwf5ub
         oScgZsOAZ9OSr/s7CTzJOLQN1cMzXs2UdmC9xtl4D4MRU0C8CvYTVWQ4TkuTvaQFbonH
         BSXM8qdXESIWM1gpwM9CIahklf7IxLUpxK6WtBRkVSTcgKBgAzhi/jaloiDTsDuEUGHv
         5Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8hlJvz8Cg/RSrujn6eg6W9O1c50l+s7v5Bap/Ro2DSs=;
        b=rEXIUiH2gwQo+y/Ru1ETspsgxElE+lf7Rftq6GAwlAkZXoOVh6iZv5Bv2M+wh5Wm2v
         kVa0oGdVQLMrY1X/9qAYo+8f7HXMUrFj5NiYb1ew2zQpWWbpeaIdsdhh+fH0ueP5TUOa
         ErYvSEZuumJIx+s16InA+3c/P17JB/0/aAn2bNfszidFCkglT7RiJz5GDeqR7kYC6led
         WcafH5vDk3XwwJRwvZI2a0mApqaphbJt1/XgQzxrBexoWXpcPwMhp10kVxYiSagi5LHg
         EMF6y2F6LgK9thNIn9rZKFgsVqZM1FMMZIKYobc0VM2sRCbezXKz3L2/TOOV1BCN6iih
         /4VQ==
X-Gm-Message-State: ACgBeo05QDf+PTxT3dxhwHtUE3VOpt8xCPAjNsPmRC5Qx3V4dm4rqFQk
        KFAizZNtM5ZbjXW2NPQmI6Q4E2Y/xE3WHg==
X-Google-Smtp-Source: AA6agR7/JhpdOMPLzO6RkZBvrR6nCK3+sQ6xgvqtcn+PCOKPalLO6+fAFWB2nSXAP9dj6tiCFYn9Uw==
X-Received: by 2002:a17:906:8b81:b0:733:183b:988e with SMTP id nr1-20020a1709068b8100b00733183b988emr3834146ejc.457.1660889285398;
        Thu, 18 Aug 2022 23:08:05 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:04 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH v1 02/19] infiniband/mthca: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:44 +0200
Message-Id: <20220819060801.10443-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, in case of error set
EIO as return code.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Håkon Bugge" <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/hw/mthca/mthca_memfree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index f2734a5c5f26..44fd5fdf64d5 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -189,7 +189,7 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
 						   chunk->npages,
 						   DMA_BIDIRECTIONAL);
 
-				if (chunk->nsg <= 0)
+				if (!chunk->nsg)
 					goto fail;
 			}
 
@@ -208,7 +208,7 @@ struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
 		chunk->nsg = dma_map_sg(&dev->pdev->dev, chunk->mem,
 					chunk->npages, DMA_BIDIRECTIONAL);
 
-		if (chunk->nsg <= 0)
+		if (!chunk->nsg)
 			goto fail;
 	}
 
@@ -482,8 +482,9 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
 
 	ret = dma_map_sg(&dev->pdev->dev, &db_tab->page[i].mem, 1,
 			 DMA_TO_DEVICE);
-	if (ret < 0) {
+	if (!ret) {
 		unpin_user_page(pages[0]);
+		ret = -EIO;
 		goto out;
 	}
 
-- 
2.34.1

