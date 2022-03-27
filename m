Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B9D4E8ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiC0Wn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiC0WnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:43:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41BF36B4B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so17879202wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cdghCtZILOuy6wyiUAMSm10nHZvUCEwy3CxnJnpQ3E=;
        b=a00oZ0zFt/UkLWjLbBa3/jFbCTFYwg2m9Y3FViz0Wi20dUXxoCDB9YnYyPfCd0MwNp
         gakNUrmY9+qo8B/AYoDZ3Ws+4zQFGZDCDugqpUOF9d80iibYqXPpuptpER2gMjOneA2s
         tGOM5g+3gOheKiGXA1hKtVT1fywSDX0ke7puAkmSD4/kVLbnAMh9m8hYtXG3PT3zHNhQ
         bs9vAKnqDF9CevtIhWXCNwiMCsNlFgbUCey6aCehtCNR1EhzicmE38C8VmVuIxa0vmjV
         G0ms8mP59Tq0tLaNQq7YU/7ICYwtTYczJ7leCPw22dzLxXNfLh/Ugo8NCn4wIwCSJUfV
         OotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cdghCtZILOuy6wyiUAMSm10nHZvUCEwy3CxnJnpQ3E=;
        b=JaYFi6A1woyLIGQwx+vxZHmwqazAr5KwRCXafSQvew74U/84/zF7WdSNuRGm7RgUrq
         s/0PDp4UPm84+Ha/MaBO8ck4umcXBMHPqLTcumidO7uKpGEKqw4i0NvcV6+MPcPmeh86
         POryz5sdvBYQgkzWdJyQl/C/kRPbGrK1mIutvByNY61wlh+VEi/uYqfY2OJFo/DEYI2e
         y7KKg4yJ5drFgDniiQQVKAB6KZnwvGJ4Yiejkt/VJ3FQecs7NBRC8WwGhR3jqyT6Qrq0
         eJ/54loE3bAuy3pDKzUDcYctdqLF95+PS9fKtB/xcI37jp/KUSOPCxaeHQ77RXM7+pE+
         vCig==
X-Gm-Message-State: AOAM532DB4DSN0sJO1KQ0QUNQel0112oGP8yDwJ1rGDNrN9JeWyD180+
        9weYU5hw7NVZnPUu/Pb0WkpNGg==
X-Google-Smtp-Source: ABdhPJx0D/6eRjbTNpgctrBZBOznJL+XQ5R4taW1lDFAJyQP4uqZk0fMKVrOQi3TA5P25fvp/LidkA==
X-Received: by 2002:a05:6000:2ab:b0:204:f77:c1a with SMTP id l11-20020a05600002ab00b002040f770c1amr19889863wry.173.1648420878388;
        Sun, 27 Mar 2022 15:41:18 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:18 -0700 (PDT)
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
Subject: [PATCH v9 12/22] drm/mediatek: dpi: move swap_shift to SoC config
Date:   Mon, 28 Mar 2022 00:39:17 +0200
Message-Id: <20220327223927.20848-13-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
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

Add flexibility by moving the swap shift value to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 6eeda222a973..6d4d8c6ec47d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -131,6 +131,7 @@ struct mtk_dpi_conf {
 	u32 dimension_mask;
 	/* HSIZE and VSIZE mask (no shift) */
 	u32 hvsize_mask;
+	u32 channel_swap_shift;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -349,7 +350,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dpi *dpi,
 		break;
 	}
 
-	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP, CH_SWAP_MASK);
+	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << dpi->conf->channel_swap_shift,
+		     CH_SWAP_MASK);
 }
 
 static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enable)
@@ -821,6 +823,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -835,6 +838,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -848,6 +852,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -861,6 +866,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

