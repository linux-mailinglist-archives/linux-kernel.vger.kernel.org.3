Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436253CAA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiFCN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbiFCN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:27:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AEE1274A;
        Fri,  3 Jun 2022 06:27:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so7198080pjs.1;
        Fri, 03 Jun 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGYGCHPMc2wMb8+o7znOSNlSgZiftTrEQzD43QCV+90=;
        b=i+7jqG7KVpeeNJ6V0vSnIFfrYVTh3rBccm8ii5aNFr8oAtqmONw/g0UFyZdHC+/HlS
         CFMib75eX8uio37b5hjw6af7cqpT+gCDcEs57LXHZoQ/5Nxl5fok9aPlsyOgpAofkSgS
         UA+f5V66+4EEBe6I6tCrHosahkwoXlGAwaojY4YDiZ6foQ+jH9aQs8gNwLxqCwgYHS3B
         P1wVqrLLMJR2WkCVGuHHiynWC2mKpRTIfpu3BsaC7Wa6PkWZFP6PeiA6HqtUV62lpa0v
         fnl+5xHFwdmwR5L4aEdBL1yVEABKWAZZhS/gCkAYrf6SOkV0fdHT6GMP9XFZYGPGbioG
         HxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGYGCHPMc2wMb8+o7znOSNlSgZiftTrEQzD43QCV+90=;
        b=XV/ow0Nn98c6MbjE/Vz6njzFk8y4VNOFtwA9pfNIoN3yGxNGi9yZ/aLBiLJf4sG2Zh
         xjlAd8NkqoxDq7X9HRArWf0Ev9LYG5gZ7fAgS5TLLlqsx1aGWjr2BkSi0zsoPNyHDEjZ
         Cd/Yj+HBjKk0Zc2stiCwwdvhZh1qmdHqJH7nk1ew5WZOSOMUL+mXfndoV524WnVLwjU4
         Wh+kfv8DJQR21SZqN7qniQ6L8e88WTQXYA3io8Pk8TDzbP9am0rO+7Mm36MX6W4dDoBH
         Va7HBXcgp/deN6Jfl1CRbwJvK9PDIf0NT3eoXVtEx8NAtRwFlAQTSys/8qBV0cyvza8P
         rk3g==
X-Gm-Message-State: AOAM533kyKeCrB52fgK84cGV8EQnGxbB5VaGhZGFJHIU7HVVnqVnUBYq
        /as+Eqh/fWLojh1dlL05GD8=
X-Google-Smtp-Source: ABdhPJzluHIhouQf927OhbZ6lRASEW4yUSiTagVN/uhD04GCE3ApYGm7UAFAiucHC3zND3JTXTWVRA==
X-Received: by 2002:a17:903:22d0:b0:164:ec0:178c with SMTP id y16-20020a17090322d000b001640ec0178cmr10442663plg.127.1654262833917;
        Fri, 03 Jun 2022 06:27:13 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l24-20020a17090ac59800b001e25e3ba05csm8536780pjt.2.2022.06.03.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:27:13 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Zhang <markz@nvidia.com>,
        Terje Bergstrom <tbergstrom@nvidia.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] drm/tegra: dc: rgb: Fix refcount leak in tegra_dc_rgb_probe
Date:   Fri,  3 Jun 2022 17:27:03 +0400
Message-Id: <20220603132703.42085-1-linmq006@gmail.com>
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

Fixes: d8f4a9eda006 ("drm: Add NVIDIA Tegra20 support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/r/20220602155615.43277-1-linmq006@gmail.com
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

