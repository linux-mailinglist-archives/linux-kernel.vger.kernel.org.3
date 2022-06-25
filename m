Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674655A8F1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiFYKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiFYKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2512A709;
        Sat, 25 Jun 2022 03:37:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i18so8545361lfu.8;
        Sat, 25 Jun 2022 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oKTuqkNAMcSE9m/aA7zeta4JWfDKTgCumXtoFm2uzk=;
        b=KJDBq6yW8PCQhMfGSov0ZPGR4Wk5yPhnBbktUIrgYaKu1/IQRsi4di63b160zNeYxB
         ERCpAa2yrI4L65wYikYrlVIdWf+vee8h0pBEU+FZQMdHEatJiRokxgXuDuldQeh/wccE
         F25KECVpEUf4HqUpodGsn79cntAqM7ynAPGKfccBC5w1kg93nvqR40CUnzocfoSmBVo0
         5Cfv2EN7JA2NdQ1XRLVEj/57m6JO/bIYden2QlhI+30hj7sXJJEI9eOUI8D38g6fHAGg
         3p5TXn+qmqV9Yh6pZLa1CX/1Glm8n4zFN6Jz0/ee6U0pQQp7SXVW67H+CDl8x5K7hcZF
         hltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oKTuqkNAMcSE9m/aA7zeta4JWfDKTgCumXtoFm2uzk=;
        b=r/mj/xTNqe/WRGUcM1SC48LAWBrPKE6Zwg0owC4KdyoHAu8IoAdSTmBFFr7xy+OuTg
         UEWT2VeYthzD62MKnsb0M1WHW/Ll4NtWhN22bcSVFXmG30pwtp7uyJlpcww3lj9lt63Y
         WvZCyrPw2Aq+vUbMClXQobK0dsZ3TRvN99rsuvRiYrPOQ+EWg6VT4kKQKpmS4zbn1aBA
         NjqQjY2zrogGMOG2+4lEoBF74j8dpgEEXFjjcB/kFAy/DqdPqboH3emLwQNTwvvh94dm
         USD2lhLUoFlV7yHzK6aWlC155lM4Z8BjbLAA4gmq4yq7yBYsSz84Yow3ORtGLTvPJZHh
         UgRA==
X-Gm-Message-State: AJIora/LAClhj7XFWmGgGp9hd9v81TdhTIBJuZkZluOWhFvSj23/8WaL
        f4OoLOqVzB1H2sVCebv7fI8=
X-Google-Smtp-Source: AGRyM1tjDyzTbaCUZguZZ7tYArQsytO/cRDImRTNJminAWr3VyrM1JyNrUAnnvnMUEkQnxNfIgVQaw==
X-Received: by 2002:a05:6512:234e:b0:47f:8c9c:dfd with SMTP id p14-20020a056512234e00b0047f8c9c0dfdmr2105854lfu.438.1656153450337;
        Sat, 25 Jun 2022 03:37:30 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:29 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] iio: adc: mcp3911: add support to set PGA
Date:   Sat, 25 Jun 2022 12:38:53 +0200
Message-Id: <20220625103853.2470346-10-marcus.folkesson@gmail.com>
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

Add support for setting the Programmable Gain Amplifiers by adjust the
scale value.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - add missing comma
        - Address comments from Andy Shevchenko

 drivers/iio/adc/mcp3911.c | 134 +++++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index a019264e73e3..f0179385485f 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -26,6 +26,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
+#define MCP3911_GAIN_MASK(ch)          (0x7 << 3*ch)
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3*ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
@@ -55,8 +57,10 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
 
 #define MCP3911_NUM_CHANNELS		2
+#define MCP3911_NUM_SCALES		6
 
 static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};
