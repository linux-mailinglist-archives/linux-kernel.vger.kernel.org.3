Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C458E2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiHIWHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiHIWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CADA12AF5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so13987407wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qkEQMAFlFrUq6t0pAagx8mtMZ2aPJX8cpHX423TQAwM=;
        b=uXFuuXPIk5YZpv5fxfWZTycPEBW26AlQ0Z/sdH2vUqzo8aI/6xrbnSStYFLxYzZ+Oj
         Zz5PP7G4DmTpFw7M8W9inRzGpMEg8/MtCeIe1u3kDorWDGlk+mDUULMeCR/JEJ6kpBkV
         KuOejQuOTAf7kAd6c5LdiCnmul5CjANOP882WB9WeitsymtypVrVCddgtG28n5Gve3dw
         4gTHayTethKgt4CYtSwlDmymnmZdqX5u2Z/X+GDr+NP6UTiT9Re72wfUqNounMKYd0vY
         Y0EuBnojzdA/BDzqq47+BHv5nTG2SqEicRiQVRm+WVHsECFdMsVa8v6fGQGcogmVSCDY
         WBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qkEQMAFlFrUq6t0pAagx8mtMZ2aPJX8cpHX423TQAwM=;
        b=euxFyn90OteZIQTB4csH7kLseHBhYi5TDXnTEYDmBlGMfRAS/pg3NFt+WRiE7QAmd4
         +l+Gj9tZCzAv1Viq8BXuY7kRWMWcMGyXlRv89acvMajpNr+3Q6r5i37EJNiJ7ee/HnY4
         Rg2Pv5s03vBo7b92Uz9U3cA4O80QNgw4OdvHYC+vTTQW0P1SpWO+E41wDA6UvHHxVE7m
         BeFFufkyZwyYFFhfg18IQSo9tR05OIiQZQ6WMI0xgYlzXGZx+gOcACw0ErhHqRd1DQ18
         AKW0CCZjroSfLLaROE0GEvRynTMAV7euDBcfNj89cEQgxVSDX5hArYIh/Rm9iFWv7yqy
         tgnA==
X-Gm-Message-State: ACgBeo0v1tyrrFfrsfMxCR8MFXSTQV+XeXHONMprE+Y9DcR9oXyyV7qK
        LyNfG+j4tFFiYSt4H1T0hXyojA==
X-Google-Smtp-Source: AA6agR4wxoZUg83IFf35QmSsc8I2+UGGkx7cAiV5AJbu7XOKEmmG2Nx4D0+JiaHZrrtQCA8c/aYRMQ==
X-Received: by 2002:a05:6000:18a3:b0:21f:d6a4:1aec with SMTP id b3-20020a05600018a300b0021fd6a41aecmr15458409wri.468.1660082728921;
        Tue, 09 Aug 2022 15:05:28 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:CXGB4 ETHERNET DRIVER (CXGB4))
Subject: [PATCH v2 24/26] thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:34 +0200
Message-Id: <20220809220436.711020-25-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  2 -
 .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    | 41 ++++---------------
 2 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 5657ac8cfca0..fca9533bc011 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1079,8 +1079,6 @@ struct mbox_list {
 #if IS_ENABLED(CONFIG_THERMAL)
 struct ch_thermal {
 	struct thermal_zone_device *tzdev;
-	int trip_temp;
-	int trip_type;
 };
 #endif
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
index 9a6d65243334..1d49cfe3e2ab 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -29,36 +29,12 @@ static int cxgb4_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int cxgb4_thermal_get_trip_type(struct thermal_zone_device *tzdev,
-				       int trip, enum thermal_trip_type *type)
-{
-	struct adapter *adap = tzdev->devdata;
-
-	if (!adap->ch_thermal.trip_temp)
-		return -EINVAL;
-
-	*type = adap->ch_thermal.trip_type;
-	return 0;
-}
-
-static int cxgb4_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
-				       int trip, int *temp)
-{
-	struct adapter *adap = tzdev->devdata;
-
-	if (!adap->ch_thermal.trip_temp)
-		return -EINVAL;
-
-	*temp = adap->ch_thermal.trip_temp;
-	return 0;
-}
-
 static struct thermal_zone_device_ops cxgb4_thermal_ops = {
 	.get_temp = cxgb4_thermal_get_temp,
-	.get_trip_type = cxgb4_thermal_get_trip_type,
-	.get_trip_temp = cxgb4_thermal_get_trip_temp,
 };
 
+static struct thermal_trip trip = { .type = THERMAL_TRIP_CRITICAL } ;
+
 int cxgb4_thermal_init(struct adapter *adap)
 {
 	struct ch_thermal *ch_thermal = &adap->ch_thermal;
@@ -79,15 +55,14 @@ int cxgb4_thermal_init(struct adapter *adap)
 	if (ret < 0) {
 		num_trip = 0; /* could not get trip temperature */
 	} else {
-		ch_thermal->trip_temp = val * 1000;
-		ch_thermal->trip_type = THERMAL_TRIP_CRITICAL;
+		trip.temperature = val * 1000;
 	}
-
+	
 	snprintf(ch_tz_name, sizeof(ch_tz_name), "cxgb4_%s", adap->name);
-	ch_thermal->tzdev = thermal_zone_device_register(ch_tz_name, num_trip,
-							 0, adap,
-							 &cxgb4_thermal_ops,
-							 NULL, 0, 0);
+	ch_thermal->tzdev = thermal_zone_device_register_with_trips(ch_tz_name, &trip, num_trip,
+								    0, adap,
+								    &cxgb4_thermal_ops,
+								    NULL, 0, 0);
 	if (IS_ERR(ch_thermal->tzdev)) {
 		ret = PTR_ERR(ch_thermal->tzdev);
 		dev_err(adap->pdev_dev, "Failed to register thermal zone\n");
-- 
2.34.1

