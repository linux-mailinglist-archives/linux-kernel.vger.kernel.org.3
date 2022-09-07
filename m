Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426F55B1064
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIGX3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiIGX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:29:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7ADFE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:29:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so15012493pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=26wB+6oXeV+aXPEoFQTjCmUsxTTyO/pi90w6t818OkM=;
        b=U1fDmxOvdHdgBxeIILx9x2+dLBCv/pMqLs1GzGsq7/ItBQYLs6cDgF2gqlrN930pFn
         RV8JxEr8o2vnEHMVTkb7x243vJB45shDFUNxmTHMJbKpcnotqzMCVVen6KVaibOdDx1G
         dIu9pgcVDFluuZikhsozAcGVXt7AfBTaupFHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=26wB+6oXeV+aXPEoFQTjCmUsxTTyO/pi90w6t818OkM=;
        b=JRNsL1yXPkY0IMS7O0C/pOsle8gwSOOE0RIUhwb4PFFToa2CAz65wcFnQfSpHm1vqw
         l6sxCdUpgQJ+eQa479Wbq3eDDfvYLaYP4LZOpZ/ruTuzqKVX6llpQyUo26SHlya9UBcE
         ZZ3p01MF0vkB6P4dSbnwG8OUYltC+3tj+oBM+IhMAJF61krVtAuH48LNrXkW1Fh0FQ5B
         StqFUix1h6Pu5lbZU4kIx1XUKpilX9vbG26Cqvg6CIa3Asn001LEhVPV496eJCEplAJT
         6rxdx/GW+HPPLS9xqbdz5XTb9PkTvc9B9nwtMjv6C50eA0nYxhPm0vxCU9qrhsydAuvn
         N8MQ==
X-Gm-Message-State: ACgBeo02yO1o5UrwhgSDBYoK4CHaSkZ/JvpBQDPpUhITTuF2EYZVSwas
        QcJoi5U1p/3rsqv4WEb5YfSUMQ==
X-Google-Smtp-Source: AA6agR5b7K8tACMSsGn6UNcBaEz94v2BcGAn53I1UyCfWlngqmdPNuJdvAeaDzei0kkefy6JhblGJw==
X-Received: by 2002:aa7:9193:0:b0:536:62e6:1a84 with SMTP id x19-20020aa79193000000b0053662e61a84mr6150333pfa.20.1662593363930;
        Wed, 07 Sep 2022 16:29:23 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:1cee:f8f:cc9f:568f])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a708600b002000dabc356sm201521pjk.45.2022.09.07.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:29:23 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 4/4 v2] dt-bindings: memory: Add jedec,lpddrX-channel binding
Date:   Wed,  7 Sep 2022 16:29:14 -0700
Message-Id: <20220907232914.243502-4-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220907232914.243502-1-jwerner@chromium.org>
References: <20220907232914.243502-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new device tree binding for an LPDDR channel to serve
as a top-level organizing node for LPDDR part nodes nested below it. An
LPDDR channel needs to have an "io-width" property to describe its width
(this is important because this width does not always match the io-width
of the part number, indicating that multiple parts are wired in parallel
on the same channel), as well as one or more nested "rank@X" nodes.
Those represent information about the individual ranks of each LPDDR
part connected on that channel and should match the existing
"jedec,lpddrX" bindings for individual LPDDR parts.

New platforms should be using this node -- the existing practice of
providing a raw, toplevel "jedec,lpddrX" node without indication of how
many identical parts are in the system should be considered deprecated.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../ddr/jedec,lpddr-channel.yaml              | 146 ++++++++++++++++++
 .../ddr/jedec,lpddr-props.yaml                |  10 +-
 2 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml

Changelog:

- v2:
  - changed $ref for rank subnode to specifically match LPDDR type in
    compatible string
  - moved `reg` up to be listed right below `compatible`

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
new file mode 100644
index 00000000000000..34b5bd153f63e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-channel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR channel with chip/rank topology description
+
+description:
+  An LPDDR channel is a completely independent set of LPDDR pins (DQ, CA, CS,
+  CK, etc.) that connect one or more LPDDR chips to a host system. The main
+  purpose of this node is to overall LPDDR topology of the system, including the
+  amount of individual LPDDR chips and the ranks per chip.
+
+maintainers:
+  - Julius Werner <jwerner@chromium.org>
+
+properties:
+  compatible:
+    enum:
+      - jedec,lpddr2-channel
+      - jedec,lpddr3-channel
+      - jedec,lpddr4-channel
+      - jedec,lpddr5-channel
+
+  io-width:
+    description:
+      The number of DQ pins in the channel. If this number is different
+      from (a multiple of) the io-width of the LPDDR chip, that means that
+      multiple instances of that type of chip are wired in parallel on this
+      channel (with the channel's DQ pins split up between the different
+      chips, and the CA, CS, etc. pins of the different chips all shorted
+      together).  This means that the total physical memory controlled by a
+      channel is equal to the sum of the densities of each rank on the
+      connected LPDDR chip, times the io-width of the channel divided by
+      the io-width of the LPDDR chip.
+    enum:
+      - 8
+      - 16
+      - 32
+      - 64
+      - 128
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^rank@[0-9]+$":
+    type: object
+    description:
+      Each physical LPDDR chip may have one or more ranks. Ranks are
+      internal but fully independent sub-units of the chip. Each LPDDR bus
+      transaction on the channel targets exactly one rank, based on the
+      state of the CS pins. Different ranks may have different densities and
+      timing requirements.
+    required:
+      - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr2-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr2.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr3-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr3.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr4-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,lpddr5-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
+
+required:
+  - compatible
+  - io-width
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    lpddr-channel0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "jedec,lpddr3-channel";
+      io-width = <32>;
+
+      rank@0 {
+        compatible = "lpddr3-ff,0100", "jedec,lpddr3";
+        reg = <0>;
+        density = <8192>;
+        io-width = <16>;
+        revision-id = <1 0>;
+      };
+    };
+
+    lpddr-channel1 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "jedec,lpddr4-channel";
+      io-width = <32>;
+
+      rank@0 {
+        compatible = "lpddr4-05,0301", "jedec,lpddr4";
+        reg = <0>;
+        density = <4096>;
+        io-width = <32>;
+        revision-id = <3 1>;
+      };
+
+      rank@1 {
+        compatible = "lpddr4-05,0301", "jedec,lpddr4";
+        reg = <1>;
+        density = <2048>;
+        io-width = <32>;
+        revision-id = <3 1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 92ef660888f318..30267ce701249a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -9,7 +9,8 @@ title: Common properties for LPDDR types
 description:
   Different LPDDR types generally use the same properties and only differ in the
   range of legal values for each. This file defines the common parts that can be
-  reused for each type.
+  reused for each type. Nodes using this schema should generally be nested under
+  an LPDDR channel node.
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -25,6 +26,13 @@ properties:
       The latter form can be useful when LPDDR nodes are created at runtime by
       boot firmware that doesn't have access to static part number information.
 
+  reg:
+    description:
+      The rank number of this LPDDR rank when used as a subnode to an LPDDR
+      channel.
+    minimum: 0
+    maximum: 3
+
   revision-id:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.31.0

