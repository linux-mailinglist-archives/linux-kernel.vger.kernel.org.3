Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C040757BDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiGTSTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiGTSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:19:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8868DDE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:19:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso1792850wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6t1tJznirgBuuhOslr+HrbK0FgxfxpNokiZkLl87qc=;
        b=jIbnUzr1HAn9joeLX2mrLV6691ELQKqEy3owuhkejKOCKt1cASKXXjB9wMEUyO/jrT
         s5tUtyzbn1t8G+kZJlIz/Cm67eUcjlh2SfDztzDnH4anMCmyswzuGwbtcoS4ncqRGF2p
         VoIe1ei2yB23cyB0YfUNuRmPsckQTAWU3G9X8cE3hJmIKjd1U5KyJWwdCwLwdsqizYma
         sr3KF6IDMPBE6gDy6iX8BTEcU6tJgdBJ+goHrNSSkiuIsJZ+cC0W7d/DwtWQsu/ud2et
         wOuoUgoaFTHv+6xS/TSJEfF4GvTFskkxX3jdr+EZ7ilhR0NVjqIRQO7vJ7CvmBaDRXeb
         RxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6t1tJznirgBuuhOslr+HrbK0FgxfxpNokiZkLl87qc=;
        b=0rwa3F/g9WPy1+7GYDhAGQmrGDhUcV2wqY29xS1LpH10dKs5799wVQ1nPgP5SeefaG
         sUAMVhkB1VZtFHmceq3e24VCPbX21r7QAfhrx5v4v53kiyFQw9AqT0DeIJLRMJ5XnTlz
         xkPKu3mC8bGcTj+x1XRQ7oceBacIzdEB1mkeN11Fr/b3xgZaoDtGB4yux6orTjA8Y12B
         vvS6A9Fgn4/rYIRwuHl69Tkk6Rj9NRvufdwKj3Af7hbMGTRY7/ZCzXVEZExdsWlBmsbr
         zDYu4LgjuQEC5jtl0f0D51QCPhg4v++Kn8Qlhuv+zyJcw2U/1LImTAPhKKb4q7T4CvfC
         5hYQ==
X-Gm-Message-State: AJIora+rv+vD8D68Xc4PpkAUxUw69k07zGseYr8OmYyg+8iojVpts7WX
        /paxsrxiKHtL6V5lztnQ2EH7OA==
X-Google-Smtp-Source: AGRyM1uGKhBM5kBeoQFZ7rJFvEZczSvd1eckDYJ1dkCuDSNjsIsqpCTaawcB/4Ev9F6PK/fbasFdmQ==
X-Received: by 2002:a05:600c:1d8a:b0:3a3:1104:88ad with SMTP id p10-20020a05600c1d8a00b003a3110488admr4894543wms.179.1658341179153;
        Wed, 20 Jul 2022 11:19:39 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003a31d200a7dsm3400093wmp.9.2022.07.20.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:19:38 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        default avatarMichael Kao <michael.kao@mediatek.com>,
        default avatarHsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2 4/4] thermal: mediatek: add another get_temp ops for thermal sensors
Date:   Wed, 20 Jul 2022 20:18:54 +0200
Message-Id: <20220720181854.547881-5-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220720181854.547881-1-aouledameur@baylibre.com>
References: <20220720181854.547881-1-aouledameur@baylibre.com>
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

Provide thermal zone to read thermal sensor in the SoC. We can read all the
thermal sensors value in the SoC by the node /sys/class/thermal/

In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
on the first read of sensor that often are bogus values.
This can avoid following warning on boot:

  thermal thermal_zone6: failed to read out thermal zone (-13)

