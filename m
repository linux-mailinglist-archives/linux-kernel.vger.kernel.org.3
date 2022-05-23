Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4845313AD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiEWQPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiEWQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:15:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63E65405
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:15:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y13so29147861eje.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGFnUfATheJcgd6cmDQVYlu9gLXYWRlr8k9P4s/DGYQ=;
        b=IKmHlc9/5WgvRfW91RixgfNPoqkOopUkLPRDZC6vJFj6T8bRRMmUi83qO2Tal4kN8j
         lDryajBcl60SVsBNNyNhxreZojGw9vRQykC4IU/uZ9D3SUu5xtRDao+JxQJ6TWl+4jPt
         aeejXEYDstEVn2kDjbPhtOd/jlcUWAfQN1TooyyiC9pXAB58biywh7WDVneKyXdzvVFP
         rubJY+qyrF7bjbLXQleiO4LphrbkiecCrhNhT9Dhx7tLPQuwTjCWT8yIuB7NSd03iARA
         nS1ohli+xGxpE4P1OyGe2eQwohkRF3rF3NAV0UqOez+IawIUAl6PFkkSOgqLhm3fasDj
         hvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGFnUfATheJcgd6cmDQVYlu9gLXYWRlr8k9P4s/DGYQ=;
        b=7FW1FXzvbsfc3zu2YZPNBb2c/UKrFYVvhdw+9ILH+a9cFUpJj0/jQmyNjlGOq51KSe
         Vp2BsOkLHyCtTkrvm58WbcJJtNv+MPS2w5bDDR91Mp/Us9W3nhIweXAWowxdpqLwyGbd
         sTP8xAJ6/1yAk/FX/pMZYJ79KU5w1XSwKXnSv9qetOP2+ZQDZbAfpzkMBOYQbXZSxxni
         EKDPnVwiZN9NjWP9w9lUHjt0iGBpkRrNzrJcpK9NDnvCEQfhCY+qwxi9F2TTCL9Nt5Ra
         aKtxHOWS18wzKWsZzxrjOfIXz3ansiXn/F/fJLJCsPWATNd3VDGLL3bK5UL6DfWRR0xy
         dLeA==
X-Gm-Message-State: AOAM530yxBoKb01eibjC0eD45QkN0RS1jsaqAdwUrLQef+lRM6FzSXMe
        qwj20KrIxcc3/S8W+nLP6QsZbA==
X-Google-Smtp-Source: ABdhPJxKHQ4KaT+LrQ1BMBe4p/nRE/TYR99LwxI7ls1LX1ia2lhZ2Nz6mIM6eBSkHUl/ZyncTSHaTw==
X-Received: by 2002:a17:907:6d93:b0:6fe:cf1c:cdab with SMTP id sb19-20020a1709076d9300b006fecf1ccdabmr6745653ejc.609.1653322526576;
        Mon, 23 May 2022 09:15:26 -0700 (PDT)
Received: from prec5560.lan ([2001:bf7:830:a7fa:f33e:a35d:7618:8a44])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b006feed212f50sm950591ejc.184.2022.05.23.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:15:25 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, maxime@cerno.tech,
        tzimmermann@suse.de, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 1/2] Revert "drm/bridge: anx7625: Use DPI bus type"
Date:   Mon, 23 May 2022 18:15:19 +0200
Message-Id: <20220523161520.354687-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a77c2af0994e24ee36c7ffb6dc852770bdf06fb1.

This patch depends on the patches just aplied to the media tree, and will
not build without them, which leaves drm-misc-next in a broken state.
Let's revert the two latter patches until rc1 has been branched,
and rc1 has been backmerged into drm-misc-next.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 0fab2aa47c67..e92eb4a40745 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
 
 	anx7625_get_swing_setting(dev, pdata);
 
-	pdata->is_dpi = 0; /* default dsi mode */
+	pdata->is_dpi = 1; /* default dpi mode */
 	pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
 	if (!pdata->mipi_host_node) {
 		DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
 		return -ENODEV;
 	}
 
-	bus_type = 0;
+	bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
 	mipi_lanes = MAX_LANES_SUPPORT;
 	ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
 	if (ep0) {
@@ -1641,8 +1641,8 @@ static int anx7625_parse_dt(struct device *dev,
 		of_node_put(ep0);
 	}
 
-	if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
-		pdata->is_dpi = 1;
+	if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
+		pdata->is_dpi = 0;
 
 	pdata->mipi_lanes = mipi_lanes;
 	if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
-- 
2.34.1

