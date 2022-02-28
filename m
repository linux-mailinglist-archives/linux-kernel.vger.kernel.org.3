Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF084C7820
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiB1SlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiB1Skw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:40:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B836E0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:33:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j22so16805421wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFFWProEoKuAUh9xM72AMLCdQM4KQgmwuniqkq2ipKk=;
        b=XBmbnAm+4+oTMlp6pyVgvt3b285D3eIMtWAG56zgUuVI1MzBh7UwKifz00Z7VcE9DH
         w1tqrlIpUCps+K1nbi1teymUOwr58lKs4skxRtBsI06tHbqUpe9ibzkTOGDzPL/B3YMl
         PajaGab3HWKD+sXTID1IRfPNP/mUHgtKcuicv3VdjpDSJ60VstKD24LRtQFNJo4jDwm5
         XUjd/zTsS3BqUhkbvcVQaw4jDG9q8+1mtSFb+Lkw6VCLZ703YHl5qNuF5VEvkHC2tmuz
         nLU3cP57Cf+jH06iyFt+FdV+xFN1ZLDLwxL0BMvImyPKgIwgENyf7uFRcKNicwz8LgJa
         rhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFFWProEoKuAUh9xM72AMLCdQM4KQgmwuniqkq2ipKk=;
        b=3+a30eNTvH2cQIKqj4zM9adaKKs8k4KCbrUYJOHvL13jCMRsSMm9fOwKn0kfvQ+FFV
         2lmN72E1jhx8Yzwvjj35EbzEOu5Cpr3/rlA/RawNs09EZAvkFP/4my3aJC5mfOtU7mr2
         g3Xb5tlVWwjw6Dr4Rw/hyjoyXnDSNEajTpF+leEHQwEBGNcZBMqvTo3AL4HDK511zMRX
         yuT1VUkBWC4Qcq+3pl/7SBm31dcHaBwzQwUkHDH3uPYQvu9eb4o5+NNsgLa5IAaSlWtp
         ko2WZDcI19h8DUzBO2FeMwvTtWuNP94zp6zF1Nk0Kfc/Aj3ltCEP8eSDqURi64lKm3zy
         sx2w==
X-Gm-Message-State: AOAM531S5VRCAp/1GfYATMAVbnH1UxM8mf0sbsXlNvFyn8UQVt5c7k//
        gmoXdiOtKtHGDfQH3K0YoWo=
X-Google-Smtp-Source: ABdhPJzykc+prbJ3d8r+oyf5greaX8g2ucPnBZ4/DeX7WDXCoe+sNytkG9GOt/k1yAqmFQxkDn4/cg==
X-Received: by 2002:adf:eac4:0:b0:1ef:87cb:3c7 with SMTP id o4-20020adfeac4000000b001ef87cb03c7mr8833096wrn.445.1646073232004;
        Mon, 28 Feb 2022 10:33:52 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdd83000000b001e58c8de11bsm11412995wrl.39.2022.02.28.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:33:51 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: tc358762: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:33:42 +0100
Message-Id: <20220228183342.24129-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/bridge/tc358762.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 1bfdfc6affaf..7870aceb0a6d 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -179,15 +179,8 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 {
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
-	struct drm_panel *panel;
-	int ret;
-
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
-	if (ret)
-		return ret;
-
-	panel_bridge = devm_drm_panel_bridge_add(dev, panel);
 
+	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
 	if (IS_ERR(panel_bridge))
 		return PTR_ERR(panel_bridge);
 
-- 
2.25.1

