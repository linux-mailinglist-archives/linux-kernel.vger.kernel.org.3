Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977144F6370
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiDFP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiDFP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:29:15 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CF561230
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:29:09 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-df22f50e0cso2713193fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=f9uUO1j3Pv/5fo7aHMxUGqKZLMa4C4Cbm+pCSR0pZdg=;
        b=Jgn1UZ4t04iIJsvgNJOclG2gtp7Az/+qysNdFnh3eLRkCs+8SzZAHC/1WjOVLWQMh/
         PzmtRz7Wuv1otNj2iwwR/t8RxAWBwq/SL24Pq2pJJZUqURusxQwV1J3DCX5o9Cp0OY1e
         OjBqIMZ2PfAS2qXVbVSQbAj79dZrvfnx9WJujiLQ0uZP8KHzcs3siWWFRujYH+Cp3KHx
         9p4L3rozr4sl9jwpP0MLavEy3LFOc6pQnGLgNCVExt5n9kgB2YWZEzu/MCG88B0nlUYy
         PxxJbJ+hI15qzgqJ2shzKQ3An7yVR5UKdqr1VI72+5z2umJ7jpddHjn/7Nos+V6ZGxIM
         LGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=f9uUO1j3Pv/5fo7aHMxUGqKZLMa4C4Cbm+pCSR0pZdg=;
        b=bEdS9GVj7koJtuAtVWlaGXZdxK9IN/CRAwgdM+k7iiv1kJ5B8NduBLO3zsP9xvW3X0
         l2S9FUwC331tIS+n/j64xkzNblZSKRKXV30Tg39hrG6PCXlRpTBa9SRwQXITVcLxdlyw
         b0iKPRNLNHLZM+1+UyXXMFne02+0+NLjR0/j0LzOQjKkA8TAoo/RvmCrgLZylH/hHmIV
         XIK4rq5Tf5GaabsRb7/5x1aWtt/qIYeQjCBdBZtSJHopIBu5h836h5fZ+UtMXIY5XHH9
         +zz8/rIdBJNpw3s+Oy1bWgbbON+zhIZBNIp0DQtuN3NqfPLyC1fzsr1D9VN/ES3O07Ah
         kLHw==
X-Gm-Message-State: AOAM5312JlOKNfhUOwF7ZbtIJD7Tus7u+wg0RXRe8dnqzfKmz+j3+0wS
        r8oDQ2ebHxrO9aF4kJtVPQ+gVw==
X-Google-Smtp-Source: ABdhPJxQAh7U7BTJOVmhbyWXNLrCv5Youq0bLX6t3zA8GC5zw7+zx9Xbj6Cz7ncvfDCYrPI+MjDeag==
X-Received: by 2002:a05:6870:1cc:b0:e1:fabc:6e03 with SMTP id n12-20020a05687001cc00b000e1fabc6e03mr3753415oad.16.1649248148501;
        Wed, 06 Apr 2022 05:29:08 -0700 (PDT)
Received: from fedora ([2804:14d:8084:84c6:2e13:8e30:84f7:1597])
        by smtp.gmail.com with ESMTPSA id t4-20020a0568301e2400b005c9781086d9sm6575055otr.9.2022.04.06.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:29:08 -0700 (PDT)
Date:   Wed, 6 Apr 2022 09:29:04 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ad7266: convert probe to full device-managed
Message-ID: <Yk2HkOcjQhOo6y2X@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

