Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67244BBB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiBRO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:57:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiBRO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:56:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246A5A5AF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c192so5420832wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsBWqhdlaWb1gMEMCTy+xVO70hKJt7Vn6RQJImIvis0=;
        b=7+JO8GgDz4eLqZqGL8gwXCKx3NMB4p8Wwn1xYLk69tPcCPx4ZZCHeT2egR0aCOFzB3
         5plooVjc/uxWNVgjnYd/iz55rnCbwVFW1oZzJqY9FMA/kZ2lMHqhv+nw4/fzrbSl888o
         +pJ+UmsFn7LNXUxlgJV3l21O6IRlAn5q034XeSze0dJXlywxtBuTY9GbCbDmIt8Gp7hG
         yDfy8Vf247TlM2ydggvBl1+jh9aKkMNTxJZeAHaGCaEUm8bcM1VqDkMtn4rwTPSeG81O
         B9zdgBvg9OXJjnqT70Mq1uscokETupfm+oflpZzO0oC/Mh4DqnYIEcgw1XaTuDF52lj7
         s7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsBWqhdlaWb1gMEMCTy+xVO70hKJt7Vn6RQJImIvis0=;
        b=g27C4KAGfOzPS25mFI1kQMbWZUi+vyzqQ6LPfu6JDHvRn55soCV3U46e879wxGXtj1
         w5GzOSwKrR9poVz5oU59QTlU8q+qlms5Tl/472Uu8XDW2Dta1x0gLggCIiJl+bLvY9Zg
         vNxIQIG9iTV7iJUO8BTrEJAgEOcEibBQzV2CmXwmqz2CydpOdfJ0tjTXGu5wegxppgLm
         lSygl5NKSo+0nofDtYa//6al9WE49rXOqx68jrTYa6t2EcX01FGgYeI08LqYUROMtEAf
         u65oVbuPgXD55ojrG/N9pJ30joXpmSZDnn88ayZvkvvp5+TKZlpbAOScKFLPOPuku5XG
         N36A==
X-Gm-Message-State: AOAM532tHyBgKz8PPs/5vct3ikLvcevHn9bV2FdLKg8JcoQZeASx/UnK
        rcd/b35/XPTAXgdkhn7GlmHwbw==
X-Google-Smtp-Source: ABdhPJyFvD28f6eULBjPuAD0GLrHqccrZfmLJsTsBWJtRo1FCRC+AL4xjZn1NWK7NCcpJLwQblQYQQ==
X-Received: by 2002:a05:600c:2d41:b0:354:24d2:8e13 with SMTP id a1-20020a05600c2d4100b0035424d28e13mr11133608wmg.138.1645196178651;
        Fri, 18 Feb 2022 06:56:18 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:18 -0800 (PST)
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
Subject: [PATCH v8 10/19] drm/mediatek: dpi: move swap_shift to board config
Date:   Fri, 18 Feb 2022 15:54:28 +0100
Message-Id: <20220218145437.18563-11-granquet@baylibre.com>
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

Add flexibility by moving the swap shift value to board config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 0d3acd08ea358..ec221e24e0fee 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -131,6 +131,7 @@ struct mtk_dpi_conf {
 	u32 dimension_mask;
 	// Mask used for HSIZE and VSIZE (no shift)
 	u32 hvsize_mask;
+	u32 channel_swap_shift;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -349,7 +350,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dpi *dpi,
 		break;
 	}
 
-	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP, CH_SWAP_MASK);
+	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP,
+		     CH_SWAP_MASK << dpi->conf->channel_swap_shift);
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

