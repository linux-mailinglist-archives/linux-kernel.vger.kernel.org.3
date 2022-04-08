Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF034F8C64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiDHBgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDHBgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:36:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9326E020
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:34:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 1C6661F46B10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649381642;
        bh=o8jyjimeTtzJ50BwKCRZ9f6gmB8wWl9FaBazezNCQ2M=;
        h=From:To:Cc:Subject:Date:From;
        b=YlIfXEQt3gi/6hDFEHwlPjoJ4xuHoCLzl5EtEkYNidX8kC4pfiTTIStaGad/8xtGy
         SgXMagTAp4i5u4O+q4IdIMQ6Ov7VmFvqLA7onwUwjXvFzOHqEm3VQAChufM4T64Uj1
         KyScdLzT7Tei6OfwqsNGQTbvotz4VNlm0EqULINJ8xks/zeZONcyn+I+twXdIweMHn
         RnqLBy5gnFOU5d5MzPk8q2WynBbONjKfplCrbXMqFBnzhPa/5JjQok3Sgl4k5JFxGQ
         ltW2LjNl7i28Bt3FdKwEhCcRVNW4hrB+3tzv8l8PT+Db1p63CRka8wQRRBMtknkmSr
         POvRznn/xkc4w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Use irq flags from devicetree
Date:   Thu,  7 Apr 2022 21:33:56 -0400
Message-Id: <20220408013356.673732-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the irq flags, like which edge to trigger on, from the devicetree
and use those when registering the irq instead of hardcoding them.
In case none was specified, fallback to falling edge trigger.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6516f9570b86..97d954b8cc12 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2588,6 +2588,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	struct anx7625_platform_data *pdata;
 	int ret = 0;
 	struct device *dev = &client->dev;
+	unsigned long irqflags;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
@@ -2639,10 +2640,13 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 			goto free_hdcp_wq;
 		}
 
+		irqflags = irq_get_trigger_type(client->irq);
+		if (!irqflags)
+			irqflags = IRQF_TRIGGER_FALLING;
+
 		ret = devm_request_threaded_irq(dev, platform->pdata.intp_irq,
 						NULL, anx7625_intr_hpd_isr,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
+						irqflags | IRQF_ONESHOT,
 						"anx7625-intp", platform);
 		if (ret) {
 			DRM_DEV_ERROR(dev, "fail to request irq\n");
-- 
2.35.1

