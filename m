Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36235B04E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIGNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIGNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8267CAB3;
        Wed,  7 Sep 2022 06:12:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so16103402wrp.11;
        Wed, 07 Sep 2022 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ChvOmSu5GMdmA6vtxRRGmQLc6VAohBorLSB7RCrJOu8=;
        b=akGKdeXu89Uh6JyTP01iqJjWtIfb1YzVaMPl6uIA8nDO4WhVwYIF6fscB6M4WFNz1V
         +2aMhOQX39U5l1qNJ46YHpV2aHOZ6PirFJWivmk0cWAOrKjHaRjbDT3IzQYyQG4Z66EN
         Aoi/JpvemWPDWu4+zJclXOqksPRIljM1zK0v2KKW61LxGbJ5EZiwjig75NU8cMhuwws5
         JYKWrTLrpz9mDfoAIloVIAbNAzilMwvRewj/9oBuIdqYHRJ/hpeTK2IwZ1uRF+vZV27D
         lXFtYvHBg/rtTTGNpOKwwXUSb08X45mA1PlrM2OYDy4j/4NllqMx7PWpRW7o8nb3hb/D
         Bm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ChvOmSu5GMdmA6vtxRRGmQLc6VAohBorLSB7RCrJOu8=;
        b=4DRTWdAsE8nndX+IM7Hfxqq4QDhs8krL7aeOhjuJgJeVh3jKncSBODBtlKQ+0FCyUT
         T4Qyz1jjrNYiNM8Bm3IEG8CyNTG1qJoShJx9mqykApu4aBzVAmlacMWIQgqHqjqJnLrN
         A3utv98MevJ4OVd0nJT4p27TfvO9TmIwK0rGsOgyOToHWrz07Mi6hdRABLAJ3GkIvp4K
         Hq4nOvPyB/U5wLRy1bgBAuDyUNjHNHEA/7QRn8HW+x3TRSk5kmWbtIKvCSQLfBBH/kRp
         jgrlYnnyv58uSw4AT4kyQ9SenlUeJi9xYU8CsBL6juN89Beo+KgUWzOVMqqGlK1g7U9w
         xGig==
X-Gm-Message-State: ACgBeo2tTx0MidgeQ3fdyl8gsl2vuM5BHWgn/7qpBOTAn1prTaOYwQco
        ohD+q8loz+GLtd8I1vlqxlxsW2hsu8M=
X-Google-Smtp-Source: AA6agR7F4oF9Ad/R2XJmtlXeddAaXEO1rNnkfG5wkXsaCDF4gY+KG0aQwBHya4Mr3b1EDa/759BhuQ==
X-Received: by 2002:adf:b646:0:b0:221:76eb:b3ba with SMTP id i6-20020adfb646000000b0022176ebb3bamr2076477wre.237.1662556366956;
        Wed, 07 Sep 2022 06:12:46 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003a5e7435190sm28667784wms.32.2022.09.07.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:12:46 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree bindings documentation
Date:   Wed,  7 Sep 2022 15:12:37 +0200
Message-Id: <20220907131241.31941-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907131241.31941-1-romain.perier@gmail.com>
References: <20220907131241.31941-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Mstar
MSC313e PWM driver, it includes MSC313e SoCs and SSD20xd.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../bindings/pwm/mstar,msc313e-pwm.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
new file mode 100644
index 000000000000..07f3f576f21b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/mstar,msc313e-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar MSC313e PWM controller
+
+allOf:
+  - $ref: "pwm.yaml#"
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mstar,msc313e-pwm
+          - mstar,ssd20xd-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: pwm@3400 {
+      compatible = "mstar,msc313e-pwm";
+      reg = <0x3400 0x400>;
+      #pwm-cells = <2>;
+      clocks = <&xtal_div2>;
+    };
-- 
2.35.1

