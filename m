Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15B5AB20A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiIBNtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiIBNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:48:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F6A457
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:23:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b16so2309819wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ne1CzWe4cfOGjFgnqh9c4T9gpw+pVEy0R/dHCBbC3j4=;
        b=V1FZtHJ8d4R2pTVPWo+Qw3P3sv4CAtBdsbCusbBP+ewYWZygqpwDp2k8T0sNyreoPc
         7+V1LPHimGgtaQVbkeFo3jwtBBylWxnXlka5WD1VDMI2aUJS0WEJ4A4AmS5Zsk6E854m
         tC+NEC87TEW7qiZde4EG1EEPKzpUbVeXIpMUzNffzmqOKc9jpkRaGOgxMBXucJNvTII7
         6cQHltIHmT56UTbOXwlbwO+uxIoGQpTrYaBs5DVbRrI/DYy3aO3pNnXEm58cDv5O4jwM
         bQbtBCu7TOlW4W4J36BeQwkozY3V6iiyoheQSG2Ry5Uu5OKqNwoq1dpR2hdAQf+OW+mB
         vmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ne1CzWe4cfOGjFgnqh9c4T9gpw+pVEy0R/dHCBbC3j4=;
        b=I/ON6ww4iU3a8w4QtHZGJUIGzE2eRyCwwz3Awn7+qBucNZszjVpSTZraPS/5w7rpks
         4b1VhCRjBmYBdNrMLd1VtbCbUN03Q7FuZKnAcTvTRHaTipMMVqZ3T9hlMuByL76Oi1rZ
         IfKgS/S37LBF+siGFqw+2eVDAZHgXzQuLYEwFGkEG8k/Sj9o0ZUy7ZSVx5Pzj6WErFiy
         NNZmfyoTP+Oj5QyHJwIOhfF5bEIKfmNdTDw8KKcrGBbUa+bhN1Ghl6lNbv7LuqMXc44j
         zoWqCgQBXkm/pPdmHAssPZQyLH/3QoiGCEVD2iRKl7C7lYAHP+pCuVG1XF3DJymfMzNc
         pSSQ==
X-Gm-Message-State: ACgBeo1BJDU/1UrBt0bls3YMYH+Tx6v3Mfk9rzb3fTlmfXCPIFgj0VF6
        wmqrm+5TbOfJXyfWZx0kN9QM/BpPUUgfRg==
X-Google-Smtp-Source: AA6agR65d7VTPa+9d+skBZR8Hb8elzsXjsl6R4k9oV8XaPUR1OtZ1KxL3EqdxP9GfE5CZOns2JNk0w==
X-Received: by 2002:a17:907:78d:b0:740:33e1:998 with SMTP id xd13-20020a170907078d00b0074033e10998mr23610530ejb.162.1662124413277;
        Fri, 02 Sep 2022 06:13:33 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id cy16-20020a0564021c9000b00446ad774ea0sm1454311edb.7.2022.09.02.06.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:13:31 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 2/3] iio: temperature: mlx90632 Read sampling frequency
Date:   Fri,  2 Sep 2022 15:13:28 +0200
Message-Id: <20220902131328.3316436-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
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

Allow user to read sensor sampling frequency to better plan the
application measurement requests.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 45a1ab51fd0c..63b19ac1484c 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -80,6 +80,9 @@
 #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
 
 #define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits*/
+#define MLX90632_REFRESH_RATE(ee_val) (MLX90632_EE_RR(ee_val) >> 8)
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
+	int ret;
+	unsigned int meas1;
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
+static const int mlx90632_freqs[8][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
+					  {8, 0}, {16, 0}, {32, 0}, {64, 0} };
+
 static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
 {
 	unsigned long now;
@@ -985,6 +1006,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
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
@@ -1019,12 +1049,24 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
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
@@ -1032,12 +1074,14 @@ static const struct iio_chan_spec mlx90632_channels[] = {
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

