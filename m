Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEDD4F0409
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356725AbiDBOji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356632AbiDBOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A961834C6;
        Sat,  2 Apr 2022 07:36:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c10so11311491ejs.13;
        Sat, 02 Apr 2022 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5SAjUnYFQM9w8TOLgtiKBk9tPwBKnHPcAhw0POhc3g=;
        b=b+K26tGd8dmMu+pIRWuwIMbEAih1Gm5KNPQz4TaxkahLVAIXTDQOYilQfs8RntMuHl
         z1o/m88jL57/PMesvniiC8uNJH9XM91PY50+Fe6sr9+CKQM6os9BZO+0TpyKt16jRTTD
         ViQt0MTtubQNJJf2rVHYmbgOIQxVgCbd4upIBjEWLKJNuxtrXiVkFucspBDYOq46Nmkg
         puOsAJgpI3321euHAjQ3Twa2TebnTGPh8WPtifqk9tP5a3En2kcYWMnA8BE7Z/mtCPer
         xADC7oCqHspz098E2cckQ6A2UFWwMhNgZvfFbeVvQba6yXlE4y6EZFiGjPf10ntrc4Cv
         p4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5SAjUnYFQM9w8TOLgtiKBk9tPwBKnHPcAhw0POhc3g=;
        b=OqmZyrbq3DWMhXj39HV7Ar5X7wknfE9Hewk4q6cwZDPwNmvIr8p4IovV1uUvop3xlS
         6uDwCqvPT4SQuD8ymgc+fjJhaqFYid/aVulJiLTR4l4gn/RwiTEffk5dtAa8T7BtTSdJ
         0jhlb7S4YYvcZHM0QZkugbvi/C7TlLT9YmbJHd1HsLhQwACtBzfwsEfkPpTQf2AUzml6
         ufNzEAbSm7Mhu8COoIwBSibQ2G6qQqWcdkj0lGt7WRF7TBQgMdxObQKumZk2ClrcM+je
         iJaPCS8FEpK2IWhDP2gPG1svJY1cqxIIfp+sOrWp5I7icxWquMpiwpZkGUNP2rMwoOaN
         Y7tQ==
X-Gm-Message-State: AOAM531bduAgPsjGcnOs0+QdrZTgIOFQJYB7WqCeIGWNcsPLv69IkSZV
        lctR4J9xH49sKQl1GFh8T7c=
X-Google-Smtp-Source: ABdhPJxKiB5huzHM1gmRf9jZL2520dkuPbe0wyAiByFM551Ipm7AyngjKLm0atJYVdkKEmHblocIHg==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr4195430ejw.282.1648910218049;
        Sat, 02 Apr 2022 07:36:58 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:57 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/16] dt-bindings: clock: fix some conversion clock issues for rockchip,rk3399-cru.yaml
Date:   Sat,  2 Apr 2022 16:36:36 +0200
Message-Id: <20220402143636.15222-17-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
References: <20220402143636.15222-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the YAML conversion somehow "assigned-xxx" properties where added.
If a proper clock is added to the cru node these properties are no longer
needed, so removed them.

With the conversion of rockchip,rk3399-cru.txt a table with external clocks
was copied. Include these clocks into the schema.

Add clocks and clocks-names to example and make them a requirement.
Reorder/restyle so that this file is line with the other Rockchip
CRU bindings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3399-cru.yaml   | 55 ++++++++++---------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index e91147c84..4574727da 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -20,15 +20,8 @@ description: |
   used in device tree sources. Similar macros exist for the reset sources in
   these files.
   There are several clocks that are generated outside the SoC. It is expected
-  that they are defined using standard clock bindings with following
-  clock-output-names:
-    - "xin24m" - crystal input - required,
-    - "xin32k" - rtc clock - optional,
-    - "clkin_gmac" - external GMAC clock - optional,
-    - "clkin_i2s" - external I2S clock - optional,
-    - "pclkin_cif" - external ISP clock - optional,
-    - "clk_usbphy0_480m" - output clock of the pll in the usbphy0
-    - "clk_usbphy1_480m" - output clock of the pll in the usbphy1
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
 
 properties:
   compatible:
@@ -39,37 +32,41 @@ properties:
   reg:
     maxItems: 1
 
-  "#clock-cells":
-    const: 1
-
-  "#reset-cells":
-    const: 1
-
   clocks:
     minItems: 1
+    maxItems: 7
 
-  assigned-clocks:
-    minItems: 1
-    maxItems: 64
-
-  assigned-clock-parents:
+  clock-names:
     minItems: 1
-    maxItems: 64
-
-  assigned-clock-rates:
-    minItems: 1
-    maxItems: 64
+    maxItems: 7
+    items:
+      enum:
+        - xin24m
+        - xin32k
+        - clkin_gmac
+        - clkin_i2s
+        - clk_usbphy0_480m
+        - clk_usbphy1_480m
+        - pclkin_cif
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: >
-      phandle to the syscon managing the "general register files". It is used
+    description:
+      Phandle to the syscon managing the "general register files". It is used
       for GRF muxes, if missing any muxes present in the GRF will not be
       available.
 
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - "#clock-cells"
   - "#reset-cells"
 
@@ -80,6 +77,8 @@ examples:
     pmucru: clock-controller@ff750000 {
       compatible = "rockchip,rk3399-pmucru";
       reg = <0xff750000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
       #clock-cells = <1>;
       #reset-cells = <1>;
     };
@@ -87,6 +86,8 @@ examples:
     cru: clock-controller@ff760000 {
       compatible = "rockchip,rk3399-cru";
       reg = <0xff760000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
       #clock-cells = <1>;
       #reset-cells = <1>;
     };
-- 
2.20.1

