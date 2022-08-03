Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD658927A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiHCSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiHCSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:54:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561D05A3FD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:54:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n20-20020a05600c3b9400b003a4f2261a7eso1269795wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2lJBh4Ldu3F8w5c1LMKvoZtYAyOssPreAlBa9+g7iEA=;
        b=dom732Z2/wWmOB2Oe7aUPh3+FN7DKbGHI5cMnWl6l/6P88jZVqd8ezgNsFTQkK5Mmo
         YGhRQprYqaRuE5AEn6sfByJd/GLBmAUq+A4V2A5Ohvphx5ICHDn1FfuneIa1McshBZRg
         8yApp60TaeeKKEg0yABjRv5ZIlPGfocQqGHMCpU0guEW5v0ZfQqAqgRSowblkDyeDZ5V
         4pBwsMADhMXlkHlP1ONCww9nyvZaG4zuiYV8xl6c5uqxhig8SSbZ00unbf3h5r/1pSsS
         gt4bn/a01WXUeXy1IxUa0bXxzOVHwDm7IdXnsGRlohOfAt+nULdNCACHbw8dcAKYsxoe
         Cs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2lJBh4Ldu3F8w5c1LMKvoZtYAyOssPreAlBa9+g7iEA=;
        b=ngowhWduKMC8a7PKqU0HHlIt5EAzevHFPC/k+lCBjY9HporusZ85LgkEhZlLfaZ+IH
         ZDGtjuqTUVh5TqKZ2hkxMPNOGtYU7jMOhfuorCxZnSdEZ6STYL0fEhkMmuFDPY7QDdZ+
         vdoA2d3AawuipzXPuqgZie2lx4hF+/7+ya5b7EVuNuMOfdX8Pc0lfHsWl9YhX/H5uFri
         q3Iyqg1mVqAq4FPFt2fImBTXFJExyqJ5X8GwRgxPya/0nayav5bdQG549kUJyNI4+gja
         AvHIRGkVrnAUclRzc+JVC8RkcvVf9acW0gN23Nfgjbpu/dQoWvHoENDxSiW/R4KGbl8p
         jU3w==
X-Gm-Message-State: ACgBeo2fnphT9tQRNIt+LV4VuunGYFHgVeC5dvyg8mDc75tNkuOm5RvJ
        waBgJC3WK3Vtc9UJdqc8UWmV9A==
X-Google-Smtp-Source: AA6agR4rpp5noOjscreSCj+sQNOg/JpEG73E1SLU1E2Xa96eqCLevZ7d0xfZ5wfMiISECAsS5loO+Q==
X-Received: by 2002:a05:600c:4a13:b0:3a5:835:c680 with SMTP id c19-20020a05600c4a1300b003a50835c680mr19729wmp.101.1659552882921;
        Wed, 03 Aug 2022 11:54:42 -0700 (PDT)
Received: from henark71.. ([93.107.66.220])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003a2f6367049sm3545072wms.48.2022.08.03.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:54:42 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atul Khare <atulkhare@rivosinc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: riscv: fix SiFive l2-cache's cache-sets
Date:   Wed,  3 Aug 2022 19:54:00 +0100
Message-Id: <20220803185359.942928-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Fix device tree schema validation error messages for the SiFive
Unmatched: ' cache-sets:0:0: 1024 was expected'.

The existing bindings allow for just 1024 cache-sets but the fu740 on
Unmatched the has 2048 cache-sets. The ISA itself permits any arbitrary
power of two, however this is not supported by dt-schema. The RTL for
the IP, to which the number of cache-sets is a tunable parameter, has
been released publicly so speculatively adding a small number of
"reasonable" values seems unwise also.

Instead, as the binding only supports two distinct controllers: add 2048
and explicitly lock it to the fu740's l2 cache while limiting 1024 to
the l2 cache on the fu540.

Fixes: af951c3a113b ("dt-bindings: riscv: Update l2 cache DT documentation to add support for SiFive FU740")
Reported-by: Atul Khare <atulkhare@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I split this off from the existing series as there is no dependancy
between this cache change and the gpio patch. The prior series can
be found at:
https://lore.kernel.org/all/20220726170725.3245278-2-mail@conchuod.ie/
---
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index e2d330bd4608..69cdab18d629 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -46,7 +46,7 @@ properties:
     const: 2
 
   cache-sets:
-    const: 1024
+    enum: [1024, 2048]
 
   cache-size:
     const: 2097152
@@ -84,6 +84,8 @@ then:
       description: |
         Must contain entries for DirError, DataError and DataFail signals.
       maxItems: 3
+    cache-sets:
+      const: 1024
 
 else:
   properties:
@@ -91,6 +93,8 @@ else:
       description: |
         Must contain entries for DirError, DataError, DataFail, DirFail signals.
       minItems: 4
+    cache-sets:
+      const: 2048
 
 additionalProperties: false
 
-- 
2.37.1