Signed-off-by: default avatarMichael Kao <michael.kao@mediatek.com>
Signed-off-by: default avatarHsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 100 ++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 1dc276f8c4f1..79b14ce1a08d 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -259,6 +259,11 @@ enum mtk_thermal_version {
 
 struct mtk_thermal;
 
+struct mtk_thermal_zone {
+	struct mtk_thermal *mt;
+	int id;
+};
+
 struct thermal_bank_cfg {
 	unsigned int num_sensors;
 	const int *sensors;
@@ -709,6 +714,32 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 		mutex_unlock(&mt->lock);
 }
 
+static u32 _get_sensor_temp(struct mtk_thermal *mt, int id)
+{
+	u32 raw;
+	int temp;
+
+	const struct mtk_thermal_data *conf = mt->conf;
+
+	raw = readl(mt->thermal_base + conf->msr[id]);
+
+	if (mt->conf->version == MTK_THERMAL_V1)
+		temp = raw_to_mcelsius_v1(mt, id, raw);
+	else
+		temp = raw_to_mcelsius_v2(mt, id, raw);
+
+	/*
+	 * The first read of a sensor often contains very high bogus
+	 * temperature value. Filter these out so that the system does
+	 * not immediately shut down.
+	 */
+
+	if (temp > 200000)
+		return  -EAGAIN;
+	else
+		return	temp;
+}
+
 /**
  * mtk_thermal_bank_temperature - get the temperature of a bank
  * @bank:	The bank
@@ -721,26 +752,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	struct mtk_thermal *mt = bank->mt;
 	const struct mtk_thermal_data *conf = mt->conf;
 	int i, temp = INT_MIN, max = INT_MIN;
-	u32 raw;
 
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + conf->msr[i]);
-
-		if (mt->conf->version == MTK_THERMAL_V1) {
-			temp = raw_to_mcelsius_v1(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		} else {
-			temp = raw_to_mcelsius_v2(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		}
-
-		/*
-		 * The first read of a sensor often contains very high bogus
-		 * temperature value. Filter these out so that the system does
-		 * not immediately shut down.
-		 */
-		if (temp > 200000)
-			temp = 0;
+		temp = _get_sensor_temp(mt, i);
 
 		if (temp > max)
 			max = temp;
@@ -751,7 +765,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 
 static int mtk_read_temp(void *data, int *temperature)
 {
-	struct mtk_thermal *mt = data;
+	struct mtk_thermal_zone *tz = data;
+	struct mtk_thermal *mt = tz->mt;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -770,10 +785,28 @@ static int mtk_read_temp(void *data, int *temperature)
 	return 0;
 }
 
+static int mtk_read_sensor_temp(void *data, int *temperature)
+{
+	struct mtk_thermal_zone *tz = data;
+	struct mtk_thermal *mt = tz->mt;
+	int id = tz->id - 1;
+
+	if (id < 0)
+		return  -EACCES;
+
+	*temperature = _get_sensor_temp(mt, id);
+
+	return 0;
+}
+
 static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
+static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
+	.get_temp = mtk_read_sensor_temp,
+};
+
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base,
 				  int ctrl_id)
@@ -1072,6 +1105,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
+	struct mtk_thermal_zone *tz;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -1161,11 +1195,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-						     &mtk_thermal_ops);
-	if (IS_ERR(tzdev)) {
-		ret = PTR_ERR(tzdev);
-		goto err_disable_clk_peri_therm;
+	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
+		tz = kmalloc(sizeof(*tz), GFP_KERNEL);
+		if (!tz)
+			return -ENOMEM;
+
+		tz->mt = mt;
+		tz->id = i;
+
+		tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i, tz, (i == 0) ?
+							     &mtk_thermal_ops :
+							     &mtk_thermal_sensor_ops);
+
+		if (IS_ERR(tzdev)) {
+			if (PTR_ERR(tzdev) == -ENODEV) {
+				dev_warn(&pdev->dev,
+					 "sensor %d not registered in thermal zone in dt\n", i);
+				continue;
+			}
+			if (PTR_ERR(tzdev) == -EACCES) {
+				ret = PTR_ERR(tzdev);
+				goto err_disable_clk_peri_therm;
+			}
+		}
 	}
 
 	ret = devm_thermal_add_hwmon_sysfs(tzdev);
-- 
2.37.1

