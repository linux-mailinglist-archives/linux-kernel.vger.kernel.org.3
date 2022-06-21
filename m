Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E6553F03
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 01:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355348AbiFUXeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 19:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350019AbiFUXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 19:34:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504D30563
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:34:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i64so14481617pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fJgKFMAN9XJcQFXSIBW4zb7s2vD8f3jyjsxvG6sAqRM=;
        b=Z/aOhdB8XUfEaX6j3ZNfWzrLU8KayJ5c0OPQZEAXfEJowv3AwV3zrG7mrwvN0nWAWV
         CUn4WPnoToYv/Lxu57bR6whg484OXyqomiPAZhX3mPCt617VmjYCnAzR7NMvpq26gd+d
         GipV0733h/usUyYvSwuLEVVvgMHQhQq+gfJif410klwaaoUgSf4wq0IX1OvZF7k896DY
         Lv9IzoMeHExsa5iz3vfVL0THo/CRD538fxMfbYL9TprYPtbRincPVLittQnywjDm2cIL
         52MbdQSNyFpI2tF3sKICGYcKiPBlQ/BmbKVzbswSeoAQ8zqTOMqIysFYiXB4EIqYrLNl
         FKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJgKFMAN9XJcQFXSIBW4zb7s2vD8f3jyjsxvG6sAqRM=;
        b=rJgOUvP6VzPOSxSAcho/51waQdVcLOeCfhE257B1rIZkmSsI52WzJkq4FPYvdq5MIx
         zotRG2pe/JBWU4c7ix4EAKcunsuIh7Ymy3SNsGjtAnWNJjq+pqixO4/6NzfVwswnpL1D
         do+xkGJsVbeFAlJkySybToPH4vZWqlDJ91y7nbvX51eefFA0Wjhp6YPu8Occt+5p3JI3
         tUTP4RVLKal3UeHrM3dGaxhiTZwCevJCNdwaeOnASF0tgCBEOvT+CFrD+PYDPC6dBBmM
         PjIN/2rP6/O4vt823rwXFgjavpd5RFkCQlfnxxMTH+h6/9JVrACXGvmeoyLUgqt7SvX8
         yuug==
X-Gm-Message-State: AJIora/hNNN/EhEUscQHm9ChP2oLrahVZnrGMlDSYGmKLWI+Bo3P2V/r
        SD4JwGvqXcLp5NarY2q45D8Tyg==
X-Google-Smtp-Source: AGRyM1vur6Kvm3tsOQjtHwjlG48ZcycgnHC9uDokuSDAPpAacs8/ihbnm3Kn225KKBUKyNxVUGtiVw==
X-Received: by 2002:a05:6a00:b8d:b0:525:4637:de98 with SMTP id g13-20020a056a000b8d00b005254637de98mr67960pfj.31.1655854459880;
        Tue, 21 Jun 2022 16:34:19 -0700 (PDT)
Received: from prec5560.. (71-212-119-14.tukw.qwest.net. [71.212.119.14])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090302c700b00168e83eda56sm11297873plk.3.2022.06.21.16.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 16:34:19 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, robert.foss@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v6 1/6] arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
Date:   Wed, 22 Jun 2022 01:34:07 +0200
Message-Id: <20220621233412.506768-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621233412.506768-1-robert.foss@linaro.org>
References: <20220621233412.506768-1-robert.foss@linaro.org>
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

