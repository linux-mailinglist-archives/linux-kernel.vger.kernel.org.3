Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC225806BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiGYV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiGYV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:29:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F624BE9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:28:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h9so17757644wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWFZXwysMvsN10lXDK6sChpf4X2qhnFs4AeSH8mvwTs=;
        b=V7mOn4CmTbqh6bMglDam17dQJNZ1uZrNkVGQ9enufVzer/0mK6rPnBa9tF2CYQq5cg
         vaNSspxKpPyqo32kEpyyS60GvsAsJWRR63UZwIyE/ZsQYTKhNDDJeYh/7BukklPce9nj
         PGeuq+xjSewtJiwagQ+ykjt7JcfqbcEpWEjmtFqX63+C+7ZHBBIApfDFjJUSg08iNFL+
         WMunOtTVpalGGXY+2NCGXOGoVwtIx7k67mk+Hgz6tL3ONvrQNdPzimxNLZdJ9A0zBcDU
         c4Tx1rEyKbqKRyH/VNBC6tDn3pUuPvQQkTcLEr0zeOECp+W8KVMi/sFUeokpdyPMEj7Q
         T+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWFZXwysMvsN10lXDK6sChpf4X2qhnFs4AeSH8mvwTs=;
        b=5AX6LQeBC2FoOPiDm2bkf7AIAOmOUDZN5De/9L+BF4Wo+XptQr7u+PJ2HsLX1QfAvq
         HoYWwtfQedgwUBabTotA+iQ34vTCjWwWotI8FVY+9e5TWZDfNBost1uvchQcoFmgkzZv
         8svdiQ35WBep3meOsygzs8IMX4/tSxGNF8NS8aTmiZmL1c0fIhUkU2fkN+tMWjaqMO6R
         H2wjhv6eHqFxVAuqURPtbNidLi/Irs7NknPcpWPNSjxjW58iaYOWA6cSbI6FPXGz3YfV
         N5x48bCgxMmAeGiVAFcB2UhBSw0WLZS/RFnsPiET4hU2npZPOYhUfVFXa5jidK+5NYSc
         lvZA==
X-Gm-Message-State: AJIora+T+M5+ogM/jWZEe7jwebV5pwMobblpTdVlQqzGJq1Kp8sHcKkA
        ZQvvLpcdw8J4WHTrHyqfPPL7Aw==
X-Google-Smtp-Source: AGRyM1sKKjruioCvoZ3EI2JZMo3qqzjeRP7j12dQmi1UnueZHyDTnJl5KV6/Y//5r/xXSnueikdBQg==
X-Received: by 2002:adf:e193:0:b0:21e:626c:d082 with SMTP id az19-20020adfe193000000b0021e626cd082mr8548154wrb.159.1658784480791;
        Mon, 25 Jul 2022 14:28:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:28:00 -0700 (PDT)
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
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v2 27/32] iio/drivers/sun4i_gpadc: Switch to new of thermal API
Date:   Mon, 25 Jul 2022 23:26:32 +0200
Message-Id: <20220725212637.2818207-28-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
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
 drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..13d1e937357c 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_get_temp(void *data, int *temp)
+static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sun4i_gpadc_iio *info = data;
+	struct sun4i_gpadc_iio *info = tz->devdata;
 	int val, scale, offset;
 
 	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
@@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = &sun4i_gpadc_get_temp,
 };
 
@@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
+		info->tzd = thermal_of_zone_register(info->sensor_device,
+						     0, info,
+						     &sun4i_ts_tz_ops);
 		/*
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
-- 
2.25.1

