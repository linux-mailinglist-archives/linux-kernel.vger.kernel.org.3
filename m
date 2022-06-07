Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3C542008
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383243AbiFHAOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383107AbiFGVwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:52:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67524122A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:10:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 15so16337072pfy.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtnd1F0vuAX+/SSVkwOkbzDfCKD7NqVqctogi5Hk2AA=;
        b=CqXu0CzsDXaL8f4kHkILIRYhaVMJlEEZJve6173/IyJOY+6hZBJ2jTZ+ecXwv5Qaxl
         AjrgNeQsszbcXAsAz2R/wSTc5rnL23YTDuFZ6YBHelCphdL0Em4uFQTsAKgWzPNtXpkc
         UwQJk0R+SUAUKFHK25pzHvnHhkbyl8YlEBHtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtnd1F0vuAX+/SSVkwOkbzDfCKD7NqVqctogi5Hk2AA=;
        b=lZFwO5MuWaCzvtEbkiY364O/wkEADeFzCUPrPfnAskc+ki2VjtO1NQWRzRyCBclEM+
         3QxLe5fOfh+6giygDL6gp0xURl1EJUwGJg/wvZV9pOOsbQFVdvGELWLEFQ2UeifNwPa9
         NLddIjPs0s9107uAFRpntq7B3T7fID3mPYBJWEnEAyYYGN+9Vv2o3Aj4Qsle2ga0JhmA
         hcwxfZRsk7Focd7zlZ7TkIVht99axgs4va6/l/E7XSTiJBzkshs8n0l5cFWQ9EjFIgBH
         715huQeTZwOWCuAcBGeGqHPvF5scK9SQXpY4LoeXq456jwryGdBXRoLoqsG1W2XGIKzs
         rXeA==
X-Gm-Message-State: AOAM533nxM5A9TW8dI4/SrviC+qrCeH9yf8u21ETP6Lxda3fGndv+U5K
        OPnNdqD+svH/gmEBN9yNIuqeCS6CuJd2Zw==
X-Google-Smtp-Source: ABdhPJyEvAvvAaY3dZFRWUyYvtdG80hZekeAOwP3RWeCHo6Lp2FGOWeFtVrcCubIKWe5YhhyXQb3pw==
X-Received: by 2002:a63:2117:0:b0:3fd:d5d7:ad12 with SMTP id h23-20020a632117000000b003fdd5d7ad12mr8819598pgh.255.1654629030483;
        Tue, 07 Jun 2022 12:10:30 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm13236084pfq.120.2022.06.07.12.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:10:29 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH 6/7] drm/bridge: anx7625: Register Type-C mode switches
Date:   Tue,  7 Jun 2022 19:00:24 +0000
Message-Id: <20220607190131.1647511-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607190131.1647511-1-pmalani@chromium.org>
References: <20220607190131.1647511-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the DT node has "switches" available, register a Type-C mode-switch
for each listed "switch". This allows the driver to receive state
information about what operating mode a Type-C port and its connected
peripherals are in, as well as status information (like VDOs) related to
that state.

The callback function is currently a stub, but subsequent patches will
implement the required functionality.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 73 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  6 ++
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 07ed44c6b839..d41a21103bd3 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -15,6 +15,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/usb/typec_mux.h>
 #include <linux/workqueue.h>
 
 #include <linux/of_gpio.h>
@@ -2581,9 +2582,59 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
+static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
+				 struct typec_mux_state *state)
+{
+	return 0;
+}
+
+static int anx7625_register_mode_switch(struct device *dev, struct device_node *node,
+					struct anx7625_data *ctx)
+{
+	struct anx7625_port_data *port_data;
+	struct typec_mux_desc mux_desc = {};
+	char name[32];
+	u32 port_num;
+	int ret;
+
+	ret = of_property_read_u32(node, "reg", &port_num);
+	if (ret)
+		return ret;
+
+	if (port_num >= ctx->num_typec_switches) {
+		dev_err(dev, "Invalid port number specified: %d\n", port_num);
+		return -EINVAL;
+	}
+
+	port_data = &ctx->typec_ports[port_num];
+	port_data->ctx = ctx;
+	mux_desc.fwnode = &node->fwnode;
+	mux_desc.drvdata = port_data;
+	snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
+	mux_desc.name = name;
+	mux_desc.set = anx7625_typec_mux_set;
+
+	port_data->typec_mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(port_data->typec_mux)) {
+		ret = PTR_ERR(port_data->typec_mux);
+		dev_err(dev, "Mode switch register for port %d failed: %d", port_num, ret);
+	}
+
+	return ret;
+}
+
+static void anx7625_unregister_typec_switches(struct anx7625_data *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->num_typec_switches; i++)
+		typec_mux_unregister(ctx->typec_ports[i].typec_mux);
+}
+
 static int anx7625_register_typec_switches(struct device *device, struct anx7625_data *ctx)
 {
 	struct device_node *of = NULL;
+	struct device_node *sw;
 	int ret = 0;
 
 	of = of_get_child_by_name(device->of_node, "switches");
@@ -2594,6 +2645,26 @@ static int anx7625_register_typec_switches(struct device *device, struct anx7625
 	if (ctx->num_typec_switches <= 0)
 		return -ENODEV;
 
+	ctx->typec_ports = devm_kzalloc(device,
+					ctx->num_typec_switches * sizeof(struct anx7625_port_data),
+					GFP_KERNEL);
+	if (!ctx->typec_ports)
+		return -ENOMEM;
+
+	/* Register switches for each connector. */
+	for_each_available_child_of_node(of, sw) {
+		if (!of_property_read_bool(sw, "mode-switch"))
+			continue;
+		ret = anx7625_register_mode_switch(device, sw, ctx);
+		if (ret) {
+			dev_err(device, "Failed to register mode switch: %d\n", ret);
+			break;
+		}
+	}
+
+	if (ret)
+		anx7625_unregister_typec_switches(ctx);
+
 	return ret;
 }
 
@@ -2759,6 +2830,8 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&platform->bridge);
 
+	anx7625_unregister_typec_switches(platform);
+
 	if (platform->pdata.intp_irq)
 		destroy_workqueue(platform->workqueue);
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index d5cbca708842..76cfc64f7574 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -443,6 +443,11 @@ struct anx7625_i2c_client {
 	struct i2c_client *tcpc_client;
 };
 
+struct anx7625_port_data {
+	struct typec_mux_dev *typec_mux;
+	struct anx7625_data *ctx;
+};
+
 struct anx7625_data {
 	struct anx7625_platform_data pdata;
 	struct platform_device *audio_pdev;
@@ -474,6 +479,7 @@ struct anx7625_data {
 	struct mipi_dsi_device *dsi;
 	struct drm_dp_aux aux;
 	int num_typec_switches;
+	struct anx7625_port_data *typec_ports;
 };
 
 #endif  /* __ANX7625_H__ */
-- 
2.36.1.255.ge46751e96f-goog

