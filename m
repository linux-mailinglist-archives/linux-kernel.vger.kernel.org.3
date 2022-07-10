Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C856D16F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiGJVZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGJVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EDA1570C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f2so4761460wrr.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKrmrf+cSxdde7+ZUymVasY3n7CrcY/HjZWqjqekd2E=;
        b=Q6/0d8VjALBuFP6Yp6/DDTv9I6sAEW6VuNJ0HRWOdbHFQXEGVkKwEqGlyKySV7oKc0
         zl9TgSS9dbQcAYqB5k9Qdc/MfOMbMV2wwJ6QehNTZv3ldzlg8dXldph6QRO0zqz9aAfu
         i8chWAUnWBSdBF8uVesQPWD8uDEJ4LcwFTxGHxBIZto03XxX6YqBUeS3SudWdspoFqOg
         gUMVqKEiza42aro7/7QSsT/ptwxZHZuNoP2d14R7J+6o4zaIrW4b5XGzJZ8vj6W0nvYu
         rw2FZyhy0mR8MvGud5WQVAUr5yrl1lXYKHyfitjIe4v2vcC6z0utO16kLSHFagt31w1H
         PZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKrmrf+cSxdde7+ZUymVasY3n7CrcY/HjZWqjqekd2E=;
        b=Hg/w1n/0WTF7sE9tsrirlKt1XH8NQDERNIkEeIxgfgjQrXm6zBmq6At4NC4tbrwJoa
         Lmsob9vJpc2/35rI0XIDjk7H2Y/MiCFX+KGYSuPlkaWmiGsJV6cSi5HQp3XT74OsF3JR
         sV02j6XJ000d3lXxloHE5N2CD3BKAH1drfEhEfFP2dGMhOwKGBpP7yuYhDJwNcB+4XQF
         qONC1coxnOQKSoJwrPhWbPC3DklxkoSpUMOpqU2cLRuklisaVq9R4I4+Xwe0k9A7wq/v
         o5A/ernpJb2ZYLA5gO6x84sltAAeMkWX0qh2BfW3PTqFzDE7iAkUuDgrmIuCIWL0orpP
         /yDQ==
X-Gm-Message-State: AJIora/FH5o3qoYQHSq3gH4iAAvjXU648TW9m0JiOiMgzPOtJ/XDM++j
        nEOBzH+Gu2tgOsAOk8v9clf9Sw==
X-Google-Smtp-Source: AGRyM1u2vq7qmaJGmyL9yhX5LXCLt9CoVTxexTX9SfZep/w9D5UJPtU+1Xzot74ix+2oUD+2qtF+9w==
X-Received: by 2002:adf:d4c4:0:b0:21d:6c8f:4da3 with SMTP id w4-20020adfd4c4000000b0021d6c8f4da3mr14085345wrk.325.1657488291458;
        Sun, 10 Jul 2022 14:24:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v1 08/33] thermal/drivers/sun8i: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:58 +0200
Message-Id: <20220710212423.681301-9-daniel.lezcano@linexp.org>
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
 drivers/thermal/sun8i_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23cbb671..d4e04c2c5135 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -108,9 +108,9 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
-static int sun8i_ths_get_temp(void *data, int *temp)
+static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsensor *s = data;
+	struct tsensor *s = tz->devdata;
 	struct ths_device *tmdev = s->tmdev;
 	int val = 0;
 
@@ -135,7 +135,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ths_ops = {
+static struct thermal_zone_device_ops ths_ops = {
 	.get_temp = sun8i_ths_get_temp,
 };
 
@@ -468,10 +468,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
 		tmdev->sensor[i].tzd =
-			devm_thermal_zone_of_sensor_register(tmdev->dev,
-							     i,
-							     &tmdev->sensor[i],
-							     &ths_ops);
+			devm_thermal_of_zone_register(tmdev->dev,
+						      i,
+						      &tmdev->sensor[i],
+						      &ths_ops);
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-- 
2.25.1

