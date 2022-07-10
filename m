Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3556D19F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGJV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiGJV0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6131706B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z12so4759041wrq.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZwqLH//W1+QEOMAk/S4a/3Zrx4GN2+Bea3NwAVXcO70=;
        b=clgX/y+/32mEh9l/6iuJB3mbxw5oYz4wdwoyICnbeWlyhTs62a/IQb2+0m0RoIii+r
         9HGkAQBSuW4ev20frhVaMPM/82lKEeHJdn6gFM82nLeeZrdu0SKKGC0fbf6CLoYbClD9
         2SviVQITEyeLGCpZ2jzA+yP7uePb3u8UAPCjBBTKedy0WRtpwCgvgr6KTEInvlOwWgjC
         cx5eCCnUBw5JzBjVu8ELgcblOhpc4m9DjEUjJJ0b0O/4oFT/Su0v1H5VxvOWU7n3qsZZ
         WiDGfGcyEikv93+5r5cKSu53Q98r7JlGUpk86h07BZQrY0HV+WCiFd2OtcOxBLlGoMKJ
         geGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZwqLH//W1+QEOMAk/S4a/3Zrx4GN2+Bea3NwAVXcO70=;
        b=NYvpqCTUkaRjcpoA9kdVmRjLT273vVXXcDpwGerg6h0qjZm7hdnAmkkMiXnA9NsQH0
         j0Gm2nX2oEDiGwGTLM3gWXl1JVRtd2KQ8w/2wg9MqlcJL4ijwIVrVgh5YntlOU5XGVeA
         T1u6j7eQ04aRALGmbEFGWs5MCsCcgmy5dKp5M0elqsjhLkcwz/rTolowPZ11kdfKNnMu
         D2dN9tFY/KrkqA1+OyCkLu4OboBeOWYHg+S8iFiOrXcxJ1i6cIJoeiw1TUm5mgTFWPPk
         xNPT9bNxWyTTcRAC2MtNdK0kckLU8cjb4lIAz/J7LabF9iythibLSI/IbyfJnBDuO75Y
         k3Fw==
X-Gm-Message-State: AJIora/nDj5lpw9ynGea1H/IAP1tYtm6CkN45oOVcrzgfGBr1gDvAUb/
        M5FNDENYb8cfjV8nTSD1SbCiRQ==
X-Google-Smtp-Source: AGRyM1sjOeQpf0Z7hmGR89J+3e9HHSig/8dGQ1+XVo+nYwSo2953t3SZUm8Anb/OMRa0RMEkLOpbtw==
X-Received: by 2002:a5d:47ca:0:b0:21d:9f54:ef97 with SMTP id o10-20020a5d47ca000000b0021d9f54ef97mr4924054wrc.478.1657488322655;
        Sun, 10 Jul 2022 14:25:22 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 29/33] regulator/drivers/max8976: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:19 +0200
Message-Id: <20220710212423.681301-30-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/regulator/max8973-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index cb7e50003f70..45d4395fcc06 100644
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
+static struct thermal_zone_device_ops max77621_tz_ops = {
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

