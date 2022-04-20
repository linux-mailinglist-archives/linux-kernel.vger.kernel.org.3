Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D4507E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358700AbiDTBTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358701AbiDTBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:19:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E72E6A9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:16:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n22so505990pfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=awQ89Q2eVIn5YtdJtEsw9K0fnZEisfTylDK7brSxfAI=;
        b=ZvuY6hhlzcCFNr5CrpHawrlh8ladPMknFoA86rFmUlkTMZDJDbdfPhhew6+FHWnpCk
         +FDTGNRKSL6QIZ2xIqtNOC/sETeJGWJUe0bPBqKynQWjbQslUqxhDEmyp1BlOL5IRviC
         BWNZTni9zkFf4LKtey1D+xcV8Yfo0Bg3jcI13oyBC3+Lup3dxUHY38P9sSDTNrtrvrvv
         TWKtpwT3B9Ga+HRSAp1CTjrdePoEprxGUxWsPSfW21CHJtUO8AGG/w1ySQ4fwygBSRNv
         Ga2bIo0qevA5EnuVJd1qATgck/fPo1TUk+pgAOBC3bHMrXG1LsedU9JnXS4qFxK03Q89
         5yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=awQ89Q2eVIn5YtdJtEsw9K0fnZEisfTylDK7brSxfAI=;
        b=W6BSfJ9+exXNEehT+ZSvYkIn2mA3ZUim6TcIuGGy9Og/zU9wdVRItj1Y3YkZMTpVIU
         WBYS7BD3qPo2j5lRJOt9k5a9D5VQ2tu6uQYpSVTRBkyQyP1c1c5IfZ7a26nsghdUtqGf
         fdoD8HPAF/fBMyQfiazojjyycJ82DWl3CuDdiHjvLOVhYlunvuh6F3aq+ehX/CH5cZHR
         Bdyi0DOIh2MoPTjuBQu1RE8ZNh/lCJ8jDhG+YirkxmS9sfLvbDOMfPpPQh6Y2qobk8LM
         KIubhjFDY9Ljp6EP2agBmDzRkyYh/Htfy/d8m+kgpDgRjkJdt3pqNta1kChkIjGTxQX3
         qYWw==
X-Gm-Message-State: AOAM5333juZOH6c9td3Eh4pmBw8h6ndn895aSUEcstq9vUsmLSH22XSQ
        44DlDchXAdY9A/U16ZZGDAU=
X-Google-Smtp-Source: ABdhPJzjbFBIwom0FEvdj81aRBOLVKoduObhzayfRfK9ccXI226pDSUG4+046qvUgjNopJQGP1k6rQ==
X-Received: by 2002:a65:6657:0:b0:381:1b99:3f04 with SMTP id z23-20020a656657000000b003811b993f04mr16771033pgv.512.1650417413525;
        Tue, 19 Apr 2022 18:16:53 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f33-20020a631021000000b0039dbae3fce0sm17926598pgl.43.2022.04.19.18.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:16:53 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: Fix error handling in analogix_dp_probe
Date:   Wed, 20 Apr 2022 01:16:40 +0000
Message-Id: <20220420011644.25730-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202204031935.5SkYsM2M-lkp@intel.com>
References: <202204031935.5SkYsM2M-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error handling path, the clk_prepare_enable() function
call should be balanced by a corresponding 'clk_disable_unprepare()'
call , as already done in the remove function.

Fixes: 3424e3a4f844 ("drm: bridge: analogix/dp: split exynos dp driver to bridge directory")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove the wrong return statement.
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index eb590fb8e8d0..474ef88015ae 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1698,8 +1698,10 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dp->reg_base))
-		return ERR_CAST(dp->reg_base);
+	if (IS_ERR(dp->reg_base)) {
+		ret = PTR_ERR(dp->reg_base);
+		goto err_disable_clk;
+	}
 
 	dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
 
@@ -1711,7 +1713,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	if (IS_ERR(dp->hpd_gpiod)) {
 		dev_err(dev, "error getting HDP GPIO: %ld\n",
 			PTR_ERR(dp->hpd_gpiod));
-		return ERR_CAST(dp->hpd_gpiod);
+		ret = PTR_ERR(dp->hpd_gpiod);
+		goto err_disable_clk;
 	}
 
 	if (dp->hpd_gpiod) {
@@ -1731,7 +1734,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 
 	if (dp->irq == -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-		return ERR_PTR(-ENODEV);
+		ret = -ENODEV;
+		goto err_disable_clk;
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
@@ -1740,11 +1744,15 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 					irq_flags, "analogix-dp", dp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		return ERR_PTR(ret);
+		goto err_disable_clk;
 	}
 	disable_irq(dp->irq);
 
 	return dp;
+
+err_disable_clk:
+	clk_disable_unprepare(dp->clock);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_probe);
 
-- 
2.17.1

