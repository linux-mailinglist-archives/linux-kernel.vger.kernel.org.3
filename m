Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231AC587330
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiHAVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiHAVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:24:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB7F474D9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso91731wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=rnSdf34ppQwc5Nkd3K+nAm5rfz0D1n/7TsfmtPOQ1f7mfvoyRTd7aGjRBteP1mEdN+
         uVBIID0DG+4+m024say2o8PxQkOYfZ0QIyAOFRRR7k5/dnK4tQuTx5Y7WDh053BwGrsa
         +A+ZNLTLMilvUhUxT+OC2aPCpjTO2HszYS/Vc0/7ExTdHxmsAW/3Jdyz83TiRqsqgEjF
         9LZqo1QEvRbZuT/fWDM74u/vx6G4fcxxWGQJVyY2AXHLnHfttQiTGZ387t6jkx7EY/hC
         50srbspL/vHwENPwcw2Cyg77OAuzQOS1xo8XZDt6d1L2QWtFIGPSOnlHivkFQe8qxHsp
         ro/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=BAAWB5Ujcm3SCCeaAog4TarjGVNHTq2PiNGjlz28InpVn2qQBNEaMK5LSC3uI8nXbU
         P1jBIPTKZ0TwyKZL98Sjr7U8//RAdMLmyBRc2UfFqCJOeUqBPP1whn7S+TDLOIziE2Jf
         bSAse7FnG0bP+H8S6dr10kT2MHuC2coB5atrT/VJN1Pv9WJJbEj3dpX//dUJs0jeyRt3
         PytmlnAl6SA1Y7VQIPx2FdEGDSzOjnvAALnAl07aoufdsbDXoKAfYboHGKT4/by1Mban
         5t9ekbWWOJwHqXj8VmOcssm3xUXd2UzglDHwyOwaQV++BfCGmrWmsTD1J4wbCe/P6TH/
         5qFw==
X-Gm-Message-State: AJIora+YVE9nYaqKaO+hqkjsPvQR9NNSTyAjKtXuVpx1i5N+SSxRmW29
        O/ripuUdwwIW17Iih39jeAvrYw==
X-Google-Smtp-Source: AGRyM1slvTgDn6sgRazIRqP+eSIHwR/V7l6ZcALcqi4FTSW/Zf4wCKIgaAbHftBdfdT0uCu4GwD6LA==
X-Received: by 2002:a05:600c:1e03:b0:3a3:6cd6:1d38 with SMTP id ay3-20020a05600c1e0300b003a36cd61d38mr12395269wmb.25.1659389022220;
        Mon, 01 Aug 2022 14:23:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:41 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 15/32] thermal/drivers/db8500: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:27 +0200
Message-Id: <20220801212244.1124867-16-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/thermal/db8500_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 121cf853e545..cb10e280681f 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -58,9 +58,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -72,7 +72,7 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static const struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 };
 
@@ -182,7 +182,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
-- 
2.25.1

