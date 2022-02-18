Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C04BB0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiBREVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiBREVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:21:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0849CBA;
        Thu, 17 Feb 2022 20:20:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u16so1359102pfg.12;
        Thu, 17 Feb 2022 20:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vOM8aB0sk3te+hLK1KNBy8JLp5Cb9O0neMkVeze4/9w=;
        b=QOqbqdXGzI2ol36L6bTEN8l7GCEHlkS6GwS8hATSvclEZaoEVFL/Q16MlkyoEaw3lP
         D0le2DDMEDLGefTxj6HtJ3qhQvOgCJ9/RJwcsGXSNPFnkq5YIL+PbUyCvauz23xJYvqn
         AiBqsh9OBcLnubxobORd1pceB2W7ptCq5phxHim6VMfePYowX+i5Cbqlz0k7PBJncTZO
         H1x4Fx4OeojlorljbbTakgZF6Mn/BH9NGvuBhxFNwb8NcbEebPbY5BRwYUOaQZPteGLy
         Axa4sCks6rm46IuA5k8iL4rcO7hT7wydaGIPGF4n9rHNHrFgS0wjaIUAoxHQpfIq5MsF
         QKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vOM8aB0sk3te+hLK1KNBy8JLp5Cb9O0neMkVeze4/9w=;
        b=GZ3Lwv9ddrT3yg2IWtY29wgccE8xKqNP9Obp8FtO762JDur8Oz/pK6PtvhF9ZgVPhM
         fm7GjE6xpD6ynEIb1iuPSYlLfbo1Q4Do2BgV/mqjc/IYclxkfM5iAR9wkWcxQYy1lnUQ
         UTHMnatRJmJ/dydEhqAPTrTBPXBhYcT9D927wOXu9SbX/KgePnNm5+aLoZ4a8Dpt5OlH
         hjawVWs1XsLyzwIOFg5LuJUsceOmeWQqhbFUMKgvpJApW+iSBMnUcH5WbEs7CxqhWQyH
         O/0Linygb+ee6DDMLYzRZnGNTRSVVQZqcvNXK5KXJA/bKSBYz61cVYXNDhIhWC/ImzKV
         G/TQ==
X-Gm-Message-State: AOAM530V/XcV4mwsFbaoWfJ/x6LUgQR5fTCzjHUgDuALwJodQz2cbfiy
        LT2cn9O0YacMmMo7xaWHaZE=
X-Google-Smtp-Source: ABdhPJzXI5DFxXleHzuIADapJ3smSmpuIMtyvSOh0zCIjmEl2BaEoFUzzKJbCzMcfxCTcKRJmT2Y8w==
X-Received: by 2002:a05:6a00:1c47:b0:4e1:2c3a:ac3d with SMTP id s7-20020a056a001c4700b004e12c3aac3dmr5939058pfw.15.1645158049201;
        Thu, 17 Feb 2022 20:20:49 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:48 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iio: potentiometer: Add available functionality
Date:   Fri, 18 Feb 2022 09:50:34 +0530
Message-Id: <20220218042038.15176-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218042038.15176-1-jagathjog1996@gmail.com>
References: <20220218042038.15176-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding available functionality for DS1803 driver which
will show the minimum, step and maximum values that the
driver can accepts through sysfs entry.
Now using the max value present in avail array instead of chip
type specific macro to make the driver flexible to add other
type of potentiometer with different max position value.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 50 ++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 3c542a50ece6..d1e00dda337a 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 
-#define DS1803_MAX_POS		255
 #define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
 
 enum ds1803_type {
@@ -26,27 +25,23 @@ enum ds1803_type {
 };
 
 struct ds1803_cfg {
+	int avail[3];
 	int kohms;
 };
 
-static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .kohms =  10, },
-	[DS1803_050] = { .kohms =  50, },
-	[DS1803_100] = { .kohms = 100, },
-};
-
 struct ds1803_data {
 	struct i2c_client *client;
 	const struct ds1803_cfg *cfg;
 };
 
-#define DS1803_CHANNEL(ch) {					\
-	.type = IIO_RESISTANCE,					\
-	.indexed = 1,						\
-	.output = 1,						\
-	.channel = (ch),					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+#define DS1803_CHANNEL(ch) {						\
+	.type = IIO_RESISTANCE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (ch),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),   \
 }
 
 static const struct iio_chan_spec ds1803_channels[] = {
@@ -54,6 +49,12 @@ static const struct iio_chan_spec ds1803_channels[] = {
 	DS1803_CHANNEL(1),
 };
 
+static const struct ds1803_cfg ds1803_cfg[] = {
+	[DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
+	[DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
+	[DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
+};
+
 static int ds1803_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -75,7 +76,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = DS1803_MAX_POS;
+		*val2 = data->cfg->avail[2]; /* Max wiper position */
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -88,13 +89,14 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
+	int max_pos = data->cfg->avail[2];
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > DS1803_MAX_POS || val < 0)
+		if (val > max_pos || val < 0)
 			return -EINVAL;
 		break;
 	default:
@@ -104,9 +106,25 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
 }
 
+static int ds1803_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length, long mask)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = data->cfg->avail;
+		*length = ARRAY_SIZE(data->cfg->avail);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	}
+	return -EINVAL;
+}
+
 static const struct iio_info ds1803_info = {
 	.read_raw = ds1803_read_raw,
 	.write_raw = ds1803_write_raw,
+	.read_avail = ds1803_read_avail,
 };
 
 static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *id)
-- 
2.17.1

