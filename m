Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975BC544785
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbiFIJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiFIJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:29:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AC4265FBF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:29:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so35590427ejg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fJgKFMAN9XJcQFXSIBW4zb7s2vD8f3jyjsxvG6sAqRM=;
        b=auf48QyAWW6DZqUwau9GfDXaTM/n+lX6tK+nWSa5AjM15Fy8+nXLC9b0hwqLXrzNyL
         MsvVCHfuZqmeQKapyOpfQQzkxniNGgTGGJ/nnEHubG2huBk3o4pwpCStcnHPqlDHnSqJ
         ILNuVDMFAGaTiZVX0gT+7dqokUEEaIn1bw+oIosCLjlWp5F31xCCvOWA37D+CQtvmslH
         NT74Gou10r8h9r7HIPMzuM99zi29OOuOV8iTfAzSFddw7grZ9mqhdYGUVTHWV6crZIVj
         I3icS1Gz4oQ2DdPX2IxJaSFy4tKcoA1Hp6ugMUpbEF3f7WFznXO+KvsU7ZLgJc+tZbhS
         eUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJgKFMAN9XJcQFXSIBW4zb7s2vD8f3jyjsxvG6sAqRM=;
        b=EUAiSR3L9dnoTN39XSmGCG4wcnMonJBLiTQ3rJ1n4S0RDvz+X0NbSgp/bihDltlzqU
         O2QpKw36MfnwVEv2QYdnYRF/BA7BWU3Ec5iwsSG8Ih78zsJjNpIQcPnY040UGFnU3o5Y
         E932RoKV1/7C2CHzL44niFvoFavE7VLsfxMv0KxROoolvQET7/YVy5sXM/nxLh+kbRnN
         jeoGQs2W+EjrxOT3tiW6ALyc4AMNrPDvaLUIPij9SSIMLWHEouw8pwWn/uFo8ozR6wL5
         enL0l7pbxwLgLsgGOoN7ASXvA9uN5JbZkFjF9MCgAw0m37BhaKafeJGZxztn/m11MCBX
         iZWA==
X-Gm-Message-State: AOAM531hT5UtBimIi3O4wXHYRLeR9+KFQwLY6Ejoswfr+AYo/ZJ11ioX
        zqy3q6M7gJDSWQ4y3Q2T61chVA==
X-Google-Smtp-Source: ABdhPJxJUOFMqR/aHNywQZi7vQBO0lulUn4MK0goRVj8Co2AsVCKs5zP899BJ2chAURT6N1y+ONWiQ==
X-Received: by 2002:a17:907:8692:b0:711:d49f:994d with SMTP id qa18-20020a170907869200b00711d49f994dmr16555809ejc.578.1654766985025;
        Thu, 09 Jun 2022 02:29:45 -0700 (PDT)
Received: from prec5560.. ([176.74.57.19])
        by smtp.gmail.com with ESMTPSA id l9-20020a50cbc9000000b0042ab87ea713sm8653417edi.22.2022.06.09.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:29:44 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, robert.foss@linaro.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v5 1/6] arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
Date:   Thu,  9 Jun 2022 11:29:35 +0200
Message-Id: <20220609092940.304740-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609092940.304740-1-robert.foss@linaro.org>
References: <20220609092940.304740-1-robert.foss@linaro.org>
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

