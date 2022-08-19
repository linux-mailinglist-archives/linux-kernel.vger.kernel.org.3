Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62809599771
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbiHSIcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347354AbiHSIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136AE97F8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l19so728949ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5WfuABgGkL9AfK5HJrbpixzed3bcUcc9/3Q45QgNRXA=;
        b=Ak1QpTr/VKgCehxKnxF4AVejAldH2KkNQfQzNsGLMm2tObgmonqMF/UtYy12/dJ3gw
         dSYoWGDuofnANi9zuQLbbvCM5dFGmcZjf4QrC8Ct2PznxP9Yep4fnItYam4hEW6Zhg9K
         JoMGzVyhay/L+ctJetYYSOtMfvlTD1wXZQpk+ab8aaB8i4KO6ANrz/PE0Y+rHqqUaFhF
         guBFgKEfPxAKoMjH9MtM5U3nCFKdLghP3/70KnBcb7APTv3xoEqPnaGIqHVxRWAYLNLB
         E+9o0q6jFukdpzahrP0bAZZSQfxAUqtTzhbJVbaN2rYkyxChXkaJ7O2pwvCiYbis2GBO
         VKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5WfuABgGkL9AfK5HJrbpixzed3bcUcc9/3Q45QgNRXA=;
        b=XhUxrT1U4+ldZNplxIxagDzKmZswniBkNHVMZCHWaHZWm70zH4YdRPOU2DcTlgagY/
         bsCYPTXLFk9ZjzE5/3tsRCGSsSZnZUrM+9FAsth3+m9+rxECjgXcALZrc6vk63HeX0xd
         JjilwzPRWrR5texUiI1MldzELbayrksqCWfv/a5ZEtoAy3Da4azTaePgsy3ZSGB/DoYH
         kL+K0cKF9ldcoO+a9khQpaKCwOM8WdvwTc6wj20maYLI6eucit0siian81YAluriEZh1
         XYcklGk8GSERXdwxDjzSJFGsVwyMrjx/2kCGi6SaSzcpfgsLSAXoMFZXlHe0xLnj1j/I
         GIUw==
X-Gm-Message-State: ACgBeo2/QDiyPKtGY/Rf47fbSZY9XYjEukHp3U5wMW3sx1i0OUpZpiuX
        GToTjip3Tswi2defWyE17U0q6A==
X-Google-Smtp-Source: AA6agR7Ph2MRxoCWXinqtcheu7CvhmScE8OpNiYuTQCdKm1lTOpi/K7x8dS/H00qwV7GYWbPqcn1dA==
X-Received: by 2002:a2e:b8d5:0:b0:25f:e94d:10a2 with SMTP id s21-20020a2eb8d5000000b0025fe94d10a2mr1993685ljp.274.1660897939400;
        Fri, 19 Aug 2022 01:32:19 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 04/16] arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:31:57 +0300
Message-Id: <20220819083209.50844-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
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

The TCSR halt regs are next to TCSR mutex (in one address block called
TCSR_MUTEX), so before converting the TCSR mutex into device with
address space, we need to split the halt regs to its own syscon device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
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

