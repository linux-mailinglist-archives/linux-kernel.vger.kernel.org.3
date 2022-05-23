Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749775310B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiEWKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiEWKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:51:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D21DA58
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t13so1581722wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjEEU2tcOn2SYqyaJsPZFLm0mU3b0pMoXygicmkjseI=;
        b=ktTyW4/79xvFoOcPUUH2aQHwWFmEz6Zyl0Us0VagMDHD6R6SCXxTrrluLMeG6ge5f9
         CxTVvDb9sbMdt1rHYN4NQ+mXPS2mMXU4NCJMRboSXIxAHycaz2I7b3UipyDVcOYMiM2/
         x+e27ODovt96LoMRD2zrdpOQoYNcl7a84J1NQjPztUFntCoUszyl0zapZOBbLODZBnhv
         /fDAiWfZei0iWQd1hnu5w7S3GPcWG0db+mkg5ZnXweOIK+tu5qLqeGU2RI8d+NynCKmY
         b8JfwOzr2rGxUFF2zRSPqKsDUA87rYVBURUriNXR+zvw8UQyt+H2FUNj0IMCgDBkADxe
         s6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjEEU2tcOn2SYqyaJsPZFLm0mU3b0pMoXygicmkjseI=;
        b=mIMgmi/QCVkJqA23CR/Qd6F7KVJrxF/lMfEMcd3KLZK5CUh1Wng1kgzjvuabhCvH+A
         pjxFsV+ojAR8VFmAf+IFyLx4PmVjL+KngqrlbFY+S3XBjAPpPYSJEWddEznBcH4EQOSx
         uWxYZ244k55Vaw1YDkx8B9tQx5Fl1OS19XIxdSLPi0vQ5/x4g+H4HqCF64XhoqphuHoX
         BXPhKyJmXw4xdilKszWU8y25pGeew/pWoKdejUxEGwYfFUEZrafO28Bmj2aPkk9H/Uhu
         fgI6YTUNuwX5z541NeVh6l7bOd3D3H5tZgALQZSSgqc+/We591J2fpV4N2p234kuPCqk
         Rnfg==
X-Gm-Message-State: AOAM531CQAzdebkRPRD1CnfaqkR365//7Ad5+lp/Rcok30mdiIXbdkeI
        SEVQSP/pWOJ7tK75Ruafh1C4PQ==
X-Google-Smtp-Source: ABdhPJwBlhpRHoko2XqERgHJP96HrEyOYLOAizuB+tTxI/6ziGJg0XnUwhSNxRFgrYWMju7TsKrLUA==
X-Received: by 2002:a5d:5910:0:b0:20d:6e9:d4e9 with SMTP id v16-20020a5d5910000000b0020d06e9d4e9mr18399125wrd.69.1653303076558;
        Mon, 23 May 2022 03:51:16 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:51:15 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 11/21] drm/mediatek: dpi: move swap_shift to SoC config
Date:   Mon, 23 May 2022 12:47:44 +0200
Message-Id: <20220523104758.29531-12-granquet@baylibre.com>
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

Add flexibility by moving the swap shift value to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.35.1

