Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EB4BD121
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiBTTxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:53:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBTTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:52:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D1AE54
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:52:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v12so23601613wrv.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuiKu9KkdMHJUZCAtqApuGiim+1oc7sc+xPUF6dp40w=;
        b=nwEhZFXE8PZzZaJs2++Ab/aQRMewiG6Q4pO3SHrMnxEtt216bWVJuFnHYnaD/67awY
         Zj6TZAU9zO8jic/r4TooeVejeWAEX2V6XE3O2HyFigcyCfxbQIHc2fS6t51brtW0PnBH
         yHKi9sNEQZpyd835wrPYy1uS6RS5ltJHgyFjwalqd4F3IUx9kav5Kj5B/pGNx67SLnjZ
         DnVnrtVEAryIDdOG/qt96MqOxVZVVjieGcZa83s9fnt3pDewKGZ/KtAM8xj8XyB2pDOi
         5No4CMn2wfjgcOBKHVkItI6IHwtZ+XryDkajS2LcCrNlsz08fVUw+10vf09GXNiK14Z5
         ZNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuiKu9KkdMHJUZCAtqApuGiim+1oc7sc+xPUF6dp40w=;
        b=wX1ckV92TlrqdggSy+2WFTQhn8bTA8rIiNUAAf5UaP6GXbT3k/UppN60GGL4dHt+fF
         42IsBPForng+ySmyrWYJx/l9BI8Vw0E0Rj9gahJcsBZhvOvWYA+lP1tsT/rCWAO588lQ
         5jvv640lwHYvE3q6pycCkPTPa53TqKBF0AqweTdYy8tgd2esV21UDR0WJJE8CjIfr3CQ
         NL621xdEKF/dBii4CEGt07j8ICaXEcwZTi2MO+kjlXLYx3YmRe3/1BFHTtUD34mmZ8/I
         69Y6Iz5kf8GFW7s5vzIXqOblqB+6LZQqs4xJttug/qe3cdmAxjBlfxHKEXUQHUGc8wIE
         AAsA==
X-Gm-Message-State: AOAM533eyNhDtHNAhDj6S/0GuvaIlmUSoN6Z4y47OlWZF3zWJRwoHPyN
        JdD71kDRpmdFYK+q6NQR6z4=
X-Google-Smtp-Source: ABdhPJwvOSqFh2WzEAHlvgpwocAilkbuH1U5HKEDxlr/CeIdwFUhgmsUtYhA4rMQ9Qeonkth+aGZ+A==
X-Received: by 2002:adf:cf0c:0:b0:1e6:22fe:4580 with SMTP id o12-20020adfcf0c000000b001e622fe4580mr13172397wrj.12.1645386755924;
        Sun, 20 Feb 2022 11:52:35 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id e10sm13978772wra.103.2022.02.20.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:52:35 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     tomba@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/omap: switch to drm_of_find_panel_or_bridge
Date:   Sun, 20 Feb 2022 20:52:12 +0100
Message-Id: <20220220195212.1129437-1-jose.exposito89@gmail.com>
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

Use the "drm_of_find_panel_or_bridge" function instead of a custom
version of it to reduce the boilerplate.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/omapdrm/dss/output.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 7378e855c278..00af27589296 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -20,23 +20,18 @@
 int omapdss_device_init_output(struct omap_dss_device *out,
 			       struct drm_bridge *local_bridge)
 {
-	struct device_node *remote_node;
 	int ret;
 
-	remote_node = of_graph_get_remote_node(out->dev->of_node,
-					       out->of_port, 0);
-	if (!remote_node) {
-		dev_dbg(out->dev, "failed to find video sink\n");
-		return 0;
+	ret = drm_of_find_panel_or_bridge(out->dev->of_node, out->of_port, 0,
+					  &out->panel, &out->bridge);
+	if (ret) {
+		if (ret == -ENODEV) {
+			dev_dbg(out->dev, "failed to find video sink\n");
+			return 0;
+		}
+		goto error;
 	}
 
-	out->bridge = of_drm_find_bridge(remote_node);
-	out->panel = of_drm_find_panel(remote_node);
-	if (IS_ERR(out->panel))
-		out->panel = NULL;
-
-	of_node_put(remote_node);
-
 	if (out->panel) {
 		struct drm_bridge *bridge;
 
-- 
2.25.1

