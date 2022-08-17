Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9D596DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbiHQMFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiHQMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B295004E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u6so13350559ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=v+CAkv8Hlyo2PxpwLaCJcPFqOS7vWYe9QQHHKSYzECU=;
        b=BIe1yai8AxnqH1xCULHo/Dm0+9wX5oQHpkNKEW9N3FM0YIpnB/eekBBEHoyu/2fQHj
         D0NNjM2bh4MnJ13IH1XqBpBGk2GF+GzuwC8HqnzO+tLFDZvtLdUa2zS8712eV6VzhKQm
         c6SBILRw31/pIPY20qUe/F979IN7p+CDxXxmHScjgmVFn7x1TuJGkAF26VsyoOkMq5Qr
         +SOOwqtpGKa8LCHiBAQq5XON3nPIyYOIsg5b5Rf35m7k4EbZtNYHYSciV/XLTjKFZ6xP
         +2J1TpzZALOZoAKaHsm+Gykzbm6wSCq6kpXhpfJ1Qbgo3fu3NVoFajTCep27Mz6W7rEA
         5C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v+CAkv8Hlyo2PxpwLaCJcPFqOS7vWYe9QQHHKSYzECU=;
        b=rC1GLEE6uJXBTqJMrWylcxLhvrw/BwfUsFH2d6KuDdiUuNlh8M9SVli45Bd7HFqsMl
         rEWXDBUN6dirWqs91HQbwgCNIp3WjuXgY83D2Ph1Sh3fVVVO+Yt6GdHUjLvkKrnXk5RA
         ZW7o0CnBFsu06Euh8f3fpXeABRY5EwgckC2ubMuh5STg0+ZhwqSz1dJqT6ZGuHAxMCcm
         KJKgOD25pCZoYTKZVpl+uhDfBFMEPrFtm3Vuf+j1S2EM63h8JWwt/i26B5stsS841Q+b
         5y+6klBsb1SXVY32PcRydhjCfzLEJWRANCuEiXDuiCNENYP0oLxJSurZbUs8EmKGifM6
         +btg==
X-Gm-Message-State: ACgBeo1Spz3oh8gbXmB08PnsGOCtXhIIodTiB24joaseyOrZNXH13DKR
        ICeGicml7UPuXEVcYgZwwFrWhg==
X-Google-Smtp-Source: AA6agR4TQRBWxy15ymqHuWCuBX5sSHPtGTKsjhtaZQ1BFvzFN58HPIlUMcLKM7hU3iREL5h32T6BCQ==
X-Received: by 2002:a2e:9e56:0:b0:261:7544:d79d with SMTP id g22-20020a2e9e56000000b002617544d79dmr1640455ljk.296.1660737869972;
        Wed, 17 Aug 2022 05:04:29 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 11/14] arm64: dts: qcom: sdm845: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 15:04:00 +0300
Message-Id: <20220817120403.458000-13-krzysztof.kozlowski@linaro.org>
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

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/sdm845-shift-axolotl.dtb: hwlock: 'reg' is a required property
  qcom/sdm845-shift-axolotl.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 21ed14200986..bd0ec0664283 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -919,12 +919,6 @@ compute-cb@8 {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	smp2p-cdsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <94>, <432>;
@@ -2588,9 +2582,10 @@ ipa: ipa@1e40000 {
 			status = "disabled";
 		};
 
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_regs_1: sycon@1f60000 {
-- 
2.34.1

