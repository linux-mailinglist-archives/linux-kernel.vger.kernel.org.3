Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C2530FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiEWKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiEWKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:51:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B82B1B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so20791811wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGvhVV4JqPNXk+p5F/0CMZDfiaz8h8RwYuVglR+Hdfg=;
        b=SSKJwV3dhXlND8s9/ZiSdxc7iQkclv7sEeQvp7zakKPDyj/A5NxLyj/8NxDKainYsZ
         66XRu7ieISGUu3vhVKtVxx2psktGaF7/gSBqnOdTK2U8Jil0Jl/KKe4qfsA4kW4tZF1m
         r5otL/wEBNRALQlcdG0qNzyuVqJK0l2zU8WbjDqxutAObwUA7Qn3DryKlBsEox8FuH5X
         t8kqrsI2tDL7+xTsF+ifFgq/UkscxL6yNBR/R/h7PdHdKrZk9p0geJs2s76EVFYKRTxt
         ISr80sfHjfhqug2M/MI+VRXzC2M9PBoiVntGVHxAhJXAcDUgzs0+Rh9ku8IA7bpwU3lP
         WbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGvhVV4JqPNXk+p5F/0CMZDfiaz8h8RwYuVglR+Hdfg=;
        b=6oeauHw7V9BlNGvskQARt+KQYIp2NQc3z9QsVBoOkzmXKDsZpGfuyVrtFEmDjBOmGu
         s+fy20aYBmJQ4MVMMdfqMb+DGzVmbLYqZNM3aZYuK4/KFZ6iLG7WMkHcDWC7Y+1UCBY2
         3ZKjXpBetcowqJuf2uVkNsD8SEb8J1ez1bWZ317eqtpZDffq2UBkGxg+9NU5wEpekZoi
         T0HIqZ1AbMi+MIIeG5xOIKV7K9ypj6a2wrpiaJVEf0YhUQBWWxA175W1zJgyszpRvNYc
         tuGvKkY0SP5li2z8dyiiqEvEtW9Ai6epu9YDfgnunn2DcH/25561prcCfvJLrk4boZKp
         lnag==
X-Gm-Message-State: AOAM531RiA6iFfyoccwQh+ewOyFQSJEaPvVOX1liGYyidbfCle3ehlzV
        9DL72+WU/w2pPAYZAJ90jTIkqw==
X-Google-Smtp-Source: ABdhPJzI1cZH2vxHZeGJbkrpsiAZ+QGY1J5LlXZuKh30WZu+XMTP0w16zzNcwHcU73Y9iru6sVfBIw==
X-Received: by 2002:a5d:674b:0:b0:20e:6164:d86f with SMTP id l11-20020a5d674b000000b0020e6164d86fmr18179608wrw.297.1653303089880;
        Mon, 23 May 2022 03:51:29 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:51:29 -0700 (PDT)
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
Subject: [PATCH v10 13/21] drm/mediatek: dpi: move the csc_enable bit to SoC config
Date:   Mon, 23 May 2022 12:47:46 +0200
Message-Id: <20220523104758.29531-14-granquet@baylibre.com>
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

Add flexibility by moving the csc_enable bit to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 40254cd9d168..eb969c5c5c2e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -133,6 +133,7 @@ struct mtk_dpi_conf {
 	u32 hvsize_mask;
 	u32 channel_swap_shift;
 	u32 yuv422_en_bit;
+	u32 csc_enable_bit;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -363,7 +364,8 @@ static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_csc_enable(struct mtk_dpi *dpi, bool enable)
 {
-	mtk_dpi_mask(dpi, DPI_CON, enable ? CSC_ENABLE : 0, CSC_ENABLE);
+	mtk_dpi_mask(dpi, DPI_CON, enable ? dpi->conf->csc_enable_bit : 0,
+		     dpi->conf->csc_enable_bit);
 }
 
 static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
@@ -827,6 +829,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -843,6 +846,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -858,6 +862,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -873,6 +878,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.35.1

