Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E7A484DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiAEGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:04:06 -0500
Received: from box.trvn.ru ([194.87.146.52]:37417 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237639AbiAEGED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:04:03 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 420F642077;
        Wed,  5 Jan 2022 11:04:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641362641; bh=0iuDf5aFUiE3JU9JwKkEu11b1MvWifmGotGBDvsIXfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvFwTmKawnd41uNXE4CQ6qV3lqGF1F4rPgxkKNMhQZByrCqaM3oMBNTEfFeERZIsH
         83mhvGbYzm/3/G5rjRLY5VvgDKGOh/aaTc7uorkWZgbJvuHULj/bY90tRRxgIbOTvj
         dP6d2ZuWShCfS4j31zdKf2AY0NCZBV9z7a82dRMIbeVn84U+PbVnBKiCD5lgVVFnhF
         2ctND/Spcc+Q3FLvRTrTTWlJya8HjlnyXjRBo5QLZuBxgxygzQSIEVbaDNZ1tvZJpO
         DO0LSlEOpW4pncd8QeE+qFSrtzy9tz7N0qTOUsH8/J0eMlhqLzN/lPll/PZtLUZJ5y
         T8vSNHx6gZ5Uw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 5/6] dt-bindings: input: zinitix: Document touch-keys support
Date:   Wed,  5 Jan 2022 11:03:22 +0500
Message-Id: <20220105060323.7928-6-nikita@trvn.ru>
In-Reply-To: <20220105060323.7928-1-nikita@trvn.ru>
References: <20220105060323.7928-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations the touch controller can support the touch-keys.
Document the linux,keycodes property that enables those keys and
specifies the keycodes that should be used to report the key events.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
 - Include input.yaml schema at the top level instead of at the
   property. (Seems like I still can't think of the schema as device
   and not implementation-specific thing...)
 - Reword the description to be more informative.
---
 .../bindings/input/touchscreen/zinitix,bt400.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
index b4e5ba7c0b49..67ed853289b2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
@@ -16,6 +16,7 @@ maintainers:
 
 allOf:
   - $ref: touchscreen.yaml#
+  - $ref: ../input.yaml#
 
 properties:
   $nodename:
@@ -79,6 +80,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2]
 
+  linux,keycodes:
+    description: |
+      This property specifies an array of keycodes assigned to the
+      touch-keys that can be present in some touchscreen configurations.
+      If the touch-keys are enabled, controller firmware will assign some
+      touch sense lines to those keys.
+    minItems: 1
+    maxItems: 8
+
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-fuzz-x: true
-- 
2.30.2

