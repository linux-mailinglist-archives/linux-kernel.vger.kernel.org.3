Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686755AE3CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiIFJFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbiIFJE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:04:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B34140E4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:04:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so21720619ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4yFAOWbxAtGl2PyfPR7jYQGQMm31HYr0AN+6Bv49Vv4=;
        b=omvY7562bz7V+wlaASP8yvfHXqY+U9lUaWQEsKuNy114e0A6NJrELZMoFjzeNBNRyw
         0J/+vuqsr4upQxBMg3vwZNrxOITDB86fZhPspErWNLDcsPuXFFtjXG7yjC3S+bDq7oZ0
         ZIPClqHKlZ04yXF3jIEk1E9dTbhvIBELbfRpK1f7DEgJh7tWS1JLMMOR0TRgP/Gm2PEg
         An3NE1oGs9qp3pzmKE554QA42HRdwQ/RkpmjMwkauFbkUMC8fM8/Lfkoq4Nt1nTWlQzH
         Yro1CdlTtpLkNopbZcdgP+PSib/WJ00rJDyHpbOEMwV4+BytpPrbfZFvAMSJG/nfwYij
         vdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4yFAOWbxAtGl2PyfPR7jYQGQMm31HYr0AN+6Bv49Vv4=;
        b=Qvnpvqh83/OCNLrMMaMPQQIPf9VlWvKjg8YEBfuyKlZi7+z/hjQTuBXb0nhDwZ2j0q
         nxuMeVC4gtgNqtf0tEiVsSv2C74bWi9WxmGaRq3vjrtUpAALp1Rhempk56CjzaaaX1Y2
         cBH+isGxLgU0PyvSMzMr1hXocz1ZvvCckPCUMCM6UNanOYSVR+BvvB+TvBhWubXat1o/
         DTaTzMxyOZEJRpxS9N/UE3i0EaKuyRzVLORweBTfWFW90EykR2qNtEz6LOTDdXQ62X4S
         +UbB0vgi/hUo5SeeV+bmrq2lcmDbgveS9TZ77Ep1gyeYwjOat2cgi5BVgqRBhvytpXIq
         Yhag==
X-Gm-Message-State: ACgBeo0HWJegmBzByk5us+uNxEjLnEyfjje1jj68ThAgJ3ud/zDYomn7
        CVsC+hSnBFORlE0Uvs9b2Dg74w==
X-Google-Smtp-Source: AA6agR4qRV6z1idl4v09C4ERCwA0d5Cd0bspmRWcDioM9B0pUiq7MVgstVKw0wa2yfDJ7GCneZeFQw==
X-Received: by 2002:a17:907:7601:b0:73d:9f0b:d99f with SMTP id jx1-20020a170907760100b0073d9f0bd99fmr38156843ejc.300.1662455096894;
        Tue, 06 Sep 2022 02:04:56 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b29-20020a50ccdd000000b0044ebf63d337sm1612531edj.57.2022.09.06.02.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:04:56 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 2/3] iio: temperature: mlx90632 Read sampling frequency
Date:   Tue,  6 Sep 2022 11:04:31 +0200
Message-Id: <8d206235a7241fe764d9d51649061a4fd1b534d6.1662454215.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1662454215.git.cmo@melexis.com>
References: <cover.1662454215.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

Allow users to read sensor sampling frequency to better plan the
application measurement requests.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index e41a18edbc65..6b33284eb0b6 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -81,6 +81,9 @@
 #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
 
 #define MLX90632_EE_RR GENMASK(10, 8) /* Only Refresh Rate bits */
+#define MLX90632_REFRESH_RATE(ee_val) FIELD_GET(MLX90632_EE_RR, ee_val)
+					/* Extract Refresh Rate from ee register */
+#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
 
 /* Measurement types */
 #define MLX90632_MTYP_MEDICAL 0
@@ -915,6 +918,24 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
 	return ret;
 }
 
+static int mlx90632_get_refresh_rate(struct mlx90632_data *data,
+				     int *refresh_rate)
+{
+	unsigned int meas1;
+	int ret;
+
+	ret = regmap_read(data->regmap, MLX90632_EE_MEDICAL_MEAS1, &meas1);
+	if (ret < 0)
+		return ret;
+
+	*refresh_rate = MLX90632_REFRESH_RATE(meas1);
+
+	return ret;
+}
+
+static const int mlx90632_freqs[][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
+					  {8, 0}, {16, 0}, {32, 0}, {64, 0} };
+
 /**
  * mlx90632_pm_interraction_wakeup() - Measure time between user interactions to change powermode
  * @data: pointer to mlx90632_data object containing interaction_ts information
@@ -993,6 +1014,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 		*val = data->object_ambient_temperature;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = mlx90632_get_refresh_rate(data, &cr);
+		if (ret < 0)
+			goto mlx90632_read_raw_pm;
+
+		*val = mlx90632_freqs[cr][0];
+		*val2 = mlx90632_freqs[cr][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1026,12 +1056,30 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int mlx90632_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)mlx90632_freqs;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(mlx90632_freqs);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_chan_spec mlx90632_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_AMBIENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_TEMP,
@@ -1039,12 +1087,15 @@ static const struct iio_chan_spec mlx90632_channels[] = {
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
 static const struct iio_info mlx90632_info = {
 	.read_raw = mlx90632_read_raw,
 	.write_raw = mlx90632_write_raw,
+	.read_avail = mlx90632_read_avail,
 };
 
 static int mlx90632_sleep(struct mlx90632_data *data)
-- 
2.34.1

