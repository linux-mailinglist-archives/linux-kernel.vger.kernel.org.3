Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25A5AC196
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 00:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiICWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiICWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 18:24:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44F5073D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 15:24:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u6so6995001eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=e0q/1eeKpn8xnk0xY6Lu5gTCh4C5ZfPCKIfvqPEAtIo=;
        b=qWgTU6GIPW2B0/TGVGZrSXEjIh7Qq6QBLdk0Kn9kSeSKCU9ixbLEUGkSAQv7TF/zK0
         CG0HqVSZJwgy1jIiY5ZADT5xPNOmZQJRXqGR8z0s1ceKG2LYO1MKLql9PRtuV6Kk2lNk
         hAwm1qAXbp9I0gBBdGZ81g7WpDAUpOQnqr+62St4Jcba2SoENhXcva68vKO1mcaFiAyB
         segSskKBOp7dgtGUq9O/oyS3/zK4JnL/hfVeCTMYCP5WKRzdgNPmfmUgWviMKCk+08tV
         x2s+SGNjDmx5+XlaSHYsq7IUCbO414dz5OSi18osuB0ywL7qfdK4gWPmol10jGI+efmY
         yYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=e0q/1eeKpn8xnk0xY6Lu5gTCh4C5ZfPCKIfvqPEAtIo=;
        b=rFIKixAvJ738wnRWusCBIZ9DChPuyPgeUOEz4+8VOv0q8JIqbjOqgSVm6yMtKXDueF
         Sq9K/QEA4OEZ2cSKOL7jdri48EsH4yCveQ+HXGlZELFkEWEtSLPOY3uupYZ5+8MmB7Sn
         cd7G2rB5TFconD8HGuDkhFPCOyZ4sQUP38R0Z+SyNcy1Heg7Lq1I7BV6bax+78v0FCK/
         3lnfI/WnUzKDNkwaaH5l8cbjo0Zbg77s0FyY/aMJIO7h4Ih6gLfHsv+i3AbkzfBfNt3X
         4zJBVWLiOmbhMLPNRfb6YFBcO+tHMv1o7vdDWd3lYHD5Qza/Jvz6SmiexQ99LUoZLTYc
         qf4g==
X-Gm-Message-State: ACgBeo00jDXF2WV413lBfB6XazAIwNYAXy0olh50v362ZSG9zBA/ZP2R
        yQAPpB0lvmXxyQ0nbXnyIoXP2Q==
X-Google-Smtp-Source: AA6agR6AvSRrqhXCwxCgR6q5NENiDCorzE8cpRoc/TFlRD//SVuBbassZ46Nr2NamAHj/SdnYTGVuA==
X-Received: by 2002:a05:6402:5285:b0:44d:adf4:e943 with SMTP id en5-20020a056402528500b0044dadf4e943mr2503119edb.302.1662243845926;
        Sat, 03 Sep 2022 15:24:05 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3sxu2v33e81l49.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d4a:f526:3662:1129])
        by smtp.gmail.com with ESMTPSA id cz19-20020a0564021cb300b0044780b6debasm3891098edb.32.2022.09.03.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 15:24:05 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 2/3] iio: temperature: mlx90632 Read sampling frequency
Date:   Sun,  4 Sep 2022 00:24:02 +0200
Message-Id: <20220903222402.3426058-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/iio/temperature/mlx90632.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 9acd819c76a6..37edd324d6a1 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -80,6 +80,9 @@
 #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
 
 #define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits */
+#define MLX90632_REFRESH_RATE(ee_val) (MLX90632_EE_RR(ee_val) >> 8)
+					/* Extract Refresh Rate from ee register */
+#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
 
 /* Measurement types */
 #define MLX90632_MTYP_MEDICAL 0
@@ -908,6 +911,24 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
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
 static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
 {
 	unsigned long now;
@@ -978,6 +999,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
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
@@ -1012,12 +1042,24 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static IIO_CONST_ATTR(sampling_frequency_available, "0.5 1 2 4 8 16 32 64");
+
+static struct attribute *mlx90632_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mlx90632_attribute_group = {
+	.attrs = mlx90632_attributes,
+};
+
 static const struct iio_chan_spec mlx90632_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_AMBIENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_TEMP,
@@ -1025,12 +1067,14 @@ static const struct iio_chan_spec mlx90632_channels[] = {
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
 static const struct iio_info mlx90632_info = {
 	.read_raw = mlx90632_read_raw,
 	.write_raw = mlx90632_write_raw,
+	.attrs = &mlx90632_attribute_group,
 };
 
 static int mlx90632_sleep(struct mlx90632_data *data)
-- 
2.34.1

