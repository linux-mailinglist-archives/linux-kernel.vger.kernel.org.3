Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BC94E79EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350326AbiCYRSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377323AbiCYRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23731E9964
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4800294wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWuHqcRax2E7zzIXZh7ToC5GlWwIxifW/4CmtpMgB/Q=;
        b=e9fQyZ0WE4Z9h6IyESMybIA7h3EtJ5dTgMV5mf91m3HTYR3d6PR3x3ANzlsJDjJpFX
         xyZXVKaHjuCfMF0lwm2Qu9a7yuhgIE8FNiY3Ra2C5iqjAr38LTWfu0BJ1+fhXSTWmUih
         aM3pvBv9RdHz220XVpBcXT8iiq7aPvagI4hTcp8GseBYMM+pFmDDxSClw8erRNva9gEY
         2imqr9DiFYjUmXQtnWctQLqe2NXNA30qtmtWcNWqvaW0TdlhnfPmu+EdWfkrn8Zm2deG
         A+8Q+xLGHP3uj/hxELbU2uz03u/3WDCI7leUQAxmTATuBJuts6p2eUn35MBM400RFU+U
         mxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWuHqcRax2E7zzIXZh7ToC5GlWwIxifW/4CmtpMgB/Q=;
        b=gSs/+KssZf/CyY4ZSEIRSE6fgQqqrLtaYoYF0YUJKCziVSS2qk5+BvGcG3oTiv4mfo
         naLMsd8lCdNX1d8GfTwFOL/P+LASBZ2kRatpSrWUw+3ZkhKIWOVN1fgMC5zT53fHBwCU
         QIiVdwR2mLhdJEZK9LS2lvMfDcb0tQ6UlR9IC5XJwlpDm2bLO6bIcFOawX5vj/fZTPOG
         17/MN+aFTa5AhV6IZqtA++Od4opNT4JJ6hZSaWjhPSoFGGOs5N2q1daAVOh7tJpOuR8D
         fG+QMgKJgg4S5SL8KqptNdqJcS67gb4t2lcVx88v/dBxAWpkDJ053ROhFqNtFVV0aV/l
         7LnA==
X-Gm-Message-State: AOAM532G+DefBORNxzJTG6YESn+RmHf55XJ+k7jmxp9GNt6juWsA3GcX
        lKDN/ymiFB95KieFmcv+ZYjK0g==
X-Google-Smtp-Source: ABdhPJyseADl0QeZy7YFh7ZKp586b0q8d6AxSePwH+EeyXqFYla8oR9D8vfPuUxPBa3bYk7yPTd2ig==
X-Received: by 2002:a05:600c:4e91:b0:38c:c1ac:c018 with SMTP id f17-20020a05600c4e9100b0038cc1acc018mr15761137wmq.189.1648228609419;
        Fri, 25 Mar 2022 10:16:49 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:49 -0700 (PDT)
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
        markyacoub@google.com
Subject: [PATCH 03/22] dt-bindings: mediatek,dp_phy: Add Display Port PHY binding
Date:   Fri, 25 Mar 2022 18:14:52 +0100
Message-Id: <20220325171511.23493-4-granquet@baylibre.com>
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

This phy controller is embedded in the Display Port Controller on mt8195 SoCs.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
new file mode 100644
index 000000000000..4180d40f4fa7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 MediaTek
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Display Port PHY binding
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  Device tree bindings for the Mediatek (embedded) Display Port PHY
+  present on some Mediatek SoCs.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-dp-phy
+
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the Display Port node.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - regmap
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    dp_phy: dp_phy {
+      compatible = "mediatek,mt8195-dp-phy";
+      regmap = <&dp_tx>;
+      #phy-cells = <0>;
+    };
-- 
2.34.1

