Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5214C783B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiB1Snr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiB1SnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:43:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF065E3;
        Mon, 28 Feb 2022 10:40:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r10so16909255wrp.3;
        Mon, 28 Feb 2022 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6YEE4tA+o8+T1pGK0p5yO3E7r4KEuRuaX2SCJDWnvc=;
        b=UK4OCcoKkVzJD4hyevzvTcvD5hTLJardtwDy3/dx7l/NiGxcmXubRspkglxKSaH6yh
         /nz8d/Hs/N6u1gdxJ4LT8UEF3bXy4tNQn0xQUGLDU56Wi/7YcvqmqL3w0H1+wEy1Hz54
         Av4nS7fn8FhGaOrq98iHrnN0V0pMIIOKfzIYsGxTfyy7ZqH0zEgGn133pkp/Q9lMdtzq
         YzkOQ9OWS1Z3Mt1ZgK/E0EV7DE9luOSiEKMJx470JgQfseYVGcxZRr/ktRD3XqJfTHnC
         3Ymcf/IcTVzVBRnT8hZd2t918UjL6DNajkHkbhpWriA8YzQ7AFmDoIdS+dkeKPuk7bo6
         4aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6YEE4tA+o8+T1pGK0p5yO3E7r4KEuRuaX2SCJDWnvc=;
        b=J8qGZtZfFZpa5E4wcppmgurDu5AZbzFBgRJf83MFKT+yCYiqxTZWE3NKkINAeq7eXv
         tOvSodRC18zJKeMye/uir6X87LXXSjXCG6Rwmd5xzI35O0XC7sTNI9FHkCZ0dSD88VP1
         Uqk//1szTELl58Id+kxZTpW3yFpUhrDg+0GrNR60Pti8HSFaMIiFUwlmhAYYQUa/6gn3
         y4XDZIPu8u0qeOXXN0vq6s9YpdEYM11yL4MtN1HM6V7n6LmJq/PFzu5/+MiHqT0phiL5
         BL6YCKyF/akHvOgu+oz9MNDeEbCi7ILJyTLAhi+tc9GyuTC3jEcswSKE21/y0/+YoGSd
         lIBw==
X-Gm-Message-State: AOAM530qmPUusGVCfz+p/hTCvicygki12fMm39DJona9ub+hVtNd7VDI
        91V7j8J9wLs1vSBLEuyaF3I=
X-Google-Smtp-Source: ABdhPJz0kvHdPe+ajGjHcDebdEWIdgAvL5IiW5tMhv+foN9qIBdzWhBia6PXsLTWZedHHDzLk+o9oQ==
X-Received: by 2002:adf:ea44:0:b0:1ef:6f00:cf47 with SMTP id j4-20020adfea44000000b001ef6f00cf47mr12996852wrn.460.1646073609801;
        Mon, 28 Feb 2022 10:40:09 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm297692wms.7.2022.02.28.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:40:09 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:39:54 +0100
Message-Id: <20220228183955.25508-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The function "drm_of_find_panel_or_bridge" has been deprecated in
favor of "devm_drm_of_get_bridge".

Switch to the new function and reduce boilerplate.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index dab8f76618f3..fb8e16ed7e90 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1232,15 +1232,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 {
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
 	struct device_node *np = pdata->dev->of_node;
-	struct drm_panel *panel;
 	int ret;
 
-	ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
-	if (ret)
-		return dev_err_probe(&adev->dev, ret,
-				     "could not find any panel node\n");
-
-	pdata->next_bridge = devm_drm_panel_bridge_add(pdata->dev, panel);
+	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
 	if (IS_ERR(pdata->next_bridge)) {
 		DRM_ERROR("failed to create panel bridge\n");
 		return PTR_ERR(pdata->next_bridge);
-- 
2.25.1

