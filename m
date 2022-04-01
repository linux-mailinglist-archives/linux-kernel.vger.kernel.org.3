Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130A84EEF0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbiDAOOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbiDAOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:14:38 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634619B07A;
        Fri,  1 Apr 2022 07:12:49 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id e4so2945876oif.2;
        Fri, 01 Apr 2022 07:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jow2eA+MI6HdTKLrJxjfgwwcafk9Rc4cTIw/I0CdChY=;
        b=dXdgFdlvIHyz3WTU36xfgFAcqof98XisB+wBhig27gWnEfiStbggNfPHnt4vKgcLrr
         ht4aMa/6+brmlYZXA4Ju5+4Aq5OXSP/7flzEjgdFU5xF43Di0THakXV0twJl28zwOGEv
         iGXXC/P4jGlhGc5BnWAaB2xbxCWHPZbLtUFwmgt73TplpZKZ+O13D/kuPuBAFAYR+EEg
         jP3G8JzoLEn2loH2F/1oovAZRyxPBpp/qlNPX711BXTVkC5nPYD2gA63zmnT96aAm/0I
         0SeXcQszIC24ByKN8b8YgxI5QfyshWOcniiv6pFnpgKTyGuO/M4gaJf7f2m/x2aXaDN0
         gM2w==
X-Gm-Message-State: AOAM530TRgoCD5crNIJf61IVuITVUKQVflBu1GedNo8PN4HqvYe2aa9K
        C3y8T6GNIT7y0YOMSE0FYQ==
X-Google-Smtp-Source: ABdhPJwOZ6ZR8VxrolMyYpaGXgl8mDv6WoiaUUXqkNSXOh4+MeSeNSLAbSpT7zsDvb7yXs+2T2nw9A==
X-Received: by 2002:aca:e004:0:b0:2da:850a:966d with SMTP id x4-20020acae004000000b002da850a966dmr4748771oig.61.1648822368657;
        Fri, 01 Apr 2022 07:12:48 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id n128-20020a4a4086000000b0032118eda64bsm1029758ooa.38.2022.04.01.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:12:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        - <patches@opensource.cirrus.com>, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix 'enum' lists with duplicate entries
Date:   Fri,  1 Apr 2022 09:12:47 -0500
Message-Id: <20220401141247.2993925-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to list the same value twice in an 'enum'. Fix all the
occurrences in the tree. A meta-schema change will catch future ones.

Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: - <patches@opensource.cirrus.com>
Cc: linux-media@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
There's also one other occurrence in snps,dwmac.yaml I didn't fix as 
there's a patch[1] for it which prompted this patch.

Rob

[1] https://lore.kernel.org/r/20220401030847epcms1p8cf7a8e1d8cd7d325dacf30f78da36328@epcms1p8

 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml        |  1 -
 Documentation/devicetree/bindings/bus/ti-sysc.yaml    |  1 -
 .../bindings/media/mediatek,vcodec-encoder.yaml       |  1 -
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml    | 11 +++++------
 .../devicetree/bindings/power/supply/bq2415x.yaml     |  1 -
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index 0afec83cc723..564ae6aaccf7 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -13,7 +13,6 @@ maintainers:
 properties:
   compatible:
     enum:
-      - nvidia,tegra20-pmc
       - nvidia,tegra20-pmc
       - nvidia,tegra30-pmc
       - nvidia,tegra114-pmc
diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.yaml b/Documentation/devicetree/bindings/bus/ti-sysc.yaml
index bd40213302da..fced4082b047 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.yaml
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.yaml
@@ -34,7 +34,6 @@ properties:
     oneOf:
       - items:
           - enum:
-              - ti,sysc-omap2
               - ti,sysc-omap2
               - ti,sysc-omap4
               - ti,sysc-omap4-simple
diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index e7b65a91c92c..df7df06c378f 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -106,7 +106,6 @@ allOf:
           enum:
             - mediatek,mt8173-vcodec-enc
             - mediatek,mt8192-vcodec-enc
-            - mediatek,mt8173-vcodec-enc
 
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index 8a90d8273767..6bd42e43cdab 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -48,13 +48,12 @@ properties:
               Name of one pin group to configure.
             enum: [ aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1,
                     pdmspk2, dmic4, dmic5, dmic6, gpio1, gpio2, gpio3,
-                    gpio4, gpio5, gpio6, gpio7, gpio7, gpio8, gpio9,
+                    gpio4, gpio5, gpio6, gpio7, gpio8, gpio9,
                     gpio10, gpio11, gpio12, gpio13, gpio14, gpio15,
-                    gpio16, gpio17, gpio17, gpio18, gpio19, gpio20,
-                    gpio21, gpio22, gpio23, gpio24, gpio25, gpio26,
-                    gpio27, gpio27, gpio28, gpio29, gpio30, gpio31,
-                    gpio32, gpio33, gpio34, gpio35, gpio36, gpio37,
-                    gpio37, gpio38, gpio39 ]
+                    gpio16, gpio17, gpio18, gpio19, gpio20, gpio21,
+                    gpio22, gpio23, gpio24, gpio25, gpio26, gpio27,
+                    gpio28, gpio29, gpio30, gpio31, gpio32, gpio33,
+                    gpio34, gpio35, gpio36, gpio37, gpio38, gpio39 ]
 
           function:
             description:
diff --git a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
index f8461f06e6f4..118cf484cc69 100644
--- a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
@@ -16,7 +16,6 @@ allOf:
 properties:
   compatible:
     enum:
-      - ti,bq24150
       - ti,bq24150
       - ti,bq24150a
       - ti,bq24151
-- 
2.32.0

