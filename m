Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7008158C41B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiHHHgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiHHHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:36:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6F13CF1;
        Mon,  8 Aug 2022 00:35:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a18-20020a05600c349200b003a30de68697so5568120wmq.0;
        Mon, 08 Aug 2022 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tEtgkQbUevQWfCMlQUP9ItpZReAakBbxAMZkCw0zIHI=;
        b=gZRVB/u6yMUMYr1evrAZ4vUcXenFBgrsfl1i2BsaRuKBfxAZ0bTPAx+7dsJBQSX/tI
         qyqVOSYQyVyq/AisARKpShXZWgGCMxQ1DVPXHppkG9SihaS3SAovTxt0FyDpkXOxow0R
         DmyHietKzmnTu7gVRFRUQ+XknACRZASayqkhi6csd+leopXFCVy6zbSRBLaBVYBdC7nL
         Fc7fXJ0wOynaY2r9orHgMnAgopF/syBmjzPMN080dNQ6KQI+nyTd59ULYaiKFvFYeR/B
         sRC9+zBJDW4dmtxBZQjEE9N2crSkCPxDWDeC5NvLAiTqB+8sEfaJB9YaFVax/o4lw8BZ
         v/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tEtgkQbUevQWfCMlQUP9ItpZReAakBbxAMZkCw0zIHI=;
        b=0rsUhQG7eiknrzwVGbmHrtC5kqG1XrnYaHfrPivMdkPTralb9piqmSbIhC4IBcTQph
         /KA6SbiccDlsGOpae1YTGkrNIGBgFSw3Zod2q/oac51JulDpL/lVNbIpoKNtjgsqDF+i
         rCwmL4madWlCA1qgLVXYZgy+tqMeKKjGO6awqkRWEJvtagCsRMz4IPHt1uAI1K6X172l
         aNz2ETAnAWdKC6QLBBVbmbwi0AGcW7dneeAKtQOaeqBfeflJLkbKjRERGu8cmx/4J6J7
         49RuTeqCDjgwP0KHtwMIItvKby3T1NBcwY8LpCEci7wGLsyfJNVfDkil56Z66n/cl7Y3
         x+9Q==
X-Gm-Message-State: ACgBeo33gdMHS3RZ2bG3hYHLyZS5qOPlYea36rJtXv2B8KBMtaCFXzZh
        uVU1Hx3MPn3XODcaIeVJJtc=
X-Google-Smtp-Source: AA6agR6wmUDrWZOn0SoBn00BpCKPIlizLIpzgniZXyou6Lw9cQHRURNdcuBpxeYHLOyQnmJOyDk62Q==
X-Received: by 2002:a05:600c:4e08:b0:3a3:55d9:fd52 with SMTP id b8-20020a05600c4e0800b003a355d9fd52mr11777713wmq.148.1659944148657;
        Mon, 08 Aug 2022 00:35:48 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:35:48 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] arm64: dts: qcom: pmi8994: Add SMBCHG
Date:   Mon,  8 Aug 2022 08:34:53 +0100
Message-Id: <20220808073459.396278-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808073459.396278-1-y.oudjana@protonmail.com>
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a node for the switch-mode battery charger available on
this PMIC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 72 +++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index 84c44912ec93..3e9db97c9805 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -10,6 +10,78 @@ pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8994_smbchg: charger@1000 {
+			compatible = "qcom,pmi8994-smbchg";
+			reg = <0x1000>;
+
+			interrupts = <0x2 0x10 0x0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x10 0x1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x10 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x10 0x3 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x10 0x4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x10 0x5 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x10 0x6 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x10 0x7 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x12 0x0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x3 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x5 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x6 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x7 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x13 0x0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x13 0x1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x13 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x13 0x3 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x13 0x4 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x13 0x5 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x13 0x6 IRQ_TYPE_EDGE_FALLING>,
+				     <0x2 0x14 0x0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x14 0x1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x3 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x5 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "chg-error",
+					  "chg-inhibit",
+					  "chg-prechg-sft",
+					  "chg-complete-chg-sft",
+					  "chg-p2f-thr",
+					  "chg-rechg-thr",
+					  "chg-taper-thr",
+					  "chg-tcc-thr",
+					  "batt-hot",
+					  "batt-warm",
+					  "batt-cold",
+					  "batt-cool",
+					  "batt-ov",
+					  "batt-low",
+					  "batt-missing",
+					  "batt-term-missing",
+					  "usbin-uv",
+					  "usbin-ov",
+					  "usbin-src-det",
+					  "otg-fail",
+					  "otg-oc",
+					  "aicl-done",
+					  "usbid-change",
+					  "dcin-uv",
+					  "dcin-ov",
+					  "power-ok",
+					  "temp-shutdown",
+					  "wdog-timeout",
+					  "flash-fail",
+					  "otst2",
+					  "otst3";
+
+			status = "disabled";
+
+			chg_otg: otg-vbus { };
+		};
+
 		pmi8994_gpios: gpios@c000 {
 			compatible = "qcom,pmi8994-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.37.1

