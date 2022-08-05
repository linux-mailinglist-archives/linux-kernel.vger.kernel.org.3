Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9558A664
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiHEHGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiHEHGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:06:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3626FA;
        Fri,  5 Aug 2022 00:06:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w14so1883427plp.9;
        Fri, 05 Aug 2022 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=u10vAEHFFPV+m/GXeBz2tZsyM176ncPweeKXNtbzC90=;
        b=lpYlKFaodSrlaln8lz1dUNOI4lQWvJ+cRzzDOYyx7EI8KlAYjZuIitS6HOEUQ55W5f
         PWtVd6lpKNqO8UwhiTfFWePr3eWySMaJkxBCEYByfZwBKNfy0B1tZ1tF6vY6HRslE4bY
         smKZ+gY3X3WRx2FXUfAq/ekAOdKBFxwUleaomuQRLg6mMBQkLAeGYUi+ihaAc60ujJja
         3qnW8ixtVDSQ8kBKInU/9OJEZj1PRzkU1v+db2Tuizs6WFlkTzLHc4CuqYn3oXAYRsoE
         MdETGC8tm2553zWhLzOHMWW8CN4c0t1kiT9g2SbHHeWr/92Zyn/6Ulnm0EClXMiT7iSg
         3fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=u10vAEHFFPV+m/GXeBz2tZsyM176ncPweeKXNtbzC90=;
        b=3zNZorf4ExtIyvsDMyjlhZ4LI1Rt2OoTSgOXvQMFdj7cyt/xiE2aUNP3cdRaoJi+CP
         zEgqjw4Vey8O/XQpSHBGfYPwtQqSzoKy85S7jra59BRISicNV2IMMeCPolp7tyyiN9ox
         ttrVcdukC9bYszbegyglX+df6fEiIatnTEntmCxBjz/Mc7rxbIq7ocMG9dAfulWtdcnA
         K5cwUixTLOdIQxXiz6YIPVcsRn5jmTMBOLP8St+pjGZcj9ulx756VtOZ/Ox39mFEhIWi
         9S9YEHMWmZDKK+OOaisP9rhjQR+zkkFFBKdkw0At3ED1oRry0WngqC38FhC07XY5w632
         BRnQ==
X-Gm-Message-State: ACgBeo2DpK6J4JbW0cI4Cp5MGhhE6znzmLVFzcixsvOSKzjule3pdsJ2
        sqh4P3LBAaFDggsThgh7qQ4=
X-Google-Smtp-Source: AA6agR6uOX2JJQosvwhOiZcfULuJgPT1rgt3CEKqJiZbC5XzNWkHdOg8QcgsZu7eNgGXLbciVCi0Iw==
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d4b with SMTP id q18-20020a17090311d200b001678a0f8d4bmr5573656plh.78.1659683194207;
        Fri, 05 Aug 2022 00:06:34 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-229-62.emome-ip.hinet.net. [42.72.229.62])
        by smtp.gmail.com with ESMTPSA id i5-20020a056a00224500b00525343b5047sm2191616pfu.76.2022.08.05.00.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:06:33 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 01/13] dt-bindings: usb: Add MediaTek MT6370 TCPC
Date:   Fri,  5 Aug 2022 15:05:58 +0800
Message-Id: <20220805070610.3516-2-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805070610.3516-1-peterwu.pub@gmail.com>
References: <20220805070610.3516-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add MediaTek MT6370 TCPC binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 0000000..72f56cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediatTek MT6370 Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  MediaTek MT6370 is a multi-functional device.
+  It integrates charger, ADC, flash, RGB indicators,
+  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6370 Type-C Port Switch and
+  Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-tcpc
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
-- 
2.7.4

