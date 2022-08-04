Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DD58A3B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiHDW4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbiHDWyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:54:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E060774CD7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:53:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z17so1362296wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kpAJvHnsGVgVYdV6CGwRXamKol+XLg/BJyowOdExSUs=;
        b=W3cU+eWftwod/gCCEn4RF6D7EDBHd9HP5Cy2gZBlBBe8SyqLB424UiO5yQ9/meWDAW
         tnLWYXRnRl1Ey5cgoNvNP7eFz9G5zR5z7h8meNq54WbpA63LDnP5UUpy6sZB+qk5mMoi
         Wq0tCL+soGYDBzUpQB19pONUQ1IFKfw/91eaM2V4KdbqTWeNaJLNDx1gs757ZOxhO5N6
         UCORYdZTHrwj+mPxVhQjmnqZXpn0eB4zHMqs/eAPkQoqsvsq8m5l38M1h/fpSMfHQJXS
         UqRikfL2/jGXGWXtTPSMcqjwCXygVwn7U9+i+xiOUiBRi7H9Any6ZVrjOsBsszElFiTs
         jsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kpAJvHnsGVgVYdV6CGwRXamKol+XLg/BJyowOdExSUs=;
        b=J3wZmbtrRok7VkvLyHnBfpuh3n9LKpMjpdV/iM/+joNAnnalMV/6J++h4HcKwMuA8A
         XkqjflUice/ogCIWQ8ypQHN1E5UCFuPdtYrRERYOKv4I81qSxV0Wtd4Zf1sHo8n9OeJp
         P9QDQfW4LTzBnE1BTfedv9TO4C6nJ3G2GJdms4AP9O1nw5gBsmIil5SvZionTk2Y/OxM
         wGAo5uVgw9j2jFigi8JHN2J2VWT3vgzNyrFwhUyQ/+gYrBxuM4oA/mmPxxkFAf9DLBIL
         QpwI7uphm4qTziqE75mdSC7xmttjF4IAWACZFfVSxi9PFHO6w2h1gUMSRphni2uGwj7N
         4KRw==
X-Gm-Message-State: ACgBeo3SAQpHgFa9n0/a//9J7sakqW6MuPaHDW26y6S/BdRilryCVkaL
        RmP08N1L72sQnGjQJx1nR99rdQ==
X-Google-Smtp-Source: AA6agR5Ha3VmIOQi6HqXaFNq4+uOYAdNMIGg2F5UmBMHHeRJ1PozwZCiQ9FAcStTb/q3qk7rfALfsQ==
X-Received: by 2002:adf:f386:0:b0:220:44e9:ea5 with SMTP id m6-20020adff386000000b0022044e90ea5mr2530945wro.555.1659653585234;
        Thu, 04 Aug 2022 15:53:05 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:53:04 -0700 (PDT)
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v5 29/33] Input: sun4i-ts - switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:45 +0200
Message-Id: <20220804224349.1926752-30-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 742a7e96c1b5..73eb8f80be6e 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -192,12 +192,12 @@ static int sun4i_get_temp(const struct sun4i_ts_data *ts, int *temp)
 	return 0;
 }
 
-static int sun4i_get_tz_temp(void *data, int *temp)
+static int sun4i_get_tz_temp(struct thermal_zone_device *tz, int *temp)
 {
-	return sun4i_get_temp(data, temp);
+	return sun4i_get_temp(tz->devdata, temp);
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = sun4i_get_tz_temp,
 };
 
@@ -356,8 +356,8 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
-	thermal = devm_thermal_zone_of_sensor_register(ts->dev, 0, ts,
-						       &sun4i_ts_tz_ops);
+	thermal = devm_thermal_of_zone_register(ts->dev, 0, ts,
+						&sun4i_ts_tz_ops);
 	if (IS_ERR(thermal))
 		return PTR_ERR(thermal);
 
-- 
2.25.1

