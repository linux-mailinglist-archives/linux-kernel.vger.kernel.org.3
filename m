Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF04C18BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbiBWQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242893AbiBWQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482E58E54;
        Wed, 23 Feb 2022 08:35:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so3301667pja.1;
        Wed, 23 Feb 2022 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=65Wdm90Autv7h+ovWGggxz9JvLLtxF54G/7vj1OKLTE=;
        b=ludn/iw7TO8EAl54NsS1kxVVqwipjy6pAT/ddqVN6qCbqk1FkGSkesDMkug+YJv3ik
         bnXQ7eB5ccJAVDQMhDYGgh4wo/ByoDXp2OUDNXNEvQ4bRCN5Hqo7G3bZ9KxaKQMocyQp
         YnVMrCMMivFOpHORmGIVITQm+HUpphc+9wIjogok6JfhVzO54Wxvg1tSESG8/XdQOYJ+
         0A+KjGK+2tmB24M6ydjI64oy6ax5+UT7xGlNU/OZ/PFEr+jdUnSuoTStMPgLDf226vq9
         kOovMFVX8IFNJmHBcD3LpX8tAmLJkND5NTK2YeAfNDWlTWWAA6zZABFAq0ECtJngNqPP
         T4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=65Wdm90Autv7h+ovWGggxz9JvLLtxF54G/7vj1OKLTE=;
        b=24qMHFNxTltiPnW/P90Uq+hJzg54TuEivOEzFAF+7sSlxb6WgDd2QD8MlQxLzADXNF
         aRXpdvsKspp54IMvEL+T9rhLNZrGRA4XtrngT60zue4rx+v1BpQPY+ZkJD5d88ZSe3wJ
         nZlBU2h5eX9F6BY4UZtBERyLeX5LLztabhLbA7kb1NXFc7DGXJRIZ9r+FstkpZlM8ARv
         oqy+x2RS///eb1crZT9zqdOS2SW5vhUG5K0h/CBkLH8qSNZkcXvlkmKr3oowETp+p1JD
         FEsizDLg4xu5FtEjnYErePpDvoySXqSfMObLxX2yTDyY9DJxUZKtNzlWFh6HeeqCmI/J
         aqlA==
X-Gm-Message-State: AOAM532tACLz3gWEJklqtcAjJ+zU6CaJ92O5My7zpMC9YI+ZK5F5qMd5
        Olj4kE3KikhMXdrQ3/KUCMp7nYn+g+uvOpwo
X-Google-Smtp-Source: ABdhPJzsOcHiFQxJLP4cBOYmIcNRg7OFleHA4BFGFuTixIEdRscmV8unU9RMmLnzQdlB/O5EGz5FNw==
X-Received: by 2002:a17:90b:3b42:b0:1b9:b5d8:ead2 with SMTP id ot2-20020a17090b3b4200b001b9b5d8ead2mr10057529pjb.149.1645634148546;
        Wed, 23 Feb 2022 08:35:48 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:48 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/7] iio: potentiometer: Add device specific read_raw function
Date:   Wed, 23 Feb 2022 22:05:23 +0530
Message-Id: <20220223163525.13399-6-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
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
 drivers/iio/potentiometer/ds1803.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index aeb74ee46fbc..878188351f8f 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -32,6 +32,8 @@ struct ds1803_cfg {
 	int kohms;
 	const struct iio_chan_spec *channels;
 	u8 num_channels;
+	int (*read)(struct iio_dev *indio_dev,
+		    struct iio_chan_spec const *chan, int *val);
 };
 
 struct ds1803_data {
@@ -55,6 +57,22 @@ static const struct iio_chan_spec ds1803_channels[] = {
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
 	[DS1803_010] = {
 	  .wipers = 2,
@@ -62,6 +80,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
 	  .kohms =  10,
 	  .channels = ds1803_channels,
 	  .num_channels = ARRAY_SIZE(ds1803_channels),
+	  .read = ds1803_read,
 	},
 	[DS1803_050] = {
 	  .wipers = 2,
@@ -69,6 +88,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
 	  .kohms =  50,
 	  .channels = ds1803_channels,
 	  .num_channels = ARRAY_SIZE(ds1803_channels),
+	  .read = ds1803_read,
 	},
 	[DS1803_100] = {
 	  .wipers = 2,
@@ -76,6 +96,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
 	  .kohms = 100,
 	  .channels = ds1803_channels,
 	  .num_channels = ARRAY_SIZE(ds1803_channels),
+	  .read = ds1803_read,
 	},
 };
 
@@ -84,20 +105,15 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
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

