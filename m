Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2198055A8F4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiFYKh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiFYKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED812A266;
        Sat, 25 Jun 2022 03:37:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so8523900lfa.11;
        Sat, 25 Jun 2022 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhFEJJvWGyZnS2sVrWZb7NGdcDQyK2DU7A6T6gb2WJA=;
        b=RzwHycqWheYC+noCEWZ3pWrvopMwyQEoy5HU95C3GvBesC2Yw8xgEz/2D5REAw/Mxl
         XHwCZXJwQ8qrtgs11qKmIquWIlRzd4JYXRkNveyBXK7ecGjvtnzPsKg2QTQHJCd7UaRW
         7DQFN80XFv17tmYLYVnE+DXR4wOjY2mAgEDoGei3w8ipXMTPFaQccWPYVK/d0pGUh3wV
         DcbVy8zdU6HgXiCUMGRm/9tcIwgZR8FlwvZr1dWg0p/YWDrHNn+k6XgXaatqJpoE4A7k
         3nrd0ws5gfU41oTToUvROlrqWMkhR83dAbIImO2NdshEWtKUB8aWbhku+kT1z1ul1/4G
         e26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhFEJJvWGyZnS2sVrWZb7NGdcDQyK2DU7A6T6gb2WJA=;
        b=SMkEMtOQmgTg32kctfi8qwjivyvwA1Cu109+fKBik1HqY8UXJwv2OIMdzXOmR8l1VC
         bPH98e18tGmOQu9QrFx3HLP9nm6yVBStUwOuEtLuSp0Gy6D3T39k5+EQZdU0te05EqKz
         3mgF1uWPNP3MD+zVVanjDicVHz2pNNqSg/sLiMdMzNHJASbcOQ3cSs7TJ4utJ7i3w1uy
         29Hm7sPNb9iFvAMUlxpWh5teUwvSOs7cwFBQMyS3sZtaFgIWG3GEFLv4pSfj194qWKhQ
         GI0ulhqHD5TM45i/ctaok7o/GTLB2tkvShZdub1GBe6989SanZ8yWHBcGOH/Qys2cEvO
         KNhg==
X-Gm-Message-State: AJIora/FC4YQfuNwe28ww1+QKfKeyBRmyucKSDQShCmmlczX5OSSpKGn
        PJ7reASm5qD91vqkUC+Ptl4=
X-Google-Smtp-Source: AGRyM1skwcUgga5EQlzbu4D1tihnETa2VYbRZh4HYXXTOIZ23nt4jdOxqkv3egu2H1ieohMK7dY4WQ==
X-Received: by 2002:a05:6512:4c3:b0:47f:6f6e:a7e7 with SMTP id w3-20020a05651204c300b0047f6f6ea7e7mr2209711lfq.674.1656153438771;
        Sat, 25 Jun 2022 03:37:18 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:18 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] iio: adc: mcp3911: use resource-managed version of iio_device_register
Date:   Sat, 25 Jun 2022 12:38:45 +0200
Message-Id: <20220625103853.2470346-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
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

Notes:
    v2:
        - No changes

 drivers/iio/adc/mcp3911.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index c5a0f19d7834..25a235cce56c 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -312,7 +312,7 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&adc->spi->dev, indio_dev);
 	if (ret)
 		goto clk_disable;
 
@@ -332,8 +332,6 @@ static void mcp3911_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct mcp3911 *adc = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	clk_disable_unprepare(adc->clki);
 	if (adc->vref)
 		regulator_disable(adc->vref);
-- 
2.36.1

