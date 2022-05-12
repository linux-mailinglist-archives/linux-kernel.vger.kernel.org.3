Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C59525585
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358039AbiELTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357957AbiELTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:14:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0E2764F8;
        Thu, 12 May 2022 12:13:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so10771408lfa.6;
        Thu, 12 May 2022 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X00UxJiG29OHM/sXI3MtHY1xp0KAlUMcsiInYqLUawo=;
        b=BIKhjkc/C+VlfYqtLCW9ohNhtcCKeCQweZnR2uH0wugGjxrsFSJrs/FjI+W6x3LX2E
         3ivLWd6Zs+MInoXNgFYJ10yBVZvp/yJjVFe7vh9DcR1Wkyy1hlT4/OzFMItwuvmmg2Pg
         eQ6biVBl6ql72Ws9Y6RKy6+Y0hFlMFSa9z9Vdsc7usd7CiXZEMSGQA2Gc2NpPqcBrkAS
         NasDtBrKDTu4rJRAXAF2y5lsCwJ311qyhiXv/1a9cf+1asrI7sph7KrPztrafa/je2KH
         s2QhY4lgBPU2H7InDDI5lYAiGIipvvAUJjrsD+J0yH9TRBYPNwMrWizW+HeLA6t6Wxd/
         KoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X00UxJiG29OHM/sXI3MtHY1xp0KAlUMcsiInYqLUawo=;
        b=3FeedqigRfU+OC8Bz6U7Imq/dpB6PKxeyJM7J2lrWJXYF80n6jFIx5VQ5q5R2iedN+
         Y82Kegbc6pB1RcaQc/eBHeH8lvbaSjw4CrSVNfJyEbroACUYX6hhiMF4bR/kEXpatdD/
         cmDZxHdol3eyOllOpjJnYQ//xs69KD5nOkoPLvpbcNNVZbGUmvfMJt8NmfKPH30r4VwN
         kxALPA+vJcGgJb1xaivBZ1FCBIzV/AvMdeqdCCpD7TzQxDFbPOFZmXQLMgbe50Ix9glJ
         6RW4vIHetqsFsPQ8VQy6LO8+jzYkCxKGcHybUIkKbk/oT42bNKXR5mhI8GdNXNDPGt9o
         pSRw==
X-Gm-Message-State: AOAM533Gt9vfWi/PcS6Zei01o1kFldqw7icUZ671/JjnqjQ674QOY24c
        o2TEBeXhDVneOFPhYgc1ABO6sndqDx1Vfw==
X-Google-Smtp-Source: ABdhPJzbLYaREDLCv/6XHTqaOAnSDI2vNV6DtnXOAyj3WhVSEfhl+++h6q1bPxZIxDG79hKpdh2s/Q==
X-Received: by 2002:a05:6512:2988:b0:473:f41d:567d with SMTP id du8-20020a056512298800b00473f41d567dmr865986lfb.384.1652382834237;
        Thu, 12 May 2022 12:13:54 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b0047255d210f4sm62146lfg.35.2022.05.12.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:13:53 -0700 (PDT)
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
Subject: [PATCH v4 4/5] proximity: vl53l0x: Handle the reset GPIO
Date:   Thu, 12 May 2022 22:13:32 +0300
Message-Id: <20220512191334.61804-5-markuss.broks@gmail.com>
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

Handle the GPIO connected to the XSHUT/RST_N pin of VL53L0X.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 8581a873919f..36c48a824725 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -44,6 +45,7 @@ struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
 	struct regulator *vdd_supply;
+	struct gpio_desc *reset_gpio;
 };
 
 static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
@@ -197,6 +199,8 @@ static void vl53l0x_power_off(void *_data)
 {
 	struct vl53l0x_data *data = _data;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	regulator_disable(data->vdd_supply);
 }
 
@@ -208,6 +212,8 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+
 	usleep_range(3200, 5000);
 
 	return 0;
@@ -237,6 +243,11 @@ static int vl53l0x_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+				     "Cannot get reset GPIO\n");
+
 	error = vl53l0x_power_on(data);
 	if (error)
 		return dev_err_probe(&client->dev, error,
-- 
2.36.1

