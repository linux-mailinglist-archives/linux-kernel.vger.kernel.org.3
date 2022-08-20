Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB859B032
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiHTT6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiHTT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053481D0E4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x15so6150289pfp.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=3GkIT6pSt7j0OC2fKZRZbaBy0BVVdg7j70Ydfc3O5b0=;
        b=bGZx4rO7iu3DSa6SUqWyU3AuyXoBOtB9RgvJWW4H1B9dvgQ/r1rM4mM0xV3R5mcev7
         mJWtjla2wR9d0t8D8f9OrVhS3F2mNFPyJJtfACwiTrunpeDnWDvH+EcgqA+Js7z9KHzg
         nHc5OiuxSnY/CB2LJZCYxz7/k+3eOk+xf7wrjXFjMtfeALLcKJJcnfcC8wyMTg/hgcsl
         x7NnFn0h7Uq0GGC2JtewVlcLt3qhaQ1v0l2Qwvx9dwT+Lt3DY/g9fCl/qS5syw6vW6Mc
         CGHZ9skfauP7fKd1eGdb0xGHfQgOYMndDXV0kjoUwkOz4GmQEVHnH3D+4u7JhvVnPwR8
         mvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=3GkIT6pSt7j0OC2fKZRZbaBy0BVVdg7j70Ydfc3O5b0=;
        b=sYlpDIFHJIJ1NPG974GqLuqNDANSq3RQJu7riuEXgkmz9q8GmvND3IreDg5KmlJOd4
         8W5Yjt9uwLeyt/bPyZ5b141CCiGV1q+uT5t1VufxmXQH4D/A+pXkDMBYSvf9CgpxwGYT
         rui6zbFaHy1D3PYetfzvvXBX9fJFxZYIQy3rddEpM+D53jCOfHLpjKJBMl/owpOV791F
         5WBB3BX2j1Jwis+P190UrZ29yv1eYRR8x4gymGhm8cH90MHOzuHNI6tnlXyhqrVgAroA
         pwvbK9wjCdtxZgdFSMhEtFOZVL5oICRojd2LE0GNtCxgyMt1Rpor5oSg96sxje2ORONx
         wobQ==
X-Gm-Message-State: ACgBeo2S4scWuzCSO8IJUZ+tlpb4YoWUT2LktgBlkFqFbTBH2aWogT9f
        9YZP46uBcMFWLQKBijuyajWI3w==
X-Google-Smtp-Source: AA6agR4gL6gKO9pMS9x34t0MspxWRnznEGmVYRa1mMugNaPpAaTZTz3beSLd1W5Qt7qFW3uWZ1ezrw==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr14080753pfb.49.1661025503484;
        Sat, 20 Aug 2022 12:58:23 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:22 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
Date:   Sat, 20 Aug 2022 12:57:37 -0700
Message-Id: <20220820195750.70861-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 37c3c272407d..403d6416f7ac 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,15 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amd,pensando-elba-spi
+    then:
+      required:
+        - amd,pensando-elba-syscon
 
 properties:
   compatible:
@@ -75,6 +84,8 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
 
   reg:
     minItems: 1
-- 
2.17.1

