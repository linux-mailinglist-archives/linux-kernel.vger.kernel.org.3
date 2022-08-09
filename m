Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3858D4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiHIHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiHIHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7C21259;
        Tue,  9 Aug 2022 00:32:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v10so8652671ljh.9;
        Tue, 09 Aug 2022 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIOq4IMQabHqc6y9r29v4FayDraSHRsNoNlUdi/9yx0=;
        b=oY9fyepLV7ROHYvBYRaKwyrBTSBjUR5Dv/LyQelCPK4bhGEXTwQKUGIDSF3viMUkLF
         CcT1uHokBkaok4gyt/6hBdcLiXrjsEjvM6GqBNiYNQhdq5ZHF1ySTo9jDrB8IC5A8F/F
         SaBOc/EZKtkjmPrEciqvWPxBc2zbBlmwHq444bHTapror16idZcUactvi5Q9hpyixHYg
         o3aybmpGprOa3OPhjza/6juSh8nb7oGyEQHMITVxwWWt4wkodyWw47pEW/hnZpfZd+Yr
         Xlm/2qvgWQq1eSPxaQFroTG8i72Cd7mOqSQSauXc5H8+gtCXv9IO93E2PWKLHVkQLGWF
         /1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIOq4IMQabHqc6y9r29v4FayDraSHRsNoNlUdi/9yx0=;
        b=xsSt+t98iUbPmpB/YidblR8NKaMbPOs7vyKgOwFX4M0l5oPdwIGDD1Gm/rHUqWo4C9
         xmna+veffH3ETAucNeru0ir7Q1Iht2ZmQfIP6i4enYPtXhbDPMmZFPgeNuSnoc6coiOi
         bsnmekyugwVmiuFJvztOIsd/OmO7VjkQdn4we/i0Pw4fQUQdPKTAj4jGDd79bafJ7Bfr
         ckg7+7qNS8APwYhEXU7uuOWtrBGXy8LI0Bp5WZPdbHCIfPeaGVJG00blGN5fvcwjJDhO
         MCX8i4CcJdnHYMQYZyUpa7hn0u1pI6eJkYmtvm6KJGosPXGN3+bcRhKPmNbaWrb5sBpJ
         Y0NQ==
X-Gm-Message-State: ACgBeo3wVen6NRb38Ci2CsU1DyzzKfa7rCBrhzsEWpk53uTQEWTD6jtc
        yGaOqt5WRLOfJt+lNB7Yjrfk/dP/mbyckQ==
X-Google-Smtp-Source: AA6agR4ctdZFMCLrOswEOPeJSNm/VQu1YwvQqJPpKP9Gk6+NdiayIR2qETaiFAH4+AP/GbYIaud+eQ==
X-Received: by 2002:a05:651c:446:b0:25e:5629:213b with SMTP id g6-20020a05651c044600b0025e5629213bmr6628019ljg.53.1660030355132;
        Tue, 09 Aug 2022 00:32:35 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:34 -0700 (PDT)
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
Subject: [PATCH v5 8/9] iio: adc: mcp3911: add support for oversampling ratio
Date:   Tue,  9 Aug 2022 09:36:47 +0200
Message-Id: <20220809073648.167821-9-marcus.folkesson@gmail.com>
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

The chip supports oversampling ratio, so expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index ac614030e400..61b516573207 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -40,6 +40,7 @@
 #define MCP3911_REG_CONFIG		0x0c
 #define MCP3911_CONFIG_CLKEXT		BIT(1)
 #define MCP3911_CONFIG_VREFEXT		BIT(2)
+#define MCP3911_CONFIG_OSR		GENMASK(13, 11)
 
 #define MCP3911_REG_OFFCAL_CH0		0x0e
 #define MCP3911_REG_GAINCAL_CH0		0x11
@@ -58,6 +59,8 @@
 
 #define MCP3911_NUM_CHANNELS		2
 
+static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
+
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -116,6 +119,36 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+}
+
+static int mcp3911_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*vals = mcp3911_osr_table;
+		*length = ARRAY_SIZE(mcp3911_osr_table);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mcp3911_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -144,6 +177,15 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+		if (ret)
+			goto out;
+
+		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
+		*val = 32 << *val;
+		ret = IIO_VAL_INT;
+		break;
 
 	case IIO_CHAN_INFO_SCALE:
 		if (adc->vref) {
@@ -203,6 +245,17 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
+			if (val == mcp3911_osr_table[i]) {
+				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
+				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
+						val, 2);
+				break;
+			}
+		}
+		break;
 	}
 
 out:
@@ -215,9 +268,12 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.indexed = 1,					\
 		.channel = idx,					\
 		.scan_index = idx,				\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_type_available =		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -279,6 +335,8 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
+	.read_avail = mcp3911_read_avail,
+	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
 };
 
 static int mcp3911_config(struct mcp3911 *adc)
-- 
2.37.1

