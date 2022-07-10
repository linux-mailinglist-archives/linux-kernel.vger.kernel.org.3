Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE456D19E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiGJV1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGJV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFA17063
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so4766850wra.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHt96uT4Q7BwS4NdRXSU1MVIN9ZQRmgKBYoUqlA70sg=;
        b=FTmtHevb/2lCiduv1bxN2jNSRFQIRp1jQ/TUsaCdBwAW/diJI+MM6X5FtZpJwCzVf3
         xFWyF1+0v3PX7grCleGiUZm577zgV6OCoxe/iNYb6agevNc8T+GA5VXWgMU5cpaWYEBF
         7FDYF6mc+ZQkiaNF9fOgCkXuuWuHDE3v6XnFCI0Lfr/ViYuHr7P9EZThxmTbJYEqO7Lc
         3kEoa0C2AA2hLg3U7vfgE7HgyBpa1NzcFta7EJPcXQvO8K+9vcDp834AfTGXBZ0+eZqT
         D/ZCenPS+afAUNbazuch9U8MPl56fezX+Sfhj2+98avOEg11/9H4dBRFDs+0XsBTrxTT
         nMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHt96uT4Q7BwS4NdRXSU1MVIN9ZQRmgKBYoUqlA70sg=;
        b=2LSj+rZCDRyGSROSoA9iDWYzJsW/g75iOUafr0PuXqdoLlqJ4VvIwjy4Uu6Bg/odIZ
         bMhaDQ/xMaJszumRaJKNuUYy4CD6jwxnaw1vKTytyJOzR96rRUQwfKvgeh8k7xSLV0rM
         Kt1qOWYjEUIYRbxpYDh7W4j9a+aRzl7dX+czAMcRmx0yVEfUNIqKIWETzYnOeRXorS9E
         S461lNUwjZzHCWUWOjKzh/M6wbNnCu6EbsC3wGRfev55oI9KkFoVGEkbr3AHo3bYJrf5
         6olyP2SqrIG+zfL60wyJqJTedhmvJ6HX6ZLcdt9ogbhubzNjmP5Ciz//Og3fxyMoF3Do
         Masg==
X-Gm-Message-State: AJIora9d+5TJgxyPcTzVLo3fTAYfs6MFC3CNQqCtqAthfHqx/mRabDUd
        HgkqxSBuXFU1JFJsFCiW/DUZjQ==
X-Google-Smtp-Source: AGRyM1uU2a9N+Tlm73VXF1neUxMMjGVz19hV+EhKo6BBv9h2XUa3CSeloMqm50v7vGSnm5mdnJA8Kw==
X-Received: by 2002:a5d:6d0d:0:b0:21d:7ae5:22ee with SMTP id e13-20020a5d6d0d000000b0021d7ae522eemr13289006wrq.152.1657488321495;
        Sun, 10 Jul 2022 14:25:21 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v1 28/33] input/drivers/touchscreen_sun4i: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:18 +0200
Message-Id: <20220710212423.681301-29-daniel.lezcano@linexp.org>
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
 drivers/input/touchscreen/sun4i-ts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 742a7e96c1b5..7cee09504e34 100644
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
+static struct thermal_zone_device_ops sun4i_ts_tz_ops = {
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

