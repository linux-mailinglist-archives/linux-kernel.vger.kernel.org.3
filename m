Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9D596E14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiHQMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiHQMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AE4E630
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s9so13342838ljs.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DL4opHqld4qCjVSblJBLt63Edv/Ob11xgTM5Drh1lj4=;
        b=U2Jpcx+6tKXhMdjtMZqfWrRNWoL3zSXnFX/6QxN/18h95toNTTH0X4ig3QhdDQyqWd
         TU1N5xdIDsBxDLNUElGF1XL0Tp+oUdOHqnqv+ltREiWU2qV6wQ25QqOE6CDDmrGAuRDP
         e3Yba/VEDsWHH6WydK5P1D0XZ0VE/KJK0Dw7F5FgjwFp88k7+xYZgH44HGzUJqDQ+2o6
         pEvwwifG4hcqO223C8431alSDRFQ9A2GT7024e0XUL9tFS+A7tzNONQIxufkGIsv/foL
         r9bDtpQXHUCddwgce7Uho+0jmP02j39CD4Kf8Yc1V/VZRWwXyQ4NgA5B3mm+3WudcK7a
         qi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DL4opHqld4qCjVSblJBLt63Edv/Ob11xgTM5Drh1lj4=;
        b=5WRReFglTFuh5eJJqSPN7mgL7GgSK3SYj1qxLdYNI9NvqlNCCcDqBpmDHF9CG/2Gl8
         vJ/9Y7kbJ2uOVJDRxTPEPW0b91P+10n4gkIa5JnERf1CPimSZWa74sbOU2wuVn5H/8i5
         r8jhYD4fGUw3BiYIL7eqEeJu6msuiTM86GeRPyZKlNlcoqS1KQNz3stwf6KNlcu+tH74
         mapOYljkkM1GX+xg7kGYapFwjLe6yT+ul9tLw9Osca5vM13naRl8P1GVmTZnXWde2Rjf
         Ls+x44sKW/LYO0jQQfq87M3a8Rz81j31VcBdLE4BKVBmwMkncMRVvUr+IQsAQLZexKJ9
         +y7A==
X-Gm-Message-State: ACgBeo26VneJ4qxkreT1Rcxbhm/mZ6UDtB370/Lmk194IU6wxxew0MRW
        uspJ8rgAnk1BvNgAeB0/CxXvAQ==
X-Google-Smtp-Source: AA6agR4EfDgBjPb1aBWDeDqMamM4ROl/UhQom14B0yGPr97jZN5jxsD8NtrDo1Hl9u/Rw4HQgueDmg==
X-Received: by 2002:a2e:597:0:b0:25e:4a64:1628 with SMTP id 145-20020a2e0597000000b0025e4a641628mr7626153ljf.378.1660737864392;
        Wed, 17 Aug 2022 05:04:24 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 07/14] arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 15:03:56 +0300
Message-Id: <20220817120403.458000-9-krzysztof.kozlowski@linaro.org>
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

