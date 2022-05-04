Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F460519F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349584AbiEDMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349579AbiEDMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777721582A;
        Wed,  4 May 2022 05:32:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so2613258ejn.2;
        Wed, 04 May 2022 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQb6i3JLN4afiayNb9b2ZXTM0vOnQttR7jIOROP3G/Y=;
        b=aHsdTT0i4b+/rqquEcasEwbRp4vMI3Q/epZoFwj34h2xL8rLbYyhjwsHaeXj2w6q6b
         LfiN265tlqSl+XbGmfUaltU98rUUgb1SSvHf5jrzEuFnsz0IDoRdbiurn2lyfMb22uCm
         F+I+MLHKaNmCUmGNqKPlb4hlNpB4IZjX0pldxi9H9kIbs4A/1PIgvdt/YwAkMo3IBS8z
         BMxALBRT/zIndRVeMc7UgmtzeK/8nRuIyMcK74pXOk2BNu2T5E58qsymc12ENMAKmQj9
         DwthCm2/9M/0ZAap2kNe9PU037opvy9r0Gaxv65kmtaZRmrQI3pMmVMovMIQuEjlw7tH
         e3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQb6i3JLN4afiayNb9b2ZXTM0vOnQttR7jIOROP3G/Y=;
        b=HnSsrWWh+j4/dYgX2hTSFzuDsIWJG97scgTmmYHJlZns6fnur4f7E2jw4lbuPY+mNj
         Hhe6VwJ7gRYvq5BlT/4PXeGY7uxjOQjl+rjFmVgAdpBBJL+qCwOZ9K3cKS/5jdOhNoLr
         HmvXB5UkHTG9vSBVnR1xUBVCFnTmlz6bQVQVNkughxMWEYU22A2/Nv46VIfPVq1RcWva
         Wsyi754pPr7FTZWYJzLKD5vkQMztPODfwppXgw4zAAkeoAJ6/DG3DRrhIHd9T+OvHueM
         39m5hzA6L/RQOKZ3/9G+wARk3R3EWj2JS3ZYZ9+OcGEfbgrAfMxOpUBtv4Gj8qu3si2O
         10pQ==
X-Gm-Message-State: AOAM532UKmwi1LjFmVtO+KV4FzWxG+SO+YwH8zm2wjoEzNMA4ToDMxmO
        NUh5URgYndZffyETPZpJlIc=
X-Google-Smtp-Source: ABdhPJzNBv4cEDn9Jph+56mXidHah4kYetwQwPrK8Clz9ddS7VIxbIJcMRjEj4lpElEiNV5dFKT2NQ==
X-Received: by 2002:a17:907:3f16:b0:6f4:c54:2700 with SMTP id hq22-20020a1709073f1600b006f40c542700mr20296404ejc.615.1651667543019;
        Wed, 04 May 2022 05:32:23 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:22 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/13] dt-bindings: arm: mediatek: Add MT6735 clock controller compatibles
Date:   Wed,  4 May 2022 16:25:52 +0400
Message-Id: <20220504122601.335495-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504122601.335495-1-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add compatible strings for MT6735 apmixedsys, topckgen, infracfg
and pericfg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/arm/mediatek/mediatek,infracfg.yaml          | 8 +++++---
 .../bindings/arm/mediatek/mediatek,pericfg.yaml           | 1 +
 .../devicetree/bindings/clock/mediatek,apmixedsys.yaml    | 4 +++-
 .../devicetree/bindings/clock/mediatek,topckgen.yaml      | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index 8681b785ed6d..aa1bb13e0d67 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -11,9 +11,10 @@ maintainers:
 
 description:
   The Mediatek infracfg controller provides various clocks and reset outputs
-  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>,
-  and reset values in <dt-bindings/reset/mt*-reset.h> and
-  <dt-bindings/reset/mt*-resets.h>.
+  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>
+  and <dt-bindings/clock/mediatek,mt6735-infracfg.h>, and reset values in
+  <dt-bindings/reset/mt*-reset.h>, <dt-bindings/reset/mt*-resets.h> and
+  <dt-bindings/reset/mediatek,mt6735-infracfg.h>.
 
 properties:
   compatible:
@@ -22,6 +23,7 @@ properties:
           - enum:
               - mediatek,mt2701-infracfg
               - mediatek,mt2712-infracfg
+              - mediatek,mt6735-infracfg
               - mediatek,mt6765-infracfg
               - mediatek,mt6779-infracfg_ao
               - mediatek,mt6797-infracfg
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index 611f666f359d..94e5e003e60e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - mediatek,mt2701-pericfg
               - mediatek,mt2712-pericfg
+              - mediatek,mt6735-pericfg
               - mediatek,mt6765-pericfg
               - mediatek,mt7622-pericfg
               - mediatek,mt7629-pericfg
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index 770546195fb5..3a186621e7a9 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description:
   The Mediatek apmixedsys controller provides PLLs to the system.
-  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>
+  and <dt-bindings/clock/mediatek,mt6735-apmixedsys.h>.
 
 properties:
   compatible:
@@ -32,6 +33,7 @@ properties:
           - enum:
               - mediatek,mt2701-apmixedsys
               - mediatek,mt2712-apmixedsys
+              - mediatek,mt6735-apmixedsys
               - mediatek,mt6765-apmixedsys
               - mediatek,mt6779-apmixedsys
               - mediatek,mt7629-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 5b8b37a2e594..920bf0828d58 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description:
   The Mediatek topckgen controller provides various clocks to the system.
-  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h> and
+  <dt-bindings/clock/mediatek,mt6735-topckgen.h>.
 
 properties:
   compatible:
@@ -31,6 +32,7 @@ properties:
           - enum:
               - mediatek,mt2701-topckgen
               - mediatek,mt2712-topckgen
+              - mediatek,mt6735-topckgen
               - mediatek,mt6765-topckgen
               - mediatek,mt6779-topckgen
               - mediatek,mt7629-topckgen
-- 
2.36.0

