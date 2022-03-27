Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98D4E8A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiC0Wmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiC0Wmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A532EEE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so17875434wrc.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCWNoI6S3UynddM0NjUJNRT0orVS9R9xw/bHT6vllVw=;
        b=kQHdQf4XWT0zrLej+HqLhQnoLSDL4FUXKFFhNAule6XP72vXNG4dkp/EOJGjwaMoiM
         Q86SkKQDDu5NwU4mv3ZPQZEwY5GItaZM9tYCempTbaBAQ5hFfeUfXyzXI206+It7105C
         tMQ0zwgm4r72iFGKg/cO3Ef+/mT6B3JT6aIm2eztCf+hH1EKcF+AbwTH7mUct/3xuFRF
         bOyCIXPSDfRwxcKg7srsWjF31+aQB8JNyoJQLsFJ2D6VPBzloCJDntMff4zwcsiwDcT9
         NyY0T6PL94BHly+F2oZQnQOgi81yUoeVhwfVyWVbo275m/Tf1yuANMoqNnI0TC57Hqar
         Dkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCWNoI6S3UynddM0NjUJNRT0orVS9R9xw/bHT6vllVw=;
        b=Y8URPLHspHmaU2FDw46u9VrEYheYj9BojcIjgevHJGSNeDEbpZAx9MkxrCGP6/sMgs
         GPUYop/1gExFrpQEGZyEV/dDHJPRWjKbHUjICrSC6LUmoiemLYHuuIeLg+DTybIFMu31
         NaFPN+kLWSgIIMH7KDnhBnDge47jcYb7Epe08KbJhHpbhR6YEf11WpDJz7PNj2kdyMQJ
         aJfMJpy7nZB780QAw5+Uq20f7D8XHbJEs187jc5zX/wP55ffcBBE8Say/jKqoJp+Mjwa
         WFZwM19cam2MjxRVhdVrKsGOm7C8EhRK/AK0UccnM0NS3FMl4Tq1uAoAbaIqlUPY8zjB
         FTLQ==
X-Gm-Message-State: AOAM532YzDkMTLOmWZaFYoVF4SoB+ElzaqZWGLSJ9nfPo/qkK5Q51PRi
        zTmFuMRYPUyf9NEPfRqw3bJfXA==
X-Google-Smtp-Source: ABdhPJzQDzvE1ZCewkLdNbBG+s3CDiVlGo2TvrQ4rL7RxUmlq5PJuIMu0oINE6aVjcSTnHJOLFvsMQ==
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id d2-20020a056000186200b00204e4179cf8mr19918655wri.593.1648420858793;
        Sun, 27 Mar 2022 15:40:58 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:40:58 -0700 (PDT)
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
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Date:   Mon, 28 Mar 2022 00:39:06 +0200
Message-Id: <20220327223927.20848-2-granquet@baylibre.com>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

DP_INTF is similar to DPI but does not have the exact same feature set
or register layouts.

DP_INTF is the sink of the display pipeline that is connected to the
DisplayPort controller and encoder unit. It takes the same clocks as
DPI.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index dd2896a40ff0..2dba80ad3b18 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -4,16 +4,16 @@
 $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: mediatek DPI Controller Device Tree Bindings
+title: mediatek DPI/DP_INTF Controller
 
 maintainers:
   - CK Hu <ck.hu@mediatek.com>
   - Jitao shi <jitao.shi@mediatek.com>
 
 description: |
-  The Mediatek DPI function block is a sink of the display subsystem and
-  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
-  output bus.
+  The Mediatek DPI and DP_INTF function blocks are a sink of the display
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
@@ -54,7 +55,7 @@ properties:
     $ref: /schemas/graph.yaml#/properties/port
     description:
       Output port node. This port should be connected to the input port of an
-      attached HDMI or LVDS encoder chip.
+      attached HDMI, LVDS or DisplayPort encoder chip.
 
 required:
   - compatible
-- 
2.34.1

