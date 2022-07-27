Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4C582F14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiG0RUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbiG0RSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:18:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72B79EFB;
        Wed, 27 Jul 2022 09:43:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso2802054pjo.1;
        Wed, 27 Jul 2022 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkXduqCunQer7KImaNq80YYtkZR4bE5GC9eBRnWBSEA=;
        b=JB3Hr5Ww5oTt+YbeAwATLAtLz/SL3TcVPd5yC9sRf7LlclWytJmpYtTVaqoCh0AXQZ
         PRPQpFToY8NbD+c12s4x5beVu0hs8FZwCf7XiK5OwgVxoMg1oe4XwYkv3TOGpul2KPAT
         wTTeIzb7v8g7qeg4diTRmx2vPygGpaV3E+Sz+luLQesCFSv/NUQ/KZKohaBKNcP6lx96
         /F/RYkUPp9WSHjDXOlzUysSBM3nxYY7vWiSvyhgchNeZVluz0zNBihDUh437CF6KKVlj
         p8NvznXkamqfu1eTJ12PBryiCiuyY5qTQ3ZEnXBTFJj2uAPSK5x5PZDrbmpMF7Y0gvZ8
         Uxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkXduqCunQer7KImaNq80YYtkZR4bE5GC9eBRnWBSEA=;
        b=d1z8PZDJbEBIfKbQObEUt3EgrKkn3xLiny2+AD8VPAU+VWgW/px/3c2s4ruFVMUGOu
         rgwKq1ZtCdu+8r1BgVp0l7DEQRS2mHxNpewKv0hrEIhILtZWnaD38hHt2YIXnrqe1Lor
         GJxf+j/SgyFYwF05r/9nSu4egWXcC7gFto+6fS5DqdSyrhl5L3HI8JhxKE6FLPlMhYUN
         y+Lzuq0H5CNRVOvQbl26IyYkP2YeH6rhU6GiXLRMljh7fPa3bTEMTVQn8bq9824VHr1W
         UwNPIIcJnfgxnHeVIbhtByQbhdR0fpLNkQvzs7IUsPmsHtvSl68r7L+pR/55AaPKGGUA
         VnOQ==
X-Gm-Message-State: AJIora8AtFcWIktnYKppW66J2jAePcQFsYGR4eIjHOLrfEAY4Z3ZqM2I
        s0a47NXiB2C8swIQV7BbAcJvFMfmG9hg7A==
X-Google-Smtp-Source: AGRyM1shETd1iWd+SaDgQAdVjf8pzBmIgHUJUk2sUIRw1F9nIxS5amEDqpIQxrzlH9/ZDbfhLh3TWg==
X-Received: by 2002:a17:902:b612:b0:16c:d98d:638 with SMTP id b18-20020a170902b61200b0016cd98d0638mr21696533pls.38.1658940235720;
        Wed, 27 Jul 2022 09:43:55 -0700 (PDT)
Received: from potin-quanta.. (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b001ef3f85d1aasm2030480pjc.9.2022.07.27.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:43:55 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v3 2/2] iio: humidity: hdc100x: add manufacturer and device ID check
Date:   Thu, 28 Jul 2022 00:41:33 +0800
Message-Id: <20220727164133.973930-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164133.973930-1-potin.lai.pt@gmail.com>
References: <20220727164133.973930-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add manufacturer and device ID checking during probe, and skip the
checking if chip model not supported.

Supported:
- HDC1000
- HDC1010
- HDC1050
- HDC1080

Not supported:
- HDC1008

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 70 ++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 0d514818635cb..593a9d3caf229 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -34,6 +34,23 @@
 #define HDC100X_REG_CONFIG_ACQ_MODE		BIT(12)
 #define HDC100X_REG_CONFIG_HEATER_EN		BIT(13)
 
+#define HDC100X_REG_MFR_ID	0xFE
+#define HDC100X_REG_DEV_ID	0xFF
+
+#define HDC100X_MFR_ID	0x5449
+
+struct hdc100x_chip_data {
+	bool support_mfr_check;
+};
+
+static const struct hdc100x_chip_data hdc100x_chip_data = {
+	.support_mfr_check	= true,
+};
+
+static const struct hdc100x_chip_data hdc1008_chip_data = {
+	.support_mfr_check	= false,
+};
+
 struct hdc100x_data {
 	struct i2c_client *client;
 	struct mutex lock;
@@ -351,6 +368,34 @@ static const struct iio_info hdc100x_info = {
 	.attrs = &hdc100x_attribute_group,
 };
 
+static int hdc100x_read_mfr_id(struct i2c_client *client)
+{
+	return i2c_smbus_read_word_swapped(client, HDC100X_REG_MFR_ID);
+}
+
+static int hdc100x_read_dev_id(struct i2c_client *client)
+{
+	return i2c_smbus_read_word_swapped(client, HDC100X_REG_DEV_ID);
+}
+
+static bool is_valid_hdc100x(struct i2c_client *client)
+{
+	const struct hdc100x_chip_data *data;
+	int mfr_id, dev_id;
+
+	data = device_get_match_data(&client->dev);
+	if (!data->support_mfr_check)
+		return true;
+
+	mfr_id = hdc100x_read_mfr_id(client);
+	dev_id = hdc100x_read_dev_id(client);
+	if (mfr_id == HDC100X_MFR_ID &&
+	   (dev_id == 0x1000 || dev_id == 0x1050))
+		return true;
+
+	return false;
+}
+
 static int hdc100x_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -361,6 +406,9 @@ static int hdc100x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
 
+	if (!is_valid_hdc100x(client))
+		return -EINVAL;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -396,22 +444,22 @@ static int hdc100x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hdc100x_id[] = {
-	{ "hdc100x", 0 },
-	{ "hdc1000", 0 },
-	{ "hdc1008", 0 },
-	{ "hdc1010", 0 },
-	{ "hdc1050", 0 },
-	{ "hdc1080", 0 },
+	{ "hdc100X", (kernel_ulong_t)&hdc100x_chip_data },
+	{ "hdc1000", (kernel_ulong_t)&hdc100x_chip_data },
+	{ "hdc1008", (kernel_ulong_t)&hdc1008_chip_data },
+	{ "hdc1010", (kernel_ulong_t)&hdc100x_chip_data },
+	{ "hdc1050", (kernel_ulong_t)&hdc100x_chip_data },
+	{ "hdc1080", (kernel_ulong_t)&hdc100x_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hdc100x_id);
 
 static const struct of_device_id hdc100x_dt_ids[] = {
-	{ .compatible = "ti,hdc1000" },
-	{ .compatible = "ti,hdc1008" },
-	{ .compatible = "ti,hdc1010" },
-	{ .compatible = "ti,hdc1050" },
-	{ .compatible = "ti,hdc1080" },
+	{ .compatible = "ti,hdc1000", .data = &hdc100x_chip_data },
+	{ .compatible = "ti,hdc1008", .data = &hdc1008_chip_data },
+	{ .compatible = "ti,hdc1010", .data = &hdc100x_chip_data },
+	{ .compatible = "ti,hdc1050", .data = &hdc100x_chip_data },
+	{ .compatible = "ti,hdc1080", .data = &hdc100x_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
-- 
2.31.1

