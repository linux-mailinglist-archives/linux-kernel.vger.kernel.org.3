Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0375806C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiGYVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiGYV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:29:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A42559D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:28:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a11so7610618wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtrE+xA1tF8iSNMdDW1P/DphWtZyHaO/Zoz/qfhB2UA=;
        b=HKPwXjA8ROF4qVeYNByZtE4ZdLmoeJu41nyUu7JJtc+7zJcOMsCzrXRof/Q6cG1F6X
         lpKOyBZ/8TZ/QkZjMkZCl8MFkCMXp9YwcetgnwN7SMuhb5noq/Lh0oL/sZ4QoC1W1eCS
         1LL7+lpCSiFjLA5e/Y4Mup78A2ioqqfE180R+WVssnd0UiDoZUZXZT9ugcDSMuZqf28x
         v6aKpdcMVtTpM21uSrPAjH6fAjVV0YiYt2N+GziuGCoYXaHMjF+awLcKrsC+kpJR/4p5
         KSpMVDxMH4x2mN9AW9YyXiqPiW7mXx2Aj1FNhVl/wzoVVBTuGRcAIqT8WNrO8yp0hgpG
         3z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtrE+xA1tF8iSNMdDW1P/DphWtZyHaO/Zoz/qfhB2UA=;
        b=OXWWDPcbi7SA04l+Y9Y0zVmXsFWn5+J1kz5swnXATza31vv4YRHaBQkCs5g5r0yJj9
         +SuKoUPh3qZaL6eqQ98/cp40+ynq3+j959wpSVc5OxK0ur5w6eC6V92Mzawa8GYG7Gpo
         lPtT6lRdYvL3Hprs/UX3iEjc7DI5XqPoZGXwmxST62K7ioWe4SkehLFgrrs/6kFlf6b5
         8an1cMov3PY8A4bw6W4xb2VsPxr9CIIQpkmYXYKeDNI9jiM2ju/0g3QAA5QleldUVKcS
         WrTGTNWb0HAqR5etCv+zApW7yTEUgulHuBQfZ0hsrMNLlGcpjG7/Ti3ILzfSNiRt8rzy
         W/Uw==
X-Gm-Message-State: AJIora/05q9j+jsKtD3RmA5lVfIw/wOWuWF1kFFJ5iNIMrI7zjfXOZ2X
        fUSz8oPQzUD/JXirYrzefjYTJg==
X-Google-Smtp-Source: AGRyM1uEfAwk0NQYCGneudL04IHnOpSVAjtNyZP1DD+jte3hquc7uQnE+4RAK4airXbZOhke68+Tdg==
X-Received: by 2002:a7b:c8da:0:b0:3a3:19e:4a3a with SMTP id f26-20020a7bc8da000000b003a3019e4a3amr22833840wml.201.1658784486125;
        Mon, 25 Jul 2022 14:28:06 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:28:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 29/32] regulator/drivers/max8976: Switch to new of thermal API
Date:   Mon, 25 Jul 2022 23:26:34 +0200
Message-Id: <20220725212637.2818207-30-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/regulator/max8973-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index cb7e50003f70..61211c462b1a 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -447,9 +447,9 @@ static int max8973_init_dcdc(struct max8973_chip *max,
 	return ret;
 }
 
-static int max8973_thermal_read_temp(void *data, int *temp)
+static int max8973_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max8973_chip *mchip = data;
+	struct max8973_chip *mchip = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -478,7 +478,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static const struct thermal_zone_of_device_ops max77621_tz_ops = {
+static const struct thermal_zone_device_ops max77621_tz_ops = {
 	.get_temp = max8973_thermal_read_temp,
 };
 
@@ -492,8 +492,8 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 	if (mchip->id != MAX77621)
 		return 0;
 
-	tzd = devm_thermal_zone_of_sensor_register(mchip->dev, 0, mchip,
-						   &max77621_tz_ops);
+	tzd = devm_thermal_of_zone_register(mchip->dev, 0, mchip,
+					    &max77621_tz_ops);
 	if (IS_ERR(tzd)) {
 		ret = PTR_ERR(tzd);
 		dev_err(mchip->dev, "Failed to register thermal sensor: %d\n",
-- 
2.25.1

