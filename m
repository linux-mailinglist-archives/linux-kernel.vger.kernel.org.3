Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271005A7364
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiHaBeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHaBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:34:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A2B14D1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l3so12777924plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VgOynVEB9/HARKXu49Pt4j7dTWgCIFiaZm3ap+KRJWg=;
        b=c70eTEa27HMsGuutG1waBvqwXQVDKH7Hg3/FJbUjjzDxswerI78gq8Vj33qN2mQMp6
         lSHjZ/6R6iAHHN8ymDYNCA9ZOW0LTIO6HtNK7Ihdjw43jzrzdsRDCf//2f0IluBpZR/U
         GI/rqAVYOjrKByBkOu0TqAuns+PoCPb0gHSzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VgOynVEB9/HARKXu49Pt4j7dTWgCIFiaZm3ap+KRJWg=;
        b=qwfWorf+nacY9OfCFndEJfNueBNorLEL50sI8cK2Dh8bDj0v/gW1blrZKOr07xi5lh
         e+lW3SvOzA6Ko/1FK1l3WrR/E3ERhhPEePYfnKrJkjenw/v8Q3WomSwwtC6T5m5F8NbE
         4trvGXO4QrAE9e8bBnPyT7RnODVZSEsMg+hundxXppFQjeZQ43NymKvtPIl68KbB/R1r
         7SY+kmJYkrOvLK1qpF2Xwwo68Eg0mOZXcpiGSOgp3qu+SbdxWBnf3nBvqwGYtfQk7XMs
         Yrr3tVdTsovh4q1OK47eX/YDD96SL8KCGT7obSbq0tycQwCzawdM1m5F4AUH7sRAUTN0
         hb1Q==
X-Gm-Message-State: ACgBeo0srApFVSAAlo0cVWYLxVCksgP/tLuNVqHP+E8iYkemZDnyXeI1
        bfqL+sz9Y/vww7v3sWGhSs8aOg==
X-Google-Smtp-Source: AA6agR4SdgAm5wO3PwP06W6bWbscrdXBG/UoiheinSk2SivjRbf3Z0nwLXCW2WF/QON++1PTx1/fgw==
X-Received: by 2002:a17:902:d486:b0:16f:15a1:6da3 with SMTP id c6-20020a170902d48600b0016f15a16da3mr24043762plg.134.1661909649860;
        Tue, 30 Aug 2022 18:34:09 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:2e75:b9a4:fb1:b1b8])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b00174f4316c24sm4261382plg.245.2022.08.30.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:09 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 4/4] dt-bindings: memory: Add jedec,lpddrX-channel binding
Date:   Tue, 30 Aug 2022 18:33:59 -0700
Message-Id: <20220831013359.1807905-5-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831013359.1807905-1-jwerner@chromium.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 .../ddr/jedec,lpddr-channel.yaml              | 116 ++++++++++++++++++
 .../ddr/jedec,lpddr-props.yaml                |  10 +-
 2 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
new file mode 100644
index 00000000000000..517e770d8e7133
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
@@ -0,0 +1,116 @@
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
+    oneOf:
+      - $ref: /schemas/memory-controllers/ddr/jedec,lpddr2.yaml#
+      - $ref: /schemas/memory-controllers/ddr/jedec,lpddr3.yaml#
+      - $ref: /schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
+      - $ref: /schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
+    required:
+      - reg
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
+      compatible = "jedec,lpddr4-channel";
+      io-width = <32>;
+
+      rank@0 {
+        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
+        reg = <0>;
+        density = <8192>;
+        io-width = <16>;
+        manufacturer-id = <255>;
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
+        manufacturer-id = <5>;
+        revision-id = <3 1>;
+      };
+
+      rank@1 {
+        compatible = "lpddr4-05,0301", "jedec,lpddr4";
+        reg = <1>;
+        density = <2048>;
+        io-width = <32>;
+        manufacturer-id = <5>;
+        revision-id = <3 1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index e1182e75ca1a3f..53a4836028cd25 100644
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
@@ -71,4 +72,11 @@ properties:
       - 16
       - 8
 
+  reg:
+    description:
+      The rank number of this LPDDR rank when used as a subnode to an LPDDR
+      channel.
+    minimum: 0
+    maximum: 3
+
 additionalProperties: true
-- 
2.31.0

