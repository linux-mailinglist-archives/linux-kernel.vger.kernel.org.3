Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB1596E19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiHQMEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiHQME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10684D259
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u6so13350156ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d81NAUVI3O6mHh9rRCLTkzFGlVQOgUX55hJVWZukNlg=;
        b=O5fDAXAHPeoUaYrEtDaUax7G81BrEIS1GD2raYLyy2z0UnXG590QYeBcIpPci5Hfwi
         y8XODPOEh0iIZJqhxkVQCQYxsknov/nV2qf+XO9QB/MVZLuu6W5URKsFK48qhYxm+PNd
         ZyLMG4TzoVTUD/w+47OlgaBNByS43kUYyc4qSRJ97kgiZbINhTTwsPZUL3iYU28x86BU
         NECJa2pnRKa0S/e8inilSWhA6NUvZFAUvdKJz9jOAQpMRN3y2xkW8mmylpZ1JbN3wUr4
         gMpEmdMTejgyNT/oJqTu7NW1NfeYaOtmHzzxWuuXGfvinl1qYAr1Snq8OPUtejGAJwLF
         Vo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d81NAUVI3O6mHh9rRCLTkzFGlVQOgUX55hJVWZukNlg=;
        b=lPMaGte6Njb02T396Fvk8leF658y9ZQfPluKh+icyOYVWw+zHeX82F8RFqfKoCcC1R
         q7/Py9v9ns6a979Yk1AaeqFte71xWOWixISN+/RO6C4bIpopxv36+gdjDdZU31pz+NOl
         KGx2Nz31bZXgQ3FcMALesSDEKIkAbhqx0LziKyU9XHSajI35OIFxvmZDeRENMk92TbLU
         BRVeGSNgHbV02ASkjaIVItTyWuLEet9xwdlNARF2Y5YpPeMn6pwCFqOnzqd9rU1MilIs
         4nbaT9r3Og8G3DJrGY7c3bqEIeHYFEwfXkzdt2q/pbK9YjDa5fNA/I+Ox8BpR0BZLmT8
         jpHQ==
X-Gm-Message-State: ACgBeo1FShqCyctnowMlg3Dd5Kiav++ZzbwaXw9AGRYuSwEjkF5zLuLp
        kIOFg/+XkFEo0080HsH9tIaM7g==
X-Google-Smtp-Source: AA6agR6u79wvYDGUZO0tZdytxlWZ5j1jtPZwx3ppR2OhdecQ870NyUimRspfcWf/hGog/YX78QVQuw==
X-Received: by 2002:a05:651c:1149:b0:25e:6918:22bf with SMTP id h9-20020a05651c114900b0025e691822bfmr7770720ljo.258.1660737859951;
        Wed, 17 Aug 2022 05:04:19 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 04/14] arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 15:03:53 +0300
Message-Id: <20220817120403.458000-6-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 02d21bff2198..f0806ed103f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1049,7 +1049,12 @@ ufsphy_lanes: phy@1da7400 {
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0x01f40000 0x40000>;
+			reg = <0x01f40000 0x20000>;
+		};
+
+		tcsr_regs_1: sycon@1f60000 {
+			compatible = "qcom,msm8998-tcsr", "syscon";
+			reg = <0x01f60000 0x20000>;
 		};
 
 		tlmm: pinctrl@3400000 {
@@ -1340,7 +1345,7 @@ remoteproc_mss: remoteproc@4080000 {
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
 			power-domains = <&rpmpd MSM8998_VDDCX>,
 					<&rpmpd MSM8998_VDDMX>;
-- 
2.34.1

