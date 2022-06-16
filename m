Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605654DB70
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359168AbiFPHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPHX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:23:57 -0400
X-Greylist: delayed 68267 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 00:23:55 PDT
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C3C3630F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:23:55 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655364220tyuagdlm
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 16 Jun 2022 15:23:33 +0800 (CST)
X-QQ-SSF: 01400000002000D0M000B00A0000000
X-QQ-FEAT: hR9GyqeohSiJBYTk+od0+lv++0Drp2ggk1O87ehDvPVH2JX41fZIZnXCoewT9
        TvOgRgq9lVfPm0SlkOBg/+/dgKmP5Dzt0drUXwhgN8R93L+T0Zp4KSovkT1dPALxMg/IQfL
        RBcW5ySW1hUXBXv/mduoWlWrFI5HvhFqXSH77EulhOr4Ica2nZwXQlFQhuMQlf8stKZLM8P
        TP7X4WgIl5QbsfoimPYgTJ9fRL1JsGn0gwq/w3fpgLasqQ8P1KlYVhziuulIozvFw7Xb07h
        bkPzEW0TqvRHqZmEFVskxWZrIU8nI7SCXjwsnBU/paad1lTQNLDn1JfMkFnMpV858Xicslp
        pikr4+oLT6sVb4zG5jbg51o21kVPA==
X-QQ-GoodBg: 2
From:   hongao <hongao@uniontech.com>
To:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hongao <hongao@uniontech.com>
Subject: [PATCH] drm/exynos: replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date:   Thu, 16 Jun 2022 15:22:33 +0800
Message-Id: <20220616072233.8302-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once EDID is parsed, the monitor HDMI support information is available
through drm_display_info.is_hdmi.

This driver calls drm_detect_hdmi_monitor() to receive the same
information, which is less efficient.

Avoid calling drm_detect_hdmi_monitor() and use drm_display_info.is_hdmi
instead.

Signed-off-by: hongao <hongao@uniontech.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 7655142a4651..17e9f5efbcfc 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -893,7 +893,7 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	if (!edid)
 		return -ENODEV;
 
-	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
+	hdata->dvi_mode = !connector->display_info.is_hdmi;
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
 			  (hdata->dvi_mode ? "dvi monitor" : "hdmi monitor"),
 			  edid->width_cm, edid->height_cm);
-- 
2.20.1



