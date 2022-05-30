Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05638538847
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiE3Uml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiE3Umd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:42:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD98D25290
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:42:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so151784wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfRzRz9zY+mWQeLzIoLCLlJA3rGJuwiAX+1Eau/u4p4=;
        b=OjKjf6rUbb5SpHdfuQH/imC6NIGGZ3P6M75JaF7jECTByieFVd1TOqOnYXpvC0Xfnl
         kfuspj+G1QyOLBh5ycOvIDKPEaJpzXwRasjKFwdTVZX+NCHgfJxPMWEQnOa4b7AQ71EH
         EHzNtZZQhJgqZQxFQ/zf9FKMzmL1isRwROY615/pxsGSyD2GBYUJv9t8Za7onN8ZMiKb
         5ziqKRVwUiCvD4Kl0L1TFAlFgHqF9+MiZjI3RA1MsLUFL5UUJFNmYpOCEqe70vM6Ox/e
         7hWYxIS0wN5QzYQ3+Wgepr65/WYoGz9FitNkxZIpVpVxrjl6s77g2vP1cmz/I5bO9hVJ
         TmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfRzRz9zY+mWQeLzIoLCLlJA3rGJuwiAX+1Eau/u4p4=;
        b=WvpAIxUgaYNMUHt/f2XxBj8SzuQawACkWCSBPTldlnqrifkjbZxGhJRbHzwMw0qEcK
         pbBRKftyS9mjmZZ+rLOrZ4CtvfWVEsbu0LTd2MJYpG/AXVTJj/KOmaliQb86l5lXIsEv
         vLrpjMYp9/SwULBmakC0nnR8o+EBS+IlpHFzzVktwuBiJ6MQlJrgVoP4+JxYtreZC/Pq
         rHtsHDHXCwINnC0th25qWwK8ztaaTASGpREGnhOBMIKZaKEgKOjO+5HHk3+9dSMtSu87
         nu+p8/6/V5KgIDA0I+WJ4EOR8I4jyil3C2evTrJzPKQ38kHyw/Or7s4IsrKIMf5YeQRD
         s84A==
X-Gm-Message-State: AOAM532iWYsOZshAR91ECNqQe/0EV7/vOAypzXU8Omh/G3t7/SEik870
        81kouvK1aZCK4kRuMY4g3zDKng==
X-Google-Smtp-Source: ABdhPJxK0D0IN4lwSq73zpNlpbs45dPOpaoXgVGrmOvGp9YvwJOGUYq8ZhEMazBS/AVR3tG2t4BOCw==
X-Received: by 2002:a05:600c:3849:b0:397:89ce:289 with SMTP id s9-20020a05600c384900b0039789ce0289mr16587313wmr.104.1653943351285;
        Mon, 30 May 2022 13:42:31 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a7bc74d000000b0039b17714eb2sm262253wmk.34.2022.05.30.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:42:30 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP cap
Date:   Mon, 30 May 2022 22:42:13 +0200
Message-Id: <20220530204214.913251-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530204214.913251-1-fparent@baylibre.com>
References: <20220530204214.913251-1-fparent@baylibre.com>
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

This adds support of MTK_SCPD_STRICT_BUSP cap.
This is required by the mt8365, for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 37 ++++++++++++++++++++-------
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 90b91b3b19a8..beaa5785fda2 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -263,17 +263,36 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
-	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
-	if (ret)
-		goto err_pwr_ack;
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP)) {
+		/*
+		 * In few Mediatek platforms(e.g. MT6779), the bus protect
+		 * policy is stricter, which leads to bus protect release must
+		 * be prior to bus access.
+		 */
+		ret = scpsys_sram_enable(pd);
+		if (ret < 0)
+			goto err_pwr_ack;
 
-	ret = scpsys_sram_enable(pd);
-	if (ret < 0)
-		goto err_disable_subsys_clks;
+		ret = scpsys_bus_protect_disable(pd);
+		if (ret < 0)
+			goto err_pwr_ack;
 
-	ret = scpsys_bus_protect_disable(pd);
-	if (ret < 0)
-		goto err_disable_sram;
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+		if (ret < 0)
+			goto err_pwr_ack;
+	} else {
+		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+		if (ret)
+			goto err_pwr_ack;
+
+		ret = scpsys_sram_enable(pd);
+		if (ret < 0)
+			goto err_disable_subsys_clks;
+
+		ret = scpsys_bus_protect_disable(pd);
+		if (ret < 0)
+			goto err_disable_sram;
+	}
 
 	return 0;
 
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index a3955d960233..5347471bc3c4 100644
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

