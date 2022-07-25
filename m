Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEF580687
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiGYV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiGYV1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8F240B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v13so9936735wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qNXTGFtlOgyRJms2wUe/LQRkw+99ki5ct4br/6n4uE=;
        b=XdQdxFqdCPRzQjqkYI9DJuVc0edMPZ6KXjrhfZq41nvJ1DD5Stjy5OW6vWLvh5lem0
         OmuFjP2dNETxSp5XVdR0mZYgdmGnedKJ5udZOLSEEPfujrHhogtWIVkUdBhHsruxwKtz
         803ilMtRg+QvItwk9rfhwDnMWBSjGZaqh/CjQDfNfuFEjqDUTK8cHunW2MMHU8fAVZQK
         AvBEfKfnxziiPWZrb+9jb2DjZJjZBRi9mpSx/RcjUUnbR0/sdQ/s5hTCjlI1LHi54RrL
         w/dqG9YFPMFvyuDgvZkRLM2zl6o3xCGgvpWeRvb3Qrronq7LKdiJn4nAYcdC6I0etC/R
         0rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qNXTGFtlOgyRJms2wUe/LQRkw+99ki5ct4br/6n4uE=;
        b=qEy2iQSSZTCwA6WaLp1tw/f+vnt5fMTvhr6JRxAzS8HV6E2J8j8zjB60dzK9HwrchU
         AYlqGZwWonWJ5PhmGOYw8OOS8xiq31rcNaEO385ifhXUo2aeL2tniU3B9eexRsfW10UH
         ZkgttqNqkVtmtjaLRo9gJe9PZn3YsINaD+YJsblPpiORZMGA8gHS2T55JyMGKUZh4Xkr
         0mcLpQxv1HhCl7a3cG2GrfbttE+vq0ABGeHDOQskNAs6gp0XrAuX55rOMK3q7r/E4Zj+
         eCAklZh4pJGVIP8Km0WsIFSmTgbDtD7cqLHrXMbZMpGLqLdInum5rghuKOpjyNuWakJ9
         xeiA==
X-Gm-Message-State: AJIora8bJn1yZtd93rQ7qoFd8fwX6fPcXFl+vAyrZ4LEd5AHVP5zYxtM
        U60Hb4cIzqaz9zf+TWKISEdljw==
X-Google-Smtp-Source: AGRyM1sLUT0joL0hR1OfWCgGnX88VgtKmYJJhqTtx7xvxYTVrSdiXGRDwqWfdapBTU9hc2NeKn4Qkg==
X-Received: by 2002:adf:ce0c:0:b0:21d:929e:1522 with SMTP id p12-20020adfce0c000000b0021d929e1522mr8332671wrn.126.1658784423697;
        Mon, 25 Jul 2022 14:27:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:03 -0700 (PDT)
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
Subject: [PATCH v2 06/32] thermal/drivers/mmio: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:11 +0200
Message-Id: <20220725212637.2818207-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
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
---
 drivers/thermal/thermal_mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 360b0dfdc3b0..1bf1a16533da 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -20,11 +20,10 @@ static u32 thermal_mmio_readb(void __iomem *mmio_base)
 	return readb(mmio_base);
 }
 
-static int thermal_mmio_get_temperature(void *private, int *temp)
+static int thermal_mmio_get_temperature(struct thermal_zone_device *tz, int *temp)
 {
 	int t;
-	struct thermal_mmio *sensor =
-		(struct thermal_mmio *)private;
+	struct thermal_mmio *sensor = tz->devdata;
 
 	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
 	t *= sensor->factor;
@@ -34,7 +33,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static const struct thermal_zone_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
@@ -68,10 +67,10 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							    0,
-							    sensor,
-							    &thermal_mmio_ops);
+	thermal_zone = devm_thermal_of_zone_register(&pdev->dev,
+						     0,
+						     sensor,
+						     &thermal_mmio_ops);
 	if (IS_ERR(thermal_zone)) {
 		dev_err(&pdev->dev,
 			"failed to register sensor (%ld)\n",
@@ -79,7 +78,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal_zone);
 	}
 
-	thermal_mmio_get_temperature(sensor, &temperature);
+	thermal_mmio_get_temperature(thermal_zone, &temperature);
 	dev_info(&pdev->dev,
 		 "thermal mmio sensor %s registered, current temperature: %d\n",
 		 pdev->name, temperature);
-- 
2.25.1

