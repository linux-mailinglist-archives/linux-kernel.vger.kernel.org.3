Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8154BD719
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiBUHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:38:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiBUHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:38:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348A1084;
        Sun, 20 Feb 2022 23:38:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e3so25504291wra.0;
        Sun, 20 Feb 2022 23:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8kD/ok13BJf5Nrp4mRjz+VFnutGthXKYvZnWK9jovI=;
        b=XWaLHpOFQ0cjx8OYjCzDNiywKezMjHZqpCgeBj1HdMPi+5CrCtpovP6dIuGMJ1GYg9
         +VoM/lz9G0BsPOfIStaKmk2clsPJLuJn/UWBRAyXRdD0uQvlvyHc10RQltqVoItgKZWd
         c+swsX0zNTgCRqHoGNT+eWvsP/zqf6D74HmqdN+Mmm9MYSNQKadKK2TA+/z96nfS8HML
         3DlIvDV5raw/wfnAn01twAw5hf+g20oL6a+sLlmlT3Z7CXVxXlmQwg2MX4om8JPpJBeV
         QGqVZvnrNZ12h4wuRJUP/tPTw6N3N8tjRFemCXSfx6GxjQOpK2FxoyMlbRCIWVd6OWON
         dyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8kD/ok13BJf5Nrp4mRjz+VFnutGthXKYvZnWK9jovI=;
        b=PPV4kUSNq31N68oHKaYZr7uxf0/3he6MoUxq6y+/SwqU0ALcDkrmEByxkXPHc+xjYG
         tE1TWy95to4nd6sVslcnKjhG5I1SfjT7tIbVtdnlFcOy8U7s5eblUBvQ0KkaMqkMScRH
         hV3+6yxVViP0UYUMM5uFyYj/EOvt8IekMkTDGaC595BbrTQ2/8T0KlgJBAGCHzMyXG1T
         Bt4xKYIahGGH01I2VVDaCZ9mJ0rSIebdGvQrT4H66am1c803TRJGytbvslnk8MFxB6Zx
         0zLUKLQMBDjpBlL+quDphMmbBnFgLYiwMvrDbgbfMCEojs/f0PPCh55gM8JYLovNNtvj
         ASBw==
X-Gm-Message-State: AOAM530lnhi+xYDLHaF4OgNZIDQO0SgqKtNHfLJro58etADCDXO1buys
        3jTeJ1SSYLiunkB2+HS9CEw6JafWCxx8PA==
X-Google-Smtp-Source: ABdhPJztU7DEG+kmcDH4HyMhAm2Pw6SdZLYZEm0x5h8LxHpPMQ7O8DgaFzs3pcMFf+YNid1/M0K+9w==
X-Received: by 2002:a05:6000:1a89:b0:1e8:db90:54cd with SMTP id f9-20020a0560001a8900b001e8db9054cdmr14553344wry.303.1645429081157;
        Sun, 20 Feb 2022 23:38:01 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id z7sm6598773wml.40.2022.02.20.23.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:38:00 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm: rcar-du: switch to devm_drm_of_get_bridge
Date:   Mon, 21 Feb 2022 08:37:57 +0100
Message-Id: <20220221073757.12181-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 72a272cfc11e..99b0febc56d1 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -712,18 +712,12 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 {
 	int ret;
 
-	ret = drm_of_find_panel_or_bridge(lvds->dev->of_node, 1, 0,
-					  &lvds->panel, &lvds->next_bridge);
-	if (ret)
+	lvds->next_bridge = devm_drm_of_get_bridge(lvds->dev,
+						   lvds->dev->of_node,
+						   1, 0);
+	if (IS_ERR(lvds->next_bridge)) {
+		ret = -EINVAL;
 		goto done;
-
-	if (lvds->panel) {
-		lvds->next_bridge = devm_drm_panel_bridge_add(lvds->dev,
-							      lvds->panel);
-		if (IS_ERR_OR_NULL(lvds->next_bridge)) {
-			ret = -EINVAL;
-			goto done;
-		}
 	}
 
 	if (lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK)
-- 
2.25.1

