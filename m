Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9548854BADB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiFNToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345089AbiFNTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:43:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F82C656
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:43:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so8571682plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrrP/zJdRTkEhRPo0RbWE/0KRS6oPs0nqZx19bNbNaw=;
        b=H6M31qNEkKNkvbdYFwIE8oo1NJB3Uh0O+pSPhqKIs2vHbVcldJkZMhtps0K2q5cWnG
         ssIghlzgq0f0UiNyMaT72VwV03kZluLC/THLzmnkvceyV9aUaBE/JG2RxvWbsUZzznHs
         bltKY6P/IrM5fNgU9zUelJ8R+OAeDDgGNfqR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrrP/zJdRTkEhRPo0RbWE/0KRS6oPs0nqZx19bNbNaw=;
        b=timmBWr/zd2/8f4pjkXtCpnAwiw7X3kAyAZcMrm7vmEYKja7HDU1SddaUYqbzRP4tM
         n4boqkbokzWLo16QXkoibLukMSVDHHfyRyf8DTI7PDBjVlX2Gb3RNS2EkLpDbaMS3kx5
         0LvQWvVqbXLr/tBeRggW2QlpxE+h2JCX4CwRetPrJNVnEklCYilRViR6S5y/s491Yk8h
         7nUqh4fV6eczOPnu1pCKaL38cMDgfhSyQh1l/JzHlzdlwWYiFX3kfe2N6Id0+vPm75ZH
         3gLPOAG5ZyqHXMjm2htopF1LT14AI+fP5K17Qq424/ohL9VGcAWwgBAQGTVLPYsSSQeC
         45yw==
X-Gm-Message-State: AJIora8iPNgZwX5dR4d7cYKVnfu9e5F67eAHkl/WAo3tcLMLW16qujv4
        8UIzsu6R33BeyZxqW+Da9nV7/Abkl1wK+Q==
X-Google-Smtp-Source: AGRyM1sn/DSEuxrzWgsQgR3jKAz550h1x3Kr9deBUlcjGj2PTAlcKFuJV1v7+Ntk6ZUVumEcwJtWrw==
X-Received: by 2002:a17:90b:2248:b0:1ea:8403:d81c with SMTP id hk8-20020a17090b224800b001ea8403d81cmr6171253pjb.97.1655235836991;
        Tue, 14 Jun 2022 12:43:56 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a409500b001df3a251cc2sm10014426pjg.4.2022.06.14.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:43:56 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v3 5/7] drm/bridge: anx7625: Register number of Type C switches
Date:   Tue, 14 Jun 2022 19:34:39 +0000
Message-Id: <20220614193558.1163205-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614193558.1163205-1-pmalani@chromium.org>
References: <20220614193558.1163205-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Parse the "switches" node, if available, and count and store the number
of Type-C switches within it. Since we currently don't do anything with
this info, no functional changes are expected from this change.

This patch sets a foundation for the actual registering of Type-C
switches with the Type-C connector class framework.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- Move ret variable to Patch v3 6/7..
- Make error print a dev_dbg, since it is noisy.
- Added Reviewed-by and Tested-by tags.

Changes since v1:
- No changes.

 drivers/gpu/drm/bridge/analogix/anx7625.c | 18 ++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 53a5da6c49dd..e3d4c2738b8c 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2581,6 +2581,20 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
+static int anx7625_register_typec_switches(struct device *device, struct anx7625_data *ctx)
+{
+	struct device_node *of = of_get_child_by_name(device->of_node, "switches");
+
+	if (!of)
+		return -ENODEV;
+
+	ctx->num_typec_switches = of_get_child_count(of);
+	if (ctx->num_typec_switches <= 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int anx7625_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
@@ -2686,6 +2700,10 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (platform->pdata.intp_irq)
 		queue_work(platform->workqueue, &platform->work);
 
+	ret = anx7625_register_typec_switches(dev, platform);
+	if (ret)
+		dev_dbg(dev, "Didn't register Type C switches, err: %d\n", ret);
+
 	platform->bridge.funcs = &anx7625_bridge_funcs;
 	platform->bridge.of_node = client->dev.of_node;
 	if (!anx7625_of_panel_on_aux_bus(&client->dev))
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index e257a84db962..d5cbca708842 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -473,6 +473,7 @@ struct anx7625_data {
 	struct drm_connector *connector;
 	struct mipi_dsi_device *dsi;
 	struct drm_dp_aux aux;
+	int num_typec_switches;
 };
 
 #endif  /* __ANX7625_H__ */
-- 
2.36.1.476.g0c4daa206d-goog

