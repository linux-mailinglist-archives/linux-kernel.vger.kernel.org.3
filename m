Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C52501BED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiDNT3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiDNT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:29:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59315E9C9D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:26:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 12so5460703pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haYPDm3gcJOpT3ehoEXjpER3N5XngpTVAaW3u0NGOJI=;
        b=UeC7bfburxpoAWzjJUTMY3oqZguOQFQOGQp20+dUQbRbygC5GDp1GhpX1zefSDwAwX
         oPcurHv9F1vN0b6Kiy0hjMb3YIxoIifgyepEWlS7Lr3/XRtT1EgYxZnDEgkB+AuhBCaA
         jx75kqzLyGQ41lLgsVvIJLTzPwC3QWjHfCEuBs0HVlb3YtEGmL1j58Kprl5s/UAf+PpQ
         nPApbFJd+eP3IzeFl4Q0xkvdK7cd0LLBnRVhp/k34Q0RkJD6eMhSXhGlImiCSsBcmpkg
         Kp4dKbdSSQMxpRdGRVkM1xVj2ZRjkOuQusf+qNz0TpReDIzhsLgcgK4ylCNTCRSIY5yq
         0XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haYPDm3gcJOpT3ehoEXjpER3N5XngpTVAaW3u0NGOJI=;
        b=N+C9gweq1e7nlW08CLt24d7/iEABeEycxSmKJObC1PJqxIjyH+fpHp6/KlxTre3sVQ
         b39NWwzANXPID0lt3VVXvkrAWA8oPg8JxmwqyHVia+haSIkjrVESX66Ne6Dj5UhjKUVH
         Mql7Yx5oqlLS4nj7jdPBFEucHc34giB/1oBdcHKplMmDqw6qZSlbrt49c6M9MQ+g2AyI
         kexAcgDS9ZdSZpA0TjNNIy/6Xh7QyBNJTenJZ6e0jc/rENe+seQW9tzMZ06KxI44IbE6
         CMwj63LqFnpyE8swRJRW64zRsp9tUNIDmz7ezovV6Maui2LyYFMU2IbvB1jehv8f+DcV
         DzRw==
X-Gm-Message-State: AOAM531RL5tbU0jZ4ukS+V5Ajb8L74wvkb3+LsNM187sob9Ud/tGyZHD
        EcjWMGO9zorJC7FsRhG1li1gEQcSLsyCZA==
X-Google-Smtp-Source: ABdhPJynoxQ23KkNemtrw04+ZKyZXFaIV6eNCW46jUX34HiBtOFI176eMFim5h0+m+hjLa9JWUK5uA==
X-Received: by 2002:a17:90b:350c:b0:1c7:5cee:3946 with SMTP id ls12-20020a17090b350c00b001c75cee3946mr157733pjb.42.1649964413797;
        Thu, 14 Apr 2022 12:26:53 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:5b60:6a76:138d:2646])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b00505ff62176asm590060pfw.180.2022.04.14.12.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:26:53 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v3 1/2] dt-bindings: wkup-m3-ipc: Add ti,set-io-isolation property
Date:   Thu, 14 Apr 2022 12:27:23 -0700
Message-Id: <20220414192722.2978837-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414192722.2978837-1-dfustini@baylibre.com>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the ti,set-io-isolation DT property on the wkup_m3_ipc
node which tells the wkup_m3_ipc driver to use the wkup_m3 to enable
IO Isolation during low power mode transitions on am43xx platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: convert to YAML, make DTS example that passes check]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Changes from v2:
- correct indentation of the 'allOf:' block

Changes from v1:
- correct typo of 'ti,set-io-isolation' property in subject
- make 'ti,set-io-isolation' only valid for 'ti,am4372-wkup-m3-ipc'

 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 78 +++++++++++++++++--
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
index 7f4a75c5fcaa..f0ae86250fe4 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
@@ -24,14 +24,22 @@ description: |+
   A wkup_m3_ipc device node is used to represent the IPC registers within an
   SoC.
 
