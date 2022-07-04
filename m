Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDD565CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiGDRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiGDRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165285F4E;
        Mon,  4 Jul 2022 10:19:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so11849801ljr.0;
        Mon, 04 Jul 2022 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGaeZMwPFEZ/IA3EvMTSeCiC4FG4w1jQa0acswAkwmE=;
        b=ZwKDawghrksnfeMhJaebVAg7GK9lGYBL/Y02gDNIHl6Ts3AXrNB9qZK7knPbUQ6Kd6
         SvAKSP3vzKZD87UFmJURJ/MzRn4gEuYJaiAYKguZXwKuEclaeSnUuqJ+47rmZ+8ZEF9q
         T+IsctVRzQS57zhBL31+4vjoGpge+D4rdyCzFatJlKLXjz8usn7JELeZ6TM/ROHn2smK
         anv2vlTytIMYpFbrzPZTqiITg+24X24t/79urHqo5LSRUquOj8rUCiaQlQfyfD3hOXRQ
         mITi3jTZadiz4xYYYLQ3KTqTftKx1pavB308XmSJLR5wwg8JwldVaAbCx2dIq9riAzmi
         4nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGaeZMwPFEZ/IA3EvMTSeCiC4FG4w1jQa0acswAkwmE=;
        b=npskJwbq79WVATHdRFcO5xFuJkOSL8Df1MWraZxpp+xkU8FzjmhUgo+cw+7d1/3+u7
         kClWyi+YzD1uhWCRvh10C9Af1Un2EhBFAErkFo7ysp+dAq7LRFfbb33QRn3nNpLqXmGj
         /2Z6bzP97OBOAIdL6RchWDF4F47osLhMEcdgLwmGAf4zxy6F3BsWFGZN54zMat65EaKa
         fROmcOBDCm2+ZAuGJ6gJtfV0KWzxi/51auQbNRKq1T8gtgWF1RpHAqbPpG9xuUNSMHa+
         G1LXjBCuxSy+A7qznH/Ud1j16EcIR8hWD0YgjaEPMcKo60t795O4pNlpvOl3+zwJMtn5
         5wMQ==
X-Gm-Message-State: AJIora8Bz0ZZyGnGs5YwkfjRiyZY5j0LRsfmPMqlW/ETqtn4gLakkQO+
        lNoyxDSnPzZD918/ySOBvkg=
X-Google-Smtp-Source: AGRyM1tA2Fc5VoSjZLRdAqFLHt2TJixeZOb+1OQjjPrrcsLX2gEJv4DCVAaIbfq6SJmFGwcUKEppKg==
X-Received: by 2002:a2e:9004:0:b0:25a:7c03:eb73 with SMTP id h4-20020a2e9004000000b0025a7c03eb73mr16960444ljg.470.1656955155394;
        Mon, 04 Jul 2022 10:19:15 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:14 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] iio: adc: mcp3911: add support for interrupts
Date:   Mon,  4 Jul 2022 19:21:13 +0200
Message-Id: <20220704172116.195841-7-marcus.folkesson@gmail.com>
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

Make it possible to read values upon interrupts.
Configure Data Ready Signal Output Pin to either HiZ or push-pull and
use it as interrupt source.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index cf4dacc7de06..9c6f456bdbdf 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -28,6 +28,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
 #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
@@ -61,6 +62,7 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct iio_trigger *trig;
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -346,6 +348,23 @@ static void mcp3911_cleanup(void *_adc)
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
@@ -403,6 +422,14 @@ static int mcp3911_probe(struct spi_device *spi)
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
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -414,6 +441,31 @@ static int mcp3911_probe(struct spi_device *spi)
 
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
+		 * don't enable the interrupt to avoid extra load on the system
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

