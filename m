Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C7523FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348379AbiEKVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348367AbiEKVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:48:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665563C70B;
        Wed, 11 May 2022 14:48:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so5863672lfb.3;
        Wed, 11 May 2022 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ch9koX2JfsEbf0kLPJgbDufXDAbUbg6Kpk+d6uErWA=;
        b=fwQ06umLfUwIkrFAgaUfU/GVG6IVp4m6m5fjhJBxP/nKzvlgb8WnaHd/BwE0y1f20k
         2qScdUbD3cVMKup1RI+1sl/DToj2l4SRO7EVCwGv1rjtr0BuoIfVlsLGt9AIfoyn1dCM
         paAayfdU+0v5CrB2d3AMZqBP6KV+Hp6+pw8Usds2rf604o9h8OzwB40T2PlhMgiZ4Tvn
         hb8MNxdmoQBZfUa83IYuJD+BZvNQWXNqD8VzRSu8IqNGxTHuS0dHpPbGX2vt3yAIqIe2
         2Vgv9qE58979QkFvjkzsqrGmyorlSPLJG0SMk43L3i+nH01nqrItxjlojz4+4p5JsMlx
         mkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ch9koX2JfsEbf0kLPJgbDufXDAbUbg6Kpk+d6uErWA=;
        b=A08N+3LT6gz91EUhFOF2tLSX+03sz3h3jCFZAyz1Q8QQSRl6tVtCC4Zwb67puWt6K8
         KTyUVgi8zD4YUzHzWHY0o0okG6zm/SjTYl32orWsTgsdYGqTGJ34ViH4j6KT2ut9WWF6
         UAsNbFt4/MitonrlNAniO3fCWM7s4cWsPDrl0mPoX7ULV//ODfuR3UNBBt4L6Eq2Imrb
         LpD3IlevVRaJCCkFC6XN93p81ZxBsY8cpVjkPIOX7OVH2TB0pI5AQVVIeUChgmf3imFd
         KqhYYQ14BAr3uxaSB/Jj7ooWwesQ/8vbBUVEUy+paOBmWV1/At7GZktAjOYgqpFfMPH/
         hHOA==
X-Gm-Message-State: AOAM532qXwdTp8Y/+7nnJlyJ2Qmz8oXvSS0UhsX90/Y5xtcps3CNaDsM
        5Yp/lwh/wYLRB1xFW96+UPFe1uiH5vw28w==
X-Google-Smtp-Source: ABdhPJz2b0cJ5q2w7qZIokN9SyTCOboNmFsOBoOJCId5h5/LZtXqKM5Ch7gJtMGk5IZquehFOu2IsQ==
X-Received: by 2002:a05:6512:39c1:b0:472:556e:b297 with SMTP id k1-20020a05651239c100b00472556eb297mr21527917lfu.564.1652305682710;
        Wed, 11 May 2022 14:48:02 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b0047255d211afsm458891lfr.222.2022.05.11.14.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:48:02 -0700 (PDT)
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
Subject: [PATCH v2 3/5] proximity: vl53l0x: Handle the VDD regulator
Date:   Thu, 12 May 2022 00:47:15 +0300
Message-Id: <20220511214718.50879-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511214718.50879-1-markuss.broks@gmail.com>
References: <20220511214718.50879-1-markuss.broks@gmail.com>
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
index ef2c063dfa1c..e65c4fcd32d6 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -42,6 +42,7 @@
 struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
+	struct regulator *vdd_supply;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -191,10 +192,31 @@ static const struct iio_info vl53l0x_info = {
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
@@ -209,6 +231,21 @@ static int vl53l0x_probe(struct i2c_client *client)
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
2.36.1

