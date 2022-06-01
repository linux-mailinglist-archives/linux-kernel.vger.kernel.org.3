Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269CA53A546
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352990AbiFAMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352986AbiFAMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:43:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236944A03
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:43:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rq11so3523346ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fJgKFMAN9XJcQFXSIBW4zb7s2vD8f3jyjsxvG6sAqRM=;
        b=wWb/JJlzX0SIWHjpeJlod/weT8/DIjxKgugl1Z6rRqQJ7VMH80FEIreq0WFcVSdQKL
         cinKRNoTO8GAYb3D/LjLx0reNWvGukOd318oeNuQofM3XgdUKIdJgEQJ/uEhXVMrDzuh
         1uclUGsHXCOCLzWLDcWyuOERyhPHeULrEKZNzNfvrUFF0FgolhHV1jblnkwjOXCmsZgF
         DJIbZOtOEV1LWLrtX0EFBFZtp3HoJxDVsxge+8HpmkXql+oR7Qrx/udbQA7Bu9iTmbUL
         lchwJvlp18Pn8XZot6BpWIrQF4GAtmFL3RnTZe2EoZLn6iCSvXddWWuAsJWutA+16Bsq
         rCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJgKFMAN9XJcQFXSIBW4zb7s2vD8f3jyjsxvG6sAqRM=;
        b=0f3J2G6hwb+N1P9rGVVGn/uVXarKvSX6vL9WYz1GNBZG4uHgmTMiD62JjPyj8ye8TH
         R83mweqTgsx5Dg4e/T1yN0hC44q56mBwz6TUapHEwV3S6NUq+oNwYv8UfxBB0hcrxjdb
         eurzI/mUQcGZhkvyjq8yC0nXDGS90dx86PWHJDt3oRst1CYSR3nSJjfKpJC6052rBc6Y
         Rf/nIem6+U4J32SvwvcgC6QzKhihn5cAWsk2EVY65cJ+GD/xsld0onu07EqnS32y3M2e
         tkcCPkPGEB93F0buIURsat4jn2sSCUZpLPM6mF8MWCFY92+1jloZgX0KyexXsqglGvl5
         AYGA==
X-Gm-Message-State: AOAM531W5I44jLNwsKz/+xykDdC+ksIV6VqnTd/lGm1FHr1NKTR/Opmv
        Q7jP1H74y1o3HmT3pIr4wnVMFA==
X-Google-Smtp-Source: ABdhPJzxE/WrmlCGuCBtlVNzkPgXcSPnDCjyJPc8KiQIiNpVTpDZ+PYqo5REyO8I1Idj9VX8sBcRYw==
X-Received: by 2002:a17:907:c11:b0:6ff:a149:43 with SMTP id ga17-20020a1709070c1100b006ffa1490043mr9062197ejc.317.1654087408947;
        Wed, 01 Jun 2022 05:43:28 -0700 (PDT)
Received: from prec5560.. ([176.74.57.19])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906830a00b006f3ef214dc0sm682055ejx.38.2022.06.01.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:43:28 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, robert.foss@linaro.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v4 1/6] arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
Date:   Wed,  1 Jun 2022 14:42:45 +0200
Message-Id: <20220601124250.60968-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601124250.60968-1-robert.foss@linaro.org>
References: <20220601124250.60968-1-robert.foss@linaro.org>
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
---
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

