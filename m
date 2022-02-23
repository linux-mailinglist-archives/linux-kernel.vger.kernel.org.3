Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2EA4C1C45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiBWTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbiBWTbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:31:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996F47AF2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:30:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u16so16314616pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zqsit+rOnmNUmUZtDFG33t7bXRXpX6/2jlTb49W6F6M=;
        b=f7ydfWcBpxG5L6A2J381iH4HWO+Fp0BYmpu1BDed5ABZxf3XF6oP22Y2AHf1sQ84NC
         fCHfEbUqyV0eKToUFSRE87ycmYTQ+r2inuCnGkuzGDsyADlZcAYUDOohGDDxfUP+D0FZ
         lZ3E9/ZVEoeHtClSloT/tJEOgS4Xk3G13zV6+5JML2acxJFI0ijqb1tivgKRgWJ5EGtd
         KoNUtrClFYCh3XaHnHiua5O+P3lP+t9GOdrrO6b3pG/KuuPyo/Ju7SkVGfi7YlmTEddu
         /PLB44NIT8UAT1W4be7+Yjr8m2Q/A+UYi74HuvGrttYLUemQbZDa/mhrYM43pqIFaMk2
         PNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zqsit+rOnmNUmUZtDFG33t7bXRXpX6/2jlTb49W6F6M=;
        b=qpXJDIqIQUYweYBkAYd+DNVUwSENWSWieH3Q/VoWckYojmM4XsF/LdC1iL3QWb9f+G
         2ohqLe5YE7adpUmkLuxQNf8aszp4tjzQwi66O6iO/CA40f74krN7shg3UIsLkJrxo5Qu
         BcHYS0VM2PJSwry39y3X/YVwmr0dDkMzj54/+w9NG7IAW49EP/fIr2MhdzJCQKSXWoas
         Bb7nedoLqLB9PorNOo/OtduciktY8EepAblRVdbGxg1j6qQCL5R86BBXrRWwNyGBC1kA
         kNrHChpperswEBvOkcLY+73vhAH08VT5QNe0ykJC8AlYw+JMfBTpDQa/WFfqRoS1lliP
         m4zw==
X-Gm-Message-State: AOAM531yVlAYYvb2QCguOwf0crPyOa8XtkK2GTwMEseWSwJq3RdKZ8bF
        82FWh69fVrJzYQtUqOrQu7HrtA==
X-Google-Smtp-Source: ABdhPJw53BrQr0n38u/wHZsD3cRkteTWrFt8/b5hq6lDWI5EoJ5nulNAJh28GXAqBXqUQxuAiQuCRA==
X-Received: by 2002:a05:6a00:23d5:b0:4e1:7cfb:7e85 with SMTP id g21-20020a056a0023d500b004e17cfb7e85mr1166724pfc.29.1645644638198;
        Wed, 23 Feb 2022 11:30:38 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:180f:6b3c:fda0:57e9:7d44:2aa7])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a8b8a00b001b8d20074c8sm3719917pjn.33.2022.02.23.11.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:30:37 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6/6] arm64: dts: qcom: sa8155: Enable pcie nodes
Date:   Thu, 24 Feb 2022 00:59:46 +0530
Message-Id: <20220223192946.473172-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223192946.473172-1-bhupesh.sharma@linaro.org>
References: <20220223192946.473172-1-bhupesh.sharma@linaro.org>
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

SA8155p ADP board supports the PCIe0 controller
in the RC mode (only). So add the support for
the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 8756c2b25c7e..3f6b3ee404f5 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -387,9 +387,51 @@ &usb_2_qmpphy {
 	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l18c_0p88>;
+	vdda-pll-supply = <&vreg_l8c_1p2>;
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l18c_0p88>;
+	vdda-pll-supply = <&vreg_l8c_1p2>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <0 4>;
 
+	bt_en_default: bt_en_default {
+		mux {
+			pins = "gpio172";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio172";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	wlan_en_default: wlan_en_default {
+		mux {
+			pins = "gpio169";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio169";
+			drive-strength = <16>;
+			output-high;
+			bias-pull-up;
+		};
+	};
+
 	usb2phy_ac_en1_default: usb2phy_ac_en1_default {
 		mux {
 			pins = "gpio113";
-- 
2.35.1

