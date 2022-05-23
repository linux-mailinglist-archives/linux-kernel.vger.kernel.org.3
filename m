Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D0531732
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiEWSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiEWSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:18:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB37532C4;
        Mon, 23 May 2022 10:57:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so26857179lfo.10;
        Mon, 23 May 2022 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6hTyWxvALgSndQqmiLi+9G4p6MJh+4j+g2xm+AL/rQ=;
        b=Fu1TwoaH71RgsLqaTGIn/HgL6qa17UmpMWrT7+W1uGedTEO6N8eXEpuYqQUxBb+CwN
         rZZrB8FbohFtveKYHP9kDfVxOorwGzHB0F24zlHvpA/3tHZuZ9p+CadRMUsx2RwizC3I
         KBHiCcrqzjHd2FXzUNZbb0/DhRoXPIUxuRC1ADLxFblesPKPdIXAMX+SMxCKzrZ3K01R
         W2b79qIdMbAyYb7oix7yyZJ2SHou9ZVS4qKKz3bysqZxnYF2jRPSLFh7ipdvsGSxRaXo
         d1VvK72AY89uEfUTSLP7uDMsv3lNndDVblKqBO78AZvIGYjQfMcFAgCpRAP+1VdUJDdU
         tLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6hTyWxvALgSndQqmiLi+9G4p6MJh+4j+g2xm+AL/rQ=;
        b=aHtPUZRjbjDx9lLasX5PrMFxaXzvcnKNoPawRy1+eotJLlSHr8kBJVXJrIkH0LsHQp
         DKa/ZjXza9dNHhnVoo/OK5pHeoBs43OYPOaAkT8lIo9LMX2eMxA4bNB65L3NaM9tJxuO
         j1ktyTKB1L9A1Pl1DDsxSb+aL6285GETjdXWf0eT0Vd8BD/lRlqzFZXE1MfQoilhRHco
         Q6BYoWeAqB0Tqi8cqD1zo8SLMVAZiNu9R6vKfZndk49kG5mS6rwX8x8HhijpFNhD7S7w
         HY6GsPIdF64VVaqA6cyDqRuTRnkbMXyEIBEwzkw4WcORHAKVb2tyVnwVzGs/UOVP7WuF
         BFXQ==
X-Gm-Message-State: AOAM530beW2gd3sMQ9STnGBFLfP8kphRbMkcV03shlkGnCGFEXdCOWtn
        ct8oItquUZkN9p0UnwTNp5PGPrLG75GIeg==
X-Google-Smtp-Source: ABdhPJwlQfWKJMMo2GI0V8Kr9PKoZOkUjLp8pP3qdVXld1DvET00FoOeOJ6WqinAdDVAjjQKdQXQdw==
X-Received: by 2002:a19:5f13:0:b0:477:b3a2:30b8 with SMTP id t19-20020a195f13000000b00477b3a230b8mr17035659lfb.683.1653328476133;
        Mon, 23 May 2022 10:54:36 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b0047255d211f9sm2087743lfr.296.2022.05.23.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:54:35 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, jic23@kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/5] proximity: vl53l0x: Handle the VDD regulator
Date:   Mon, 23 May 2022 20:53:42 +0300
Message-Id: <20220523175344.5845-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523175344.5845-1-markuss.broks@gmail.com>
References: <20220523175344.5845-1-markuss.broks@gmail.com>
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

