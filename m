Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED6D48B875
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbiAKUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:19:10 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38494
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345974AbiAKUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:30 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 06B4A4004D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932309;
        bh=B7eb4svBYjse6OhWKfcBGRECU3OCvQCpw+6zWu1iivQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VMklxot9Fi6B5ts7Cs6cSfLPN64RxB8T+o/PTWfmjx2L7wWRNvmHUmkjIn99JKzIT
         Vzsizbfm+KWGqpA9LPmJZPbEWHnA4vghNX02OblrzuAlqN7tHXKOWgVR+uqyqvecVe
         aFrVnmUzbc9bdpNuKzBWtR5FtmLXbupI2Wu5fO/PHbAM5C3iuSYeHlE5lYRBYa0hKr
         GpQGuvO3YBok9SXyz4HSAoASTtOQ+ZGtT+UK5I5YOResSZBENX4x/y8mm/cap3LZf0
         w5iATjKLFFR7bYcFMdURmthaD2O29mlHrqIkayVkrrF6KYF57wLdvA/m/aM8WH9ORp
         JwKjus9QN8nyQ==
Received: by mail-ed1-f69.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso179703edd.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7eb4svBYjse6OhWKfcBGRECU3OCvQCpw+6zWu1iivQ=;
        b=kRGiyIlKKrsiGGGWN9WOEh/w0w+dRqMWwMbwzt1+Cq7RbtxHLq0QZfRopXE9yOIjYz
         NcALgFC4hzJMflayptQf+9U57gSXcL4MN3/q9fo70Ni+pwPGsimZy+jVPSbqtHUBYbqF
         ZruCaqmXXNZ0ljzfaQOhzZpoJlTXN32QFvx4C72ABQwYAgeC7PvRQG3qK9AEseeyxfEU
         HF93/WJA/Z1bxGQS2RJXEsZdAEPcAXlietDd/4PeebYaIuY3U9hIdZBhUopUoDMoBrp+
         GC47ZXc7fWNXrL1MBkYz5sup+VpGvRHjv7/LZ1R3/RYRldCgZpURQpYZAVrPE4whaw6n
         +CCg==
X-Gm-Message-State: AOAM530MXfvyIzqoMndSoLczboAROCYptxXsa09LxVMeBgY71CyCPfPu
        9/teZ3QuYkHG728Lk0AJzQ4Ox+eoy3X+rMq1o6xnqivm6vrD3VZw6IE/rdEYcfvvIrLnUP6SPly
        KyKHXI3cULB8He4ASX0orkCbV+QiZxBP0qMNPYTOexw==
X-Received: by 2002:a17:906:9743:: with SMTP id o3mr4917475ejy.162.1641932307890;
        Tue, 11 Jan 2022 12:18:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDLMQAtYvvGFLQbylU0wX+h2/hT+LQs+a2r74G9q823h9VzJ2eJOEH3H9exRQ9Re9sKec2MA==
X-Received: by 2002:a17:906:9743:: with SMTP id o3mr4917457ejy.162.1641932307713;
        Tue, 11 Jan 2022 12:18:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 25/28] dt-bindings: pinctrl: samsung: describe Exynos850 and ExynosAutov9 wake-ups
Date:   Tue, 11 Jan 2022 21:17:19 +0100
Message-Id: <20220111201722.327219-19-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Samsung Exynos SoC pin controller nodes (Exynos3250, Exynos4,
Exynos5, Exynos5433) with external wake-up interrupts, expected to have
one interrupt for multiplexing these wake-up interrupts.  Also they
expected to have exactly one pin controller capable of external wake-up
interrupts.

It seems however that newer ARMv8 Exynos SoC like Exynos850 and
ExynosAutov9 have differences of their pin controller node capable of
external wake-up interrupts:
1. No multiplexed external wake-up interrupt, only direct,
2. More than one pin controller capable of external wake-up interrupts.

Add dedicated Exynos850 and ExynosAutov9 compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../samsung,pinctrl-wakeup-interrupt.yaml     | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 6b684a53119b..a822f70f5702 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -16,9 +16,12 @@ description: |
   controller.
 
   External wake-up interrupts for Samsung S3C/S5P/Exynos SoC pin controller.
-  Only one pin-controller device node can include external wake-up interrupts
-  child node (in other words, only one External wake-up interrupts
+  For S3C24xx, S3C64xx, S5PV210 and Exynos4210 compatible wake-up interrupt
+  controllers, only one pin-controller device node can include external wake-up
+  interrupts child node (in other words, only one External wake-up interrupts
   pin-controller is supported).
+  For newer controllers, multiple pin-controller device node can include
+  external wake-up interrupts child node.
 
   See also Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml for
   additional information and example.
@@ -32,6 +35,8 @@ properties:
       - samsung,s5pv210-wakeup-eint
       - samsung,exynos4210-wakeup-eint
       - samsung,exynos7-wakeup-eint
+      - samsung,exynos850-wakeup-eint
+      - samsung,exynosautov9-wakeup-eint
 
   interrupts:
     description:
@@ -41,7 +46,6 @@ properties:
 
 required:
   - compatible
-  - interrupts
 
 allOf:
   - if:
@@ -56,6 +60,8 @@ allOf:
         interrupts:
           minItems: 6
           maxItems: 6
+      required:
+        - interrupts
 
   - if:
       properties:
@@ -67,6 +73,8 @@ allOf:
         interrupts:
           minItems: 4
           maxItems: 4
+      required:
+        - interrupts
 
   - if:
       properties:
@@ -81,5 +89,18 @@ allOf:
         interrupts:
           minItems: 1
           maxItems: 1
+      required:
+        - interrupts
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos850-wakeup-eint
+              - samsung,exynosautov9-wakeup-eint
+    then:
+      properties:
+        interrupts: false
 
 additionalProperties: false
-- 
2.32.0

