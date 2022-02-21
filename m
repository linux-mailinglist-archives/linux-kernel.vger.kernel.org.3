Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF204BD741
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346228AbiBUHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346307AbiBUHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:34:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FCF13E93;
        Sun, 20 Feb 2022 23:34:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i14so25390929wrc.10;
        Sun, 20 Feb 2022 23:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+qoR05yyHcZH4vSpMFd8zmkj+IJ0A8LVRiydiNyLQE=;
        b=bfJ5+9lJe1regsuOgOS62d6ohx+ewAGRCfg62qzUyvYZ+eec9jm0xpboi7mUJnHtRv
         b81hAbPB3zc1/p3GtZnBfH5tb7iVphRT8k0sM1SUj/jymWXJOxMc+o3E8aRz24F9Qgbt
         oQES8SLZ7qCM/r0yZHgLqC4AxDNlB8kFFZDMskAc36MeaGYxUDuqJqJkjZ1Yy8hHwxZj
         JOYxBcGX0LlyvJUGOmRPN0lHOojK1SeGpCeoE5u8FSU19yXr4CDHEL28OV7ApyphpHzU
         m/XuzUzdkLylwL8QK8qfXcgfIMIDEBt4xE83umKA13INLGHzsXmpMvThU1wPS76KJel0
         ndhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+qoR05yyHcZH4vSpMFd8zmkj+IJ0A8LVRiydiNyLQE=;
        b=g5urPmb7r+199O+WmoOQNU+h9fKfh1awGZFezOfrRM4EOgtsqvH+UyBQj/rqvOV+Bp
         oTOmOzzJpcZEqkzKhPREicem3GEs9jNEqdSSNqxvIIeuVd77Omi/gWcHRPIF1UGjTdcd
         lUNaiazwep9xUbP6bXGgRdhJQrnejhRov0QIl/zwVpRlsPqAqvMMeSmpQCl+YpWRls0z
         eufJwcCCWZcvGf1NrtHB07rp9p/IQ1gcnpAYZ/IOdRzCkFpYs0oY0KBeJVsVaB2EyQhA
         HKsKlp0oipeJQo/o6jEW0yLwz+lVC2iPqPjat6UWNbEd40QOrFBAgn/y+LP8oIV6GO6+
         Aqdw==
X-Gm-Message-State: AOAM531CcUCPjGTdLWySUBsN0AylVDwTSB/9VNAxOUc9clXDchDk/16z
        a/gFfqvA+MjzN2hyUrzJ+SRUczkbka66kw==
X-Google-Smtp-Source: ABdhPJx0lw3Y5VqBWVHfEPeyySbm9dv8MgG72DRRcySxMXil771gs/YOCQimQJH9Iw+6HqFyEOkkeQ==
X-Received: by 2002:adf:e7cd:0:b0:1e3:31a4:4b55 with SMTP id e13-20020adfe7cd000000b001e331a44b55mr13981624wrn.650.1645428849129;
        Sun, 20 Feb 2022 23:34:09 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id f13sm29876580wri.82.2022.02.20.23.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:34:08 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, maxime@cerno.tech,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/msm/dp: switch to devm_drm_of_get_bridge
Date:   Mon, 21 Feb 2022 08:33:39 +0100
Message-Id: <20220221073339.10742-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/msm/dp/dp_parser.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index a7acc23f742b..0951752e2d98 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -268,16 +268,8 @@ static int dp_parser_clock(struct dp_parser *parser)
 static int dp_parser_find_panel(struct dp_parser *parser)
 {
 	struct device *dev = &parser->pdev->dev;
-	struct drm_panel *panel;
-	int rc;
 
-	rc = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
-	if (rc) {
-		DRM_ERROR("failed to acquire DRM panel: %d\n", rc);
-		return rc;
-	}
-
-	parser->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	parser->panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
 	if (IS_ERR(parser->panel_bridge)) {
 		DRM_ERROR("failed to create panel bridge\n");
 		return PTR_ERR(parser->panel_bridge);
-- 
2.25.1

