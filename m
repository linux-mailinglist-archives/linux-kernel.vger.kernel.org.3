Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B05148E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiD2MMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358909AbiD2MMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:12:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB04A76DD;
        Fri, 29 Apr 2022 05:09:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i19so15002421eja.11;
        Fri, 29 Apr 2022 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3h0GmbLis4NZlIpE1erozUhXxnX3hbvB9DGcuZNxy0=;
        b=c6T7Zs34qKyJosNnF60fAsXzOXOjfnffDPU16Jku4FqdvaFz7ZiMeOjxLuSiaoBLrI
         0XZRwQz44o+jIrlmwjevlFXbFrKQDtAUgWtpiYmWDbjrkSmZPyWvD0JmwJgLuW7zWoZn
         qmWarF+uZR9/L5v6mG/78YKstcRtaybbmETP19yQQ/tb6PINzwXWHg6nsz0QOXaNi0AU
         CxLxNhACjWGa8bb4cJCrkFDTqem4EvGs72mLGCksOX+yvqTWZ7IsOAxoyVtxiYmm69FP
         4IfZVOECRfY14tYECw/I2xRQv5YXf2lB32v037eEHlUp3RvOzcx2ranwmTPGZYW34Jiv
         j7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3h0GmbLis4NZlIpE1erozUhXxnX3hbvB9DGcuZNxy0=;
        b=KfD3GqSroSCIgjHMdoXv7jEEobUyClkwZx+kXRUklXMSjPDDG3WAqsYGkU+MbVkVXa
         zduKpQpcOSVDs87hA96Oh0Lx8D9AnpwOnieEqb/IPHRXoFDtbmOj+U79jycGEYMdem1S
         mGeE6FNp7jFuWg7wLklEXAR+qIfE4BSji0NmFGRtVtujnkSPs31QbjI9lAAZdoQ734xJ
         yvKSS7jLQ8l9SS3QDu+/oxdOrlsdIbNOirFZno5dPz1bKvdUwpUVh18lLWtFPWWtol5u
         ggvpp7EvtFnDWldEl5VKnsgIxP79uY+9SRo0nh1Do/0D/RCLpFS0KszmH40VAZAq4FgH
         cieg==
X-Gm-Message-State: AOAM532lQG8hL5Q30IzY/SuWrg36LlvgYMm96yAZb2Oyns2iidr/lO4A
        nJx4oouIAGcC8R/zoXfvcX0Il6/zVF0=
X-Google-Smtp-Source: ABdhPJz12NwOZDTgyGujISBptWIThPCsQcuS/r2NVDbNhQ+BUvntf05Kg3Rf3PfMgVUeuwr5iJDpIQ==
X-Received: by 2002:a17:907:ea5:b0:6f3:b061:a794 with SMTP id ho37-20020a1709070ea500b006f3b061a794mr18010764ejc.294.1651234174654;
        Fri, 29 Apr 2022 05:09:34 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b006f3ef214d9fsm590248ejk.5.2022.04.29.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:09:34 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] regulator: sm5703: Correct reference to the common regulator schema
Date:   Fri, 29 Apr 2022 15:09:14 +0300
Message-Id: <20220429120914.9928-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct file name is regulator.yaml, not regulators.yaml.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../bindings/regulator/siliconmitus,sm5703-regulator.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
index 75ff16b58000..9d84117530ca 100644
--- a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
@@ -19,14 +19,14 @@ description: |
 properties:
   buck:
     type: object
-    $ref: regulators.yaml#
+    $ref: regulator.yaml#
     unevaluatedProperties: false
     description:
       Properties for the BUCK regulator.
 
   vbus:
     type: object
-    $ref: regulators.yaml#
+    $ref: regulator.yaml#
     unevaluatedProperties: false
     description:
       Properties for the VBUS regulator.
@@ -34,14 +34,14 @@ properties:
 patternProperties:
   "^ldo[1-3]$":
     type: object
-    $ref: regulators.yaml#
+    $ref: regulator.yaml#
     unevaluatedProperties: false
     description:
       Properties for single LDO regulator.
 
   "^usbldo[1-2]$":
     type: object
-    $ref: regulators.yaml#
+    $ref: regulator.yaml#
     unevaluatedProperties: false
     description:
       Properties for a single USBLDO regulator.
-- 
2.35.1

