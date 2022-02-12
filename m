Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE004B360B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiBLPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:51:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiBLPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:51:14 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666D2458C;
        Sat, 12 Feb 2022 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644681057;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5sZAQo8xRWpw61mM0KJi2rPZ2ueKCXrwgU5gkKQV1AU=;
    b=B18erzr9+APDciPl82uqh0T+WVEqjBNGiPFHNx7yXpCZMOpYrlsCET14eLqDzAYN4w
    Rkr8ASv2M69M4/V3GPGbg5iL68YKoDqdD0CnyNnBPczSdvWCo9L9Aodk/Vg99riD+GAe
    YKd6T2YLiFH3tU4kR6jm26W0hYuNBfk3lC4SsthwTFjfHGLSf/A0sM/8W7eaTFhQWzxn
    JsLJfwNfUKhc/39wbNF4nU9M8ZSGB4YYW+y2iPXYdyrxC/qi3QAk5PD1sQ/8aKaS0N1a
    5EwTvcZwx50OhDJHMPcyFLBI+QIRRk82euYUnMcL40zpzPVUutDnP+pgsguf2Jw8CDhO
    d+Hg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVblcdY="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CFouswo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 12 Feb 2022 16:50:56 +0100 (CET)
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
        Harry Wentland <harry.wentland@amd.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        letux-kernel@openphoenux.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v15 1/7] drm/ingenic: Fix support for JZ4780 HDMI output
Date:   Sat, 12 Feb 2022 16:50:49 +0100
Message-Id: <9d3a2000d2bb014f1afb0613537bdc523202135d.1644681054.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1644681054.git.hns@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
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

From: Paul Boddie <paul@boddie.org.uk>

We have to make sure that
- JZ_LCD_OSDC_ALPHAEN is set
- plane f0 is disabled and not seen from user-space

Tested on MIPS Creator CI20 board.

Signed-off-by: Paul Boddie <paul@boddie.org.uk>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 7f10d6eed549d..dcf44cb00821f 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -65,8 +65,10 @@ struct ingenic_dma_hwdescs {
 struct jz_soc_info {
 	bool needs_dev_clk;
 	bool has_osd;
+	bool has_alpha;
 	bool map_noncoherent;
 	bool use_extended_hwdesc;
+	bool plane_f0_not_working;
 	unsigned int max_width, max_height;
 	const u32 *formats_f0, *formats_f1;
 	unsigned int num_formats_f0, num_formats_f1;
@@ -453,7 +455,7 @@ static int ingenic_drm_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc)
 		return 0;
 
-	if (plane == &priv->f0)
+	if (priv->soc_info->plane_f0_not_working && plane == &priv->f0)
 		return -EINVAL;
 
 	crtc_state = drm_atomic_get_existing_crtc_state(state,
@@ -1055,6 +1057,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	long parent_rate;
 	unsigned int i, clone_mask = 0;
 	int ret, irq;
+	u32 osdc = 0;
 
 	soc_info = of_device_get_match_data(dev);
 	if (!soc_info) {
@@ -1312,7 +1315,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 	/* Enable OSD if available */
 	if (soc_info->has_osd)
-		regmap_write(priv->map, JZ_REG_LCD_OSDC, JZ_LCD_OSDC_OSDEN);
+		osdc |= JZ_LCD_OSDC_OSDEN;
+	if (soc_info->has_alpha)
+		osdc |= JZ_LCD_OSDC_ALPHAEN;
+	regmap_write(priv->map, JZ_REG_LCD_OSDC, osdc);
 
 	mutex_init(&priv->clk_mutex);
 	priv->clock_nb.notifier_call = ingenic_drm_update_pixclk;
@@ -1511,7 +1517,9 @@ static const struct jz_soc_info jz4770_soc_info = {
 static const struct jz_soc_info jz4780_soc_info = {
 	.needs_dev_clk = true,
 	.has_osd = true,
+	.has_alpha = true,
 	.use_extended_hwdesc = true,
+	.plane_f0_not_working = true,	/* REVISIT */
 	.max_width = 4096,
 	.max_height = 2048,
 	.formats_f1 = jz4770_formats_f1,
-- 
2.33.0

