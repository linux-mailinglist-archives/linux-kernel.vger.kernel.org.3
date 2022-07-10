Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2852F56D18E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiGJV0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00B215A1E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v16so4735012wrd.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9euVydakO8zgEHn2aQPblIk4q+hgF12Z+XIqfPeASw=;
        b=hnXTbPJRCGIFkI6ivd1ihUzIfiSxwyFh+Qi3UQcfdfFvQpPNY6PBiEz1p9kbtxYCT9
         4PQE2w7kVW63GcS2Ng4qQRoxADhNJqhDs35xfqYTtZatSlE5CzZ13xnX9soEuJEvIR3K
         Phn8FVlUrQ95LsCzpUlDqq/icxQlA8uHZv2GeGshRwAMUVaq1eBrg7zchpTlzSguXbsn
         I+Q/7QISjRtsn/mZjzxAqN1I4eiMdh7ppEWXpGqteA6DUtpjRz8LXwib8BvLIyLd01A6
         gCdyadMNr0SGdYrlE9pp6aA2vlHbAvhnxoqXZ19V9xhJIJ+0ntlNtGE/oQx45ZQZhiGI
         ZH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9euVydakO8zgEHn2aQPblIk4q+hgF12Z+XIqfPeASw=;
        b=KO+g4OER1BzY5JKDDHC4BjHK3xVRQ1ct9rLAPay2AFfXEatxRQRbUNMKlioSTzBGMw
         Rp2eSp5hFrV0ZABJ1ijKSplMF0Sg8HrAITTF6gCYEAtj7dAd3NaaEEKbCfJghW3rY4Fb
         +LZOQr5FUe0CXDbNpwz3AcQ3xh+sDlDX+mgMcsnQzISKeL3pAFDAt748G53q/2VEnR9j
         jBR+JRSF21wP1kb0aDS+ASuXDgIP9lAVl/dDQUCluT0p29S1gPXQiQbw3UsDBpjaP0bY
         BA93/teFga1GBBJwwmRjuiHmq0fa1IUsJkYeZ/K43904G1ggX0ldKjER6kb2TpiIU2+E
         zGuQ==
X-Gm-Message-State: AJIora/lnsrxV/NA1wlAtLHNrpeP5P1Bdzte8v8SBvhELOoDMXwL5BVK
        h8ii9VZ2lOSlZUIcyiTFXE+p5g==
X-Google-Smtp-Source: AGRyM1vYpjOdERDPOQIs55QnVDI/7J8smEkbfJJ22XmivSSjHSSL2YJPvTD7VSmZE0/R1jc9gNPtog==
X-Received: by 2002:a5d:6d0b:0:b0:21d:9f54:efa2 with SMTP id e11-20020a5d6d0b000000b0021d9f54efa2mr4860041wrq.607.1657488308788;
        Sun, 10 Jul 2022 14:25:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 19/33] thermal/drivers/qoriq: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:09 +0200
Message-Id: <20220710212423.681301-20-daniel.lezcano@linexp.org>
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
 drivers/thermal/qoriq_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..86c8cdabcbbe 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -82,9 +82,9 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
 }
 
-static int tmu_get_temp(void *p, int *temp)
+static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qoriq_sensor *qsensor = p;
+	struct qoriq_sensor *qsensor = tz->devdata;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 	/*
@@ -122,7 +122,7 @@ static int tmu_get_temp(void *p, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+static struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -146,9 +146,9 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(dev, id,
-							   sensor,
-							   &tmu_tz_ops);
+		tzd = devm_thermal_of_zone_register(dev, id,
+						    sensor,
+						    &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
 		if (ret) {
 			if (ret == -ENODEV)
-- 
2.25.1

