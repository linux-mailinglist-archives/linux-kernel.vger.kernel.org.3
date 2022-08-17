Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8959778F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiHQUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbiHQUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:06:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD85A2C7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:06:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u14so2864702wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1R6UrF0Wsbj6EmcSlPWRzTAwonFDames2nGAVyANWlQ=;
        b=AeJIiHm9h3I/Eov20f5hm9jFdNKZoOB4Jm6+CCfujHehef2vYBlAHYHSx5/YrlWtGy
         uwOBvhI96+/wdxcUYt/7toPQmj4t0R7CoZ7AyNypy40Yp4pB0wOibbFOUSqHZ/xHuZY+
         a5AbbRHn5YtRY0D0gKPtmjm/2hkhkJrpqVZ72vi2GO26mLW9PDvv9Bybx4U6HbVZQ509
         m8j1y5HSVzo5McL0PRSHDvNJfP4bGBEOmQ7YHJDmQ4AVZxCcIjWIUTSURamn6zVm0hYx
         tZIvcSQZwjZOSNVtG4bAxh1Ql8CBw+SvPUU8vlL66yaGZadxHsoKbpUfyorMa/vTna1L
         QXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1R6UrF0Wsbj6EmcSlPWRzTAwonFDames2nGAVyANWlQ=;
        b=khuJnxHYIxVHWmsNbZS4Gq9g45gonCGvlrxep+GgDBZLI7/kw4SAt7zb7xted6pW6F
         JW/aWgJPFgMpY63SLUXaMDch3ueAQSjiJYrPuGjUbPiqNsyJyha9SHulpypUqgDslxVE
         4LKoMOLXB0NvTbxisNTD7edhGQsw1Yi60vijedX3pITQXxDdBmN8STJa2UApCGyqbMvk
         CNFGxWciT3FDFQhPDJVt0RfWt5QS95oI0/nNArdpvZIhinktbO8gQBS7yEt+RNtdA4x5
         y9DFDODmxBb3M6VMJvl3gMzTDw7Q1X8XnWRz8UAeuEcFEKpnR11YUTFnyQ04zgFtrs93
         bpkQ==
X-Gm-Message-State: ACgBeo3rOnvNDHx5Qityt3AFrHCg/fcqW1zSWcBRuxfvfuLN0iUGZ1Sx
        tEBFK7uErtBZwjyUAMa5/Fclig==
X-Google-Smtp-Source: AA6agR5ISPAA2r8H4343y7nQ1xvi4vK0fSr9VzDNPaY5Bb1ElOubBSAalLLrbPfbH95opdbBSj6WkQ==
X-Received: by 2002:a5d:67c7:0:b0:225:210b:21a4 with SMTP id n7-20020a5d67c7000000b00225210b21a4mr3350305wrw.677.1660766760597;
        Wed, 17 Aug 2022 13:06:00 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a531c7aa66sm3400883wma.1.2022.08.17.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:05:59 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: timer: sifive,clint: add legacy riscv compatible
Date:   Wed, 17 Aug 2022 21:05:25 +0100
Message-Id: <20220817200531.988850-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817200531.988850-1-mail@conchuod.ie>
References: <20220817200531.988850-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

While "real" hardware might not use the compatible string "riscv,clint0"
it is present in the driver & QEMU uses it for automatically generated
virt machine dtbs. To avoid dt-validate problems with QEMU produced
dtbs, such as the following, add it to the binding.

riscv-virt.dtb: clint@2000000: compatible:0: 'sifive,clint0' is not one of ['sifive,fu540-c000-clint', 'starfive,jh7100-clint', 'canaan,k210-clint']

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index e64f46339079..bbad24165837 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -22,12 +22,18 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-clint
-          - starfive,jh7100-clint
-          - canaan,k210-clint
-      - const: sifive,clint0
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-clint
+              - starfive,jh7100-clint
+              - canaan,k210-clint
+          - const: sifive,clint0
+      - items:
+          - const: sifive,clint0
+          - const: riscv,clint0
+        deprecated: true
+        description: For the QEMU virt machine only
 
     description:
       Should be "<vendor>,<chip>-clint" and "sifive,clint<version>".
-- 
2.37.1

