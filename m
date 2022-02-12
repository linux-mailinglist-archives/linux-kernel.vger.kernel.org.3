Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625DB4B3592
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiBLOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 09:20:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiBLOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:19:48 -0500
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A1245B6;
        Sat, 12 Feb 2022 06:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644675572;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=76+TPRGf0MB6hHRwPaUxmX8Eixo5outKfV374UIYYws=;
    b=aWk329+8WtFTSQFW0tU4F4FsNyw+Wkka7OQy5wrqZB5FszkqVeZz+DsRD4HtFLn61G
    JIkU5vbSNE2HAGQZ1kxZe8pzFGN4pxAmdUBOUD8UXfMkKQrBDncboNcj5/ZY6YvdUVry
    entTLZAURbz8+usjomfqZjltgbMKaqCZr+FqK+PyVVd+szjq7yF4Dak5UgrQeitTu7kY
    eWhZdIrMaleqVCG+VzKpoDWV41jFXcq1KUHCSrdtRHXOXXVTJ+g6Ky3DWMx7djdmiRJJ
    LD1k9ugwTz0YP78q6B53eIfmy0O4bZsnpTQ34fOsNdvDuHU+c//3xDN/hRFrqJDQ8rSR
    QUOg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVblcdY="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CEJVsqW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 12 Feb 2022 15:19:31 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v14 5/9] drm/bridge: dw-hdmi: repair interworking with hdmi-connector for jz4780
Date:   Sat, 12 Feb 2022 15:19:23 +0100
Message-Id: <8703a3e48574c09e8756b79e8f69be7d84926fe9.1644675566.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1644675566.git.hns@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7cd70656d1285b ("drm/bridge: display-connector: implement bus fmts callbacks")

introduced a new mechanism to negotiate bus formats between hdmi connector
and the synopsys hdmi driver inside the jz4780.

By this, the dw-hdmi is no longer the only bridge and sets up a list
of formats in dw_hdmi_bridge_atomic_get_output_bus_fmts().

This includes MEDIA_BUS_FMT_UYVY8_1X16 which is chosen for the jz4780 but only
produces a black screen.

This fix is based on the observation that max_bpc = 0 when running this
function while info->bpc = 8. Since the formats checks before this always test
for max_bpc >= info->pbc indirectly my assumption is that we must check it
here as well.

Adding the proposed patch makes the CI20/jz4780 panel work again in
MEDIA_BUS_FMT_RGB888_1X24 mode.

Fixes: 7cd70656d1285b ("drm/bridge: display-connector: implement bus fmts callbacks")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b0d8110dd412c..826a055a7a273 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2620,10 +2620,10 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
 	}
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
+	if (max_bpc >= info->bpc && info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
 		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+	if (max_bpc >= info->bpc && info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
 		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
 
 	/* Default 8bit RGB fallback */
-- 
2.33.0

