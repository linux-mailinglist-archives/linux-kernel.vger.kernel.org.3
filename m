Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18749549CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbiFMTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbiFMTCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:02:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6612A89
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:37:12 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D02B66015CE;
        Mon, 13 Jun 2022 17:37:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655138231;
        bh=EU5dXJaxST5yUrirK7LNhLQYTDy3gjAdYEoad2iWgjY=;
        h=From:To:Cc:Subject:Date:From;
        b=CcyxbA6+H2CHZ79FccQzbDfT0w5dk+YkS66AasdDCPAvv8TFB9WPHC7NfKZFDi0Af
         Vv/tku+hO0aNkbqwRybcjgYPhWKBFVe/vFwWIt2TA8xi1++q5t/IFv8+N0WQb2YAg7
         QEURcJqXLQVG4oaOczNg9uOO0uIhDOoN+PeMzQF04o8TZrXhO+Gi+xpoL8pkOnJK7K
         +m50Ww23uZIWODl8ReM8VPEcG0tW4KT7cLNa7N9tIjPSBIwtXMssplzkqXEfEgR+GR
         31nZPaZVj4ZZqqX4pQzah0dkMdqw9+HI5IFf+V7nR1P6gZp94VcBD4AX2fxTSC9T+F
         mDNW0HZDIGjSA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Zero error variable when panel bridge not present
Date:   Mon, 13 Jun 2022 12:37:05 -0400
Message-Id: <20220613163705.1531721-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While parsing the DT, the anx7625 driver checks for the presence of a
panel bridge on endpoint 1. If it is missing, pdata->panel_bridge stores
the error pointer and the function returns successfully without first
cleaning that variable. This is an issue since other functions later
check for the presence of a panel bridge by testing the trueness of that
variable.

In order to ensure proper behavior, zero out pdata->panel_bridge before
returning when no panel bridge is found.

Fixes: 9e82ea0fb1df ("drm/bridge: anx7625: switch to devm_drm_of_get_bridge")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 53a5da6c49dd..3aed4de16690 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1657,8 +1657,10 @@ static int anx7625_parse_dt(struct device *dev,
 
 	pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
 	if (IS_ERR(pdata->panel_bridge)) {
-		if (PTR_ERR(pdata->panel_bridge) == -ENODEV)
+		if (PTR_ERR(pdata->panel_bridge) == -ENODEV) {
+			pdata->panel_bridge = NULL;
 			return 0;
+		}
 
 		return PTR_ERR(pdata->panel_bridge);
 	}
-- 
2.36.1

