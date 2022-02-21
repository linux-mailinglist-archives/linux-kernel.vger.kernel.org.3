Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11C4BD73B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbiBUH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:29:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiBUH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:29:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCCE2E7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:28:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so25360062wra.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3PLukBtwfovlwrmcqI4UjQoWYEr1ObJtYBgUzUoDAs=;
        b=Bu/jNlb3lvECwKGFKqpGdOKDkX/dwpq3DeeCBPL4qdZRs+20A7yQ1DHVXTHQ3m6LvJ
         AnEGmKipFWYIFviPjHqCywEnmWtZ8AwdteBwMKrBHolRiZPXhCB50x/yhvEbAdH2UODJ
         fCdqIHyTsoNPtNXLRpS1jnWpUTga6MLuq/u/vGN/YkPaZ/27WjEQIDJNuIL2l8LPvGC2
         7b+jwdzaIHoNHPVkbK2YpJ46aFRqlzwZz0VwVzRzFMMCEb4igsiWCW2FeBDm4DQIJxXr
         KEToa5m5bIR6JmObEkr98YCR6TrfHD0voUNSh64nEGdSwCQoLM0AjLH2P7x9h/4FO1No
         bCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3PLukBtwfovlwrmcqI4UjQoWYEr1ObJtYBgUzUoDAs=;
        b=HqPCGry95LC082blssOS5fqxr/vHezNsG9z3y7JQT4s1D2R17CDP8gmKxNHdOJV6pz
         DWslbfQO2qMFYpBQJCemawOeaMqTg6uVdwF9jhUfP6zECGrylYhNA8mB90dK4CNNC4Fg
         DNAfwTR8a3hTvGYc8UfQf4XQd3bMm9c90ZAATvqf3KjiJYgBmaPj1WFIGK9qL1XALVud
         5BypyyOTktAMuqGpfEDxbNpMarYEplvsdlQWd0LtVt9d6gWx6cB7RkVGZevg93hpiwFS
         KAQkvYs5UC1arRAZ5fRrxrRjfO2Z37VfohhVuEmHoel5kH+JeLJ/zdyiX2cUC8J+07bi
         tDmw==
X-Gm-Message-State: AOAM533ifvwPrAgq/rshN13PZTs4OxgpYLxdFqWCkV9ZCQL3m+VhtEJI
        TFDDQ9mS+KvceNcs4BW4mMk=
X-Google-Smtp-Source: ABdhPJycx/kO9uFt2e1KqYq1bD0y+GYGwvsUObhfNQ/vM2YEzor8nrTr9ioB0mbALGJZknXhs5T8Dg==
X-Received: by 2002:a5d:4e03:0:b0:1e3:3a59:48ae with SMTP id p3-20020a5d4e03000000b001e33a5948aemr14430468wrt.634.1645428532396;
        Sun, 20 Feb 2022 23:28:52 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id a1sm51008492wrf.42.2022.02.20.23.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:28:52 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: anx7625: switch to devm_drm_of_get_bridge
Date:   Mon, 21 Feb 2022 08:28:35 +0100
Message-Id: <20220221072835.10032-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/analogix/anx7625.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 2346dbcc505f..dfeb800751d5 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1333,8 +1333,6 @@ static int anx7625_parse_dt(struct device *dev,
 			    struct anx7625_platform_data *pdata)
 {
 	struct device_node *np = dev->of_node, *ep0;
-	struct drm_panel *panel;
-	int ret;
 	int bus_type, mipi_lanes;
 
 	anx7625_get_swing_setting(dev, pdata);
@@ -1371,18 +1369,14 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
-	ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
-	if (ret < 0) {
-		if (ret == -ENODEV)
+	pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
+	if (IS_ERR(pdata->panel_bridge)) {
+		if (PTR_ERR(pdata->panel_bridge) == -ENODEV)
 			return 0;
-		return ret;
-	}
-	if (!panel)
-		return -ENODEV;
 
-	pdata->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-	if (IS_ERR(pdata->panel_bridge))
 		return PTR_ERR(pdata->panel_bridge);
+	}
+
 	DRM_DEV_DEBUG_DRIVER(dev, "get panel node.\n");
 
 	return 0;
-- 
2.25.1

