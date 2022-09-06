Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BABA5AE311
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiIFIjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiIFIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:38:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC6792EE;
        Tue,  6 Sep 2022 01:36:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t70so4198748pgc.5;
        Tue, 06 Sep 2022 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=Xfk8q/boJ++tc6ED5541SR2gX9poZWoUxjihn9Y8AOmq7ZxCdFcEB2HwppGGikcMKT
         14j3J2LkM3p3R37EYDFuViu9+ILjA0A8Oi1EOCKenDTrjh6I9xWtyGE32GrkSJLylE4c
         z6SmiFl1RwdomDTsmTxTT8lqZeW0RncJF/xrt+jbHAZm5+4d7hh+QflwnUpZPUlx+jo3
         VNxBZw+L41TSjj6s9EBGmVP5bF/FSH62Z5+TTpG/+kLYZ9myeddS26KECOo4jQuugAtT
         2lFHZrjH6KHuH8+OPNMl/kYg7MHiGVG/l7up1QBCOoTJzkd4rRLf9S8LNW97hLvVN6mN
         7hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=O9638kMH0C+se5YKDbJZHtI1CRUWpYaCUl13oljCt6nCOGssajhlW0Leg6STxxgj0A
         YRx8DY1//L3NHkRkCjz6qOXoLXLLw0Np1HgvPlKeMzFVRogsp+Ng5Cvu5HTzanXC32Vi
         lVg8Ak0uZtIf5SpFMYhtbi5dht8WGQmaAfb6haIWS4TMdNnt8kFrERoTGbBCwXxHQeHa
         RdRj4GOrzCWIjdY/wvBqKO932R41TBUR7M34MSTOIUHbFN8/l0/fIts5O+/jEYRjnh93
         ter7ktmoRVfY39xx9XpJjliImRkg1rExWQQXA0M9GmCqQ5OVlzKWPpDNCM2ounYHF1Zy
         Fohg==
X-Gm-Message-State: ACgBeo0VX+HfcvaDTlpH8t5r5EahRNjzArCQ286u37IGe6n7Ez09VF4W
        YRujnh5TcPMuD2ScIAM3VJ0=
X-Google-Smtp-Source: AA6agR4mIARd2VRb2eVkGdWPStcgkOSE3UbrobG0zHPxw9lscm6zsU+2gdQ68uhAbBosYrOX5RA7nA==
X-Received: by 2002:a65:6e45:0:b0:42b:7e3b:754e with SMTP id be5-20020a656e45000000b0042b7e3b754emr42294872pgb.26.1662453397150;
        Tue, 06 Sep 2022 01:36:37 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-80-193.emome-ip.hinet.net. [42.73.80.193])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm9474506pfj.57.2022.09.06.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 01:36:36 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 3/8] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Tue,  6 Sep 2022 16:33:59 +0800
Message-Id: <93186865d8d7094a4d7d7a7dfee6d5f3058e4ef7.1662476695.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662476695.git.chiaen_wu@richtek.com>
References: <cover.1662476695.git.chiaen_wu@richtek.com>
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

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 0000000..e9d02ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

