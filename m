Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488256670A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiGEJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiGEJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C248C11A3C;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 06669CE1AFB;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41659C5832B;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=Uy3ubjYoX5YJYX58mI9UPoE9fqVXua8OSCQpJb2PU1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Azmpn8cgQxvEZAv6C7gZhDSRXXzBhLvdrM9syVpU7MwqQ0BoGarnkbKg5y3FnCCq4
         4g0XK7pwzQ+fI2lg/WjWR1bj7NO5s1An+Z1tMzYPn6Rh4unbjEo8s20FoxQ+VPzaYM
         TE2gt2fQWPce2XaDObPbqB5l4UyDARwGSGGtoDnLJECeueCHFjifnfMiePiCJI198W
         kcajFc/72X/6jNI3i9kFZyQXTSGhh1qvOkfnLw6iw2VNKFe+yx9y5owL0XYH/nWB9Y
         Rfj/5Oay1bk8hxdFiy/Wg1rLyhk8hbt9fJ7EWjC1/dDBG+/aqGJTgXKkJMTaIle963
         rX/fgvl6zpnTg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004YK-9N; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 31/43] dt-bindings: phy: qcom,qmp-usb: clean up supplies
Date:   Tue,  5 Jul 2022 11:42:27 +0200
Message-Id: <20220705094239.17174-32-johan+linaro@kernel.org>
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

The USB PHY binding requires the vdda-phy and vdd-pll supplies.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-usb-phy.yaml        | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 2f7043503ca0..3404ad7fc6db 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -95,6 +95,8 @@ required:
   - clock-names
   - resets
   - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
 
 additionalProperties: false
 
@@ -127,9 +129,6 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
   - if:
       properties:
@@ -158,9 +157,6 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
   - if:
       properties:
@@ -190,9 +186,6 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
   - if:
       properties:
@@ -225,9 +218,6 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
   - if:
       properties:
@@ -256,9 +246,6 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
   - if:
       properties:
@@ -286,9 +273,6 @@ allOf:
           items:
             - const: phy_phy
             - const: phy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
 examples:
   - |
-- 
2.35.1

