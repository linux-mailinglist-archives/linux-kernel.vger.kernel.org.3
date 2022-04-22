Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0870550C0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiDVVOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiDVVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:14:14 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23A437A92D;
        Fri, 22 Apr 2022 13:10:08 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e656032735so8477119fac.0;
        Fri, 22 Apr 2022 13:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRlND03QRiLNxpthhVYllX72CYYJ3yDiI6bua4XFKvA=;
        b=Sjg3/zAk2gUA6EepGyiH5dZ5CgjS40NfbU+5hZ1ZnuQRs74yBIwpiK65hALIBBll34
         xW5jECFIr5BczxmlIOCAhGSFh5/VJWlZ7DsET9IznYYHNA/8VdYlPWIIi8A6+HsTMhFc
         qIchaW0jMqBIf9SHm6rI2IAwYPPHoM+o4MdH6QIlx8773GBV39um2OrEacG7cC3pRRGl
         WdYovFhOXqazo9ux2mW2TprgP9igwVRud75qfZUSGEehHUcaXkf/4sUM3etOybtmlEO3
         G7DwkRM6P5Sl2gn6WNwkejYqgk/UDN1soqSoFiQi8kAUiRfWifHFMUSpU+OepjhM0naF
         Abcw==
X-Gm-Message-State: AOAM530zQh2rT6WWmbFTYj1C5/XWeY5BC1nha2ybI9X/7fQvpdumUXpY
        am2c/wZznAQKOLvGJ1aqVHGZ+Qb1AQ==
X-Google-Smtp-Source: ABdhPJw4RcUjb7CqmA8x9VRfliX7nFRroF9Tr6XBHqm/4Ty7bVwjvz8npkVW2jaOBHqrxjgPl8gkXw==
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id u1-20020a056870420100b000e647c4e104mr6400492oac.257.1650655294496;
        Fri, 22 Apr 2022 12:21:34 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id w2-20020a4a7642000000b0033a2cdbe62fsm1132208ooe.45.2022.04.22.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:21:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Drop undocumented i.MX iomuxc-gpr bindings in examples
Date:   Fri, 22 Apr 2022 14:21:21 -0500
Message-Id: <20220422192121.2592030-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX iomuxc-gpr bindings are undocumented and a mess. Drop their use
from the examples.

The problem with the binding beyond the just random variations is that
the iomuxc-gpr is not a separate block, but registers within the iomuxc
block containing random leftover controls. As a separate DT node, it
creates nodes with overlapping memory addresses.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 8 --------
 Documentation/devicetree/bindings/mux/reg-mux.yaml | 1 -
 2 files changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 13baa452cc9d..fb784045013f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -100,12 +100,4 @@ examples:
         compatible = "allwinner,sun8i-h3-system-controller", "syscon";
         reg = <0x01c00000 0x1000>;
     };
-
-  - |
-    gpr: iomuxc-gpr@20e0000 {
-        compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
-        reg = <0x020e0000 0x38>;
-        hwlocks = <&hwlock1 1>;
-    };
-
 ...
diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
index 60d5746eb39d..df4db96b5391 100644
--- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
@@ -96,7 +96,6 @@ examples:
 
     #include <dt-bindings/mux/mux.h>
     syscon@1000 {
-        compatible = "fsl,imx7d-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon", "simple-mfd";
         reg = <0x1000 0x100>;
 
         mux2: mux-controller {
-- 
2.32.0

