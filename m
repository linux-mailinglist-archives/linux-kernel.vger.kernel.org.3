Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F559B00E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiHTT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHTT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF6165AB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso10446144pjl.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=NTXAxyQL3waGEJkz3JFJl11ykh+V7CnflPyyCrkRmVo=;
        b=aDa+MkMjVsjqpzMdLGR6xZaO83PwMwIyrZk1GxVo53E9S8vjB9rlObTewiew3FvTg9
         PsmXG+TvLB+kgfj/mcJ2XaywU1rNXrEAUj3nPhpqmZ5YSLfTolGBVp2+oxHN3xxXv0V6
         QyCuqJhpn2pRir62TbQzOyzsahTjKTvVsI2BqP3rWHEB8nifJPHLG1boGRd10ty1mUKH
         iqj6LJQH+pu00fdELeJ+itJKXkM2mmWwl3xm2HTPAgoHIacTVprXbH+2jD1X+/PhvKv1
         1c207Zornyjs8wquci/ZHDxlHF5mWGFuKOFM5SSeE5m7llxoQKCNdgE0dsrSJ+oasP6n
         Xz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=NTXAxyQL3waGEJkz3JFJl11ykh+V7CnflPyyCrkRmVo=;
        b=eTu6A1WOBak49C/0wg5bxymKIt7eKZ/fi0qa4GioBhVe9p2UyCCqTsMMJTIPtC599F
         hrN0TLFRiRCFywHZHZvrsxHE4xYCsPDhtkAWIDuufo3CLzV9MdjVQnVJJzWZwAJbocli
         VYA9GhfaJmyQc8zYAAbvuOuqChbP8islNsq18X3EIaxQ04rIajgZ7sYxvBC+QBZmVPuY
         nHKwIoNZeRYeoV4FBYrE4GwTEv3AlUjKXZc6fFPtp3LB+MG8UtbC2trWcdWpYO+p8hQs
         EGqL5A0V+VgXxSTXevz1Gxa4Kh/R4tCHV57vlQRd8n9kGLKScUnCjVF6gmoSrgFTUWbv
         Zs7Q==
X-Gm-Message-State: ACgBeo2fQO++V4wqt+yZ8KHuj2OfJyrMDW5c9t6kjgVpQzX+vrYLjIsT
        l2AECgwZOQeWrvk7/cFOld6i4Q==
X-Google-Smtp-Source: AA6agR4lIy2KV6bT/mtcoUBCfdxboF9vk9E8rQOlcdA7QKnG74sjDawFROrHf2Z3OgHjdJ4lYC890g==
X-Received: by 2002:a17:902:70c7:b0:170:9030:8219 with SMTP id l7-20020a17090270c700b0017090308219mr13177138plt.163.1661025498268;
        Sat, 20 Aug 2022 12:58:18 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:17 -0700 (PDT)
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
Subject: [PATCH v6 02/17] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Sat, 20 Aug 2022 12:57:35 -0700
Message-Id: <20220820195750.70861-3-brad@pensando.io>
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

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 4207fed62dfe..964b610eeef2 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -17,12 +17,14 @@ properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -118,6 +120,15 @@ required:
   - interrupts
   - clocks
 
+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

