Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27BD530FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiEWKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiEWKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:51:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8A2CCB0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so9131612wrc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zP6HMIa2YPzZ4Ud3UnVV9v/2WWghDZEujrnaWZbPns=;
        b=CVxXAcJ7h3wlqtwZU9H9KpppU+0u/RTKAuP4gBIGTnyBTrBe1J9DA3/oPGdgksz0xy
         GLUAXoK2K5PD5Qa5uoLYqngMrUqTrBQJ22WiVornX3mY7lg3WgNkr4opKRljcDGJ+/bZ
         bW3RuhkiUKraQUELKEkJxDdqc9nVn+Cdrp9idbZpPPJXCWSoi+iPXeHO6GRdDakV8A0+
         KEZmDMyXYpfBriNae5MHHjylHFP8Q/FOiVWpPyPtKhse51L0ASaj2EH1H/nCY3QgBzmZ
         PDdfqUyUduPQmp+OuR3gzYBUFeiFmKAZZCk6UmkCYrXc5uFd1B9NK+3wO+q7fCqOFV0R
         g8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zP6HMIa2YPzZ4Ud3UnVV9v/2WWghDZEujrnaWZbPns=;
        b=RjoQ6RaLvPbWOW/f/frIM9WCjbAEzkNEyRi4f03sqpxzkjonQ7ICN6o7waDn29VSdr
         187u4B+oHB5GFJrS3K4+YCzBbtMq2FWy5Kinvy0EFB+wHxWUQ+2Ei4sWX+bQSY5kMkL8
         LdZe4qJ/g3w6nT2+JoCAzLzDvfBJm1SSbh59enfbGUQvDxAaUwSEN2Mn1Ydg6PakvZMm
         Byvy8hAvDIPSLSaHf5wvcCRVFsZmGlHIPZNpRN19wE4nIEl55PxCIJFQi3BpTz4PYclq
         TzuW6A3qwJTCI5YHXXw6+BxfWbJy9l39njJPB7wKFYSBuYwQaBs8GOgaIAOVlm+YlHj8
         xDMg==
X-Gm-Message-State: AOAM530jzzqXS/ZZJ/A7jGZwgIl9arClt0Y+ecsHHUivJbSkoJ3bEMjT
        Zx9ONP0rmgRcMDlnVCD2W+xSxg==
X-Google-Smtp-Source: ABdhPJyQ9VeNqhjj7qlI7JhdS3acBdep+9UKDmpO3Y91brQHC2cBHqOMlHX3SGs3/FwHb18YDgbYJA==
X-Received: by 2002:a5d:6484:0:b0:20f:cc0b:e3f1 with SMTP id o4-20020a5d6484000000b0020fcc0be3f1mr8011615wri.237.1653303109362;
        Mon, 23 May 2022 03:51:49 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:51:48 -0700 (PDT)
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
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 16/21] drm/meditek: dpi: Add matrix_sel helper
Date:   Mon, 23 May 2022 12:47:49 +0200
Message-Id: <20220523104758.29531-17-granquet@baylibre.com>
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

Add a mtk_dpi_matrix_sel() helper to update the DPI_MATRIX_SET
register depending on the color format.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 21 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index a6b6d62a17e7..5b88a7ed5845 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -386,6 +386,25 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
 		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
+static void mtk_dpi_matrix_sel(struct mtk_dpi *dpi, enum mtk_dpi_out_color_format format)
+{
+	u32 matrix_sel = 0;
+
+	switch (format) {
+	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
+	case MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL:
+	case MTK_DPI_COLOR_FORMAT_YCBCR_444:
+	case MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL:
+	case MTK_DPI_COLOR_FORMAT_XV_YCC:
+		if (dpi->mode.hdisplay <= 720)
+			matrix_sel = 0x2;
+		break;
+	default:
+		break;
+	}
+	mtk_dpi_mask(dpi, DPI_MATRIX_SET, matrix_sel, INT_MATRIX_SEL_MASK);
+}
+
 static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 					enum mtk_dpi_out_color_format format)
 {
@@ -393,6 +412,7 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, false);
 		mtk_dpi_config_csc_enable(dpi, true);
+		mtk_dpi_matrix_sel(dpi, format);
 		if (dpi->conf->swap_input_support)
 			mtk_dpi_config_swap_input(dpi, false);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_BGR);
@@ -400,6 +420,7 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, true);
 		mtk_dpi_config_csc_enable(dpi, true);
+		mtk_dpi_matrix_sel(dpi, format);
 		if (dpi->conf->swap_input_support)
 			mtk_dpi_config_swap_input(dpi, true);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index dd47dd3f2e4f..91b32dfffced 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -231,6 +231,9 @@
 #define EDGE_SEL_EN			BIT(5)
 #define H_FRE_2N			BIT(25)
 
+#define DPI_MATRIX_SET	0xB4
+#define INT_MATRIX_SEL			BIT(0)
+#define INT_MATRIX_SEL_MASK		(0x1F << 0)
 #define RGB_TO_JPEG			0x00
 #define RGB_TO_FULL709			0x01
 #define RGB_TO_BT601			0x02
-- 
2.35.1

