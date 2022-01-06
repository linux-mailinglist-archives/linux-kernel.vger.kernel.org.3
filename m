Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2B486106
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiAFH3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:29:47 -0500
Received: from box.trvn.ru ([194.87.146.52]:48347 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235610AbiAFH3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:29:40 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 949AC4A10A;
        Thu,  6 Jan 2022 12:29:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641454152; bh=0iuDf5aFUiE3JU9JwKkEu11b1MvWifmGotGBDvsIXfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThqJuqmMR/kJrLqvTr6zhOTBVyEZg1XLOUaOK3V6mc09CGsqI5LGXecPwh/oJrPCR
         YHq3s+JuOlHbVNJ/bzrf8ejfboOL+uC9e4V2+T7mspbbBbKtVG0VI6scSYskVdbURD
         CZzk/dR07EClbVf/lyDyADsnS6ZC5y6CbmztfxL7BbieqkGRiqUyOnG6jUMK0tnIh5
         sTZC7IrZL40GG5AxYhybgHcoYuXgKtYICXHImK0Q1sr+rqdhyHZCGcnQdX/Y3btZYT
         gMH4uKxXVaRLW33YJEOG7mLJgj3QpfMDRXnmmBykrXMXGAkuI5FnrhGWjWAat8ev3O
         1CDytkOU+L9vw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 5/6] dt-bindings: input: zinitix: Document touch-keys support
Date:   Thu,  6 Jan 2022 12:28:39 +0500
Message-Id: <20220106072840.36851-6-nikita@trvn.ru>
In-Reply-To: <20220106072840.36851-1-nikita@trvn.ru>
References: <20220106072840.36851-1-nikita@trvn.ru>
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

