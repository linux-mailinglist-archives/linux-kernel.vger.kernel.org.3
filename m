Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8725977A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiHQUMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbiHQUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6666A4B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id s23so7153266wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vuO3cD7vHfOoM26qaFlIa3/qXvWH4JaTB3axSBEJPBw=;
        b=QNqHEQCbHfRVGS+tAMiAeZUZwHbBaHSl0+l3elr57UhAo9n9y5kVxNnKfpGR3/bFaK
         +0au1CDmSpQEpc+SU4gk9DT+bLflPHiKU7I8q8oQr7K+iXIJMVRPppzrl+EdG1CICueI
         mETGyBRKdR/0jUMOQefFZwBRXS0F6IVfTdGwBMcn+/W4tOLw5o3k++yjoq0kYu6PUOu8
         zPeHvkIN/+xOD7MPCo5mJihWLZw9Ayb2dZz9D3SYCFb7mSsm+ctbY/v+37Sk2BkryeRN
         +keBV6AYTGq3C5eSUKwO2Ih+l7MLpNlzPwmWLNs+G4q0F/Ce1V4BLVEMj+kApmgnT9U8
         jwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vuO3cD7vHfOoM26qaFlIa3/qXvWH4JaTB3axSBEJPBw=;
        b=7XhQVlrMXqnpPFvl60lfO/k9H4JW3Ak16q5XCjsMlkPUgBuIdoSS8dPPdxLMnqhuWJ
         BSARKZz2RpBfEtgHh7fjbTkY8yFrE/6e+S1wqyJvQXtdADzU+H5l+zGtw4en/SgA+w34
         jlVy0tu2CLjD905Qo5+69QsSaff6WrtEe+6jaq5+klpmE9nJcMH6t7c9f6j5tzI9rsDE
         7a5+25JZP4wCN6gZ/D/S8qXA50yH7GvsVKm4VyJtsdg4eWjVULvzSnx1jac7NtuMuGg2
         z11Rd07f55RtqsCP42W5dIkOdnm/TGJ9qXoIuM6bfS25sMglQUEzKXiuS33SZHuHSlZu
         bFiw==
X-Gm-Message-State: ACgBeo2JVSitQNgTqWcIpamjK0HayL+9FrNpVmrTk/bpv5QVSAHoq03l
        hSsTIKBgurIhQ1xehQ6v3HWNMg==
X-Google-Smtp-Source: AA6agR4uxolucIHZMbESqZVNmKY0bzNzoYEESejDuTjDSWvejaLJaV19DGDusJCVom1LcN9XAiM6Ow==
X-Received: by 2002:a1c:7407:0:b0:3a5:b81b:c5c5 with SMTP id p7-20020a1c7407000000b003a5b81bc5c5mr3038616wmc.144.1660767160200;
        Wed, 17 Aug 2022 13:12:40 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003a5dfd7e9eesm3029371wmq.44.2022.08.17.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:12:39 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
Date:   Wed, 17 Aug 2022 21:12:11 +0100
Message-Id: <20220817201212.990712-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817201212.990712-1-mail@conchuod.ie>
References: <20220817201212.990712-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

While "real" hardware might not use the compatible string "riscv,plic0"
it is present in the driver & QEMU uses it for automatically generated
virt machine dtbs. To avoid dt-validate problems with QEMU produced
dtbs, such as the following, add it to the binding.

riscv-virt.dtb: plic@c000000: compatible: 'oneOf' conditional failed, one must be fixed:
        'sifive,plic-1.0.0' is not one of ['sifive,fu540-c000-plic', 'starfive,jh7100-plic', 'canaan,k210-plic']
        'sifive,plic-1.0.0' is not one of ['allwinner,sun20i-d1-plic']
        'sifive,plic-1.0.0' was expected
        'thead,c900-plic' was expected
riscv-virt.dtb: plic@c000000: '#address-cells' is a required property

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 92e0f8c3eff2..99e01f4d0a69 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -66,6 +66,11 @@ properties:
           - enum:
               - allwinner,sun20i-d1-plic
           - const: thead,c900-plic
+      - items:
+          - const: sifive,plic-1.0.0
+          - const: riscv,plic0
+        deprecated: true
+        description: For the QEMU virt machine only
 
   reg:
     maxItems: 1
-- 
2.37.1

