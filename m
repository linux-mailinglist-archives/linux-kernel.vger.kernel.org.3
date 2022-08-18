Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F77597E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiHRGP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiHRGPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:15:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D89352F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:15:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o2so889248lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=lHFbiCnPlh8rFbDy4RC1CMtmGsk/EvGiejplMwBZ6t4=;
        b=aHM2W+eNDfg5HYRawTx7fay0ZrwX3j9AkmFQO/80A/Tr/2yxQpHmxy9OfQc+Xby3NA
         lLEcvCysvGFofPt5dGWbtt7itYRDh4QDHFvqaq0P7U2AZDXXnw485xzwy7CNfAlWZeCz
         zRSbXVz3KKL6NxrZqq2MhRs/n4QXLoBLnqQ1UXwLKj7ZvNcIGzu67TZ3QoETkdmbZCVf
         ISD4An6W+p7+C6GhYAeKNB80PtRiI0qGjKTROhFFhOtIMQTfCinIQFQ5F2tE/tOhPp4q
         r2iXoYtKkOKZKv5EbgLpjiF/Mi8nMkfbOT2P0VSRXRWPe/4WcZ5V7EdmDsUgVjTvMp2q
         Y1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=lHFbiCnPlh8rFbDy4RC1CMtmGsk/EvGiejplMwBZ6t4=;
        b=Ep7NjfqSBZtqMThimC70lz8yDXthw3suA+C2InmsMlpKDoYhjydHTCBYTxLYcDCa4t
         3LaxdTdNB+zv8Fv+E0NRX9dGI/1M3SuJVJOUG6ER8oO3Xlsd/Kzt7EziOm7RtQWpN5ew
         Sc2QzkkwrbEo8gI6SdCnmrhEcurZqoOICfME0pWmjj58OrpRpIfK28/Te+vEdEIeBGCb
         cSdR1JPeQvx0YnmBXfRJkzl7DBK6F6kzb6ss6sVDb3LSAvbEl20pf1RkIpZVxlvDgKpE
         ZTZQKn00MQgijMiqlDTMhRfzxGgi4nOePyVSMd3EnvO37neCXpJ5zIrhDbIu6n1Yh0hF
         5IkQ==
X-Gm-Message-State: ACgBeo3CuXezKRKZ7XU9lQy+8d3E1HSU+JRlwZzijw9nymd8iqBrBP8s
        yKePRExSsxhWa2RF3j7UE+UGNQ==
X-Google-Smtp-Source: AA6agR7yYaou2ubazzmZUOD+5aj3xw0+OQjhUPj3PNj9tTz5EJjh/9ycqQUd8T/g75pkmydzS2VNYw==
X-Received: by 2002:a05:6512:1681:b0:48d:adaa:446a with SMTP id bu1-20020a056512168100b0048dadaa446amr510571lfb.355.1660803352231;
        Wed, 17 Aug 2022 23:15:52 -0700 (PDT)
Received: from krzk-bin.. (d15l54bxv1k5c31plwt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:671:aa32:2bd5:8994])
        by smtp.gmail.com with ESMTPSA id x25-20020a056512131900b0048aec70f7e6sm92132lfu.194.2022.08.17.23.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:15:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] dt-bindings: memory-controllers: fsl,imx8m-ddrc: restrict opp-table to objects
Date:   Thu, 18 Aug 2022 09:15:49 +0300
Message-Id: <20220818061549.9087-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple 'opp-table:true' accepts a boolean property as opp-table, so
restrict it to object to properly enferce real OPP table nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Peng Fan <peng.fan@nxp.com>

---

Changes since v2:
1. Correct typo in msg (Peng).
2. Add Ack.

Changes since v1:
1. Correct typo in subject.
---
 .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
index 2b39fce5f650..519b123116dc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
@@ -47,7 +47,8 @@ properties:
       - const: apb
 
   operating-points-v2: true
-  opp-table: true
+  opp-table:
+    type: object
 
 required:
   - reg
-- 
2.34.1

