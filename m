Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF359977B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbiHSIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347253AbiHSIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173C2E9A8E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x19so5212799lfq.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E+17Qxxn21Uu6LvEIhuc2ojzyXZWgnM8bM1M23WOvqM=;
        b=eI9FvXYmtBy87bejmWl5mEBHmnpmC7hddgW4zvoPYswRxCfZPtIStdiZQoc3w471zE
         7a/UsxfxMsv6UjIU1XJW6E3DDiNY/2kzkUM5UK69YvYTb57v0d9CIt9Pn6wxNqoLmqQP
         N5smsEcImoMBmKkdOceOsr3JFPaYci94XqzaFKiBZBgrmpF8ptBpsQukaj5+3mCCrxtH
         ydz8mQ+wgp87aQuejZvQ2tkEAlxH0cAFM6DqubZ5VXh+hLi61NbW9ql4UJ3bH7EFT7yb
         MblCen9Op/zruiVde3V9PhMTcqVUqZSQdPNmDF+K89coHvlsl9AYE7tXHE/jDRik4hOD
         ICzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E+17Qxxn21Uu6LvEIhuc2ojzyXZWgnM8bM1M23WOvqM=;
        b=DJXduDiZrPwgg8CKn6ql+2K93OZAPV2Jc1lJ8/UTejm7w6lH5WsAiX3EIFuJ4/c56J
         0sT+ktCm3sR7xHcQADvXhXU8yk8nKJ1J43jBJYE60zUD6s3GIIDH3Ws+x+DiX6oXT20a
         DexEXd8KGOg1oY9dvZy0e3ulxifa9yJfLMbTXqojPDYY/5GNsJX6WJwbvFTrJTKTGZtd
         rl2q4w7E0VGlaE9TZ3HFv/B0y4luWdwXfU1zsw2JfnZ6xllruO5/OzcrxGtSQX4YYgE2
         WL8G3ib44XzHxk4iVEaxKObiVBPAZBaSaWVp5vfXMNcfPQ6VJmWWhniOAmIsg6CVCVdc
         VAjA==
X-Gm-Message-State: ACgBeo3EJdppRpGj2qHom0VuE1vHrTa0JWu/sgf9kGeo7fCFVIbHH3PW
        jXhk8EuNwzKNvf77Pm83jGsFbQ==
X-Google-Smtp-Source: AA6agR65Pux9Q6UuNKdMfHI9jiKB+6inzGUrjhufALKPQAuPflJALLwzwmR5m/YxJmT2symi+YIMeQ==
X-Received: by 2002:a05:6512:21a6:b0:48d:13c4:df1f with SMTP id c6-20020a05651221a600b0048d13c4df1fmr2151780lft.576.1660897947484;
        Fri, 19 Aug 2022 01:32:27 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 10/16] arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:32:03 +0300
Message-Id: <20220819083209.50844-11-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0e286715d1b..21ed14200986 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2590,7 +2590,12 @@ ipa: ipa@1e40000 {
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0 0x01f40000 0 0x40000>;
+			reg = <0 0x01f40000 0 0x20000>;
+		};
+
+		tcsr_regs_1: sycon@1f60000 {
+			compatible = "qcom,sdm845-tcsr", "syscon";
+			reg = <0 0x01f60000 0 0x20000>;
 		};
 
 		tlmm: pinctrl@3400000 {
@@ -3207,7 +3212,7 @@ mss_pil: remoteproc@4080000 {
 				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
 			reset-names = "mss_restart", "pdc_reset";
 
-			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
 			power-domains = <&rpmhpd SDM845_CX>,
 					<&rpmhpd SDM845_MX>,
-- 
2.34.1

