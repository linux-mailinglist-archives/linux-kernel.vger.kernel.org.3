Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C674C7810
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiB1Skd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiB1SkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:40:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E9B1A83
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:31:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v21so16846845wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80IauG/d1J+24O+js6o66KmrN0KsXMCLre6trIg99LQ=;
        b=iMrbNpsj+1cEzLoigb874QD2f9x0Svo32wxz2+LBSGHl8vwNV4yGlBiP1HGdQV3PoX
         NPIKH4eQeFuWAL9MxTvrJKJneoatmzeWN1WDnolpHqwf0/yhsSaxaAp74JvBOgBXcoQ7
         1IndfORgIfOq46dOCBD19cAY2y5JKz4/iN1u2qCa4ViyvDy6APu1HmZ8aqbx2YRuAywQ
         L1nQvDE9IqctLNIv8YIqQtWJIgIVA5EY8dP3em70i96qa3GOtsS96UCC7WZStxyRv6au
         wBV2IgmC+M7ED202x7xe7+iyYG6zcEAeyP1uROqu5yC3yssHk793OaI2207EGEpuZuW3
         ehJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80IauG/d1J+24O+js6o66KmrN0KsXMCLre6trIg99LQ=;
        b=TR+gPXiRDMOeugRFen+B8yy3T5piE8S5Y1o7LgSFje6SEduRa3/AiXyZlZNkPXNs/9
         jHm/O/rPzWWfA8G89ouCjIDwlhTP1D9RZXVJqYoCjVkUN+tECHTSxWwbDz5aOWj19TRA
         rP1YNX26tUJhxZpDTNmqxhAIH8ePWDvpL4WuAzeYmNgYvwUrchc8S61be33jS69+8nXO
         NnqYSTb4moA0aWxfZG9toMZscvcJ38dHgi6Faw8fQwqignLJqS+r2yZrKWnfmTHzIkVb
         F8oFC+QF6mGpkIYEdAyEHpdWYIKY9iQaHxJfotjK2uGIeCkMUeIkeB01cXEBhYHW/Bno
         ms9w==
X-Gm-Message-State: AOAM5311xvD9eDOPj3rIM3to1l8z1WfI3RcV+k7zOMwZgtDNIJYWkqnJ
        yDBhJj618YtFbpmruNqJzYg=
X-Google-Smtp-Source: ABdhPJyPAH/7Ee3C7zgL5tsV5rMzbtFf4QKcHZbN52HkzSCV9cCbcgECaNTt8rOXdUCTC9tDW5e9KA==
X-Received: by 2002:a5d:59a6:0:b0:1f0:150:4bad with SMTP id p6-20020a5d59a6000000b001f001504badmr445442wrr.581.1646073099334;
        Mon, 28 Feb 2022 10:31:39 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b001edc38024c9sm12670725wra.65.2022.02.28.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:31:39 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     andrzej.hajda@intel.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/bridge: parade-ps8640: switch to devm_drm_of_get_bridge
Date:   Mon, 28 Feb 2022 19:31:31 +0100
Message-Id: <20220228183131.23494-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function "drm_of_find_panel_or_bridge" has been deprecated in
favor of "devm_drm_of_get_bridge".

Switch to the new function and reduce boilerplate.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 818704bf5e86..1c2c4dd50ce0 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -566,7 +566,6 @@ static int ps8640_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
 	struct ps8640 *ps_bridge;
-	struct drm_panel *panel;
 	int ret;
 	u32 i;
 
@@ -651,13 +650,7 @@ static int ps8640_probe(struct i2c_client *client)
 	devm_of_dp_aux_populate_ep_devices(&ps_bridge->aux);
 
 	/* port@1 is ps8640 output port */
-	ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
-	if (ret < 0)
-		return ret;
-	if (!panel)
-		return -ENODEV;
-
-	ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	ps_bridge->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
 	if (IS_ERR(ps_bridge->panel_bridge))
 		return PTR_ERR(ps_bridge->panel_bridge);
 
-- 
2.25.1

