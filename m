Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92C51833F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiECLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiECLa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:30:58 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD762B27B;
        Tue,  3 May 2022 04:27:25 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1651577243;
        bh=X1P1czu7olInCuAQsy8kh9ER4hFIClKs76hLpKYw1KQ=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=C++waFrmpLW4z31URtuRSBlGy4QI0L2rbDWoUO0GDTF7R07CpWNLWq+fAFfWfYf4/
         TnhEW3Uaz+dbwcBhEq9TVXDqef0KGLqi07m78Pzr3Yp1I+orngCyr3t1HoSKcVjwb0
         dhSUxaWYTLtQfHNoBfTTzCg+8FX/3wcG0HGAkNaG+YGM9lRNHLn5McrmMtP0opPrlF
         0SjV3M2W6rz7wRckPlp9uvR6NRFxSzczMo+IlXOQ3N1tta44NzPfJHoR0NUF3pIKRD
         WBxk3a03yBW7tkkRgdG6F0yABOt9mnEKc1AiFVnTTRvyvhXo3WQct/J9iKc+VmvTil
         cPep9RBxYGCJg==
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: [PATCH v2 1/2] dt-bindings: leds: Add multi-color default-intensities property
Date:   Tue,  3 May 2022 13:27:06 +0200
Message-Id: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651577132.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <20220502204616.GA27288@ucw.cz>
References: <20220502204616.GA27288@ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This allows to assign intensity values to the indivisual sub LEDs
(colors) at driver probe time, i.e. most commonly at kernel boot time.
This is crucial for setting a specific color early in the boot process.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    V1->V2: no changes

 .../devicetree/bindings/leds/leds-class-multicolor.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index 37445c68cdef..c483967a847c 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -31,6 +31,13 @@ patternProperties:
           include/linux/leds/common.h.
         enum: [ 8, 9 ]
 
+      default-intensities:
+        description: |
+          This parameter, if present, sets the initial intensities of the
+          individual colors. This array must have the same length as the
+          multi-color LED has sub LEDs (colors).
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
     $ref: "common.yaml#"
 
     required:
-- 
2.36.0

