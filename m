Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4758AE2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiHEQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiHEQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:29:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395201116B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:29:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso4199151wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XYwLdkCxi/i5yAItJxUUyXuQNOjzCE2mt/Ff4B2y6Cs=;
        b=D3jxpRS5zNs90vY2YI73WI0Sebg+PIYbtdcLdZdVJEXt3MBup6LCK2JIBzVVc9luf/
         y+mycZVPceDjrWQVGmfZ+sxZXcbWaL3763eF+Q+DVIutHNzi0RLCew0mxmG7/kIfLpZ7
         vd2UHhO6bKZq2M2BwoTDjQ3+TgKGoGMYtrEJ7e6B1dAuq64Hny8AXJO4zU7fKCqwp9Y4
         XqNFWxfQxCabjC6uSb/6FW+5T/zzzug2dsC9ovC7y6kN2H0bGhe/mof5pv9jfOu9lrLj
         Jx8RXO1fH6Lhe+YFFJEXwg8WmUhG2kUGCItPfw3nN1RjSrrl4qMrjHweVP2pn41EcyL1
         yILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XYwLdkCxi/i5yAItJxUUyXuQNOjzCE2mt/Ff4B2y6Cs=;
        b=tf0bKVjv4nNfNHjuYV8Zry3l5mD9r1UQ/ypFxTxTrbUG6cJRZ9TX8nnD5i6YZcGjyg
         RiuCsA42pgznMTn9gsk2X3OWOkThIAvp/Dh3ZM8VjbpqcAbuJ1LYUSUbR9fA4t9Rjj3/
         R0Nt9I4pl7ABZeyp6TgTbVAfnUmk09lRoNb68xHmoDY23BM4msXClXwThH0ARcDmhpMP
         h8vr928C7MIomPvLHbK3RZLOtduqGJnThXB0OL3Z8LnQ0M+/pmZPkakfbZdVUZJ75mA6
         TDjS9VJDAnnLESbz6QDeqGjIWTS07Qp9KWQRYvBn4g0tuRvEziWZ499Do0Fzxl5q8Eiu
         zvGg==
X-Gm-Message-State: ACgBeo1JVvOzGlyaK92SWFsdc0ikP7IBiOnvfRXasTs078OASK3nmzhG
        dzGQpVFrkmoxJTjBSvZrjkdq8g==
X-Google-Smtp-Source: AA6agR72z7gXpSrSt4MlK0Qii9Fz4lxO9+YCgAXzA44zWKFpX88wGi7wvDKIHf1SjUomkA4m7/Xc+g==
X-Received: by 2002:a05:600c:3d8d:b0:3a3:15a8:a8e1 with SMTP id bi13-20020a05600c3d8d00b003a315a8a8e1mr5151407wmb.167.1659716945693;
        Fri, 05 Aug 2022 09:29:05 -0700 (PDT)
Received: from henark71.. ([93.107.66.220])
        by smtp.gmail.com with ESMTPSA id b10-20020a056000054a00b00220633d96f2sm5210086wrf.72.2022.08.05.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:29:05 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/3] dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
Date:   Fri,  5 Aug 2022 17:28:44 +0100
Message-Id: <20220805162844.1554247-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805162844.1554247-1-mail@conchuod.ie>
References: <20220805162844.1554247-1-mail@conchuod.ie>
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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 92e0f8c3eff2..eb07c4f1a201 100644
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
+        description: For legacy systems & the qemu virt machine only
 
   reg:
     maxItems: 1
-- 
2.37.1

