Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD104F62DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiDFPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiDFPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:16:43 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7E3520E61
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:16:34 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e1e5e8d9faso2677156fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRK2iHcZ9JGwfO4QnMiDs/a6NPe5T+0ewcruwhEjB8U=;
        b=EWHuYiPJIn2gnHd8UHZ5X+qZee96O656e2rBtF4Dn3vTqVNEcMKnSDWfDSE2gcS7sW
         SmR1H2sun0Hzg1N7Ydi7C15ssqZ29XAa/pQbDg4nXua1fD7TKeeGrGSB92I4NcebMR1q
         4o2mSR5vB8HDzmieQ7rNPPtYrdSH+nRp9bO8blvTEkyppXR7V9udJiXfU8+KOd9MmJow
         1QNEJrEuIThJtYMAWoa80J8AQEfUCRyczT7qEPK+AysX8UE1e2YrevC33uwQFagLUcuQ
         O9znufBQpN22sqv6WQCsD07uIxMhvH2JGUMl7TOYB4v5WN4HudMjrOVwPeNIE/3Xkl8n
         KMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRK2iHcZ9JGwfO4QnMiDs/a6NPe5T+0ewcruwhEjB8U=;
        b=wlh9aEndtBLZZTcwemyiEpRreAsW49jtocDPVIK3hESGIOxYtjkQ56hhhSNJp+tL6w
         nfoAfnXxYwbWSrVwv9EtKu1eKgWiIaBL8bvdYgGGsm83IPFjr+q0JQS96nvshCqsQ3CO
         0sTarXtHLygkoJP0gcLxAXg3hqjk7dAwPJ9uMH11VSYtdXm94zJhw1CwYe02PETdX3IX
         sM9vnCO1a3S8fGE9TW7YL7etrRsQ0q6iOJo5jUr541YcUhXcFnOcFq2qdlESLJ5VS3so
         xTbrEhkms5UF3h5kPft4mRJhco1IZInoa4ALeAE2YZoPIi9bhlwzNbfgj2v+H6UB7+sM
         OBNQ==
X-Gm-Message-State: AOAM530sOL8SCCFvHlJxx2vHyfrqTOHSkJFygEe8cbDQyKjYuawWRqV2
        R8fSiJqzntQr9sRiOtBU8k50dg==
X-Google-Smtp-Source: ABdhPJyAvDBkXbpZIInakNZ6h93PhBwf4bkzSKscwcQKjaFgR4e2+tKbyjkjmp4L8SQtKCHpPVfxEQ==
X-Received: by 2002:a05:6870:a106:b0:de:de08:4e42 with SMTP id m6-20020a056870a10600b000dede084e42mr3708390oae.247.1649247389569;
        Wed, 06 Apr 2022 05:16:29 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:2e13:8e30:84f7:1597])
        by smtp.gmail.com with ESMTPSA id q6-20020a056870028600b000d9be0ee766sm6349049oaf.57.2022.04.06.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:16:28 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH] iio: ad7266: convert probe to full device-managed
Date:   Wed,  6 Apr 2022 09:16:20 -0300
Message-Id: <20220406121620.912350-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert probe functions to device-managed variants, with exception of
the regulator, which required a devm_add_action_or_reset() hook
registration.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/iio/adc/ad7266.c | 43 +++++++++++++---------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c17d9b5fbaf6..4f8f07d5c1a3 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -378,6 +378,11 @@ static const char * const ad7266_gpio_labels[] = {
 	"ad0", "ad1", "ad2",
 };
 
+static void ad7266_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7266_probe(struct spi_device *spi)
 {
 	struct ad7266_platform_data *pdata = spi->dev.platform_data;
@@ -398,9 +403,13 @@ static int ad7266_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
+		ret = devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st->reg);
+		if (ret)
+			return ret;
+
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
-			goto error_disable_reg;
+			return ret;
 
 		st->vref_mv = ret / 1000;
 	} else {
@@ -423,7 +432,7 @@ static int ad7266_probe(struct spi_device *spi)
 						      GPIOD_OUT_LOW);
 				if (IS_ERR(st->gpios[i])) {
 					ret = PTR_ERR(st->gpios[i]);
-					goto error_disable_reg;
+					return ret;
 				}
 			}
 		}
@@ -459,35 +468,12 @@ static int ad7266_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->single_xfer[1], &st->single_msg);
 	spi_message_add_tail(&st->single_xfer[2], &st->single_msg);
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, &iio_pollfunc_store_time,
 		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops);
 	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_buffer_cleanup;
-
-	return 0;
-
-error_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static void ad7266_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7266_state *st = iio_priv(indio_dev);
+		return ret;
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7266_id[] = {
@@ -502,7 +488,6 @@ static struct spi_driver ad7266_driver = {
 		.name	= "ad7266",
 	},
 	.probe		= ad7266_probe,
-	.remove		= ad7266_remove,
 	.id_table	= ad7266_id,
 };
 module_spi_driver(ad7266_driver);
-- 
2.35.1

