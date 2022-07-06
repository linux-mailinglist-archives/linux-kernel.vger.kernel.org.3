Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC35686B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGFL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGFL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:29:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D225C4B;
        Wed,  6 Jul 2022 04:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F5BB81AE0;
        Wed,  6 Jul 2022 11:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56129C3411C;
        Wed,  6 Jul 2022 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657106949;
        bh=GvN3mQgjOamdQTg3riR+7vwKF1Gt9KXU0ujXPuAgHdc=;
        h=From:To:Cc:Subject:Date:From;
        b=kQuAJ2oZASoqhrMmZluDfCTX6Gc4LBTwnLXgd3jr6trS7VlhJ2MjyPTUFwqtOrS7j
         Lly7oWb1/aWEW+FY3vYAcZyfNBn1sGYCuW6miBrKt4UxWOx7X362KGdbAiqnTPuvAs
         hcolkQNOPGFvaJn/JXp+Y521TSjYF8Ku9I12XDg3MhVSXQQIDO+NqyYXztJVtLeSn+
         uLmZ+eAVxK+6LosvYK+Z3UV6QmmQpbjOZgM/TPzo8HoGQnL46dlaOiAd7wQlZvLByj
         3MDlpZJzbYSJabmPmnxZsvsZTn6/FpSyDmnF9SBzReUvak7y8ER2PyKqtHA8LrOPRO
         ocmU+q46xamFQ==
Received: by pali.im (Postfix)
        id BE99E7BA; Wed,  6 Jul 2022 13:29:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add value property
Date:   Wed,  6 Jul 2022 13:28:27 +0200
Message-Id: <20220706112828.27278-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to define inverted logic (0 - enable LED, 1 - disable LED) via value
property. This property name is already used by other syscon drivers, e.g.
syscon-reboot.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../devicetree/bindings/leds/register-bit-led.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.yaml b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
index 79b8fc0f9d23..d6054a3f9087 100644
--- a/Documentation/devicetree/bindings/leds/register-bit-led.yaml
+++ b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
@@ -43,6 +43,17 @@ properties:
         0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
         0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]
 
+  value:
+    description:
+      bit value of ON state for the bit controlling this LED in the register
+      when not specified it is same as the mask
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      [ 0x0, 0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, 0x100, 0x200, 0x400, 0x800,
+        0x1000, 0x2000, 0x4000, 0x8000, 0x10000, 0x20000, 0x40000, 0x80000,
+        0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
+        0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]
+
   offset:
     description:
       register offset to the register controlling this LED
-- 
2.20.1

