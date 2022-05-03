Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720351918F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbiECWof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbiECWo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:44:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC341F93
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:40:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w17-20020a17090a529100b001db302efed6so3191234pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJTMp60yVPlpACNJP/dPSerG6q4+tCNFLovcxZfzgpw=;
        b=mPiekIzUJZ1ORsFOwevg29S0fjLLyCb6eTpc6bO+PI8+8zvjqyUtZHNV+eui9dr/wu
         7z7br0XhXN9ubuQQnpWD+kemfxzRMjMKbepsIZdLeBz5BSRZcTf9HqMWSsD1AaxuTv30
         ywRf8Bx6v27k7tzIVuZ6SpHE1vyE5QcghEj4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJTMp60yVPlpACNJP/dPSerG6q4+tCNFLovcxZfzgpw=;
        b=wbCTkphfKYwFNdW8REV5VNGKWjviJ5+Sqn5zDJDMB7KIg8ghHtnwdn4zXqg50JucQa
         Yvj42YJh0NFNcfgUUmPWSzOJybZpeYosKYkbeIasaRLgxn9+V3umBTkitUhasjWgs54/
         sYgW2PjbzDl/6XrdvlpSIU1Vx0YpPaXPurbgs14YsuhNHs+9HAFBMbtqmiKmEfzZSAQ5
         KyI5SYHZEM79egYBMwUeFvLRzqQkaEJGLSxeXjySHWWmQ/6bRHFYqXsErinysE+lnHnD
         pOQ6xuU+WzO3uix38UBsx+uTK77rQrUY4o4u+DEwiZG8dDYwvIRN1G9O+Z+aETfNQpbp
         eWEQ==
X-Gm-Message-State: AOAM530c0lN8bh3LfsTISG8S7kWPsw7EKRUUPZaFZRneRTR9JBfmEwnz
        iOKvZlf62G7e59jRSxWnZsBajQ==
X-Google-Smtp-Source: ABdhPJxI1px4iialtat/eNsHwtP473+rj8LypxEcCFT7XlM63zuMiRvvrL3tTsdNa82uXlSxVWhzsA==
X-Received: by 2002:a17:902:9001:b0:156:a567:2683 with SMTP id a1-20020a170902900100b00156a5672683mr18769417plp.164.1651617654273;
        Tue, 03 May 2022 15:40:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:93ca:84cb:c452:c0a3])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b0015e8d4eb27esm6803778plb.200.2022.05.03.15.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:40:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/bridge: parade-ps8640: Handle DP AUX more properly
