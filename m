Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541659972A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbiHSIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347667AbiHSIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B1E9AB3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x10so3890435ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aF1kTOExhxJ5LhZnkigAMIE3Og/cjDqIZ0JV+mWnMgg=;
        b=b8DvidfLi+K7kGfFf1QKaFrYO7KrGRMn+DztPWASn5wxp41FkPsFAXyRdYxKfIX11u
         GWPaDRM6Ixd6HlnXMvoRoWVtci6X+Q3IYfN2DWV/JC9oS6rX2iSXMDTQryjBUEy7sdTT
         7ce5dhSca/eP1c1D7KUM1Nouy/Jy0O6Tpde6tKMmDMj3PBeWG3ZmeNMStQKKLPiEXj5E
         4xisLrl0TF+6DNAbedEleTix4fT9XfidVwuUpmmZV5z/VhQ5Qs34ERijU1/yPLEq7olh
         6/hK/K+DPjdamhDvVsURSPMxZ49IMPt73IkXrufDz17b1jidI8awrDP8RY0ttx19Mz0O
         lI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aF1kTOExhxJ5LhZnkigAMIE3Og/cjDqIZ0JV+mWnMgg=;
        b=I4LOvi1+EnobewLzqLBQrW6fVJMAEjeQRJSC6326CpJIA7wWdIal0K67dJOwO8c0j1
         0eYYYJqa8mdPdtPo+PqDPKrTUJFWUNFVK3F8/3GGckG3V2fiDDWtZYhMZ8L1r9Iz2dtm
         Lr/hiWeGsucgAaIrkchFS9HN6Fwyu1Hg9ZnrTScNgTcjITi749N8Z4ejEDwT8ziEYj2v
         D/pD7CSXGUvh0pchIjTrg8ZpOL1gsbv1hpMwdylddTG+jkKxtJZF/Ah+EWpJNeOFHA2w
         r5lzUvmM2sDTkhUqhYW1VU6la4uls7JUaCjA2KMIRmaKyS7o0awbQeSxEP+ZibM7IE9s
         lEFA==
X-Gm-Message-State: ACgBeo0SoroGYpKhYcXMa819YfJwsCcTaBIg59PYkr22vlYwRBQ/hwqs
        w7+qbNnwi0FMdvuVMTuvDB7mWw==
X-Google-Smtp-Source: AA6agR6XRfFnswT27eivG55n2X6GuJgt/JHyayGyQW+0bgLjG2m6ACmKTArmnrpY8QmOaX0Z/3vO8A==
X-Received: by 2002:a05:651c:514:b0:25e:7113:396b with SMTP id o20-20020a05651c051400b0025e7113396bmr1737625ljp.65.1660897954103;
        Fri, 19 Aug 2022 01:32:34 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 15/16] arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:32:08 +0300
Message-Id: <20220819083209.50844-16-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 7d509ecd44da..6df2e6828282 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2056,7 +2056,12 @@ ipa_virt: interconnect@1e00000 {
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0x0 0x01f40000 0x0 0x40000>;
+			reg = <0x0 0x01f40000 0x0 0x20000>;
+		};
+
+		tcsr_regs_1: sycon@1f60000 {
+			compatible = "qcom,sm8150-tcsr", "syscon";
+			reg = <0x0 0x01f60000 0x0 0x20000>;
 		};
 
 		remoteproc_slpi: remoteproc@2400000 {
-- 
2.34.1

