Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6D584000
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiG1NcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiG1NcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:32:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD452FCE;
        Thu, 28 Jul 2022 06:32:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id o12so1947380pfp.5;
        Thu, 28 Jul 2022 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMv9KlIa0pFgExAgCxphjWJ/W44z6y3JYucXOnlse+8=;
        b=GiuVWSnFmvnh0lbRvy/eIzxaWGkIt3vYa/XBOGeNxWoS8K0WsJmPd5DJZALJ+jnYCu
         gOzPHPkPFMhu9B9NuFIJnPvyY+Ozh+nDS/uUKGUXrX6201Mrl2qkkRcUoaAM54yE6D3/
         Cn++8S6WcAAT8ARHz2In1ILxGCn1RHyRBWhTbVPRtURipA/KeKN5W10ZqAMORAQUDBvR
         hZhx5fj0kjlQLDjUdrQGhYVdcaH4jtl088Ul6504hq5269toQ8MFQuPbH8cUMkblfUn/
         /myz5vvQbyN9iYG0RE+sjxfCzQebDOiZoNchIc71xDFU+v/lrXVaFOyUV6nYYmaVjxWP
         FFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMv9KlIa0pFgExAgCxphjWJ/W44z6y3JYucXOnlse+8=;
        b=jWVCx4OYCQ0Xj15k8/gWtND0wg5DgYewkV+hVkr3X3Z+P7559A4jKYSbU61X2CDyr/
         GDzespzzsqBtNRFAapisuViNM7e+Pg9uGQG9uWdR1ULmN3bCalFoxmtGF5r6Uuxyr0WM
         lUvtXOiSweLMgTsacrVJjURZh4hFpHnWvgFh6+sbhykgAepruj5dkfKqg0D1waOayLKA
         nIhMWcC04IS52ljM62k4SW5mZUi3544pcbXxKi+Y6CwJPriIe7OVFWEB2oMzWLmJWUsv
         ACzT/WruG5InsXUi7FAJfZtk5LeQHZbSeXr2FgqkySjwHLX4bABVZs7jHXbDsGddA1tc
         0Xqg==
X-Gm-Message-State: AJIora/h/hW8Quf81/1OHBQNOXpcY6Nfmdlyei7KMxtco30DVrdrNRMi
        H50R0LFMVlPk2cmE926QncE=
X-Google-Smtp-Source: AGRyM1t5tZrDrBCpShCUQY/z8SGnrUqSlYqy8Cm0PDxJdDp2NBn1uKZCU+3MsZDtazPX10S0SsenPQ==
X-Received: by 2002:a63:5650:0:b0:41a:dfa4:bdee with SMTP id g16-20020a635650000000b0041adfa4bdeemr19709607pgm.515.1659015131210;
        Thu, 28 Jul 2022 06:32:11 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id u188-20020a6379c5000000b00419b128cf98sm928474pgc.54.2022.07.28.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:32:10 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and device ID check
Date:   Thu, 28 Jul 2022 12:54:35 +0000
Message-Id: <20220728125435.3336618-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
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
 drivers/iio/humidity/hdc100x.c | 67 ++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 0d514818635cb..31f18cc1cf63c 100644
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
@@ -351,8 +368,32 @@ static const struct iio_info hdc100x_info = {
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
@@ -361,6 +402,10 @@ static int hdc100x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
 
+	chip_data = device_get_match_data(&client->dev);
+	if (chip_data->support_mfr_check && !is_valid_hdc100x(client))
+		return -EINVAL;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -396,22 +441,22 @@ static int hdc100x_probe(struct i2c_client *client)
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