Date:   Tue,  3 May 2022 15:40:29 -0700
Message-Id: <20220503153850.v2.2.Ia6324ebc848cd40b4dbd3ad3289a7ffb5c197779@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220503224029.3195306-1-dianders@chromium.org>
References: <20220503224029.3195306-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it works, for the most part, to assume that the panel has
finished probing when devm_of_dp_aux_populate_ep_devices() returns,
it's a bit fragile. This is talked about at length in commit
a1e3667a9835 ("drm/bridge: ti-sn65dsi86: Promote the AUX channel to
its own sub-dev").

When reviewing the ps8640 code, I managed to convince myself that it
was OK not to worry about it there and that maybe it wasn't really
_that_ fragile. However, it turns out that it really is. Simply
hardcoding panel_edp_probe() to return -EPROBE_DEFER was enough to put
the boot process into an infinite loop. I believe this manages to trip
the same issues that we used to trip with the main MSM code where
something about our actions trigger Linux to re-probe previously
deferred devices right away and each time we try again we re-trigger
Linux to re-probe.

Let's fix this using the callback introduced in the patch ("drm/dp:
Callbacks to make it easier for drivers to use DP AUX bus properly").
When using the new callback, we have to be a little careful. The
probe_done() callback is no longer (always) called in the context of
our probe routine. That means we can't rely on being able to return
-EPROBE_DEFER from it. We re-jigger the order of things a bit to
account for that.

With this change, the device still boots (though obviously the panel
doesn't come up) if I force panel-edp to always return
-EPROBE_DEFER. If I fake it and make the panel probe exactly once it
also works.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Rewrote atop new method introduced by patch #1.

 drivers/gpu/drm/bridge/parade-ps8640.c | 77 +++++++++++++++++---------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index edb939b14c04..68131ca91eac 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -104,6 +104,7 @@ struct ps8640 {
 	struct gpio_desc *gpio_powerdown;
 	struct device_link *link;
 	bool pre_enabled;
+	bool bridge_added;
 };
 
 static const struct regmap_config ps8640_regmap_config[] = {
@@ -537,12 +538,11 @@ static const struct drm_bridge_funcs ps8640_bridge_funcs = {
 	.pre_enable = ps8640_pre_enable,
 };
 
-static int ps8640_bridge_host_attach(struct device *dev, struct ps8640 *ps_bridge)
+static int ps8640_bridge_get_dsi_resources(struct device *dev, struct ps8640 *ps_bridge)
 {
 	struct device_node *in_ep, *dsi_node;
 	struct mipi_dsi_device *dsi;
 	struct mipi_dsi_host *host;
-	int ret;
 	const struct mipi_dsi_device_info info = { .type = "ps8640",
 						   .channel = 0,
 						   .node = NULL,
@@ -577,17 +577,44 @@ static int ps8640_bridge_host_attach(struct device *dev, struct ps8640 *ps_bridg
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = NUM_MIPI_LANES;
 
-	ret = devm_mipi_dsi_attach(dev, dsi);
+	return 0;
+}
+
+static int ps8640_bridge_link_panel(struct drm_dp_aux *aux)
+{
+	struct ps8640 *ps_bridge = aux_to_ps8640(aux);
+	struct device *dev = aux->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	/*
+	 * NOTE about returning -EPROBE_DEFER from this function: if we
+	 * return an error (most relevant to -EPROBE_DEFER) it will only
+	 * be passed out to ps8640_probe() if we don't have our panel
+	 * under the "aux-bus". That should be fine because if the panel is
+	 * under "aux-bus" it's guaranteed to have probed by the time this
+	 * function has been called.
+	 */
+
+	/* port@1 is ps8640 output port */
+	ps_bridge->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
+	if (IS_ERR(ps_bridge->panel_bridge))
+		return PTR_ERR(ps_bridge->panel_bridge);
+
+	drm_bridge_add(&ps_bridge->bridge);
+
+	ret = devm_mipi_dsi_attach(dev, ps_bridge->dsi);
 	if (ret)
-		return ret;
+		drm_bridge_remove(&ps_bridge->bridge);
+	else
+		ps_bridge->bridge_added = true;
 
-	return 0;
+	return ret;
 }
 
 static int ps8640_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device_node *np = dev->of_node;
 	struct ps8640 *ps_bridge;
 	int ret;
 	u32 i;
@@ -628,6 +655,14 @@ static int ps8640_probe(struct i2c_client *client)
 	if (!ps8640_of_panel_on_aux_bus(&client->dev))
 		ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
 
+	/*
+	 * Get MIPI DSI resources early. These can return -EPROBE_DEFER so
+	 * we want to get them out of the way sooner.
+	 */
+	ret = ps8640_bridge_get_dsi_resources(&client->dev, ps_bridge);
+	if (ret)
+		return ret;
+
 	ps_bridge->page[PAGE0_DP_CNTL] = client;
 
 	ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
@@ -670,31 +705,23 @@ static int ps8640_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	devm_of_dp_aux_populate_ep_devices(&ps_bridge->aux);
-
-	/* port@1 is ps8640 output port */
-	ps_bridge->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
-	if (IS_ERR(ps_bridge->panel_bridge))
-		return PTR_ERR(ps_bridge->panel_bridge);
-
-	drm_bridge_add(&ps_bridge->bridge);
-
-	ret = ps8640_bridge_host_attach(dev, ps_bridge);
-	if (ret)
-		goto err_bridge_remove;
-
-	return 0;
-
-err_bridge_remove:
-	drm_bridge_remove(&ps_bridge->bridge);
-	return ret;
+	/*
+	 * Kick off the probe for our panel if it's on the dp-aux bus.
+	 * If the panel is on the aux bus ps8640_bridge_link_panel() will
+	 * get called when it finishes probing. If the panel is an old-style
+	 * platform device ps8640_bridge_link_panel() will be called directly
+	 * and its return value will be the return value of our function.
+	 */
+	return devm_of_dp_aux_populate_ep_device(&ps_bridge->aux,
+						 ps8640_bridge_link_panel);
 }
 
 static int ps8640_remove(struct i2c_client *client)
 {
 	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
 
-	drm_bridge_remove(&ps_bridge->bridge);
+	if (ps_bridge->bridge_added)
+		drm_bridge_remove(&ps_bridge->bridge);
 
 	return 0;
 }
-- 
2.36.0.464.gb9c8b46e94-goog

