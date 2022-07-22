Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9DD57E55F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiGVRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiGVRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:22:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D165D64;
        Fri, 22 Jul 2022 10:22:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so8721229pjq.4;
        Fri, 22 Jul 2022 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeiIlgvumKK5S0+PlFlhTMVYAJ0Lvpf2jQ1NG55lcEY=;
        b=IcL1/yuk0eNs+nlfp8kWoKt6OGOm/JV1gT/3grJG+GvdWS6RJpqrH2Ut4HlGhz3vJM
         M1d97/cuDJPWvkbaoEWNN6dRtUU64tRNPeQgZfI0UZRhSj82mmG671hnfX9BTNVaa0HK
         TLsExZf5TsmWSDL5z3FIuo/AqmWqhMq9362l3CAZrRho01+E+qvhDgSSYTe6wMY3D9Bv
         MbYBL2qiUAtJWgymLRA9PUMGlcW69sGZrTkJORrmR2fGoXL+/QWj4RUPGlqsvmkphGB2
         8CHBrQlwItqZsNLpQr8VTL7k/2I3/4+zWly+FVWwRAPRE4On1nsbxuRTZaZxhzIsnuXW
         uuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeiIlgvumKK5S0+PlFlhTMVYAJ0Lvpf2jQ1NG55lcEY=;
        b=BkVXORX4eFNpgSIX8BixkQ0mWPIgWU2zBD4kprzavY23xxhzoPqlyYUvkljxoZbIiA
         aZu8hYZoHiRTYdKPBzhHISTBllYLzwJ3HJkMdr3n0KmOjkIoj2T5V+X15gcBiu1AZ+si
         wLZ9bv6ugm1iQG3chjDTYjbn0WktfewxddkoDVlP6qNST/sgCEkeauS1Hde/dlCRDnvw
         9FgUXVa2vgRtzPTHdGHtHQLORmxs2TntcuAzQOFZ2wu+gQj69pbfmdDdzC4+k5lE1IcU
         F54LV/6ArXgdkyA0suGCSKpzVKC9j3E3vlYlbJ78tU0fI2IR2NFi0FlZC/120MxpOVh8
         UU1A==
X-Gm-Message-State: AJIora/2JPZSBtPPCl2WmGN4E9HTD7zNM9GtDVhdgsT64BlPEVEOz0Qm
        sz4gD8CSZenohypIyp+4sOM=
X-Google-Smtp-Source: AGRyM1s+gkXYyczPUE2+QAKLCqqm5OhlVQZ1bdrCzaAps2IrdGgS1DxAKjzsy/3Otg0cJ4ZCgLnYdg==
X-Received: by 2002:a17:90a:5513:b0:1f1:c93c:7ad8 with SMTP id b19-20020a17090a551300b001f1c93c7ad8mr18163136pji.88.1658510566454;
        Fri, 22 Jul 2022 10:22:46 -0700 (PDT)
Received: from potin-quanta.. (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id bf17-20020a656d11000000b003fd4831e6fesm3625505pgb.70.2022.07.22.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:22:45 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iio: humidity: hdc100x: add manufacturer and device id cehck
Date:   Sat, 23 Jul 2022 01:20:34 +0800
Message-Id: <20220722172035.44977-1-potin.lai.pt@gmail.com>
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

Add manufacturer and device id checking during probe, and Skip the
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
 drivers/iio/humidity/hdc100x.c | 87 +++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4..b8ae8d2ae7f0 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -34,6 +34,32 @@
 #define HDC100X_REG_CONFIG_ACQ_MODE		BIT(12)
 #define HDC100X_REG_CONFIG_HEATER_EN		BIT(13)
 
+#define HDC100X_REG_MFR_ID	0xFE
+#define HDC100X_REG_DEV_ID	0xFF
+
+#define HDC100X_MFR_ID	0x5449
+
+enum {
+	HDC100X,
+	HDC1000,
+	HDC1008,
+	HDC1010,
+	HDC1050,
+	HDC1080
+};
+
+struct hdc100x_of_data {
+	bool support_mfr_check;
+};
+
+static const struct hdc100x_of_data hdc100x_of_data = {
+	.support_mfr_check	= true,
+};
+
+static const struct hdc100x_of_data hdc1008_of_data = {
+	.support_mfr_check	= false,
+};
+
 struct hdc100x_data {
 	struct i2c_client *client;
 	struct mutex lock;
@@ -351,6 +377,42 @@ static const struct iio_info hdc100x_info = {
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
+static const struct of_device_id hdc100x_dt_ids[];
+static bool is_valid_hdc100x(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	const struct of_device_id *match;
+	struct hdc100x_of_data *of_data;
+	int mfr_id, dev_id;
+
+	match = i2c_of_match_device(hdc100x_dt_ids, client);
+
+	if (match) {
+		of_data = (struct hdc100x_of_data *)match->data;
+		if (!of_data->support_mfr_check)
+			return true;
+	} else if (id->driver_data == HDC1008)
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
 static int hdc100x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -362,6 +424,9 @@ static int hdc100x_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
 
+	if (!is_valid_hdc100x(client, id))
+		return -EOPNOTSUPP;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -397,22 +462,22 @@ static int hdc100x_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id hdc100x_id[] = {
-	{ "hdc100x", 0 },
-	{ "hdc1000", 0 },
-	{ "hdc1008", 0 },
-	{ "hdc1010", 0 },
-	{ "hdc1050", 0 },
-	{ "hdc1080", 0 },
+	{ "hdc100X", HDC100X },
+	{ "hdc1000", HDC1000 },
+	{ "hdc1008", HDC1008 },
+	{ "hdc1010", HDC1010 },
+	{ "hdc1050", HDC1050 },
+	{ "hdc1080", HDC1080 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hdc100x_id);
 
 static const struct of_device_id hdc100x_dt_ids[] = {
-	{ .compatible = "ti,hdc1000" },
-	{ .compatible = "ti,hdc1008" },
-	{ .compatible = "ti,hdc1010" },
-	{ .compatible = "ti,hdc1050" },
-	{ .compatible = "ti,hdc1080" },
+	{ .compatible = "ti,hdc1000", .data = &hdc100x_of_data },
+	{ .compatible = "ti,hdc1008", .data = &hdc1008_of_data },
+	{ .compatible = "ti,hdc1010", .data = &hdc100x_of_data },
+	{ .compatible = "ti,hdc1050", .data = &hdc100x_of_data },
+	{ .compatible = "ti,hdc1080", .data = &hdc100x_of_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
-- 
2.34.1

