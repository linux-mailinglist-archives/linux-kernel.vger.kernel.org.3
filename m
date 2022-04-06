Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CE4F6BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiDFUxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiDFUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:51:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA53CBF38
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:07:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so6261381ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LQaWUct48NS9KOzqSJyG6Q8nrCLvO/0d/8JaBy+8UI=;
        b=8TLmi9yBHa5xfLlHJtNCWx/79qp4+wuKkyxTxgSZtFc2EXW66RIEfopio1Yw+IBGtI
         6zrd5FaUZBKsPWNz7OcfX4S8P/YnO6QAQsUVEIP8ecGjtCTCwGvutCrVx7+QzVtjDmo4
         vDA3YxoKJixzsVnvWjfdYRN2iLRa7hBuqURTaxUrLei+2EAA1QYn6SdisYjJFh1oalQT
         WfnTDmBuLl53v1JN5NavC3N5mpE2QkeT9bRWdMFUesnvBV4W9OLhmzE2tQUrooRgOY0p
         iIRanPlPSedLVXDBbtP2wmNAqqk05QBOTOzOTgU/fqykRCZGO+fJcwCyjEQD0Nlp/ijn
         gYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LQaWUct48NS9KOzqSJyG6Q8nrCLvO/0d/8JaBy+8UI=;
        b=HMl2dxhm1ztvYn51KQn0l+inIAsZr4xujhtli9V3YvdanxOmMscWuSTl8oJ01wDqsp
         j0fkw2B9w0WGdOCIKeOcih/syT/SBJolTIN3rmy+VNr451OeuvS3mobC2YwbvXAwHbhi
         usRis/qTPy9s1L/W47I2LTeJO/YlsuNxeYmvR7SsJpDO8D6fKPeTa/QOvJe/dXdOgWOx
         +zMsJnO3s1H2rD4778HmKg5R0XOjWKIPHhIxnuKXRLqO+kQtwcbXYa0Y2viQlssJNuXe
         hOJfr+NyLdMYER51krS/SfW4fFAPTvYPewvbPRWOASTCxr2H62exBgV5/MyYbtB9U6lA
         tj2g==
X-Gm-Message-State: AOAM5310AatH1HBjbm6oZ7zoEaE9Zyt1PNGHp8jPVxDS1RuMKMTjXK+B
        hDlV1aBpkaeuL54DLIVTFdGCKw==
X-Google-Smtp-Source: ABdhPJwRJutJaI7ufjruNvQEHwLj2pj6On47DxDImFWmez6E6EnVTp6BuR7eMlhnvrAAGLTGDlyZjA==
X-Received: by 2002:a17:907:1c9e:b0:6e0:2fed:869a with SMTP id nb30-20020a1709071c9e00b006e02fed869amr9619973ejc.122.1649272055250;
        Wed, 06 Apr 2022 12:07:35 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm6853732ejc.120.2022.04.06.12.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:34 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 4/7] drbd: Make use of PFN_UP helper macro
Date:   Wed,  6 Apr 2022 21:07:12 +0200
Message-Id: <20220406190715.1938174-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cai Huoqing <caihuoqing@baidu.com>

it's a refactor to make use of PFN_UP helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   | 2 +-
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_worker.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index df25eecf80af..9e060e49b3f8 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -683,7 +683,7 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 		}
 	}
 
-	want = ALIGN(words*sizeof(long), PAGE_SIZE) >> PAGE_SHIFT;
+	want = PFN_UP(words*sizeof(long));
 	have = b->bm_number_of_pages;
 	if (want == have) {
 		D_ASSERT(device, b->bm_pages != NULL);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 911c26753556..c6c1843452ba 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -364,7 +364,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
 	struct page *page = NULL;
-	unsigned nr_pages = (payload_size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	unsigned nr_pages = PFN_UP(payload_size);
 
 	if (drbd_insert_fault(device, DRBD_FAULT_AL_EE))
 		return NULL;
@@ -1631,7 +1631,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	sector_t sector = peer_req->i.sector;
 	unsigned data_size = peer_req->i.size;
 	unsigned n_bios = 0;
-	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	unsigned nr_pages = PFN_UP(data_size);
 
 	/* TRIM/DISCARD: for now, always use the helper function
 	 * blkdev_issue_zeroout(..., discard=true).
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0f9956f4e9c4..af3051dd8912 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1030,7 +1030,7 @@ static void move_to_net_ee_or_free(struct drbd_device *device, struct drbd_peer_
 {
 	if (drbd_peer_req_has_active_page(peer_req)) {
 		/* This might happen if sendpage() has not finished */
-		int i = (peer_req->i.size + PAGE_SIZE -1) >> PAGE_SHIFT;
+		int i = PFN_UP(peer_req->i.size);
 		atomic_add(i, &device->pp_in_use_by_net);
 		atomic_sub(i, &device->pp_in_use);
 		spin_lock_irq(&device->resource->req_lock);
-- 
2.35.1

