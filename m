Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F434E79D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiCYRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377353AbiCYRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCECE8877
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so11727329wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjQ/r5pco9RwC0sUJWXpp29RkJXQ6qdzLc/z+bngWRI=;
        b=JCQEwvmrbpZpX9TTkHxE1XfIMryiGXzsmmGV4TrzOuO6ttzQ/mxBa1RKj0VLV9x9UY
         4g13irktKfzn6rPan75uwvJ6J8bDM+kY9QRiGd8wjdr2MKe1N1E/RsMr9ow7KUJk98qn
         ZVliZmMXo+/yp3qmfs7zCez21PLXH6qIsfXXBZk/wo28hSX2nfHo6WVEj5AGOmFa7uV8
         57wOQ/7a26LDgckOUFGxL7R5buGa2DHr0We00A4Hh5sG26apUbdinar2B81MPjgMnV0W
         J4QVcdSJFbqo9AhrMpIVXtzKh1lp4zJzAySs1KG0pDx2Kpm6+Rv3gGeoUj3vYLvjCpSk
         lwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjQ/r5pco9RwC0sUJWXpp29RkJXQ6qdzLc/z+bngWRI=;
        b=50yq+k2HjqgmkT/EjWPJOKca0TW6Ob4KQqIc1PKxwIsgyFn2uj/C0Aq8SeNEomVHdi
         4Bs8zgArxznyogsUu0bNkK904diTZZvYlbiRdeBHIFGf3hZ9Qax+6nqAYtPn+nIODQwv
         j22tAeij1VvCtH3WZnXYKQbsRa963A6DsE71/Sh9uDjua8/l/YER2te9Y4wTRQww8zao
         ibNvl7YR/AiQqFQqKb8z7okto7b0+Z6OrDf6eEiDd0iaGrQsiLSN0X7VhUhgo21/Jnxq
         um9WWXnqPDmTHK7d2yIYFzGyVA+5hQHkkbLjpVpViYZBR1sdHYw3yUex8jhIj1Q67+PY
         g3HQ==
X-Gm-Message-State: AOAM53164/YBBwUMlG6wMLneDgnNKlLtvM1nwICTfpIv34dxRYby7lVz
        NUbi9BifyrGaL8XYL6hP/IdzdA==
X-Google-Smtp-Source: ABdhPJyrSxcXKaAP25ZBJ7/tCD9C7PS/Qy2PJKAsjuVE99MIZGYJl8Bk5UUwKOQluWdrhnCKdKIRIQ==
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id v7-20020adfebc7000000b001ee945affb4mr10145745wrn.641.1648228604779;
        Fri, 25 Mar 2022 10:16:44 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:44 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Date:   Fri, 25 Mar 2022 18:14:50 +0100
Message-Id: <20220325171511.23493-2-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
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
index dd2896a40ff0..53acf9a84f7f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -4,16 +4,16 @@
 $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: mediatek DPI Controller Device Tree Bindings
+title: mediatek DPI/DP_INTF Controller Device Tree Bindings
 
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

