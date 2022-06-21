Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD533552FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348368AbiFUKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348138AbiFUKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:36:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874028E14;
        Tue, 21 Jun 2022 03:36:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso12086127pjd.3;
        Tue, 21 Jun 2022 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D/Eqnjqmnl12dSFxUrRjFlGQ54ZKMERMuKCuM1+6plU=;
        b=esJE5Cs8hxQTCMjqmhUfTurNyYXyH5qffkShag2sqyUzZJpiCQbbmxf917Iufe65XX
         eCth9pwsuHVyTXhutbGdZXeTMKZFqBSZ8xn4E3ooMLF4A0a5fPy6u82/xeA+QS/LWFEs
         L2Vva8Iqn66NoGTPpO7/ytEhQK68ckVHF0JEl7pFnq2rJ3te4zxMirS3/juuvhv6To9E
         j/fpGbpYiozPDEpgaVk3PTBeXZTR54ufr2SwY1n8o7ygPxwW5j17rb9qlZIpNg4Rk4+X
         b9tY/MK6YVgfKV05db5WwKLNmQBE9MgOB0QmGI4F8FfNfIz7gEQFdTvz7C/rpVbJpY7/
         g0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D/Eqnjqmnl12dSFxUrRjFlGQ54ZKMERMuKCuM1+6plU=;
        b=m0z1G7qnj5sgy1IeBQQfVs0NqYMyzL9iF3ShfQNKoWx4P2bxMYdPzMmvJmcRgwJ7zd
         hNPHfkHRb/hD5g2+f+g8dR/Ou0oNam40xXdFHvCLMPM7W1xMitJ4bAXMFXsP3eoqnSSx
         hulz3ggnttfKtXLrWiQGGApljMblLFb/ueCUyWGl4r3/36yMxkNmNq64k43C/KadXkAh
         6Wib10MuoH/5UPy3JQzHa1vI5Mzr29CeWy5o5wLVuihjRbttHze+hZOqymxHbwM8vdAL
         QEIb1vPCES2oL/fxu9kycokv2G4rVLM9mWa0ErHQIqeH6d1hIBS46Ge4dTeHbMQm4J4x
         g7HQ==
X-Gm-Message-State: AJIora99OiO80Lgc9GshKf13WKfjUKI/JZIOxG0ByHA4Em1NEpUr9m7j
        l7e9hdILAOcMVGPc6WVPssc=
X-Google-Smtp-Source: AGRyM1sEEDKgvokbKyArv3aS8MDcv/zXvb23OlGn2uUZ3vo0e/I5E/JjSAqVa9aEWi1MCin4gOlNYQ==
X-Received: by 2002:a17:903:2308:b0:16a:666:8ec2 with SMTP id d8-20020a170903230800b0016a06668ec2mr21368451plh.20.1655807800571;
        Tue, 21 Jun 2022 03:36:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:c428:5499:b787:9:3bde])
        by smtp.gmail.com with ESMTPSA id o188-20020a625ac5000000b0050dc762819bsm36295pfb.117.2022.06.21.03.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 03:36:40 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: backlight: rt4831: Add the new ocp level property
Date:   Tue, 21 Jun 2022 18:36:27 +0800
Message-Id: <1655807788-24511-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
References: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add 'richtek,bled-ocp-microamp' property to make it chooseable.

The wrong backlight ocp level may affect the backlight channel output
current smaller than configured.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v3:
- Refine the description for backlight ocp property.
- Use the enum to list the supported value.

Since v2:
- Change the property name from 'richtek,bled-ocp-sel' to 'richtek,bled-ocp-microamp'.

---
 .../devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
index e0ac686..99e9e13 100644
--- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -47,6 +47,11 @@ properties:
     minimum: 0
     maximum: 3
 
+  richtek,bled-ocp-microamp:
+    description: |
+      Backlight over current protection level.
+    enum: [900000, 1200000, 1500000, 1800000]
+
   richtek,channel-use:
     description: |
       Backlight LED channel to be used.
-- 
2.7.4

