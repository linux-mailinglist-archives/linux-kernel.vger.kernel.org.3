Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF99560B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiF2UgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF2UgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:36:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC930F5D;
        Wed, 29 Jun 2022 13:36:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y16so6203499lfb.9;
        Wed, 29 Jun 2022 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cum4ZLY4F3hU5Y/mRP9v9xDUy4JzQcKCwxlvWrxymB0=;
        b=WuyY7qW+HCSSzFSLtc4rFTG0WS48oHYVAOg/q4AUqASeq8+5XgZdnsDWmIn78ccwCk
         d3o6Hb3AT6NclfBzcpV4eY+OWNR7z1Xy5ArMQI72dgTHZthr3NkhBGcNI1GxcS2CKhHw
         B1GbFyUhawrrOIn3D+SgXYjc4nxXrm0ZEQa4Q4Qq3F5lGIyBbW/mOys6jNphE0C6YYBE
         Voh2O/aPF1dmj4Ll6YWkPcJKRnr7nzzjcyzTFmvlstGNMDO+cpZ/06ghFugOnhV18yoV
         Rr+8tWOXZWQa1+GOvj2TsIzP6LSUW0bA7s9p88gic3baUCpXQ4ww4IZZFhrSRLO8/D9m
         05Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cum4ZLY4F3hU5Y/mRP9v9xDUy4JzQcKCwxlvWrxymB0=;
        b=2ouXX1iBCQlZHFY6Ly0EyDrAa9N20328IewQL8pxBC+4ipV3uKFQQcjIag1N+oQ4UN
         Bpgyt450MouU0JjK+50HbxSZaH7ouAD8U9HzNWLSMUmVo+Yjb/vnzI/RhRR5fsvZcXya
         EL/AOVtouMrUhlHlBUgzQNTZBpJsHYIxtFWqZB7UmSdKZqFN/vNtjKe3Tkh/pjvq8Y7B
         bd3swoGQjO0DBC03II8y7eu89Q/fIBLa5AGg23Wr1xuDOFtWQ67NRku6KlNxxi9Qknmi
         fhasfZYu0CW+7xwMJTrVrXOgrm32/tNXgsfG4grEHIA4T/EAm5d/DOBMgVZ9dG1RvmA1
         wv3A==
X-Gm-Message-State: AJIora9+PPHWIag0l8e2w+svVcGjs3qrf2M3rQesfDh2l2o/JlTQAQcz
        6i1TWXSFLtwFKnbN2tv7EQS03tGfottc5w==
X-Google-Smtp-Source: AGRyM1sjHdMc8r4kOAVvDSXun0/3hIPR8IttNr7lI5/QmNY+yF5MpxDORulTNwDHzBmTuJcWcQR9wA==
X-Received: by 2002:a05:6512:402:b0:481:a86:5721 with SMTP id u2-20020a056512040200b004810a865721mr3227708lfk.525.1656534960424;
        Wed, 29 Jun 2022 13:36:00 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f5c4-74736162.cust.telenor.se. [46.194.245.196])
        by smtp.gmail.com with ESMTPSA id p12-20020ac24ecc000000b0047f59336d6asm2738057lfr.179.2022.06.29.13.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:35:59 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: adc: ad778-1: do not explicity set INDIO_BUFFER_TRIGGERED mode
Date:   Wed, 29 Jun 2022 22:38:47 +0200
Message-Id: <20220629203847.4801-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The core sets INDIO_BUFFER_TRIGGERED as part of
devm_iio_triggered_buffer_setup().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index aa42ba759fa1..f5e5df105e67 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -620,7 +620,7 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad7768_info;
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7768_setup(st);
 	if (ret < 0) {
-- 
2.36.1

