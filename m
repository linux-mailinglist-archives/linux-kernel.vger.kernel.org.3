Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09E2586BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiHANQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHANQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:16:08 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBAA2B267;
        Mon,  1 Aug 2022 06:16:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79084C01B3;
        Mon,  1 Aug 2022 15:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659359765; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=dDXHjR+rY6x+7wr/ZTif7aTyQ06P/cqOLoN75cSeQSE=;
        b=X9iZc0Z4Au8xcwh5BGUVPUeW3PFbUuPS4d/S5zwhSWxhWC5VKweWWKXGBzI7A65c6IRDgy
        6TQ0cf/rOvjHbEN77cEfasgFG01SYcqEKtu+/gR57QoPPFejxE9vauR5Sm5b5RiqW8ZDaT
        /2LMfY2ThnJP92ws7h7vl01KtjARfxejAigX+2bTAxTbPxtZZnEaTBBw75/R2CPw2C+K9Z
        CV9SO0ofCusjMwa7wEf359uxwD/s5DUJUrauAbYSL47KJN7Hp0JgQSzYQ+cITi9XntYZDi
        F7/FV/hTKL1EwCa0yCU4s2lvQeXXzYTJvbNjo+egk621ozMcefkHdwaqfPvv1g==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
Subject: [PATCH v2 2/8] dt-bindings: regulator: pca9450: Allow arbitrary regulator names
Date:   Mon,  1 Aug 2022 15:15:46 +0200
Message-Id: <20220801131554.116795-3-frieder@fris.de>
In-Reply-To: <20220801131554.116795-1-frieder@fris.de>
References: <20220801131554.116795-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Instead of restricting regulator-name to non-descriptive names, allow
to use arbitrary strings. This enables us to use the name of the
voltage rail that is powered by the regulator as some board DTs
already do.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
* new patch
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml         | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index b539781e39aa..b1e4fd09928b 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -49,9 +49,9 @@ properties:
 
         properties:
           regulator-name:
-            pattern: "^LDO[1-5]$"
             description:
-              should be "LDO1", ..., "LDO5"
+              Should be "LDO1", ..., "LDO5" or whatever the name of the boards
+              voltage rail powered by this regulator is.
 
         unevaluatedProperties: false
 
@@ -63,9 +63,9 @@ properties:
 
         properties:
           regulator-name:
-            pattern: "^BUCK[1-6]$"
             description:
-              should be "BUCK1", ..., "BUCK6"
+              Should be "BUCK1", ..., "BUCK6" or whatever the name of the boards
+              voltage rail powered by this regulator is.
 
           nxp,dvs-run-voltage:
             $ref: "/schemas/types.yaml#/definitions/uint32"
-- 
2.37.1

