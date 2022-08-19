Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2042859972C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347343AbiHSIc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiHSIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE0E97F8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x10so3889864ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bSmakT1vdCHgEKF8qCqyNm6SNZVWPZI3wfwFHGWqtB4=;
        b=CCvUcvjt98Fr4igCTaHPTFj+RnhBjAOxYI3X2/G0dWEV3CrvNwsGLwhQFia3yLImcY
         j59ivJ/dZQOyZXNT5py+SKq9+sh6n78YoRpKHkVcNzLZ+DYqcwbR2sh8VYrDLemXXJu4
         NXLdNdr3BA/VkK34JUz4FcAShKHcOxMCBSlVC8tXnCKCxma4hNajIWyBgaGtfk7uhZz7
         GFt1KezmcF7rd+ygh/9iq/vqdFEsRS30vaZ1Qb82wevhasB85ZXudr3TaFW9qZUXNNNw
         sNR4v4hw6+X2oTkGLGkNZfgcKjrs+A113WpERHpU1MnrVDo3+1BR4fFVw9CwpWQQUFcR
         m9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bSmakT1vdCHgEKF8qCqyNm6SNZVWPZI3wfwFHGWqtB4=;
        b=QreDmJ/TN7eChVMVWlZdtxH/T0hsH+01CxaxU9bMrVsnAdaaSj3pSmVgmd5KQIlfom
         YIm+FgmIr84gP81O6UEBXi90W7CxcSfWuSSzR3oD8UXx0eVyPK2q5P+xADJ5Jv6ExdRR
         528s5AYdsT/ZxN4v3lLrM8PTYjk2sFlqxJ7ZwDfzxE2Jd5C3w8r+31aUzVsIDG8Lvhd2
         Xb0iOQdO11FzNu0+7sPWoMsHHrnOKpuuA235KzMSxZnSxRx8uJqm8dcHYrBzk/mzvdvx
         /R9NwtomDhworgMRBoSYaPYHStJ9J8vLdKZi7/8gOVnelCFeoj+2sNftI+z+92QLF7Oc
         /Obg==
X-Gm-Message-State: ACgBeo3avhHJpug3sVlvNEGz05nE5qkMvRV3DPnNZtEfXImYSoNDbCv/
        upDhSJi+4QZg873NTG/ulCeKpw==
X-Google-Smtp-Source: AA6agR79bH3x4HCzZtPJLf+xIcNftzO6hiXEXp2Wgv+HLmznRikp9QsLsVuu6Qe8yQ9KCHYZEaVt7g==
X-Received: by 2002:a2e:be06:0:b0:261:be8b:64f3 with SMTP id z6-20020a2ebe06000000b00261be8b64f3mr460430ljq.193.1660897936812;
        Fri, 19 Aug 2022 01:32:16 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 02/16] arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:31:55 +0300
Message-Id: <20220819083209.50844-3-krzysztof.kozlowski@linaro.org>
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

