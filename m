Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51058206A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiG0Gtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiG0Gt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:49:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A86147BB3;
        Tue, 26 Jul 2022 23:46:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w7so15338922ply.12;
        Tue, 26 Jul 2022 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/y/NGsYBEyTIfNWZk+cf407tuuEI0WUq+xtTfiUgps=;
        b=iFbW8yvgdiL9TcUyZFCEDTsa17t5tOrJKO9WdNS7PYhQPeG2K4q5ZlzrUJsdDGOIyZ
         FYLH9p5Q9u4yXunFtHGJc89/5PyGHf+qkUYTowBvHDT9fzlojgUG6Yn2civJBbVAJOV8
         MfybykCPqP06OGGO5A4b+q0oLh9LdscvPrLHBfMxPX0xdzc6AUyLk3wnLgWz2GN1wRv9
         B34MgMEHnJ0OXsGcRS9DipBN6pvA2exLlFo4mZBTTeSZToc0+a9S8I5kbqGO2UekggHg
         0GKADxM8/KAm1Wg9tFoT+dmRl4N628e32HoXQCLBROmrNpZ4vZjhGHGNXTV1Y/B/obOR
         TsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/y/NGsYBEyTIfNWZk+cf407tuuEI0WUq+xtTfiUgps=;
        b=fXtrZTieZL+sH1RlG1hunm3mAZE/nRH8uS5VYfEgsa17UtYUKx7Ud4q+OjISb52mid
         etDU+gk+XdGNAONMs8QwBnwbITozRHbjXsF+HtGKo7jisW0iY177Q2+ja2HW16CoqFhq
         Q/C8a80Gcfn68lx2VKmHFmAvm2t+Qts1ZQJVxWVBLZ7x7Fe9HZ6XEv6zE2UuTMB2ftZ+
         KOkNj1Rvt3aKUp/e6Yf2kq42n2oqCPqri3IZfdy5OVWxIsDuD8INPROdIz7x3oDJyIHj
         BMR7PmE216knP9TZZsY5924qXleMmx687p4f1afHrgB4YtL4gn6MKYJ2iCp4Q7y3+L1+
         GKkA==
X-Gm-Message-State: AJIora8GO1tHALwnrVtlcrX18AGk/88kNmaBCHHBHtvdkA2mQyRUiJn0
        CbfOjbywCI+IfYpLEjRfbtQ=
X-Google-Smtp-Source: AGRyM1vLhD8q/yparTYLclk5jUsBDeJwr6U//vyCS7QRBOpPejVocjbqDmk/0BmFMC09bvo3DcA5Ng==
X-Received: by 2002:a17:90b:4b81:b0:1ef:cd2c:bf2e with SMTP id lr1-20020a17090b4b8100b001efcd2cbf2emr2842594pjb.137.1658904395569;
        Tue, 26 Jul 2022 23:46:35 -0700 (PDT)
Received: from potin-quanta.. (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b0016bf5557690sm12964882plg.4.2022.07.26.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:46:34 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 1/1] iio: humidity: hdc100x: add manufacturer and device ID cehck
Date:   Wed, 27 Jul 2022 14:44:15 +0800
Message-Id: <20220727064415.940690-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.34.1
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
LINK: [v1] https://lore.kernel.org/all/20220722172035.44977-1-potin.lai.pt@gmail.com/
                                                           
changes v1 --> v2:                       
- fix typo in commit message           
- change to use probe_new
- use device_get_match_data instead of i2c_of_match_device
---
 drivers/iio/humidity/hdc100x.c | 78 ++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4c..8c69b4a610c4f 100644
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
@@ -351,8 +368,38 @@ static const struct iio_info hdc100x_info = {
 	.attrs = &hdc100x_attribute_group,
 };
 
-static int hdc100x_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
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
+	const struct of_device_id *match;
+	struct hdc100x_chip_data *data;
+	int mfr_id, dev_id;
+
+	data = device_get_match_data(&client->dev);
+	if (data) {
+		if (!data->support_mfr_check)
+			return true;
+	}
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
+static int hdc100x_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct hdc100x_data *data;
@@ -362,6 +409,9 @@ static int hdc100x_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
 
+	if (!is_valid_hdc100x(client))
+		return -EOPNOTSUPP;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -397,22 +447,22 @@ static int hdc100x_probe(struct i2c_client *client,
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
@@ -422,7 +472,7 @@ static struct i2c_driver hdc100x_driver = {
 		.name	= "hdc100x",
 		.of_match_table = hdc100x_dt_ids,
 	},
-	.probe = hdc100x_probe,
+	.probe_new = hdc100x_probe,
 	.id_table = hdc100x_id,
 };
 module_i2c_driver(hdc100x_driver);
-- 
2.31.1

