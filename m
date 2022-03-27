Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102044E8AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiC0WnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiC0WnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:43:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1844F442
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r204-20020a1c44d5000000b0038ccb70e239so2571666wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XC6XswkJj9AaYIVp5h6fpj+i9TeNQ29eMbDaNcuaTD0=;
        b=gpx7DXyvMS5a9EuMo3979p8BL242XxGFd/Jbxb6UZWJUuu5/yrdhc7cqFHJX3VBrWV
         9Wv57i55/WqeSGz2+jUfLF4U6p/d6e7kwMvN7fq+Q0VLIVvG177IWM72VXIRpQ3rUxGz
         8Ju16is/FCkoarMtGzdxW97JEBBo0wbX6zaorqAPEc8yiqXrplj5LPoTDKtFoH/4/hrE
         6iQLayY59U8tOymX+NGMMajUq5Ir/+Moky7f9MmFYcbGUhKKNWSv2SUx9LoxogYtIrV/
         ajHoYH+RpLI+wXiEDo9fFmw7QCU6huRhWc8bVdas/6rdBzTtmLBg2l8OPUduyBTJCQyc
         jg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XC6XswkJj9AaYIVp5h6fpj+i9TeNQ29eMbDaNcuaTD0=;
        b=WNmQCLz1ojB6lZ/tqgwuvBgO8/M+fGxLPgJ9deUqaEJ1KcYVULNo7ChbF8z6tF6kl9
         1ELnVvabvsIAquS3nw+dDQGOWOE6zCLyioB16PTb/Vy7r6OFvcyvs2nAKzMgvdGhVeDo
         qcdNylFrL3leVuqF+kwGszB9rGSTp9N5sZfCJ1yYOjtKUr3RBNQsZt8f/bM4Mr72gAXZ
         +n9613QIaKki1ypuKkF1CT6IUUER7PiWlO71I0K0sMdJ6flLbJZQTWhALNiHSSl9er/E
         J/bBoO/Djn5mI5t6yDt+uCdRFpgWZkeduEu7NBGCcobIod0X1nwykWb6BDj2dp07X/jW
         d1sA==
X-Gm-Message-State: AOAM530PtNibmd80rRTwZx9LF3u7zjPORuzxmhLJQ8x5GDE3fFIz4zBI
        LNyXi5n39cMIGS7FoaygOcd82Q==
X-Google-Smtp-Source: ABdhPJwEe1v2JbBYTHnfiXw0K97yw2rhxs5cAcCUspAoi18e3S0BP2YTH5oTq716yBth0/2APkGuGw==
X-Received: by 2002:a05:600c:500a:b0:38c:991b:a4b with SMTP id n10-20020a05600c500a00b0038c991b0a4bmr31403591wmr.50.1648420874862;
        Sun, 27 Mar 2022 15:41:14 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:14 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: [PATCH v9 10/22] drm/mediatek: dpi: move dimension mask to SoC config
Date:   Mon, 28 Mar 2022 00:39:15 +0200
Message-Id: <20220327223927.20848-11-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
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

Add flexibility by moving the dimension mask to the SoC config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 454f8563efae..bf098f36a466 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -127,6 +127,8 @@ struct mtk_dpi_conf {
 	u32 num_output_fmts;
 	bool is_ck_de_pol;
 	bool swap_input_support;
+	/* Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no shift) */
+	u32 dimension_mask;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -156,30 +158,30 @@ static void mtk_dpi_disable(struct mtk_dpi *dpi)
 static void mtk_dpi_config_hsync(struct mtk_dpi *dpi,
 				 struct mtk_dpi_sync_param *sync)
 {
-	mtk_dpi_mask(dpi, DPI_TGEN_HWIDTH,
-		     sync->sync_width << HPW, HPW_MASK);
-	mtk_dpi_mask(dpi, DPI_TGEN_HPORCH,
-		     sync->back_porch << HBP, HBP_MASK);
+	mtk_dpi_mask(dpi, DPI_TGEN_HWIDTH, sync->sync_width << HPW,
+		     dpi->conf->dimension_mask << HPW);
+	mtk_dpi_mask(dpi, DPI_TGEN_HPORCH, sync->back_porch << HBP,
+		     dpi->conf->dimension_mask << HBP);
 	mtk_dpi_mask(dpi, DPI_TGEN_HPORCH, sync->front_porch << HFP,
-		     HFP_MASK);
+		     dpi->conf->dimension_mask << HFP);
 }
 
 static void mtk_dpi_config_vsync(struct mtk_dpi *dpi,
 				 struct mtk_dpi_sync_param *sync,
 				 u32 width_addr, u32 porch_addr)
 {
-	mtk_dpi_mask(dpi, width_addr,
-		     sync->sync_width << VSYNC_WIDTH_SHIFT,
-		     VSYNC_WIDTH_MASK);
 	mtk_dpi_mask(dpi, width_addr,
 		     sync->shift_half_line << VSYNC_HALF_LINE_SHIFT,
 		     VSYNC_HALF_LINE_MASK);
+	mtk_dpi_mask(dpi, width_addr,
+		     sync->sync_width << VSYNC_WIDTH_SHIFT,
+		     dpi->conf->dimension_mask << VSYNC_WIDTH_SHIFT);
 	mtk_dpi_mask(dpi, porch_addr,
 		     sync->back_porch << VSYNC_BACK_PORCH_SHIFT,
-		     VSYNC_BACK_PORCH_MASK);
+		     dpi->conf->dimension_mask << VSYNC_BACK_PORCH_SHIFT);
 	mtk_dpi_mask(dpi, porch_addr,
 		     sync->front_porch << VSYNC_FRONT_PORCH_SHIFT,
-		     VSYNC_FRONT_PORCH_MASK);
+		     dpi->conf->dimension_mask << VSYNC_FRONT_PORCH_SHIFT);
 }
 
 static void mtk_dpi_config_vsync_lodd(struct mtk_dpi *dpi,
@@ -813,6 +815,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
+	.dimension_mask = HPW_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -825,6 +828,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
+	.dimension_mask = HPW_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -836,6 +840,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
+	.dimension_mask = HPW_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -847,6 +852,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
+	.dimension_mask = HPW_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

