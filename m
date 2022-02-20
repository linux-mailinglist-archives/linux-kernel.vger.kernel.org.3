Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F144BCBB7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiBTCrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiBTCrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:47:03 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246C5FA0;
        Sat, 19 Feb 2022 18:46:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 139so11250435pge.1;
        Sat, 19 Feb 2022 18:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiihxuBwfEAWFN0iioefL1gnjjyjm+Qiro5uJmWB4Mw=;
        b=k6wSS9R16e0VnxsMB2WaPy1av0Oghsz1AOganzzQ69lnObFYJdgTARI1FrPT0NPNZJ
         +iys2EVyrHFGBiSZjPVc9MtWnxyXZnrEb5SUh02Nt4DnqSlxgfsNTw+kkt3wTH+DklEc
         idGti2WJp9/hPY7Pnas6t7S7f3l+fX5Cy9LKbYCdqMCFj1R0jmFP3tfGs5jv/NcQlATA
         QkJ6dgC8sG4T5myObaB1n9Rl/rgot/kKj0Oc+18p2Ghd2d/ULJbQuQ7HaJxPRWoHSw5Z
         iEHmHw85n50r+jtOQ2u8lJCPsqZriELX9AaivYA/xPZOiBFwk8qKAILwP18Db3o+dJxb
         c5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uiihxuBwfEAWFN0iioefL1gnjjyjm+Qiro5uJmWB4Mw=;
        b=COji0BjbloIyZKfU8DMg9YxoiuP9uN8rIYxo4X9OO2uBWXDIRrbjRbc4XQKkcjILhq
         XV4ERo450eT0j9U+snTSg/ieB2gccZJhY9GL+iTSA0Kycnf/jwXgRqWcGH7OiUF9xDA8
         o1at56haQEYJK7bj1Wa5xrecYKmXqIkmh6Gmg/aeYzj825SRBeTRpuVCMXpe2o8ljFAC
         x9ZYyg9xnMSY0c8lbfG34zKEK2pMze8GXDoE1CWTUgF+xHf8Ler5q2+XRNtk9FKp3dED
         DfAgfOuNQ5Icn4EdHZEX1PlkbIhsVN7QrJA7de6zgOmj3sZIhAjY9LJmWA2uF+TxSSpJ
         Hprg==
X-Gm-Message-State: AOAM530xWE4XdOiagaKd6vIV8vG6cVsQORL4GkPwytHx7qpWIro/rTtP
        h4wNCIxevPPT9wmnT8DahStjWhj2JbzZbCLIgwc=
X-Google-Smtp-Source: ABdhPJx9MWZyyRf0OhWyT7FiO36PEUMWgtqcWeZ/5YSfdheUW8wXKzoXrfOks710EGnG4kDZ3/AAag==
X-Received: by 2002:a63:88c1:0:b0:36c:dcd7:2241 with SMTP id l184-20020a6388c1000000b0036cdcd72241mr11534177pgd.141.1645325202279;
        Sat, 19 Feb 2022 18:46:42 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:42 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] iio: potentiometer: Add available functionality
Date:   Sun, 20 Feb 2022 08:16:27 +0530
Message-Id: <20220220024632.4183-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
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
 drivers/iio/potentiometer/ds1803.c | 52 +++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 3c542a50ece6..c9cf7181cb7f 100644
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
@@ -104,9 +106,27 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
 }
 
+static int ds1803_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type,
+			     int *length, long mask)
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

