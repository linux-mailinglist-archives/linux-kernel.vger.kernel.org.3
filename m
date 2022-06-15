Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D0F54C267
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbiFOHIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbiFOHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:08:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F92899B;
        Wed, 15 Jun 2022 00:08:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o8so14060861wro.3;
        Wed, 15 Jun 2022 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KF9TQbXAQaO0+lCyq0Pm6oIczmP+NGAwWhS+H2ag0I=;
        b=nxWF6vfTvRMvqC2OXTc3S/F+H+7Bp4aNqsHfCWFGbhvnC89Nsh4G1mSULS0/5MQzhg
         Y4gYcTjH23l/4iioN81St/KfV2pKDfU2dChXQa8ne8Ju02ic0Bm0pb9DyM6QoGlSwugH
         C016lNxcQmDW+Uq1yBA+1QBVY9R1cLptRhLP3RaRu7ioPf/Wvl7fbsRDz4Ah4XRajARo
         ogU5SI4Fh1D/SrNhvlKAlgJJqDYVMIIZYxU4+UjQ0OI542E624niyk/e0b6svEnHLKc5
         EnpBTsa6H381WNxwnRuHe8oc8nLYsm2eBCKd27ZyXg5pmZKgCjZPOFQZYpTeCG5yTL5O
         3HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KF9TQbXAQaO0+lCyq0Pm6oIczmP+NGAwWhS+H2ag0I=;
        b=UuJvtikB1iSY/3G1+3sya2YomHUj2fVnc4H4bQaflXGXM9xrFUTBLu4IFqccvf+W5p
         5xQbRWrTyVJaDC6vHfYOcbYXpaZiWqWF87vmpjHNc/QGKQ37MjgQoG7rkIKPiRl/IwQ1
         FoWZS/hnlyySTk1O7dG6quhZm7toWGP7TKiV/xfsIu3lU+qsYV0YNJn722AJ/LcoiOiD
         UJ4c2cM1KLR85aIUmvUle7XMwue2uVqRwCnA+rcmjuqT53ZTG6loQT3YtcVd+auUWVQ/
         psQlfl9TIr0/Vaj5Ph58WoU5Uf8yoUbk1NLUwguhhUw0+Vd54fBUSZXzH24POjEjCY/I
         AVqw==
X-Gm-Message-State: AJIora/6ivXLElD9lzQUIwFkNofOYj/5X01Ksr3L4ePc6HwlFjqDqNCN
        XVfNWOO6pa1K9Mqpn53d6bCvKO9sjkE=
X-Google-Smtp-Source: AGRyM1tmEsuVgCBD/+wsO6NoYwOMQq6OCjFfmW6ttsay5izsZH2En83dJmD0ZLslZ5fHuRWzOobvwg==
X-Received: by 2002:a05:6000:1445:b0:219:f383:40bc with SMTP id v5-20020a056000144500b00219f38340bcmr8447579wrx.53.1655276911312;
        Wed, 15 Jun 2022 00:08:31 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id i8-20020adffc08000000b0020c5253d8d0sm13562708wrr.28.2022.06.15.00.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:08:31 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree bindings documentation
Date:   Wed, 15 Jun 2022 09:08:09 +0200
Message-Id: <20220615070813.7720-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615070813.7720-1-romain.perier@gmail.com>
References: <20220615070813.7720-1-romain.perier@gmail.com>
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
MSC313e RTC driver, it includes MSC313e SoCs and SSD20xd.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../bindings/pwm/mstar,msc313e-pwm.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
new file mode 100644
index 000000000000..82f2357db085
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
@@ -0,0 +1,47 @@
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
+    oneOf:
+      - items:
+        - enum:
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

