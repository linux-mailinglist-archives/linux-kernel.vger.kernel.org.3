Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606614BBB77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiBRO6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:58:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiBRO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:57:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911C193DE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:36 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c192so5421354wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyf8Lgz3CGRP90NmEMFSmZ4sowvuSJF2fJjaNq/1oHo=;
        b=3+Bgb08C7VBTeMDKtyxnSNW4MTo/FoqcRvsKM9o7sBdCQrffwQDuUiUHTeQiT0zV7D
         SdsU02OPg8z0wKAdUnpsdvJ13iRHqFyB4izp0ejqW1Cdh1393CxCWGgE7YWJpQU1tFSL
         wpllP/eMvXlWGjt3TU52UJa9wfTMMFy4hZSgNC0wegAkbURh+udXbuodP36LyGD+QK4v
         cAOEYI8S33XeahoHUhCfEHNkcXL+subtTrgzrEdW5EDOewi2aKibwAe9AZcXEzL8Vuc0
         EdWur2NsIb5dKx4Mt/a6LxePfco6A7jeJJp9M/u5c6aSJ394dGN4BGOe6EHp+XFjnRRa
         G4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyf8Lgz3CGRP90NmEMFSmZ4sowvuSJF2fJjaNq/1oHo=;
        b=vhlSn+oj+ktEGHCPah2hYp0obhC7L4NMXJDmEuhxdmKcYRGpJPVdHEDoZY5jwQoj46
         +VrClFFBVEQ5n2CdIrV5YXH1BLqw10ksOJ6NXxS4G2vrUpnSS5KNtc+uxG/BZfw4u5Vi
         jQckP+J5PhWd5NaOzz2Y9dvUPCLIXXUWT3SyRI+5b2kevvpnuw7splUXu5RiCQOy/6l9
         u9LMBU78pCdGum43zUlK8iech79TD6UTlyEF68z36yA69+crloELXy4TEyquTXQHPbWZ
         8b7UvUNZlXjFfAlEU0FUO4UF84EDDjQIBGqhlYbauwG+lcuNMrP1EoPIQlNzZl0cYpC1
         A6cg==
X-Gm-Message-State: AOAM532SUzJYrFlV739rmDZZPkAPVBpTjhs4IOCmVrHNlaJz7AqBuzr/
        qZ7LRwu3skYDLZOScW5Ko4jKNQ==
X-Google-Smtp-Source: ABdhPJx6rXykt2bBihoV1EGcUO8vEHbX7rmGjB/O/cyCDfQdLOoG+5xvSnvWdYVaVgsxH15CXqrdFw==
X-Received: by 2002:a05:600c:3b1d:b0:37c:2d38:945e with SMTP id m29-20020a05600c3b1d00b0037c2d38945emr11411054wms.60.1645196194799;
        Fri, 18 Feb 2022 06:56:34 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:34 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v8 17/19] drm/mediatek: add hpd debounce
Date:   Fri, 18 Feb 2022 15:54:35 +0100
Message-Id: <20220218145437.18563-18-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218145437.18563-1-granquet@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
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

Implement the DP HDP debounce described in DP 1.4a 3.3.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 2a3d5f15b651b..fe91ab8b2fd89 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -178,6 +178,8 @@ struct mtk_dp {
 	struct device *codec_dev;
 	u8 connector_eld[MAX_ELD_BYTES];
 	struct drm_connector *conn;
+	bool need_debounce;
+	struct timer_list debounce_timer;
 };
 
 static struct regmap_config mtk_dp_regmap_config = {
@@ -1698,6 +1700,9 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	if (event < 0)
 		return IRQ_HANDLED;
 
+	if (mtk_dp->need_debounce && mtk_dp->train_info.cable_plugged_in)
+		msleep(100);
+
 	if (mtk_dp->drm_dev) {
 		dev_info(mtk_dp->dev, "drm_helper_hpd_irq_event\n");
 		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
@@ -1776,6 +1781,13 @@ static irqreturn_t mtk_dp_hpd_isr_handler(struct mtk_dp *mtk_dp)
 	}
 	train_info->cable_state_change = true;
 
+	if (train_info->cable_state_change) {
+		if (!train_info->cable_plugged_in) {
+			mod_timer(&mtk_dp->debounce_timer, jiffies + msecs_to_jiffies(100) - 1);
+			mtk_dp->need_debounce = false;
+		}
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -2239,6 +2251,13 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
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
@@ -2319,6 +2338,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	else
 		mtk_dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
+	mtk_dp->need_debounce = true;
+	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -2332,6 +2354,7 @@ static int mtk_dp_remove(struct platform_device *pdev)
 	platform_device_unregister(mtk_dp->phy_dev);
 
 	mtk_dp_video_mute(mtk_dp, true);
+	del_timer_sync(&mtk_dp->debounce_timer);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.34.1

