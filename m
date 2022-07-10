Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41A856D18D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiGJV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGJVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D06167CD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so4734853wrd.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcpZSIH2SERO1GqyHwX4x93zMY30Y7mW4dlxxSKfG3U=;
        b=DkH+joBDC3nsJED1Ms9+qHjYNRXpFVkLjKKz8SDgtNuruLOmDbFn4tNLITaL/3fUs1
         iEToE8oeRMl1JjC37xgHsLLgC7saTnUNTrkOQJfKLncPNSKkjCcp6j25vVS99YPZ26vV
         Am31ePHKac9HHpkYrgA5W8WpbfAJgTkufFqpkTW6tYr+YPzpHThobK2YkSsMZVQcCHdu
         +/V+uiIeH7MlD6TGzYjL43t4vZ2vprSvLZ90d8o5nNa1gBBCE213u5yPZhZoO9VdPjCZ
         hJZqD14CSBKPnfEG0pfu/u6fDbI7kimoEs0+bW0rBeIu0o2yN6W3oKJrDhWRq+cfem+I
         OxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcpZSIH2SERO1GqyHwX4x93zMY30Y7mW4dlxxSKfG3U=;
        b=7cPBAp/iCHvGlx1S0plkBKWK4QW6a0batXg19aTuVbXwL8j0DDZAkXZCpmbX/yxbtg
         01zCWOBDiD9XghNWVtPQY6PkthHOuX5yd1W+4RIrnUzoVFcPTYgCFlORPjzOIxR/u/m8
         d3I/eDT+jMe2otFIwAj2m0O2i+gEE+a3uZ9LbzQ4qhmTv221HL3KlItS/sJe1ESAgwEM
         HtIVF05dRV2IUL8cE+VGXXOaDs+lUeNbxA0HNYr+VNiQqvEuGc0f2VvXiGnXcaO500ix
         2DCY7Y82VK71SNMp7n5bDPVmPzrAQrdWpxtJEs7IxzBR9ucNgUDJUkVL5F70bAQnzEtx
         fkMw==
X-Gm-Message-State: AJIora+QuNN8O0lp3SVq2EWynGiuXTS1w9/tYNZP0sYCejzNfpPeh98s
        oDsl8u/NNxj3TWShpu3Vj/AacQ==
X-Google-Smtp-Source: AGRyM1uWETlLwBtF39e/Lb6B1+JJRTnU2AvJdn266EFJX8KSznhMv/Q3QD9dksIwZzaAGoR3NyBOcA==
X-Received: by 2002:a05:6000:144b:b0:21d:a57d:8000 with SMTP id v11-20020a056000144b00b0021da57d8000mr2558397wrx.204.1657488304082;
        Sun, 10 Jul 2022 14:25:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 15/33] thermal/drivers/db8500: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:05 +0200
Message-Id: <20220710212423.681301-16-daniel.lezcano@linexp.org>
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
 drivers/thermal/db8500_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 21d4d6e6409a..f06492824e27 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -59,9 +59,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -74,16 +74,16 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 }
 
 /* Callback to get temperature changing trend */
-static int db8500_thermal_get_trend(void *data, int trip, enum thermal_trend *trend)
+static int db8500_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	*trend = th->trend;
 
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 	.get_trend = db8500_thermal_get_trend,
 };
@@ -202,7 +202,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
-- 
2.25.1

