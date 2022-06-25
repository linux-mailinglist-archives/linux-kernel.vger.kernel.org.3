Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346BD55A8E5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiFYKhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiFYKhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB42A266;
        Sat, 25 Jun 2022 03:37:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x3so8601745lfd.2;
        Sat, 25 Jun 2022 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtWFlPGPjVSnMZ4erXWfPBR06ujhnTCZkKaRKoERWf8=;
        b=ESfRLf2NxNJFMdlALFjxdqvR7bhoTehmwJUioSfvKlzNvcfPuBDB0NzKCDQPMTFXsI
         r7NnOspg0cJuUqiHK4Eq4ujdBf36irns9HbK283iiaMR8mWZ/9Y2U0BFTvBhp4kgB7hG
         oHoGEZLse/dRvEeOm9RFLY6UeXhdUyDNeX0iyEMHBjnheaFK+a6oLe/79ABGOyWZ9eqT
         fobidA5ee7nXT3QPIxvgjUVpsDDDhWQWLS7g6BvfRCEFHPWbnG2BQ0RNBueR5mOBf72Y
         xe2Mn33qjwB6cMeZVBUxHrHAcY5dr/HH8iFuzTuNi/LR3BBxKuS06BQO3kxDVz0O6VLq
         AxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtWFlPGPjVSnMZ4erXWfPBR06ujhnTCZkKaRKoERWf8=;
        b=GfohkBpBe9seqcoFrbOgxN10SVRlfar5yteVDyzhn+mJEj8rrpZ6dQsxSn4sshjxvY
         D4c/LZ4gxZFaLYGPDUNbyU1dgukfgPmt05PvygXE3wcNe7jfb5hgseeGruy3bsxHvROo
         LsyI2nrEcIeUL+XqCK/bfNmToj4T2NrSmsNUiOU4oLQJbIs89MsSpZIOXFfHbwKKGnQF
         qprmtUDEvzlBdJUPHjfuJFtcuYNFrIHrnsENhPFrXYVoEap5+SPhfRW/NAwhhWmEO3AB
         lJTbDU35JoYDtZeBurjzlWNKauBflCdJCP0+lLlxvr25CG4yF3uSwok/4C8HYJZDSh+S
         GrFQ==
X-Gm-Message-State: AJIora9yYWmzXX+9NRHXsfmNV+9Dq4LD96uw3GFjAtssDcrM/aCJLpin
        EBtPbYfkyPAr1oOUXiK/4x8=
X-Google-Smtp-Source: AGRyM1taTAUzfY2cDEMMbKMHGCLHGiW+1rnUMl9L6SKviO8I/PYa0Jfa/5qCwqpggp3clA+i+MFLuQ==
X-Received: by 2002:a05:6512:6d0:b0:47c:6082:9ca3 with SMTP id u16-20020a05651206d000b0047c60829ca3mr2225636lff.353.1656153440266;
        Sat, 25 Jun 2022 03:37:20 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:19 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] iio: adc: mcp3911: add support for buffers
Date:   Sat, 25 Jun 2022 12:38:46 +0200
Message-Id: <20220625103853.2470346-3-marcus.folkesson@gmail.com>
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

Add support for buffers to make the driver fit for more usecases.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - No changes

 drivers/iio/adc/mcp3911.c | 58 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 25a235cce56c..2a4bf374f140 100644
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
@@ -303,7 +353,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		goto clk_disable;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
 	indio_dev->info = &mcp3911_info;
 	spi_set_drvdata(spi, indio_dev);
 
@@ -312,6 +362,12 @@ static int mcp3911_probe(struct spi_device *spi)
 
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

