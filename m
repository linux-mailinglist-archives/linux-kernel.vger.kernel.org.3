Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4756FF07
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiGKKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGKKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:36:06 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56429DB2EB;
        Mon, 11 Jul 2022 02:46:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C1B8CE009F;
        Mon, 11 Jul 2022 02:46:29 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P0BZemjs-lfy; Mon, 11 Jul 2022 02:46:29 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657532789; bh=1v2XP+X0BV0+f8lDEvEGGuJl3IIyEoqp6P3bTpGegCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7wts7AYrBwHrw2A/AKQVaDj0/QiuR67dbYSwOxWRq3uUKEC4jiMZ3kDWbNf/Iv2s
         x1tkIn84gzT35OIBWfYkMatpVMXtv4KqL3DehQ4He8rjMvftVfSTa8UC3fZy/MqTPE
         IAZDivY18pJQ30B4gqQIAdqKm9v+U+JAlrV1a5hmt4Pv8jHO9PlmuzSYwt3v+RSFS7
         KsXZwEOLCeW3yxsKZm5EXK31F3M9mJkQo3/2YthjK9OFJ6EY3/Yzajp9J7Akvcu20Z
         1gEXIrOkG1XC3ZnhbLZfJS7LTrO82zwz7pUY0KCta6Z0vjH1wSm29YGza9FDFDOlT9
         WKFKx4WSpynFg==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/3] dt-binding: power: power-domain: add power-supply-needs-irq
Date:   Mon, 11 Jul 2022 11:45:48 +0200
Message-Id: <20220711094549.3445566-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power-supply-needs-irq board description property for power domains.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../devicetree/bindings/power/power-domain.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 889091b9814f..e82c2f7ccb97 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -70,6 +70,16 @@ properties:
       by the given provider should be subdomains of the domain specified
       by this binding.
 
+  power-supply: true
+
+  power-supply-needs-irq:
+    type: boolean
+    description:
+      A power-supply can link for example to a regulator controlled via
+      i2c or otherwise needing interrupts enabled to be able to enable and
+      disable. This property makes various callbacks usually run in the
+      noirq phase, being run when interrupts are available.
+
 required:
   - "#power-domain-cells"
 
-- 
2.30.2

