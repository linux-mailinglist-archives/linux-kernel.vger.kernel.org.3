Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942156D192
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiGJV0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGJVZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3A15728
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r14so4782445wrg.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2wfLrxXnyl/4VAOjy10YdLX3f8bz6C8KrI7vU13mPo=;
        b=GF3P6Ppzi5+tUgEUE3vCUVcj/Lq0AuDieMw0s4jyfEKnnDNqI0hX1t2JtNhMRXSERR
         dZ+pTJQx5YaUVt8cT8ctcyB8Oe+eQ36Pnvp+ICr5uH04C47g+yfNNxoBSrsZSLtqcWTC
         tDgwObfr8ClF78HSehzFcQ3jgomp5rag+Fqfz597GQt3mABMbgMIBUAgBQMvFx+6r30j
         rfXXXg52iclx77Enq9KsjF041SeWnpJx573n1qjlDMAF+F9wIFOak5pNAeQiRxDl2AIJ
         XpOEiPtT7yitt798THZk+5n7Pv5npwnuIycLTZ8pVN1VJAZJOoPaEKrjmPTCdTK6aNFn
         gY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2wfLrxXnyl/4VAOjy10YdLX3f8bz6C8KrI7vU13mPo=;
        b=z5ILkt9XDvQfX8XW3mGd2ag7IX8SsTInf+i2zdJaVO56RF6LXOZvrHL7nDn1es2YYk
         iSRJ/ySgPJzP3V1ShZIZg6P7iszFEcJnKrisU5DjF1y7Y298GWLp6/pJQ0PjbY8WxHZ3
         UJze6531/8+SyGdC1qYiiU08jokS5B3VwaKKzGFIv6PKwB2v047Ke3sXlUMjIX0KbkR3
         16KaTYBhqAL4MJPFac4dxejnLSmQRViHfsxHqfsNXXzzQTXtYC3cZhMXfNyq3lAiE26x
         NW5V2AW+/vR81yWKJqZ7DLWQ14vvylOr53pWf4TRN+vBgclqeoOvyniSABinmPu+pkA+
         yIWw==
X-Gm-Message-State: AJIora8/PM5MmIiN9ivO1cE5shFpiX/AoVOKFz+QuUA+BHQjqwkGGTjq
        5tP2FmjBH0Zvf10rbz0b73L+VQ==
X-Google-Smtp-Source: AGRyM1tbyrl3D/MULNcGXt5KDLm/AiRAo6WzJyqoCBnaHv/g+Na1lzusD3ORcFiw4Iiv/pgV6cV1VQ==
X-Received: by 2002:adf:9d82:0:b0:21a:3906:59cc with SMTP id p2-20020adf9d82000000b0021a390659ccmr13761133wre.289.1657488307710;
        Sun, 10 Jul 2022 14:25:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 18/33] thermal/drivers/rzg2l: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:08 +0200
Message-Id: <20220710212423.681301-19-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/rzg2l_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index be07e04c6926..22eb58b69f4a 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -73,9 +73,9 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 	iowrite32(data, priv->base + reg);
 }
 
-static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = devdata;
+	struct rzg2l_thermal_priv *priv = tz->devdata;
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
@@ -111,7 +111,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+static struct thermal_zone_device_ops rzg2l_tz_of_ops = {
 	.get_temp = rzg2l_thermal_get_temp,
 };
 
@@ -203,8 +203,8 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						    &rzg2l_tz_of_ops);
+	zone = devm_thermal_of_zone_register(dev, 0, priv,
+					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
 		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
-- 
2.25.1

