Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865484B3586
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiBLOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 09:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiBLOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:19:49 -0500
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6318245B7;
        Sat, 12 Feb 2022 06:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644675571;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i8pTmnLmwlb11chyD0dSM2jAOpH2BALjlZjdfMA39JQ=;
    b=sdNF5R0RHznzGkb4VKZfZFXv5z7vsqqPhAqbLy5AIvpot0X+b+5+ktWPLUaqRr5CM5
    /wxas83cZ1ti/RoqOPsco9Y7ZYrxQ3AzgP8m1ddOfqwsNyW2iUVxwbpGtT56LfZMpNID
    4uat+zFIZXcFUyE9HMPIN6fSQLeaWbno5vchm9lNL1pnwPszPo3UbptdBvlYvTnG38hD
    gT8D5T89fxGsGZzKMNEtWqx6ih6G1h4lMVgOkD5o8zj/pDyqZr1Alsb/fBttdgERQR4u
    g5jXKoCreGB/QaxV7/5RLgUiTiagRlLHR2B6TUWlCCVpHGhI2P+qRw/SFvNkauLHUROv
    wkdA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVblcdY="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CEJVsqV
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
Subject: [PATCH v14 4/9] drm/bridge: display-connector: add ddc-en gpio support
Date:   Sat, 12 Feb 2022 15:19:22 +0100
Message-Id: <27ebb5cf149444b2461f7cff687441815632cb8a.1644675566.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1644675566.git.hns@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"hdmi-connector.yaml" bindings defines an optional property
"ddc-en-gpios" for a single gpio to enable DDC operation.

Usually this controls +5V power on the HDMI connector.
This +5V may also be needed for HPD.

This was not reflected in code.

Now, the driver activates the ddc gpio after probe and
deactivates after remove so it is "almost on".

But only if this driver is loaded (and not e.g. blacklisted
as module).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index d24f5b90feabf..e4d52a7e31b71 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -24,6 +24,7 @@ struct display_connector {
 	int			hpd_irq;
 
 	struct regulator	*dp_pwr;
+	struct gpio_desc	*ddc_en;
 };
 
 static inline struct display_connector *
@@ -345,6 +346,17 @@ static int display_connector_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* enable DDC */
+	if (type == DRM_MODE_CONNECTOR_HDMIA) {
+		conn->ddc_en = devm_gpiod_get_optional(&pdev->dev, "ddc-en",
+						       GPIOD_OUT_HIGH);
+
+		if (IS_ERR(conn->ddc_en)) {
+			dev_err(&pdev->dev, "Couldn't get ddc-en gpio\n");
+			return PTR_ERR(conn->ddc_en);
+		}
+	}
+
 	conn->bridge.funcs = &display_connector_bridge_funcs;
 	conn->bridge.of_node = pdev->dev.of_node;
 
@@ -373,6 +385,9 @@ static int display_connector_remove(struct platform_device *pdev)
 {
 	struct display_connector *conn = platform_get_drvdata(pdev);
 
+	if (conn->ddc_en)
+		gpiod_set_value(conn->ddc_en, 0);
+
 	if (conn->dp_pwr)
 		regulator_disable(conn->dp_pwr);
 
-- 
2.33.0

