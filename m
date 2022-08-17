Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597C596E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiHQMEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiHQME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD124B4B5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z20so13361718ljq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7xLpyvjcjxtFjBdq2TnMTpFX2axCPt8X9rBvt8vK73g=;
        b=OCl7RP5B3diVVIlZ1sxJjymAcMtuFqHzkuw+8yc3snwyOed1ZRJArA+IcW+HOA9oEQ
         f+ratGG0lP05xhtuZF7AXUso/5Wk9CTIpfEa5U9b/5Jntj6Cn9YKqyaoLEEAN/bkXfjL
         LPSASlUxzjjGKsJe1/Uw0HObPUepsMzaJHO2AqwyWMQ4JhkMUwSkAcq/3u2sMYnDyWRX
         qq2kAMMYaI2yFimpgYDtfNzmRVW7B9ZQg4hdMxyFZeyEmMcw7Vz3AQQ3xstDhU55vtxP
         NdBz0C3oRDgZ6X1/nf8OuxNNA7LYoF1mYy3tA5cXk7OQKrX7pDtZoKeHTgEsluYdyAqj
         m6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7xLpyvjcjxtFjBdq2TnMTpFX2axCPt8X9rBvt8vK73g=;
        b=ZuQz2LW1m1BShnBF2mNUOdW9xAH8lhlKKPR/bjQF7AdfRFjxk9yOZPRsn0sceIJcLJ
         bgJhnpgYKqMxMyf/BU07RMVvL/4o2LFTp51k2oClDX+6habnhBpyB50bUnXsnr/wquY8
         8zGSBi35yGUK4sooqb+97O+Orj3rbLcJQHZobrY7NvLbWwxOqUVjh4/sPEcSn4DoPw+v
         K1ZRZM6apw+YFE9nVla5JkSsK0As5Ft15nNRj/4RQs1CwvDKszJNDa8nQ84Ego1rgg/F
         QUie5LjCDXTKw4ExwQTXSBAWD+4l1VL+VhZa7VzfJzKLqKPs0fBOxtm7e/bqbMe7btif
         eW0A==
X-Gm-Message-State: ACgBeo0G4Wk5NvrGbjMyURdbsMXBGEOadxn4o+RPxPeJug7zW+MZOjIx
        5Gd8vgxiTy7zMRd8myVnOe6eoQ==
X-Google-Smtp-Source: AA6agR5r2qyeSvJtZI4WU8K3RqHXaRKZJMrxzhGEoQa7yoh9SaWiOmc56Mb8c6MEpg1WwJ1mGXbGHg==
X-Received: by 2002:a2e:a552:0:b0:25e:6fa1:a6c4 with SMTP id e18-20020a2ea552000000b0025e6fa1a6c4mr7374386ljn.90.1660737856798;
        Wed, 17 Aug 2022 05:04:16 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 02/14] arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 15:03:51 +0300
Message-Id: <20220817120403.458000-4-krzysztof.kozlowski@linaro.org>
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
and their IO address space.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 742eac4ce9b3..3411ced96db6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -359,7 +359,7 @@ opp-2150400000 {
 	firmware {
 		scm {
 			compatible = "qcom,scm-msm8996", "qcom,scm";
-			qcom,dload-mode = <&tcsr 0x13000>;
+			qcom,dload-mode = <&tcsr_2 0x13000>;
 		};
 	};
 
@@ -840,10 +840,15 @@ pnoc: interconnect@5c0000 {
 
 		tcsr_mutex_regs: syscon@740000 {
 			compatible = "syscon";
-			reg = <0x00740000 0x40000>;
+			reg = <0x00740000 0x20000>;
 		};
 
-		tcsr: syscon@7a0000 {
+		tcsr_1: sycon@760000 {
+			compatible = "qcom,tcsr-msm8996", "syscon";
+			reg = <0x00760000 0x20000>;
+		};
+
+		tcsr_2: syscon@7a0000 {
 			compatible = "qcom,tcsr-msm8996", "syscon";
 			reg = <0x007a0000 0x18000>;
 		};
@@ -2413,7 +2418,7 @@ mss_pil: remoteproc@2080000 {
 			qcom,smem-states = <&mpss_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x4000>;
 
 			status = "disabled";
 
-- 
2.34.1

