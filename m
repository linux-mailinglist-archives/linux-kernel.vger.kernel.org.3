Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392A84DD0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiCQXCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiCQXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:02:11 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A614CD2C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so9201463ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6pGCFpZSVA4WdsVequ/uBV4TZcR3KGRwpFzQt31iO0=;
        b=isLQpVpqqqpoxVPtT8WrHxtM5GoA0rV+2IKxJmqv60ltU27HtXf/xyJ2Ppz5OdoonC
         Q8+TnxmwAn48uYay80ZFcY5QiOAg9OuxdiBxYH1MPBGlA4KrRBGSFLqq73S5cWYkqlN6
         NtKSFXdcOCvcWKdw8XYy8kqrYsz6yzq2klfbEGXZQoZLOaXywCCPeFEbBy3uAUnkldNv
         ko3HqF8WEkdZbbC5WfIV61RgNOiBWvIJOU6b2Ad0t9WlHCsCnPjpxjvLzbtCWHYjKqVj
         /DqNs1l4b1nMCHKOG7xAkpa8SAsDUojQV56nXaFgCqSwUDy2hiidgcLI25Qdikdx/GKV
         KnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6pGCFpZSVA4WdsVequ/uBV4TZcR3KGRwpFzQt31iO0=;
        b=u2WPXq0SZEk7t0cIGwsq1S/T2LUeDDY8H+tjKGcb185b2vYCGv5VrhTgUkgy5I9JwY
         3Z78Jdyz4v5OtbrP56qAlWn53tyNEWhMJ4G7HAjmivXwRTqTDWqiwPgL25WA22PwISxc
         npKkhfCisE8Kk+ji0DEjqv41zyqY//zgovAqDBWnZ8NqmhU0aceRaSeA1f0QniJ/BMeS
         QOUy6BjDg6vvUBur4WGcOncojky+5u44AhsMmbr6rFsMbVUO1l144CdXZbzbqoCzSmTI
         ziEuCrPvuPGE0+UR+n2ifhYWcoQ5w+0t0GG9MbS2zKXZ4VqW73h4yPsH1fF/W1AKixNs
         XkIA==
X-Gm-Message-State: AOAM530xZjjjtFUmPSnVt/CUyx8AVA4QXmibI3tR0j/il821nIRieWPp
        5OkxeDHafnnhlVwneMKahPbzcg==
X-Google-Smtp-Source: ABdhPJyxUj4uP2bWGRXszAdwLp7lM5cQT/CyvD3iLcClfAMJRw+eYpxHl0DUCy4dafeN5jmkwbGBYw==
X-Received: by 2002:a2e:834f:0:b0:249:357c:bf28 with SMTP id l15-20020a2e834f000000b00249357cbf28mr4380677ljh.102.1647558052195;
        Thu, 17 Mar 2022 16:00:52 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm191876ljv.35.2022.03.17.16.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:00:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/5 v2] dt-bindings: gnss: Modify u-blox to use common bindings
Date:   Thu, 17 Mar 2022 23:58:41 +0100
Message-Id: <20220317225844.1262643-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317225844.1262643-1-linus.walleij@linaro.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
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

This modifies the existing U-Blox GNSS bindings to reference
the common GNSS YAML bindings.

Fixed an unrelated whitespace error while at it.

Cc: devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change additionalProperties to unevaluatedProperties and
  cut the :true insertion of properties from the common
  props so new common properties get available immediately.
---
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 396101a223e7..35a760cfd343 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: U-blox GNSS Receiver Device Tree Bindings
 
+allOf:
+  - $ref: gnss-common.yaml#
+
 maintainers:
   - Johan Hovold <johan@kernel.org>
 
@@ -29,27 +32,20 @@ properties:
     description: >
       Main voltage regulator
 
-  timepulse-gpios:
-    maxItems: 1
-    description: >
-      Time pulse GPIO
-
   u-blox,extint-gpios:
     maxItems: 1
     description: >
       GPIO connected to the "external interrupt" input pin
-  
+
   v-bckp-supply:
     description: >
       Backup voltage regulator
 
-  current-speed: true
-
 required:
   - compatible
   - vcc-supply
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.35.1

