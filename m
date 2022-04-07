Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F164F7E80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiDGL6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiDGL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:58:34 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6147ACD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:56:30 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e1dcc0a327so6093285fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoNJyQ9i7p9EmUWA3T7gto6j9HpcpbaFgL9mxYK2vi0=;
        b=c59uRjC89onHqXp7pfqBNuJzt16ZqqwD3qw108yHuG0zwUe7z+kEyAQ6kAKT/sANRk
         8B5R6JpfKscpAlwdIqvR8mmLmj5KoRQDwwtZ0ZcTVd1wNNhbpBprPL0PqThG1qRONVK4
         DFlMiIJME/azHjdAPBtMo6tc3UVzXnKcInPQwOSYGW030sbFLze4PcIbmaH3tSrbPbqD
         7grKCWsOdEc862M7yxsL6AlOtreITnSnCfWFl20LUMJH9puWt/2drEUDrhkLwJ0m47Rj
         OoaGT2loAeV8ESZjCKo6f+MEO2s1hQCFSp6wBwSgH0xnc6HugFOTsmFW6mnEiMYleizR
         hv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoNJyQ9i7p9EmUWA3T7gto6j9HpcpbaFgL9mxYK2vi0=;
        b=N2Lj/nh8QesV9EyDGwBRTOAXQSCYI1K6SpzHVVjzQVumHnUymh+472vOhUTpvQE6lB
         wtly+lhyiq5H9GpZIdHFNbQPxQwSTD9h6NpseKd5UTy3k9V4ykAVgfIx6h2qFoZ0XgYb
         xuYoTKLoGhYIHQ0btSzeV+TqlvHEBVZlrPZIFBWuwD7PoPl5YXcQk2ULu+MwCkX7k+Dc
         D0iNNdtwKI9WQ4CLsgX5+kSZJ5fsqbqWPDlbH4Z6su9xLcLCCtwnoR8MeyOSbmmR8d5w
         fCdM6C9iFn4Y/XwAzpekkpHSv35yUajtQF7YmSd/lzxQvDdSAKUSD3iOFOxWnrdRxTkI
         X23w==
X-Gm-Message-State: AOAM532byvllwg3vVWxebW/ZbQQHygMXRTQr/7tHNUAO2Dywbzxtq2+k
        r14qKzv3OdtsKq5eAufTy8XySMmli3+eEaKp
X-Google-Smtp-Source: ABdhPJzzS0lc63FgTUKSt/2ZASb12eQDkWyoVdMJsqKvtCIJHsNLKrKxpg8TERXrzzOC7j5iRBZ1bw==
X-Received: by 2002:a05:6870:6192:b0:e1:dcc4:e0e8 with SMTP id a18-20020a056870619200b000e1dcc4e0e8mr6298605oah.58.1649332589872;
        Thu, 07 Apr 2022 04:56:29 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:2e13:8e30:84f7:1597])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d4002000000b005e6b6ed9001sm151420ote.60.2022.04.07.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 04:56:29 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2] iio: ad7266: convert probe to full device-managed
Date:   Thu,  7 Apr 2022 08:56:21 -0300
Message-Id: <20220407115621.10781-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert probe functions to device-managed variants, with exception of
the regulator, which required a devm_add_action_or_reset() hook
registration.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/iio/adc/ad7266.c | 44 +++++++++++++---------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c17d9b5fbaf6..f20d39f0bc01 100644
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
@@ -433,7 +442,6 @@ static int ad7266_probe(struct spi_device *spi)
 		st->mode = AD7266_MODE_DIFF;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
@@ -459,35 +467,12 @@ static int ad7266_probe(struct spi_device *spi)
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
@@ -502,7 +487,6 @@ static struct spi_driver ad7266_driver = {
 		.name	= "ad7266",
 	},
 	.probe		= ad7266_probe,
-	.remove		= ad7266_remove,
 	.id_table	= ad7266_id,
 };
 module_spi_driver(ad7266_driver);
-- 
2.35.1

