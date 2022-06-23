Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED51558447
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiFWRkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiFWRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B791892172;
        Thu, 23 Jun 2022 10:07:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z13so3958104lfj.13;
        Thu, 23 Jun 2022 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjncueEDEOXI1ZZ67zcML01m1fkxgPmoKbICq2roG2s=;
        b=Nbfpp64GCIC3Ssb2kIy30hSg2CvRnj7k5371N7oDJcy9yRrzXfWPlihKCsqH7PcIE5
         V/ELtiN4T5onBwd8yDHruPhe3sX3Eq4thg1QJPmXD/i0/2y72IabKcnZGQQkg7uwNEdW
         3xHKi9EFhWI7Pxs/aCSKK6I5xH3hLbiyIO7Jx9p+B2hVPglBA389cXxNok+pouJXyMff
         exqPyt/wkdciq0nqxpAVakavthyUR1FqPoZ6I352Jxlg2nhFIom+fz0/xOFU6ALT5Fn2
         yjzTqT9kipZ49qQLAl4obHCmZlBjTkjiy9ULvFgOK2m0pujrSo9vG8Sq7IDu7jRbKWSc
         /chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjncueEDEOXI1ZZ67zcML01m1fkxgPmoKbICq2roG2s=;
        b=d3ZrhNcmIDjfBj5qmAWOYgZ00uxZHY1sk81SeoAJHYUicMZxnhLTaANBaBJf77D8d/
         FEi8g2DTPgsxbUA3ypDjXNDhZMNFfQC04UX75Yx7bWj9qaXc+9+09xrefjyFrGJmln7+
         jej2HfPVE9Pd5/IFCXZkLTP+JZCGL7LPwjQdPKgDh8UtwNTWKtq11aqWhouS2qsGxfHW
         QfPhLyMyQtpMqtjoXdNbTonOtERyLBszvWZBS+j27moTqgS/hplFiDPWuissNLtd49w6
         B8dALZL1FAEVSaXMoLAb7aMDnO/jxRH9vBcvzACVh/X5CigBUEXwttf8yMHi7UTXpiFt
         OYMA==
X-Gm-Message-State: AJIora9J2k2TJ5SXXwlHe7s3kORJnsjBa7XC9PLebNYUnEfvuw8ch9YR
        8smQOLOsXU2YI0tehqygZ68=
X-Google-Smtp-Source: AGRyM1uz5elafW+BeYQYajDTPcNuwwsjDMnR5Qto7IrVP4vWW/8kdHK+rUwI23w6aY4oIrYIGwWBNg==
X-Received: by 2002:a05:6512:31d5:b0:47f:718a:3459 with SMTP id j21-20020a05651231d500b0047f718a3459mr6103570lfe.480.1656004028467;
        Thu, 23 Jun 2022 10:07:08 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:07 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] iio: adc: mcp3911: add support for interrupts
Date:   Thu, 23 Jun 2022 19:08:38 +0200
Message-Id: <20220623170844.2189814-4-marcus.folkesson@gmail.com>
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

Make it possible to read values upon interrupts.
Configure Data Ready Signal Output Pin to either HiZ or push-pull and
use it as interrupt source.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 768cb0203f52..e761feed5303 100644
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
@@ -292,11 +305,30 @@ static int mcp3911_config(struct mcp3911 *adc)
 	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
 }
 
+
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
 	struct mcp3911 *adc;
 	int ret;
+	bool dr_hiz;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
@@ -346,6 +378,17 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		goto clk_disable;
 
+	dr_hiz = device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz");
+	if (dr_hiz)
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				0, 2);
+	else
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				MCP3911_STATUSCOM_DRHIZ, 2);
+
+	if (ret < 0)
+		goto clk_disable;
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
 	indio_dev->info = &mcp3911_info;
@@ -356,6 +399,32 @@ static int mcp3911_probe(struct spi_device *spi)
 
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

