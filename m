Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BF507D09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358378AbiDSXGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347369AbiDSXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:06:16 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DA2611E;
        Tue, 19 Apr 2022 16:03:32 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 80EA022248;
        Wed, 20 Apr 2022 01:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650409410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pF8LG5F8NwFab7DCpCeNAFG08MwxqutfST9nL8U0DGU=;
        b=Q5X/L/9QQ278d/vKZfhx5R5kJ6qyUhY26zHq8B5oKJQ+J5lVc4nHIJVR8OIuY4jr4yI4tC
        gq/RhDPbaUcuBSzdaVGVfFw2kZL2AfY9ilGZi/qY4DJDbLsU5gd4t4GfFv8a2O+jjt+mrq
        wzVHEHKNJfCgSCykbvc7zXB2lCSb9J8=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: ocelot: add reset property
Date:   Wed, 20 Apr 2022 01:03:23 +0200
Message-Id: <20220419230324.3221779-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419230324.3221779-1-michael@walle.cc>
References: <20220419230324.3221779-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the LAN966x SoC the GPIO controller will be resetted together with
the SGPIO and the switch core. Add a phandle to register the shared
reset line.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
index 7149a6655623..98d547c34ef3 100644
--- a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
@@ -42,6 +42,14 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    description: Optional shared switch reset.
+    items:
+      - const: switch
+
 patternProperties:
   '-pins$':
     type: object
-- 
2.30.2

