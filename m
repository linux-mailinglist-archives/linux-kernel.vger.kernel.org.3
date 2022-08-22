Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B859C1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiHVOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiHVOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:45:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35A186E7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:45:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r16so13503676wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bSMvzF6WPZ8nDQB+J28VbvrCg97cVH3Ebn5HDrB27ak=;
        b=m4y+Z+22JbZ0Ly6iBmFidAPZbkvp3PPRC8y3oYtfAFQ6zt8Qsv0eBQvfUmbwvpR5Fz
         6FfER971HaLEhnRP4cPVeZI966k6CvgqRYCznu2N07D+STkzGsmBCWwAs27GojNTHxAb
         gfgGQK7gfmYhtspMaXzBNGZI8QN+iNbbEWfO1RD64+OxUeqMNHNXqtJWfrO1YBcgZvf/
         ltLGBra18ZmCpSqLGVqMvGQr3CEgFaReGa7JDnqLUfwStl5qtHpUwTTTGLIKZQ+JRo2D
         SDXJAvjea+okphduoXudm34rEiqTE6SIaK/Nn5GnhZyUjgypTOvG5JnUFCysgq1kcBWA
         A+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bSMvzF6WPZ8nDQB+J28VbvrCg97cVH3Ebn5HDrB27ak=;
        b=j1PEzIMALhdAEMn67SRzQdAvG13QFn0CDBXSYDCEkk4uF3Mz3Ss3ilFk3bCExtFSTo
         9I832XTptu4vElLwVjowp/rNWLEUkF1Dwk25XgX1oGrlp5qsvAPOlbmLaqaKKMIy7u7r
         ilnjFDnoXlTd14+SeDyrFQdr/4jrrtoJoE6S5PwdtotWzJFy7OndpMQSbNuJd3MlsEkd
         4iTwEEsnnDht1fLQ/U3jQSBEpmMTj5Tw31Du/EBBdTtteyOM6B6mwV1LVt2KKXhJEaXi
         3lk4lJSngIF65JH432v5O3oDz7XBfJFrhHY94d6Is2SuPgRLAEVcTHPlchYMV5bolQzV
         GzoQ==
X-Gm-Message-State: ACgBeo12YYDQjEUno8RKk0PH7iuCJOr3XJqh3T0rNue7VbKqM/lvcj6V
        L84nuG0GtTLt+Xy9fMi+aq4C1A==
X-Google-Smtp-Source: AA6agR5R6cBNc/betWL+bcg9LDkG0egcM3JtWWDX14j+emkuV8ZDXIYqm2augz26Mh+LKIlQ0llVbw==
X-Received: by 2002:adf:dd0f:0:b0:225:1fd6:66d9 with SMTP id a15-20020adfdd0f000000b002251fd666d9mr11085044wrm.42.1661179524224;
        Mon, 22 Aug 2022 07:45:24 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003a5dadcf1a8sm14670935wma.19.2022.08.22.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:45:23 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP cap
Date:   Mon, 22 Aug 2022 16:43:02 +0200
Message-Id: <20220822144303.3438467-4-msp@baylibre.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822144303.3438467-1-msp@baylibre.com>
References: <20220822144303.3438467-1-msp@baylibre.com>
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

From: Alexandre Bailon <abailon@baylibre.com>

This adds support for MTK_SCPD_STRICT_BUSP capability. It is a strict
bus protection policy that requires the bus protection to be disabled
before accessing the bus.
This is required by the mt8365, for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Changes in v3:
    - Rename MTK_SCPD_STRICT_BUSP to MTK_SCPD_STRICT_BUS_PROTECTION
    - Remove extra bool variable reflecting the capability
    
    Changes in v2:
    - Fixup error handling path.

 drivers/soc/mediatek/mtk-pm-domains.c | 27 +++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index c2cbe0de6aa1..d323275aa11c 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -303,9 +303,17 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
-	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
-	if (ret)
-		goto err_pwr_ack;
+	/*
+	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
+	 * stricter, which leads to bus protect release must be prior to bus
+	 * access.
+	 */
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
+					      pd->subsys_clks);
+		if (ret)
+			goto err_pwr_ack;
+	}
 
 	ret = scpsys_sram_enable(pd);
 	if (ret < 0)
@@ -315,12 +323,23 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_sram;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
+					      pd->subsys_clks);
+		if (ret)
+			goto err_enable_bus_protect;
+	}
+
 	return 0;
 
+err_enable_bus_protect:
+	scpsys_bus_protect_enable(pd);
 err_disable_sram:
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
+		clk_bulk_disable_unprepare(pd->num_subsys_clks,
+					   pd->subsys_clks);
 err_pwr_ack:
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_reg:
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 974c68a1d89c..493f3fa14612 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -10,6 +10,7 @@
 #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
 /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
 #define MTK_SCPD_ALWAYS_ON		BIT(5)
+#define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(6)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.37.2

