Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD34A74AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbiBBPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345482AbiBBPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:35:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BDC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:35:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b15so18662077plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kL1KkyIWXceE/tVaN24Ly31VYKQD4vVNlo5DAeEyfY=;
        b=b5YKAAMv5vUBLFWQo7/svxf4uW9c4jQdCBlNf+YEv43MWbabtbkORAN1zwYdD3Q9ZQ
         qjb1pqvxN+woMw8Eqk6kW+KZs2VAKtXnsh1q8TCzqeJyDfj0vbZxe1YvqMo4pONZtFtN
         M4tZ+iGO4UvOMRmV8zwFLcJbtGJ+XdytpGBi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kL1KkyIWXceE/tVaN24Ly31VYKQD4vVNlo5DAeEyfY=;
        b=piu085/5/aL7zTLeMdXY8RLg7kt0oWMT1VrOpCL1idJQ/pJZS43SxWJw/hVrC+k7ce
         1OVE72sRbCbBDR8AwDA8zA4rjbndJzmuKuXmXk/L+MPqWR1wxKrJpFAgzWLq2GBiooGz
         r29b4G6taS3omZZpE4Iqt/uXWVgybSuSlR14+UOGHpp8ttFWL5u+aiZVCi5JJmDZNXM6
         UQ/ovGcx6moIYBYE5a5KV6nBnSHwfsTdrtFcleOM3VEkbrWVvmXnbYAqtfsz5UwRtg9E
         ypVmh3uyr0bgFL4KDs6eQnFDvFZ0Zo/KL2XUcIZOW/FxP1JMcWSUcetCqif7rMaKrStI
         fGsg==
X-Gm-Message-State: AOAM532e16CbOBlfPk1mJEmTIHIJmbDtsT5tbWY0S75o6F9qZbFLdZ1J
        qasPIlgMihgS/P6hcrc08HqWtA==
X-Google-Smtp-Source: ABdhPJxDqqgJegVyPTA9BanZUtQtEA08JWZcOpDX3pVHOZSHFBzCbRoHQptLSCpYdHmg86Z5HQ0NUQ==
X-Received: by 2002:a17:903:230f:: with SMTP id d15mr32346742plh.8.1643816135351;
        Wed, 02 Feb 2022 07:35:35 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id q2sm11096617pfj.94.2022.02.02.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:35:35 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Guodong Liu <guodong.liu@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: mt8195: fix bias-pull-{up,down} checks
Date:   Wed,  2 Feb 2022 23:35:28 +0800
Message-Id: <20220202153528.707185-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the constraints and description for bias-pull-{up,down} were added,
the constraints were not indented correctly, resulting in them being
parsed as part of the description. This effectively nullified their
purpose.

Move the constraints out of the description block, make each description
part of the same associative array as the enum its describing, and
reindent them correctly so they take effect.

Also add "type: boolean" to the list of valid values. This corresponds
to having bias-pull-{up,down} without any arguments.

Fixes: 91e7edceda96 ("dt-bindings: pinctrl: mt8195: change pull up/down description")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bindings/pinctrl/pinctrl-mt8195.yaml      | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 328ea59c5466..8299662c2c09 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -99,6 +99,14 @@ patternProperties:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
           bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: mt8195 pull down PUPD/R0/R1 type define value.
+              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
+                description: mt8195 pull down RSEL type define value.
+              - enum: [75000, 5000]
+                description: mt8195 pull down RSEL type si unit value(ohm).
             description: |
               For pull down type is normal, it don't need add RSEL & R1R0 define
               and resistance value.
@@ -115,13 +123,6 @@ patternProperties:
               & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
               define in mt8195. It can also support resistance value(ohm)
               "75000" & "5000" in mt8195.
-              oneOf:
-                - enum: [100, 101, 102, 103]
-                - description: mt8195 pull down PUPD/R0/R1 type define value.
-                - enum: [200, 201, 202, 203, 204, 205, 206, 207]
-                - description: mt8195 pull down RSEL type define value.
-                - enum: [75000, 5000]
-                - description: mt8195 pull down RSEL type si unit value(ohm).
 
               An example of using RSEL define:
               pincontroller {
@@ -146,6 +147,14 @@ patternProperties:
               };
 
           bias-pull-up:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: mt8195 pull up PUPD/R0/R1 type define value.
+              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
+                description: mt8195 pull up RSEL type define value.
+              - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
+                description: mt8195 pull up RSEL type si unit value(ohm).
             description: |
               For pull up type is normal, it don't need add RSEL & R1R0 define
               and resistance value.
@@ -163,13 +172,6 @@ patternProperties:
               define in mt8195. It can also support resistance value(ohm)
               "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
               "75000" in mt8195.
-              oneOf:
-                - enum: [100, 101, 102, 103]
-                - description: mt8195 pull up PUPD/R0/R1 type define value.
-                - enum: [200, 201, 202, 203, 204, 205, 206, 207]
-                - description: mt8195 pull up RSEL type define value.
-                - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
-                - description: mt8195 pull up RSEL type si unit value(ohm).
               An example of using RSEL define:
               pincontroller {
                 i2c0-pins {
-- 
2.35.0.rc2.247.g8bbb082509-goog

