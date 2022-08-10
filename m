Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF658E5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiHJDyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiHJDy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:54:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A24865825
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:54:27 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10edfa2d57dso16491824fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+hXeqbfCui9YdYkTLylnam0ju3zV31ixDbAl5c/vAHk=;
        b=pXwTzNpyHE31N4UgHP7zgfoqnMIbSFrHnr4hlNDgNj+3NfesQW5VeKWwCM7QqVV0L+
         sXnw5pRdJIbtiJ8C0T/kz5O+5UPLhkeRX5QxJR2yg2tPHQxI1QYMO1jd5Bff6xJJWNgO
         bDW7+yk0nTDn2Y4USvLDmHjopqARv3J95R+e61YXPc0G4/fPpbhCJ2wxPqjx3Jw44unj
         Ilvf/xBaOzu5Lg9h4m8mWZoOZ8wTprjizU08aVasmrBsVG4CQWWvteUP3wjloPkU8mTn
         bxhOa+LM0TPyGySOh5OYN9JFuFwpnNN2iFEdBOrwY5FqT+qin+NChKcGNFpo/baf72/F
         o+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+hXeqbfCui9YdYkTLylnam0ju3zV31ixDbAl5c/vAHk=;
        b=MRBcqz1t2RrEys7cyCynxBFrjiJUhVoWM0nAx9s6BmTaYe3z7MN1sEwAaIYBi3Sw50
         9kYlq+hbGNU5qvDFmVt8zuVIEfeg2a+QFvdbg8TmWbQEZmZpJz7Hw3JxkDrv/BdVRUfp
         qOd0+bXutFW/lgvpfACUDiRDsfapvOXFHWhCeMgetnmrhSDmv4wTpvTKiaP12ox2AOB2
         yM4Gx0LokV+MAlbbNVfz4TR7OHD0ro6NWbxVT88yL+ESokjQGPvjvAvSjH1YuMpAs+8D
         teciou5hGjriIFS+7VNMOIxB0Y+JVsuTUJ1CU/yM8thOYVBVg9k5llWr2RY7+4GqZjJ+
         bTBw==
X-Gm-Message-State: ACgBeo0vGUAsr8LY9aZdvcDHbYdF/sWb0TIzIEh9MEjsz6zcnZ5mg+cF
        bpKaN7zW2+CdGEWdWc4XNoCz7w==
X-Google-Smtp-Source: AA6agR4mLrLrQtI0x86uYrurjRPM1cSgFGkDBZmmJ5TWr80FYg9BTYYOUcA+AAzpXBakzcl9E9ljyg==
X-Received: by 2002:a05:6870:6389:b0:10e:6438:a8ed with SMTP id t9-20020a056870638900b0010e6438a8edmr661665oap.199.1660103666824;
        Tue, 09 Aug 2022 20:54:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13-20020a056871088d00b000f5f4ad194bsm3569732oaq.25.2022.08.09.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:54:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: qcom: sdm845: switch usb_1 phy to use combo usb+dp phy
Date:   Tue,  9 Aug 2022 22:54:21 -0500
Message-Id: <20220810035424.2796777-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
References: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Change sdm845's usb_1_qmpphy to use combo usb+dp phy bindings, rather
than just usb phy.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0e286715d1b..eae307a4babf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3922,9 +3922,10 @@ usb_2_hsphy: phy@88e3000 {
 		};
 
 		usb_1_qmpphy: phy@88e9000 {
-			compatible = "qcom,sdm845-qmp-usb3-phy";
+			compatible = "qcom,sdm845-qmp-usb3-dp-phy";
 			reg = <0 0x088e9000 0 0x18c>,
-			      <0 0x088e8000 0 0x10>;
+			      <0 0x088e8000 0 0x38>,
+			      <0 0x088ea000 0 0x40>;
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -3936,11 +3937,11 @@ usb_1_qmpphy: phy@88e9000 {
 				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
 
-			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
-				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: phy@88e9200 {
+			usb_1_ssphy: usb3-phy@88e9200 {
 				reg = <0 0x088e9200 0 0x128>,
 				      <0 0x088e9400 0 0x200>,
 				      <0 0x088e9c00 0 0x218>,
@@ -3953,6 +3954,16 @@ usb_1_ssphy: phy@88e9200 {
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
 			};
+
+			dp_phy: dp-phy@88ea200 {
+				reg = <0 0x088ea200 0 0x200>,
+				      <0 0x088ea400 0 0x200>,
+				      <0 0x088eaa00 0 0x200>,
+				      <0 0x088ea600 0 0x200>,
+				      <0 0x088ea800 0 0x200>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+			};
 		};
 
 		usb_2_qmpphy: phy@88eb000 {
@@ -4775,8 +4786,8 @@ dispcc: clock-controller@af00000 {
 				 <&dsi0_phy 1>,
 				 <&dsi1_phy 0>,
 				 <&dsi1_phy 1>,
-				 <0>,
-				 <0>;
+				 <&dp_phy 0>,
+				 <&dp_phy 1>;
 			clock-names = "bi_tcxo",
 				      "gcc_disp_gpll0_clk_src",
 				      "gcc_disp_gpll0_div_clk_src",
-- 
2.37.1

