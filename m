Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5357BDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiGTSTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiGTSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:19:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D68D6F7E2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:19:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so27295170wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7ClOaY29q/UhKGleJgriKV9seCgrAHzD4o55sbVqbE=;
        b=U25zxMuTlfG9FKoGJ8D0VJx2M73CYydlvOMHsJis/rV0YVmrC6mR0xG6wVsf0jVtsh
         LGYhX+2OZHZGLcWAYcBwN/kxj5pEKVfWT5CI5VYGAljVYrY+Tc6MtBikiOmQJ2WG1ElO
         ORuSxTh7fBcVgNVov8LDetdZJ0eiSyVtZZy/l1UjoMgZsBV8SEaNK5YFxMt6TSF63ODI
         ZSH8Q+t/5HwvjV+sbwr7RV8a1wYelm/dKcbV6mwjwG45OHZsG1YqVIniZL7nYRd1elvv
         rEW6Wxoz3UwFc07F5QgYKPyJCr2UYU/mr7bNC/sdKOddwNjIN8nGLWnMAxzpqeAOqmvF
         6cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7ClOaY29q/UhKGleJgriKV9seCgrAHzD4o55sbVqbE=;
        b=4TZClkZg3BAw/cJ4XdLvqYgdTVj7Q+pHb0lINWEPK3Dt8QtczYriL7I1ctRlHaNkug
         38SRrKW7jaPYQIvep6+/QsVrNQIlqZExfYLLg2CU+WYPB6EAWWEbeP2ZEaLSaoyMY0oS
         /R3YNuLctRz6nxlzyCWT3HCWAfJNny2cnTxy3uePnJt8PPWWZyehMzvxhjyIvCwzgUll
         slKf2eSMxTnfZ97et4Fll8QcuJ5Fa7+4ssQtWvzlBhIKXgG2rKg6knJSCQ90D5gTWLdW
         tqnmHV5+TrZUFwTzRZzAwDEVHP4LfkrVUjakwrdFv/ZnWtjPankHGd7tbI52vS7sH897
         iaNg==
X-Gm-Message-State: AJIora9IA0y8P0wLAEDJ61NhktcLwkGwr3XSsRG3lYmAAbdlIwyOdywb
        b7w932wQlQr2FBMxFhBlCg4Xuw==
X-Google-Smtp-Source: AGRyM1vfj2pobuNQH2wthtGApjgEuP8BunLn/EqZqFLAOjATur0M5PpTlWR4RkCynwXU5aGpbpkUkw==
X-Received: by 2002:adf:ee4b:0:b0:21e:4ecf:b150 with SMTP id w11-20020adfee4b000000b0021e4ecfb150mr2128791wro.290.1658341177830;
        Wed, 20 Jul 2022 11:19:37 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003a31d200a7dsm3400093wmp.9.2022.07.20.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:19:37 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v2 3/4] thermal: mediatek: control buffer enablement tweaks
Date:   Wed, 20 Jul 2022 20:18:53 +0200
Message-Id: <20220720181854.547881-4-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220720181854.547881-1-aouledameur@baylibre.com>
References: <20220720181854.547881-1-aouledameur@baylibre.com>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add logic in order to be able to turn on the control buffer on MT8365.
This change now allows to have control buffer support for MTK_THERMAL_V1,
and it allows to define the register offset, and mask used to enable it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 216eb0d61c5b..1dc276f8c4f1 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -283,6 +283,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -578,6 +581,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = ~0x37,
+	.apmixed_buffer_ctl_set = 0x1,
 };
 
 /*
@@ -1031,14 +1037,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
 	int tmp;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
+
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1138,8 +1148,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
-- 
2.37.1

