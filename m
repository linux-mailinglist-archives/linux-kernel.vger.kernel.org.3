Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72356D168
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGJVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGJVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:24:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843110549
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so2016017wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6UpZxMs6Mqjfm9lFZkQvs2oPZ3BpcuARfv2WvsRFc8=;
        b=7eP5i1cApoeADUl1qvPMI05On/4n8rzqej9f1ynk/X8gS+0GIfns9KyuaR9ADGkkUb
         +dat/V+CoEk/6CbkBlcrJlzSL03Kg7GZRCu7kM9EoM4d++BB7HeIsFix4d2lAPhjCjVT
         FchZH52kyTSDBFlmKgkzTD98mntb8CAX2Q8NLgySEUOUYNQPfwyk/buvD8im8xDMIP7B
         fWUBkRzDD/8vCnY0OKG7BmZSo7+i4WJRXhKcDccZaMmQxdKYDQv5VFqMMUf8G8ceGxti
         qAXMQ/qzhTfXL15q/fcXOHQK9LTdXPvAArgxYDwuISkeqYQU6MmjZqE/P453FlyTj/x7
         Y5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6UpZxMs6Mqjfm9lFZkQvs2oPZ3BpcuARfv2WvsRFc8=;
        b=Dtordzc5xJ85Yg1IjReUMNlhRuu3+fhDx3fRWVAPDUcMvvj2fEsQ4ToXkPoTvenBO/
         e8fBFLCDFKmWaJclif/jqevvKMdgLPrIxTYK/lSbyTKnjqOc81rybtPc77C917Cqhn8i
         03yldB7xrgIwcpdnnEelFRND56rxifQcCLZ+tkMJEU0lLmA5lAkmD3RHdGv7ffcTjCnG
         N4E/Np/jqsQf8D/Tsjhxc2ktGD+lRalrdiqwccVGMrM1woJzKpdZUSLg0JrywOzFTXPz
         Ql9RtVUJGrRO8R6T4EBsPwlUDqpqNBhA+6MNgEw0WhGeg+kJtFxzLubXwkIYEmv+wD5q
         tJPQ==
X-Gm-Message-State: AJIora+PUjjnYqTFwhmdNbOurukDbjNWr6kDCH9q02cpZyqPhaSN5Lej
        1KIoKnXN/1BS3loYa9Jwwu6oFg==
X-Google-Smtp-Source: AGRyM1sU6krUfi9DTkwT2d3dqHGaGczAfeCTxsiKOGMOsQMqzxz5m+5MnRgSOE6BbF1G8zXvDRCSMQ==
X-Received: by 2002:a05:600c:224b:b0:3a2:e86a:988a with SMTP id a11-20020a05600c224b00b003a2e86a988amr1241607wmm.135.1657488281194;
        Sun, 10 Jul 2022 14:24:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 05/33] thermal/drivers/generic-adc: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:55 +0200
Message-Id: <20220710212423.681301-6-daniel.lezcano@linexp.org>
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
 drivers/thermal/thermal-generic-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73665c3ccfe0..5d58ba904298 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -52,9 +52,9 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	return temp;
 }
 
-static int gadc_thermal_get_temp(void *data, int *temp)
+static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct gadc_thermal_info *gti = data;
+	struct gadc_thermal_info *gti = tz->devdata;
 	int val;
 	int ret;
 
@@ -68,7 +68,7 @@ static int gadc_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops gadc_thermal_ops = {
+static struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
@@ -143,8 +143,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gti);
 
-	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
-							   &gadc_thermal_ops);
+	gti->tz_dev = devm_thermal_of_zone_register(&pdev->dev, 0, gti,
+						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
 		if (ret != -EPROBE_DEFER)
-- 
2.25.1

