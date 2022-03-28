Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700AF4E91FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiC1JyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiC1JyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:54:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B6546B2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:52:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so18130400pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPzKfL7z/ioVzkWZmdGnUOpm+jBpSszjouCZkOgerBU=;
        b=PYeDYo1HZ+7zO+AjGFbIt9N+/gsEwVMegWIS1I/bcFoGw2PEndjfGBaRvllTEbs38N
         bXCJNvmvP6ZAfHeZpXIU4iyuyb9MptbvUFETlcAZE46xCGPDdPvBYAQ9zSkk8R5DDTgb
         5S60isfPn4L159WOuC8jbTlz9F+uOPIOXLZ3E2c7Aq1lVQ0XEKMWPuWa+YcdvPUL2O35
         TY/cFDmCgsRX4OoFTJs3BMODa300OOCIj/TSt3G2gzC+bAXHZ78QMcfs4eEkQ6fJ6XHr
         alMg+XAF/PD2Yo6eM4tpg2eMEB53C0KBsrNeMRUSDUm7xmN8zuQjbskLfdazAxBn3DBG
         S1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPzKfL7z/ioVzkWZmdGnUOpm+jBpSszjouCZkOgerBU=;
        b=XuuwU1mIpAhBGl8dtdP01ls4m19qb+/wr9YMcQRXSXKosb8skmJRU87fIL0PFnN61O
         07lgfe4gd14r0TxoXY5WMcY7qJ63JzB8xHwj+PO1aw0AE/YOEoHaDPq758ArEO+d9ok+
         +Mnx32GpSmp6iJf7hdIdS6DZP6wQrHp/yrmxdMcKwjT5c8KrjoeuuDwcvDM69fOYI7A+
         o2Sb0PlZ/Nsirtt3fO+moIS1mNCrXhTR0xwKROmzwOeC2zGKr9S4jfV5M5NJdUmh+qF6
         0DebWwg3XrXPquUcz7caV1yejTL0zxwmTRfFwh0MK39HEgbqKNQ2+P+skXpQYE5B58Vh
         IDgw==
X-Gm-Message-State: AOAM531rVQQR7Yc0WpeE9BaJaxOakCCLDrPTXBnzJaeebmwApTCpcvuA
        RlUlNolUkpw3ZgRKe0lU4kfsWA==
X-Google-Smtp-Source: ABdhPJyTbXAWOqRoBuc+FpnhaK605V2eNVJRooRDgQ+I4q3Ph/Hxo0TJOY0YQ0dhaz7sKJr7ECLF+Q==
X-Received: by 2002:a17:902:ea52:b0:153:fd04:c158 with SMTP id r18-20020a170902ea5200b00153fd04c158mr25087355plg.83.1648461156722;
        Mon, 28 Mar 2022 02:52:36 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id g4-20020a633744000000b00381efba48b0sm12255117pgn.44.2022.03.28.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 02:52:36 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v8 1/4] dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and modify compatible
Date:   Mon, 28 Mar 2022 17:52:22 +0800
Message-Id: <7cc9a7b5f7e6c28fc9eb172c441b5aed2159b8a0.1648461096.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648461096.git.zong.li@sifive.com>
References: <cover.1648461096.git.zong.li@sifive.com>
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

Add dma-channels property, then we can determine how many channels there
by device tree, rather than statically defining it in PDMA driver.
In addition, we also modify the compatible for PDMA versioning scheme.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 47c46af25536..3271755787b4 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -28,7 +28,15 @@ allOf:
 properties:
   compatible:
     items:
-      - const: sifive,fu540-c000-pdma
+      - enum:
+          - sifive,fu540-c000-pdma
+      - const: sifive,pdma0
+    description:
+      Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
+      Supported compatible strings are -
+      "sifive,fu540-c000-pdma" for the SiFive PDMA v0 as integrated onto the
+      SiFive FU540 chip resp and "sifive,pdma0" for the SiFive PDMA v0 IP block
+      with no chip integration tweaks.
 
   reg:
     maxItems: 1
@@ -37,6 +45,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  dma-channels:
+    description: For backwards-compatibility, the default value is 4
+    minimum: 1
+    maximum: 4
+    default: 4
+
   '#dma-cells':
     const: 1
 
@@ -50,8 +64,9 @@ unevaluatedProperties: false
 examples:
   - |
     dma-controller@3000000 {
-      compatible = "sifive,fu540-c000-pdma";
+      compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>, <30>;
       #dma-cells = <1>;
     };
-- 
2.35.1

