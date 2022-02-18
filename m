Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D754BBB79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiBRO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiBRO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:57:24 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D30E0C4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c192so5421255wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7H4qXnTXW08RnaMU6nHzYQDDgNK890kQnNZHO+wv8Is=;
        b=GbL9EOhgOCg+DlOkGcN01lp2uIBQiOJ++mt534W/MQIpzAOw9Dt7JC5h5y3Avtf1gq
         9/OlETR1IwJ3flgAwzPQJmqVpacPVhYuDjniJoQzkv4LU0+cY7lURCGjfnsdMtpbibfr
         0V+HMtN/qfO9VesRTJ9agOihdUpTA84TS/KgFc5uqprMm/WDxzWTiMYVxpXA6dHCaPCk
         EHdeXGC42f5/vWiMPO+hh2+l28UkFjIYUeCrZAYrtdCwoWZfVnnFY3HiNyl/0rxb+fOC
         gr7+2YKVIwShDqOFDQXrav/awPMS8RhM3ob473UmS0DKTYFisimPVaYWKIYRExf5FkbO
         WqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7H4qXnTXW08RnaMU6nHzYQDDgNK890kQnNZHO+wv8Is=;
        b=XomB82jL+zObuq1pD4dzfL9xtADFVATLUhd1UIRuCTI714Ev3W+bA2fJ1wOge9cam7
         Lh3hQItob4v+6vs+gJOig+ZW3aGBrCpNiMW3X8MXaI3Dc6k/k0tuf06oNdYks7CrgEE7
         GnoHPhbfD/ya8UyOsaZ1BR/pYKog05Tqucfbi0vt5Vsa/tYqIK6IqhnlDeMt4yKmlG88
         bj85ntJR6AXKjghYbH1vfHqExJvCqSrJaTmWeK881UUzLdeiVC7exD7UgaanmRSCcyse
         uR5aOPFUp+poEnEpfhuwPaE98ChZhoX0eLmZKZNhhOnMZ6QRKIfxroZcoq3ZiUuGnM+4
         BXQw==
X-Gm-Message-State: AOAM532fDCDSTB8pPDwp1BnAozzs3Vtn4fDvcOhJE6P6B+JMc7ej4YI1
        iWg2ZhoON5c16WsVNPHJr6NONA==
X-Google-Smtp-Source: ABdhPJxPvf8xrJg8I6LH2cnRlqNzZBlpAwtBJFRtBVDCKJxb59B/hVg/UcpgNkvvBHj0WWgcw/8y8w==
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr10699463wmq.130.1645196192675;
        Fri, 18 Feb 2022 06:56:32 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:32 -0800 (PST)
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
Subject: [PATCH v8 16/19] drm/mediatek: Add mt8195 External DisplayPort support
Date:   Fri, 18 Feb 2022 15:54:34 +0100
Message-Id: <20220218145437.18563-17-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218145437.18563-1-granquet@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds External DisplayPort support to the mt8195 eDP driver.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 87 +++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 5b60293ecc0d3..2a3d5f15b651b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -188,6 +188,11 @@ static struct regmap_config mtk_dp_regmap_config = {
 	.name = "mtk-dp-registers",
 };
 
+static bool mtk_dp_is_edp(struct mtk_dp *mtk_dp)
+{
+	return mtk_dp->next_bridge;
+}
+
 static struct mtk_dp *mtk_dp_from_bridge(struct drm_bridge *b)
 {
 	return container_of(b, struct mtk_dp, bridge);
@@ -888,26 +893,49 @@ static int mtk_dp_get_calibration_data(struct mtk_dp *mtk_dp)
 		return PTR_ERR(buf);
 	}
 
