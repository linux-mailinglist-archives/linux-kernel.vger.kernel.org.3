Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76459F7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiHXKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiHXKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:40:09 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1180F56;
        Wed, 24 Aug 2022 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661337608;
  x=1692873608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExxK4259tG5nnE3ln+0qV2zPOa5+AB6wgMpbTvSsFKk=;
  b=Bu+LGXWZ7xaM+BpLBDtYJVMhf84QRJ7WX6Qa4LtToYL6vn0nhdvjBuVj
   hZkPWgfk5R0LUWV56ZXVhPlbVLdXJ6eNTei81dIDc48qCf0cejkuoSQo7
   Q2fWCGf7UXAoGLZJvG27BCl6SRYtzldoqL34GJPSjW8uaCjXubQ3THjGT
   C7L5JdHI+/QMm1fhYxu7gAu6mBr8dm7hNflUytZUQCnsaMUjMc6tvqSAb
   QEmn4YSuLmSUzzcINtdcs6umTWV+O7K/ex4rbifg3sOrHLbaAguAZxK2I
   wePD1JjcG1Tm5myrgbWnhBu/fl6XsEq6OYGsWodmKTW5o7i7xbj8H6w48
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <axel.jonsson@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: adc: mcp320x: use device managed functions
Date:   Wed, 24 Aug 2022 12:40:01 +0200
Message-ID: <20220824104002.2749075-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* functions in probe to remove some code and to make it easier
to add further calls to the probe function.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/adc/mcp320x.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index b4c69acb33e3..28398f34628a 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -371,6 +371,11 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 	},
 };
 
+static void mcp320x_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int mcp320x_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -445,27 +450,13 @@ static int mcp320x_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	mutex_init(&adc->lock);
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto reg_disable;
-
-	return 0;
-
-reg_disable:
-	regulator_disable(adc->reg);
-
-	return ret;
-}
+	ret = devm_add_action_or_reset(&spi->dev, mcp320x_reg_disable, adc->reg);
+	if (ret)
+		return ret;
 
-static void mcp320x_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp320x *adc = iio_priv(indio_dev);
+	mutex_init(&adc->lock);
 
-	iio_device_unregister(indio_dev);
-	regulator_disable(adc->reg);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id mcp320x_dt_ids[] = {
@@ -520,7 +511,6 @@ static struct spi_driver mcp320x_driver = {
 		.of_match_table = mcp320x_dt_ids,
 	},
 	.probe = mcp320x_probe,
-	.remove = mcp320x_remove,
 	.id_table = mcp320x_id,
 };
 module_spi_driver(mcp320x_driver);
-- 
2.34.1

