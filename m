Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E188524B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351126AbiELLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352976AbiELLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:08:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876A5C645;
        Thu, 12 May 2022 04:08:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d19so8402536lfj.4;
        Thu, 12 May 2022 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLQN83VvltxdSATanB/kDolFLpegPPuCVvOhwlfRT+8=;
        b=mZKX+SjxOH6UemtZnMDam2zh4o0eCLB8so8IKQqcaT/v+lQaOSyK0I4aqZU0rH1PsI
         AQY7Z5bMcIcCHiB3FoOarcfppy4bM6E1k3W8Jvon1kHWLMOc2NG65+PD6s/omE1j3+Dp
         YulAxEOaWGDVoiLiRCKF34qwfA0CYYprz37nMqUXsYO34KAjdMp1drtR2wUucv70iIrh
         qZDSUsep1SaKn6lR3T18tZNpeDfRYP2+NydR+5y/BH5bkLEPVggSEKs+Go2jVsL7FgEI
         n0pQDeL7vdZDsUUPAtlmpN91QpLncAKmsdhv2TZoTKo0ZJZfc2i8y9Agccr1+aSmFDDz
         Y3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLQN83VvltxdSATanB/kDolFLpegPPuCVvOhwlfRT+8=;
        b=0/xay8dzv9atp4iIGhz2/ox/zfOpZBMv3JlFzbuH94+5qdz7KUHBI9x72YRLCk2hU3
         1SOYx30ab3+ZPW6JVje6aDoSiY4WWoyzTnPHpR+XiT3ltirZK6CMIeEL6bqMtBeatbx9
         Bnffgx8ysS6JEKEt3Lmh4WOwTu/lIqWUhitkBFSkIE5e6j1rW72tW5vSpH8vH8aKd2rL
         +dFPvdP/VB5qUpmucKe/6gw5WtMj7CDuizRnPMuyJFOTuC2QxZy+uKBO/qCEx3J/UXTZ
         keHGSNK+capYysZissAvDP08nuF3zOH513n6vi5P3lNKKfr72dKp5LYwWG8lZusPZLT5
         S6yA==
X-Gm-Message-State: AOAM530m7UxSMJg+lFlDMrVfcOFF+9fWhjYsEsDQqzCYGJbdQ29+GRtY
        Iul7F8egnZNkNxyfiKlizCIi+o2Z3EZxYQ==
X-Google-Smtp-Source: ABdhPJzJ6moCcfNylhZKc150gNUcy3ILRU+95Eo3tbpylNCKdRplmHXnaNaT730MloGNdz/49Derow==
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id z3-20020a0565120c0300b0044779127e6bmr23587775lfu.508.1652353697935;
        Thu, 12 May 2022 04:08:17 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i25-20020a056512007900b004725b99d2fdsm734883lfo.164.2022.05.12.04.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:08:17 -0700 (PDT)
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
Subject: [PATCH v3 4/5] proximity: vl53l0x: Handle the reset GPIO
Date:   Thu, 12 May 2022 14:07:56 +0300
Message-Id: <20220512110757.5297-5-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512110757.5297-1-markuss.broks@gmail.com>
References: <20220512110757.5297-1-markuss.broks@gmail.com>
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
index d8523e3981e8..ef099dd174c1 100644
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
 	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
 	if (error)
 		return dev_err_probe(&client->dev, error,
-- 
2.36.1

