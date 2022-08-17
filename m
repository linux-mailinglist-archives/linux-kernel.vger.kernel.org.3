Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14D59698C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiHQGZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHQGZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:25:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D87969D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:25:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c28so13749545lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=m0s8lq0ZE5dtbPoTxENvKQgRbYkC4Hv5FjBGALWO43w=;
        b=l5Shbj4CqrnxxetEyGEMZbaySC8XW1ZtUiPGbHF6A7nm0Y/+THbDt8fd3hw1NnxM6P
         0HMwOfLxDKxSl1iVD1IR6N/B+jPRtAAjPoEEQobx5kioFs3d74hdH26FJLqSL3eYTkBp
         lgYhNKY7blfmYp8l00yB7wlwhabM9AjcDqySml8YRMngakKAQ/tZ4zUAa7nVLpjgVZT1
         MIXFb2SoLoHxQqzjeiu/d2e+NwCXSmuK5kp5HZ7TEjATkWePvW+pxKLn75t5rjp+yBsm
         pxXUhHzw1IWgNubq3PfadZTsEN0Jawu52Hh9U+O2ckHSe7ce7C9RGN9YEl8Qm6NUDTBU
         dAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=m0s8lq0ZE5dtbPoTxENvKQgRbYkC4Hv5FjBGALWO43w=;
        b=st2jmwgVIO7rUvsqttlWHZjNjaMvQWXLrVEeo4agG1UY9xJjI7DM3r07zjzQ+T7xPH
         Ga34tMXJ/YDfvdqYvb13tGHdU279mjZQLOlLTQ9OxDQCclEdpSWCJA28W20rWWrfSFmK
         1IVd03x5fHdfrBGyjtHnb+LfsB5qE7h+j0tw1rHMzmNpRmVm/KD8FCeQM2fKOAVYC/j/
         +PSI82LIT+Vhf2zIbAhy1EtGL2OVhBsc9LRFytqxtoI8sYyPdLAblhnXvpYXQbsYz5FI
         oTVBHJBwUdrmmgGURODqGBYqaCUS1tgjeoxSfs+Pw+10kBtdAGDfzNsbvtBOos4q+74C
         3TMg==
X-Gm-Message-State: ACgBeo190bwafcdE7vK4rSz1Qso531dwjpUSWGBlJpDHQPnPtkBnCs/D
        e9wn/m1BstLo93D8OE/FbS+MQA==
X-Google-Smtp-Source: AA6agR788tLbvIi0il7fkyZ8+svc4RBeE51Ahvwg47GsGIxJxBJlejvkdjwnZaczuCQcSkczVcZBww==
X-Received: by 2002:ac2:5b8d:0:b0:48a:f61d:68a6 with SMTP id o13-20020ac25b8d000000b0048af61d68a6mr8050433lfn.603.1660717553716;
        Tue, 16 Aug 2022 23:25:53 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e9215000000b0025e42641a32sm2069836ljg.123.2022.08.16.23.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:25:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: gpu: arm,mali: restrict opp-table to objects
Date:   Wed, 17 Aug 2022 09:25:47 +0300
Message-Id: <20220817062547.20122-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple 'opp-table:true' accepts a boolean property as opp-table, so
restrict it to object to properly enfoerce real OPP table nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 3 ++-
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index d209f272625d..2a25384ca3ef 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -74,7 +74,8 @@ properties:
       - const: bus
 
   mali-supply: true
-  opp-table: true
+  opp-table:
+    type: object
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index eceaa176bd57..318122d95eb5 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -101,7 +101,8 @@ properties:
 
   mali-supply: true
 
-  opp-table: true
+  opp-table:
+    type: object
 
   power-domains:
     maxItems: 1
-- 
2.34.1

