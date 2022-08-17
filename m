Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A252D596DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiHQME7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiHQMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149D4D164
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a9so18700621lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QCMHKhkVunzbtGiMJ/wq/fYfBgDNCThjx88/COvHDls=;
        b=jMVMljrAXcYn6hVHQqGcd6DmXZC3bnx+dOnbvpw03W+hSQ1yLtV0yLSF4E0K/vW1PH
         oalzUaSW36/TGpx1jvmKYfJnOc4cgVr4qtZeIyKFcSEM2D+P81umCkxaU2W3uAXwr6uh
         ee/qbI/7n8m0SzL5Foh+yEM0axQYOjoy0oTPG1c65x8yk5pvaDFmBuBgJ5U6/X4Havsr
         mnSeAsv5VFRGZr88sBTI7F7D3sawGuq8j48d28YDpkyobzHE/kJrD/7xJmTB3MjKGsu6
         ToSYcvWwkrQufRZReX2PNGrqdAhOI1W52Om5OJriqZj3FC7u++OGv1HXos0EixfwxHaD
         2NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QCMHKhkVunzbtGiMJ/wq/fYfBgDNCThjx88/COvHDls=;
        b=jQxYW9ySRL3NR8So2JVE023PJUWUM63+3k5KrpFyWlDytuaRXlZq3j6eivt8bVYU00
         CjBqcWOjU90FINHyAA3Ft39oFFFqhNIRq9gFukDRYvxcB6jSpPigiC+jfpkx6zkSwbZF
         eIz5jvWfaWVLlLbueb/21EDLFQrGotodRUDR7lLdKf1J5tsr1zdtidVC+HR/PJgurkL/
         ON1dhR5YplNL/0Whgvg+/ZeChv1Q+0X1Pv73usmKErjTG9kkHoIGrGA9LFQN8wH4bKy5
         3IbhZ+CzVyC/4p0be9uzKqNlgdgpf1acqZxaYmGnATyMGLBSrmRLE9BtimZzjDBAsTuz
         HU9Q==
X-Gm-Message-State: ACgBeo3jOjufxoBbbVnRtoJAN9d0MGHn/Lri2lbT0x6egDtn0TpNL1TU
        F3PynQ/QkKkC7m4uhJmmkg2+EA==
X-Google-Smtp-Source: AA6agR5S+APZgwcw+bIIDVGoAnuC/13B7ipF5b8+EdFoYAALnaA5p2FIyrCTjzHmbNXDwKwD1Go7xg==
X-Received: by 2002:a05:6512:238c:b0:48b:132:8392 with SMTP id c12-20020a056512238c00b0048b01328392mr8117244lfv.658.1660737867059;
        Wed, 17 Aug 2022 05:04:27 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 09/14] arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 15:03:58 +0300
Message-Id: <20220817120403.458000-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR halt regs are next to TCSR mutex, so before converting the TCSR
mutex into device with address space, we need to split the halt regs to
its own syscon device.  This also describes more accurately the devices
and their IO address space, and allows to remove incorrect syscon
compatible from TCSR mutex:

  qcom/sc7280-herobrine-crd.dtb: hwlock@1f40000: compatible: ['qcom,tcsr-mutex', 'syscon'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f267b289..89a8e6b9822a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2155,12 +2155,17 @@ ipa: ipa@1e40000 {
 		};
 
 		tcsr_mutex: hwlock@1f40000 {
-			compatible = "qcom,tcsr-mutex", "syscon";
-			reg = <0 0x01f40000 0 0x40000>;
+			compatible = "qcom,tcsr-mutex";
+			reg = <0 0x01f40000 0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 
-		tcsr: syscon@1fc0000 {
+		tcsr_1: sycon@1f60000 {
+			compatible = "qcom,sc7280-tcsr", "syscon";
+			reg = <0 0x01f60000 0 0x20000>;
+		};
+
+		tcsr_2: syscon@1fc0000 {
 			compatible = "qcom,sc7280-tcsr", "syscon";
 			reg = <0 0x01fc0000 0 0x30000>;
 		};
@@ -2522,9 +2527,9 @@ remoteproc_mpss: remoteproc@4080000 {
 				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
 			reset-names = "mss_restart", "pdc_reset";
 
-			qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
-			qcom,ext-regs = <&tcsr 0x10000 0x10004 &tcsr_mutex 0x26004 0x26008>;
-			qcom,qaccept-regs = <&tcsr_mutex 0x23030 0x23040 0x23020>;
+			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
+			qcom,ext-regs = <&tcsr_2 0x10000 0x10004 &tcsr_1 0x6004 0x6008>;
+			qcom,qaccept-regs = <&tcsr_1 0x3030 0x3040 0x3020>;
 
 			status = "disabled";
 
@@ -3259,7 +3264,7 @@ remoteproc_wpss: remoteproc@8a00000 {
 				 <&pdc_reset PDC_WPSS_SYNC_RESET>;
 			reset-names = "restart", "pdc_sync";
 
-			qcom,halt-regs = <&tcsr_mutex 0x37000>;
+			qcom,halt-regs = <&tcsr_1 0x17000>;
 
 			status = "disabled";
 
-- 
2.34.1

