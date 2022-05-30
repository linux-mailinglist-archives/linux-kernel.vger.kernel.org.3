Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D2D538819
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbiE3UPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiE3UPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:15:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56768980
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k16so11675967wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1KekYBsM60PWOUWQkx+YAzcNsdLIbx5495ax2Uk44I=;
        b=CqyGXFlBzgROVHYp7ecYqfw78XKSS+1L6CsO2OmUQm1gW9QrLMVzAign7WkMfXoBme
         A8lr2oORL6b6NHYKjjkGlHMWy7WFnjRrmqtAWvs/Q9zTHfZTXuiqF3FDL3d9wiX/in6V
         1y+cx25AaHHtQ/O9bqYMNx4kDPTzWFDu+rFFWtZ+VbALHzs8N3WQ9XJKKYwr7qvthQfp
         skZkKYkVdVHMoEGPFjwk/62HwsA0GrOQw6QBBXa3+BnVTT+YrZOyX75AW/4ZXbrAZ+Px
         05flweFs9wJmVhJcMbp4jwVZB++k4TYn8pbr+gMqfBnuWNl1Ka8iCQB8UiZ18JHZw7Q2
         r9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1KekYBsM60PWOUWQkx+YAzcNsdLIbx5495ax2Uk44I=;
        b=Okpmch8PCgOjgB8aYpnCZcGmIwgR1a0Ol23DGGuittj40D1ulYGkQKRD+oQ+RFvR/g
         i1BDnwkewSJ6IKmUWYNzbhB7ciKHiRUPFfoKOo5zn3NKBoh4I3Akh2xp9TSARaLrTvnx
         1CK72f1yZ53W6MocXxfMg+E197UeOGwclpd9NvnqO2n/QzQ/eExQ0JnVTHcFXtqHEWnO
         MGjFlDwxyNOfRVTkTdXndvFpl0NXi5StMjLIzMUoKbn2JHmTOCDt6W+oB1w3yTgdpJ4P
         /VH+F5woI+NhFJdF2yVTFwk91MLKagoIqIq7zh80iVDTTlzepBFOS9g4n3KoEDclpQzr
         6SWQ==
X-Gm-Message-State: AOAM533Y9XcIE9fAgkjnqQG2cxdXU8Rk0fe1Ji3I7SR3BWqLJIvlcCyr
        CNOQXbMP9B+Q73LFWSBjohN7Rg==
X-Google-Smtp-Source: ABdhPJywyGKnqq1V2paxWnR8T4gDyaRPZAbgv7ZM88KcD65BYAgOubg2wGcIuvlSdR++OtUlPvntWw==
X-Received: by 2002:a5d:5281:0:b0:20c:d5be:331c with SMTP id c1-20020a5d5281000000b0020cd5be331cmr46490408wrv.9.1653941699537;
        Mon, 30 May 2022 13:14:59 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0020d110bc39esm9770401wrz.64.2022.05.30.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:14:58 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/7] dt-bindings: display: mediatek: dpi: add power-domains property
Date:   Mon, 30 May 2022 22:14:30 +0200
Message-Id: <20220530201436.902505-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
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

DPI is part of the display / multimedia block in MediaTek SoCs, and
always have a power-domain (at least in the upstream device-trees).
Add the power-domains property to the binding documentation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 77ee1b923991..caf4c88708f4 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -57,6 +57,9 @@ properties:
       Output port node. This port should be connected to the input port of an
       attached HDMI or LVDS encoder chip.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -64,6 +67,7 @@ required:
   - clocks
   - clock-names
   - port
+  - power-domains
 
 additionalProperties: false
 
@@ -71,11 +75,13 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8183-power.h>
 
     dpi0: dpi@1401d000 {
         compatible = "mediatek,mt8173-dpi";
         reg = <0x1401d000 0x1000>;
         interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
         clocks = <&mmsys CLK_MM_DPI_PIXEL>,
              <&mmsys CLK_MM_DPI_ENGINE>,
              <&apmixedsys CLK_APMIXED_TVDPLL>;
-- 
2.36.1

