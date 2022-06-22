Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC03556F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377320AbiFVX3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377507AbiFVX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:28:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B43424A3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:28:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jb13so3083261plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hLzS98auu4febZeywb1kJ/b/UaFrA5NEXBvc0oFVba0=;
        b=Wh/vMBTt3XEkvprHbw60EglbKKQxjHIZaqP8BDnJKDPbvoEyoNTFF4LF4aWVddDbrp
         eyP74K2cGHt4Jbw/U7ftg8DB7UNs10mtNy4Hm3EMdl0oEFVO6IIRfRAW8Kcgzzi1ls79
         dgo/2uXBnOfrb/AEZ5F/PQbL3mqp0Xf6xHHNLH7XRhL2uxWDIpEZPcxRPh8k3vurKTtw
         VYrMtTCCdUqVLvsGCk/fZsm0aAT+2skKA6oSo7+V8rZ8rppoMni8NR3qqXzwwuA1aQX2
         nN1kY9SiCvvdN0PDdYRwrLz5oogA19B4islKsO0LlKoUD3joRdKDHAGiacf1D9LPh/4q
         S+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLzS98auu4febZeywb1kJ/b/UaFrA5NEXBvc0oFVba0=;
        b=SvC644vDWfUwjazjrGJN5NdnUgqbB511pDtJNb6NCWbOJLZ05m3pSZNfWCRttZgrPl
         BuFrgbcrzFWITT0WSf6O0X9L/WPi3IfFt2jBT0BJtUTpBubr0iAUZ7a/hmcOXlVr8jvt
         e1Edf+PHrEwtzn61i18sU/kdHQds5g8UgyXg+oySPIASBnpX5+OnuP8jNmYSQ425CMc4
         BHeKgPNIwFqR7jn/rvSUTMrkj919IuAZY2HMu9nLzZaH20ogcyEDA75WmGE30f9NiPwD
         If732BNkfXSqcZHI2AZ1DUWIZfGeaDpJd49w4Wa28uimX1QqlrvVMFKDIoFZeKlvdvLs
         87Rg==
X-Gm-Message-State: AJIora+FrRBxuOOiVaj0yPQeGL9c7fGG9xZwl330onfR0yUujQcGSgb6
        3UjJt/D5cgavgb1YpXOyu92Y4rmiuvoNR+1Y
X-Google-Smtp-Source: AGRyM1tJ/WWBqLRMXSS7a7wJSUMu5X1d5KAVQn8BDVUxziPil6mW1PXgu2UCKjPQuAXZVj6DHF/M8g==
X-Received: by 2002:a17:902:f689:b0:16a:4021:8848 with SMTP id l9-20020a170902f68900b0016a40218848mr8502195plg.23.1655940538097;
        Wed, 22 Jun 2022 16:28:58 -0700 (PDT)
Received: from prec5560.. (71-212-119-14.tukw.qwest.net. [71.212.119.14])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b001622c377c3esm13297863plo.117.2022.06.22.16.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:28:57 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, robert.foss@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v7 1/6] arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
Date:   Thu, 23 Jun 2022 01:28:41 +0200
Message-Id: <20220622232846.852771-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622232846.852771-1-robert.foss@linaro.org>
References: <20220622232846.852771-1-robert.foss@linaro.org>
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

Replace &rpmhpd power domain integers with their respective defines
in order to improve legibility.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---

Changes since v6
 - Add r-b - Konrad



 arch/arm64/boot/dts/qcom/sm8350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c0137bdcf94b..52428b6df64e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1656,8 +1656,8 @@ mpss: remoteproc@4080000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 0>,
-					<&rpmhpd 12>;
+			power-domains = <&rpmhpd SM8350_CX>,
+					<&rpmhpd SM8350_MSS>;
 			power-domain-names = "cx", "mss";
 
 			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
@@ -2167,8 +2167,8 @@ slpi: remoteproc@5c00000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 4>,
-					<&rpmhpd 5>;
+			power-domains = <&rpmhpd SM8350_LCX>,
+					<&rpmhpd SM8350_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_slpi_mem>;
@@ -2235,8 +2235,8 @@ cdsp: remoteproc@98900000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 0>,
-					<&rpmhpd 10>;
+			power-domains = <&rpmhpd SM8350_CX>,
+					<&rpmhpd SM8350_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			interconnects = <&compute_noc MASTER_CDSP_PROC &mc_virt SLAVE_EBI1>;
@@ -2540,8 +2540,8 @@ adsp: remoteproc@17300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 4>,
-					<&rpmhpd 5>;
+			power-domains = <&rpmhpd SM8350_LCX>,
+					<&rpmhpd SM8350_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
-- 
2.34.1

