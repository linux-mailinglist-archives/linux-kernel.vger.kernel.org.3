Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721A4F67DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiDFRoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiDFRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:44:07 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA871162BF;
        Wed,  6 Apr 2022 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649262374;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KR13NrwR20zSnWj2ej7PoEMIq+O+MWSZlNAGuKlspIA=;
    b=MaUqpElqHdAzdRvn1WMicaIyHDhkY7ObvP0u4Uy6X+ur1PgEUgdVIkFIn01ZOQhvJ2
    YLT/vZG2GlmTFmgM+mja3HVE7MGJ/xw/Q1Kg/xToqAcFzfyRJUcSndMzyJHkguwYKuTf
    CvU4IbL1ZLqHg744dKucD6Tc3JSva/PJT5/PmOKxu1VlA4DhfpOVWfe9Q4N3+NHBN0lU
    uwE6zUeFXNVzLqf/6G6si29DAaROIHnFRyAUHVqcPJRuPLK+OQ6WL3PVlIMMi/yMTwaE
    NmT67/5V4c+gMR2+XWI20SHaMd7yNFA7spf0Sju1PRTtV3oYRpIzpT2MYPibsfSkUcCC
    lCMQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgcbPa"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy36GQEgVR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 6 Apr 2022 18:26:14 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <maxime@cerno.tech>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: [PATCH v17 5/6] drm/bridge: dw-hdmi: add YCBCR formats only if CSC is available
Date:   Wed,  6 Apr 2022 18:26:07 +0200
Message-Id: <d5801eb7733a616df30fef1d192e88ad147afc1c.1649262368.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649262368.git.hns@goldelico.com>
References: <cover.1649262368.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

otherwise they will produce a black HDMI screen.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b5a665c5e406e..ec40dd8865065 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2628,10 +2628,12 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
 	}
 
-	if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
+	if (hdmi->csc_available && hdmi->sink_is_hdmi &&
+	    (info->color_formats & DRM_COLOR_FORMAT_YCBCR422))
 		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
 
-	if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+	if (hdmi->csc_available && hdmi->sink_is_hdmi &&
+	    (info->color_formats & DRM_COLOR_FORMAT_YCBCR444))
 		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
 
 	/* Default 8bit RGB fallback */
-- 
2.33.0

