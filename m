Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1438599779
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347735AbiHSIdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347590AbiHSIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10568E991A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v4so3930359ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=txjXCRtOELuunkCVXNi0V+0kB2LPofpz702NPuFtQkk=;
        b=WRo0rSEUtXYkkgU2C5eUCi8no3l41nxekq4KYhtKWXLw17rKIRxMDevgKTOadNaswI
         T5IhnPrrfeK1kO8NO8FSkT3yKAlnLbGPc4jiAyA/jwCvs/o5V3kEub3lebz7qvSE5yO5
         av0KlJhL4k3Ot0DwqQB0fZGserk+d7JyKPGy3/TvwkPivyF2DzkU48PHf0RRmXt5fVaO
         qUyngmY5mosnEunSSgpKyjcnpBfr+KXuTDiCopqBClqAWQSR5vbQF57NDeRXwRokZiBd
         k5zShAn096Y713nnFW9rb9+VYA90JBlAT35gmsypAQARbothyuMm5WutD7DrOhWo0Zbe
         EIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=txjXCRtOELuunkCVXNi0V+0kB2LPofpz702NPuFtQkk=;
        b=RfftOhlGREwoHT52ahucrnqGtCG711NoZF/xuh8e05T1uaD79yOfOb27FF1Y4SxT44
         nrsoe0hmoVI0gOJq+KU5Hghw3f3V1D2HuSxKIJn7thrCLLmhA8CBqNM4x73IGvtRcoav
         AbdGXXXYaQ0KHEWbS9oD93HB3ld36XgzIZXwKi4Oxp3bC9CcQc5l+m8lxBY/QflSrIg6
         RJc64axrNxFN5MySoKybSLUyUY2YeAoFIDXfArKcKhFf8vfVnaumftkbrgGgrMHtodG9
         XNISQlMdj7g/6a1HoOIny5W8dJ1RnimAtYdQHlzfjoP74+IH2mCn/ezIlJelvR6TNHs8
         V1OA==
X-Gm-Message-State: ACgBeo1lxPgk6tmz+Pj4B438+BsQMGtA7VL2IPvLh76jW8vFEngJoioW
        30r6CDng5ZsGj+dN5KPS1ikleg==
X-Google-Smtp-Source: AA6agR60V4CvViYgSN+CSY/0Z+KZgBs1aH1KfkqRX4Lh7lZX4cZinLOIDaoJsobPydS9XPWJzZ6JBA==
X-Received: by 2002:a05:651c:50e:b0:25f:f52b:3c91 with SMTP id o14-20020a05651c050e00b0025ff52b3c91mr2042344ljp.391.1660897943626;
        Fri, 19 Aug 2022 01:32:23 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 07/16] arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:32:00 +0300
Message-Id: <20220819083209.50844-8-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 49f28cb531f6..5d2dd21da79c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1464,10 +1464,15 @@ ipa: ipa@1e40000 {
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0 0x01f40000 0 0x40000>;
+			reg = <0 0x01f40000 0 0x20000>;
 		};
 
-		tcsr_regs: syscon@1fc0000 {
+		tcsr_regs_1: sycon@1f60000 {
+			compatible = "qcom,sc7180-tcsr", "syscon";
+			reg = <0 0x01f60000 0 0x20000>;
+		};
+
+		tcsr_regs_2: syscon@1fc0000 {
 			compatible = "qcom,sc7180-tcsr", "syscon";
 			reg = <0 0x01fc0000 0 0x40000>;
 		};
@@ -1932,8 +1937,8 @@ remoteproc_mpss: remoteproc@4080000 {
 				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
 			reset-names = "mss_restart", "pdc_reset";
 
-			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
-			qcom,spare-regs = <&tcsr_regs 0xb3e4>;
+			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
+			qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
 
 			status = "disabled";
 
-- 
2.34.1

