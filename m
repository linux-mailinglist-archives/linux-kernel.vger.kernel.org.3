Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673F4CC68D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiCCTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiCCTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:51:27 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE051A2766;
        Thu,  3 Mar 2022 11:50:41 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id u17-20020a056830231100b005ad13358af9so5508502ote.11;
        Thu, 03 Mar 2022 11:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhMaxl9TNUY7wmimyJIBPEvN19wmFM03Xz5lz5R1wLg=;
        b=cby+1l5RDded3QZDCUgDLdBTfNimHJK3k3b/tgDG0jF/z1M60ExT2A2PjQvx6vmUJc
         L/ZhC7bNyZ/fbWYaPgHzNl/ELl23olCvqMmB7jRJs+dh7zbKfw8QPBp9FazH1liRKGE3
         6Bb/4FN0sgdjQy0k/30HaMT4by1EDiN24kdPpF9Me1I0uYJsdZl7ilY4NQ1+gBhs+PIM
         PGra8voYzA9fMVvNYeZwglqYQl4tSUKJQerVV8AMtFRUFQW8xhQSxOe5wh5EbnPxQWfZ
         +nQowAmPc6lViWmrFmYvBYLVJVJegkJ+Gw/F2OHexKr/7JmB7+ECrJWen18x6mfsES65
         hfQA==
X-Gm-Message-State: AOAM532SBs3+Fmve6fgIDkhdWDBdAZbUVr7VHv2h/RAHC/Jv22VMMzRC
        5durE37Y2Wv2MHnoBUyevl/QOCltbg==
X-Google-Smtp-Source: ABdhPJxNkjR26g3ZjckCD3XAvZYDK3jRzlipdtAmUPlc+MmhHO0P1uj50SZKAybUR7H9R9TVdomSGQ==
X-Received: by 2002:a05:6830:920:b0:5af:ca85:67c4 with SMTP id v32-20020a056830092000b005afca8567c4mr18478108ott.363.1646337040861;
        Thu, 03 Mar 2022 11:50:40 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id bm5-20020a056820188500b0031c42eb457csm1367350oob.43.2022.03.03.11.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:50:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        - <patches@opensource.cirrus.com>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mfd: Fix pinctrl node name warnings
Date:   Thu,  3 Mar 2022 13:50:34 -0600
Message-Id: <20220303195034.2261989-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent addition pinctrl.yaml in commit c09acbc499e8 ("dt-bindings:
pinctrl: use pinctrl.yaml") resulted in some node name warnings:

Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: \
 lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml: \
 codec@1a: $nodename:0: 'codec@1a' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: \
 pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'

Fix the node names to the preferred 'pinctrl'. For cirrus,madera,
nothing from pinctrl.yaml schema is used, so just drop the reference.

Fixes: c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml")
Cc: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix lochnagar-pinctrl nodename in example

 Documentation/devicetree/bindings/mfd/brcm,cru.yaml          | 4 ++--
 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 4 ++--
 Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml | 3 ---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
index be4a2df71c25..b85819fbb07c 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
@@ -39,7 +39,7 @@ patternProperties:
   '^phy@[a-f0-9]+$':
     $ref: ../phy/bcm-ns-usb2-phy.yaml
 
-  '^pin-controller@[a-f0-9]+$':
+  '^pinctrl@[a-f0-9]+$':
     $ref: ../pinctrl/brcm,ns-pinmux.yaml
 
   '^syscon@[a-f0-9]+$':
@@ -94,7 +94,7 @@ examples:
             reg = <0x180 0x4>;
         };
 
-        pin-controller@1c0 {
+        pinctrl@1c0 {
             compatible = "brcm,bcm4708-pinmux";
             reg = <0x1c0 0x24>;
             reg-names = "cru_gpio_control";
diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
index c00ad3e21c21..a04570335b76 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
@@ -126,7 +126,7 @@ properties:
       clock-frequency:
         const: 12288000
 
-  lochnagar-pinctrl:
+  pinctrl:
     type: object
     $ref: /schemas/pinctrl/cirrus,lochnagar.yaml#
 
@@ -293,7 +293,7 @@ examples:
                 clock-frequency = <32768>;
             };
 
-            lochnagar-pinctrl {
+            pinctrl {
                 compatible = "cirrus,lochnagar-pinctrl";
 
                 gpio-controller;
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index c85f759ae5a3..8a90d8273767 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -107,9 +107,6 @@ properties:
 
     additionalProperties: false
 
-allOf:
-  - $ref: "pinctrl.yaml#"
-
 required:
   - pinctrl-0
   - pinctrl-names
-- 
2.32.0

