Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83E4BCBCA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbiBTCrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbiBTCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:47:14 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C904245A5;
        Sat, 19 Feb 2022 18:46:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 12so7672407pgd.0;
        Sat, 19 Feb 2022 18:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ienohvOr86bVgWt3LPZgXi/rHK6KTUPXquXbb0N97Wc=;
        b=a5ohoCZ/oyGlyMnA4Nfq5vgav/ZOadiMjoNoHfc8Ief+NdFjTcyTLrjZ1rHkaMwhcA
         EqFelYVsodgB6dHLOsKImevwxgHocwDquUzouVu7G4hNXPI3ErquCBnCclczk1dbzfmw
         JZENi9pknWYRSkpShYkR57uF/DzeEqmKyovSQ0E0bhT5WxVGCx93DNpcyMB+HDB187GL
         XRo9xktKG49FQ7BRyDlwNj9wDMbKbCejUoQqVEyS5lR0kJrTwPcR7LJIiRNsWFkppiEE
         5pwJLDAGt9CFkEqwnSEdQqQXAgM+WctjLmMpbt4RkuxDRgQGqEpV79StbAyXyJwR6yiE
         EwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ienohvOr86bVgWt3LPZgXi/rHK6KTUPXquXbb0N97Wc=;
        b=y9yuuVhwKE6YNFOh0CqhloTqPs0Q1180790wdbeRgr3S3zxLgEU/t4deQyFf3FnYXD
         8C8CQYuXHUFsWQGK2vDOZxQeo6N2Ckn9N05QGUkjD6p3TqKgBqRTv+KpIaIjkXT1Su/d
         iObsbEN3pMBoKCmakMHodlZ7vhW+ltQncMrt1r6H+/ymzSnO3V0y+Y5z369ZyTaXCY6O
         1Gs14Auv4USZUuPELM2IwvJoJZqhv1Al+KHslYUh+t3tbDJFN4F6DdUUxm+qICyAMlEf
         xalOSt4Qr/742RlL4FmJtUqSehosRrj43Wr+yrOiu+iTbSKjYzvASEZzhvHoD8EPkXlZ
         DEUg==
X-Gm-Message-State: AOAM533uKzix8ChVz+v++m3ZuEuJmAgCt1FoTQCAkswc1KiS7t1pakIa
        f+7sRp5lv/IbV0vjIrflf20=
X-Google-Smtp-Source: ABdhPJyJejfVoRR57gRpqlUDaQG9CRRc3q/Oi9iZs8AgVfsxZxxUKE/ThNNdlax5WFCjqUSnLztCqA==
X-Received: by 2002:a65:6c0d:0:b0:364:ae2e:9708 with SMTP id y13-20020a656c0d000000b00364ae2e9708mr11734107pgu.189.1645325210135;
        Sat, 19 Feb 2022 18:46:50 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:49 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] iio: potentiometer: Add device specific read_raw function
Date:   Sun, 20 Feb 2022 08:16:30 +0530
Message-Id: <20220220024632.4183-6-jagathjog1996@gmail.com>
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

Added function pointer in the device specific structure to
call the appropriate device read_raw function, so that the
other type of devices with different read method can be
handled.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 34 ++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 3b86a4106277..1d6175dc4319 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -31,6 +31,8 @@ struct ds1803_cfg {
 	int kohms;
 	const struct iio_chan_spec *channels;
 	u8 num_channels;
+	int (*read)(struct iio_dev *indio_dev,
+		    struct iio_chan_spec const *chan, int *val);
 };
 
 struct ds1803_data {
@@ -54,16 +56,35 @@ static const struct iio_chan_spec ds1803_channels[] = {
 	DS1803_CHANNEL(1, DS1803_WIPER_1),
 };
 
+static int ds1803_read(struct iio_dev *indio_dev,
+		       struct iio_chan_spec const *chan,
+		       int *val)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 result[ARRAY_SIZE(ds1803_channels)];
+
+	ret = i2c_master_recv(data->client, result, indio_dev->num_channels);
+	if (ret < 0)
+		return ret;
+
+	*val = result[chan->channel];
+	return ret;
+}
+
 static const struct ds1803_cfg ds1803_cfg[] = {
 	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
 			 .channels = ds1803_channels,
-			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+			 .num_channels = ARRAY_SIZE(ds1803_channels),
+			 .read = ds1803_read },
 	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
 			 .channels = ds1803_channels,
-			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+			 .num_channels = ARRAY_SIZE(ds1803_channels),
+			 .read = ds1803_read },
 	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
 			 .channels = ds1803_channels,
-			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+			 .num_channels = ARRAY_SIZE(ds1803_channels),
+			 .read = ds1803_read },
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -71,20 +92,15 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
-	int pot = chan->channel;
 	int ret;
-	u8 result[ARRAY_SIZE(ds1803_channels)];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_master_recv(data->client, result,
-				      indio_dev->num_channels);
+		ret = data->cfg->read(indio_dev, chan, val);
 		if (ret < 0)
 			return ret;
 
-		*val = result[pot];
 		return IIO_VAL_INT;
-
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
 		*val2 = data->cfg->avail[2]; /* Max wiper position */
-- 
2.17.1

