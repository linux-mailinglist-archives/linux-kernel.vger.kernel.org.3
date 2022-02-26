Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED04C5705
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiBZRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiBZRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:13:52 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AEE106C91;
        Sat, 26 Feb 2022 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1645895585;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i8pTmnLmwlb11chyD0dSM2jAOpH2BALjlZjdfMA39JQ=;
    b=B6v6ihOk/9KDlEIMLQ3sGfeLNWDkgzXpBaLFw9o30/Lq2yLulEEykANLH4DLyhJ6LL
    73fZMby+nqN6dvgGeGuM0qZJMcTQ5WpQ4MEk55JV50jpsJC6n+MoEnDOIsjVZA3pleHY
    1phexMxXcHm7bXoX8U7WfTsMYxsFp+6IOkAwtKpo+KdxZtqE2apbMF+ahpVcfSTdUKrm
    p60xO/Y37ULd0UTLQ18Kw81SqOulTOhNCNNPUrJb2g5x4FJCVya/bvZhQRzLbWMu0dW9
    Q+GSJDmSVpiF27cleVVm7bLLwUTSIpYs9XultGrs/B4MUag/q4y61ENaXhjcb/IYQHWb
    1O6g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdcK1D0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 SBL|AUTH)
    with ESMTPSA id V41e6fy1QHD4E1z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 26 Feb 2022 18:13:04 +0100 (CET)
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
Subject: [PATCH v16 3/4] drm/bridge: display-connector: add ddc-en gpio support
Date:   Sat, 26 Feb 2022 18:13:01 +0100
Message-Id: <31045a729978327615a50d4d17b47e6034095192.1645895582.git.hns@goldelico.com>
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

