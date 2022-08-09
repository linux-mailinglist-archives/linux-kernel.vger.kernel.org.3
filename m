Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15058D4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiHIHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiHIHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F72201A8;
        Tue,  9 Aug 2022 00:32:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx38so12116782ljb.10;
        Tue, 09 Aug 2022 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+SAkjMA9USkunV6u8e85+vmzHskDjPwmtcGKKR/aSo=;
        b=mmHxuYFsb+En24QdjK9F2J9TD1SkCS6Gz9hjqVGIumoGsrFhrdC5HvQJYk9KqMgnq3
         YK4H0Tj3fZusyL9Sn8ZCWqU+1P/Be3gGNe/wtFTEbJFxetoAUxtsU26lftmTKZ5u6+bS
         Jxhg3MtQTVkqSdcl6sV0sWYE1Z6Vd9rnbeYTdRyyuvxQhps9Us/WQgVUxEObuUnDwXsR
         uVwR+M2+kDArqYEa4hioOpP+EkWzgbOtoP7xBWK5+xqlbtAXLj9RJdpvRrIzBeRmTWVI
         hwxQJUlzQsLRgPNrd3LQPqpiH4E3LllL8YPXHqMsZmFPAA6l2Vh6XvaPOEz8qowDFy4z
         R0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+SAkjMA9USkunV6u8e85+vmzHskDjPwmtcGKKR/aSo=;
        b=tNDQ9nJxsX29qUNea5GT40IA9LzqXddiwk7vbNnJ5pPdZtR9Tt76Fs+KBSzaW3ddFN
         t+VjJbG6/FMa/5u9c/AXysuSRhEdFvTs5x884VsdA4OrNmNX3XF5fwkAdRvPB0jVS6po
         a9992q8Mye95sc0duubGUs2lGTgurn8VgFAs8Dx5ctuaP+hRkniysV1g3UDPOIFaZhb0
         KU9DIk9JXOSTxgzcJytMaXS1FF9F+s+oq9cudzrsMZNl5wn/N8x8nv+F2G6uX6qHUCbZ
         LcUnfjsdyuSJMycy51u3J4Zrw+wtsL/rkvxgvQRdiZ9GTwL4nuVgoW6xVzA07qyj4VNz
         aE3A==
X-Gm-Message-State: ACgBeo1bf2eggz8dAKwcrzvjPVLV5py6YDtjVkcZLOpajl7I7fKXrbzX
        59/z+aDmPoX7io5+d1d7z/A=
X-Google-Smtp-Source: AA6agR4pFmAGiKXTOeaKFuDcGc9ML9KnnfLVnJWTM87Msbs4Sfz7Oku96RJ7ODDpJDCpN5zI8KBxBg==
X-Received: by 2002:a2e:a814:0:b0:25d:915d:35be with SMTP id l20-20020a2ea814000000b0025d915d35bemr6906832ljq.256.1660030353109;
        Tue, 09 Aug 2022 00:32:33 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:32 -0700 (PDT)
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
Subject: [PATCH v5 6/9] iio: adc: mcp3911: add support for interrupts
Date:   Tue,  9 Aug 2022 09:36:45 +0200
Message-Id: <20220809073648.167821-7-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809073648.167821-1-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 87ab7e24ab08..ac614030e400 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -30,6 +30,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
 #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
@@ -63,6 +64,7 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct iio_trigger *trig;
 	struct {
 		u32 channels[MCP3911_NUM_CHANNELS];
 		s64 ts __aligned(8);
@@ -352,6 +354,23 @@ static void mcp3911_cleanup_regulator(void *_adc)
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
@@ -415,6 +434,15 @@ static int mcp3911_probe(struct spi_device *spi)
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
@@ -425,6 +453,31 @@ static int mcp3911_probe(struct spi_device *spi)
 
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
2.37.1

