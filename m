Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0C558433
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiFWRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiFWRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C292161;
        Thu, 23 Jun 2022 10:07:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a2so56351lfg.5;
        Thu, 23 Jun 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQHq1R8+z5ISpQ71LBkGKEl1o+IhCGseMKIHQK9OFR4=;
        b=EI9rk/s6el+woaWK1fR4rjizrETaD7hvCzSsV6Hecp7G9Bmav3LwvqrFA8KKgFs4t+
         nhqYiwIQ5iAN6MWCnR3mrxqxOSz/ekgoETCj5rv9+8TJRD+jeeq/1yloNSW/8kPCuQwS
         umm2cdav02G4E1/nW0AcYN22Uogk4PqfzsCbCQ2SemOl6nuW4Lu+NY82EEtWTJ7cs6U9
         PQKmMvb9eZD5O1jW6p/htkrO+XIaiDpYB9q+3/3rOboIqH9rr/uE5nqU4OSdRMjxwHpz
         g3pBdab/UsbOPEtb1SVn+maV5cq8D+72rFs4WhTCW5Xb0wFtD/RYL0QUCiFI/00sPerl
         FuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQHq1R8+z5ISpQ71LBkGKEl1o+IhCGseMKIHQK9OFR4=;
        b=stC7BQAEl/EUhzgTKjywBDd8p23PqAlBvl5Iy5aJvmuCIbUkUYdeWZSfa5yo1hV3Rt
         islobTw3itTh4HIJA9RXhf8RYgV96eIa0H2cOO6+IR0aUiStrZ3xVFL5RPG2NGkRxr2A
         EMuvPL4WKExE3nwAyxW7WrxVejLUcc0NCcaz4eVKq/ju04/Xy0oCsexACVLAcq07ITrz
         P+ZZB3PhX+6Ym1SWA4J3i8nSGDcmrt5mWKarKDOUto85XxXNNNBTtjfQj5kaOlb4Y2N9
         GL5gHO07pnhWctUkjdksw8ejpyNW+bAJDu/0ry5OyBoXO6zWMJaF346IE5rBz6xuui6M
         Gu5g==
X-Gm-Message-State: AJIora8AxYBCdZ3fg8tzj0+oaxD3vW85ElRDqa9amPUWZKS4tgNiC1t7
        Hl4bqjmEvF+Nx0UASzrD/5GbAovCyAvcZw==
X-Google-Smtp-Source: AGRyM1txW/yYaILtToFPJXqzZ5Do/Pm+4fxfuBgG9r+hZXk+wXMxTHD/6koYJCDRnSe/pKH5kVOS4A==
X-Received: by 2002:a05:6512:3151:b0:47f:9d42:8e11 with SMTP id s17-20020a056512315100b0047f9d428e11mr5046731lfi.274.1656004026843;
        Thu, 23 Jun 2022 10:07:06 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:05 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] iio: adc: mcp3911: add support for buffers
Date:   Thu, 23 Jun 2022 19:08:37 +0200
Message-Id: <20220623170844.2189814-3-marcus.folkesson@gmail.com>
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

Add support for buffers to make the driver fit for more usecases.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 58 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 3d9e8ed10874..768cb0203f52 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -9,6 +9,10 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -54,6 +58,10 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct {
+		u32 channels[2];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
@@ -187,16 +195,58 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = idx,					\
+		.scan_index = idx,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 24,				\
+			.storagebits = 32,			\
+		},						\
 }
 
 static const struct iio_chan_spec mcp3911_channels[] = {
 	MCP3911_CHAN(0),
 	MCP3911_CHAN(1),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mcp3911 *adc = iio_priv(indio_dev);
+	int scan_index;
+	int i = 0;
+	u32 val;
+
+	mutex_lock(&adc->lock);
+	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
+			indio_dev->masklength) {
+		const struct iio_chan_spec *scan_chan =
+			&indio_dev->channels[scan_index];
+		int ret = mcp3911_read(adc,
+				MCP3911_CHANNEL(scan_chan->channel), &val, 3);
+
+		if (ret < 0) {
+			dev_warn(&adc->spi->dev,
+					"failed to get conversion data\n");
+			goto out;
+		}
+
+		adc->scan.channels[i] = val;
+		i++;
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
+			iio_get_time_ns(indio_dev));
+out:
+	mutex_unlock(&adc->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
@@ -297,7 +347,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		goto clk_disable;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
 	indio_dev->info = &mcp3911_info;
 	spi_set_drvdata(spi, indio_dev);
 
@@ -306,6 +356,12 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+			NULL,
+			mcp3911_trigger_handler, NULL);
+	if (ret)
+		goto clk_disable;
+
 	ret = devm_iio_device_register(&adc->spi->dev, indio_dev);
 	if (ret)
 		goto clk_disable;
-- 
2.36.1

