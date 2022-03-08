Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80B4D1466
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbiCHKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345718AbiCHKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230A42A18
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s18so3382499plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XAPYlXfrbQb3eNY+AafE+ihWQbItq1u/P6A4TCShoQ=;
        b=hFJUBUeTgT0nhSfBieWGKfelni90TSaIJERtQxilM8ZLSJl9NORTRX+eYAHr0Oo/KN
         rtF3oBwXKEbzQ5WY3SP7hQuS4sRXkse6SHLPPpMV5onMsLuGrNungp8YKWBWIjDI+jhQ
         KDmzDYVcK9y3FD/VsxCam5wouCWfbI/FbjoPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XAPYlXfrbQb3eNY+AafE+ihWQbItq1u/P6A4TCShoQ=;
        b=2GktULfR6Hx2al00onjobZY0vzsSYdNdL22XR2GYZNdzcNfu1MaOtTrxuhu5cvM7PU
         rUwM7Y0rBue5zKnqUbxDJTmYeqPG7H8CRzrG6nu5Z3ADtnLJKtbFpv4i7gEyG0DCAIWh
         aQ3UMvoDT6ORK+rHgE0F2/VsSas26Ei1cosHghW1IQ6MXpFrsGrEieilOxRRQf5GF0/9
         Dt3yj45XQu55U390/FWFWYtPvYkGOLVnGEOlrl9YtsWAKGPWa1i2sdroWs33dMQD8zbT
         xRRER6wTOcfsn6GEuH5YbVmm7fYzuhYIevJGsi2G37HfkkCj5lkEnRS3dVdcDhqeYOuV
         6fJA==
X-Gm-Message-State: AOAM531kKgFQ2KuxoNDCsJOHUo4EQxVJzUt+KMJ+G0cMzm5OhMmJTP3C
        ZyhScrx0lLM/sVc8JJqsOGY80Q==
X-Google-Smtp-Source: ABdhPJzGrWZUwCSTl12rRQJ06sxqRAcLOqol6JfTehC0xhhxAaiMBo1vwZYNvhWDGPkLqvhA3N3OEw==
X-Received: by 2002:a17:90b:4a92:b0:1bf:2a03:987c with SMTP id lp18-20020a17090b4a9200b001bf2a03987cmr3753511pjb.186.1646734224826;
        Tue, 08 Mar 2022 02:10:24 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:24 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 10/11] pinctrl: mediatek: pinctrl-paris: Simplify with dev_err_probe()
Date:   Tue,  8 Mar 2022 18:09:55 +0800
Message-Id: <20220308100956.2750295-11-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Use the dev_err_probe() helper to simplify error handling during probe.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 25d999848c2a..b587379eef4b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -1024,6 +1024,7 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
 int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 			    const struct mtk_pin_soc *soc)
 {
+	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pins;
 	struct mtk_pinctrl *hw;
 	int err, i;
@@ -1036,11 +1037,9 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 	hw->soc = soc;
 	hw->dev = &pdev->dev;
 
-	if (!hw->soc->nbase_names) {
-		dev_err(&pdev->dev,
+	if (!hw->soc->nbase_names)
+		return dev_err_probe(dev, -EINVAL,
 			"SoC should be assigned at least one register base\n");
-		return -EINVAL;
-	}
 
 	hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
 				      sizeof(*hw->base), GFP_KERNEL);
@@ -1065,10 +1064,8 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 	spin_lock_init(&hw->lock);
 
 	err = mtk_pctrl_build_state(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "build state failed: %d\n", err);
-		return -EINVAL;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "build state failed\n");
 
 	/* Copy from internal struct mtk_pin_desc to register to the core */
 	pins = devm_kmalloc_array(&pdev->dev, hw->soc->npins, sizeof(*pins),
@@ -1106,10 +1103,8 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 
 	/* Build gpiochip should be after pinctrl_enable is done */
 	err = mtk_build_gpiochip(hw);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Failed to add gpio_chip\n");
 
 	platform_set_drvdata(pdev, hw);
 
-- 
2.35.1.616.g0bdcbb4464-goog

