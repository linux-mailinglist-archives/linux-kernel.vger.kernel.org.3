Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108CE5487C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357832AbiFMM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356701AbiFMMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669715675D;
        Mon, 13 Jun 2022 04:12:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so5590710pjb.3;
        Mon, 13 Jun 2022 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PhEd/hCsm+H0s/MYgcNh9Jcss9lmcQSw7vjFLzWUag=;
        b=Suc6iBHRFwzduJcDko660RQDxH8yM9viwXxb8kLirMiKU3L4sZb2X0B5lKMBVXKi5m
         C9x103BsKW1QIXl69OQHktmu0sQ3TRjuqgfyotPqL/6uHnOybIy+Nxkse1c0ISdmSoiF
         PMKWMq5mJY9d5yWnR/OsT/YTfccwN04V8IEw6u0XkdipUSHnBDYPmDC5o3Bcig2Rl2Mt
         H+xeFH/SA2v1DMTus00eyR3bLPHDR3rMPAjogql5vp2kyoddKeIIfYwgwNwhp0+iY7C7
         5UybtJdfXvabI83NctAt+Y1VE+5sSULv89R2w2dsvoy1D9tHlASeb57h1nIkXoD1B1In
         omug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PhEd/hCsm+H0s/MYgcNh9Jcss9lmcQSw7vjFLzWUag=;
        b=OY7tqRmmmFEFYVYc2fwu5N8yOw5B+1zf2ro74xs4SmkOY/qDKY+KR70eGDeOq59poz
         fouUgvMK2EfdDtr3LB8C3Zv8E9Ud7T6DkYtN3mRBZDP7XOWHuBAoy1zo4NMy9adfQ+px
         aWur7T7FpMNNRjIRAmJOMaWgkxb8Y5HhNJozLNz1LVvX7lACiyknqL2+hLfn2n8E1zJv
         5NZKj6Od+fpnnQmZh71ouddhXWYFKmrzM2D/jhv79QNDmD3DPysBJyCUaUXf8m9/Ed8C
         tp3QhdKCyIDXg6A2kcX97FPlA9sBNpuIbtDaB/yiKjT7H4T2RmH5bEhmSfkhDQvyp1Es
         q5Hg==
X-Gm-Message-State: AOAM533JU63q306d0lJhhhSgn3gXfYPUvMo6okGMhTIij8gbJAw0bLxF
        gihgm8vfqSLS3UYzQF2I9Yc=
X-Google-Smtp-Source: ABdhPJwg+KdzNhzT/AjwhzSIUVFwI7i5f/6BugmkfhPT6mWaHcgxcAdsTgruwXA2gFhNBmT+m6N0DQ==
X-Received: by 2002:a17:902:b68c:b0:167:95e2:f822 with SMTP id c12-20020a170902b68c00b0016795e2f822mr30806898pls.128.1655118774234;
        Mon, 13 Jun 2022 04:12:54 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:12:53 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH v2 02/15] dt-bindings: power: supply: Add Mediatek MT6370 Charger
Date:   Mon, 13 Jun 2022 19:11:33 +0800
Message-Id: <20220613111146.25221-3-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613111146.25221-1-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add Mediatek MT6370 Charger binding documentation.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../power/supply/mediatek,mt6370-charger.yaml | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
new file mode 100644
index 000000000000..b63553ebb15b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6370 Battery Charger
+
+maintainers:
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-charger
+
+  interrupts:
+    description: |
+      Specify what irqs are needed to be handled by MT6370 Charger driver. IRQ
+      "MT6370_IRQ_CHG_MIVR", "MT6370_IRQ_ATTACH" and "MT6370_IRQ_OVPCTRL_UVP_D"
+      are required.
+    items:
+      - description: BC1.2 done irq
+      - description: usb plug in irq
+      - description: mivr irq
+
+  interrupt-names:
+    items:
+      - const: attach_i
+      - const: uvp_d_evt
+      - const: mivr
+
+  io-channels:
+    description: |
+      Use ADC channel to read vbus, ibus, ibat, etc., info. Ibus ADC channel
+      is required.
+    minItems: 1
+    maxItems: 9
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpio:
+        maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - io-channels
+
+additionalProperties: false
+
+...
-- 
2.25.1

