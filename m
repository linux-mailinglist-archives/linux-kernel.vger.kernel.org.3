Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF5534850
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbiEZBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbiEZBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:42:14 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D276BA5031;
        Wed, 25 May 2022 18:42:11 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id f2-20020a4a8f42000000b0035e74942d42so70269ool.13;
        Wed, 25 May 2022 18:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=es4Dl3HxibZW+rfFQc8vlolcSAmU2qFD1JzSMoMcVAI=;
        b=kD7SRJg0uw016Bepf8+U7ep5uBwXBY13xHJqWKF5VKu001BZ+fuAFF5ZKggboasa3r
         Kpj9QGiT4KgcqKaKLLosknn6BVlbQUHkek458KeOBUVuMHmWzcffHEGqpPvbL7MXMWru
         wg6l1JRMs9ITDJPMJ7FltBosl98QDdvSLpg7tO+FfTQkIbGM1PA57wJcQurWu2Pf5idM
         N92jFjqTSpQirUiuHWbnItyIFm24eX3HkEjqAbOvDMJGAjA2j1yIy6n/vRPaGykTWbcf
         eA9lZfDwtXOaAiiRxW/d4teryAGT0hfJoHvbDw96UXbJISOLamR6NFYyOjoRxzzR1lUk
         YizQ==
X-Gm-Message-State: AOAM533Ha9cp0OePWm4vkNQEvwqtC3DQZrOZfZV7APjBr2ELeWwO9UVS
        MLv3g55Vl+10ctKHUbL9wQ==
X-Google-Smtp-Source: ABdhPJzflN/TcyuSaeWPrFPWA3VwGVIp/rDi77qRGec5FuOWcIL5jX3B1Wndr9AAvVRoq4Rq8zpRQw==
X-Received: by 2002:a4a:95c6:0:b0:35f:7f11:7055 with SMTP id p6-20020a4a95c6000000b0035f7f117055mr14079108ooi.87.1653529331123;
        Wed, 25 May 2022 18:42:11 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id c27-20020a9d615b000000b006062d346083sm122822otk.22.2022.05.25.18.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:42:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hu Ziji <huziji@marvell.com>, Al Cooper <alcooperx@gmail.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Fix unevaluatedProperties warnings in examples
Date:   Wed, 25 May 2022 20:42:04 -0500
Message-Id: <20220526014204.2873107-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'unevaluatedProperties' schema checks is not fully working and doesn't
catch some cases where there's a $ref to another schema. A fix is pending,
but results in new warnings in examples. Fix the warnings by removing
spurious properties or adding a missing property to the schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml  | 2 --
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index b672202fff4e..5ecdac9de484 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -75,7 +75,6 @@ examples:
       sd-uhs-sdr104;
       sdhci,auto-cmd12;
       interrupts = <0x0 0x26 0x4>;
-      interrupt-names = "sdio0_0";
       clocks = <&scmi_clk 245>;
       clock-names = "sw_sdio";
     };
@@ -94,7 +93,6 @@ examples:
       non-removable;
       bus-width = <0x8>;
       interrupts = <0x0 0x27 0x4>;
-      interrupt-names = "sdio1_0";
       clocks = <&scmi_clk 245>;
       clock-names = "sw_sdio";
     };
diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index c79639e9027e..aca1a4a8daea 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -56,6 +56,9 @@ properties:
       - const: core
       - const: axi
 
+  interrupts:
+    maxItems: 1
+
   marvell,xenon-sdhc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-- 
2.34.1