-	cal_data->glb_bias_trim =
-		check_cal_data_valid(1, 0x1e, (buf[3] >> 27) & 0x1f, 0xf);
-	cal_data->clktx_impse =
-		check_cal_data_valid(1, 0xe, (buf[0] >> 9) & 0xf, 0x8);
-	cal_data->ln0_tx_impsel_pmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 28) & 0xf, 0x8);
-	cal_data->ln0_tx_impsel_nmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 24) & 0xf, 0x8);
-	cal_data->ln1_tx_impsel_pmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 20) & 0xf, 0x8);
-	cal_data->ln1_tx_impsel_nmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 16) & 0xf, 0x8);
-	cal_data->ln2_tx_impsel_pmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 12) & 0xf, 0x8);
-	cal_data->ln2_tx_impsel_nmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 8) & 0xf, 0x8);
-	cal_data->ln3_tx_impsel_pmos =
-		check_cal_data_valid(1, 0xe, (buf[2] >> 4) & 0xf, 0x8);
-	cal_data->ln3_tx_impsel_nmos =
-		check_cal_data_valid(1, 0xe, buf[2] & 0xf, 0x8);
+	if (mtk_dp_is_edp(mtk_dp)) {
+		cal_data->glb_bias_trim =
+			check_cal_data_valid(1, 0x1e, (buf[3] >> 27) & 0x1f, 0xf);
+		cal_data->clktx_impse =
+			check_cal_data_valid(1, 0xe, (buf[0] >> 9) & 0xf, 0x8);
+		cal_data->ln0_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 28) & 0xf, 0x8);
+		cal_data->ln0_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 24) & 0xf, 0x8);
+		cal_data->ln1_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 20) & 0xf, 0x8);
+		cal_data->ln1_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 16) & 0xf, 0x8);
+		cal_data->ln2_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 12) & 0xf, 0x8);
+		cal_data->ln2_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 8) & 0xf, 0x8);
+		cal_data->ln3_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[2] >> 4) & 0xf, 0x8);
+		cal_data->ln3_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, buf[2] & 0xf, 0x8);
+	} else {
+		cal_data->glb_bias_trim =
+			check_cal_data_valid(1, 0x1e, (buf[0] >> 27) & 0x1f, 0xf);
+		cal_data->clktx_impse =
+			check_cal_data_valid(1, 0xe, (buf[0] >> 13) & 0xf, 0x8);
+		cal_data->ln0_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 28) & 0xf, 0x8);
+		cal_data->ln0_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 24) & 0xf, 0x8);
+		cal_data->ln1_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 20) & 0xf, 0x8);
+		cal_data->ln1_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 16) & 0xf, 0x8);
+		cal_data->ln2_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 12) & 0xf, 0x8);
+		cal_data->ln2_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 8) & 0xf, 0x8);
+		cal_data->ln3_tx_impsel_pmos =
+			check_cal_data_valid(1, 0xe, (buf[1] >> 4) & 0xf, 0x8);
+		cal_data->ln3_tx_impsel_nmos =
+			check_cal_data_valid(1, 0xe, buf[1] & 0xf, 0x8);
+	}
 
 	kfree(buf);
 
@@ -1026,7 +1054,10 @@ static void mtk_dp_video_mute(struct mtk_dp *mtk_dp, bool enable)
 			   VIDEO_MUTE_SEL_DP_ENC0_P0_MASK |
 			   VIDEO_MUTE_SW_DP_ENC0_P0_MASK);
 
-	mtk_dp_sip_atf_call(MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE, enable);
+	if (mtk_dp_is_edp(mtk_dp))
+		mtk_dp_sip_atf_call(MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE, enable);
+	else
+		mtk_dp_sip_atf_call(MTK_DP_SIP_ATF_VIDEO_UNMUTE, enable);
 }
 
 static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
@@ -2228,7 +2259,11 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	}
 
 	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
-	if (IS_ERR(mtk_dp->next_bridge)) {
+	if (IS_ERR(mtk_dp->next_bridge) && PTR_ERR(mtk_dp->next_bridge) == -ENODEV) {
+		dev_info(dev,
+			 "No panel connected in devicetree, continuing as external DP\n");
+		mtk_dp->next_bridge = NULL;
+	} else if (IS_ERR(mtk_dp->next_bridge)) {
 		ret = PTR_ERR(mtk_dp->next_bridge);
 		dev_err_probe(dev, ret, "Failed to get bridge\n");
 		return ret;
@@ -2279,7 +2314,10 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	mtk_dp->bridge.ops =
 		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
-	drm_bridge_add(&mtk_dp->bridge);
+	if (mtk_dp_is_edp(mtk_dp))
+		mtk_dp->bridge.type = DRM_MODE_CONNECTOR_eDP;
+	else
+		mtk_dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -2338,6 +2376,9 @@ static const struct of_device_id mtk_dp_of_match[] = {
 	{
 		.compatible = "mediatek,mt8195-edp-tx",
 	},
+	{
+		.compatible = "mediatek,mt8195-dp-tx",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_dp_of_match);
-- 
2.34.1

