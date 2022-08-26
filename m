Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033E35A259C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiHZKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiHZKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:13:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C23B6035
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:13:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m1so1502742edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=d7GvD5Hf8tzx2V16UHtbEc4zSmsYhgs5namwMdUKQPg=;
        b=DLLfCVlp2U4QI+BOhllreQjGGdeNESlyL55nAHcCzcYmShTeExBKWkQ8ZA1ApIjW4J
         AjaYWoZoJo9NDRXioB05eBFV1jRVqOVW69HKgFLTXWhA7V+cuSL8o2Y7WMlIoJwVoWxT
         WuVYZJYr+xIYnNF95OfB8bwv8L1IcagqS+AcyecQUqlHNHAawiOERmqhC7/Rly/KH0Ui
         d/UqZYdn/ig3f/9f4lZ+FRzqr+P3s5muGeLRSmoxjtVja1SW5q2pLyPlEcQBVspxrawu
         XSrGs73N6fuT1JEJGIbmW9Wqalj2h+qtpzD/VH82N8Wm0/YUakiWfrln/mfMgPHG3COo
         CP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=d7GvD5Hf8tzx2V16UHtbEc4zSmsYhgs5namwMdUKQPg=;
        b=i53wSUdipf0rDrHY6M+5W2mrv+ezPo3gqkebjsYu37mCez1D8Dii6P/eXmlEFn+6JM
         njMsst1eH1NzcgkPYJMjw96vflH4qfwxyWQad8W6RbUcvippY6uvLO4Ke/sANTZqMZFQ
         l9flkyKb8wotDQ5+OoIvPrndzFCDGyqVt+gyhrCT3+hhrEiGKEE05gbr99NId0Icu67n
         NRCbM8R+m5X6ToNuVKi3LkyXT9+GrRHR7qedRNOxgi8Wke8udZZvXnUBaZ8ZJR0TqoJl
         I6ClwqSw20LEdFvV9r3vUGpgyKRQI2OxHdZhPwgAj0SunjYqVjZyOzScGr9zoVRWzJxg
         w3aA==
X-Gm-Message-State: ACgBeo2aBtfxa0k5fQbqcJZMaHZbSM1H87HTdpvqQOx+XORghqYjb2Rk
        BcNgVXwXI9pT7FIRsLY80wRQzw==
X-Google-Smtp-Source: AA6agR7B2EVGoS22Haj9Qb9AHKKqUFAmMhvtd2k/yh1GQcATYVpHaR3x5yGcs4xvVnQEJ861RjW53w==
X-Received: by 2002:a05:6402:2694:b0:447:24fc:1749 with SMTP id w20-20020a056402269400b0044724fc1749mr6323306edd.250.1661508817318;
        Fri, 26 Aug 2022 03:13:37 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id og4-20020a1709071dc400b0073ddfe1ea69sm707920ejc.111.2022.08.26.03.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:13:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: bcm-ferxrm-mailbox: Fix error check for dma_map_sg
Date:   Fri, 26 Aug 2022 12:13:35 +0200
Message-Id: <20220826101335.78779-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
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

dma_map_sg return 0 on error, fix the error check, and return -EIO
to caller.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index fda16f76401e..bf6e86b0ed09 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -622,15 +622,15 @@ static int flexrm_spu_dma_map(struct device *dev, struct brcm_message *msg)
 
 	rc = dma_map_sg(dev, msg->spu.src, sg_nents(msg->spu.src),
 			DMA_TO_DEVICE);
-	if (rc < 0)
-		return rc;
+	if (!rc)
+		return -EIO;
 
 	rc = dma_map_sg(dev, msg->spu.dst, sg_nents(msg->spu.dst),
 			DMA_FROM_DEVICE);
-	if (rc < 0) {
+	if (!rc) {
 		dma_unmap_sg(dev, msg->spu.src, sg_nents(msg->spu.src),
 			     DMA_TO_DEVICE);
-		return rc;
+		return -EIO;
 	}
 
 	return 0;
-- 
2.34.1

