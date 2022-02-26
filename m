Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23DF4C570C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiBZRN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBZRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:13:52 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3532D199C;
        Sat, 26 Feb 2022 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1645895585;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Itv7i6Bm9qZTP8Djtnn3kfJowIcb04gXWZLzQuWU4eI=;
    b=SY9lMrn0n3OMql/lFd2TXmtXDus93skI0DVEBQZI2xDQdwt+pXUj4o1sr6YS7tlIPb
    BIHDP9L9iLeTgky6h+CHqSJj/jlGc+RZizXvyqow7QTWEnyyglSn4u+OY8qXOxf+6wov
    SI3BJ3XwHmsiRBWmTEfERJegK5QrwzXNGpaKaV43d2z2LttGaHpQ6nhrewgTRMAUBOt/
    SUK4SXagUqOG8qQ+rpYOXNxFWR6HThWMEK1U36EEnaMckB+Jl8k48uA3/E790sw86fBj
    A5EqGWqflY6lC1XNpj+7v7rYaIHFaLkLtaxe2QAz66fHpFwEDO9XYchFCUgJAQa2xtB8
    ATDg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdcK1D0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 SBL|AUTH)
    with ESMTPSA id V41e6fy1QHD5E20
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 26 Feb 2022 18:13:05 +0100 (CET)
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
Subject: [PATCH v16 4/4] drm/bridge: dw-hdmi: fix bus formats negotiation for 8 bit modes
Date:   Sat, 26 Feb 2022 18:13:02 +0100
Message-Id: <169afe64b4985c3f420177cd6f4e1e72feeb2449.1645895582.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645895582.git.hns@goldelico.com>
References: <cover.1645895582.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7cd70656d1285b ("drm/bridge: display-connector: implement bus fmts callbacks")

introduced a new mechanism to negotiate bus formats between hdmi connectors
and bridges which is to be used e.g. for the jz4780 based CI20 board.

In this case dw-hdmi sets up a list of formats in
dw_hdmi_bridge_atomic_get_output_bus_fmts().

This includes e.g. MEDIA_BUS_FMT_UYVY8_1X16 which is chosen for the CI20 but
only produces a black screen.

Analysis revealed an omission in

Commit 6c3c719936dafe ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")

to check for 8 bit with when adding UYVY8 or YUV8 formats.

This fix is based on the observation that max_bpc = 0 when running this
function while info->bpc = 8.

Adding the proposed patch makes the jz4780/CI20 panel work again with default
MEDIA_BUS_FMT_RGB888_1X24 mode.

Fixes: 7cd70656d1285b ("drm/bridge: display-connector: implement bus fmts callbacks")
Fixes: 6c3c719936dafe ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 43e375da131e8..c08e2cc96584c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2621,11 +2621,13 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
 	}
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
-		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
+	if (max_bpc >= 8 && info->bpc >= 8) {
+		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
+			output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
-		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
+		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+			output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
+	}
 
 	/* Default 8bit RGB fallback */
 	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
-- 
2.33.0

