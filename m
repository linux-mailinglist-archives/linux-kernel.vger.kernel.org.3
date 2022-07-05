Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C3D56669E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiGEJtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiGEJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52438A1;
        Tue,  5 Jul 2022 02:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD7361919;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311AAC341D5;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=Vc4R/y9mBKNiS8vedJbz+BXjfJtt2YyS5z6mX/z//hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Afj5P0paU3YpfxgARnGWfWsYUTPCDSiRtwOuY6FrgR4Nlnn4dqDfypytdrb3xtaW9
         wYq56e6bYXXo0pFHlbm7z8CAJeaLAbCjgcqB8YQpTQQEXmzYCZbtGMhOFpgSjg9/2i
         t9kchhKGDu7t3WBG1P4Zg/L1DvtbjP2MRAQAst20AS57duMtPUzebjcYOT6hSB0FPe
         JqcEpUZ02JMH0QdOhc9+odl3Zz62+yEGNWQcUOUuoBP8o42QeOrL5iDKWGfOBgH1Qk
         0XEPGvAc308gPAj8j6wYbqDigo3rgMkddGlj45zryD6vUoV0fXtcqpljE3PbxuwnII
         1XVXE96bfbncA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB0-0004Wt-Jl; Tue, 05 Jul 2022 11:49:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 01/43] dt-bindings: phy: qcom,qmp: fix bogus clock-cells property
Date:   Tue,  5 Jul 2022 11:41:57 +0200
Message-Id: <20220705094239.17174-2-johan+linaro@kernel.org>
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

The QMP PHY wrapper node is not a clock provider so drop the bogus
'#clock-cells' property that was added when converting to DT schema.

Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 8b850c5ab116..f74b3bf34a23 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -66,9 +66,6 @@ properties:
       - description: Address and length of PHY's common serdes block.
       - description: Address and length of PHY's DP_COM control block.
 
-  "#clock-cells":
-    enum: [ 1, 2 ]
-
   "#address-cells":
     enum: [ 1, 2 ]
 
@@ -116,7 +113,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - "#clock-cells"
   - "#address-cells"
   - "#size-cells"
   - ranges
@@ -468,7 +464,6 @@ examples:
     usb_2_qmpphy: phy-wrapper@88eb000 {
         compatible = "qcom,sdm845-qmp-usb3-uni-phy";
         reg = <0x088eb000 0x18c>;
-        #clock-cells = <1>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0x0 0x088eb000 0x2000>;
-- 
2.35.1

