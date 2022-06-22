Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD745552BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377399AbiFVRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377384AbiFVRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:45:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E26D3467E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:45:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso147712pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUYHW95AtLLmO7V4imqn0bSxETrjySQOkszCKZgpB8c=;
        b=lbchqIqZHE9CwsidR5WeollNQ6dBNgdTnBG0KNFSuSMHXIevxj6D7aC9O2Teg3vixK
         WJ1Jr3arfzfufi6xxT/db/9/UlXuAuGrZ5BnHzfyMgsT3ULuzk/danAHku6hBy6TgC2+
         7TZUUjQWMf/S6gPNFwmWDdi8AbH1Y1mJRKcXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUYHW95AtLLmO7V4imqn0bSxETrjySQOkszCKZgpB8c=;
        b=zkXsxfUuq76YTd+YmJJjQazhOlnrnJ8Cg8cFcd5SNX2L5jHKkU6yPW68juKLYj94zj
         PWrh+AWZ9SERRELuwAfgjL4w1AvzsSqvkeVxE7iDwmp8RFELxSOyMpiNKYVvezdJj0BF
         Oq+c/JOBR3t7lHnj7Iv8r+ZMpV9cWQ3FCms93pqpRCl+adeO7C2asfbEimJmi62lx5E+
         I11Nhlknom00rSlzjgyWgPbsVxD6vxUB2uiB2eI/AjOptLoIK6LvnXQhcZfYMx8QH69/
         ZTpl7N8bXq14Xg8Ve8u/RfFHomfApBiVXnMRveVtoY3nt3g+CSVEA5hDppsjCFkS1JQy
         +osQ==
X-Gm-Message-State: AJIora9/4+6FJbXjFAGt/+Y8uCHc20ZMco8o/PR+k9FGgxRbv51/F5Pu
        L02sgYB5mTSc+qiiiheIFpwpoFljYvfH2w==
X-Google-Smtp-Source: AGRyM1sFxe9GH21t/auStPnBEkJHItewIiphX9U6txtmcstedWPu/2gRKDpmd2xjVTxW4cdMr9LGMw==
X-Received: by 2002:a17:903:2285:b0:16a:2ee7:4779 with SMTP id b5-20020a170903228500b0016a2ee74779mr13121137plh.43.1655919953548;
        Wed, 22 Jun 2022 10:45:53 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090b079100b001ece55aec38sm35470pjz.30.2022.06.22.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:45:53 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
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
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v5 7/9] drm/bridge: it6505: Register number of Type C switches
Date:   Wed, 22 Jun 2022 17:34:36 +0000
Message-Id: <20220622173605.1168416-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622173605.1168416-1-pmalani@chromium.org>
References: <20220622173605.1168416-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pin-Yen Lin <treapking@chromium.org>

Parse the "switches" node, if available, and count and store the number
of Type-C switches within it. The extcon registration is still
supported, but we don't expect both extcon and typec-switch be
registered at the same time.

This patch sets a foundation for the actual registering of Type-C
switches with the Type-C connector class framework.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

v5 is the first version for this patch.

 drivers/gpu/drm/bridge/ite-it6505.c | 34 +++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 4b673c4792d7..b259f9f367f6 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -452,6 +452,7 @@ struct it6505 {
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
 	struct dentry *debugfs;
+	int num_typec_switches;
 
 	/* it6505 driver hold option */
 	bool enable_drv_hold;
@@ -3229,13 +3230,28 @@ static void it6505_shutdown(struct i2c_client *client)
 		it6505_lane_off(it6505);
 }
 
+static int it6505_register_typec_switches(struct device *device, struct it6505 *it6505)
+{
+	struct device_node *of;
+
+	of = of_get_child_by_name(device->of_node, "switches");
+	if (!of)
+		return -ENODEV;
+
+	it6505->num_typec_switches = of_get_child_count(of);
+	if (it6505->num_typec_switches <= 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int it6505_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
 	struct it6505 *it6505;
 	struct device *dev = &client->dev;
 	struct extcon_dev *extcon;
-	int err, intp_irq;
+	int err, intp_irq, ret;
 
 	it6505 = devm_kzalloc(&client->dev, sizeof(*it6505), GFP_KERNEL);
 	if (!it6505)
@@ -3255,11 +3271,21 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	if (PTR_ERR(extcon) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (IS_ERR(extcon)) {
-		dev_err(dev, "can not get extcon device!");
-		return PTR_ERR(extcon);
+		if (PTR_ERR(extcon) != -ENODEV)
+			dev_warn(dev, "Cannot get extcon device: %ld", PTR_ERR(extcon));
+		it6505->extcon = NULL;
+	} else {
+		it6505->extcon = extcon;
 	}
 
-	it6505->extcon = extcon;
+	ret = it6505_register_typec_switches(dev, it6505);
+	if (ret) {
+		dev_dbg(dev, "Didn't register Type C switches, err: %d", ret);
+		if (!it6505->extcon) {
+			dev_err(dev, "Both extcon and typec-switch are not registered.");
+			return -EINVAL;
+		}
+	}
 
 	it6505->regmap = devm_regmap_init_i2c(client, &it6505_regmap_config);
 	if (IS_ERR(it6505->regmap)) {
-- 
2.37.0.rc0.104.g0611611a94-goog

