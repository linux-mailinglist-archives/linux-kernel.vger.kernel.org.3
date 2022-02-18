Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7F4BB0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiBREVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiBREVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:21:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F971AF075;
        Thu, 17 Feb 2022 20:20:52 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so11317063pjl.2;
        Thu, 17 Feb 2022 20:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l5vECSNMgOnnumdzy/X9A35VNb5su3yfGIWvExDKxt8=;
        b=elnBQXmDA1PO89usj49wd+VEXsjD6qDRr83u12VKDjjS2dODx6q2X4UviPuSxIYrTk
         n6B7kc0K5O0XwGJx0FuDRq3OtdGXpRbIVRzJcLhvtQxwsL603VOWMQCiLZZ3l57SL9hH
         nvHjtSzrSvvuACa7UEtNANqWz0bdO7YGSHB6ndvkQcixnGgJNhReE9coca1eCDthlJ6H
         ZMCUklmGAx3sit2F1NMxNBBog45RpHRKV3jClQufdZBziMT+M2aK12LleV5K7eVi2bCR
         oI44q3t+OHe9FLyDlsJ0IC/LqEuta7y6QAwcJf4ND6BXfm8v2BLCLZEOdfO+opHYq7ep
         v4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l5vECSNMgOnnumdzy/X9A35VNb5su3yfGIWvExDKxt8=;
        b=i9IOuRAoOXNDBCkrIUTlgtQ66rJcfjDnm6D7R7baXGb4uRH5WlhIq179ENDo+Z3EKW
         FAKdEJMNw1jgHGoaMp2eAZOLsDPcYHN7ZnNetWwbOHiwPyKPjBRAXNlLamB5dIkjnLy1
         +X1BzwGVKzgM/DY6NkeJrvEyPRa7hv/iBHM9myVEg7s/qJpKBk5fk2VL7GSqW6l0KY82
         I1ttPnv7bN8FhrFEUTCoimkAAmfmNQQXiXPhdwKz6J7UIypskmUh0YklmhDfmDSIMYFZ
         nfpj00b8ToHnWGnAfkckrUk+0o+TpVgAXlVjh7ipVGUktEInEbQnIW5VoV3Qh85KJGLl
         FIZw==
X-Gm-Message-State: AOAM532/QcYgEfbRetiUXpbA1qkEdBpAaI/uuotdPJtGJMaB7cHmd0Fo
        En5e+fvEhiWisz3TAtTnBEQ=
X-Google-Smtp-Source: ABdhPJzGGbKiS3wOS2UfrhDMNkllqU33t0WzuRntxZcq5dMHzcCUK5XsEymSs8QfT8u4WrI1cByq6A==
X-Received: by 2002:a17:902:7d89:b0:14f:2fed:2461 with SMTP id a9-20020a1709027d8900b0014f2fed2461mr5848003plm.4.1645158051960;
        Thu, 17 Feb 2022 20:20:51 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:51 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] iio: potentiometer: Add channel information in device data
Date:   Fri, 18 Feb 2022 09:50:35 +0530
Message-Id: <20220218042038.15176-4-jagathjog1996@gmail.com>
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

Adding each device wiper count and channel information into
device private data.
Utilizing addr member of struct iio_chan_spec to get the
wiper register address so that the value can be read or write
to the same address.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 33 ++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index d1e00dda337a..0ef3acb13c79 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -16,7 +16,8 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 
-#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
+#define DS1803_WIPER_0         0xA9
+#define DS1803_WIPER_1         0xAA
 
 enum ds1803_type {
 	DS1803_010,
@@ -25,8 +26,11 @@ enum ds1803_type {
 };
 
 struct ds1803_cfg {
+	int wipers;
 	int avail[3];
 	int kohms;
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
 };
 
 struct ds1803_data {
@@ -34,25 +38,32 @@ struct ds1803_data {
 	const struct ds1803_cfg *cfg;
 };
 
-#define DS1803_CHANNEL(ch) {						\
+#define DS1803_CHANNEL(ch, addr) {					\
 	.type = IIO_RESISTANCE,						\
 	.indexed = 1,							\
 	.output = 1,							\
 	.channel = (ch),						\
+	.address = (addr),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),   \
 }
 
 static const struct iio_chan_spec ds1803_channels[] = {
-	DS1803_CHANNEL(0),
-	DS1803_CHANNEL(1),
+	DS1803_CHANNEL(0, DS1803_WIPER_0),
+	DS1803_CHANNEL(1, DS1803_WIPER_1),
 };
 
 static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
-	[DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
-	[DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
+	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -88,7 +99,7 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
-	int pot = chan->channel;
+	u8 addr = chan->address;
 	int max_pos = data->cfg->avail[2];
 
 	if (val2 != 0)
@@ -103,7 +114,7 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
+	return i2c_smbus_write_byte_data(data->client, addr, val);
 }
 
 static int ds1803_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
@@ -144,8 +155,8 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
 	data->cfg = &ds1803_cfg[id->driver_data];
 
 	indio_dev->info = &ds1803_info;
-	indio_dev->channels = ds1803_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
+	indio_dev->channels = data->cfg->channels;
+	indio_dev->num_channels = data->cfg->num_channels;
 	indio_dev->name = client->name;
 
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.17.1

