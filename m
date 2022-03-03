Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDF4CC34F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiCCQ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiCCQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:58:11 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D1382;
        Thu,  3 Mar 2022 08:57:25 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so6460636ooi.2;
        Thu, 03 Mar 2022 08:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGCumHgMLBELRu52rk5UqShkzz2ZUaCbCoiX7DHIJjo=;
        b=3daa/Xi6PRdQVAlbzp0kfVKo6cW9IllCPEh1rgDtJM/YFEKfz/QfnBZO6ZuO+tWA2l
         rMZRgMdDAQhWDR3biBOC4jwA6IJV/EeczDdcN44758lwZmRMbLMnyH5tNgZXX5qp+xEQ
         rNDuoDBE1bjECG+CywGheBzjiOG3Sp8+ncEbocldysocdeGtRFh/cYFq5zkmD1Qpt0hv
         5HTE5Hr5chRteD2xK9tgrq/KWqIwhn7XNyJsfg9U9EY5lpD1c66jktG9EbyrT/rOJSR7
         7HI5PQNPcWUjg3qroOanuJ5egZE9bOnrvtmfhBNKYjtXmcuy5p0M+yVVoNwt8BMa5ees
         4Jww==
X-Gm-Message-State: AOAM532VSCD0tB8CjprYB4bJ7906DwW373klPCuk3ZxU2nBdYDYrVHsk
        6ssNaY8ibb5SkeEYFwA2ko1jvEizGw==
X-Google-Smtp-Source: ABdhPJwXDCjm/ogChH0mahEYJGjHROaJuT/GNQDy5B6m7ZeQMkVYPgNQGQYbmPKjCrLxG505HRERSQ==
X-Received: by 2002:a05:6820:552:b0:31c:5eca:fa40 with SMTP id n18-20020a056820055200b0031c5ecafa40mr18682006ooj.82.1646326644797;
        Thu, 03 Mar 2022 08:57:24 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id l20-20020a056820031400b0031cf5913126sm1155125ooe.36.2022.03.03.08.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:57:24 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Allow 32-bit 'cpu-release-addr' values
Date:   Thu,  3 Mar 2022 10:57:09 -0600
Message-Id: <20220303165710.1859862-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

While the DT Spec says 'cpu-release-addr' is always 64-bit, some 32-bit Arm
DTs used a 32-bit value. We're now stuck with those cases, so add uint32 as
a valid type.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 85a31ca862d0..ed04650291a8 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -233,14 +233,14 @@ properties:
           - ti,am4372
 
   cpu-release-addr:
-    $ref: '/schemas/types.yaml#/definitions/uint64'
-
+    oneOf:
+      - $ref: '/schemas/types.yaml#/definitions/uint32'
+      - $ref: '/schemas/types.yaml#/definitions/uint64'
     description:
+      The DT specification defines this as 64-bit always, but some 32-bit Arm
+      systems have used a 32-bit value which must be supported.
       Required for systems that have an "enable-method"
         property value of "spin-table".
-      On ARM v8 64-bit systems must be a two cell
-        property identifying a 64-bit zero-initialised
-        memory location.
 
   cpu-idle-states:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
-- 
2.32.0

