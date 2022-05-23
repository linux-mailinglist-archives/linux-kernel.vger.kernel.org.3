Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B29531C95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiEWS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245494AbiEWS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:27:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADCD4105;
        Mon, 23 May 2022 11:02:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi33so21973406ejc.3;
        Mon, 23 May 2022 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X00UxJiG29OHM/sXI3MtHY1xp0KAlUMcsiInYqLUawo=;
        b=n5V1x8nfknwiuZ01vBCWBJp2SDBg3zi23hvJdOeG1ukUA5q0CI/AGiNS1Aw76smWTR
         i0m0FQVyyc4hFwDPIg5ElEbnyUp5Ei/cAjCU9hY1/V0ytPv8h4VZexApyqWhBUvX2SCc
         qjC9pB3PR1dE5B952JAsq13Z5EUHKPBulwhFBbYP4M7Il7td63xkuXPTMHgXxxrDN9Vy
         4SGaUQxOHHFeiFjA8KdbSMkFpjud0qeHvQEY/6MXBUinCtXkIT3QmWpV3u2Zc2kgo9/0
         7TxD+0oacgozB26oHS53DHBnk8Y65gXwdJHJo0IaTnN5mBorkhprNt2OFIJrxzZtAL1o
         Jhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X00UxJiG29OHM/sXI3MtHY1xp0KAlUMcsiInYqLUawo=;
        b=veHGgUDPAexLTuWrrUkEkHx6KRKtPxPec8C7yjUhn+j2PRt+04TrgxEm60U3w/vApz
         zHYleAeE9HCnnVQmS7bh+F9Cf6NWZwrfAF0FOfb9hUpros9BJ6BqIg39i5+UOiRyzMrK
         oWYuMn/V7Qt44r4HvFAT4ZJWtuo8YzXlxjyhc/lylYS0axA3YYW/8r8hLvcOpwKRbxpS
         ZNfMqkpg27sec1FTlcYJhYkcxNTM59Y/CjSePQN3ZOQu64z+uMkrAAXZ4VrhZZQchqjf
         09QfiUTkg47AomKcSSoHabbZbyQ0ltW6U3Dv4NoMn++pa0Lg/OC50paas0WOjSJOTsZ7
         nkwA==
X-Gm-Message-State: AOAM533xe/pBEqkWtqEkulxdI66Y/tJPmRnH/00jlBFtdjctgOmQnR3C
        4dS2xSyfjqysXKJGcbY9h40UcxitiLRxAA==
X-Google-Smtp-Source: ABdhPJzGrq2mVI+VKEC0mJ7HKWpkQWD0eyzh6iKDuBcdWU+6lo4lBEBoetokGgCNwOO/7NdTKhgcOg==
X-Received: by 2002:a2e:b88a:0:b0:253:e7f5:c0e9 with SMTP id r10-20020a2eb88a000000b00253e7f5c0e9mr5076231ljp.38.1653328478170;
        Mon, 23 May 2022 10:54:38 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b0047255d211f9sm2087743lfr.296.2022.05.23.10.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:54:37 -0700 (PDT)
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
Subject: [PATCH 4/5] proximity: vl53l0x: Handle the reset GPIO
Date:   Mon, 23 May 2022 20:53:43 +0300
Message-Id: <20220523175344.5845-5-markuss.broks@gmail.com>
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

