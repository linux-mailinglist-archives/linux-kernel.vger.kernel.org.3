Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75C4E6BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357124AbiCYBI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiCYBI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:08:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B957FB6E41;
        Thu, 24 Mar 2022 18:06:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c11so5187159pgu.11;
        Thu, 24 Mar 2022 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=99ip5yM/eXMtw/bhYIEGY/geBI8pRphT9RnitiSW3ck=;
        b=pD++ADWNMuXubx1OgdCjv26q8P743r69bPPzSjwH7wT1iIhqZ+1wQI6I57O7dYk6BH
         lP1KK42t+KOc7CpWp2yccvsawvSq0ryDGMSGDgdiomPRKR4oAuVKgNNEjMXkUqf7p+KG
         I34LpGmFANgt5PZyTdWbb5Ky7+CVCnamcn0L82bHB3ULbzzQmFuRrc8sSBaMWogwfbOn
         cODzygqlC+TwIUaUuR4o/9IyWX4TizyarhQDSNvx/pXLcOZDbyEbXwQ6wz8jY9mcPXax
         8x6gjXZc9VaKshPPGE31J4qkkJzuoHEGWM/NT/cDS+B9C0WwHlJhILPdxnKRkm9HBtHY
         9SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=99ip5yM/eXMtw/bhYIEGY/geBI8pRphT9RnitiSW3ck=;
        b=CqPXuKSxYCzQHnYimI8DmHFl1TSJIHNqXUsMH54J7mTCKddCEEtmjx8xTW/4feSWIw
         9EYBpamgYFS6e59MFm0tXlnJGS0IGCvw4Hq07tDwJDmyVcehIEKVO9ESC4ucB6P9NOyZ
         0czqG9xanwuSuQ1K+Didni85GcO0N9NXRI15FXdvMvSiZqCpZfTInD9zGQK6jUPvX60A
         lkoS2O4X6rB2KNXm6a/OsEk0N+D85wiroZ6pBjoFfQl9VEPerxJCF/pF4MlpdtCDnnqd
         rFMiDKt0YegMpI6rxI9Zm/mJQIyeE22LqEslKMPZ4iRGvslpUtj6J7z8DhdBhGWJIVdG
         5ylQ==
X-Gm-Message-State: AOAM530jDDwLCgV85v7qmhX4Jy0h67i80gjKOYcpCPwQ2QhoU2ZxuAn8
        dWzgVxYzuJp1qCzEIkdmPt0PcGEeghs=
X-Google-Smtp-Source: ABdhPJwfWKs3jY4Mpgmt6KEuGZiZeciBMSdRdoiMV7SLqB4YfwMqQN2VQ4XY/SoYP1JEEtEARtqNRQ==
X-Received: by 2002:a63:5907:0:b0:382:2f93:5467 with SMTP id n7-20020a635907000000b003822f935467mr5898806pgb.460.1648170413167;
        Thu, 24 Mar 2022 18:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:d674:140:d261:4ff3:2835])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm10971483pjb.10.2022.03.24.18.06.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:06:52 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: Add binding for Richtek RT5759 DCDC converter
Date:   Fri, 25 Mar 2022 09:06:40 +0800
Message-Id: <1648170401-6351-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for Richtek RT5759 high-performance DCDC converter.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt5759-regulator.yaml        | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
new file mode 100644
index 00000000..c24b583
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5759-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5759 High Performance DCDC Concverter
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT5759 is a high-performance, synchronous step-down DC-DC converter that
+  can deliver up to 9A output current from 3V to 6.5V input supply, The output
+  voltage can be programmable with I2C controlled 7-Bit VID.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT5759/DS5759-00.pdf
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5759
+      - richtek,rt5759a
+
+  reg:
+    maxItems: 1
+
+  regulator-allowed-modes:
+    description: |
+      buck allowed operating mode
+        0: auto mode (PSKIP: pulse skipping)
+        1: force pwm mode
+    items:
+      enum: [0, 1]
+
+  richtek,watchdog-enable:
+    description: enable the external watchdog reset pin listening
+    type: boolean
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: richtek,rt5759
+then:
+  properties:
+    richtek,watchdog-enable: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  # example 1 for RT5759
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt5759@62 {
+        compatible = "richtek,rt5759";
+        reg = <0x62>;
+        regulator-name = "rt5759-buck";
+        regulator-min-microvolt = <600000>;
+        regulator-max-microvolt = <1500000>;
+        regulator-boot-on;
+      };
+    };
+  # example 2 for RT5759A
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt5759a@62 {
+        compatible = "richtek,rt5759a";
+        reg = <0x62>;
+        regulator-name = "rt5759a-buck";
+        regulator-min-microvolt = <600000>;
+        regulator-max-microvolt = <1725000>;
+        regulator-boot-on;
+        richtek,watchdog-enable;
+      };
+    };
-- 
2.7.4

