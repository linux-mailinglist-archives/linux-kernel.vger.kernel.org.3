Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53414F6692
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiDFRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiDFRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:17:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0A3E8E5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:12:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b188so2655859oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=/g2L7JPkn6C2YVAVneUn/BxXp+WB2voVVlguKc7I6O0=;
        b=wIaF4g8LyYmBT9nsKoniqqKHWdF58uE5m/r+9mtuPaoSBd19GD5qQF769nGSf6kh8W
         z0J0RCiNkT3+aQCih3lMC1NI0MO/yhoHFOd/6Zuw7hVoHJr0gXtMSzU+VOawJBZEWXFN
         2qGVNthNXv0G7n9kZ7/iT/QWUO+/ZxeyCP277uri/ri+H6kZW3UfpyKByMrY7EU+Qja+
         RtPuPTjSCkxrjhea7YWBOiopTCNqZfcN7d6nhZp1mueGrl2NQBndzvEY7ZUUC6A3UQyj
         txWOl2yqHBYa/mCGVRuykWHvduf4BX9ZmabkmSZ6oC7A3iIUMt9DR5FHiI1veRJQ1yRK
         r0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=/g2L7JPkn6C2YVAVneUn/BxXp+WB2voVVlguKc7I6O0=;
        b=eaFiiiWy2/v5T7zooeQfw3qapAfKdrgSHjn/SnaoAOAg7PzXUKCYRvWVCRv2+FqPdz
         a24LXrkX0PjNB2eQb1g83xbAkO4yKHEsFfekGsdfluefqG/R5LTL5Pfh8pm/RgTTOigS
         wg7RYU66xuII9FNo43JB+emtConEoclZVgvGZ0zHT0A6ZseYTmYdfV5a1Z/6Aiofj4QO
         QTdX7kZpI1x9yOhwYXTyrVR/mnfBDnRqRegWevH+ez8xU9ukfZfFOvpvXkt4zPVAIiBu
         Jk8s1mRK9CAqRt4WDEMuKZMhRl42y1yDWm8aWel+rBBLRg4XxqVHW60e+XXoGVbnuQha
         Jx7Q==
X-Gm-Message-State: AOAM531HjF9jGGPNTgAaVhT0ClaPseXsoqF5D6Ti2WOaJC1OC7V/wCxe
        6pKlzisgowsw9n3yNXsyu5ViUg==
X-Google-Smtp-Source: ABdhPJynqBbOyknd/9G7kXviNn+mXel7sWBGugvOU+3Pr7MhUbgE9Y7MIi+E3+Z0kAGPR4Em5aH1lg==
X-Received: by 2002:a05:6808:1294:b0:2f7:5e83:f0f with SMTP id a20-20020a056808129400b002f75e830f0fmr3912451oiw.77.1649257961263;
        Wed, 06 Apr 2022 08:12:41 -0700 (PDT)
Received: from fedora ([2804:14d:8084:84c6:2e13:8e30:84f7:1597])
        by smtp.gmail.com with ESMTPSA id k124-20020aca3d82000000b002ef4c5bb9dbsm6462397oia.0.2022.04.06.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:12:40 -0700 (PDT)
Date:   Wed, 6 Apr 2022 12:12:36 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     michael.hennerich@analog.com, lars@metafoo.de, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ad7266: convert probe to full device-managed
Message-ID: <Yk2t5D2x2+YorkTd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
I apologize if you received this email more than once. For some reason, the
patch is not showing up on the linux-iio mailing list. I believe that the
problem was that Michael's Hennerich email on the MAINTAINERS list was
Michael.Hennerich@analog.com instead of michael.hennerich@analog.com. Anyway,
I am truly sorry with you received this email more than once.
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

