Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A234FECBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiDMCIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiDMCId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:08:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293343465B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:06:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k14so463875pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z6VCNILZAmJ4nVoBo0dJpxo2XYMU5Usk4gCsaeE6Yw=;
        b=auXusTGGPpWbx4FwMgi5fRIZsIeipynBmzmyIDxiUooF2PV8PMpBeEVJ0sRXhw5ICA
         UWtAPsflTpFfpwkfyZfFNFtO1ENsDt0vNXZDyRokkv1k6mFErkNjU6n/lrXO8oDp2JUM
         ujQL/JFcCDgtZFP/3YktMkV7T+/qJIZLWk3DKIFryg7uDitjf+cmMpVopCvoKkS9yo8c
         gEoJ8x+cYsQdvOC0GeAQypfM3cuFTwmrZhYxO1tTCa+59G6qxqYgeWU6Sqh54bU39eEI
         SirmqncSv3lHmfD+8an/b2UeZMYzt4CWeqjKgzCTXvwQeBBu+BfH9th75BfpFb9DkyGj
         tz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z6VCNILZAmJ4nVoBo0dJpxo2XYMU5Usk4gCsaeE6Yw=;
        b=weqdlLp7rTMUC28rb1fJAMTyhtvdBP6YIYsQlsxJX4566E/C3mZuD9YPSG08HOfqbv
         TEbFKVSBr7nu8vWgSmvr/zTUHR8mD1cJ1s7GFJqDY0rT7wiwensWcQAMbTVWGiyPbGwX
         8dLVTS4ZMqJG2SF7xkDeIolpi3RGBvLbFwXZuQfIIMiQzNO1OIUEIjwMI434pDz9Tk+I
         UM/YRHN5lIHkEZSl71jHgCJwzYfdvzMquzTza7VE+pwdTbDRs7YxbQ8Ek6lvnD6mzmBm
         b0gcn44lmtdJIvj8qpi/ht7NNjF3UCyrLjQcy9gVo4anggKY2Q6jxgAd0bDWXN4y3qdl
         dV7w==
X-Gm-Message-State: AOAM531Se/0Dqn3GZetrugJjvgCyilIGM4ImGmEbpl8zSpGfI2Ejysen
        88OV06TxZue+cDBGqcAprgyWfQ==
X-Google-Smtp-Source: ABdhPJxQPVLpGODV8SB3q39sdBBl2uibExiZ7AvCqsVWcqRCdtg8V77GJtTIS2/aqARtKZry7HIYRQ==
X-Received: by 2002:a65:6d0a:0:b0:382:28b6:7baa with SMTP id bf10-20020a656d0a000000b0038228b67baamr32280131pgb.486.1649815573652;
        Tue, 12 Apr 2022 19:06:13 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:669f:cec7:c0c2:1cc])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b00505f720bb76sm4234053pfp.215.2022.04.12.19.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 19:06:13 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add ti,io-isolation property
Date:   Tue, 12 Apr 2022 19:06:40 -0700
Message-Id: <20220413020641.2789408-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220413020641.2789408-1-dfustini@baylibre.com>
References: <20220413020641.2789408-1-dfustini@baylibre.com>
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

Add documentation for the ti,io-isolation DT property on the wkup_m3_ipc
node which tells the wkup_m3_ipc driver to use the wkup_m3 to enable
IO Isolation during low power mode transitions on am43xx platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: convert to YAML, make DTS example that passes check]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 68 +++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
index 7f4a75c5fcaa..30a65b75c024 100644
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
@@ -63,6 +71,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: GPIO pin connected to enable pin on VTT regulator
 
+  ti,set-io-isolation:
+    type: boolean
+    description:
+      If this property is present, then the wkup_m3_ipc driver will instruct
+      the CM3 firmware to activate IO isolation when suspending to deep sleep.
+      This can be leveraged by a board design to put other devices on the board
+      into a low power state.
+
 required:
   - compatible
   - reg
@@ -74,21 +90,63 @@ additionalProperties: false
 
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

