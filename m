Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE6478F21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhLQPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbhLQPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:09:21 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA011C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:09:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t26so4655474wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0zmm5Uwifws1MjnZkoUoDiCdMAMP2gTWa9ThB/Ce5w=;
        b=HiI6Pzls1JZKv4QmjjgDV0dP59e7eML5Uxrijbu7h94/E6mIBwXfsvMDg/0qDsS/40
         LQ6IaIMyUkNrczWzL3lRvSWZJEjUPaaTesF8oi0tzguCd+hloRw+9tj7+nQ12eqgozsh
         XTtP75hHNxb8vbVPWp0m52ZoQFpl8RjTJnMIhuMAbhMBMQrin6mFYaW6JRGnxoMcX7xj
         LIal1DRnVz6dKP/zniJdPQCjiT7aLJt3f0GG30ccY/w2qPiaJPgA5m7PxwBBVmpNGbVx
         /pf0qcU07yC+xQWkI8l6EfwQBE+kbp7V/jj/x7NZzq0VXECNDhNuN0VxvEm/iU6lx84c
         RsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0zmm5Uwifws1MjnZkoUoDiCdMAMP2gTWa9ThB/Ce5w=;
        b=E1iYiqFnPaszktKP9/CPS58VDXk7eq/D3wNQ58InDNkmPF4468WTVMPGBYgKQpxF7g
         UIoUrBWYPtVtkgUnul06kL9CjV+L86O2llhVoMAqVG3kUaTjobYkud+ld5j6uSHbQc/Z
         EBigIBA/Lr2xy355NaZjqatmAex8XW8YCUxpVCen2x/jMoa6DVpbNxhDRqDHL8ZO33wj
         bSx+tIf6Pn7cNzGZXIdikTKcUXaZAtSFuyaJUpAi/vyCBdUr7aPNxQnxGZvURoW5qff/
         a87OlgNOvpI00fYA4WCYG8tIQo9a4jFfCM6C+T7zIVgJ/C/ZlENwnHHsCvFibfG+jkBd
         bOUA==
X-Gm-Message-State: AOAM533ZYu7O04w3Use6VKQzpCx3TU2bjQyOgxPTpkAwIJBr0J8C8swC
        3l+4HA7gDPpuZVsIVpIGZ0OfLQ==
X-Google-Smtp-Source: ABdhPJx5/1BsBGu53I1FtcJbP7X+IDnOXTCM7flbne+QScrb5fAv3VQF1KMorpUVilt/7lV7ZP4BVw==
X-Received: by 2002:a05:6000:15c7:: with SMTP id y7mr2935396wry.424.1639753759334;
        Fri, 17 Dec 2021 07:09:19 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6441-43a4-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6441:43a4:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id g18sm12655132wmq.4.2021.12.17.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:09:18 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/8] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Date:   Fri, 17 Dec 2021 16:08:47 +0100
Message-Id: <20211217150854.2081-2-granquet@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217150854.2081-1-granquet@baylibre.com>
References: <20211217150854.2081-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index dd2896a40ff08..53acf9a84f7fb 100644
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
2.32.0

