Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8234C3C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiBYD2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYD2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:28:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C740E7D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:28:00 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id p8so3579176pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZMKM13WOXr0Cj+JFI693E2RT8tiGsgNHY8tIWC/7wA=;
        b=NlEBER48+BAv+pYpPTx0rfeKZ1GwncJgF+xLdGTwRe3mDhFs5KsTN6WYQcXYUt6VPG
         wuhKmKVgs7OG3yHA6LjqWJRNXaplIMBeQWsy/oPEeF4+zBTqs9sltsPPY9QPCKZOXXON
         661cGzrUtj/uEV0VytoAeEu/9v/3lQcw4b/jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZMKM13WOXr0Cj+JFI693E2RT8tiGsgNHY8tIWC/7wA=;
        b=KGlgPWx0BpPiHKUL9bZ2mA43QngJKxduATmtDaHsAfO/WBc5cMKh3J2UsJMegfb9mj
         wLrSDo5DU8NtapAe3nNU4JlYbgRT3PUDNa7UN3hXH32SU80eXdFpfqQSbPCwgUfWdt2G
         enDPVESPT1FwL7IzeW/WA1yoDoFJDTMJzr6quucjYgD5X/RyYFcuKpDs02hm8w4OyKUS
         //Yt1MOywu42luSS12GdaQYGYTnpgH/Y7rQfcCJm9UTZfoPZNgko7wNkSwGKjZWQyIrO
         eVA/GFYNJK3hBvpabitHYyupIzl63leLYpuoXus1FGJQZp/KgRcJHeBW/EsRQ+/drkmZ
         YjXg==
X-Gm-Message-State: AOAM530V3dwXWOf1Dn3Fc27y5mGOpRgeCIQgmdqjjOenMp7k9qYORrlq
        nhoyqKlR3x/+cgwV+tGvB7ZFLg==
X-Google-Smtp-Source: ABdhPJx+kHFiPrkhdZm5XLElk/g3benE49UUovXBtXArAuVbE2sKuAaWSgZHosRUd7JHRRrHV4UmWw==
X-Received: by 2002:a65:6c0d:0:b0:364:ae2e:9708 with SMTP id y13-20020a656c0d000000b00364ae2e9708mr4611904pgu.189.1645759679598;
        Thu, 24 Feb 2022 19:27:59 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d786:892f:a6fa:6f0c])
        by smtp.gmail.com with ESMTPSA id q5-20020a056a00150500b004be09fd6ad6sm905097pfu.191.2022.02.24.19.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 19:27:59 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Fix DPI component detection for MT8192
Date:   Fri, 25 Feb 2022 11:27:54 +0800
Message-Id: <20220225032754.140168-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When support for MT8192 was added, the DPI device was not added to the
list of components to look for. This causes the secondary display
pipeline to not be able to fully bind, and the DRM driver subsequently
defers probing.

Add the DPI device compatible to list of DPI components to fix this.

Fixes: 01365f549c88 ("drm/mediatek: Add support for Mediatek SoC MT8192")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b147797177c6..47ba18cbc5c8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -511,6 +511,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8183-dpi",
 	  .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt8192-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
-- 
2.35.1.574.g5d30c73bfb-goog