-  Support for VTT Toggle
-  ==================================
+  Support for VTT Toggle with GPIO pin
+  ====================================
   On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
   connected to the enable pin on the DDR VTT regulator. This allows the
   regulator to be disabled upon suspend and enabled upon resume. Please note
   that the GPIO pin must be part of the GPIO0 module as only this GPIO module
   is in the wakeup power domain.
 
+  Support for IO Isolation
+  ========================
+  On AM437x SoCs, certain pins can be forced into an alternate state when IO
+  isolation is activated. Those pins have pad control registers prefixed by
+  'CTRL_CONF_' that contain DS0 (e.g. deep sleep) configuration bits that can
+  override the pin's existing bias (pull-up/pull-down) and value (high/low) when
+  IO isolation is active.
+
 properties:
   compatible:
     enum:
@@ -63,6 +71,24 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: GPIO pin connected to enable pin on VTT regulator
 
+  ti,set-io-isolation:
+    type: boolean
+    description:
+      If this property is present, then the wkup_m3_ipc driver will instruct
+      the CM3 firmware to activate IO isolation when suspending to deep sleep.
+      This can be leveraged by a board design to put other devices on the board
+      into a low power state.
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: ti,am4372-wkup-m3-ipc
+    then:
+      properties:
+        ti,set-io-isolation: false
+
 required:
   - compatible
   - reg
@@ -74,21 +100,63 @@ additionalProperties: false
 
 examples:
   - |
+    /* Example for AM335x SoC */
     soc {
         #address-cells = <1>;
         #size-cells = <1>;
 
-        mailbox: mailbox {
+        am335x_mailbox: mailbox {
             #mbox-cells = <1>;
         };
 
-        wkup_m3_ipc: wkup_m3_ipc@1324 {
+        wkup_m3_ipc@1324 {
            compatible = "ti,am3352-wkup-m3-ipc";
            reg = <0x1324 0x24>;
            interrupts = <78>;
            ti,rproc = <&wkup_m3>;
-           mboxes = <&mailbox &mbox_wkupm3>;
+           mboxes = <&am335x_mailbox &mbox_wkupm3>;
            ti,vtt-gpio-pin = <7>;
         };
     };
+
+  - |
+    /*
+     * Example for AM473x SoC:
+     * On the AM437x-GP-EVM board, gpio5_7 is wired to enable pin of the DDR VTT
+     * regulator. The 'ddr_vtt_toggle_default' pinmux node configures gpio5_7
+     * for pull-up during normal system operation. However, the DS0 (deep sleep)
+     * state of the pin is configured for pull-down and thus the VTT regulator
+     * will be disabled to save power when IO isolation is active. Note that
+     * this method is an alternative to using the 'ti,vtt-gpio-pin' property.
+     */
+    #include <dt-bindings/pinctrl/am43xx.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        am437x_mailbox: mailbox {
+            #mbox-cells = <1>;
+        };
+
+        am43xx_pinmux {
+            pinctrl-names = "default";
+            pinctrl-0 = <&ddr3_vtt_toggle_default>;
+
+            ddr3_vtt_toggle_default: ddr_vtt_toggle_default {
+                 pinctrl-single,pins = <
+                    0x25C (DS0_PULL_UP_DOWN_EN | PIN_OUTPUT_PULLUP | DS0_FORCE_OFF_MODE | MUX_MODE7)
+                 >;
+            };
+        };
+
+        wkup_m3_ipc@1324 {
+           compatible = "ti,am4372-wkup-m3-ipc";
+           reg = <0x1324 0x24>;
+           interrupts = <78>;
+           ti,rproc = <&wkup_m3>;
+           mboxes = <&am437x_mailbox &mbox_wkupm3>;
+           ti,set-io-isolation;
+        };
+    };
+
 ...
-- 
2.32.0

