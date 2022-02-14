Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719D4B405F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiBNDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:36:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiBNDgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:36:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B855BEB;
        Sun, 13 Feb 2022 19:36:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z17so9496403plb.9;
        Sun, 13 Feb 2022 19:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7KqLxqPXt/++zKfasndyL6p23tdrDEEEjd2RPr4XZo=;
        b=Pc7IxxDbPMy2UhDaeNT6VbKrKdAb8RyVUEzmuNZ+LoKtxXGF5Quz9RWZm8uv3JqQ/o
         xuK7wnKECOSpAO/KIt+8UPJjpXsc8FMHa11rkrhHl+ZWQhbDntA99DmKBtT+TWpxYV8o
         WLrwupk7DSZaCgltu+WtqclK5cogCElvYJ0n+tNR0ON7gpwmNnuhQS25TYlSz2CoPpku
         uDUE7cY7h0qGQxhq6nVWUI6lxJPPCSwG6F+pHDDRT5LscxJf6igszJrM/ynVL2pYeJNU
         ZCKSDe3e91iS/0Wdd5Ix004ap+ggZ4FRfNMDJfMXcSn5kkWqJRIhupn+Eh4Db5EZLgbi
         A59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7KqLxqPXt/++zKfasndyL6p23tdrDEEEjd2RPr4XZo=;
        b=WcZsgoCWQV8RNbENufSZjZH3whljPdN5RbbCciD5KeEPvGsh3Cb7EIKQdwBGNrfEia
         xUkTBwssXxcoOpxlCZIaGHpaFTVWuSqsCojV7UEBb+xXKd/7nU/Q/CTiWRl9HPo6XW7G
         CcTLxslIYY/l5j/5U7F34TF975xbg/c9DQCvA5hY4iQy2gxSxjlwV+4dcxgLXJiIyK+r
         wypNsN9hEAlOd/Qsc/xjTAmSkbHcMbaAdxk/PLWodEPsCZM3K31oecEHnTpwRuJF8ZKA
         M8W0bi6kqRvRQDkdjRWp2f3skWa7g5mcmj3gyHWhkxxe4Td99N5zA5GbWIHuWZkJ34+G
         jFLw==
X-Gm-Message-State: AOAM531s8+ZKhIDTjVutlNEYvkN3MK5/RmZH2gd5kX3zsI+SEFAJnF9c
        ZxomXS/h+pht29TYAJ6TaKQ=
X-Google-Smtp-Source: ABdhPJxFip/rAnmBpWGFq5IRDYYEHXGsve+3nLRSSiVFjg1Xq6Mu6k+N4QorJjdWtWg0Y0DwQc88VA==
X-Received: by 2002:a17:902:778b:: with SMTP id o11mr4796423pll.87.1644809790406;
        Sun, 13 Feb 2022 19:36:30 -0800 (PST)
Received: from localhost.localdomain ([27.7.103.158])
        by smtp.gmail.com with ESMTPSA id me14sm36012pjb.41.2022.02.13.19.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:36:30 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iio: potentiometer: Add available functionality
Date:   Mon, 14 Feb 2022 09:06:18 +0530
Message-Id: <20220214033620.4059-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214033620.4059-1-jagathjog1996@gmail.com>
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding available functionality for ds1803 driver which
will show the minimum, step and maximum values
it can accepts through sysfs entry.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 38 ++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 3481dd460525..bccb9ccac931 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -27,12 +27,13 @@ enum ds1803_type {
 
 struct ds1803_cfg {
 	int kohms;
+	int avail[3];
 };
 
 static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .kohms =  10, },
-	[DS1803_050] = { .kohms =  50, },
-	[DS1803_100] = { .kohms = 100, },
+	[DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
+	[DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
+	[DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
 };
 
 struct ds1803_data {
@@ -40,13 +41,14 @@ struct ds1803_data {
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
 
 static int ds1803_probe(struct i2c_client *client,
-- 
2.17.1

