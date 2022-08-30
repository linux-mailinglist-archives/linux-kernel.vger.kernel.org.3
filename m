Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114DB5A61ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiH3La5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiH3LaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2C205CC;
        Tue, 30 Aug 2022 04:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD4F61567;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E6EC43470;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859001;
        bh=yWn0mchADNb4i5UW1sCKqU+i2ZXlFqRzep42z3Q8y7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuiSR07ow1+wX+R9+72Uf6S+Sp3GOR5GCPBx5PRbUKcScjo8Nu2iG6K1v/nARvoEQ
         JN5lam3e3XRDaSYTfmFNlRGYQZY7plhvx/1HqewWE3Azi9412RlSYBKnqxC8jdvyLO
         f1zCLZZcRidAdE9ELwLPMm0HTDLewrHscsCx4xu9M9WzjRi6HVitnmy/CNobpvMSKJ
         E0DrIWJr8SDGDAvem6Ou/6OuZG6MiTRneNWu9N5fJY/b+/cR/dsJ8skhjvATG/Rkbj
         BA3iM6jgvLfPFwoz6haD2wk5vpZRDklwBFvIYhHoKIMa8N0w8f63J5tcdjVyyrqIgl
         YIB8zss16h8eg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRO-00010v-Sk; Tue, 30 Aug 2022 13:29:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 23/30] dt-bindings: phy: qcom,qmp-usb3-dp: fix bogus clock-cells property
Date:   Tue, 30 Aug 2022 13:29:16 +0200
Message-Id: <20220830112923.3725-24-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fixes: 59351049ad15 ("dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml        | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 31f3ad2ee683..da7d8dfc631c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -31,9 +31,6 @@ properties:
       - const: dp_com
       - const: dp
 
-  "#clock-cells":
-    enum: [ 1, 2 ]
-
   "#address-cells":
     enum: [ 1, 2 ]
 
@@ -150,7 +147,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - "#clock-cells"
   - "#address-cells"
   - "#size-cells"
   - ranges
@@ -172,7 +168,6 @@ examples:
               <0x088e8000 0x10>,
               <0x088ea000 0x40>;
         reg-names = "usb", "dp_com", "dp";
-        #clock-cells = <1>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0x0 0x088e9000 0x2000>;
-- 
2.35.1

