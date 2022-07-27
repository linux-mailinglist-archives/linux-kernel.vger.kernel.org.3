Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73458349F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiG0VEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiG0VEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:04:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179A5F99B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bn9so15199379wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4QJf8ruUt+YX0IWOG7trN4ZQXuWHdSPHvGfzpjTqBk=;
        b=139xpVPAbf4/6WQEmBothCI7+YWLiMxD7qqrCd14879SEYl9In9xOYAqQy/QRY4JMc
         A7I6mNxWd/1YV/TMoH6KcBJw0Vpnt1faNDgLl30hkJvKCn/wKeqRly2ZYlxEOSv+e6nA
         SxTl6jOPVh6gglT2H5OjVlVkvv6Nj63MXLXIogPLt1S+BwZUv+HQMK4/6Vux+8+gPiLU
         ik+4fis2qt94kCpQbz7nP6W736pm1lopr6/RClgEDQLC4b8owDW11BTXDfBdyCsGKppB
         f5M/Z/rDCQbVPHYFjn6P9r4Hqftz2pEE9+I7sX0NI8MHZmPnILhFUSPpmDonqh7Z73E7
         lpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4QJf8ruUt+YX0IWOG7trN4ZQXuWHdSPHvGfzpjTqBk=;
        b=s0f9dNwt9WEwGIa8ytTFUB2xIwM5qEcop4pEfVpjx7OlP2M/eEkeSenivqfDbLl08w
         3Lnd0lrwVD+iZ9lopyrkNcS2JTijlNIOFc/5nEc2hd/LPUcJZr11L3cUv12/cXHcOH/6
         xgy9OEIWzWx1kw/J0vlaiPh1GUYKEYRyNTKTAI3sfM1UwuTOf2K4Qe6IzsU2tIVNk0bH
         ikcBkAto5px3eCKw2bYvDkcEaKegKHYFGZHXUJjEnt3hS8TUUnHYx9pvQNBcpxxttTnI
         9hmAwdFYbaXbIZbaXyDhLVIpk20w9/zeAlYmSR9PZiO71dDWIwgax3A5aFYtWG+tfEUX
         wPNg==
X-Gm-Message-State: AJIora9VdM+C/s2TlhiMYfJ/BrdLMOqv8UHV0uwhcdl/BvBLlrSaTdmR
        Mmb7XvjURRgVMA7eP7x1ngAvgw==
X-Google-Smtp-Source: AGRyM1uKDZW3ud2tPr2zObS8Pq1dlFDn2x8npRuWqIBVJ6Ty2tIw4bgvpOrIrm1bV2Lq2c5Wny1rjw==
X-Received: by 2002:adf:e7c9:0:b0:21d:8716:e08d with SMTP id e9-20020adfe7c9000000b0021d8716e08dmr15451054wrn.328.1658955838331;
        Wed, 27 Jul 2022 14:03:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:58 -0700 (PDT)
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
Subject: [PATCH v3 20/32] thermal/drivers/mtk: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:41 +0200
Message-Id: <20220727210253.3794069-21-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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

