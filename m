Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D73597E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbiHRGRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiHRGRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:17:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6194ED3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:17:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u9so842732lfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3lKvSLctByK0zaQtA6Zi8eoMtQj42Hrxz02cVPPHF9Y=;
        b=WdtbeKlQvJsYj2WMvztp7RbB2d27anQdkC/S8ppbLUke62xlXRV6AL70R59/rktGaD
         aMriqETm0kF/5YRl0jMh7Fmj+udKG73AevbuWz1ounWn4GFPTSrNV4gKVz0iTFp5QZlC
         E5MWyvADKw2du/r86rc6W+IsvgdKIS6IC+MpOKHi+9SieWDtOBYWtF7x2cqidmnRxqsV
         a4zJyFcrcSF70SZu1Xe0e38qk8opfjxzhKv9MYbtlcMMiiFnA4Eo1bOqj+LVb3mXgRfP
         zM7aQPpRSxoOLpVkxwCx8pkUKXOyexhWoeD4KYQNbeXALzUgqyQ46Qe4O+F13tqzLzOO
         c5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3lKvSLctByK0zaQtA6Zi8eoMtQj42Hrxz02cVPPHF9Y=;
        b=TzbsRYyTXwxOfVGH2W/yDkpvhYbUa7uTDwuAxBXIAUNbAcgcTO+6E50hpyG6SePewx
         0qFBT3qdyv6Vh8DO1LrjjFIE+QEgXQHpbWyJMa2nZUG8RlolcYmiQMGYIOvLOvblHs7F
         GHrphuJn1UmCvqCG7xVqIJku72THUwak2uaDp/9Sc6IoeABuRDDkII8BZ9JGnEc5aNAJ
         TgTwCcCn5QJg+vWdXp7Gqa5wCtuADt02Ws39yQfR3BZWUms85yl+JnrPTn73iQsbR6Q2
         qUj/95eL04GlLWRoK/+AWf0czwPZDdiU6q7vnIBHp2RhGi3NMc7IRrHx6JxVmVkYdYnl
         e09A==
X-Gm-Message-State: ACgBeo3l+0u3Whc5olR3uDbWiWhzdlNsYXAjfMGyS0Jaepia9Cg13P3P
        awKM2s54jpxxzV3EAMk1V+K1Fir5QRQGpH0G
X-Google-Smtp-Source: AA6agR4rPJNr1Z23bdYVXjYbH/epwMhSaP+1kE6as9hyHWK9eejt9hdliKqVf3C3FTtv751W8tpIrA==
X-Received: by 2002:a05:6512:3b88:b0:492:ae89:d6d0 with SMTP id g8-20020a0565123b8800b00492ae89d6d0mr455491lfv.381.1660803435694;
        Wed, 17 Aug 2022 23:17:15 -0700 (PDT)
Received: from krzk-bin.. (d15l54bxv1k5c31plwt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:671:aa32:2bd5:8994])
        by smtp.gmail.com with ESMTPSA id t11-20020ac243ab000000b0048b2ba11520sm92734lfl.165.2022.08.17.23.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:17:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: gpu: arm,mali: restrict opp-table to objects
Date:   Thu, 18 Aug 2022 09:17:13 +0300
Message-Id: <20220818061713.9611-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple 'opp-table:true' accepts a boolean property as opp-table, so
restrict it to object to properly enforce real OPP table nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct typo in msg.
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 3 ++-
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index d209f272625d..2a25384ca3ef 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -74,7 +74,8 @@ properties:
       - const: bus
 
   mali-supply: true
-  opp-table: true
+  opp-table:
+    type: object
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index eceaa176bd57..318122d95eb5 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -101,7 +101,8 @@ properties:
 
   mali-supply: true
 
-  opp-table: true
+  opp-table:
+    type: object
 
   power-domains:
     maxItems: 1
-- 
2.34.1

