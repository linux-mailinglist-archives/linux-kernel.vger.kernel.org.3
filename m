Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98704FBA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiDKLNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbiDKLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:13:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356845508;
        Mon, 11 Apr 2022 04:10:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h10so2603696pfr.10;
        Mon, 11 Apr 2022 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XXujWv8lbJXMrh5FclRTjsJnuyiej8YOUUAvRohoa3s=;
        b=gcT9GQEj1t1ZMdyhctXLydfAFX5hJlcGLVeDVXE4xRStIU2phGu2595faUy4D1XVQi
         8NSlPudyh3AoIrKfEXsKH69GAECt1esYOrQJRR/FqRoRD11sgBzHskkRewUOdrXyEiUp
         TqBPv6EKHFYBtQq6tHrGMj/esWKe1/h13FeoMF+mSYO6m+4NVXpqcLoEk8Zv254RDUJ5
         S+XPXVWWMJSezaAIYNRmaFn5PTNn3g41KbYdteLwnTSUCZKQboIYrR+FshheB1W7N9Q9
         6y36Ot/AwRSZWFAPOXwRU1n6mzm+F11yj0Qmw2CzLVoi8Geh/pUWpHA76QDVpBf63Q8T
         YkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXujWv8lbJXMrh5FclRTjsJnuyiej8YOUUAvRohoa3s=;
        b=kHQ/nuQnOFHLTahuGOZTyj/8d3MRL4l5pjJvt3RnmyrsVxAaKQkr8zOh8ZI7MHYoZ1
         fFMrnJpbF7TGI1LtznxEZJO8h2/5oBEdjt3NVHoji99Hf8PciDZUY6G5J7uAAHmKugKw
         bqKhLE9Uq2VrqaVYyt/41Ty74r+vPqvAAKqLd6Omfhj7jC4zvuL4AAKPIDJTYZj04udY
         AvQ2Ghhp3iNOwV/HXKSUemOFWynZunUY9P8WyI4L+4zg3Ey7AljsonT5ouT4Y8OGDDor
         aJBkuGInXDGxYZ796pJTJl1NOa1/q2A5vIMSKl4tOGk+Rk/ImS6MuMSx9adDEnOm4tNp
         eZTw==
X-Gm-Message-State: AOAM530c1mvmNy4Y0b+7GbxTa0JuYfoPEUnQiiBkwJveCZ5jOpC6C02e
        JJ0wHkyYf2vR98x5Kv3znbA=
X-Google-Smtp-Source: ABdhPJw72lmFNFIrZAgtp85ZjO3V6LbjMyNXozucroQEKDrnteZXfV9NtvRYf7wNnYPlC4pJ653QKg==
X-Received: by 2002:a65:638d:0:b0:39d:74ad:ce0b with SMTP id h13-20020a65638d000000b0039d74adce0bmr1023945pgv.103.1649675439049;
        Mon, 11 Apr 2022 04:10:39 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm34628169pfv.123.2022.04.11.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:10:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout
Date:   Mon, 11 Apr 2022 11:10:33 +0000
Message-Id: <20220411111034.24447-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 5720ec0a6d26 ("spi: spi-ti-qspi: Add DMA support for QSPI mmap read")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/spi/spi-ti-qspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index e06aafe169e0..081da1fd3fd7 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -448,6 +448,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct dma_async_tx_descriptor *tx;
 	int ret;
+	unsigned long time_left;
 
 	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
 	if (!tx) {
@@ -467,9 +468,9 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	}
 
 	dma_async_issue_pending(chan);
-	ret = wait_for_completion_timeout(&qspi->transfer_complete,
+	time_left = wait_for_completion_timeout(&qspi->transfer_complete,
 					  msecs_to_jiffies(len));
-	if (ret <= 0) {
+	if (time_left == 0) {
 		dmaengine_terminate_sync(chan);
 		dev_err(qspi->dev, "DMA wait_for_completion_timeout\n");
 		return -ETIMEDOUT;
-- 
2.17.1

