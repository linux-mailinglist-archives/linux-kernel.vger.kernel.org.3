Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0459EC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiHWThr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiHWThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:37:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CF98367
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:33:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so10077742wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SXjC+1eAipiwLVckozeddO7uqjToKvtGjqOQeotcMjA=;
        b=KbX0skZMzo1dHORnO1cN91HQwYl5fklrhtHhR2L7O0pjBR2WQcmbC6+6QCsRSVABqj
         suGNDT5zgBvkiN83Nia7Fxsj/GUe4ZrlfG1UmMEwbcLoXEmvZ6cUjQlSkDHA5N85GJ7D
         MXdfh/3k36Gh681xIxzhAcU5D3VniKUKc7tEsODBfWdS6vC/28mqYdr0qmBYnIIijOqQ
         6o4C9Z6SGB/f+JumjLGTtaD8bu4/rwOJUdJ+qMjZPi23lOHvE9w6+/bt9ug4xdsaXDcL
         0nTVKQhWqBAP3808O62VC5jQ8sGAcXbvQgO/aibQ4HwTyaZ5rV1mI4kilaKf0RQQhBgU
         q44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SXjC+1eAipiwLVckozeddO7uqjToKvtGjqOQeotcMjA=;
        b=YcH53LzPbXfamfv9InWZp01u72GbF7M/d5vIrlDBDj8LNDEQlbVGpvBir1qdJXtRKs
         Cw0gGntptrnkExpU9nkAxsQsVFfd3JohjZms00YW9mF/tsKRYKiFwF5DeBE79ZzLFhtM
         IZpsylKB2ndl1Gl84pL1miHDHoDZ3dslzEBym42heB3eDO2jB+ZP27zT1LL8vptOxnxh
         ksiSLbODbqmVKB/zA+dYdWblQEkydr7o3mINCswAAQj7N3L12MWO93OeoyXSOUGxF9QG
         yAP+t2cwGrclrfCsg/AdO/gnndc6X9K/BFfWJvDtdDktzmD9gjdNs6BhanD8f9cskCD7
         gOQA==
X-Gm-Message-State: ACgBeo3Gy+4duOMU+hHKh8c20fTXk1Fqpz2ZzAs8EOeb6d/N7j7+R977
        UfJ5So3IKLBuWyXxtIsEYlyg5Q==
X-Google-Smtp-Source: AA6agR5q5Ekkbe1X55VNXuzYGucNAP21vgIbfd9u4MP8ILX9K+hq65/YrNIaCt5ZG3XgVMMwVoDaHA==
X-Received: by 2002:a05:600c:2c47:b0:3a6:4623:4ccf with SMTP id r7-20020a05600c2c4700b003a646234ccfmr3142126wmg.85.1661279636305;
        Tue, 23 Aug 2022 11:33:56 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003a5fcae64d4sm19396556wms.29.2022.08.23.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:33:55 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
Date:   Tue, 23 Aug 2022 19:33:18 +0100
Message-Id: <20220823183319.3314940-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823183319.3314940-1-mail@conchuod.ie>
References: <20220823183319.3314940-1-mail@conchuod.ie>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

