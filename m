Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4816599768
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbiHSIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbiHSIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDCE990C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so5248777lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=r9Tkhs8iRZKA/xD9KN/+OgaKLtO/SCM3ARj69+DISGs=;
        b=zh6eWeXmxOqbTaUiUKsju+FNFWmsNstbBDDBboZI42HImzRtnU3ztlpFZAiPMHnjFR
         V4BuQrft+UoJx4szA/dkwsZJvOnb8Y5ylF6vEz/b6ne7RislpT4LrKoYSWgeD5NbR2EE
         Hok2LVuOUF21WrwRyYhRU5IP48RehmquufONZKHTGD8SDdoa693E1o2n2f+rVg8v8EUW
         oS/AdrNR9sJt2t8/KgtKYHzKdf+tfTcWSf6OHqWi0JzyTq39mCJFsXAAaGqF6lRGcp8l
         kabBjmojFm7TgzXqbqwxGfr87R2SS2kHoyA0EdsqMYUbKQmK91ogvmFK5J3f85GfOu+P
         VEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=r9Tkhs8iRZKA/xD9KN/+OgaKLtO/SCM3ARj69+DISGs=;
        b=unl50uB7yrBzcc6bZ2PflqXdj/73xkjsJFQRrjAzL/rXUw01cQt1BriYg0L0Avtuxh
         N1wDabLJTybIvYcnvLTcuGJ3vlmPRZVbvRISlh/Y2vR5euWfw0ll0CfA0wPHMr/CEEzF
         UymoU7RYMYU+tLgp1IHhl9pJXrso1L802w4j3j00HJv+EhMqxMah5Al7XXheHvHPm2ul
         olqxz8eAWfa82UYhIJHwXATxWYAy4i2mMsALKDGKWCJ6Z3gM0RYinWvlV1bz0FwAWQz2
         8H2gBmr0PlvLrDS6Dq/FIkDhwyPA8Phlqi46gYoIztyp4e9eWMsDxkJo3DfsRrLXY8rE
         dr+w==
X-Gm-Message-State: ACgBeo1HCNtDvLmqJ26byk2FuG5/O73JDMx+Jt3MSKXnehwaaxPgvRhj
        XIofTP7tFSguHxhQfGvy/BzJsWfmVk8vNvRu
X-Google-Smtp-Source: AA6agR5FIc0QGMG/pMBu109cR90TvStFdFPoZIj7ftDcLQh/GukBI9Rw0g1pIyYWxjf/6HiU2bpYiA==
X-Received: by 2002:a05:6512:118a:b0:492:a32d:3678 with SMTP id g10-20020a056512118a00b00492a32d3678mr1963460lfr.259.1660897946189;
        Fri, 19 Aug 2022 01:32:26 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 09/16] arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:32:02 +0300
Message-Id: <20220819083209.50844-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
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

The TCSR halt regs are next to TCSR mutex (in one address block called
TCSR_MUTEX), so before converting the TCSR mutex into device with
address space, we need to split the halt regs to its own syscon device.
This also describes more accurately the devices and their IO address
space, and allows to remove incorrect syscon compatible from TCSR mutex:

  qcom/sc7280-herobrine-crd.dtb: hwlock@1f40000: compatible: ['qcom,tcsr-mutex', 'syscon'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
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

