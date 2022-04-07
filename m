Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA84F7DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiDGLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244802AbiDGLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:18:19 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9B70CD1;
        Thu,  7 Apr 2022 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649330173;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ghuIHOXwcBIPtNzAtXxIIrMgvWMfEspBSWPIcijGCo0=;
    b=lzV7xcfX/NnVZKB2WsRCTREkq6y1NvR6MFt70ozwrwoK7e4D/lrT6EpMQONq3PnuPS
    hDrDIYhC1OFobcDxQH/vTUQXCT1tz0AavoFfOzFWw67vxmKkbxi8dEeU42SPbIOxBT4o
    JGepwZTTUmN2yypLrJ3TKrc6qeHy95z20Us907dZ4FZcmJ3zKq6x+Y8gmvfTXMnVoiGb
    JXkzdTfFo0V38Q+eN7Dy/jsI3Cb18UpyXNkmMKY77YmE902LbMi+o95Nwn23nMtRolqj
    qxkb1E0a1vLlNCrGqydsxx0eaIVYBWbxR+iVUvu/2kV483bRaKBOtnrgvAmcJtu0AwLy
    3dJw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1KHeBQyh+ITDDFsCr4="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy37BGCjxD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 7 Apr 2022 13:16:12 +0200 (CEST)
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
        letux-kernel@openphoenux.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v18 1/3] drm/bridge: display-connector: add ddc-en gpio support
Date:   Thu,  7 Apr 2022 13:16:09 +0200
Message-Id: <3607e924b7c0cf0be956c0d49894be1442dbda41.1649330171.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649330170.git.hns@goldelico.com>
References: <cover.1649330170.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"hdmi-connector.yaml" bindings defines an optional property
"ddc-en-gpios" for a single gpio to enable DDC operation.

Usually this controls +5V power on the HDMI connector.
This +5V may also be needed for HPD.

This was not reflected in code but is needed to make the CI20
board work.

Now, the driver activates the ddc gpio after probe and
deactivates after remove so it is "almost on".

But only if this driver is loaded (and not e.g. blacklisted
as module).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

