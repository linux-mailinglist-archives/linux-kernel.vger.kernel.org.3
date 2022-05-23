Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D46530EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiEWKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiEWKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:50:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3884C7B0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:50:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h14so20758664wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqXYVhrRj9CHgAnfmavY+OUOGAECWuzwcnTYspWQkrE=;
        b=g/rnOuq2Ks4ma+AdgXNaku8HasO87T86iTPRwuDZffAiRvRN9E4rDlnu5km/QOEpFm
         qmztUmdpfx6YpBrMnDQMYH50vC9CzOA2qWZBXrqLmnZw/OYCMc2HoCQA5QZJgBTbS20v
         unujNoN+7Au/jJ8A49uL1w8fX78FPztttWQObyDlZFDdk9Run4HSzpoefjhG92Zqlwsh
         E9vDx1lbyKrZ2HCvgMT2VKaPbdRD3Anqa5gaZ7knspM8q9LBU/1gmcL4LbFrlZRoNOTr
         +bcNiKzLqpLepsy7SedpuzdpUI2eD18nSQln1JIYNcoljS7sjdg5CZLe6R0VhhFCzg7O
         gNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqXYVhrRj9CHgAnfmavY+OUOGAECWuzwcnTYspWQkrE=;
        b=14PCOzigaHPQ3WnhhSGP+2CkUaOb9sls51pQ9GAU4hAcW3RkKT3IEO3mRlBvsOQM4/
         8zRKMCZgjj0e2UMl2wbaE6zzzVr/a7yQEDG8E15YPWA6itkoN2cpjDU8XtpvNasZHcTh
         kyGbVjfHVFaiwiHI+IWmwCeMIa7II+VNFeIA3SgOqZciKj2NcZhpZvTKttfNgzuNVJIc
         W+c9tYr4hRutK8ML0uVDhsg5qG20eZ8jb0Ib6icdYp5gq0/BgxO3SPigfyD1F9zSwbNA
         DLHbU5TSAkYNST5DWHtsnzk0VlgyczOCU7SZZxDAI1HzzqeSbWdkMeQK6O6LEPzZKt4E
         lrPg==
X-Gm-Message-State: AOAM530cZmNcWrhiHqpsRxpfmjgNPAGsO3sUDNp5Z6f6B8VTiM11vPiv
        UHWP8+SQKoF6+ED0XF+S9XqtLw==
X-Google-Smtp-Source: ABdhPJxBnLXMcYy77fFpeAyi0ruOH6Xn80k3CU5iV4vZcHjxIdmYPEXeJK7hqDTk6+kltw4LwUnbHQ==
X-Received: by 2002:a5d:5910:0:b0:20d:6e9:d4e9 with SMTP id v16-20020a5d5910000000b0020d06e9d4e9mr18395841wrd.69.1653303012296;
        Mon, 23 May 2022 03:50:12 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:50:11 -0700 (PDT)
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
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 01/21] dt-bindings: mediatek,dpi: Add DPINTF compatible
Date:   Mon, 23 May 2022 12:47:34 +0200
Message-Id: <20220523104758.29531-2-granquet@baylibre.com>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

DPINTF is similar to DPI but does not have the exact same feature set
or register layouts.

DPINTF is the sink of the display pipeline that is connected to the
DisplayPort controller and encoder unit. It takes the same clocks as
DPI.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../bindings/display/mediatek/mediatek,dpi.yaml     | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index dd2896a40ff0..6d9f6c11806e 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -4,16 +4,16 @@
 $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: mediatek DPI Controller Device Tree Bindings
+title: mediatek DPI/DPINTF Controller
 
 maintainers:
   - CK Hu <ck.hu@mediatek.com>
   - Jitao shi <jitao.shi@mediatek.com>
 
 description: |
-  The Mediatek DPI function block is a sink of the display subsystem and
-  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
-  output bus.
+  The Mediatek DPI and DPINTF function blocks are a sink of the display
+  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
+  parallel output bus.
 
 properties:
   compatible:
@@ -23,6 +23,7 @@ properties:
       - mediatek,mt8173-dpi
       - mediatek,mt8183-dpi
       - mediatek,mt8192-dpi
+      - mediatek,mt8195-dpintf
 
   reg:
     maxItems: 1
@@ -35,12 +36,14 @@ properties:
       - description: Pixel Clock
       - description: Engine Clock
       - description: DPI PLL
+      - description: Optional CK CG Clock
 
   clock-names:
     items:
       - const: pixel
       - const: engine
       - const: pll
+      - const: ck_cg
 
   pinctrl-0: true
   pinctrl-1: true
@@ -54,7 +57,7 @@ properties:
     $ref: /schemas/graph.yaml#/properties/port
     description:
       Output port node. This port should be connected to the input port of an
-      attached HDMI or LVDS encoder chip.
+      attached HDMI, LVDS or DisplayPort encoder chip.
 
 required:
   - compatible
-- 
2.35.1

