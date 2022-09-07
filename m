Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D805B040E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIGMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIGMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:36:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2D7B8F2E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:36:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so22153653lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ozxna7OXRQ1OVszMUY0d4yr30/luJFmuNl59JFfJkG8=;
        b=QCukGyHBPM9jdduoCbZKDn+hzV/Qcsh4gYl+qhJDpzhYaTsmS83u1eLps741qFH6co
         f4nW98pdQ7PoYlb1rFfRQVxLW0jz0ZudXoJNNfglGUTIacLM+lAesgbKCN68N38/NuhJ
         k4rm4G/h9n8TXqEd9LFifaq4SQDi/beubCM0BYZQGCrQWqjbtkJEIY7qd6l6lik/tt14
         Z3/xYJV3NQMjrTIOiX754fzZ2EhGWSXhgM1ZrCgv7MnOf9XmtBTWDNdgwNR/FjiYhqFq
         EZ7AWpPN/R70PgPgWHvLPi4WJRBtX74IUR/nghjWARqnbrx4yrDrxdqYqeOsDWAROcpH
         u2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ozxna7OXRQ1OVszMUY0d4yr30/luJFmuNl59JFfJkG8=;
        b=gNTUvJkkCei6gI7N5cXf10+gxfzQYpAeK7DHB2S1PIoIhpHy7SUyEvHChSU5MiUZdB
         cFt6BaihQdbOPM5C6XtE5MNkdvfRwe5RlZN11LNuanXymVAC5iXZ+JBexjbDGO/tKi3N
         VLLMXf/v+H/r3PrOm+YwyInV9sPZgYNSWM0bcyZId8GXM1ufOniseqoRvhwZmMPfva3H
         96wLVKY14W3aPEmoxnkWyY4GoATcZEutIsNWIbX5Y9+LdJW7/qButev0E7s+A8WDRBzo
         Agry8V/eGnKy5GujobhXOJxKZdQy5xu9R3DqndCcVNg7xKbwNcwmdsKTpF+w0MczjX3w
         0hOA==
X-Gm-Message-State: ACgBeo3IP/bzrFMraQ7L2szroilL1faBlwT9vuday6mQ3Raisyza9F3X
        M3G5sz9TZ8yEmGg+AdAP6yQSOA==
X-Google-Smtp-Source: AA6agR60oHI50O7D0hm2wWlJ1d8nquDuYmiJAAN55kaQZ5nyA9gJumDYI+sz1nutVOKJdWQcVpF8kQ==
X-Received: by 2002:a05:6512:239e:b0:497:a36a:9ae with SMTP id c30-20020a056512239e00b00497a36a09aemr1084228lfv.378.1662554198185;
        Wed, 07 Sep 2022 05:36:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b7-20020a2eb907000000b00261b4df9ec4sm2624062ljb.138.2022.09.07.05.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:36:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: power: reset: restart-handler: add common schema
Date:   Wed,  7 Sep 2022 14:36:30 +0200
Message-Id: <20220907123630.57383-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common schema for restart and shutdown handlers, so they all use
same meaning of "priority" field.  The Linux drivers already have this
property and some systems want to customize it per-board in DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See also:
https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro.org/
https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
---
 .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
 .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
 2 files changed, 33 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/restart-handler.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
index a72d5c721516..d3d18e0f5db3 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -25,6 +25,9 @@ description: >
   inactive-delay, the GPIO is driven active again.  After a delay specified by wait-delay, the
   restart handler completes allowing other restart handlers to be attempted.
 
+allOf:
+  - $ref: restart-handler.yaml#
+
 properties:
   compatible:
     const: gpio-restart
@@ -41,16 +44,6 @@ properties:
       in its inactive state.
 
   priority:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      A priority ranging from 0 to 255 (default 129) according to the following guidelines:
-
-        0:   Restart handler of last resort, with limited restart capabilities.
-        128: Default restart handler; use if no other restart handler is expected to be available,
-             and/or if restart functionality is sufficient to restart the entire system.
-        255: Highest priority restart handler, will preempt all other restart handlers.
-    minimum: 0
-    maximum: 255
     default: 129
 
   active-delay:
diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
new file mode 100644
index 000000000000..f5d22ca0cd45
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Restart and shutdown handler generic binding
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description:
+  Restart and shutdown handler device is responsible for powering off the
+  system, e.g. my cutting off the power.  System might have several restart
+  handlers, which usually are tried from most precise to last resort.
+
+properties:
+  priority:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      A priority ranging from 0 to 255 according to the following guidelines::
+        0:   Restart handler of last resort, with limited restart capabilities.
+        128: Typical, default restart handler; use if no other restart handler
+             is expected to be available, and/or if restart functionality is
+             sufficient to restart the entire system.
+        255: Highest priority restart handler, will preempt all other restart handlers.
+    minimum: 0
+    maximum: 255
+
+additionalProperties: true
-- 
2.34.1

