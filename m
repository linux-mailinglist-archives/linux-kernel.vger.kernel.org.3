Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3085858362C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiG1BMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1BME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:12:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BDB3134F;
        Wed, 27 Jul 2022 18:12:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d3so483007pls.4;
        Wed, 27 Jul 2022 18:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9+m39qpfDk/Jz5JojeONM6iXLnZUrRI7Za8g7a2MjA=;
        b=YnUAKpUwr6Z0hgClMKu/z6gzuLd2HBzBV74KpUUfhItEXPghvWt2bQV0US4N6hYI3I
         5exC2Hf0DXL7jPYWOWE/4oF+cKcfdLF7zIcmqJrZsEJV3l14mXKMQrEoydw/RBipfmjD
         yypu1wbl0DelATYZCqWMGZ5buPDS4AThMF9OQomt4AbF3M8ald5jUgiJfi6MtPvtkv37
         msE4qVe2oGcm94ygJfi/SXKxPbQNNNVrT52INPVXGD0G3VcN3yWEvrpil1/hX0LBlg5j
         MrfnGOjaUvrli4KhYSLoO9nBQc5SACnB/odrJ1wGjeCydL7o/d+T1U1FlUicGliIQcFN
         hzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9+m39qpfDk/Jz5JojeONM6iXLnZUrRI7Za8g7a2MjA=;
        b=sYsZCzZTB4juBTDmWrH5bWlYLdGFgJ43MMyTP1uMH1wivggpmfqBbOxR2FEi9prRST
         0e+gbEPvh4LDR7veNOqqdBrQW6+lNHB7zt61g9XWDT9LPhZENFEPLaduEgtp0JrO+Csm
         gIUokFyqXfJIFTf4LmLrvoNJgKJKnwmgiavU48jzbTveQEFcWYlTGiz/hLkPSOIcf+Px
         mZhFpzfsOMbF3PUYxXGOHZax+pptcUN26gKIrabZXV1l/idAx3YXXj88rYj9ARjM4qKP
         dOqnzBV+PA/J9dmN6rSwRGjNzV6KYPAOLMMao7g66K2107WXnKVbZHkSju9WTI7ZpWmr
         Wkjg==
X-Gm-Message-State: AJIora82irl9LVIToS6tL4wioonzSIYnRm3VZwQB0S8yxM5T5zqAJ0Ff
        Sead+N7osYMUKuVUTXYmC8n0RQrHXvI2QQ==
X-Google-Smtp-Source: AGRyM1uyHj9EthnZvg5Fhnn4IYVAr8XGvk8wF6m1uPtl9tyYnlhwKWAyK0jM9dD3AcisXkE275UHBw==
X-Received: by 2002:a17:902:6bcc:b0:16d:17db:3374 with SMTP id m12-20020a1709026bcc00b0016d17db3374mr24798082plt.101.1658970722825;
        Wed, 27 Jul 2022 18:12:02 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id x194-20020a6286cb000000b0052ad49292f0sm14526215pfd.48.2022.07.27.18.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 18:12:02 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 2/2] iio: humidity: hdc100x: add manufacturer and device ID check
Date:   Thu, 28 Jul 2022 00:34:17 +0000
Message-Id: <20220728003417.3083353-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
References: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
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
 drivers/iio/humidity/hdc100x.c | 69 ++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 0d514818635cb..be1244577921d 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -34,7 +34,25 @@
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
+	const struct hdc100x_chip_data *chip_data;
 	struct i2c_client *client;
 	struct mutex lock;
 	u16 config;
@@ -351,8 +369,32 @@ static const struct iio_info hdc100x_info = {
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
+	int mfr_id, dev_id;
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
+	const struct hdc100x_chip_data *chip_data;
 	struct iio_dev *indio_dev;
 	struct hdc100x_data *data;
 	int ret;
@@ -361,6 +403,10 @@ static int hdc100x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
 
+	chip_data = device_get_match_data(&client->dev);
+	if (chip_data->support_mfr_check && !is_valid_hdc100x(client))
+		return -EINVAL;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -368,6 +414,7 @@ static int hdc100x_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->chip_data = chip_data;
 	mutex_init(&data->lock);
 
 	indio_dev->name = dev_name(&client->dev);
@@ -396,22 +443,22 @@ static int hdc100x_probe(struct i2c_client *client)
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

