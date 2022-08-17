Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61583596F16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiHQNEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiHQNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:04:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB63C15B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z20so13508594ljq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QCMHKhkVunzbtGiMJ/wq/fYfBgDNCThjx88/COvHDls=;
        b=iBbyiaFqKTDODYRVXGbUEnyLW64y2b+NXCcGhfcnBBw/8Ll59PGYqsbETO+Ymvq229
         fTaHJ8yL/a6f0QlIAZ9lJT7oDtYt8T9P0oYQRJrlvHOgp6wYZRWmtSV+SgYijx+etsy7
         Pzkp3S0YAkN/dt+aKsS4L3QHaO9gdZj4y+n06I9taPVq5jt8zkkwgXtlnPXGDJraK1jy
         LpTvvNJM8V8WpY3rRuIU6vGmF/n2Xwlf9ZMpp4kcNzXiecVQPCr3NTHrMEqlLGArDnFs
         a4j7X8f/eLt0DzFUOwT73Fp19X2byCbWXExCzXIE4oZrjCCrIBrbfDirqDFnwCu595DM
         Ea8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QCMHKhkVunzbtGiMJ/wq/fYfBgDNCThjx88/COvHDls=;
        b=H0ELQ1v5Oz1U/Q1ZpG+jqrlLIVUw7r0L1dhmGEtH5ykbSVlJLzkZvUS1vCUvBVb33g
         tRotkW+0l0IKlCbUKKjJ5ATi8Cfpnpv4vsyEGMtobAlHB5Bd1aMvREV8mSq7I1xTT2wv
         qbn7oujyZ9lC9cJqRKR6MqiaPNAw8uor0sFWPIuUHAXWwBDh8zS5an7CYNUMWLUbweqD
         Jbcaa0fauM8mCI5pUdpXze8tygzLN+go68hI4w0VOBYFZPalTkxAUCiVyLtMQ3bVR83W
         t5hPM/MJ6mGpG6HZszwlv1CsG4Otz/uA3tmoElWXnllt5X5KsWTK13UTC6yyEZRBO7to
         xhzg==
X-Gm-Message-State: ACgBeo2QH+dTii5b3P5Cw6/3F4o6VSqZBmyBgHOgWnMX6BgjGj+5MVD1
        QwI4ps7O5oZ+4YisBpHoxwEDAg==
X-Google-Smtp-Source: AA6agR4voDsvddPVWKd+rLt8r1aP0H5GQ0S4vnExx5ubs+n/b5cZm+o7DR00uvmEZWwy9VfOo90F/A==
X-Received: by 2002:a05:651c:12cb:b0:25b:fa3f:c3f with SMTP id 11-20020a05651c12cb00b0025bfa3f0c3fmr8365132lje.364.1660741442798;
        Wed, 17 Aug 2022 06:04:02 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b0048b3768d2ecsm1683243lfd.174.2022.08.17.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:04:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 09/14] arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 16:03:37 +0300
Message-Id: <20220817130342.568396-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
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

