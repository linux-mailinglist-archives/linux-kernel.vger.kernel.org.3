Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046C555842D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiFWRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiFWRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8492151;
        Thu, 23 Jun 2022 10:07:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o23so16929561ljg.13;
        Thu, 23 Jun 2022 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGSdRSXlkf0EIyduZq/whIQ2rDkrEQQxbaXXIkw+vOc=;
        b=ZFHGjYUJvqZZhg78fpoliU7qdjoto7KiFJyYriKWwGL0L/3RDJ0Sw/wu0prrvThurs
         CfMrLatOrnBaIH445OM2GhWnP1bL4MelDWESLWvDdoAeybUiu7l9QkxT5uKQGnR6phJO
         1ULSiORHbAjQapGBYmBTipq16k1Nn6T9pBqgdWk8CJCUuUDeoOZrRlafyCZzANaqZGPX
         E6zOtPIJa71dIQPeOPAB2MyP1/fHYwP0H8PaK0XLO9Ol79cx4qnKD5FZjerp3QHIG7XP
         9IQNl+GkyCPSHO4wIB3gTRJLN/xbTMJrVdGsrJZ4t7aPuAqE/Ozy0N2TeEPPB27EbPN2
         Z4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGSdRSXlkf0EIyduZq/whIQ2rDkrEQQxbaXXIkw+vOc=;
        b=7rS7A4RFfHwN+0v0GwD+zJRCnOXqpSszrRbK2Ea1pclgkfowEvbIsUr1BSW8l/v6aN
         ij9ziGGKYyhxuwbu/b6r/3/kRfeT9KnFL2f+qKsLJZa6fDd1hIJoha9YfkVQNEXfSvTs
         i7SXsxTrPiJeyyLXbG13uP6yrBljdkV1SUMjg4UidxPlLYgt2HiCLZW6/qDd1WaZ7gb0
         l2/3G69dtNm79m6iBSsx6tNx1tgmo9If5Y8FdvglnA6PszjQVhMXU1nYE/gmIGPY4F9x
         2hbf6v9xI+26bqrhKcGRMgL/o6hRCNgVszPFK112ewkGwgvdOCwLpplx575XSRMdr/qa
         /D4w==
X-Gm-Message-State: AJIora8bfRIVOj7ibqEqkPY9jaDOy9lZf6UlmnzKsW9BPVY2mqmpJU3k
        xFiK0xyNhGIAAmtAA5IjDR0=
X-Google-Smtp-Source: AGRyM1vT6R/FeopIjUsc0j4VCnlgppCQy/5MJHK1pAwuLfvpE7UwIUaowXDXmGf8cnNZG+EHMTF3kA==
X-Received: by 2002:a05:651c:233:b0:255:58b9:1f53 with SMTP id z19-20020a05651c023300b0025558b91f53mr5230297ljn.143.1656004025373;
        Thu, 23 Jun 2022 10:07:05 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:04 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] iio: adc: mcp3911: use resource-managed version of iio_device_register
Date:   Thu, 23 Jun 2022 19:08:36 +0200
Message-Id: <20220623170844.2189814-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep using managed resources as much as possible.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 4338552cd0ca..3d9e8ed10874 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -306,7 +306,7 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&adc->spi->dev, indio_dev);
 	if (ret)
 		goto clk_disable;
 
@@ -326,8 +326,6 @@ static void mcp3911_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct mcp3911 *adc = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	clk_disable_unprepare(adc->clki);
 	if (adc->vref)
 		regulator_disable(adc->vref);
-- 
2.36.1

