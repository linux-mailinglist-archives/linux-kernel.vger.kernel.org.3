Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C025AE690
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIFL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIFL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:26:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09B4F645
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:26:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cu2so22580731ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XyJKVGE0cD/925orO/HXak99UYJgYNpKUPooDkzvfhg=;
        b=YNaLRjPAI6HE/oMyHjRmptBtO0czvRuRep/SybAqxLi3sij+gq+SpkrrYJyfT0c9Vs
         oIpm8H9JSRvaS7soQue2jz38q3KxMszb++YocStDax3w7KvRD2/xVB4zUTJ8s+MIpYnP
         5530UTobZsnos0Y/ybyG77PEK1ZxnxZYI2SOsiXkdtF4popIQ/1hO6SwqZaAaqFkg2eu
         RNDYrteHXE9DOAHLDObRTFvStb4kZ7c8Bex/YxEyx8yCTM3Ja+sN3+fMNjTyBDFPepOn
         qJ4Qbl9xpxjLI+rVBkXUpuAV5HxzJQjruGSfmJaQRHG6QESxRGnBfSrq7Otk9hz33B5Q
         H7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XyJKVGE0cD/925orO/HXak99UYJgYNpKUPooDkzvfhg=;
        b=kp+oR843ZT9/hZ9V+GaZ/93Z++X/WINN2s24UAVH5lZYtSC9pO87Nel0eaU6k9dNin
         rCqEDe8ioEvCGfOxtlHbKRJeK2qpg7RboZGenuTwRO4u/wcGDgWeEGa6IKz07MKOn3B8
         fikbj0amUWndiaPwRjPNjdBcclaLpv9n6DMcDHNCx6CvS5bt7R3wOUyhGZDnCQXmO+Jo
         Rvs1XmdSlftNf6za+TBfpW5Lpmv8y4m13Cflo7X4EkIRW84HtQbng/iVsIgYN5Nu2qCK
         3obMK7jHYRUN1UawdKCPXJkzC4PrOUPz7uU/FHeM+STUqekVWtlxGODcYI5DxOPGKYPv
         8i4w==
X-Gm-Message-State: ACgBeo3lVB4lrQQTsJx6stqd+OU7A2CHHOclEX2NC+vnMgKw9m9x9zJG
        gO5ydwsPkJoItjTxgi5QVDfYug==
X-Google-Smtp-Source: AA6agR4ZyeXLSEhMi1dcy3MJJxfdhL/tgUBQixZK3GdCiGoHRrYPA2/r6QQn1Arm6OJyHPsEG5YVMQ==
X-Received: by 2002:a17:907:781a:b0:730:ccea:7c29 with SMTP id la26-20020a170907781a00b00730ccea7c29mr39108019ejc.85.1662463603472;
        Tue, 06 Sep 2022 04:26:43 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906210900b0074136cac2e7sm6395669ejt.81.2022.09.06.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 04:26:42 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio: temperature: mlx90614 Refactoring available filter attributes
Date:   Tue,  6 Sep 2022 13:26:32 +0200
Message-Id: <20220906112632.244453-1-cmo@melexis.com>
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

Change/refactor to the new way of defining available attribute values.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90614.c | 41 ++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index c253a5315988..3157416be912 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -79,16 +79,15 @@ struct mlx90614_data {
 
 /* Bandwidth values for IIR filtering */
 static const int mlx90614_iir_values[] = {77, 31, 20, 15, 723, 153, 110, 86};
-static IIO_CONST_ATTR(in_temp_object_filter_low_pass_3db_frequency_available,
-		      "0.15 0.20 0.31 0.77 0.86 1.10 1.53 7.23");
-
-static struct attribute *mlx90614_attributes[] = {
-	&iio_const_attr_in_temp_object_filter_low_pass_3db_frequency_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group mlx90614_attr_group = {
-	.attrs = mlx90614_attributes,
+static const int mlx90614_freqs[][2] = {
+	{0, 150000},
+	{0, 200000},
+	{0, 310000},
+	{0, 770000},
+	{0, 860000},
+	{1, 100000},
+	{1, 530000},
+	{7, 230000}
 };
 
 /*
@@ -373,6 +372,22 @@ static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int mlx90614_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (int *)mlx90614_freqs;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(mlx90614_freqs);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_chan_spec mlx90614_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -389,6 +404,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
 	},
@@ -401,6 +418,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
 	},
@@ -410,7 +429,7 @@ static const struct iio_info mlx90614_info = {
 	.read_raw = mlx90614_read_raw,
 	.write_raw = mlx90614_write_raw,
 	.write_raw_get_fmt = mlx90614_write_raw_get_fmt,
-	.attrs = &mlx90614_attr_group,
+	.read_avail = mlx90614_read_avail,
 };
 
 #ifdef CONFIG_PM
-- 
2.34.1