+static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
 struct mcp3911 {
 	struct spi_device *spi;
@@ -65,6 +69,7 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
+	u32 gain[MCP3911_NUM_CHANNELS];
 	struct {
 		u32 channels[2];
 		s64 ts __aligned(8);
@@ -113,6 +118,37 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_get_gain(struct mcp3911 *adc, u8 channel, u32 *val)
+{
+	int ret;
+
+	ret = mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
+	if (ret)
+		return ret;
+
+	*val >>= channel * 3;
+	*val &= GENMASK(2, 0);
+	*val = BIT(*val);
+
+	return 0;
+}
+
+static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+}
+
 static int mcp3911_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type, int *length,
@@ -124,6 +160,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
 		*vals = mcp3911_osr_table;
 		*length = ARRAY_SIZE(mcp3911_osr_table);
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = (int *)mcp3911_scale_table;
+		*length = ARRAY_SIZE(mcp3911_scale_table) * 2;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -180,29 +221,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_SCALE:
-		if (adc->vref) {
-			ret = regulator_get_voltage(adc->vref);
-			if (ret < 0) {
-				dev_err(indio_dev->dev.parent,
-					"failed to get vref voltage: %d\n",
-				       ret);
-				goto out;
-			}
-
-			*val = ret / 1000;
-		} else {
-			*val = MCP3911_INT_VREF_MV;
-		}
-
-		/*
-		 * For 24bit Conversion
-		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
-		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
-		 */
-
-		/* val2 = (2^23 * 1.5) */
-		*val2 = 12582912;
-		ret = IIO_VAL_FRACTIONAL;
+		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
+		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
+		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
 	}
 
@@ -220,6 +241,18 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&adc->lock);
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
+			if (val == mcp3911_scale_table[i][0] &&
+				val2 == mcp3911_scale_table[i][1]) {
+
+				adc->gain[channel->channel] = BIT(i);
+				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
+						MCP3911_GAIN_MASK(channel->channel),
+						MCP3911_GAIN_VAL(channel->channel, i), 1);
+			}
+		}
+		break;
 	case IIO_CHAN_INFO_OFFSET:
 		if (val2 != 0) {
 			ret = -EINVAL;
@@ -264,6 +297,48 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int mcp3911_calc_scale_table(struct mcp3911 *adc)
+{
+	u32 ref = MCP3911_INT_VREF_MV;
+	u32 div;
+	int ret;
+	int tmp0, tmp1;
+	s64 tmp2;
+
+	if (adc->vref) {
+		ret = regulator_get_voltage(adc->vref);
+		if (ret < 0) {
+			dev_err(&adc->spi->dev,
+				"failed to get vref voltage: %d\n",
+			       ret);
+			return ret;
+		}
+
+		ref = ret / 1000;
+	}
+
+	/*
+	 * For 24bit Conversion
+	 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
+	 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
+	 */
+
+	/* ref = Reference voltage
+	 * div = (2^23 * 1.5 * gain) = 12582912 * gain
+	 */
+	for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
+		div = 12582912 * BIT(i);
+		tmp2 = div_s64((s64)ref * 1000000000LL, div);
+		tmp1 = div;
+		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
+
+		mcp3911_scale_table[i][0] = 0;
+		mcp3911_scale_table[i][1] = tmp1;
+	}
+
+	return 0;
+}
+
 #define MCP3911_CHAN(idx) {					\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -276,8 +351,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_type_available =		\
+		.info_mask_shared_by_type_available =           \
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_separate_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),		\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -330,6 +407,7 @@ static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
 	.read_avail = mcp3911_read_avail,
+	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
 };
 
 static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
@@ -460,6 +538,14 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		goto clk_disable;
 
+	ret = mcp3911_calc_scale_table(adc);
+	if (ret)
+		goto clk_disable;
+
+       /* Store gain values to better calculate scale values */
+	mcp3911_get_gain(adc, 0, &adc->gain[0]);
+	mcp3911_get_gain(adc, 1, &adc->gain[1]);
+
 	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
 				0, 2);
-- 
2.36.1

