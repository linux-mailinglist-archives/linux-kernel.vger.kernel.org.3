Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283DB531017
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiEWKv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiEWKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:51:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3652912A87
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u27so19931628wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkts/Sde7nd98mjIi3GzZQjBJaHLHDi+m6EizH3TGsU=;
        b=Y+0CSVrVS9WyATu6S94zU3DJBrKkpYqrPk4RjAlg+rGcjnyUqrCJg+azA8JDCMwU0r
         ctrd6MkYGDUg+6pbznzAvb0PgsPTdD+/lOzCOl9XAb544vL4VO8YZhTGixUYTWw1u2oW
         Nzybx0A4TrE2m+pvcTZucGhaxExy8IKjASDaO15+2xgMlBFvrde0q+y8jLa9tj3V31Me
         DS6uJFgXHK+gd0s7sGhST20vJimYNdXe53w79y8/56FfATf6WruA1Hc9fiaMuG5bi5ZA
         ZsHw2ZGxUS7e35uN/EXRBG8LSKrLjtVVNSYRu/17aMNx80FNvXLXTJ6YMg1EKrY1F6GI
         CM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkts/Sde7nd98mjIi3GzZQjBJaHLHDi+m6EizH3TGsU=;
        b=Uqpg1R1DsZRUpeVy9OhrG7ZHNZ7dgdLn3q/wrMnhsFPrrDvhv2j5+WTHVSePe5WClJ
         MBkfVY+S3We/1DobCqvMGgh4XcuKNZRiOEjpaTixsIcDBATmTiGK+RSZqVTsA4MYlEUh
         5SuYyLa/EWpPW3l+R7+LzKBEc5vosk+xCqNofGTk3GxMC/8l1ERqK5RzuwVCZA0+AQD8
         r1DcKct7Ivak8U25rQaJPyDSbjV12JJDdjEjDSdDVg3ctCFFBvzBe/mWSojXAjZ9hXXE
         0zIzDRCzqtjVcqLbK4ASFeHXYM0uK8iQ0JT8I+jYTC8wtxoyr6Dz+7MKSuWsFvpoW53K
         EO5g==
X-Gm-Message-State: AOAM533gOid6UJW9G/4EfvuQh2TU9BVwOsdoQHb6VX+ybm4Dqe5TIRT4
        q0SCgCjDCVGMHXSITgCVD4c5ow==
X-Google-Smtp-Source: ABdhPJw++Udgn1IeBKegHsQgscxxX+V01340gZv0n6oYlTpZVbPptZM9/TVKjK2WhSSYg5Z+1aCntg==
X-Received: by 2002:a5d:6446:0:b0:20e:667b:a9dd with SMTP id d6-20020a5d6446000000b0020e667ba9ddmr18387744wrw.345.1653303069745;
        Mon, 23 May 2022 03:51:09 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:51:09 -0700 (PDT)
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
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 10/21] drm/mediatek: dpi: move hvsize_mask to SoC config
Date:   Mon, 23 May 2022 12:47:43 +0200
Message-Id: <20220523104758.29531-11-granquet@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523104758.29531-1-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
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

Add flexibility by moving the hvsize mask to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bf098f36a466..6eeda222a973 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -129,6 +129,8 @@ struct mtk_dpi_conf {
 	bool swap_input_support;
 	/* Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no shift) */
 	u32 dimension_mask;
+	/* HSIZE and VSIZE mask (no shift) */
+	u32 hvsize_mask;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -243,8 +245,10 @@ static void mtk_dpi_config_interface(struct mtk_dpi *dpi, bool inter)
 
 static void mtk_dpi_config_fb_size(struct mtk_dpi *dpi, u32 width, u32 height)
 {
-	mtk_dpi_mask(dpi, DPI_SIZE, width << HSIZE, HSIZE_MASK);
-	mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
+	mtk_dpi_mask(dpi, DPI_SIZE, width << HSIZE,
+		     dpi->conf->hvsize_mask << HSIZE);
+	mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE,
+		     dpi->conf->hvsize_mask << VSIZE);
 }
 
 static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
@@ -816,6 +820,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -829,6 +834,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -841,6 +847,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -853,6 +860,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.is_ck_de_pol = true,
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.35.1

