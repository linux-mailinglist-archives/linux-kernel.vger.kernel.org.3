Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DAB545521
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiFITmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiFITmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:42:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA041FA0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=Iz08tVktvNrbowTeGbModb3qzWC
        sOcZZTav84wWb4W4=; b=uUEr2opAfqH2G3i89GbrxTWooooQcTpVRO3II2T2ZLU
        +2fe+RlIH0pic2xOlSFlqMCQTI5760kzLa+JZBibQR+7ck4eWloFGszZdvbtV8+f
        +EjZYnz60u7ADD8w5+vqeRCtRH+6f0LCdcTGZs4OARyx1G46lIYKqvq2QcF28MIY
        =
Received: (qmail 3437072 invoked from network); 9 Jun 2022 21:42:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2022 21:42:11 +0200
X-UD-Smtp-Session: l3s3148p1@GvcPBAnhM0VZD+/V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support
Date:   Thu,  9 Jun 2022 21:41:53 +0200
Message-Id: <20220609194154.12829-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for R-Car S4. The S4 IP differs a bit from its siblings in
such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
are not routed to the INTC-AP but to the ECM.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1:

* Describe that this SoC does not require interrupts (Thanks, Geert!)

I hope dtbs_check is happy now. I can't test it because I get tons of
python install errors when trying to update my dtschema :(

 .../devicetree/bindings/thermal/rcar-gen3-thermal.yaml   | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index 1368d90da0e8..08001d6fa67c 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -8,9 +8,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Renesas R-Car Gen3 Thermal Sensor
 
 description:
-  On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
-  sensors (THS) which are the analog circuits for measuring temperature (Tj)
-  inside the LSI.
+
+  On most R-Car Gen3 and later SoCs, the thermal sensor controllers (TSC)
+  control the thermal sensors (THS) which are the analog circuits for
+  measuring temperature (Tj) inside the LSI.
 
 maintainers:
   - Niklas Söderlund <niklas.soderlund@ragnatech.se>
@@ -27,6 +28,7 @@ properties:
       - renesas,r8a77965-thermal # R-Car M3-N
       - renesas,r8a77980-thermal # R-Car V3H
       - renesas,r8a779a0-thermal # R-Car V3U
+      - renesas,r8a779f0-thermal # R-Car S4
 
   reg: true
 
@@ -63,6 +65,7 @@ if:
         contains:
           enum:
             - renesas,r8a779a0-thermal
+            - renesas,r8a779f0-thermal
 then:
   properties:
     reg:
-- 
2.35.1

