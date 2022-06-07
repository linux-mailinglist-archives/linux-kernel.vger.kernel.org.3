Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D25424D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390484AbiFHAvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382715AbiFGVvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:51:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3A1912EE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:09:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g186so7875317pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zv6DUaDAW0iYk91AWgt5SeSWK+UTvh87ZNXi8mCkADI=;
        b=mwjQcID3rvKF93+FfvpOrFV+CjWy6pKoNXnMY/jvTDR27o1WtjtWyytbJp5+ZxSuQG
         MsV/mGMRqjO6SKY5JLuSafWagoX+C0e3RkwDuP6S6KNJvGq2tllJjGp6Klpc2QstdvEI
         LGSJKqQFNc9NImfFVyEZdWcd5fcCt4ema/AQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zv6DUaDAW0iYk91AWgt5SeSWK+UTvh87ZNXi8mCkADI=;
        b=3pa6mX7VfXMYT/kHe0SAFNYtyy65QA6/OCJ25ioiCqZln9aVc/gBOCASMHwxlfkO1P
         qQY1uo+ZUZjHNv+9TMwUhSE7+C+VErIr3jCjju6Ww8dImglI2/qrVvqC0UtzQ9cRAz32
         jNaHzXiy3WNsxH+a5cBWVrdkZ5pYZQDYlH1Ro8cXkpMKiul/AjqHMpaqTY7PxNKIHBmE
         GJPOohxNBvucvITzhu0l9r2RN0VUILFhQb+Rx5Fhc5ZbIDdpUwjuGeRXM+UzIYqdWkJP
         nR4phfQebc7CnLgd7BxooxPW5CphVumGowNryUkMQnzabaoCMNVhDzaHE4P0SpcZijuH
         BeuA==
X-Gm-Message-State: AOAM531Hybi3ddqEQpC9EQjZLLjMQ7CaTAcjN33ETUVydfpAgd0UOUHo
        Ie4kXt5QL1kdHufF4IjC1Wn+bZTRhdnYnQ==
X-Google-Smtp-Source: ABdhPJxg13/ypCkYzKXsJqhP1fBID2bU68Drc0UUN8dMixPUYyS7csEranmT2FlCgcicHOIGfd4fvQ==
X-Received: by 2002:a63:e5d:0:b0:3aa:3c53:537e with SMTP id 29-20020a630e5d000000b003aa3c53537emr26718637pgo.622.1654628958136;
        Tue, 07 Jun 2022 12:09:18 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm13236084pfq.120.2022.06.07.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:09:17 -0700 (PDT)
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
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH 5/7] drm/bridge: anx7625: Register number of Type C switches
Date:   Tue,  7 Jun 2022 19:00:23 +0000
Message-Id: <20220607190131.1647511-6-pmalani@chromium.org>
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

Parse the "switches" node, if available, and count and store the number
of Type-C switches within it. Since we currently don't do anything with
this info, no functional changes are expected from this change.

This patch sets a foundation for the actual registering of Type-C
switches with the Type-C connector class framework.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
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
2.36.1.255.ge46751e96f-goog

