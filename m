Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9B85666F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiGEJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiGEJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3951209E;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4CC6192E;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D763C341EE;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014543;
        bh=2mTzUOp7tdPQMM7Xc9YC7rFHgcOOSo/32RHu2yNuMEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmLRZ09r97aAxUAe7aAEHwhG0MQCHv9ZOlPsm8H1h1xuhgV/uYUCKD9M7aXBjWpFh
         sv+vQlMjzxJhy+Oy8JDoueLwU3L4/zvgiINNjNGMINSk/4CDYTEiMzrqfM50yySZ7e
         vE2pu2WbUNduriouHKna7F50M7f0Oc1/IAjNi15BpR26Swl8FdoZooGJkYdy++yjrj
         a6h4F5EAgv+rfXcW8NBs6UEf9/vR69E6iAlo1qX8JeX2inBCQk0Sox+M7eFl6I1lqs
         OjT0DYgSBNlyR0k8ZMNukr2L5woRMoSoOznptW5XeubJqzOBTiz6iiCzu8pSavahVI
         RS1i1k9z9NvHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB2-0004Xs-Fb; Tue, 05 Jul 2022 11:49:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 22/43] dt-bindings: phy: qcom,qmp-ufs: clean up reset providers
Date:   Tue,  5 Jul 2022 11:42:18 +0200
Message-Id: <20220705094239.17174-23-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705094239.17174-1-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
MIME-Version: 1.0
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

The UFS binding requires a single PHY reset.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index c4458d90d8b7..b84511f02221 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -52,12 +52,12 @@ properties:
     maxItems: 4
 
   resets:
-    minItems: 1
-    maxItems: 3
+    items:
+      - description: PHY reset in the UFS controller.
 
   reset-names:
-    minItems: 1
-    maxItems: 3
+    items:
+      - const: ufsphy
 
   vdda-phy-supply:
     description:
@@ -108,12 +108,6 @@ allOf:
         clock-names:
           items:
             - const: ref
-        resets:
-          items:
-            - description: PHY reset in the UFS controller.
-        reset-names:
-          items:
-            - const: ufsphy
 
   - if:
       properties:
@@ -137,9 +131,3 @@ allOf:
           items:
             - const: ref
             - const: ref_aux
-        resets:
-          items:
-            - description: PHY reset in the UFS controller.
-        reset-names:
-          items:
-            - const: ufsphy
-- 
2.35.1

