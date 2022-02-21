Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148474BD72B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiBUHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:43:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346545AbiBUHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:43:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E4DA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:42:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w13so8484637wmi.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9gzKenx+aszBYGgfBSeWmEFs7B/QZ34GNE9lVymcB4=;
        b=YHqLcuZRVcf1bNB/ivMHeUFOdizHM6H7zZ4A0vH3H5/uGh+nDnQ6Z0FRwqxyzn6yps
         XuVAvne2VPbsPFFme5eMfOQ6zvUeB4texlLYP9lPfSdywZeH8fYXMikKi3HNJXZ1Q8aG
         KKEQ2HINoO8DJ4rxybRTu2AGSvIU6APVbIXRMOHLeZ4ycnf+J5UHisYKThrxxuSbn+s7
         /P0Tg2fGNCpUuv7QtWdzw/S1BI8DsRgHXpA7JZLDhkKywoVdIyqJkyedv0xmIJChumyJ
         MaCAj6GSBfvwsAbMPevZ0Vy7bDBSadQaFLMrVuDyiMDuHqR1QSR64L4Fzrp/oQ2tMROh
         6NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9gzKenx+aszBYGgfBSeWmEFs7B/QZ34GNE9lVymcB4=;
        b=rzOOBKLUXfDTUGed2sA4UqY53R4M5eNVLsuXYt2fVYTpmkk0aUvFequpND0Y40wMG8
         oJlAjAnyV0g8BFyA/RfcgGPb2Bqx5liTQDxp5GQOXnKmG34BV3mZV80ygQln3Nwzx7EI
         EL1TK60/kwcWM+Fd9TqaNJn9UFGJc3+WIqyh+P9oZ7LdpMuOTWZIkXJmZr8Zss+HALBi
         TjdSD5sNvrZjR8KATAz3zVO7SpEEWDtcFfKXjfWpr4ucmAZ/Jlcp5uynWQchXk6mHulV
         /y1iIAtdJ2lkeKECy+heg4zeKDB9Cc7HK2uWLJ+LI8XB47Ge9r2+P6boqKfGGjT3iowP
         rvrw==
X-Gm-Message-State: AOAM530HK0ujcPrr1JqbszfQys0cHZNGG2IgftRqTjYtBJN7hxuuSw76
        NylxrppEsNylT2wXrKQZ+6+7FS2G6JXNZw==
X-Google-Smtp-Source: ABdhPJwZdJzRu4i7z3qg4jpAoKRVhllG5OYuhM4QqelqutkZmJs34W3J9Om/p4Bz9LrPxDN96mb5fA==
X-Received: by 2002:a1c:a946:0:b0:37d:1e29:5ccb with SMTP id s67-20020a1ca946000000b0037d1e295ccbmr16564422wme.8.1645429355803;
        Sun, 20 Feb 2022 23:42:35 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b0037bf83d99a2sm6828276wmj.1.2022.02.20.23.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:42:35 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jagan@amarulasolutions.com
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, lgirdwood@gmail.com, broonie@kernel.org,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: chipone-icn6211: switch to devm_drm_of_get_bridge
Date:   Mon, 21 Feb 2022 08:42:24 +0100
Message-Id: <20220221074224.12920-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/chipone-icn6211.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index a6151db95586..23c34039ac48 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -178,7 +178,6 @@ static const struct drm_bridge_funcs chipone_bridge_funcs = {
 static int chipone_parse_dt(struct chipone *icn)
 {
 	struct device *dev = icn->dev;
-	struct drm_panel *panel;
 	int ret;
 
 	icn->vdd1 = devm_regulator_get_optional(dev, "vdd1");
@@ -214,11 +213,7 @@ static int chipone_parse_dt(struct chipone *icn)
 		return PTR_ERR(icn->enable_gpio);
 	}
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
-	if (ret)
-		return ret;
-
-	icn->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	icn->panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
 	if (IS_ERR(icn->panel_bridge))
 		return PTR_ERR(icn->panel_bridge);
 
-- 
2.25.1

