Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9629565CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiGDRT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiGDRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B02F3A;
        Mon,  4 Jul 2022 10:19:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id i17so7012517ljj.12;
        Mon, 04 Jul 2022 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IMnOPFsjcxK/PLm5RmjMuxbEUfs1z1kxBu9661T4Q8=;
        b=agQrv+IFskuEeNO6CZahMRE8TjZedWOEN+E616LSBJkd9Ndgrx5W2Q6Q7LTcZ0bf2T
         GDntNiPMvG7HrRILqcb2VNF3gq0Nsb9IdbE+bCVZB/mAwnRAXmTZnWMnqzrajdOcZchj
         42a/wn+cenpTWVCHt+0tSMKqiHH8RhDuM1EOWFndJD65hSajF+exD074KoowPHvo0g18
         kbQYHLbzYsiaOMlu6FDYC5LHlzU/Ex59ThL7yQDxldndYYjTcl38fNFffWHRFL5aYhho
         SiCzV6QDcUdidjuJmQLUeXYKdB2iS2U3QejmhV8LlBlaR0U5e97dWxwXhz+jeAvI2Ou1
         qOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IMnOPFsjcxK/PLm5RmjMuxbEUfs1z1kxBu9661T4Q8=;
        b=aK9BDn4cDzlfxAHz2pRMJSP4O70uURvjdc6g+avq0PHQJ8OmkgiQPeU4hUHdjWF1jP
         KCkdFVHIvQOBS7CpYaG3KE5CXizKn/QUkwQeWcmMA1ikiN8kl2WOoTpgq5PWmlbZXjV7
         8zFb+7LXOY/0/yox94hOBt/YVF25n4E6hO8Vb06QkbA+JXdt+nLmqLMPz0tHd3zvqb7r
         JfdacsbwFVcUn0HTpBpFKbRmw7L0sAshf7ZOA4BkBQPChSITS33o45+7q1HUIcM2L6sP
         sfq00FX+ss4YuGUMCySluBYoePTohO8G18l/KJhexN1pyYkW+7QgNgD0nkaQNFULeR4V
         MQXQ==
X-Gm-Message-State: AJIora8w+e+7E4pWSkUT6vHAD4Jbv/Q2Vg6N3Yaz5qVKweVTexDWIddO
        /mW9335CANLT3O97p14y9MI/SB36lqE=
X-Google-Smtp-Source: AGRyM1sXf/svu0IaP74xq8Lk17RSxFDMlJad09RVQdWT5jEzJrs0U98VG6hhRgmz9ubcjazIyKHeTA==
X-Received: by 2002:a05:651c:211e:b0:25a:88ca:d766 with SMTP id a30-20020a05651c211e00b0025a88cad766mr18105554ljq.230.1656955153044;
        Mon, 04 Jul 2022 10:19:13 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:12 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] iio: adc: mcp3911: use resource-managed version of iio_device_register
Date:   Mon,  4 Jul 2022 19:21:11 +0200
Message-Id: <20220704172116.195841-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704172116.195841-1-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
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
 drivers/iio/adc/mcp3911.c | 43 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 890af7dca62d..f5fd9da6ab55 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -258,6 +258,16 @@ static int mcp3911_config(struct mcp3911 *adc)
 	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
 }
 
+static void mcp3911_cleanup(void *_adc)
+{
+	struct mcp3911 *adc = _adc;
+
+	if (adc->clki)
+		clk_disable_unprepare(adc->clki);
+	if (adc->vref)
+		regulator_disable(adc->vref);
+}
+
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -271,6 +281,10 @@ static int mcp3911_probe(struct spi_device *spi)
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
+	ret = devm_add_action_or_reset(&spi->dev, mcp3911_cleanup, adc);
+	if (ret)
+		return ret;
+
 	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
 	if (IS_ERR(adc->vref)) {
 		if (PTR_ERR(adc->vref) == -ENODEV) {
@@ -296,21 +310,20 @@ static int mcp3911_probe(struct spi_device *spi)
 			dev_err(&adc->spi->dev,
 				"failed to get adc clk (%ld)\n",
 				PTR_ERR(adc->clki));
-			ret = PTR_ERR(adc->clki);
-			goto reg_disable;
+			return PTR_ERR(adc->clki);
 		}
 	} else {
 		ret = clk_prepare_enable(adc->clki);
 		if (ret < 0) {
 			dev_err(&adc->spi->dev,
 				"Failed to enable clki: %d\n", ret);
-			goto reg_disable;
+			return ret;
 		}
 	}
 
 	ret = mcp3911_config(adc);
 	if (ret)
-		goto clk_disable;
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -322,31 +335,11 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto clk_disable;
-
-	return ret;
-
-clk_disable:
-	clk_disable_unprepare(adc->clki);
-reg_disable:
-	if (adc->vref)
-		regulator_disable(adc->vref);
-
-	return ret;
+	return devm_iio_device_register(&adc->spi->dev, indio_dev);
 }
 
 static void mcp3911_remove(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp3911 *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	clk_disable_unprepare(adc->clki);
-	if (adc->vref)
-		regulator_disable(adc->vref);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
-- 
2.36.1

