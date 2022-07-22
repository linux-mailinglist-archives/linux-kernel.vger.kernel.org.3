Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD957E1F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiGVNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiGVNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4CAF970;
        Fri, 22 Jul 2022 06:04:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o7so7552776lfq.9;
        Fri, 22 Jul 2022 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP/jBdxtlvbqvrCkJL3Z7fkeonR4hZLm7YdyaYMKfFs=;
        b=Qs9scKC2u5aLHQ9jg8i68FaDiKjVOEhPY4+aOzyx/Retd7GfkjEE1AZ14c+1Pao0n7
         HyfYSpFS9TW7y1RY759Mvu/6jU9u5iwW3roYIt/C/5ucPX9Txnxfk6zVjuf/uizs5DBu
         sHA+5uujRRecAqqPiccsbQpg0GcfG2GP15JEJIJxXOvnj+ikE+hKfDKvxYrzodLOTtUS
         mbiLtzGwEnmS5ocuDDZ+zMXevrTCe36+giQQenWbcCPTfba+/SN736iwTWlgzkgFjmXB
         m2LcVaU92AjAICcQ0DJCgSQfJZHOx1gr2aR5GiKmbyDSd9k59rz/ce0QjNfEaiEOX3d3
         ZgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP/jBdxtlvbqvrCkJL3Z7fkeonR4hZLm7YdyaYMKfFs=;
        b=S2FYC/5yxLWqBoCU88YdOCPcBX7saA/3lxbbsDjcoh+eV2nhUOM9pnRdaD9U5K4F3V
         ZJgU+amMB7gZsWYy22qjoTYI8RefjFV/EY+waBziBlz1x9wFHgJwSY3jUWw3nggyDvqw
         e0qJwHQw/zS5MjoDOVYqmYeBgGE18GuHD7XnHR1mShiso2xaZzXxpEkv6IaID2HzdCEz
         geBBHUAPC6qey5D70Z17zD8QYZTQHJ8tMs29lafiqE2Vgwgdc0rgJfqxCudSBtBJ32l5
         vV1hGb3YhXsGWJlps6nIOjgjHiheKiP6L3oz/cY5G0HLRLY5Fp7PEMIEugdN5zqRapdC
         Hz0Q==
X-Gm-Message-State: AJIora+q1hdblpdcNnoD0a8Vog9bYTa92ezAjPaqDdOqhRsArzA3NEgY
        9i5OXTFE5ZgyMeI4TBn8+yo=
X-Google-Smtp-Source: AGRyM1vEc8KNR3meV8qcOJz4YyltHvZlYFpJ/VKAVw1o6/x3ODjm67DX0h9yYu13xw0KVtwWWFUXFQ==
X-Received: by 2002:a05:6512:114d:b0:48a:783c:c13f with SMTP id m13-20020a056512114d00b0048a783cc13fmr179833lfg.355.1658495048832;
        Fri, 22 Jul 2022 06:04:08 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:08 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] iio: adc: mcp3911: add support for interrupts
Date:   Fri, 22 Jul 2022 15:07:23 +0200
Message-Id: <20220722130726.7627-7-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to read values upon interrupts.
Configure Data Ready Signal Output Pin to either HiZ or push-pull and
use it as interrupt source.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 96c0a2a50c7c..7db2c75da4ac 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -29,6 +29,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
 #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
@@ -62,6 +63,7 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct iio_trigger *trig;
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -346,6 +348,23 @@ static void mcp3911_cleanup_regulator(void *_adc)
 	regulator_disable(adc->vref);
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
@@ -409,6 +428,15 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				0, 2);
+	else
+		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
+				MCP3911_STATUSCOM_DRHIZ, 2);
+	if (ret)
+		return ret;
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3911_info;
@@ -419,6 +447,31 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	if (spi->irq > 0) {
+		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+				indio_dev->name,
+				iio_device_id(indio_dev));
+		if (!adc->trig)
+			return PTR_ERR(adc->trig);
+
+		adc->trig->ops = &mcp3911_trigger_ops;
+		iio_trigger_set_drvdata(adc->trig, adc);
+		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
+		if (ret)
+			return ret;
+
+		/*
+		 * The device generates interrupts as long as it is powered up.
+		 * Some platforms might not allow the option to power it down so
+		 * don't enable the interrupt to avoid extra load on the system.
+		 */
+		ret = devm_request_irq(&spi->dev, spi->irq,
+				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				indio_dev->name, adc->trig);
+		if (ret)
+			return ret;
+	}
+
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 			NULL,
 			mcp3911_trigger_handler, NULL);
-- 
2.36.1

