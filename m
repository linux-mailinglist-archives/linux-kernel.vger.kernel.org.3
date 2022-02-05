Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36824AA55F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378906AbiBEBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiBEBsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:48:01 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D2C061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 17:48:00 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r27so10607471oiw.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 17:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwqiOxP9YHS7gWZlUy/Ide8I7ik75+E4L6SkE9qurM8=;
        b=SX/r8oivOKBmjoQGeU3nT0z9H54wk6+8Qa7bljk+63UOjxZcK/6NnqNHZFUHg7WVWb
         E3v+9gEV8s3ampzbdfmLyiLQGD5ZTXFho8wem7UQMnQQiTWOFEUrjkpGoOEpqCx+tKuR
         LlbVGCBtSpo3XWGtEyyQOSk9MQwUuWo58mv6m0OKtfTDN1aqDxvmcdPdBHDcBe4BGS9w
         c3oJ2afAsToUv4Qxv2CZEBfrYiHgJLHlLYOizaFgTs/Z4ImKVsRaFwZdp1vKZc1igZyo
         4RNAdg0iS5g/yVSFyRqgqdDp4C5ki0krTzMYKPBsXIhiwa5farpPM9bNzAiFVQgIEzpn
         iwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZwqiOxP9YHS7gWZlUy/Ide8I7ik75+E4L6SkE9qurM8=;
        b=ORrRvReDD4mVpv1nOzxWIn/Bl6EHrW6/9WkLoeA1pvMucHf/BnOGvHz9+iOnfOB0WA
         6+zg2IBzoiTbGungbc1/t+pMToAmnQXImEYWJ/8ntiEcFuDLQf6nMSb1e/utUIYWsWMH
         i235S9VgwmfWcJwEnBnwFOElpVTvLYqHXseXZXqGA5R1RWya6U3TEJz/RifWmAfYOhYU
         5iebXBzWOKH/6nvzeaWDIfkV2TcUKXP6E8xmfqvXs5UDy4KcfxLN1Qepq0LQfTcm2Q1E
         iINqiB62VZH75J0EZaYA1eK5RGf3a32YmPyG830JmtGhzFnZxWX35KzBnvxjTUTTQf3Z
         LGNQ==
X-Gm-Message-State: AOAM533JZcviUAfQk/UWVnTHyx/V1AziJUXrptizTgZEksgtzEUGsXlZ
        JcKeQZShblnKRc92rg/hE48=
X-Google-Smtp-Source: ABdhPJxkpdnDdeyiK3lUeHlxYFtvl95BTBfOP8qe7nRcTa/6HHnRa20lNjWX7rVjOgbQPJ9grHzYhQ==
X-Received: by 2002:a05:6808:17a9:: with SMTP id bg41mr852705oib.41.1644025679729;
        Fri, 04 Feb 2022 17:47:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v31sm1422052ott.25.2022.02.04.17.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 17:47:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mark Brown <broonie@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] Revert "ASoC: mediatek: Check for error clk pointer"
Date:   Fri,  4 Feb 2022 17:47:55 -0800
Message-Id: <20220205014755.699603-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9de2b9286a6dd16966959b3cb34fc2ddfd39213e.

With this patch in the tree, Chromebooks running the affected hardware
no longer boot. Bisect points to this patch, and reverting it fixes
the problem.

An analysis of the code with this patch applied shows:

        ret = init_clks(pdev, clk);
        if (ret)
                return ERR_PTR(ret);
...
                for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
                        struct clk *c = clk[data->clk_id[j]];

                        if (IS_ERR(c)) {
                                dev_err(&pdev->dev, "%s: clk unavailable\n",
                                        data->name);
                                return ERR_CAST(c);
                        }

                        scpd->clk[j] = c;
                }

Not all clocks in the clk_names array have to be present. Only the clocks
in the data->clk_id array are actually needed. The code already checks if
the required clocks are available and bails out if not. The assumption that
all clocks have to be present is wrong, and commit 9de2b9286a6d needs to be
reverted.

Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: Mark Brown <broonie@kernel.org>
Cc: James Liao <jamesjj.liao@mediatek.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Daniel Golle <daniel@makrotopia.org>
Fixes: 9de2b9286a6d ("ASoC: mediatek: Check for error clk pointer")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/soc/mediatek/mtk-scpsys.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 670cc82d17dc..ca75b14931ec 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -411,17 +411,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-static int init_clks(struct platform_device *pdev, struct clk **clk)
+static void init_clks(struct platform_device *pdev, struct clk **clk)
 {
 	int i;
 
-	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
+	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
-		if (IS_ERR(clk[i]))
-			return PTR_ERR(clk[i]);
-	}
-
-	return 0;
 }
 
 static struct scp *init_scp(struct platform_device *pdev,
@@ -431,7 +426,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 {
 	struct genpd_onecell_data *pd_data;
 	struct resource *res;
-	int i, j, ret;
+	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
 
@@ -486,9 +481,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	pd_data->num_domains = num;
 
-	ret = init_clks(pdev, clk);
-	if (ret)
-		return ERR_PTR(ret);
+	init_clks(pdev, clk);
 
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
-- 
2.35.1

