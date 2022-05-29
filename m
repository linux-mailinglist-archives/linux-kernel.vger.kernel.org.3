Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D93537090
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiE2KvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiE2KvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:51:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DF4B429
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f9so16128410ejc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG2alJJEUiFUsTUssLuacIQlAnfrVBSipCBTK2ZQ304=;
        b=r3oLuFyLFfHTXiFMf3qFMnpoW2K7OINHmNW09UWdX00Co5LyDIJSUaxZa8+2Chf7D2
         P1/4lNUDVHAbXAPCj+/YohWp4TlG664iclnUeBwpIa0CwURyv72KCdQlBAKvPKFkUKqe
         pTd97pDgv14GLt/i+CDUJm5y+QAP0ee6PsKejQoM3DLT5Ho+Go5bEEf/BJBI/YATLE6u
         DyGyFRZy/4dIyoIxrCpw6OZseRzHNkewQq27hKZUnf3vIpcGsl+dtfa77kBa81CPBSfl
         vKdgW4ygXAAxnLvamA0yWHPCH77agefNu/xjRcHBATH0rSGaee/EvA07TZDLUdfXSzFn
         H0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG2alJJEUiFUsTUssLuacIQlAnfrVBSipCBTK2ZQ304=;
        b=W2NbnBXZSY/IJwi7DNYi2fXLDJ0s3PSQ4rxnJmIWmrt/hi/V6qOtZoI8GtOP/VRVnA
         oDX/O6wlIQAg40faQ8IK6aDN26aYOIvPyT3RPlT935by3beoMPv424Ux9JULUm2KiuW/
         EYW5WQtUIGsdm+M4FwDuMXxwifCj6eakbooNOaNM5XXAyVnTL8Zj7uw4VYQpPT7bJsk1
         9prSADYAJSuNKZ2S8VBLJh3hmYoPychaT+lleAdWieCBsYafEpps9UD/gGY6grXCgB1X
         ybe2YmPG2sm0+eCJScgBbN9fI0UZsppYjnTRv3N8lwy+ZDOtcGw/6rgKdkykSOLlWahm
         X+0Q==
X-Gm-Message-State: AOAM531U95zK11jH5NhMMqWdNMASbsizowPrkPatyY9fPoHiwOx0jeBT
        1ejptCKCwdoGFesc0ovLFiNhKw==
X-Google-Smtp-Source: ABdhPJyj6oLgJuEi9K+8KrQi1YE7XhrD3YlFKzr1kM6Jl/9u/Gt9lNhiMVx9XFKfT/WN03gdCI2E8g==
X-Received: by 2002:a17:906:2883:b0:6e8:7012:4185 with SMTP id o3-20020a170906288300b006e870124185mr43913960ejd.204.1653821474869;
        Sun, 29 May 2022 03:51:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w25-20020a50f119000000b0042b0fcfe966sm4746991edl.37.2022.05.29.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:51:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     David Wang <David_Wang6097@jabil.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: document several vendors for Aspeed BMC boards
Date:   Sun, 29 May 2022 12:49:22 +0200
Message-Id: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefixes for manufacturers of Aspeed SoC based BMC boards:
ASrock, ByteDance, Ingrasys, Inventec and Quanta.  Move also bticino to
proper alphabetical place.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/vendor-prefixes.yaml     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 495a01ced97e..169f11ce4cc5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -141,6 +141,8 @@ patternProperties:
     description: ASIX Electronics Corporation
   "^aspeed,.*":
     description: ASPEED Technology Inc.
+  "^asrock,.*":
+    description: ASRock Inc.
   "^asus,.*":
     description: AsusTek Computer Inc.
   "^atlas,.*":
@@ -195,12 +197,14 @@ patternProperties:
     description: Broadcom Corporation
   "^bsh,.*":
     description: BSH Hausgeraete GmbH
+  "^bticino,.*":
+    description: Bticino International
   "^buffalo,.*":
     description: Buffalo, Inc.
   "^bur,.*":
     description: B&R Industrial Automation GmbH
-  "^bticino,.*":
-    description: Bticino International
+  "^bytedance,.*":
+    description: ByteDance Ltd.
   "^calamp,.*":
     description: CalAmp Corp.
   "^calaosystems,.*":
@@ -544,6 +548,8 @@ patternProperties:
     description: Shenzhen Hugsun Technology Co. Ltd.
   "^hwacom,.*":
     description: HwaCom Systems Inc.
+  "^hxt,.*":
+    description: HXT Semiconductor
   "^hycon,.*":
     description: Hycon Technology Corp.
   "^hydis,.*":
@@ -578,6 +584,8 @@ patternProperties:
     description: Infineon Technologies
   "^inforce,.*":
     description: Inforce Computing
+  "^ingrasys,.*":
+    description: Ingrasys Technology Inc.
   "^ivo,.*":
     description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^ingenic,.*":
@@ -598,6 +606,8 @@ patternProperties:
     description: Inter Control Group
   "^invensense,.*":
     description: InvenSense Inc.
+  "^inventec,.*":
+    description: Inventec
   "^inversepath,.*":
     description: Inverse Path
   "^iom,.*":
@@ -1010,6 +1020,8 @@ patternProperties:
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
+  "^quanta,.*":
+    description: Quanta Computer Inc.
   "^radxa,.*":
     description: Radxa
   "^raidsonic,.*":
-- 
2.34.1

