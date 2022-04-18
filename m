Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6539505E14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347481AbiDRSws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiDRSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:52:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E801D33F;
        Mon, 18 Apr 2022 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650307795; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nc5sIEFkzgJ2j9U+7Rs4qBYEvdcvvjY3ksRsV+cjhc=;
        b=0zEbo+PYGQgtMfZM6hGiyltpSPPhFv8Y6+yi5oZYU78tTx4Vkcn8sr25so6RaGPhgkhRBD
        DeRV7xdx24/fVfMveXZv3OhVITOodRIvVfZcFS4CiC0NXL8rtbhzcjhIwldqUE4JeJjBGh
        AEuxC66TNNwuE8EgsyqV4/+n2doloCE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     list@opendingux.net, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 1/5] dt-bindings: rtc: Rework compatible strings and add #clock-cells
Date:   Mon, 18 Apr 2022 19:49:29 +0100
Message-Id: <20220418184933.13172-2-paul@crapouillou.net>
In-Reply-To: <20220418184933.13172-1-paul@crapouillou.net>
References: <20220418184933.13172-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC in the JZ4770 is compatible with the JZ4760, but has an extra
register that permits to configure the behaviour of the CLK32K pin. The
same goes for the RTC in the JZ4780.

Therefore, the ingenic,jz4770-rtc and ingenic,jz4780-rtc strings do not
fall back anymore to ingenic,jz4760-rtc. The ingenic,jz4780-rtc string
now falls back to the ingenic,jz4770-rtc string.

Additionally, since the RTCs in the JZ4770 and JZ4780 support outputting
the input oscillator's clock to the CLK32K pin, the RTC node is now also
a clock provider on these SoCs, so a #clock-cells property is added.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
---
 Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
index b235b2441997..57393c3ac724 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
@@ -18,14 +18,14 @@ properties:
       - enum:
           - ingenic,jz4740-rtc
           - ingenic,jz4760-rtc
+          - ingenic,jz4770-rtc
       - items:
           - const: ingenic,jz4725b-rtc
           - const: ingenic,jz4740-rtc
       - items:
           - enum:
-              - ingenic,jz4770-rtc
               - ingenic,jz4780-rtc
-          - const: ingenic,jz4760-rtc
+          - const: ingenic,jz4770-rtc
 
   reg:
     maxItems: 1
@@ -39,6 +39,9 @@ properties:
   clock-names:
     const: rtc
 
+  "#clock-cells":
+    const: 0
+
   system-power-controller:
     description: |
       Indicates that the RTC is responsible for powering OFF
-- 
2.35.1

