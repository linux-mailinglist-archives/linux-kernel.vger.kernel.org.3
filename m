Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE25A7AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiHaKFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiHaKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:05:21 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA19543F3;
        Wed, 31 Aug 2022 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661940317;
  x=1693476317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IV6/GgZtvZM/HS0HfOk29zo087rTH6OyitDmydT3TPc=;
  b=MI+LNoqsJCy2Kkkg27zpOmFqFqpaVwsfQjFC+B1/1OOmkIAHk0ehzs9R
   sma56gJoNT8wlDpd7F39bcEW+hAAEbvU0iKa8m9sZyJ5VlHTn4mifKM37
   YoEkev4a0+4hBayPcbensKILZL8ZvVynN08nC3p1KfeROp5zf6ZiHe72Z
   8mYvN0NVuINcTzj3W9HM4Rp60UJ3fUoPUpQhRNmK/T7xe0vmp7DuiEyLG
   FalSgheXJvmRmuwrza4O+SLnemTEcQfWjgEXFHIkw9M3xB+PlMOqf/3zg
   vMUmA70AXWGRs5U6ICBk1ZMIzhIruy2FdxfRsTomc6KpRBGA+9LwpeDav
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] iio: adc: mcp320x: use device managed functions
Date:   Wed, 31 Aug 2022 12:05:05 +0200
Message-ID: <20220831100506.3368103-5-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 8ed27df9a0bb..b1c1bf4b8047 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -390,6 +390,11 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
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
@@ -460,27 +465,13 @@ static int mcp320x_probe(struct spi_device *spi)
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
@@ -535,7 +526,6 @@ static struct spi_driver mcp320x_driver = {
 		.of_match_table = mcp320x_dt_ids,
 	},
 	.probe = mcp320x_probe,
-	.remove = mcp320x_remove,
 	.id_table = mcp320x_id,
 };
 module_spi_driver(mcp320x_driver);
-- 
2.34.1

