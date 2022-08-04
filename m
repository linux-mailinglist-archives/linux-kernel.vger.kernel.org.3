Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534758A397
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiHDWyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiHDWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B973935
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so1317645wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=f4QJf8ruUt+YX0IWOG7trN4ZQXuWHdSPHvGfzpjTqBk=;
        b=rvexQfHPZzZ0D0GkqyhLJgFnmk7R3q2g2qgNiF2HS6jGBCBhwo0ISJafzMy+JGDQAa
         o+DjjRHYAEu/LrFNS2puklAcJ/uJPc7dbbMky+y3poaBslmZ6H5t0DHrtg7CxcozwCoC
         /O0fGXHclLxaJXmJ2Zx+BI9V4aKmkwyAk9MVqk5wqs1Yj+U04G8l/aywlcVAFXQmUNx1
         YASI/NqbzbtmLZADj4Fj+Kx8An+imvG/YdTcvRdJ5u4ZmE2lgcX7fdTKUvjiignMXfXe
         59E1BL3Mp6I0z7rcuQch+JtP/7mSiQsBI20wAU64p5WLwZFWiTzq+PBTipdqZCqIoeft
         YJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f4QJf8ruUt+YX0IWOG7trN4ZQXuWHdSPHvGfzpjTqBk=;
        b=JidW8lSjhHRiI4Mm/PVVMyjaP0YX1+B0xq7pGG9i3t8IxqsXtz94+FUXDMErhvImbw
         +O6SX1CLlFcy4EswNYJzR7pwe9+d7GbBRW7AnLkIQ9QQfpx2ZJPfnmsIzLZpTua75vyY
         tATfEOWFdhGifyGH3ityA8YJHABr88VvW/nzfSj1Cf5cJpNI/rwLDWFjH+C+/tbo5Xd3
         gk9B/oLcF217WUn6HCB45vQtxWC3HNxcBmfAdCWqsWHnsAqmnbnoOn8QOOfKnOaB8RFq
         ltRJTvinLU9dsXvtub4dcM55RK/lV2bAAwnW0rgEI24WzCk7K16X3LVrUCrobTGkZ5NE
         fmHQ==
X-Gm-Message-State: ACgBeo2XECWC7w91WB4/x6N3IQF0qpUe0yKoWjZWbGSk3AUlVD0bExhi
        jpwxjT/yifioF5I6fsGziGv1QA==
X-Google-Smtp-Source: AA6agR6gXUzDG0SVDH9UUJyKV7MukOfFADrlBb8tsIlCRCKwbxjhGuEBW6mFCtVwwijD4CGvXUsgUg==
X-Received: by 2002:a05:6000:178d:b0:21d:a3cc:54c8 with SMTP id e13-20020a056000178d00b0021da3cc54c8mr2511734wrg.602.1659653563947;
        Thu, 04 Aug 2022 15:52:43 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:43 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v5 20/33] thermal/drivers/mtk: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:36 +0200
Message-Id: <20220804224349.1926752-21-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..8440692e3890 100644
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
+static const struct thermal_zone_device_ops mtk_thermal_ops = {
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

