Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC655A8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiFYKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiFYKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4C2A255;
        Sat, 25 Jun 2022 03:37:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b7so5502910ljr.6;
        Sat, 25 Jun 2022 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAG25Y0XDP+Vyl6v8IvvJ8qg+yJ22TMKtj4bJENIGag=;
        b=qyyd1hNVs9W6aOFx1mXF6ugcyEG5nGiKV2mRDOcgdantgIipD4tT0inbu5TU4lg3ga
         dLRkQVjcDHVMzDhLDqr3wnf0C9TP6swb8tfyXBthJ+wqb57pUbb5qB8kiB8lfdBJAtVi
         KZXFsgrT0bLFsbGyCn0C1ZQPr4CiaAZqnVuyLzMEbb9eQ/Efn/3a353wEHcd+0ptTmjC
         KCqAxXJSzSm5sWW8v0tSuT59JcHwaB+wSBNSXUXvndmuSYjAfdol5d0onqn38AKLPzne
         CqtnkOY8rDzgU5xhepo8XLaGhbqgKP7yViPWpGvnWuLn8+z3mHkb2RSVcXIdVy+mtsRc
         WYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAG25Y0XDP+Vyl6v8IvvJ8qg+yJ22TMKtj4bJENIGag=;
        b=YlId+eyteZRIknu6/pxa8htuxxjNQ2BebwEpJHSOg6Q6tBhqb8GA+J76UMGWXEiDsV
         3A0r1zq3ZZdjvZfGH8fcIcc2e13xIgRfxKiGAcnotel9yz80N6tNgCoIjSchxZmycXHI
         JctqpUTUmJb1qnjYpr+mF29Rj1t3TFpUZatFVal7QW4zs4eYPIhztXfZ1SUH18/1880k
         914R8yVz70JWqWQo9olojpQz7zXt54XrxHZ9L1K+XTBnHwWNmfMSR2ecMrft2kGG6vRf
         13XhfETU/poNr9h4nSojHjvgoClaXUKbKOGIfQLBsa+dWrZZMdftwaHIYra2JSIPTK/n
         aJZQ==
X-Gm-Message-State: AJIora9cCVcqOOEVJqryUQ80XqCdaIigLgKoIWYpZvxUiMO7Mc5ZOlr4
        MXAOqB5hSh/+wu+YADDZZ/0=
X-Google-Smtp-Source: AGRyM1uSv2ouCH1ZnIH4pAJZVYt/5kxrZQTwJzqiXE/kpWP7FATFYQIi3QsAfAt558H/pMn/PuiVrw==
X-Received: by 2002:a05:651c:1695:b0:25a:6e09:cf37 with SMTP id bd21-20020a05651c169500b0025a6e09cf37mr1614809ljb.19.1656153442886;
        Sat, 25 Jun 2022 03:37:22 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:21 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] iio: adc: mcp3911: add support for interrupts
Date:   Sat, 25 Jun 2022 12:38:47 +0200
Message-Id: <20220625103853.2470346-4-marcus.folkesson@gmail.com>
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

Make it possible to read values upon interrupts.
Configure Data Ready Signal Output Pin to either HiZ or push-pull and
use it as interrupt source.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - Removed blank lines (Andy Shevchenko)
        - Removed dr_hiz variable (Andy Shevchenko)

 drivers/iio/adc/mcp3911.c | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 2a4bf374f140..f4ee0c27c2ab 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -26,6 +26,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
 #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
@@ -58,6 +59,7 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct iio_trigger *trig;
 	struct {
 		u32 channels[2];
 		s64 ts __aligned(8);
@@ -252,6 +254,17 @@ static const struct iio_info mcp3911_info = {
 	.write_raw = mcp3911_write_raw,
 };
 
+static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct mcp3911 *adc = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(adc->trig);
+
+	return IRQ_HANDLED;
+};
+
 static int mcp3911_config(struct mcp3911 *adc)
 {
 	struct device *dev = &adc->spi->dev;
@@ -298,6 +311,23 @@ static int mcp3911_config(struct mcp3911 *adc)
 	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
 }
 
+static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	struct mcp3911 *adc = iio_trigger_get_drvdata(trig);
+
+	if (enable)
+		enable_irq(adc->spi->irq);
+	else
+		disable_irq(adc->spi->irq);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops mcp3911_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+	.set_trigger_state = mcp3911_set_trigger_state,
+};
+
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -352,6 +382,15 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		goto clk_disable;
 
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				0, 2);
+	else
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				MCP3911_STATUSCOM_DRHIZ, 2);
+	if (ret < 0)
+		goto clk_disable;
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
 	indio_dev->info = &mcp3911_info;
@@ -362,6 +401,32 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	if (spi->irq > 0) {
+		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+				indio_dev->name,
+				iio_device_id(indio_dev));
+		if (!adc->trig)
+			goto clk_disable;
+
+		adc->trig->ops = &mcp3911_trigger_ops;
+		iio_trigger_set_drvdata(adc->trig, adc);
+		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
+		if (ret)
+			goto clk_disable;
+
+		/*
+		 * The device generates interrupts as long as it is powered up.
+		 * Some platforms might not allow the option to power it down so
+		 * don't enable the interrupt to avoid extra load on the system
+		 */
+		ret = devm_request_irq(&spi->dev, spi->irq,
+				&mcp3911_interrupt,
+				IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				indio_dev->name, indio_dev);
+		if (ret)
+			goto clk_disable;
+	}
+
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 			NULL,
 			mcp3911_trigger_handler, NULL);
-- 
2.36.1

