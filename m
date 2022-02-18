Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924314BBB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiBRO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:56:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiBRO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:56:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F2D580DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u1so15005411wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rl9GJMwANTs4ZJlwlTLAUM9iGOwBbNwdWImM77zNitM=;
        b=Hq1ej1mQ2MMxf1bH4FLzvR7tpbxNj+Ol/3YFedobT9BlNZW3XGnLfALtYMiNcrFzvx
         6wfzxXM7ZKIwy8BWbif2XP0qliiTiU2SwVHwOoJ0MqJE6DuHFSclcfH5h4QjN8UtDm8T
         IIaoAVlt8blotwG4zd4GBZQgaMwNFiq47JQGj0VDHJmeFcNcGBTyYfvmV4e0IQKILwBT
         YihSV6M8YUNaWuEcTz5iv2sOHevL3jcuTZNiVFYuLPZHhY6LtP5DRie4iwTinXqSZKgv
         Mnorce5EopmKWsKgTqFd7XpUdJOS75xN0MyOPsv4qcw3iMagdkdhheMdVHy6NhAu549X
         1/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rl9GJMwANTs4ZJlwlTLAUM9iGOwBbNwdWImM77zNitM=;
        b=CVCQpjnvk/ci5Omky+U+XmCNDOkRpjn3PnV/XKfyqUiZbz6fkyhYMAXcUHf+NFdsI8
         o0+Iewt0lpshB86L8KbnjqD+Ciq+rsLTs9JRNrmCoYfVTqgaz8HGZhPkAtI6NVIz87iq
         zqXxwsWOG7aoRzqJRAiShGtZPFwnQUdhXpX550TmexOxwKOJCeT9dsrwh8YZoLQKtqOD
         kX0E+QQh0RrnSMt5Gp99D66at4tppSvCFx4QzqTyGHGub7Pau1KWGtrhzwUU3giEE/rm
         VXuP423Cmmb7FOB1cqiigOHESSgAVpwBbEfNxRQIaBi0zFr33py+PkuM5USW3MMzNRTi
         8kJA==
X-Gm-Message-State: AOAM5308vrkUQYGp1d/zAsceyMiUYOsG+S5bV4dAIWv5KeJU8iXm2b0i
        v+0BlfM7/+TQgUnpXrIqErbj5A==
X-Google-Smtp-Source: ABdhPJzLbEEfYgSHqBNDUq8sOQOCufmyh+U/0S0P0s5vcWkm4sqUVe7KIKtrF43MUbMyX5wJmXLcDQ==
X-Received: by 2002:adf:ec07:0:b0:1e3:1ef2:5ff6 with SMTP id x7-20020adfec07000000b001e31ef25ff6mr6336681wrn.255.1645196168227;
        Fri, 18 Feb 2022 06:56:08 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:07 -0800 (PST)
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
Subject: [PATCH v8 05/19] drm/mediatek: dpi: move dpi limits to board config
Date:   Fri, 18 Feb 2022 15:54:23 +0100
Message-Id: <20220218145437.18563-6-granquet@baylibre.com>
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

Add flexibility by moving the dpi limits to the board config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 4554e2de14309..4746eb3425674 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -125,6 +125,7 @@ struct mtk_dpi_conf {
 	bool edge_sel_en;
 	const u32 *output_fmts;
 	u32 num_output_fmts;
+	const struct mtk_dpi_yc_limit *limit;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -235,9 +236,10 @@ static void mtk_dpi_config_fb_size(struct mtk_dpi *dpi, u32 width, u32 height)
 	mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
 }
 
-static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi,
-					 struct mtk_dpi_yc_limit *limit)
+static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
 {
+	const struct mtk_dpi_yc_limit *limit = dpi->conf->limit;
+
 	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
 		     Y_LIMINT_BOT_MASK);
 	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
@@ -449,7 +451,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 				    struct drm_display_mode *mode)
 {
-	struct mtk_dpi_yc_limit limit;
 	struct mtk_dpi_polarities dpi_pol;
 	struct mtk_dpi_sync_param hsync;
 	struct mtk_dpi_sync_param vsync_lodd = { 0 };
@@ -484,11 +485,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
 		pll_rate, vm.pixelclock);
 
-	limit.c_bottom = 0x0010;
-	limit.c_top = 0x0FE0;
-	limit.y_bottom = 0x0010;
-	limit.y_top = 0x0FE0;
-
 	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
 	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
 	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
@@ -536,7 +532,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	else
 		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
 
-	mtk_dpi_config_channel_limit(dpi, &limit);
+	mtk_dpi_config_channel_limit(dpi);
 	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
 	mtk_dpi_config_channel_swap(dpi, dpi->channel_swap);
 	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
@@ -790,12 +786,20 @@ static const u32 mt8183_output_fmts[] = {
 	MEDIA_BUS_FMT_RGB888_2X12_BE,
 };
 
+static const struct mtk_dpi_yc_limit mtk_dpi_limit = {
+	.c_bottom = 0x0010,
+	.c_top = 0x0FE0,
+	.y_bottom = 0x0010,
+	.y_top = 0x0FE0,
+};
+
 static const struct mtk_dpi_conf mt8173_conf = {
 	.cal_factor = mt8173_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 	.max_clock_khz = 300000,
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.limit = &mtk_dpi_limit,
 };
 
 static const struct mtk_dpi_conf mt2701_conf = {
@@ -805,6 +809,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.max_clock_khz = 150000,
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.limit = &mtk_dpi_limit,
 };
 
 static const struct mtk_dpi_conf mt8183_conf = {
@@ -813,6 +818,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.max_clock_khz = 100000,
 	.output_fmts = mt8183_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
+	.limit = &mtk_dpi_limit,
 };
 
 static const struct mtk_dpi_conf mt8192_conf = {
@@ -821,6 +827,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.max_clock_khz = 150000,
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.limit = &mtk_dpi_limit,
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
-- 
2.34.1

