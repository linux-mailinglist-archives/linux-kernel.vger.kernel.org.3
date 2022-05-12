Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38239525589
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiELTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357961AbiELTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:13:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784E02764DC;
        Thu, 12 May 2022 12:13:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u23so10797237lfc.1;
        Thu, 12 May 2022 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6hTyWxvALgSndQqmiLi+9G4p6MJh+4j+g2xm+AL/rQ=;
        b=PysoZzwNMfsEcuiter0OSCiPRt4Ho8EYePnl4pJqPmAonr4+tAlQcrGFBSFe7IeX4g
         aRFxmEnXrpO4NhWPqDWoZAvc4Xjkw6XlOpDuSZDQsJDZRF93R5tP6dFXsMtRc7GpNYlu
         l2fGDHCj/CgiiYE7Auez0HBUwzw3RHSCUafL0EJlhLcB8gYa6Z2I/S7jsRuAKWlQ8Afr
         ++1R8C7P99xDg1XA3uzKJwb7yt5YAChecZVuV1sRftSsKZp7nFfv4zY6y8DnRXWj7vLK
         lGPbktAjFQWSQPe0qSn6amEAhMhy43NGsTQ8ZAQdzACHgTUPrmxE2zDjdJeu/Neq/8uI
         +hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6hTyWxvALgSndQqmiLi+9G4p6MJh+4j+g2xm+AL/rQ=;
        b=IxgFnfK2n+QCKSPHQj4tZsXn1GKzCMkU81JPUSrFDCy8/Uo0lK8RxvMNJQvvvOuv/9
         va3FXJErRVDk+A2AcMCNb9TJu+jSB3O/NqrR3IGWyIhg6w1SPCeFOftmRZ53gASqGnmT
         nE4Xw8KKa6xZuBFKgbbv643/2Kjk96uIRE/fvPpTijKf8yT4nX/ePaEVMxH777u9OZA4
         NabHB6RU/pkFl71QvFGy/y2aBffD0NCRN0+rA0xCP5tKDMO4k5lnM4SFeytPHtWvlZNY
         fbWjzTNrE7bVtHQ6yqKEd5KfVbn+ModstSD3CoqlIGgagoZLYg/vjAmIuxr8F+6Jm4OK
         yZZg==
X-Gm-Message-State: AOAM531xIG2hffFUapAQmmnlS0vPelh0CztGJKEarrRQirJaRjoIKP6n
        8rSJ/JEzeEH9J1iKYy3gDaZSPqPWquEH7w==
X-Google-Smtp-Source: ABdhPJxezMskd742DMYln9aEmh78sXgfMEsMgpKa1dItrQ1qSxFU8SVH5RR7d57wBs+UShJjU8+DYQ==
X-Received: by 2002:a05:6512:332d:b0:472:9a2:6e27 with SMTP id l13-20020a056512332d00b0047209a26e27mr847024lfe.611.1652382831889;
        Thu, 12 May 2022 12:13:51 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b0047255d210f4sm62146lfg.35.2022.05.12.12.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:13:51 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
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
Subject: [PATCH v4 3/5] proximity: vl53l0x: Handle the VDD regulator
Date:   Thu, 12 May 2022 22:13:31 +0300
Message-Id: <20220512191334.61804-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512191334.61804-1-markuss.broks@gmail.com>
References: <20220512191334.61804-1-markuss.broks@gmail.com>
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
index 12a3e2eff464..8581a873919f 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -43,6 +43,7 @@
 struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
+	struct regulator *vdd_supply;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -192,10 +193,31 @@ static const struct iio_info vl53l0x_info = {
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
@@ -210,6 +232,21 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
+	data->vdd_supply = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	error = vl53l0x_power_on(data);
+	if (error)
+		return dev_err_probe(&client->dev, error,
+				     "Failed to power on the chip\n");
+
+	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
+	if (error)
+		return dev_err_probe(&client->dev, error,
+				     "Failed to install poweroff action\n");
+
 	indio_dev->name = "vl53l0x";
 	indio_dev->info = &vl53l0x_info;
 	indio_dev->channels = vl53l0x_channels;
-- 
2.36.1

