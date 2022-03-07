Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76364CF14E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiCGFpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiCGFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:45:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E54B1E8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:44:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cx5so12334885pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 21:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBjY8RLSr4Wf/RqUjGw1XSvLuEMUT8Kxzt7XGrbbTA4=;
        b=lAIL2WxrAiBazAGJWqjUTrqx5il2WIviCluimAC8nzelpPqBr/fFyB0UwfzXwAL4My
         qSBZbEpYxq1IMDHdPb8L17LXv6GHdnT4Dr9u1+hE/mspifd4KxifeLe8Yq619itW3q6s
         4A3GNykAGj2/dcfQ+9RyzD0Rc5gQiBU9yrDLzdDglsTk3oGFxBPdGKkSqfNe6sdzZkd7
         HjK1N8J8ZkzD3YyzWtGJl9ltWtt7FvKPJtJFJWxYwYBq5Cm+Vw6+5KatCLZu/D3zL2OA
         Ig0VCxU4YELlJ9oowPlOCY6MhCU/cvHLbgVRGHymaOQ60JsCKegvKYNZrqTLHS1rmwcX
         4daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBjY8RLSr4Wf/RqUjGw1XSvLuEMUT8Kxzt7XGrbbTA4=;
        b=rc7Po5JiY2FKckzCSxyyy7BZWfQPm8ep/fVZhNKCJxwKu7gGvW5V7ykKalms6/TBtb
         JavDoF3YKQtvIwX+j/9EPGOuJxkEVzN+/wSJThtUFBSupx2snujGsBayvbRAPYj0E/dw
         wLqM9rwKq/dgrzLkQUeefS9NS0K/d6orUaLiR9QH0phKLfiQjnE1PSiFr8JrU5JRM9DI
         tLxtB4vkjcRf9yJCt9HZdSSNVEB7vLpY7L05u/ybQqoIhhb4wWQzNYQIuPTg3PuRi27m
         Cz7UApG8nc++fd4kjMfjupTM2lyYAk2eL11y0GqAYMz0SCf2jsLIde0NbXI1Tf64x0HU
         bHIA==
X-Gm-Message-State: AOAM533JlT5Om/RpwgeePXKtKplsv4oiJjNLvuhTS34gG5WgrXiHaeIn
        Fh0feHV2UAUwGo7yqJWV9VW/pg==
X-Google-Smtp-Source: ABdhPJxVlNJdV8XimvQFNcl99mDUTWcRveCL2gfbpROyNetl5A3n1pSHAfO43mCGHS6p1SKXEyj0XQ==
X-Received: by 2002:a17:903:2346:b0:151:60f4:84ee with SMTP id c6-20020a170903234600b0015160f484eemr10817143plh.27.1646631875488;
        Sun, 06 Mar 2022 21:44:35 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id k1-20020a056a00168100b004e0e45a39c6sm14447385pfc.181.2022.03.06.21.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:44:34 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/3] dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and modify compatible
Date:   Mon,  7 Mar 2022 13:44:24 +0800
Message-Id: <1e75ad35b7d1fb6156781bf9c545e1f084c43a1e.1646631717.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646631717.git.zong.li@sifive.com>
References: <cover.1646631717.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 75ad898c59bc..92f410f54d72 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -25,7 +25,15 @@ description: |
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
@@ -34,6 +42,12 @@ properties:
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
 
@@ -48,8 +62,9 @@ additionalProperties: false
 examples:
   - |
     dma@3000000 {
-      compatible = "sifive,fu540-c000-pdma";
+      compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>, <30>;
       #dma-cells = <1>;
     };
-- 
2.31.1

