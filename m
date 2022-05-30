Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042F053881F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbiE3UPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243141AbiE3UPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:15:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E981486
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d26so10410068wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68IUzThINQHS9c64e/2mypyGj3LqFegF7aUXUpeQSII=;
        b=u2d8p4QAEi3ctSajLm45PHcAdGNb4dc77i74TOisR6B9VoH4w4onMoONsDGc3+PD+H
         +CrhEa4dqWqz9Ox/kXTWVRT8E7CQbbf7aihiXS2nwKfsF7QdmyITkvGLWshI6CBe8T3o
         w+MZ3qyL9qilLXMp73nAWWB+Wf7+LKB0j1tLpB4aiA6DfeiwUpupRWzLyf2NdaFVwFhp
         06XaOJrlzigu+lK98u0RqdZ4636R+6b0oGqiR/Rv9Wpdw2nS8VyJTiojxul5B+VTONR3
         8g+oeqgqR/+0BrG0MjTMrWqf6A0PMwEMqEuRVaqq+3TNoBTalrcrKHPHGw0XGUawcdLW
         kgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68IUzThINQHS9c64e/2mypyGj3LqFegF7aUXUpeQSII=;
        b=NeBTrDzDVNt0dk8DImCKPXAKK2MEFc4eYRH4Su2TOk/Sp3FOaFswYBad/xHE8J9/xu
         zyLvGYDAs3hNZCgHkvV240gkZH6wBky/xtL5HQm1KBzGvVJ5MGBkL598eR+oNgmb3odz
         VQFOSQAcxhXanOwulLqb3ZJ2TvYwwNdBTUKqHhX9uISUkb5YsK0XtbO9LREfYBPTN1MT
         FZH5/3cJw0CcxP2PecQeOWoiXQQGAgLAgD/rZpntCldstMveQ2xF3S+S9jofsX4LcZTj
         iEwZWDSlTiMOg9GXi2Hwzlyhs1bCHbBjVDDUqgMk6i7m5CnP8dVRfjKLyzgw2NoXS8Qv
         NJcw==
X-Gm-Message-State: AOAM530go/Yp5hvjPO+ZoBm9TNTQNvU7lYiQt39GX5KQpFwJ+1CJuUrO
        FfXrb6Qtd2+hGowpOufu3eL6kg==
X-Google-Smtp-Source: ABdhPJyV//TAUQKJXHBmXItC+7NmI594G8rIKaBMVmslTUXdIAFnw+TnofqHost0A6YrIMpMLuB/pw==
X-Received: by 2002:a05:6000:2ab:b0:210:12ab:76e6 with SMTP id l11-20020a05600002ab00b0021012ab76e6mr17162232wry.120.1653941700978;
        Mon, 30 May 2022 13:15:00 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0020d110bc39esm9770401wrz.64.2022.05.30.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:15:00 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/7] dt-bindings: display: mediatek: dpi: add binding for MT8365
Date:   Mon, 30 May 2022 22:14:31 +0200
Message-Id: <20220530201436.902505-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530201436.902505-1-fparent@baylibre.com>
References: <20220530201436.902505-1-fparent@baylibre.com>
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

DPI for MT8365 is compatible with MT8192 but requires an additional
clock. Modify the documentation to requires this clock only on MT8365 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../display/mediatek/mediatek,dpi.yaml        | 44 ++++++++++++++++---
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index caf4c88708f4..c9c9f4d5ebe7 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -17,13 +17,18 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt2701-dpi
-      - mediatek,mt7623-dpi
-      - mediatek,mt8173-dpi
-      - mediatek,mt8183-dpi
-      - mediatek,mt8186-dpi
-      - mediatek,mt8192-dpi
+    oneOf:
+      - enum:
+          - mediatek,mt2701-dpi
+          - mediatek,mt7623-dpi
+          - mediatek,mt8173-dpi
+          - mediatek,mt8183-dpi
+          - mediatek,mt8186-dpi
+          - mediatek,mt8192-dpi
+      - items:
+          - enum:
+              - mediatek,mt8365-dpi
+          - const: mediatek,mt8192-dpi
 
   reg:
     maxItems: 1
@@ -32,16 +37,20 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     items:
       - description: Pixel Clock
       - description: Engine Clock
       - description: DPI PLL
+      - description: DPI Clock
 
   clock-names:
+    minItems: 3
     items:
       - const: pixel
       - const: engine
       - const: pll
+      - const: dpi
 
   pinctrl-0: true
   pinctrl-1: true
@@ -71,6 +80,27 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8365-dpi
+
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+
+    else:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.36.1

