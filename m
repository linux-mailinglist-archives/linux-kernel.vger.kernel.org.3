Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B95453FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbiFIST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345355AbiFISTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:19:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE63B4040
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:19:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so20889332plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3m9ez4cM4hiYs276hV/EUX/qeGe+tzFYgA9QX32RhM=;
        b=jkK73066+UxvJ5xFs1AtNV3sHc9/h6S8mJVHGO3CFCC+9KuwpwXefPlSAW5U2xfllr
         HHaHLrfTss2GcS9nAoLug0IHIr9n1zKvu6SDZlqz3j3Ft+SZouLsl5pqvJiWJBd4aULj
         ocBiWRPWQMUCK/Q7DmcT66O517yBB8lA5ti2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3m9ez4cM4hiYs276hV/EUX/qeGe+tzFYgA9QX32RhM=;
        b=2v0vykNFFqwLthmfiwj5nKS57ONYq7sh5PLbjseWjcic/pcWFbiT36zhF91+wOOCuu
         TaIjII8XQKXCDLNwzuUVQZ4bMf3TzoI8BQv1e5xmIHtFz4rgkZ8O674vzFJ0/cLch9Fc
         q0IYHRkF2sbtTijqBp7xRviuiP8Ksy2J6ftvsaYM+0QlqugyEb07I8S9hd927/Qit8Io
         nQ/6ZaAvGgfmNUVab0WrGUyKcjWgo31nNiHTPZmWjVtjyG5lU0w0eAeo5iuCHg1Cu9Yh
         nYI7qJ1UMFG5yj/WHvjIVK38T1YGldU3fAjSPbALR8ezaaES0m+DnTv3qFnH+npO+Fl5
         zt2Q==
X-Gm-Message-State: AOAM532z9kZdeV6J1wDfalw58A1HTbX7KvD5WR7ihYYhg2Ddgvr0MN3B
        hNEtuHYmHB0sK6B27z1BILs52rZzHJH7Hw==
X-Google-Smtp-Source: ABdhPJzhlzTGKke4dLwYx4GBwR8EWUUrWbpjJrMKK7ZTUdjPnXvKfnhCIFdSOp1vZlUMaDGMYuXWDg==
X-Received: by 2002:a17:902:edd7:b0:168:b0b2:f0a3 with SMTP id q23-20020a170902edd700b00168b0b2f0a3mr2412619plk.20.1654798761971;
        Thu, 09 Jun 2022 11:19:21 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b003fb0354c43asm17728049pgj.32.2022.06.09.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:19:21 -0700 (PDT)
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
Subject: [PATCH v2 5/7] drm/bridge: anx7625: Register number of Type C switches
Date:   Thu,  9 Jun 2022 18:09:44 +0000
Message-Id: <20220609181106.3695103-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220609181106.3695103-1-pmalani@chromium.org>
References: <20220609181106.3695103-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v1:
- No changes.

 drivers/gpu/drm/bridge/analogix/anx7625.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 53a5da6c49dd..07ed44c6b839 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2581,6 +2581,22 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
+static int anx7625_register_typec_switches(struct device *device, struct anx7625_data *ctx)
+{
+	struct device_node *of = NULL;
+	int ret = 0;
+
+	of = of_get_child_by_name(device->of_node, "switches");
+	if (!of)
+		return -ENODEV;
+
+	ctx->num_typec_switches = of_get_child_count(of);
+	if (ctx->num_typec_switches <= 0)
+		return -ENODEV;
+
+	return ret;
+}
+
 static int anx7625_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
@@ -2686,6 +2702,10 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (platform->pdata.intp_irq)
 		queue_work(platform->workqueue, &platform->work);
 
+	ret = anx7625_register_typec_switches(dev, platform);
+	if (ret)
+		dev_info(dev, "Didn't register Type C switches, err: %d\n", ret);
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

