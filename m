Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD258E5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiHJDys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiHJDy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:54:29 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8F6580A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:54:28 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k29-20020a9d701d000000b0061c99652493so9813299otj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ry+ibPoPjFsGLqx07kgp5fWkflkrTbeFQgZo2EyqkqE=;
        b=tw/iUHjUhBM1Jb0bsYEVv6P9HbZT21GNFQmSCWk4eLKD4mkBXqKwVGPJyvb1hddl4X
         9G42R6frr8FSAsgHfBHBpAzNxOd+LN6XSws1vIzWGDmgEWz1XnUQsrrtBmhbzS3q4ojZ
         gXnf4I0xyq9fASqWKTCnSINPY0QkCXPMxuxeTqFC9S27j2RjBQZswzvNs2nzc+RtstLJ
         mL9PwTzcZigQWfVtMNUoa2U6XuNkOSz39Xq4p/orcurCQGYnuLowRao1o2SzGoaei5wx
         L2NUBIw+R2CkNdMvyQHzgnZdxMsER3Oncl81qvrFtZqfw12/9ZpaX6SAL1ToQkzRb68z
         9FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ry+ibPoPjFsGLqx07kgp5fWkflkrTbeFQgZo2EyqkqE=;
        b=Chr55GNhzoP8V/h0OvK0VVBVsH2IcKT0PleNTpfXIW8BfwecXf71T4EhO0RXO/F7x1
         EVgZnl1Eutf/2rnfxGDFejlcMaL0we/kM3z7Rs+dgbIdpp/OORsuQ/MMN0lr1oDB2t1b
         xCOnjOQBadmBRWM0ptpqy+aUjTlWtYox60o+ANcILm2gwiV01lkIXlCVSIKWTiS1mtVa
         mgvQSgOOpZPxtW9TFzOTBlWfBgF7Vt8NZ4buDQCRJbnPP0MMKJMz1sbuqJFcwjVmxwGi
         i1Z7TN28TgA6UfcDKs5IjOXFqVwAonsFlIAnWlnHn0QOFCgswYd37fDiiPsnmqm2JAZq
         1ZDg==
X-Gm-Message-State: ACgBeo2csN99o34FmBD5mXLhk4m4WnVnKKSEdWI9H1HxK2ukSmPazmvy
        xgJZnIJB93KHQNIu7BirSUI70w==
X-Google-Smtp-Source: AA6agR7AC3Nx3L/Jc8GUrjAPqdz3P8KG7jVDlTu2KGz8zpD9uwar7E9OOC8m11GCpTOS5QCH3k9cpg==
X-Received: by 2002:a9d:5383:0:b0:61c:6ca8:c68 with SMTP id w3-20020a9d5383000000b0061c6ca80c68mr9706838otg.303.1660103667797;
        Tue, 09 Aug 2022 20:54:27 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13-20020a056871088d00b000f5f4ad194bsm3569732oaq.25.2022.08.09.20.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:54:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sdm845: add displayport node
Date:   Tue,  9 Aug 2022 22:54:22 -0500
Message-Id: <20220810035424.2796777-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
References: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add displayport controller device node, describing DisplayPort hardware
block on SDM845.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 82 +++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index eae307a4babf..a8ba6ebc714f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4457,13 +4457,20 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dpu_intf1_out: endpoint {
-							remote-endpoint = <&dsi0_in>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&dp_in>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
 						dpu_intf2_out: endpoint {
 							remote-endpoint = <&dsi1_in>;
 						};
@@ -4495,6 +4502,77 @@ opp-430000000 {
 				};
 			};
 
+			mdss_dp: displayport-controller@ae90000 {
+				status = "disabled";
+				compatible = "qcom,sdm845-dp";
+
+				reg = <0 0xae90000 0 0x200>,
+				      <0 0xae90200 0 0x200>,
+				      <0 0xae90400 0 0x600>,
+				      <0 0xae90a00 0 0x600>,
+				      <0 0xae91000 0 0x600>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+				clock-names = "core_iface", "core_aux", "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				#clock-cells = <1>;
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+				assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
+				phys = <&dp_phy>;
+				phy-names = "dp";
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						dp_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dp_out: endpoint { };
+					};
+				};
+
+				dp_opp_table: dp-opp-table {
+					compatible = "operating-points-v2";
+
+					opp-162000000 {
+						opp-hz = /bits/ 64 <162000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
 			dsi0: dsi@ae94000 {
 				compatible = "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
-- 
2.37.1

