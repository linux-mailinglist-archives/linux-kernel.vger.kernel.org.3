Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35E59B027
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiHTT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHTT6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEBE237DF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso7744593pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=Klg3A3HrC6BDodvLklTbiYx2mxjckpW5j4Mk64dlIWo=;
        b=hefQx/OIX0sYRllNPCZM0yXrau/nMHUh/bvsXdAyXn0d3FP222WoJVQJIMJ9DWbMuC
         VEX3mFiQ7wG7qniOyPpsMiZ3/q8xJWjdxNq+OHaSzsljTupz0Rn+JbpllG9einHtTU0V
         Ket+IcgRpFY22zlzd5sNyOWusCQpHHNwEXTzMfY5XBfCc0alr4Cn3mart9hkKexdIwDX
         98rqXg8WE8WMahsHPtTqB5V1qUmepBd4CrFGwdBogFoGUFJiwJS+Y1fZBJIjUqP9mGVz
         wmpEhqScwmJ56DIpXxot97Zly+yy3w6kAvlY0QUkMKt3RtkhPar2YtBfFF3ZP7HWBBXu
         Dcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Klg3A3HrC6BDodvLklTbiYx2mxjckpW5j4Mk64dlIWo=;
        b=JOErETu0JyPgkIpXLHzEQnet5PdBaJdkqADHLVRtnOdXSYjhVeqV/AKx0Sfg/2HVsT
         qekqfY2ce1B8K3+rbowDE+8yXIxqvYceGsFNlt40ypptNqsPdyCvEsQMk5vq0aD8zML+
         NEb2DlCn7ZMD6jLrbn/cbanYKXqIrNXETtpeLryIyxSnGire/oqs2e9rvjhxK/xJucke
         hAYgrU4BQpdj2WgX+qN9nKAV0krriLppEllakppHmLAoVJs7coiVTIXijlBx8084M4Db
         gycv3o2u0HnX4RlGZJbOUVwdnwAFbA8FuoaTSiIj60NGpNpD/a8623fENUtGERDJ0ne/
         ygiw==
X-Gm-Message-State: ACgBeo2YehahagiRXlHqKVyMeBsIXVkgV0zC6SoEHFZUNZ2VVRr8PnSQ
        0a9QqhnX2FjqZ7uvT3JaMYOoCA==
X-Google-Smtp-Source: AA6agR6wA+vcuG6mkLW7/jrTeHDP0/xxGtqSMWUBkf1+CqT8XQBAs5bf9E7qrUoDojtbzAxKdPZr3g==
X-Received: by 2002:a17:902:ec8e:b0:16d:d156:2bf1 with SMTP id x14-20020a170902ec8e00b0016dd1562bf1mr12882035plg.17.1661025512392;
        Sat, 20 Aug 2022 12:58:32 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:30 -0700 (PDT)
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
Subject: [PATCH v6 07/17] dt-bindings: reset: amd,pensando-elbasr-reset: Add AMD Pensando SR Reset Controller bindings
Date:   Sat, 20 Aug 2022 12:57:40 -0700
Message-Id: <20220820195750.70861-8-brad@pensando.io>
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

Document bindings for AMD Pensando Elba SR Reset Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../reset/amd,pensando-elbasr-reset.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
new file mode 100644
index 000000000000..0fdc6cc5ecdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Reset Controller
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+description: |
+  AMD Pensando Elba SoC reset controller driver which supports a resource
+  controller connected to the Elba SoC over a SPI bus.  The Elba reset
+  controller must be defined as a child node of the Elba SPI bus
+  chip-select 0 node.
+
+properties:
+  compatible:
+    const: amd,pensando-elbasr-reset
+
+  reg:
+    const: 0
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        spi@0 {
+            compatible = "amd,pensando-elbasr";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-max-frequency = <12000000>;
+
+            rstc: reset-controller@0 {
+                compatible = "amd,pensando-elbasr-reset";
+                reg = <0>;
+                #reset-cells = <1>;
+            };
+        };
+    };
+
+...
-- 
2.17.1

