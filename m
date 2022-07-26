Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85D658128B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiGZMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiGZL7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:59:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C597C33A21
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:59:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bf9so22204327lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHwZd9Pa/u5FR2uyBy86asEX1D1p0ApvUQHSWmOJELc=;
        b=CFgz8CvhxFDwBGTe1xoN/YZRHkIJZewi+lcJD03uHtfKnzuDfQhL088LRcxqb1XyCH
         I0XimVUkJRlN4FgAp367moM3f28au7hdXiuWfJINMvGLh1O1BbfGbz/0tvtiqfcTLJbx
         EoRaPiyZuTDIv/jxOrUH8cvUFMk+yGGaGfBTyKJrfoPf5rvEvl9rQ6XGMrw/rZtCy0qw
         sA8XxSFSYNUE48qQqDhe+6z75ERSiKb/Fsbpj5PMSo2cy51XK7MJRi8HdCpxPROi3nbj
         B0ekE6EKv1gOZgIC1XO8ocNPdsjEfSHkQw/NDDUIgtusNVvl6ckqHU6qCGdHlgrjMIZe
         d3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHwZd9Pa/u5FR2uyBy86asEX1D1p0ApvUQHSWmOJELc=;
        b=iRyRPy5X+kjY0lyFoRpGx3h7ACNG8QvN8oUbRlFgOTebg/ja/UZlmJ9ZsVRYwZbD3+
         1BL9GhybKbFSzs3VRDORijSGRJQA2cqOHkab4phEWJBWL7qn1TCGiUpcUqQ+o9bED6B7
         lNUNLtjlyAYht1MjuVI0bQ/Sl8CzS7wARfGH8eZE2j8WwljQ1pBxtLg4spyqcUmz2gBj
         QoFb24Lp1nGyH1cyLrGnT6gAyacdr6F2TYA8TM8+jwrrqEUdBvOViSsvGfcd51wYfex9
         GbD/OpPRQdu86URDqQxmooKHc/nn1AJti4MksmO8K+Z6YjXKHZWkdv9jaex8TU20PPqg
         lFvA==
X-Gm-Message-State: AJIora8At6SPBx9E1eRK+BAhqogngTo1BvtaFj+A4kqphRnwW7v6jgoz
        O9o05x5uhDwIDSY0xX3KJCxV6Sz2P2n8+w==
X-Google-Smtp-Source: AGRyM1uTeTJKflknwQZFgLgiyeO6V8yL127gHJDQoNP8cfaMBAq1K2MGFBcVEdCqD1oYkhRCQOvYTg==
X-Received: by 2002:a05:6512:3a90:b0:48a:adce:47f0 with SMTP id q16-20020a0565123a9000b0048aadce47f0mr456238lfu.473.1658836779525;
        Tue, 26 Jul 2022 04:59:39 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id q6-20020a0565123a8600b00489de206812sm3138967lfu.151.2022.07.26.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:59:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: timer: ingenic,tcu: use absolute path to other schema
Date:   Tue, 26 Jul 2022 13:59:37 +0200
Message-Id: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Absolute path to other DT schema is preferred over relative one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index d541cf2067bc..0a01e4f5eddb 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -113,7 +113,7 @@ properties:
 patternProperties:
   "^watchdog@[a-f0-9]+$":
     type: object
-    $ref: ../watchdog/watchdog.yaml#
+    $ref: /schemas/watchdog/watchdog.yaml#
     properties:
       compatible:
         oneOf:
@@ -145,7 +145,7 @@ patternProperties:
 
   "^pwm@[a-f0-9]+$":
     type: object
-    $ref: ../pwm/pwm.yaml#
+    $ref: /schemas/pwm/pwm.yaml#
     properties:
       compatible:
         oneOf:
-- 
2.34.1

