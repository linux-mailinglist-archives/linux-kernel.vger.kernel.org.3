Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2D4BBB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiBRO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:57:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiBRO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:56:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21C294FDB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e3so15109075wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuTaFtig3SnFf6C4slaInn4xvK8Id+vB8cmRoSwKiFg=;
        b=68FMR/GwLKH+1rzhdAaaORUi8Efwl2E63rdWqTClx3MF5LIQOBP06VQCfGDmM4hVuJ
         uIpYAWoh0jGwC/h7fpyRyEj7ZD2+3J5AcMjpqaKdLXbEpk7YDzgqlZ18w6ipyDuWM+Cb
         5w4aBMEzhyKtHQU5UH94TiUSHpu7Xb12+KjQzkrwDxSgu8fXQqiS4gl4uB1r0DJbz66F
         u3RNVWyF6gEVDZKvUd8Q6w5uGWQQ8TTrzLbfdeN5XxNh4IZ/DEk3niX/FAlGY1HeH7oc
         y5zdaQhk6884w5sTxqJPhWDrcS8NCsgU+vOsPvoVrZiZ0Bw4nrFcsNNgjCZaAAtjSLTl
         qzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuTaFtig3SnFf6C4slaInn4xvK8Id+vB8cmRoSwKiFg=;
        b=lO+wN3WpBjk0U8GJjBP8OUwEWcEM5upTya7esDOr54bAgvYNklPWfPe9s4B/BjQtOg
         aEj4LrEDiR9ohiINckMZt02dZpFgW1p1elT0TfYq0mS8wCsWdwaTQ3qnmJqXKhufaKUK
         7TwB6ljrHa3hXpAoQSz6MWrx3f8zRgOV1e9L6NXKIew1pTJ4UPyOeii2NgRpaWRCnBoE
         UDkzP9KvB56B0f9aA+eNKFN7YBH0JTSzTaDh6RblaBoWPG3eld3ThxxLgxl7xzuuPXlg
         eIekCp3DHovR9nBuW7IITHt3AWUmWj6qKuMe33nkRqEkttmMUERlDdm0y2GJTpfNLZnU
         4SgQ==
X-Gm-Message-State: AOAM530e4qaUATxo3iqSjgRF/Jqky9Y4HGzC3DD31XrPJEVzY9O0mWbD
        mRpbn7e5V3ftUnPCgzX2c+c7Hg==
X-Google-Smtp-Source: ABdhPJxH+Er1c3Cm6J7dlW1f4Qgz72n7Sr/ISnyeoyasJ9oKxmU3w2ECuou3CoUasJq43XiV/koKYQ==
X-Received: by 2002:adf:8170:0:b0:1e0:6087:9d42 with SMTP id 103-20020adf8170000000b001e060879d42mr6297959wrm.217.1645196174524;
        Fri, 18 Feb 2022 06:56:14 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:14 -0800 (PST)
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
Subject: [PATCH v8 08/19] drm/mediatek: dpi: move dimension mask to board config
Date:   Fri, 18 Feb 2022 15:54:26 +0100
Message-Id: <20220218145437.18563-9-granquet@baylibre.com>
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

Add flexibility by moving the dimension mask to the board config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 454f8563efae4..8ca3455ed64ee 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -127,6 +127,8 @@ struct mtk_dpi_conf {
 	u32 num_output_fmts;
 	bool is_ck_de_pol;
 	bool swap_input_support;
+	// Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no shift)
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

