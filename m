Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106205310D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiEWKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiEWKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:52:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A041931361
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:52:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184-20020a1c02c1000000b003974edd7c56so154685wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLfS42PaaSTIvwoBINmbgQcJWAC+mkxuv8Sro1ZZiBw=;
        b=h7Ar0XPc6m9I8Rf5wHDAfZoG1WMnfebvWZ5PMsjzR2Z5Qpy93Hzk2O1p0IJMPQPx2e
         fI+LdDbsC7B/XHPcDBpBpwFX4ePIq6AgQ23hN5ZUZq1rjV7+sLlE5NGePnl1iQPEVEEq
         mn2qZgeg/WZl5p5a2odv8KBJH3fwk7VlQ9q1iO81MSuZBBWfmB6c38cPcJShOKM7v+tY
         H/PXXEXLlGoPS4o2pzO3gvhyu7q07QXiiDcY9h425ZGqzmanPE1KiAZ54e6+VJNfJpIr
         sBLX1QZev0rIBy6QjmmBMVYMJPuoxirKfPtzyttNpRhvL+61lUwqvhwv6hmR8W0yckwZ
         z7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLfS42PaaSTIvwoBINmbgQcJWAC+mkxuv8Sro1ZZiBw=;
        b=78p3xeHNBpgBT2bxdXrMO1DYCNjNan1bFMTJrH9XSBMC3cY4ISYG/9QkPnIdh72T5q
         rHxOq+JCM2bGPUUkMcFfiEM9Bd2yhHnx3MNamtEn7GuABJen+6Cdf7pCEbqPhegd/veK
         TFfy7L82ztmAnAWknmdjwpAULdImv5+Ix3HbhAlUcaaiJGgxm/tMYsy3UjWXjjUpIAwA
         kaY7bOjEsU/zNbgjA6yuZaCuffIwh0HybWtNYjNGFqQFExuwJ/j9Oc8ln32QthpkTFUt
         NAwzWOFWj2gaEeh2vYXPnfUOoQoKNffDmJCKTYAdZWSJVVKTa5ATST2Tk2dPGrSck1Zo
         us8g==
X-Gm-Message-State: AOAM532MdavBal/KBQPqM9F1+Tn9weUfv5PNj5NKf45fnKo0Bge+5yKy
        /wpW2givlwR8XlyiC00bmGo+kg==
X-Google-Smtp-Source: ABdhPJzde8+aBgbVlyoCCnCNTWr7Ur5rMTCZYCt2csAVS6LILQDcPXm+e3GmDaRs9bF2zxKHX6TnHA==
X-Received: by 2002:a05:600c:42d3:b0:397:47ae:188c with SMTP id j19-20020a05600c42d300b0039747ae188cmr6383674wme.150.1653303136070;
        Mon, 23 May 2022 03:52:16 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:52:15 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 20/21] drm/mediatek: add hpd debounce
Date:   Mon, 23 May 2022 12:47:53 +0200
Message-Id: <20220523104758.29531-21-granquet@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523104758.29531-1-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

From the DP spec 1.4a chapter 3.3, upstream devices should implement
HPD signal de-bouncing on an external connection.
A period of 100ms should be used to detect an HPD connect event.
To cover these cases, HPD de-bounce should be implemented only after
HPD low has been detected for at least 100ms.

Therefore,
1. If HPD is low (which means plugging out) for longer than 100ms:
   we need to do de-bouncing (which means we need to wait for 100ms).
2. If HPD low is for less than 100ms:
   we don't need to care about the de-bouncing.

In this patch, we start a 100ms timer and use a need_debounce boolean
to implement the feature.

Two cases when HPD is high:
1. If the timer is expired (>100ms):
   - need_debounce is true.
   - When HPD high (plugging event comes), need_debounce will be true
     and then we need to do de-bouncing (wait for 100ms).
2. If the timer is not expired (<100ms):
   - need_debounce is false.
   - When HPD high (plugging event comes), need_debounce will be false
     and no need to do de-bouncing.

HPD_______             __________________
          |            |<-  100ms   ->
          |____________|
          <-  100ms   ->

Without HPD de-bouncing, USB-C to HDMI Adapaters will not be detected.

The change has been successfully tested with the following devices:
- Dell Adapter - USB-C to HDMI
- Acer 1in1 HDMI dongle
- Ugreen 1in1 HDMI dongle
- innowatt HDMI + USB3 hub
- Acer 2in1 HDMI dongle
- Apple 3in1 HDMI dongle (A2119)
- J5Create 3in1 HDMI dongle (JAC379)

Tested-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 4789853ec5ff..c056bc3ca9f6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -154,6 +154,8 @@ struct mtk_dp {
 	struct mutex dp_lock;
 
 	struct drm_connector *conn;
+	bool need_debounce;
+	struct timer_list debounce_timer;
 };
 
 static struct regmap_config mtk_dp_regmap_config = {
@@ -1970,6 +1972,9 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	if (event < 0)
 		return IRQ_HANDLED;
 
+	if (mtk_dp->need_debounce && mtk_dp->train_info.cable_plugged_in)
+		msleep(100);
+
 	if (mtk_dp->drm_dev) {
 		dev_info(mtk_dp->dev, "drm_helper_hpd_irq_event\n");
 		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
@@ -2047,6 +2052,11 @@ static irqreturn_t mtk_dp_hpd_isr_handler(struct mtk_dp *mtk_dp)
 	}
 	train_info->cable_state_change = true;
 
+	if (!train_info->cable_plugged_in) {
+		mod_timer(&mtk_dp->debounce_timer, jiffies + msecs_to_jiffies(100) - 1);
+		mtk_dp->need_debounce = false;
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -2474,6 +2484,13 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.detect = mtk_dp_bdg_detect,
 };
 
+static void mtk_dp_debounce_timer(struct timer_list *t)
+{
+	struct mtk_dp *mtk_dp = from_timer(mtk_dp, t, debounce_timer);
+
+	mtk_dp->need_debounce = true;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2547,6 +2564,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	else
 		mtk_dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
+	mtk_dp->need_debounce = true;
+	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -2559,6 +2579,7 @@ static int mtk_dp_remove(struct platform_device *pdev)
 
 	platform_device_unregister(mtk_dp->phy_dev);
 	mtk_dp_video_mute(mtk_dp, true);
+	del_timer_sync(&mtk_dp->debounce_timer);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.35.1

