Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64457FB24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiGYITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiGYITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:19:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22513CD6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u5so14853751wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=usxsP0K1Xc8cmseqwIYE6ZqiT92s9j11+9Dz8i0YM0g=;
        b=lv+HXPVhjb50QOdFMwn/gpk7Lionrt4BCfECLdNR9Hspn3noeqcc93vGQPMcdCDUTx
         qhnFcrQhGvnS3RekfHFvbZ5LXn2YhfxVLjbNmDuL/QLLOFsgVH7NM/iUcDAzLrKqrG5c
         2uvAOHu9IZDbNHdLNyoL5SS+k2cT7yZqdrUxLVa5T6kZTc0LgBVj52D7HNHCG5ycTthB
         NNdU+vF33FmkBJcwTvSBgPi0quhj2q4o+aUvXloYBnyYITv0pzHOQCEtx/rXjFKGrmE9
         cqwC2qKlWAF+zm3ZRW+vQcobEzJ+oz2tGh70NQwKumhg2KDi2izOik2P9vIfO7MkSzyI
         3qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usxsP0K1Xc8cmseqwIYE6ZqiT92s9j11+9Dz8i0YM0g=;
        b=DALoMTHfWV3EXohd7bPK7VuJ2LHUCTn6P+5FPSpm+knYcK0BJqW+Ty4aMWCgZhyd5l
         9hMhtSy92npDrGPu6b2aiNrvU43+IGsGkCh/QrfiGi0QGRC5TuivziZeoXeYc7JH4Lbm
         8O7leRjHf+0WIRm1PZj91s5ppv7iRLj+/R5GT/nWnqCNyJNzZqMCOHyyCgNEm7hNrqXg
         4WnY7GN3CZcsD0iJfF37olvy9Uk6qADHQHD0LCg7TeUKxNwXfRyDqp8Tr1UYi/FWicP2
         FXL4Ln2tTu6p1sCteGTdYQ9uO4v/w57Oxg2yPWywLVn/3vN5EIq2Ri31faTOSVBZXbnB
         uhbA==
X-Gm-Message-State: AJIora/58/jvAc5mq1cm9RT58whPUaTkwgdPSqqzLNChqaGwRWg4Q/s1
        0TAHSf2LBJpVObIiS8B6AU5dJQ==
X-Google-Smtp-Source: AGRyM1uyqjH/4hgu+UdZWfQezOgf1LqnW80TfiBg5gxjZZ5SFJbrEh87S3uipSb8IG/IhExuSyQQrA==
X-Received: by 2002:adf:fbc3:0:b0:21e:3c88:2aa1 with SMTP id d3-20020adffbc3000000b0021e3c882aa1mr7168379wrs.84.1658737151472;
        Mon, 25 Jul 2022 01:19:11 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm16695264wmh.33.2022.07.25.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:19:11 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP cap
Date:   Mon, 25 Jul 2022 10:18:52 +0200
Message-Id: <20220725081853.1636444-4-msp@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725081853.1636444-1-msp@baylibre.com>
References: <20220725081853.1636444-1-msp@baylibre.com>
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
    Changes in v2:
    - Fixup error handling path.

 drivers/soc/mediatek/mtk-pm-domains.c | 29 +++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index d0eae2227813..94ca8981f45e 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -240,6 +240,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	struct scpsys *scpsys = pd->scpsys;
 	bool tmp;
 	int ret;
+	bool strict_busprotect;
 
 	ret = scpsys_regulator_enable(pd->supply);
 	if (ret)
@@ -263,9 +264,18 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
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
+	strict_busprotect = MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP);
+	if (!strict_busprotect) {
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
+					      pd->subsys_clks);
+		if (ret)
+			goto err_pwr_ack;
+	}
 
 	ret = scpsys_sram_enable(pd);
 	if (ret < 0)
@@ -275,12 +285,23 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_sram;
 
+	if (strict_busprotect) {
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
+	if (!strict_busprotect)
+		clk_bulk_disable_unprepare(pd->num_subsys_clks,
+					   pd->subsys_clks);
 err_pwr_ack:
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_reg:
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index e788d6bdde9d..a50cfb926d22 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -8,6 +8,7 @@
 #define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
 #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
+#define MTK_SCPD_STRICT_BUSP		BIT(5)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.36.1

