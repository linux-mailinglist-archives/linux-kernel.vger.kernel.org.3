Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE858734C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiHAV0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiHAVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:25:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9A48E8C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:24:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so15612491wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y6LxKgZwFvrUFcWeNV79IxBK5DkuqAc3CHWOKwe+2Kg=;
        b=oMM9tnR7QzPjtZ+1m1u7pMsTss6AsCogAux3KpeBe15Hb6ncZDNCI8N8iJNibEkCIP
         RwJTd2ZVZbZfat7hQXg9uUIFw7dcDZj6XxQP2RDSkUNCsbV1dXTWQdQAmwajmE09jBYR
         RegRApstzhKmOzxcjSrrd4goEcAFBwgB+U7KxJmGJNwEoPowrKzRewAqu6zuMKC0+ZB7
         btikjisq5dQjXL8Yt1meVJH71+KdOqxMiGm4s30OBHrfKVwRXSRxJq/xCNGlGjWz6Xjo
         Uad16pplS0bhw+XRl8dO2SVHitaZC1FEldg8KmiMPtpHYnHgP0OFfBK997iZDfCHDVBP
         x3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y6LxKgZwFvrUFcWeNV79IxBK5DkuqAc3CHWOKwe+2Kg=;
        b=EjtLL4ozVFxO5b2oJS5+/BCgcIT+5K4aFGx4fG01nnaMZ8GVr2Mn4ojNG08G4L1F97
         1IjJfJYFj5c3fFcC5NBVBKAreF+pitmfvzGWtXS+kXybLdSr1TQLxEjG59ukWiN6yfh/
         t2vL/N755BHDQWI0kbC2S7B3aZxkm5ZyKWz4+C74yDomdSGqk4Y++JYfLcWVbpM9fX65
         V73hbhE9NrCh7l7pw3acbEcvTZuAzmu82b4dCZknNgksb9JDRMVjqyx+x7Dlg25BGB+s
         IIn1J9LVd5ypDvyBFQLqwtyngJzx02v4+7gv8/0i1kaeTsUzWKBP9iDfQOHTwClFlkCU
         n8Jg==
X-Gm-Message-State: ACgBeo3U1vFEQAsWsliu9qJq/hFk9BnDCIUdBEMLGQKwyaNDWJKgRGgC
        udRouNMnas5kOo3OxlvBYTUSFw==
X-Google-Smtp-Source: AA6agR6LQuBuxHr9NlKX+Yh/sLUuiKkvW4uAPOGwqx0Du8XFLAErB40m30ObZN6cp9AVZYIQXyjIrQ==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id b1-20020adfd1c1000000b002205ec3fb62mr5971169wrd.69.1659389054419;
        Mon, 01 Aug 2022 14:24:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:24:14 -0700 (PDT)
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
Subject: [PATCH v4 29/32] regulator/drivers/max8976: Switch to new of thermal API
Date:   Mon,  1 Aug 2022 23:22:41 +0200
Message-Id: <20220801212244.1124867-30-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
Acked-by: Mark Brown <broonie@kernel.org>
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

