Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D344BBB35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiBRO4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiBRO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:56:26 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB2C57B3B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:00 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k1so15027129wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qC+RbOnlbAMYT0RkhfvSIqXlBo3fNavEyqmQsnLiR2Q=;
        b=CB/gthuBR1PKlTX0iRK6AGpgmej1LoRD8khuOAy0FQB9eCSE8iJkQM4NYE1ZysOiKs
         la2wmI5DNqHmk3Wie4KVwcRAjSuR3pv9v0Z3NBZHUVKejZwAY0Y78WkhHLlnXLYHPDIv
         KiAERdi2FrteWdUGKvtFGAAT71x4pk+S1RHGgB1i/atRB3wMMCKZVkDFzFbER0ZMu+O4
         VATNEmRSJkbX/ZDl4zvF+/q0Cl8dwfUwyt24KzEVU8MVMBpgeCCsQTzOW3z1fLhqK7CM
         WOhVK1BhA0a2HUW0Pn8hKI2l4dGz92rXj1d/SpDEDofgbA1bFqHzXEVn6guVSxM93lv7
         SjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qC+RbOnlbAMYT0RkhfvSIqXlBo3fNavEyqmQsnLiR2Q=;
        b=3rY10/dODCRa0rdQWewX8icdMyb1v264MmNfsFjFV1bR35hGlU/TWmMOnPKagoIKo5
         DzzfBsEeOnJOqEsZs3nnNG2mxVd9GnNenYNy15/igwnnGxQWQQA+VkpvrjoGFKjdi9HH
         SP7r573KBSuVvsr5Un6mSIRy3ZGORYrxvbgUcw8B1DDYEgsxityHMyuk2oCqq695UiFP
         bYCja6BYuiEhnmJAqLP+19zTJTCNyj2cDU/YtTa0A5755QGfYCsXIsWaonooND+XLoIu
         PhNDvsHkJPGVErtvPCwoKNFTkoSJ+RRGpo587FJxZKOEtycG2hQu9e6089mxsYEhSLgI
         PQqA==
X-Gm-Message-State: AOAM530kjanO9CIoJ0fuhOfEACR2ZKd5v3jxNMvpBDZDT1mmhgvotIg9
        n7nWPgTV9uaFXepOcNbLwiRzcw==
X-Google-Smtp-Source: ABdhPJwNBdk3NS5ZflKP/t4iGuuUk373NB0fBIlAS30h710cFUX/Rlxqs4tq3A739PN3fuS29Ive5g==
X-Received: by 2002:a05:6000:257:b0:1e3:3a1b:d4ca with SMTP id m23-20020a056000025700b001e33a1bd4camr6304391wrz.112.1645196158903;
        Fri, 18 Feb 2022 06:55:58 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:55:58 -0800 (PST)
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
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 01/19] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Date:   Fri, 18 Feb 2022 15:54:19 +0100
Message-Id: <20220218145437.18563-2-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218145437.18563-1-granquet@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
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
2.34.1

