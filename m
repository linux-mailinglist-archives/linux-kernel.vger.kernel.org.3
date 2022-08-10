Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8A58EE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiHJOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHJOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:37:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABFE5071D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:37:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x9so12616608ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=R+Ougz4fRR8eTzuJCOGBB5cXOVbi2l3xNgfJfKfekik=;
        b=Lds0fv0b+SulbyNYD4YjOLRTUHDrpRM9pApZFe6gS0IzjVbyRtJutYyamESDlcxsEg
         l2o7LwlQO1VZrJabB69g6/B1nn1uVDB7JJtBAYRK/szW1+NsigbVDPD8NgYKIjYKN4h3
         +fowc+xNrML0jG+0414Bl89xeoHiJX5pkc5HiXb7iw911/v4mqRJlEW+BuygnfcHRcUY
         lTY4L7QlN3vtealDUgO+VR4vuN74Tu6g1k2w5ejyyzUtLa4sNQyNjnmhbvYCxZBZ1dG3
         DlPE9FzrqpRhaqSxVtegd/7HFie09R2rvSv7cmTKU955KNUxOpRWKUJEVRmKNBNI3loE
         /+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=R+Ougz4fRR8eTzuJCOGBB5cXOVbi2l3xNgfJfKfekik=;
        b=6wGoIHVxfMUBYCZPlxG4MnyTQO5nqufF22Ce/ccGfLlyWLrUQUPHaJG9XVh00AlGz/
         sw2yttaWmJDo8y3+pOt6QuQ3k6wPsE4JcVtm27WvE2r0b+IVaHqrXTSr/l4zdDzGUKs0
         72nbWDkTcL0g3qwXqEF6RILd5ukPl8x7ssV2/gjkZF+S2QnbT0UAOdMgltd15bMAAotI
         EezUkENkVKnDEFeR3HPiuh3kzimuHlQPfbuoPm487c8nj4k8MNF8O82mnN/GdO0TwfRo
         D4gEguvy71wkvnV+1K+HEK66TRxF4E82Mc9ai5XPwGL7NArWhB+DROGdLOQeGKxKJLBO
         4FLA==
X-Gm-Message-State: ACgBeo0mWt/XiWbIo8EjRvZrvORZjxjIDQBe+FQ8YVpp8n52vnc1bIPs
        v4NLKjJpifMKAvVrRKMongGM0Q==
X-Google-Smtp-Source: AA6agR5epgFnbUL98NJO8fqilTyQwEnTqSP/AArKazeI+Lbd/CIEuHx4fdNa17GZ7W0kb8lrfOAHdA==
X-Received: by 2002:a2e:a409:0:b0:25e:724a:f788 with SMTP id p9-20020a2ea409000000b0025e724af788mr8208513ljn.300.1660142246958;
        Wed, 10 Aug 2022 07:37:26 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id q23-20020a056512211700b0048b2583fb46sm360445lfr.200.2022.08.10.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:37:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] dt-bindings: chrome: google,cros-ec-type: restrict allowed properties
Date:   Wed, 10 Aug 2022 17:36:13 +0300
Message-Id: <20220810143613.482724-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe exactly what properties are allowed in Google Chrome OS EC Type
C port, so the schema can properly validate the DTS.  Existing DTS
defines always connectors with unit addresses, not a sole "connector"
child.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/chrome/google,cros-ec-typec.yaml     | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
index 2d98f7c4d3bc..50ebd8c57795 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -20,13 +20,24 @@ properties:
   compatible:
     const: google,cros-ec-typec
 
-  connector:
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^connector@[0-9a-f]+$':
     $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+    properties:
+      reg:
+        maxItems: 1
 
 required:
   - compatible
 
-additionalProperties: true #fixme
+additionalProperties: false
 
 examples:
   - |+
-- 
2.34.1

