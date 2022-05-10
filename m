Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C55225B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiEJUns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiEJUni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3158829ED0B;
        Tue, 10 May 2022 13:43:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so112737lfg.7;
        Tue, 10 May 2022 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YT/2zj6suok1QDPY2bNDHH8fszKu/6jV8dkbTQl6UTo=;
        b=qLjQHVz7SB6ayG/YauYW+iRkvnUbR1G3ZSxQTY3sDPoHZXzrYzRghU0Vbpq4+rTKMa
         /dKKmGAvCtf6JnOomM5ZxTVgOSdRk5nE7Aurh70Xeqdr1jt+0qvQwOGJxODrd1/9zICl
         2RugQBpjY2JN8DKkIVtIPOsoOsFpQhwyI64thQW8OIX9s35UcxZOQVz7O2Inqw35bNXL
         GKzMFcN+R5wjwl9JFIWcyWJ5t9MAoB8Dwrh0C0T3z0+Ea6UE8oTK/AyIUFu6Ol+qV5aA
         AfQ4lO0MaB/C5BZxnJai8lLEnhGTorzpk2zM9f8GNIzQSGL6tz2cyNrUEyd+hTVSTu7i
         3eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YT/2zj6suok1QDPY2bNDHH8fszKu/6jV8dkbTQl6UTo=;
        b=xp8RlcDl0ArEfovlC/Kwq9rcK0IIJYl87Hrr6DvzhrVUJi1Ziu5bdRtWjKu3EaeGSQ
         R8E/T4/NiCugBELgKDss4DCWkAna+dmyV32In+jikx0zBcVshjogFpd6RQn9o7Xn49eV
         XiKOgdECxYCdgE/JWLeUaWl+lmpfSzkPbkezfu3WIC/z31bNl1Zu1PpIGcyfnqPAgckP
         xvrEh1gYE09TrII5E4rLM6+HQsTQZB+L69GnZiUNiH7K1hCoRvFVKJJgGCv5tBpH7FIP
         AgS6Lpn2Qrkbc797MjTFQ6JltugGVRhWJA5/xZ3t/q5IZGv7OHworPWfiwafVef+i+Io
         huNQ==
X-Gm-Message-State: AOAM533GOLY+tNWLfRXVp6nHX7qmNgdBEx8yrdLtQq6mc0zCsjEtzgtv
        gKzt6AgyMwe5bwWD1jyP21K4r/P0wtc=
X-Google-Smtp-Source: ABdhPJyk4e6hgqMSDo7OtbvC1MxjCu5xhbhE59OA6EsLjixjjRU3Y9S90Cg1BgaOto5W62qaKYru6A==
X-Received: by 2002:ac2:5f84:0:b0:471:fd0f:a6e7 with SMTP id r4-20020ac25f84000000b00471fd0fa6e7mr17285738lfe.41.1652215414042;
        Tue, 10 May 2022 13:43:34 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b0047255d210f0sm12318lfz.31.2022.05.10.13.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:43:33 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/5] proximity: vl53l0x: Handle the VDD regulator
Date:   Tue, 10 May 2022 23:42:54 +0300
Message-Id: <20220510204256.8874-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510204256.8874-1-markuss.broks@gmail.com>
References: <20220510204256.8874-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the regulator supplying the VDD pin of VL53L0X.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 16f809c479cb..74aeb2548ef6 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -42,6 +42,7 @@
 struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
+	struct regulator *vdd_supply;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -187,10 +188,31 @@ static const struct iio_info vl53l0x_info = {
 	.read_raw = vl53l0x_read_raw,
 };
 
+static void vl53l0x_power_off(void *_data)
+{
+	struct vl53l0x_data *data = _data;
+
+	regulator_disable(data->vdd_supply);
+}
+
+static int vl53l0x_power_on(struct vl53l0x_data *data)
+{
+	int ret;
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret)
+		return ret;
+
+	usleep_range(3200, 5000);
+
+	return 0;
+}
+
 static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
+	int error;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -205,6 +227,21 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
+	data->vdd_supply = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
+	if (error)
+		return dev_err_probe(&client->dev, error,
+				     "Failed to install poweroff action\n");
+
+	error = vl53l0x_power_on(data);
+	if (error)
+		return dev_err_probe(&client->dev, error,
+				     "Failed to power on the chip\n");
+
 	indio_dev->name = "vl53l0x";
 	indio_dev->info = &vl53l0x_info;
 	indio_dev->channels = vl53l0x_channels;
-- 
2.35.1

