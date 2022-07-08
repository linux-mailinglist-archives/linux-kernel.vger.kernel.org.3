Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3E56C308
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiGHUz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiGHUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:55:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED021833;
        Fri,  8 Jul 2022 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657313667; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/je/yixPYeA/QHCrkMiLMxqQF45GlsX63kQIV1/14JU=;
        b=N5DYcY6vfio+hGOYhjp5KGAwIn0xck8GrJpptyYgr9A91DSQmVmuginnSV4Tm1tHgHorjd
        GRdvIpaxt+DL7FnRb4LbfStQe34uwvlnsGWaWwcYODG2lPUjTLRv0YmqTLctf6/TOQavsq
        bZ5+cg9MeLHh8hcb+Wsy+QSRfyEqE2k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/6] drm/ingenic: Use the new PM macros
Date:   Fri,  8 Jul 2022 21:54:06 +0100
Message-Id: <20220708205406.96473-7-paul@crapouillou.net>
In-Reply-To: <20220708205406.96473-1-paul@crapouillou.net>
References: <20220708205406.96473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use DEFINE_SIMPLE_DEV_PM_OPS() instead of the SIMPLE_DEV_PM_OPS()
  macro. This makes it possible to remove the __maybe_unused flags on
  the callback functions.
- Since we only have callbacks for suspend/resume, we can conditionally
  compile the dev_pm_ops structure for when CONFIG_PM_SLEEP is enabled;
  so use the pm_sleep_ptr() macro instead of pm_ptr().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 98ff038d95d6..d5dcff59b9a8 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1470,21 +1470,22 @@ static int ingenic_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused ingenic_drm_suspend(struct device *dev)
+static int ingenic_drm_suspend(struct device *dev)
 {
 	struct ingenic_drm *priv = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_suspend(&priv->drm);
 }
 
-static int __maybe_unused ingenic_drm_resume(struct device *dev)
+static int ingenic_drm_resume(struct device *dev)
 {
 	struct ingenic_drm *priv = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_resume(&priv->drm);
 }
 
-static SIMPLE_DEV_PM_OPS(ingenic_drm_pm_ops, ingenic_drm_suspend, ingenic_drm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ingenic_drm_pm_ops,
+				ingenic_drm_suspend, ingenic_drm_resume);
 
 static const u32 jz4740_formats[] = {
 	DRM_FORMAT_XRGB1555,
@@ -1615,7 +1616,7 @@ MODULE_DEVICE_TABLE(of, ingenic_drm_of_match);
 static struct platform_driver ingenic_drm_driver = {
 	.driver = {
 		.name = "ingenic-drm",
-		.pm = pm_ptr(&ingenic_drm_pm_ops),
+		.pm = pm_sleep_ptr(&ingenic_drm_pm_ops),
 		.of_match_table = of_match_ptr(ingenic_drm_of_match),
 	},
 	.probe = ingenic_drm_probe,
-- 
2.35.1

