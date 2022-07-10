Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2A56D17B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGJV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGJVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7BB14039
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f2so4761976wrr.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7qU0l11XuBaUxJzhKqB0uFCFxpqtrqPIbLk2Bb/IBU=;
        b=bViLhf8ekuUWaRy1driK478eBCats9Y5hHqzf3t8OuUIsIUJlRKiYgZCrGxQLMLqpc
         dSooLG6qwZTlKZ7bYeJbBVuG9Ro/m0yGY1VZUyXC1FnI1JvVNcd9yoEP+6LoZj+fSJ1u
         zkSflFutUDefFGp/TOZl+n71eitpTw93MUxamFSgMpgHJlGl14WuymrAYyZibHcMMlJK
         WGM29wuKfb1i7AV+1aD0oceriCGQu/w91N0xsc8uocJNovvMcsMf3qO+VNYGpJxtVm3h
         MfpufvYog+RHS0X0rsDQq1bWh2amnXqZWaEtCFKRLDut4dn8xUzp2esXsp7Q7u1bTGgY
         IrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7qU0l11XuBaUxJzhKqB0uFCFxpqtrqPIbLk2Bb/IBU=;
        b=z62mHNqoe8w2u37Wfs6tpNujcDbYCZ1codocTgqRnpAQY5y1pvRPfVUnSBgYADh1gD
         ipBzFI0hkAPZsimc3EvakullH+5Ml3YgCgLBNBQdxv47z4KWNnFhQfSU5dCKlIJhTAHC
         vbpheZv9huvudIKAu7fkSj66hKVFhBrp70OdfFbQbuidks27nyCK6zeiDNUj5W9lMFdT
         PyXdNwPTb1K48KxaBrnemxcC0DGuFiBZPrkf81tfoeI7lRKQkn/giktGgJ7zT9LhgQTh
         9qOMfd4ZWn0UG1MCeF/JquF3goPMCOwDj6VIaVRPYThZ+onaXhqdM/aodp/6r31cCCjL
         M/3Q==
X-Gm-Message-State: AJIora8cKrYWLL855cOTA9EjTpWcOGvZn+A1yWUeBxpp37wJ5TITo0Dd
        DsSDzRvJ2ZCgaUY0WeSXNst+iQ==
X-Google-Smtp-Source: AGRyM1vffzN5eiy27fcXyMoBJq1BVy3jqLfPjvEt5vtveDcNZJ5OnAIq2aniQxmH184KYKgCE6sxcA==
X-Received: by 2002:a5d:58ef:0:b0:21d:9fc8:302e with SMTP id f15-20020a5d58ef000000b0021d9fc8302emr4587256wrd.22.1657488310058;
        Sun, 10 Jul 2022 14:25:10 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v1 20/33] thermal/drivers/mtk: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:10 +0200
Message-Id: <20220710212423.681301-21-daniel.lezcano@linexp.org>
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
 drivers/thermal/mtk_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..1dfa6b058d9c 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -679,9 +679,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	return max;
 }
 
-static int mtk_read_temp(void *data, int *temperature)
+static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = data;
+	struct mtk_thermal *mt = tz->devdata;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -700,7 +700,7 @@ static int mtk_read_temp(void *data, int *temperature)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
+static struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
@@ -1082,8 +1082,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-						     &mtk_thermal_ops);
+	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
+					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev)) {
 		ret = PTR_ERR(tzdev);
 		goto err_disable_clk_peri_therm;
-- 
2.25.1

