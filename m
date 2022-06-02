Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57153BBF1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiFBP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiFBP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:56:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB62A80DD;
        Thu,  2 Jun 2022 08:56:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d129so5091543pgc.9;
        Thu, 02 Jun 2022 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tu7jo/PyJIG6BDHX/FMNU8mRbHE8qx0k2AbAIgv/aSw=;
        b=G4jo1+hJKSw+rgStl1RDyAKlzn6sdzcOvMqZYnRb8VwJFHqt9vu6FxzP5RWkU9flVa
         POSqy3npwwMgIp5CSWeCDD1msIdEE0UJjR37Kg9yk/7pXH7VhI0kAHk/vXVFVy9GnNUI
         7Ra/AA/R/y67VxnW+DDlOf2xtVdkxCiN+0ATosFJ6EvK/2SeZVEujPT0cCnykHN0NBo3
         5BgOwix0MqKOxrPNLprkQVdYsSeIRIywIv8Bq2NGzFpCOZUp8FGQ1iFf4Z+JZAO9jnpY
         WaV40vB+3QAwC94rW6xWVbh2i/NAqfm04HyesLf1jqelyBmJXGDRRXDPlTbh/y7gc5zF
         Uguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tu7jo/PyJIG6BDHX/FMNU8mRbHE8qx0k2AbAIgv/aSw=;
        b=frpS0vBl10al28JvSNxPXzcbHp+cMek5vk5BqvO6UtoHa6eSh8BguI7EWdtZX2FaaB
         YA15P28r3vvKAQYOjMI87DXJWjsX3HEeTH8mg/tpZwD6vpH+AOEtGV7M2uRl7z/McxPO
         cdVFMEDbjBogEBVMdyXA/8/ufUXzWTY28EVDb4oRY1xREIPj7iJGrKkCAAGp1rZ/ZIpl
         v9Fgj0tZusbOLNKccV1/Ppk4MGAZedqXoUla+/hbYUgHlm4uwZVbzoOupyib2lq3nhvY
         /KAKTM9NvNuVtIq+MD/HK8Saie3hUaWqH7SDVodQnd9LsirCSXzk4mjoiFv3z1ZTCkGw
         pqog==
X-Gm-Message-State: AOAM530P6u9Zm6gJlZj1wpAXt0Agt0SIfUXfBHm9hYKf4RQnC4pDSVhq
        dJ7iOn0CK2/OPnQGP9rRf4ny5a5clWIPzW0WsS8=
X-Google-Smtp-Source: ABdhPJwDRdxm8qjdYFCIqC2XRn1Qg5sgd/UC1C6tDrjH0A1hr+j6rW5IwdSM13nzTycWCfPhVjncMQ==
X-Received: by 2002:a05:6a00:815:b0:518:9905:de06 with SMTP id m21-20020a056a00081500b005189905de06mr5854249pfk.76.1654185384781;
        Thu, 02 Jun 2022 08:56:24 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id z15-20020a63b90f000000b003fc95548840sm3548205pge.36.2022.06.02.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:56:23 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/tegra: dc: rgb: Fix refcount leak in tegra_dc_rgb_probe
Date:   Thu,  2 Jun 2022 19:56:15 +0400
Message-Id: <20220602155615.43277-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
So add of_node_put() in error paths.

Fixes: format:d8f4a9eda006 ("drm: Add NVIDIA Tegra20 support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/tegra/rgb.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index ff8fce36d2aa..cef2b1b72385 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -196,12 +196,16 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	int err;
 
 	np = of_get_child_by_name(dc->dev->of_node, "rgb");
-	if (!np || !of_device_is_available(np))
-		return -ENODEV;
+	if (!np || !of_device_is_available(np)) {
+		err = -ENODEV;
+		goto err_put_node;
+	}
 
 	rgb = devm_kzalloc(dc->dev, sizeof(*rgb), GFP_KERNEL);
-	if (!rgb)
-		return -ENOMEM;
+	if (!rgb) {
+		err = -ENOMEM;
+		goto err_put_node;
+	}
 
 	rgb->output.dev = dc->dev;
 	rgb->output.of_node = np;
@@ -209,31 +213,34 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 	err = tegra_output_probe(&rgb->output);
 	if (err < 0)
-		return err;
+		goto err_put_node;
+
 
 	rgb->clk = devm_clk_get(dc->dev, NULL);
 	if (IS_ERR(rgb->clk)) {
 		dev_err(dc->dev, "failed to get clock\n");
-		return PTR_ERR(rgb->clk);
+		err =  PTR_ERR(rgb->clk);
+		goto err_put_node;
 	}
 
 	rgb->clk_parent = devm_clk_get(dc->dev, "parent");
 	if (IS_ERR(rgb->clk_parent)) {
 		dev_err(dc->dev, "failed to get parent clock\n");
-		return PTR_ERR(rgb->clk_parent);
+		err = PTR_ERR(rgb->clk_parent);
+		goto err_put_node;
 	}
 
 	err = clk_set_parent(rgb->clk, rgb->clk_parent);
 	if (err < 0) {
 		dev_err(dc->dev, "failed to set parent clock: %d\n", err);
-		return err;
+		goto err_put_node;
 	}
 
 	rgb->pll_d_out0 = clk_get_sys(NULL, "pll_d_out0");
 	if (IS_ERR(rgb->pll_d_out0)) {
 		err = PTR_ERR(rgb->pll_d_out0);
 		dev_err(dc->dev, "failed to get pll_d_out0: %d\n", err);
-		return err;
+		goto err_put_node;
 	}
 
 	if (dc->soc->has_pll_d2_out0) {
@@ -241,13 +248,17 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			return err;
+			goto err_put_node;
 		}
 	}
 
 	dc->rgb = &rgb->output;
 
 	return 0;
+
+err_put_node:
+	of_node_put(np);
+	return err;
 }
 
 int tegra_dc_rgb_remove(struct tegra_dc *dc)
-- 
2.25.1

