Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF15531DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiEWVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiEWVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:23:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14556D4E7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:23:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so434609pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQAatZV5NnfoF9WuNNy+yRJv0Fno2wnlohfY6hxqcKo=;
        b=XLcg+FpMHpseQi+OkiMTv3/y5Vv/vzEzVgxLJ+voWj/1pzB6aG7oqja0fl9mgXWEau
         /2qYZnBjmZlNRWo3A2g+fAn7NkZmGB27uYFEkwnz4yFCGUnABEj3cxu9deWc3N0kONtL
         PPuY1IXpFEwLrIu3HjNlgw6PwqPgXYvD7yiZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQAatZV5NnfoF9WuNNy+yRJv0Fno2wnlohfY6hxqcKo=;
        b=tQxvEWS1JInQLbFpZ9VshsZZjiiVz3y6D/cEn/F8CZCdW5kG/queiYHIdqa3qMDHe3
         /GCLhn6+ObkVMuIDcOGdZIGwgOTZcQ8UBZMtWaVnMlqrTLN/UIaIcOSeI9d5MTyMs82o
         y387VLA7ivFrmAE69Rw1y4l7qiisP2L6N4TNJke3XFapI7si7km1MgRWB7dMc67EVjYa
         4LpFJE9AGP8EqIi+T1yvMo+8dONnocEIWRoIKDvBZpuRsiGElosH9X85n7jeYH02zNof
         ECYvIYP2WiU8JR3NOCXRKrW7WQCwjZfpMyjW0OVSn1k1BEqny4P4YNc662jxCX2DYAco
         IdYg==
X-Gm-Message-State: AOAM533O2c1f9vtElfxc8UPk9kp1Wy7OFgY6EmWzd2mJe09XWlXf7lRm
        +ZAiE4VCqxNS+cfJuVBHxB2/Xw==
X-Google-Smtp-Source: ABdhPJwUu257XWos/EKzre0r3S5qICXanQlox2IWgIPD8747Pymaf7700D7Rm+fp0UynkANX6FUT6Q==
X-Received: by 2002:a17:90b:4d8b:b0:1dc:aebe:4c8b with SMTP id oj11-20020a17090b4d8b00b001dcaebe4c8bmr970265pjb.145.1653341010131;
        Mon, 23 May 2022 14:23:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:64b0:b6b9:c0f3:1cc8])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b0015e8d4eb234sm5545922plg.126.2022.05.23.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:23:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce bindings for Elan eKTH6915
Date:   Mon, 23 May 2022 14:23:23 -0700
Message-Id: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like many i2c-hid touchscreen controllers, the Elan eKTH6915
controller has a reset gpio. For the Goodix GT7375P touchscreen the
decision was to add a new binding rather than trying to add a new GPIO
to the existing i2c-hid binding. We'll follow the lead and do it here,
too.

SIDE NOTE: the Elan eKTH6915 is a touchscreen _controller_ that's
included as a part on some touchscreens. The reset line isn't truly
necessary for the functioning of the touchscreen, so it's possible
that some designs won't have it hooked up and will just guarantee the
power sequencing requirements with RLC circuits. Thus, we'll mark the
reset gpio as optional.

Note that if the reset GPIO isn't used there's actually no true need
to use the "elan,ekth6915" compatible instead of the "hid-over-i2c" on
Linux. However:
- Officially using just "hid-over-i2c" for this device violates the
  existing "hid-over-i2c" bindings. The bindings say that you're not
  supposed to use "post-power-on-delay-ms" without specifying a more
  specific compatible. Currently the Linux driver doesn't enforce
  this, but it violates the bindings to just use
  "hid-over-i2c". ...and if you're going to add a more specific
  compatible anyway, might as well do it right.
- Using this compatible means we don't need to specify
  "hid-descr-addr" since it's inferred from the compatible.
- Using this compatible means that the regulator names match the names
  on the Elan datasheet (vcc33 / vccio) vs the generic hid-over-i2c
  (vdd / vddl).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 .../bindings/input/elan,ekth6915.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/elan,ekth6915.yaml

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
new file mode 100644
index 000000000000..05e6f2df604c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/elan,ekth6915.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Elan eKTH6915 touchscreen controller
+
+maintainers:
+  - Douglas Anderson <dianders@chromium.org>
+
+description:
+  Supports the Elan eKTH6915 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+properties:
+  compatible:
+    items:
+      - const: elan,ekth6915
+
+  reg:
+    const: 0x10
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
+
+  vcc33-supply:
+    description: The 3.3V supply to the touchscreen.
+
+  vccio-supply:
+    description:
+      The IO supply to the touchscreen. Need not be specified if this is the
+      same as the 3.3V supply.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc33-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ap_ts: touchscreen@10 {
+        compatible = "elan,ekth6915";
+        reg = <0x10>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_ts>;
+      };
+    };
-- 
2.36.1.124.g0e6072fb45-goog

